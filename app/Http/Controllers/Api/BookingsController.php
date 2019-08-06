<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiCustomer as Customer;
use App\Models\Api\ApiBookings as Booking;
use App\Models\Api\ApiVenue as Venue;

use DB;
use Carbon\Carbon;
use Mail;

class BookingsController extends Controller
{
    public function updateBookings(Request $request)
    {
        $response = [
            'data' => [
                'code' => 400,
                'message' => 'Something went wrong. Please try again later!',
            ],
            'status' => false
        ];
        
        DB::beginTransaction();

        try {

            $lastDayOfBookings = Booking::whereDate('checkOut', Carbon::today())->whereIsactive(1)->get();
            $customerIds = $lastDayOfBookings->pluck('customerId'); 

            $emails = json_decode(Customer::whereIn('id', $customerIds)->pluck('email'));

            $message = "Hi! Today is the last day of your booking.";
            
            \Mail::send('Mails.bookingEnd', ["message" => $message], function ($message) use ($request, $emails)
            {
                $message->from('info@cattery&kennel.online', 'Catteries & Kennels');
                $message->to($emails);
                $message->subject("New Email From Your site");
 
            });

            // bookings that had been completed yesterday
            $completedBookings = Booking::whereIsactive(1)->whereCheckout(date('Y-m-d', strtotime('-1 day', strtotime(Carbon::today()))))->get();

            /*  
                update no of cats and no of dogs of a venue by the values of completed booking's cats and dogs when a booking ends. 
                Also de-activate the booking.
            */
            
            foreach($completedBookings as $booking) {

                $booking->venue->totalCats += $booking->noOfCats;
                $booking->venue->totalDogs += $booking->noOfDogs;
                $booking->venue->save();

                // de-activate the booking
                $updateBooking = Booking::whereId($booking->id)->update([
                    "isActive" => 0,
                ]);
            }

            DB::commit();

            $response['data']['code'] = 200;
            $response['data']['result'] = $completedBookings;
            $response['data']['message'] = 'Booking updated successfully';
            $response['status'] = true;

            } catch (Exception $e) {

            DB::rollBack();

            throw $e;
        }
        return $response;
    }

    // registered customer making a new booking
    public function registeredCustomerBooking(Request $request)
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
 
                'venueId'      =>  'required',
                'customerId'   =>  'required',
                'noOfCats'     =>  'required',
                'noOfDogs'     =>  'required',
                'checkIn'      =>  'required',
                'checkOut'     =>  'required',
                'isActive'     =>  'required',
                'isRegistered' =>  'required'
            ];
    
            $validator = Validator::make($request->all(), $rules);
    
            if ($validator->fails()) {
                
                $response['data']['message'] = 'Invalid input values.';
                $response['data']['errors'] = $validator->messages();
    
            }
            else
            {

                try {

                    DB::beginTransaction();

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

                    $dateCheckIn = $request->get('checkIn');
                    $breakData1 = explode(' ', $dateCheckIn);
                    $checkIn = $breakData1[0];

                    $dateCheckOut = $request->get('checkOut');
                    $breakData2 = explode(' ', $dateCheckOut);
                    $checkOut = $breakData2[0];

                    $booking = Booking::create([

                        "venueId" => $request->get('venueId'),
                        "customerId" => $request->get('customerId'),
                        "noOfCats" => $request->get('noOfCats'),
                        "noOfDogs" => $request->get('noOfDogs'),
                        "checkIn" => $request->get('checkIn'),
                        "checkOut" => $request->get('checkOut'),
                        "searchCheckIn" => $checkIn,
                        "searchCheckOut" => $checkOut,
                        "isActive" => $request->get('isActive'),
                        "isRegistered" => $request->get('isRegistered')
    
                    ]);

                    $venue = Venue::whereId($request->venueId)->first();
                    
                    // decrement venue cats and dogs by values of booking's cats and dogs values
                    $venue->totalCats -= $request->noOfCats;
                    $venue->totalDogs -= $request->noOfDogs;

                    $venue->save();

                    // disable venue status if there is no place for new bookings. 
                    // Also keep minimum value of venue cats and dogs to '0' in order to avoid negative integer for values
                    if($venue->totalCats <= 0 && $venue->totalDogs <= 0) {

                        $venue = Venue::whereId($request->venueId)->update([
                            'isAvailable' => 0,
                            'totalCats' => 0,
                            'totalDogs' => 0
                        ]);

                    }
                    DB::commit();

                    $response['data']['code']     =  200;
                    $response['data']['message']  =  'Booking created successfully';
                    $response['data']['result']   =  $booking;
                    $response['status']           =  true;

                } catch (Exception $e) {

                    DB::rollBack();
                    throw $e;
                }
                
            }
        }
        return $response;
    }

    // list all new bookings of a venue registered present day
    public function newVenueBookings(Request $request)
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

        if(!empty($user) && $user->isVenue())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            try {

                $newBookings = Booking::join('customers AS customer', 'bookings.customerId', '=', 'customer.id')
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
                    ->where('bookings.venueId', $request->venueId)
                    ->where('bookings.checkIn', Carbon::today()->toDateString()) // bookings that registered present day(today)
                    ->where('bookings.isActive', 1)

                    ->get();

                $response['data']['code']     =  200;
                $response['data']['message']  =  'Request Successfull';
                $response['data']['result']   =  $newBookings;
                $response['status']           =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }


    // list all active bookings of a venue
    public function activeBookings(Request $request)
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

        if(!empty($user) && $user->isVenue())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            try {
                
                $activeBookings = Booking::join('customers AS customer', 'bookings.customerId', '=', 'customer.id')
                    ->select(
                        'customer.bookerName', 
                        'customer.email', 
                        'customer.phoneNumber', 
                        'bookings.noOfCats', 
                        'bookings.noOfDogs', 
                        'bookings.checkIn', 
                        'bookings.checkOut',
                        'bookings.isActive',
                        'bookings.isRegistered',
                        )
                    ->where('bookings.venueId', $request->venueId)
                    ->where('bookings.isActive', 1)
                    ->get();

                $response['data']['code']     =  200;
                $response['data']['message']  =  'Request Successfull';
                $response['data']['result']   =  $activeBookings;
                $response['status']           =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }

    // list all bookings of a venue that has been completed or canceled
    public function oldBookings(Request $request)
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

        if(!empty($user) && $user->isVenue())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
               'status' => false
            ];
            
            try {
                
                $oldBookings = Booking::join('customers AS customer', 'bookings.customerId', '=', 'customer.id')
                    ->select(
                        'customer.bookerName', 
                        'customer.email', 
                        'customer.phoneNumber', 
                        'bookings.noOfCats', 
                        'bookings.noOfDogs', 
                        'bookings.checkIn', 
                        'bookings.checkOut',
                        'bookings.isActive',
                        'bookings.isRegistered',
                        )
                    ->where('bookings.venueId', $request->venueId)
                    ->where('bookings.isActive', 0)
                    ->get();

                $response['data']['code']     =  200;
                $response['data']['message']  =  'Request Successfull';
                $response['data']['result']   =  $oldBookings;
                $response['status']           =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }
}
