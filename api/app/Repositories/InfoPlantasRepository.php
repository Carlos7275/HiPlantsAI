<?php

namespace App\Repositories;

use App\Models\Configuracion;
use App\Models\InfoPlantas;
use Illuminate\Support\Facades\Http;
use GuzzleHttp;

class InfoPlantasRepository  extends EloquentRepository
{
    public function __construct(InfoPlantas $infoPlantas)
    {
        parent::__construct($infoPlantas);
    }

    public function ObtenerPlantasRegistradas()
    {
        return $this->model->all();
    }

    public function ObtenerPlantasEspecifica($id)
    {
        return $this->model->find($id);
    }
    public function IdentificarPlantaConImagen($imagen)
    {
        $token = Configuracion::find(1);

        $PROJECT = "all";
        $API_URL = 'https://my-api.plantnet.org/v2/identify/' . $PROJECT . '?api-key=';
        $API_PRIVATE_KEY = $token->tokenplantsnet;
        $API_SIMSEARCH_OPTION = '&include-related-images=true';
        $API_LANG = '&lang=es';

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
        $token = Configuracion::find(1);

        $sanitizeNombre = urlencode($nombre);
        $response = Http::withHeaders([
            'Authorization' => $token->tokentreffle
        ])->get(env("TreffleURL") . "/v1/plants/search?q=$sanitizeNombre&limit=1");

        return json_decode($response, true);
    }

    public function ObtenerInformacionEspecie($especie)
    {
        $token = Configuracion::find(1);

        $sanitizeEspecie = urlencode($especie);

        $response = Http::withHeaders([
            'Authorization' => $token->tokentreffle
        ])->get(env("TreffleURL") . "/v1/species/$sanitizeEspecie");

        return json_decode($response, true);
    }
}