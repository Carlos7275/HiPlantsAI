<?php

namespace App\Repositories;

use App\Models\InfoPlantas;
use Illuminate\Support\Facades\Http;
use GuzzleHttp;

class InfoPlantasRepository  extends EloquentRepository
{
    public function __construct(InfoPlantas $infoPlantas)
    {
        parent::__construct($infoPlantas);
    }


    public function IdentificarPlantaConImagen($imagen)
    {
        $PROJECT = "all"; // try "weurope" or "canada"
        $API_URL = 'https://my-api.plantnet.org/v2/identify/' . $PROJECT . '?api-key=';
        $API_PRIVATE_KEY = env("PlantsNetToken");
        $API_SIMSEARCH_OPTION = '&include-related-images=true'; // optional: get most similar images
        $API_LANG = '&lang=es'; // default: en

        $client = new GuzzleHttp\Client();
        $apiRequest = $client->request(
            'POST',
            $API_URL . $API_PRIVATE_KEY . $API_SIMSEARCH_OPTION . $API_LANG,
            [
                'multipart' => [
                    [
                        'name'     => 'images',
                        'contents' => fopen($imagen, 'r')
                    ],
                ]
            ]
        );
        $response = json_decode($apiRequest->getBody());

        return $response;
    }


    public function ObtenerInformacionPlanta($nombre)
    {
        $response = Http::withHeaders([
            'Authorization' => env("TrefleToken")
        ])->get(env("TreffleURL") . "/v1/plants/search?q=$nombre&limit=1");

        return json_decode($response, true);
    }

    public function ObtenerInformacionEspecie($especie)
    {
        $response = Http::withHeaders([
            'Authorization' => env("TrefleToken")
        ])->get(env("TreffleURL") . "/v1/species/$especie");

        return json_decode($response, true);
    }
}
