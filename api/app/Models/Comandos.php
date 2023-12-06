<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comandos extends Model
{
    use HasFactory;
    protected $table = "comandos";

    protected $fillable = [
        'comando',
        'descripcion',
    ];
   
    protected $hidden = [
        'created_at',
        'updated_at'
    ];
}
