<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;
use DB;

use App\Models\Api\ApiVenue as Venue;
use App\Models\Api\ApiBookings as Booking;

class VenueAdminController extends Controller
{
    public function listNewBooking(Request $request) {

        $user = JWTAuth::toUser($request->token);

        $response = [
                'data' => [
                    'code'      =>  400,
                    'errors'    =>  'Invalid Token, user not found!',
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

                $bookings = Booking::whereIsactive($request->isActive)->get();
                
                $response['data']['code']       =  200;
                $response['data']['message']    =  'Request Successfull';
                $response['data']['result']     =  $bookings;
                $response['status']             =  true;

            } catch (Exception $e) {

                throw $e;
            }
        }
        return $response;
    }
}
