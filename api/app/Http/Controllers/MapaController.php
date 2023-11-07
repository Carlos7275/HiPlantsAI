<?php

namespace App\Http\Controllers;

use App\Repositories\MapaRepository;
use Illuminate\Http\Request;

class MapaController extends Controller
{
    private MapaRepository $_mapaRepository;

    public function __construct(MapaRepository $mapaRepository)
    {
        $this->middleware('auth:api', ['except' => ["ObtenerPlantas,ObtenerPlantaEspecifica"]]);
        $this->_mapaRepository = $mapaRepository;
    }

    public function RegistrarPlanta()
    {
    }

    public function ObtenerPlantas()
    {
    }

    public function ObtenerPlantaEspecifica($id)
    {
    }

    public function DarBajaPlanta($id)
    {
    }
}
