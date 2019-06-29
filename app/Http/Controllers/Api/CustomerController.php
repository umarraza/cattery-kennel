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
            'address'       =>   'required',   
            'phoneNumber'   =>   'required',
            'occupantName'  =>   'required',
            'dateOfBirth'   =>   'required',
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

                $isRegistered = $request->get('isRegistered'); // default NULL

                if ($isRegistered == 1) {

                    $password = $request->get('password');
                    $username = User::whereUsername($request->username)->first();

                    $user = User::create([
                        
                        'username'  =>  $request->get('username'),
                        'email'     =>  $request->get('email'),
                        'password'  =>  bcrypt($password),
                        'roleId'    =>  $request->get('roleId'),
                        'verified'  =>  User::STATUS_ACTIVE,
                        'language'  =>  "English",
    
                    ]);
                }

                $userId = $user->id; // default NULL

                $customer = Customer::create([

                    'bookerName'    =>  $request->get('bookerName'),
                    'email'         =>  $request->get('email'),
                    'address'       =>  $request->get('address'),
                    'phoneNumber'   =>  $request->get('phoneNumber'),
                    'occupantName'  =>  $request->get('occupantName'),  // should be a seprate table for occupants
                    'dateOfBirth'   =>  $request->get('dateOfBirth'),   
                    'requirements'  =>  $request->get('requirements'),
                    'userId'        =>  $userId,

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

            } catch (Exception $e) {

                DB::rollBack();
                throw $e;
            }
        }
        return $response;
    }

    public function customerBookings(Request $request) {
        
        $customerId = $request->get('customerId');

        $comments = Customer::find($customerId)->bookings;

        return $comments;

    }


}
