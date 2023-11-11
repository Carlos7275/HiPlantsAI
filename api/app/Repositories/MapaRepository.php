<?php

namespace App\Repositories;

use App\Models\Mapa;
use Illuminate\Support\Facades\Http;

class MapaRepository  extends EloquentRepository
{
    public function __construct(Mapa $mapa)
    {
        parent::__construct($mapa);
    }

    public function RegistrarMapa()
    {
    }

   
   
    public function ObtenerZona($lat, $lon)
    {
        $response = Http::get(env("GeoCodeURL") . "reverse?lat=$lat&lon=$lon");
        return json_decode($response)->display_name;
    }
}
