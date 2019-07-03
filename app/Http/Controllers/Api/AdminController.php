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


class AdminController extends Controller
{
    public function repeatBookers(Request $request)
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

                $collection = Booking::all();
                $length = count($collection);
                $ids_array = [];

                for ($i = 0; $i < $length; $i++) {
                    $ids_array[] = $collection[$i]->customerId;
                }

                $result= array_count_values($ids_array);
                $new_array = [];
                foreach ($result as $key => $value) {
                    if ($value >= 2) {
                        $new_array[] = $key;
                    }
                }

                $customers = Customer::whereIn('id', $new_array)->get();

                $response['data']['code']       =  200;
                $response['data']['message']    =  'Request Successfull';
                $response['data']['result']     =  $customers;
                $response['status']             =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }

    public function peakDatesBooked(Request $request)
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

                $collection = Booking::all();
                $dates = $collection->pluck('checkOut', 'checkIn');

                $array  = [];

                foreach($dates as $checkIn => $checkOut) {

                    $date_from = $checkIn;
                    $date_to = $checkOut;
                    $date_from = strtotime($date_from);  
                    $date_to = strtotime($date_to);

                    // Loop from the start date to end date and output all dates inbetween  

                    for ($i=$date_from; $i<=$date_to; $i+=86400) {  
                        $array[] = date("Y-m-d", $i);
                    }                    
                }

                $results = array_count_values($array);
                $new_array2[] = 0;
                $new_array3 = [];
                foreach ($results as $key => $value) {

                    if ($value >= 3 && $value >= max($new_array2)) {

                        $new_array2[] = $value;
                        $new_array3[] = $key." => ". $value ." Times";
                    }
                }

                $reversed_array = array_reverse($new_array3);

                // return $reversed_array;

                $dates_data = [];
                $times_data = [];

                foreach ($reversed_array as $value) {

                    $data =  explode(' => ', $value);
                    $date_key = $data[0];
                    $val2 = $data[1];
                    $trimTimes = explode(' ', $val2);
                    $time_value = $trimTimes[0];
                    // return $time_value;

                    $dates_data[] = $date_key;
                    $times_data[] = (int)$time_value;

                    // create new table in db and store these fucking dates in that table and retrieve them latter.

                }

                return array_merge($dates_data, $times_data);

                return $times_data;
                // number of repeat wise show dates

                $response['data']['code']       =  200;
                $response['data']['message']    =  'Request Successfull';
                $response['data']['result']     =  $reversed_array;
                $response['status']             =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }

    public function noOfcustomerPets(Request $request)
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

                $customersIds = Customer::all()->pluck('id');

                $bookings = Booking::whereIn('customerId', $customersIds)->get();

                return $bookings;

                return $bookings;



                $response['data']['code']       =  200;
                $response['data']['message']    =  'Request Successfull';
                $response['data']['result']     =  $reversed_array;
                $response['status']             =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }




}