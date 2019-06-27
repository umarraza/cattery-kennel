<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Supplier extends Model
{
    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';
	/**
	* The database table used by the model.
	*
	* @var string
	*/
    protected $table = 'suplliers';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'buisnessName',
        'address',
        'phoneNumber',
        'buisnessDescription',
        'facilities',
        'serviceaRate',
        'discountAvailable',
        'type',
        'userId',
    ];

    public function getArrayResponse() {
        return [
        		'id'  			        =>  $this->id,
             	'buisnessName'          =>  $this->buisnessName,
                'address'               =>  $this->address,
                'phoneNumber' 		    =>  $this->phoneNumber,
             	'buisnessDescription'   =>  $this->buisnessDescription,
             	'facilities' 		    =>  $this->facilities,
             	'serviceaRate' 		    =>  $this->serviceaRate,
             	'discountAvailable' 	=>  $this->discountAvailable,
                'type' 		            =>  $this->type,
             	'userId' 	    	    =>  $this->userId,
                 
                 
        ];
    }
}
