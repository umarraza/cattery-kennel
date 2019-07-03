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

    public function createVenue(Request $request)
    {

        $response = [
            'data' => [
                'code' => 400,
                'message' => 'Something went wrong. Please try again later!',
            ],

            'status' => false
        
        ];

        $rules = [

            'buisnessName'         =>   'required',
            'email'                =>   'required',
            'address'              =>   'required',   
            'phoneNumber'          =>   'required',
            'buisnessDescription'  =>   'required',
            'facilities'           =>   'required',
            'serviceaRate'         =>   'required',
            'discountAvailable'    =>   'required',
            'totalCats'            =>   'required',
            'totalDogs'            =>   'required',
            'type'                 =>   'required',
            'userId'               =>   'required',
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

                $venue = Venue::create([

                        'buisnessName' => $request->get('buisnessName'),
                        'email' => $request->get('email'),
                        'address' => $request->get('address'),
                        'postcode' => $request->get('postcode'),
                        'phoneNumber' => $request->get('phoneNumber'),
                        'buisnessDescription' => $request->get('buisnessDescription'),
                        'facilities' => $request->get('facilities'),
                        'serviceRate' => $request->get('serviceRate'),
                        'discountAvailable' => $request->get('discountAvailable'),
                        'totalCats' => $request->get('totalCats'),
                        'totalDogs' => $request->get('totalDogs'),
                        'type' => $request->get('type'),
                        'isPaid' => $request->get('isPaid'),
                        'userId' => $request->get('userId'),

                    ]);

                    // $checkPayment = $supllier->isPaid;

                    // if(isset($checkPayment)) {

                    //     $buisnessName = $request->get('buisnessName');
                    //     $message = "A random message";
                    //     $tousername = $request->get('email');

                    //     \Mail::send('mail',["buisnessName"=>$buisnessName], function ($message) use ($tousername) {
                    
                    //         $message->from('info@fantasycricleague.online');
                    //         $message->to($tousername)->subject('Confirm your buisness');
                
                    //    });
                    // }

                    DB::commit();

                    $response['data']['code']       = 200;
                    $response['status']             = true;
                    $response['data']['result']     = $venue;
                    $response['data']['message']    = 'Venue created Successfully';

            } catch (Exception $e) {

                DB::rollBack();
                throw $e;
            }
        }
        return $response;
    }

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
