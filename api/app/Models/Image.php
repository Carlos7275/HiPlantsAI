<?php

namespace App\Models;

class Image
{

    const ruta = "../public/storage/images/";
    //Convierte de Base64 a una ruta
    static public function base64toUrl($base64_image_string)
    {
        list($data, $base64_image_string) = explode(';', $base64_image_string);
        list(, $extension) = explode('/', $data);
        $output_file_with_extension = uniqid() . '.' . $extension;
        list(, $imageData)      = explode(',', $base64_image_string);
        self::crearCarpetaImagenes();
        file_put_contents(self::ruta . $output_file_with_extension, base64_decode($imageData));

        return "/storage/images/" . $output_file_with_extension;
    }

    static function  crearCarpetaImagenes()
    {
        if (!file_exists(self::ruta))
            mkdir(self::ruta);
    }
    //Elimina una Imagen dada la ruta
    static public function DeleteImage($path)
    {
        unlink($path);
    }
}
