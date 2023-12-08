<?php

namespace App\Http\Controllers;

use App\Models\InfoPlantas;
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

    public function ObtenerPlantasNoVisitadas($text = false)
    {

        $id = auth()->user()->id;

        $id = urlencode($id);
        $url = "{$this->prologURL}/plantasNoVisitadas?idusuario=$id";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response->resultado));
        else {
            $mensaje = "¡No se encontraron plantas no visitadas!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas no visitadas, ' : 'Planta no visitada,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantasNoVisitadasCercanas($text = false, $Lat, $Long)
    {
        $id = auth()->user()->id;
        $Lat = urlencode($Lat);
        $Long = urlencode($Long);
        $id = urlencode($id);
        $url = "{$this->prologURL}/plantasNoVisitadas/Cercanas?lat=$Lat&long=$Long&idusuario=$id";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response->resultado));
        else {
            $mensaje = "¡No se encontraron plantas no visitadas cercanas!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas no visitadas cercanas, ' : 'Planta no visitada cercana,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantaMasVisitadaTiempo($text = false)
    {
        $url = "{$this->prologURL}/plantaMasVisitadaTiempo";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response->resultado));
        else {
            $mensaje = "¡No se encontraron plantas mas visitadas por tiempo!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 4));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontró') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas mas visitadas por tiempo, ' : 'Planta mas visitada por tiempo,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }


    public function ObtenerPlantaMenosVisitadaTiempo($text = false)
    {
        $url = "{$this->prologURL}/plantaMenosVisitadaTiempo";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response->resultado));
        else {
            $mensaje = "¡No se encontraron plantas menos visitadas!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 4));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontró') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas menos visitadas, ' : 'Planta menos visitada,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantaMasVisitada($text = false)
    {
        $url = "{$this->prologURL}/plantaMasVisitada";
        $response = json_decode(Http::get($url));
        $idplanta = $response->resultado;
        $planta = $this->_mapaRepository->find($idplanta);
        if (boolval($text) == 0)
            return response()->json(Message::success($planta));
        else {
            $nombrePlanta = InfoPlantas::find($planta->id_planta)->nombre_planta;
            $mensaje = "La planta mas visitada en general es $nombrePlanta se encuentra en $planta->zona";
            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantasCercanas($text = false, $Lat, $Long)
    {

        $url = "{$this->prologURL}/plantasCercanas?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response));
        else {
            $mensaje = "¡No se encontraron plantas cercanas!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas cercanas, ' : 'Planta cercana,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerAreasCercanas($text = false, $Lat, $Long)
    {

        $url = "{$this->prologURL}/plantasCercanas?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response));
        else {
            $mensaje = "¡No se encontraron zonas cercanas!";

            $nombres = $response->resultado[0][3];

            $mensaje =   'El area cercana de plantas es '  . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantasCercanasToxicas($text = false, $Lat, $Long)
    {
        $url = "{$this->prologURL}/plantasCercanasToxicas?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response));
        else {
            $mensaje = "¡No se encontraron plantas toxicas cercanas a ti!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas cercanas toxicas, ' : 'Planta cercana toxica,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantasCercanasNoToxicas($text = false, $Lat, $Long)
    {
        $url = "{$this->prologURL}/plantasCercanasNoToxicas?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response));
        else {
            $mensaje = "¡No se encontraron plantas no toxicas cercanas a ti!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas cercanas no toxicas, ' : 'Planta cercana no toxica,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerAreaMasVisitada($text = false)
    {
        $url = "{$this->prologURL}/plantaMasVisitada";
        $response = json_decode(Http::get($url));
        $idplanta = $response->resultado;
        $planta = $this->_mapaRepository->find($idplanta);
        if (boolval($text) == 0)
            return response()->json(Message::success($planta));
        else {
            $mensaje = "El área más visitada es $planta->zona";
            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerAreaMenosVisitadaPorTiempo($text = false)
    {
        $url = "{$this->prologURL}/plantaMenosVisitadaTiempo";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response->resultado));
        else {
            $mensaje = "¡No se encontro el area menos visitada por tiempo!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 5));

            if ($numeroPlantas > 0)
                $mensaje =  ($numeroPlantas > 1 ? 'Las areas menos visitadas por tiempo son ' : 'El area menos visitada por tiempo es ')  . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantasCercanasComestibles($text = false, $Lat, $Long)
    {
        $url = "{$this->prologURL}/plantasCercanasComestibles?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response));
        else {
            $mensaje = "¡No se encontraron plantas comestibles cercanas a ti!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas cercanas comestibles, ' : 'Planta cercana comestible,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }

    public function ObtenerPlantasCercanasVegetables($text = false, $Lat, $Long)
    {
        $url = "{$this->prologURL}/plantasVegetablesCercanas?lat=$Lat&long=$Long";
        $response = json_decode(Http::get($url));
        if (boolval($text) == 0)
            return response()->json(Message::success($response));
        else {
            $mensaje = "¡No se encontraron plantas vegetables cercanas a ti!";

            $numeroPlantas = count($response->resultado);
            $nombres = implode(', ', array_column($response->resultado, 2));

            if ($numeroPlantas > 0)
                $mensaje = "Se " . ($numeroPlantas > 1 ? 'encontraron' : 'encontro') . " " . $numeroPlantas . " " . ($numeroPlantas > 1 ? 'Plantas cercanas vegetables, ' : 'Planta cercana vegetable,') . $nombres;

            return response()->json(Message::success($mensaje));
        }
    }




}
