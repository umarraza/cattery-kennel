<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bookings extends Model
{
    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';
	/**
	* The database table used by the model.
	*
	* @var string
	*/
    protected $table = 'bookings';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [

        'venueId',
        'customerId',
        'noOfCats',
        'noOfDogs',
        'checkIn',
        'checkOut',
        'isActive',
        'isRegistered',
        'userId'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class, 'id');
    }

    public function venue()
    {
        return $this->belongsTo(Venue::class, 'venueId');
    }

    public function getArrayResponse() {
        return [

            'id'  	        =>   $this->id,
            'venueId'       =>   $this->venueId,
            'customerId'    =>   $this->customerId,
            'noOfCats'      =>   $this->noOfCats,
            'noOfDogs'      =>   $this->noOfDogs,
            'checkIn'       =>   $this->checkIn,
            'checkOut'      =>   $this->checkOut,
            'isActive'      =>   $this->isActive,
            'isRegistered'  =>   $this->isRegistered,
            'userId'        =>   $this->userId,

        ];
    }
}
