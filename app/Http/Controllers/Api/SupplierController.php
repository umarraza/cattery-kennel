<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

use JWTAuthException;
use JWTAuth;
use DB;

use App\Models\Api\ApiSupplier as Supllier;

class SupplierController extends Controller
{
    
    public function createSupllier(Request $request)
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
            'buisnessDescription'  =>   'required',
            'facilities'           =>   'required',
            'serviceaRate'         =>   'required',
            'discountAvailable'    =>   'required',
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

                $supllier = Supllier::create([

                        'buisnessName' => $request->get('buisnessName'),
                        'address' => $request->get('address'),
                        'phoneNumber' => $request->get('phoneNumber'),
                        'buisnessDescription' => $request->get('buisnessDescription'),
                        'facilities' => $request->get('facilities'),
                        'serviceaRate' => $request->get('serviceaRate'),
                        'discountAvailable' => $request->get('discountAvailable'),
                        'type' => $request->get('type'),
                        'userId' => $request->get('userId'),
                    ]);

                    DB::commit();

                    $response['data']['code']       = 200;
                    $response['status']             = true;
                    $response['data']['result']     = $supllier;
                    $response['data']['message']    = 'Supplier created Successfully';

            } catch (Exception $e) {

                DB::rollBack();
                throw $e;
            }
        }
        return $response;
    }

}
