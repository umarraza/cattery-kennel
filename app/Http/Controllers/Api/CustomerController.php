<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiBookings as Booking;
use App\Models\Api\ApiCustomer as Customer;
use App\Models\Api\ApiUser as User;

use DB;

class CustomerController extends Controller
{
    public function newCustomer(Request $request)
    {
        $response = [
            'data' => [
                'code' => 400,
                'message' => 'Something went wrong. Please try again later!',
            ],

            'status' => false
        ];

        $rules = [
 
            'bookerName'    =>   'required',
            // 'email'         =>   'required|unique:customers',
            'address'       =>   'required',   
            'phoneNumber'   =>   'required',
            'pets'          =>   'required',
            'requirements'  =>   'required',

        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            
            $response['data']['message'] = 'Invalid input values.';
            $response['data']['errors'] = $validator->messages();

        }
        else
        {
            DB::beginTransaction();

            try {

                if ($isRegistered = $request->get('isRegistered') == 1) {

                    $password = $request->get('password');
                    $userData = User::whereUsername($request->username)->first();  //check if username exist or not

                    if(isset($userData)) {

                        $response['data']['code']     =  401;
                        $response['status']           =  false;
                        $response['data']['message']  =  '';
                    }

                    $user = User::create([
                        
                        'username'  =>  $request->get('username'),
                        'email'     =>  $request->get('email'),
                        'password'  =>  bcrypt($password),
                        'roleId'    =>  $request->get('roleId'),
                        'verified'  =>  User::STATUS_ACTIVE,
                        'language'  =>  "English",
    
                    ]);

                    $userId = $user->id; 

                    $customer = Customer::create([

                        'bookerName'    =>  $request->get('bookerName'),
                        'email'         =>  $request->get('email'),
                        'address'       =>  $request->get('address'),
                        'phoneNumber'   =>  $request->get('phoneNumber'),
                        'pets'          =>  $request->get('pets'),  
                        'requirements'  =>  $request->get('requirements'),
                        'userId'        =>  $userId,
    
                    ]);
    
                    $booking = Booking::create([
    
                        'venueId'       =>  $request->get('venueId'),
                        'customerId'    =>  $customer->id,  // customer id will define the number of repeat bookers
                        'isActive'      =>  1, 
                        'isRegistered'  =>  $request->get('isRegistered'), 
    
                    ]);

                    DB::commit();
    
                    $response['data']['code']     =  200;
                    $response['status']           =  true;
                    $response['data']['result']   =  $customer;
                    $response['data']['message']  =  'New booking created successfully';

                } else {

                    $customer = Customer::create([

                        'bookerName'    =>  $request->get('bookerName'),
                        'email'         =>  $request->get('email'),
                        'address'       =>  $request->get('address'),
                        'phoneNumber'   =>  $request->get('phoneNumber'),
                        'pets'          =>  $request->get('pets'), 
                        'requirements'  =>  $request->get('requirements'),

                    ]);
    
                    $booking = Booking::create([
    
                        'venueId'       =>  $request->get('venueId'),
                        'customerId'    =>  $customer->id,  
                        'isActive'      =>  1, 
                        'isRegistered'  =>  $request->get('isRegistered'), 
                    
                    ]);
    
                        DB::commit();
    
                        $response['data']['code']     =  200;
                        $response['status']           =  true;
                        $response['data']['result']   =  $customer;
                        $response['data']['message']  =  'New booking created successfully';
                }

            } catch (Exception $e) {

                DB::rollBack();
                throw $e;
            }
        }
        return $response;
    }

    public function listCustomers(Request $request)
    {
        $user = JWTAuth::toUser($request->token);
        $response = [
                'data' => [
                    'code'      =>  400,
                    'errors'    =>  '',
                    'message'   =>  'Invalid Token! User Not Found.',
                ],
                'status' => false
            ];

        if(!empty($user) && $user->isSuperAdmin())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            try {

                $customers = Customer::all();

                if (isset($customers)) {

                    $response['data']['code']       =  200;
                    $response['data']['message']    =  'Request Successfull';
                    $response['data']['result']     =  $customers;
                    $response['status']             =  true;
    
                }

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }

    public function customerBookings(Request $request) {
        
        $customerId = $request->get('customerId');

        $bookings = Customer::find($customerId)->bookings;

        return $bookings;

    }
}
