<?php
namespace App\Models;


class Paths{
        //Obtiene la ruta relativa de las imagenes guardadas en la  API
    public static function getRelativePath($path){
     
        $ruta= explode('/',$path);        
         return "../public/".array_filter($ruta)[1]."/".array_filter($ruta)[2]."/".array_filter($ruta)[3];
     }
}
