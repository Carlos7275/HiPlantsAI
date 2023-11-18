<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InfoPlantas extends Model
{
    use HasFactory;
    protected $table = "info_plantas";

    protected $fillable = [
        "id",
        "nombre_planta",
        "nombre_cientifico",
        "toxicidad",
        "año",
        "familia",
        "nombres_comunes",
        "distribucion",
        "colores",
        "humedad_atmosferica",
        "cantidad_luz",
        "meses_crecimiento",
        "genero",
        "estatus"
    ];

    protected $casts = [
        'colores' => 'json',
        'nombres_comunes' => 'json',
        'distribucion' => 'json',
        'meses_crecimiento' => 'json'
    ];
    protected $hidden = [
        "updated_at"
    ];
}
