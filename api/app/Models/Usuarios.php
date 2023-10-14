<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;


class Usuarios extends Authenticatable implements JWTSubject
{
    use  HasFactory, Notifiable;
    
    protected $table = "usuarios";
    //Datos a Capturar
    protected $fillable = [
        'email',
        'password',
        "url_imagen",
        "id_rol",
        "id_genero",
        'estatus'
    ];
    //Datos a ocultar en los queries
    protected $hidden = [
        'password',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }
}
