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

                $noOfCats = $request->get('noOfCats');
                $noOfDogs = $request->get('noOfDogs');
                $checkIn = $request->get('checkIn');
                $checkOut = $request->get('checkOut');
                $location = $request->get('location');
                $postcode = $request->get('postcode');

                if (isset($postcode)) {

                    $bookings = Booking::where('searchCheckIn','like','%' .$checkIn)
                    ->where('searchCheckOut','like','%' .$checkOut)
                    ->whereIsactive(1)
                        ->get();
                    $venueIds = $bookings->pluck('venueId');

                    $venues = Venue::whereIn('id', $venueIds)
                        ->whereIsavailable(1) //checl if venue available for bookings
                        ->wherePostcode($postcode)
                        ->orderBy('serviceRate', 'asc')
                        ->get();

                        $listVenues = [];

                    foreach ($venues as $venue) {

                        // check if venue has no of cats and dogs greater then customer's requirements
                        if ($venue->totalCats >= $noOfCats && $venue->totalDogs >= $noOfDogs) {
                            $listVenues[] = $venue;
                        }
                        
                        $venue = $venue->images;
                    }

                    $response['data']['code']       =  200;
                    $response['data']['message']    =  'Request Successfull';
                    $response['data']['result']     =  $listVenues;
                    $response['status']             =  true;

                } else {

                    $bookings = Booking::where('checkIn', 'like', '%' .$checkIn)
                    ->where('checkOut','like','%' .$checkOut)
                    ->whereIsactive(1)
                        ->get();

                    $venueIds = $bookings->pluck('venueId');

                    $venues = Venue::whereIn('id', $venueIds)
                        ->whereIsavailable(1)
                        ->where('address', 'like', '%' . $location . '%')
                        ->orderBy('serviceRate', 'asc')
                    ->get();

                $listVenues = [];

                foreach ($venues as $venue) {

                    $totalCats = $venue->totalCats;
                    $totalDogs = $venue->totalDogs;

                    if ($totalCats >= $noOfCats && $totalDogs >= $noOfDogs) {

                        $listVenues[] = $venue;
                        $venue = $venue->images;
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
