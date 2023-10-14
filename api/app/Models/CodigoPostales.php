<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CodigoPostales extends Model
{
    use HasFactory;
    protected $table = "codigos_postales";

    public $timestamps = false;
   
    protected $fillable = [
        "d_codigo",
        "d_asenta",
        "d_tipo_asenta",
        "d_mnpio",
        "d_ciudad",
        "d_estado",
        "d_cp",
        "c_estado",
        "c_oficina",
        "c_cp",
        "c_tipo_asenta",
        "c_mnpio",
        "id_asenta_cpcons",
        "d_zona",
        "c_cve_ciudad",
    ];
    protected $hidden = [

        "d_cp",
        "c_estado",
        "c_oficina",
        "c_cp",
        "c_tipo_asenta",
        "c_mnpio",
        "d_zona",
        "c_cve_ciudad",
    ];
}
