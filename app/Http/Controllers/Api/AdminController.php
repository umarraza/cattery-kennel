<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiPeakDate as PeakDate;
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
            
            DB::beginTransaction();

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

                        $new_array3[] = $key;
                        $date_key = $key;
                        $occurence = $value;
                        $new_array2[] = $value;

                        $date = PeakDate::create([
                            "date" => $date_key,
                            "occurence" => $occurence
                        ]);
                    }
                }

                $peakDates = PeakDate::select('date', 'occurence')->get();
                $array_data = json_decode($peakDates);
                $reversed_array = array_reverse($array_data);
                $count = count($reversed_array);

                $sameDates = [];

                // return $peakDates;

                for ($i = 0; $i < $count; $i++) {

                    $sameDates[] = PeakDate::whereOccurence($peakDates[$i]->occurence)
                    ->select('date', 'occurence')->get();

                }

                DB::commit();

                $response['data']['code']       =  200;
                $response['data']['message']    =  'Request Successfull';
                $response['data']['result']     =  $reversed_array;
                $response['status']             =  true;

            } catch (Exception $e) {

                DB::rollBack();
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

                $customers = Customer::with('bookings')->get();

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




}