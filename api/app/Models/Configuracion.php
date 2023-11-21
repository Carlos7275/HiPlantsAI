<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    use HasFactory;
    protected $table = "configuracion";

    protected $fillable = [
        'tokentreffle',
        'tokenplantsnet',
        'tokenipinfo',
        'distanciamin',
        'distanciamax',
    ];

    protected $hidden = [
        'id',
        'tokentreffle',
        'tokenplantsnet',
        'tokenipinfo',
        "created_at",
        "updated_at"
    ];
}
