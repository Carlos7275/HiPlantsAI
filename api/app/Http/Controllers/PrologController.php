<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\MapaRepository;
use App\Repositories\UserRepository;
use Illuminate\Support\Facades\Http;

class PrologController extends Controller
{
    var $prologURL;
    var UserRepository $_usuarioRepository;
    var MapaRepository $_mapaRepository;

    public function __construct(
        UserRepository $usuarioRepository,
        MapaRepository $mapaRepository
    ) {
        $this->middleware('auth:api', ['except' => []]);
        $this->prologURL = env("PrologURL");
        $this->_usuarioRepository = $usuarioRepository;
        $this->_mapaRepository = $mapaRepository;
    }

    public function ObtenerPlantasNoVisitadas()
    {
        $id = auth()->user()->id;

        $id = urlencode($id);
        $url = "{$this->prologURL}/plantasNoVisitadas?idusuario=$id";
        $response = json_decode(Http::get($url));
        return response()->json(Message::success($response->resultado));
    }

    public function ObtenerPlantasNoVisitadasCercanas($Lat, $Long)
    {
        $id = auth()->user()->id;
        $Lat = urlencode($Lat);
        $Long = urlencode($Long);
        $id = urlencode($id);
        $url = "{$this->prologURL}/plantasNoVisitadas/Cercanas?lat=$Lat&long=$Long&idusuario=$id";
        $response = json_decode(Http::get($url));
        return response()->json(Message::success($response->resultado));
    }

    public function ObtenerPlantaMasVisitadaTiempo()
    {
        $url = "{$this->prologURL}/plantaMasVisitadaTiempo";
        $response = json_decode(Http::get($url));

        return response()->json(Message::success($response->resultado));
    }


    public function ObtenerPlantaMenosVisitadaTiempo()
    {
        $url = "{$this->prologURL}/plantaMenosVisitadaTiempo";
        $response = json_decode(Http::get($url));

        return response()->json(Message::success($response->resultado));
    }
    public function ObtenerPlantaMasVisitada()
    {
        $url = "{$this->prologURL}/plantaMasVisitada";
        $response = json_decode(Http::get($url));
        $idplanta = $response->resultado;
        $planta = $this->_mapaRepository->find($idplanta);

        return response()->json(Message::success($planta));
    }

    public function ObtenerPlantasCercanas($Lat, $Long)
    {

        $url = "{$this->prologURL}/plantasCercanas?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));

        return response()->json(Message::success($response));
    }
}
