<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mapa extends Model
{
    use HasFactory;
    protected $table = "mapa";

    protected $fillable = [
        "id_planta",
        "zona",
        "latitud",
        "longitud",
        "url_imagen",
        "estatus",
    ];

    protected $hidden = [
        "updated_at"
    ];
}
