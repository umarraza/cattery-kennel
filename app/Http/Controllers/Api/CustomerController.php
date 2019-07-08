<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiBookings as Booking;
use App\Models\Api\ApiCustomer as Customer;
use App\Models\Api\ApiVenue as Venue;
use App\Models\Api\ApiUser as User;
use App\Models\Api\ApiCustomerPets as CustomerPets;


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
                        'requirements'  =>  $request->get('requirements'),
                        'userId'        =>  $userId,
    
                    ]);
    

                    /*

                        CHECKING THE AVAILIBILITY OF CATTERY PLACE IN REQUIRED DATE.

                        To get occupied rooms for the period specified, i.e '2016-02-27'-'2016-02-24', you can use:

                        SELECT DISTINCT room_no
                        FROM reservation
                        WHERE check_in <= '2016-02-27' AND check_out >= '2016-02-24'
                        Output:

                        room_no
                        =======
                        13
                        14
                        
                    */

                    $booking = Booking::create([
    
                        'venueId'       =>  $request->get('venueId'),
                        'customerId'    =>  $customer->id,  // customer id will define the number of repeat bookers
                        'noOfCats'      =>  $request->get('noOfCats'),
                        'noOfDogs'      =>  $request->get('noOfDogs'),
                        'checkIn'       =>  $request->get('checkIn'),
                        'checkOut'      =>  $request->get('checkOut'),
                        'isActive'      =>  1, 
                        'isRegistered'  =>  $request->get('isRegistered'), 
    
                    ]);

                    $venue = Venue::whereId($request->venueId)->first();
                    $venueMail = $venue->email;
                    $venue->totalCats -= $request->noOfCats;
                    $venue->totalDogs -= $request->noOfDogs;

                    $venue->save();

                    if($venue->totalCats <= 0 && $venue->totalDogs <= 0) {

                        $venue = Venue::whereId($request->venueId)->update([
                            'isAvailable' => 0,
                        ]);

                    }
                    $customerMail = $request->get('email');
                    $customerMessage = "Hi! Customer";

                    \Mail::send('Mails.customer', ["message" => $customerMessage], function ($customerMessage) use ($customerMail)
                    {
                        $customerMessage->from('info@cattery&kennel.online', 'Catteries & Kennels');
                        $customerMessage->to($customerMail);
                        $customerMessage->subject("New Email From Your site");
                    });

                    $venueMessage = "Hi! Venue";

                    \Mail::send('Mails.venue', ["message" => $venueMessage], function ($venueMessage) use ($venueMail)
                    {
                        $venueMessage->from('info@cattery&kennel.online', 'Catteries & Kennels');
                        $venueMessage->to($venueMail);
                        $venueMessage->subject("New Email From Your site");
                    });

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
                        'requirements'  =>  $request->get('requirements'),

                    ]);
    
                    $booking = Booking::create([
    
                        'venueId'       =>  $request->get('venueId'),
                        'customerId'    =>  $customer->id,  
                        'noOfCats'      =>  $request->get('noOfCats'),
                        'noOfDogs'      =>  $request->get('noOfDogs'),
                        'checkIn'       =>  $request->get('checkIn'),
                        'checkOut'      =>  $request->get('checkOut'),
                        'isActive'      =>  1, 
                        'isRegistered'  =>  $request->get('isRegistered'), 
                    
                    ]);
    
                    $venue = Venue::whereId($request->venueId)->first();
                    $venueMail = $venue->email;
                    $venue->totalCats -= $request->noOfCats;
                    $venue->totalDogs -= $request->noOfDogs;

                    $venue->save();

                    if($venue->totalCats == 0 && $venue->totalDogs == 0) {

                        $venue = Venue::whereId($request->venueId)->update([
                            'isAvailable' => 0,
                        ]);
                    }

                    $customerMail = $request->get('email');
                    $customerMessage = "Hi! Customer";

                    \Mail::send('Mails.customer', ["message" => $customerMessage], function ($customerMessage) use ($customerMail)
                    {
                        $customerMessage->from('info@cattery&kennel.online', 'Catteries & Kennels');
                        $customerMessage->to($customerMail);
                        $customerMessage->subject("New Email From Your site");
                    });

                    $venueMessage = "Hi! Venue";

                    \Mail::send('Mails.venue', ["message" => $venueMessage], function ($venueMessage) use ($venueMail)
                    {
                        $venueMessage->from('info@cattery&kennel.online', 'Catteries & Kennels');
                        $venueMessage->to($venueMail);
                        $venueMessage->subject("New Email From Your site");
                    });

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
