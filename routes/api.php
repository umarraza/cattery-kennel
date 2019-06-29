<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('/login', 'Api\AuthController@login');
Route::get('/logout', 'Api\AuthController@logout');
Route::post('/signup', 'Api\AuthController@signUp');
Route::post('/forgot-password', 'Api\AuthController@forgotPass');
Route::post('/reset-password', 'Api\AuthController@changePassword');

Route::post('/create-venue', 'Api\VanuesController@createVenue');

Route::post('/create-cattery-image', 'Api\CatteryImagesController@createImages');

Route::post('/new-customer', 'Api\CustomerController@newCustomer');
Route::post('/new-booking', 'Api\BookingsController@newBooking');


Route::post('/list-customer-bookings', 'Api\CustomerController@customerBookings');



