<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;

use App\Models\Api\ApiCatteryImages as CatteryImages;
use App\Models\Api\ApiUser as User;

use DB;

class CatteryImagesController extends Controller
{

    // Create Cattery & Kennel Images

    public function createImages(Request $request)
    {

        $user = JWTAuth::toUser($request->token);
        $response = [
            'data' => [
                'code'      => 400,
                'errors'    => '',
                'message'   => 'Invalid Token! User Not Found.',
            ],
            'status' => false
        ];
        if(!empty($user) && $user->isSupplier())
        {
            $response = [
                'data' => [
                    'code' => 400,
                    'message' => 'Something went wrong. Please try again later!',
                ],
                'status' => false
            ];
            $rules = [

                'base64ImageData'   =>  'required',
                'supplierId'        =>  'required',
            ];

            $validator = Validator::make($request->all(), $rules);
            
            if ($validator->fails()) 
            {
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

                        $image = CatteryImages::create([

                            'imageName'  => $file_name,
                            'supplierId'=> $request->get('supplierId'),
    
                        ]);

                        DB::commit();

                        $response['data']['message'] = 'Image created Successfully';
                        $response['data']['code'] = 200;
                        $response['data']['result'] = $image;
                        $response['status'] = true;

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
        }    
        return $response;
    }
}
