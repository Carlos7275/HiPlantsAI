<?php

namespace App\Utils;

class Utils
{
    static function ConvertirErroresALinea($json)
    {
        $errorMessages = [];

        foreach ($json as $field => $errors) {
            foreach ($errors as $error) {
                $errorMessages[] = $error;
            }
        }

        $errorString = implode(' ', $errorMessages);

        return $errorString;
    }
}
