<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CustomerPets extends Model
{
    protected $table = 'customer_pets';

    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';

     protected $fillable = [

        'catName',
        'dogName',
        'dateOfBirth',
        'image',
        'customerId',


    ];


    public function getArrayResponse() {
        
        return [

            'id' => $this->id,
            'catName' => $this->catName,
            'dogName' => $this->dogName,
            'dateOfBirth' => $this->dateOfBirth,
            'image' => $this->image,
            'customerId' => $this->customerId,

        ];
    }
}
