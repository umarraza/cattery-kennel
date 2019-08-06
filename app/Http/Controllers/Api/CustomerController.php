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

                // signup a user if customer decided to register himself
                if ($request->get('isRegistered') == 1) {

                    $password = $request->get('password');
                    $userData = User::whereUsername($request->username)->first();  //check if username exist or not

                    if(isset($userData)) {

                        $response['data']['code']     =  401;
                        $response['status']           =  false;
                        $response['data']['message']  =  '';
                    }

                    $user = User::create([
                        
                        'username'  =>  $request->get('username'),
                        'fullName'  =>  $request->get('bookerName'),
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
    
                    $dateCheckIn = $request->get('checkIn');
                    $breakData1 = explode(' ', $dateCheckIn);
                    $checkIn = $breakData1[0];

                    $dateCheckOut = $request->get('checkOut');
                    $breakData2 = explode(' ', $dateCheckOut);
                    $checkOut = $breakData2[0];


                    /** 
                     *  Note:
                     *  
                     *  serachCheckIn & searchCheckOut fields are just for venue seraching purpose when a 
                     *  customer enter dates while registering a new booking. 
                     *  
                     *  Searching was not possible on complete timestamp date format i.e (2019-07-03 00:00:00) 
                     *  because this timestamp format includes hours, minutes & seconds as well. We need just 
                     *  date witout time to perform search for venues. This is the reason to create 2 additional
                     *  dates i.e 'searchCheckIn' & 'searchCheckOut' in a simple string in order to perform 
                     *  searches easily. I there is a consize way of searching other then this, you can 
                     *  implement that.
                     * 
                    */



                    $booking = Booking::create([
    
                        'venueId'       =>  $request->get('venueId'),
                        'customerId'    =>  $customer->id, 
                        'noOfCats'      =>  $request->get('noOfCats'),
                        'noOfDogs'      =>  $request->get('noOfDogs'),
                        'checkIn'       =>  $request->get('checkIn'),
                        'checkOut'      =>  $request->get('checkOut'),
                        "searchCheckIn" =>  $checkIn,
                        "searchCheckOut"=>  $checkOut,
                        'isActive'      =>  1, 
                        'isRegistered'  =>  $request->get('isRegistered'), 
    
                    ]);

                    $venue = Venue::whereId($request->venueId)->first();
                    $user = User::find($venue->userId);
                    $venueMail = $user->email;

                    // decrement of no of cats and dogs of a venue with new booking's cats and dogs value

                    $venue->totalCats -= $request->noOfCats;
                    $venue->totalDogs -= $request->noOfDogs;
                    $venue->save();

                    // disable venue status if there is no place for new bookings. 
                    // Also keep minimum value of venue cats and dogs to '0' in order to avoid negative integer for values
                    if($venue->totalCats <= 0 && $venue->totalDogs <= 0) {

                        $venue = Venue::whereId($request->venueId)->update([
                            'isAvailable' => 0,
                            'totalCats' => 0,
                            'totalDogs' => 0,
                        ]);
                    }
                    
                    // mail to customer for confirmation by platform
                    $customerMail = $request->get('email');
                    $customerMessage = "Hi! Customer";

                    \Mail::send('Mails.customer', ["message" => $customerMessage, "booking"=>$booking,"customer"=>$customer], function ($customerMessage) use ($customerMail)
                    {
                        $customerMessage->from('info@cattery&kennel.online', 'Catteries & Kennels');
                        $customerMessage->to($customerMail);
                        $customerMessage->subject("New Email From Your site");

                    });

                    $venue = Venue::whereId($request->venueId)->first();
                    $venueMessage = "Hi! Venue";
                    
                    // mail to a venue about notifying for a new booking
                    \Mail::send('Mails.venue', ["message" => $venueMessage,"booking"=>$booking,"customer"=>$customer,"venue"=>$venue], function ($venueMessage) use ($venueMail)
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
                    $user = User::find($venue->userId);
                    $venueMail = $user->email;

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

    public function customerBookings(Request $request)
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

        if(!empty($user) && $user->isCustomer())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            try {

                $customerBookings = Booking::join('customers AS customer', 'bookings.customerId', '=', 'customer.id')
                    ->select(
                        'customer.bookerName', 
                        'customer.email', 
                        'customer.phoneNumber', 
                        'bookings.noOfCats', 
                        'bookings.noOfDogs', 
                        'bookings.checkIn', 
                        'bookings.checkOut',
                        'bookings.isRegistered',
                        )
                    ->where('bookings.customerId', $request->customerId)
                    ->where('bookings.isActive', 1)

                    ->get();

                $response['data']['code']     =  200;
                $response['data']['message']  =  'Request Successfull';
                $response['data']['result']   =  $customerBookings;
                $response['status']           =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }

    public function customerBookingsHistory(Request $request)
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

        if(!empty($user) && $user->isCustomer())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            try {

                $pastCustomerBookings = Booking::join('customers AS customer', 'bookings.customerId', '=', 'customer.id')
                    ->select(
                        'customer.bookerName', 
                        'customer.email', 
                        'customer.phoneNumber', 
                        'bookings.noOfCats', 
                        'bookings.noOfDogs', 
                        'bookings.checkIn', 
                        'bookings.checkOut',
                        'bookings.isRegistered',
                        )
                    ->where('bookings.customerId', $request->customerId)
                    ->where('bookings.isActive', 0)

                    ->get();

                $response['data']['code']     =  200;
                $response['data']['message']  =  'Request Successfull';
                $response['data']['result']   =  $pastCustomerBookings;
                $response['status']           =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }

    public function updateCustomer1(Request $request)
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

        if(!empty($user) && $user->isCustomer())
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
                'id'   =>   'required',

            ];
            if ($validator->fails()) {
            
                $response['data']['message'] = 'Invalid input values.';
                $response['data']['errors'] = $validator->messages();
    
            }
            else {
                try {

                    $customers = Customer::whereId($request->id)->update([

                        "bookerName" => $request->get('bookerName'),
                        "address" => $request->get('address'),
                        "phoneNumber" => $request->get('phoneNumber'),

                    ]);
    
                    if ($customers) {
    
                        $response['data']['code']       =  200;
                        $response['data']['message']    =  'Customer Updated Successfully';
                        $response['data']['result']     =  $customers;
                        $response['status']             =  true;
                    }
    
                } catch (Exception $e) {
    
                    throw $e;
                }
            }
        }
        return $response;
    }
    public function updateCustomer(Request $request)
    {
        $user = JWTAuth::toUser($request->token);
        $response = [
                'data' => [
                    'code'      => 400,
                    'errors'    => '',
                    'message'   => 'Invalid Token! User Not Found.',
                ],
                'status' => false
            ];

        if(!empty($user))
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            $rules = [

                'bookerName' => 'required',
                'address' => 'required',
            	'phoneNumber' => 'required',
            	'id' => 'required',
                
            ];

            $validator = Validator::make($request->all(), $rules);

            if ($validator->fails()) {
                
                $response['data']['message'] = 'Invalid input values.';
                $response['data']['errors'] = $validator->messages();

            } else {

                DB::beginTransaction();
                try {
                 
                    $customer = Customer::find($request->id)->update([
                    
                        'bookerName' => $request->get('bookerName'),
                        'address' => $request->get('address'),
                        'phoneNumber' => $request->get('phoneNumber'),
    
                    ]);

                    if ($customer) {

                        DB::commit();
                        $response['data']['code']       =  200;
                        $response['data']['message']    =  'Customer updated SuccessfullY';
                        $response['status']             =  true;
    
                    }

                } catch (Exception $e) {

                    DB::rollBack();
                    throw $e;
                }
            }
        }
        return $response;
    }
}
