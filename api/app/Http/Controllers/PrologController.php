<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Support\Facades\Http;

class PrologController extends Controller
{
    var $prologURL;

    public function __construct()
    {
        $this->prologURL = env("PrologURL");
    }

    public function Sumar($num1, $num2)
    {

        $num1 = urlencode($num1);
        $num2 = urlencode($num2);

        // Construir la URL con los parámetros
        $url = "{$this->prologURL}/sumar?x={$num1}&y={$num2}";
        $response = json_decode(Http::get($url));
        return response()->json($response);
    }
}
