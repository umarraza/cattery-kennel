<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiBookings as Booking;

use DB;

class BookingsController extends Controller
{
    public function newBooking(Request $request)
    {

        $customer = Booking::find(3)->customer;

        return $customer;

        $response = [
            'data' => [
                'code' => 400,
                'message' => 'Something went wrong. Please try again later!',
            ],

            'status' => false
        
        ];

        $rules = [

            'venueId'      => 'required',
            'customerId'   => 'required',
            'isActive'     => 'required',
            'isRegistered' => 'required',
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

                $booking = Booking::create([

                    'venueId'       =>  $request->get('venueId'),
                    'customerId'    =>  $request->get('customerId'),
                    'isActive'      =>  $request->get('isActive'),
                    'isRegistered'  =>  $request->get('isRegistered'),

                    ]);

                    DB::commit();

                    $response['data']['code']     =  200;
                    $response['status']           =  true;
                    $response['data']['result']   =  $booking;
                    $response['data']['message']  =  'New booking created successfully';

            } catch (Exception $e) {

                DB::rollBack();
                throw $e;
            }
        }
        return $response;
    }

}
