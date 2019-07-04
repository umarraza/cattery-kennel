<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiCatteryImages as CatteryImages;
use App\Models\Api\ApiCustomerPets as CustomerPets;

use App\Models\Api\ApiUser as User;

use DB;

class PetsController extends Controller
{
    public function newPet(Request $request)
    {
        $response = [
            'data' => [
                'code' => 400,
                'message' => 'Something went wrong. Please try again later!',
            ],
            'status' => false
        ];
            
        $rules = [
 
            'dateOfBirth' => 'required',
            'base64ImageData' => 'required',
            'customerId'  => 'required',

        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            
            $response['data']['message'] = 'Invalid input values.';
            $response['data']['errors'] = $validator->messages();

        }
        else
        {
            $file_data   =  $request->get('base64ImageData');

            @list($type, $file_data) = explode(';', $file_data);
            @list(, $file_data) = explode(',', $file_data);
            @list(, $type) = explode('/', $type);

            $file_name = 'image_'.time().'.'.$type; 

            if($file_data!="")
            { 
                
                \Storage::disk('public')->put($file_name,base64_decode($file_data));

                DB::beginTransaction();
                try {

                    $pets = CustomerPets::create([

                        "catName" => $request->get('catName'),
                        "dogName" => $request->get('dogName'),
                        "dateOfBirth" => $request->get('dateOfBirth'),
                        "image" => $file_name,
                        "customerId" => $request->get('customerId'),

                    ]);

                    DB::commit();

                    $response['data']['code']     =  200;
                    $response['data']['message']  =  'Request Successfull';
                    $response['data']['result']   =  $pets;
                    $response['status']           =  true;

                } catch (Exception $e) {

                    DB::rollBack();
                    throw $e;
                }
            }
            else
            {

                $response['data']['message'] = 'File Required';
                $response['data']['code'] = 400;
                $response['status'] = false;
            }
        }
    return $response;
    }
}
