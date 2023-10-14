<?php

namespace App\Models\Response;
//Clase Prefija para Mensajes
class Message
{
    static function Validation()
    {
        return ['message' => "¡Atencion!", "data" => "¡No deje los campos vacios!"];
    }
    static function success($data)
    {
        return ["message" => "¡Operacion Exitosa!", 'data' => $data];
    }

    static function Forbidden()
    {
        return ["message" => "¡Atencion!", 'data' => "¡Acceso No Autorizado!"];
    }

    static function Observation($observation)
    {
        return ["message" =>  $observation];
    }
    static function Error($error)
    {
        return ["message" => "¡Hubo un Error!", 'data' => $error];
    }
    static function notFound()
    {
        return ["message" => "¡No se encontro el registro!"];
    }
}
