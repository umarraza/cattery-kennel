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
Route::post('/venue-details', 'Api\VenueAdminController@venueDetails');
Route::post('/update-venue', 'Api\VenueAdminController@updateVenue');

// Images Routes
Route::post('/create-cattery-image', 'Api\CatteryImagesController@createImages');
Route::post('/venue-images', 'Api\CatteryImagesController@venueImages');
Route::post('/delete-venue-image', 'Api\CatteryImagesController@deleteVenueImage');


// Custmer Routes
Route::post('/list-customer-bookings', 'Api\CustomerController@customerBookings');
Route::post('/update-customer', 'Api\CustomerController@updateCustomer');

Route::get('/list-customers', 'Api\CustomerController@listCustomers');
Route::post('/new-customer', 'Api\CustomerController@newCustomer');
Route::post('/new-pet', 'Api\PetsController@newPet');
Route::post('/past-customer-bookings', 'Api\CustomerController@customerBookingsHistory');


// Booking Routes
Route::post('/new-bookings', 'Api\BookingsController@newVenueBookings');
Route::get('/update-bookings-status', 'Api\BookingsController@updateBookings');
Route::post('/customer-new-booking', 'Api\BookingsController@registeredCustomerBooking');
Route::post('/active-bookings', 'Api\BookingsController@activeBookings');
Route::post('/old-bookings', 'Api\BookingsController@oldBookings');
Route::post('/old-bookings', 'Api\BookingsController@oldBookings');



// Admin Routes
Route::get('/list-repeat-bookers', 'Api\AdminController@repeatBookers');
Route::get('/peak-dates-booked', 'Api\AdminController@peakDatesBooked');
Route::get('/customer-pets', 'Api\AdminController@noOfcustomerPets');
Route::get('/list-all-venues', 'Api\AdminController@listVenues');

// Search Routes
Route::post('/search-venues', 'Api\SearchController@serachVenues');








