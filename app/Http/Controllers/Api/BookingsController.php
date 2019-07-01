<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiBookings as Booking;

use DB;
use Carbon\Carbon;


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
        
        try {

            $bookings = Booking::whereCheckout(Carbon::today())->get();

            // update booking status

            return $bookings;

            $response['data']['code']       =  200;
            $response['data']['message']    =  'Request Successfull';
            $response['data']['result']     =  $customers;
            $response['status']             =  true;

            } catch (Exception $e) {

            throw $e;
        }
        return $response;
    }

}
