<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CatteryImages extends Model
{
    const CREATED_AT = 'createdAt';
    const UPDATED_AT = 'updatedAt';
	/**
	* The database table used by the model.
	*
	* @var string
	*/
    protected $table = 'cattery_images';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'imageName',
        'isProfile',
        'venueId'
    ];

    public function getArrayResponse() {
        return [

            'id'  	     =>  $this->id,
            'imageName'  =>  $this->imageName,
            'isProfile'  => $this->isProfile,
            'venueId'    =>  $this->venueId,

        ];
    }

    public function venue() {
        return $this->belongsTo(Venue::class, 'id');
    }
}
