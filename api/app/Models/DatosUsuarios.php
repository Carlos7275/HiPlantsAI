<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DatosUsuarios extends Model
{
    use HasFactory;
    protected $table = "datos_usuarios";

    protected $fillable = [
        'id',
        'nombres',
        'apellido_paterno',
        'apellido_materno',
        'domicilio',
        "referencia",
        "id_asenta_cpcons",
        "cp",
        'fecha_nacimiento',
        'telefono',
    ];
}
