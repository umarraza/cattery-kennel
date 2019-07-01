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
use App\Models\Api\ApiVenue as Venue;


use DB;


class SearchController extends Controller
{
    public function serachVenues(Request $request)
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
            
            try {

                $clientCats = $request->get('clientCats');
                $clientDogs = $request->get('clientDogs');
                $checkIn = $request->get('checkIn');
                $checkOut = $request->get('checkOut');
                $location = $request->get('location');
                $postcode = $request->get('postcode');

                // $checkBookings = Booking::whereBetween('checkIn', [$checkIn,$checkOut])->whereIsactive(1)->get();
                // $checkBookings = Booking::has('customer')->get();

                // get venues that are available for booking
                // rating could be add in future
                // ->orWhere('postcode', $postcode)


                if (isset($postcode)) {

                    $venues = Venue::whereIsavailable(1)
                    
                    ->where('postcode', $postcode)
                    ->orderBy('serviceRate', 'asc')
                    ->get();

                    $ids = $venues->pluck('id');
                    
                    $bookings = Booking::whereIn('venueId', $ids)
                        ->whereCheckin($checkIn)
                        ->whereCheckout($checkOut)
                       // ->whereNotBetween('checkIn', [$checkIn,$checkOut])
                        ->whereIsactive(1)
                    ->get();

                    $listVenues = [];

                    foreach ($venues as $venue) {

                        $totalCats = $venue->totalCats;
                        $totalDogs = $venue->totalDogs;

                        if ($totalCats > $clientCats && $totalDogs > $clientDogs) {

                            $listVenues[] = $venue;
                        }
                    }

                    $response['data']['code']       =  200;
                    $response['data']['message']    =  'Request Successfull';
                    $response['data']['result']     =  $venues;
                    $response['status']             =  true;

                } else {

                    $venues = Venue::whereIsavailable(1)
                    
                    ->where('address', 'like', '%' . $location . '%')
                    ->orderBy('serviceRate', 'asc')
                    ->get();

                $ids = $venues->pluck('id');
                
                $bookings = Booking::whereIn('venueId', $ids)
                    ->whereCheckin($checkIn)
                    ->whereCheckout($checkOut)
                    // ->whereNotBetween('checkIn', [$checkIn,$checkOut])
                    ->whereIsactive(1)
                ->get();

                $listVenues = [];

                foreach ($venues as $venue) {

                    $totalCats = $venue->totalCats;
                    $totalDogs = $venue->totalDogs;

                    if ($totalCats > $clientCats && $totalDogs > $clientDogs) {

                        $listVenues[] = $venue;
                    }
                }

                    $response['data']['code']       =  200;
                    $response['data']['message']    =  'Request Successfull';
                    $response['data']['result']     =  $venues;
                    $response['status']             =  true;
                }
    
            } catch (Exception $e) {

                throw $e;
            }
        return $response;
    }
}
