<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recorridos extends Model
{
    use HasFactory;
    protected $table = "recorridos";

    protected $fillable = [
        "id",
        "id_mapa",
        "id_usuario",
        "tiempo",
    ];

    protected $hidden = [
        "updated_at"
    ];
}
