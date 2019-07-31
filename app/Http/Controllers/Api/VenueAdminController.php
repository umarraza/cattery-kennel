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
use App\Models\Api\ApiUser as User;
use App\Models\Api\ApiCatteryImages as CatteryImages;

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
            'address'              =>   'required',   
            'phoneNumber'          =>   'required',
            'facilities'           =>   'required',
            'serviceRate'          =>   'required',
            'discountAvailable'    =>   'required',
            'totalCats'            =>   'required',
            'totalDogs'            =>   'required',
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

                        'buisnessName'         =>  $request->get('buisnessName'),
                        'address'              =>  $request->get('address'),
                        'postcode'             =>  $request->get('postcode'),
                        'phoneNumber'          =>  $request->get('phoneNumber'),
                        'buisnessDescription'  =>  $request->get('buisnessDescription'),
                        'discountDescription'  =>  $request->get('discountDescription'),
                        'facilities'           =>  $request->get('facilities'),
                        'serviceRate'          =>  $request->get('serviceRate'),
                        'discountAvailable'    =>  $request->get('discountAvailable'),
                        'totalCats'            =>  $request->get('totalCats'),
                        'totalDogs'            =>  $request->get('totalDogs'),
                        // 'type'                 =>  $request->get('type'),
                        'isPaid'               =>  $request->get('isPaid'),
                        'userId'               =>  $request->get('userId'),

                    ]);

                    $user = User::whereId($request->get('userId'))->first();

                    if($venue->isPaid == 1) {
                        
                        $buisnessName = $request->get('buisnessName');
                        $message = "A random message";
                        $tousername = $user->email;
                        
                        \Mail::send('Mails.mail',["buisnessName"=>$buisnessName], function ($message) use ($tousername) {
                            $message->from('info@fantasycricleague.online');
                            $message->to($tousername)->subject('Confirm your buisness');
                       });
                    }



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

    public function venueDetails(Request $request) {
        
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
                'status' => false
            ];
            
            try {
                
                $occupiedCats = Booking::whereVenueid($request->venueId)->where('isActive', 1)->sum('noOfCats');
                $occupiedDogs = Booking::whereVenueid($request->venueId)->where('isActive', 1)->sum('noOfDogs');

                $venue = Venue::with('images')->whereId($request->venueId)->first();

                $venue['occupiedCats'] = $occupiedCats;
                $venue['occupiedDogs'] = $occupiedDogs;

                $response['data']['code']     =  200;
                $response['data']['message']  =  'Request Successfull';
                $response['data']['result']   =  $venue;
                $response['status']           =  true;

            } catch (Exception $e) {

                throw $e;
            }
        return $response;
    }
}
