<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PeakDate extends Model
{
    protected $table = 'peak_dates';

    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';


     protected $fillable = [

        'date',
        'occurence'
    ];


    public function getArrayResponse() {
        
        return [

            'id' => $this->id,
            'date' => $this->date,
            'occurence' => $this->occurence

        ];
    }
}
