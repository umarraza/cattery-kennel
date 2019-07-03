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
            'code'      =>  400,
            'errors'    =>  '',
            'message'   =>  'Invalid Token! User Not Found.',
        ],
                'status' => false
        ];

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

            Mail::send('Mails.bookingEnd', ["message" => $message], function ($message) use ($request, $emails)
            {
                $message->from('info@fantasycricleague.online', 'Catteries & Kennels');
                $message->to($emails);
                $message->subject("New Email From Your site");
            
            });

            $completedBookings = Booking::whereIsactive(1)->whereCheckout(date('Y-m-d', strtotime('-1 day', strtotime(Carbon::today()))))->get();
            
            foreach($completedBookings as $booking) {

                $booking->isActive == 0;
                $booking->save();
            }

            DB::commit();

            $response['data']['code']       =  200;
            $response['data']['message']    =  'Request Successfull';
            $response['data']['result']     =  $completedBookings;
            $response['status']             =  true;

            } catch (Exception $e) {

            DB::rollBack();

            throw $e;
        }
        return $response;
    }

    public function listVenueBookings(Request $request)
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
                    ->where('bookings.venueId', $request->id)
                    ->where('bookings.checkIn', Carbon::today())->get();

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
}
