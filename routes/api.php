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

// Auth Routes
Route::post('/login', 'Api\AuthController@login');
Route::get('/logout', 'Api\AuthController@logout');
Route::post('/signup', 'Api\AuthController@signUp');
Route::post('/forgot-password', 'Api\AuthController@forgotPass');
Route::post('/reset-password', 'Api\AuthController@changePassword');

// Venue Routes
Route::post('/create-venue', 'Api\VenueAdminController@createVenue');
Route::post('/list-new-bookings', 'Api\VenueAdminController@listNewBooking');

// Images Routes
Route::post('/create-cattery-image', 'Api\CatteryImagesController@createImages');

// Custmer Routes
Route::post('/list-customer-bookings', 'Api\CustomerController@customerBookings');
Route::get('/list-customers', 'Api\CustomerController@listCustomers');
Route::post('/new-customer', 'Api\CustomerController@newCustomer');

// Booking Routes
Route::post('/new-booking', 'Api\BookingsController@newBooking');
Route::get('/update-bookings-status', 'Api\BookingsController@updateBookings');
Route::post('/list-venue-bookings', 'Api\BookingsController@listVenueBookings');

// Admin Routes
Route::get('/list-repeat-bookers', 'Api\AdminController@repeatBookers');
Route::get('/peak-dates-booked', 'Api\AdminController@peakDatesBooked');
Route::get('/customer-pets', 'Api\AdminController@noOfcustomerPets');

// Search Routes
Route::post('/search-venues', 'Api\SearchController@noOfcustomerPets');








