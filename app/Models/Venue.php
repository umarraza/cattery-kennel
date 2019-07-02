<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Venue extends Model
{
    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';
	/**
	* The database table used by the model.
	*
	* @var string
	*/
    protected $table = 'venues';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'buisnessName',
        'email',
        'address',
        'postcode',
        'phoneNumber',
        'buisnessDescription',
        'facilities',
        'serviceRate',
        'discountAvailable',
        'totalCats',
        'totalDogs',
        'type',
        'isPaid',
        'isAvailable',
        'userId',
    ];


    public function User()
    {
        return $this->belongsTo(User::class,'id','userId');
    }

    public function bookings()
    {
        return $this->hasMany(Bookings::class, 'venueId');
    }


    public function getArrayResponse() {
        return [

            'id'  			        =>  $this->id,
            'buisnessName'          =>  $this->buisnessName,
            'email'                 =>  $this->email,
            'address'               =>  $this->address,
            'postcode'              =>  $this->postcode,
            'phoneNumber' 		    =>  $this->phoneNumber,
            'buisnessDescription'   =>  $this->buisnessDescription,
            'facilities' 		    =>  $this->facilities,
            'serviceRate' 		    =>  $this->serviceRate,
            'discountAvailable' 	=>  $this->discountAvailable,
            'totalCats' 	        =>  $this->totalCats,
            'totalDogs' 	        =>  $this->totalDogs,
            'type' 		            =>  $this->type,
            'isPaid' 		        =>  $this->isPaid,
            'isAvailable' 		    =>  $this->isAvailable,
            'userId' 	    	    =>  $this->userId,
                
        ];
    }
}
