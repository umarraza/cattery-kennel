<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $table = 'customers';

    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';

     protected $fillable = [

        'bookerName',
        'email',
        'address',
        'phoneNumber',
        'pets',
        'requirements',
        'userId'
    ];

    public function bookings()
    {
        return $this->hasMany(Bookings::class, 'customerId');
    }


    public function getArrayResponse() {
        
        return [

            'id'            =>  $this->id,
            'bookerName'    =>  $this->bookerName,
            'email'         =>  $this->email,
            'address'       =>  $this->address,
            'phoneNumber'   =>  $this->phoneNumber,
            'pets'          =>  $this->pets,
            'requirements'  =>  $this->requirements,
            'userId'        =>  $this->userId,


        ];
    }
}
