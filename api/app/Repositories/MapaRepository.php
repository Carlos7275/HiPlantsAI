<?php

namespace App\Repositories;

use App\Models\Mapa;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class MapaRepository  extends EloquentRepository
{
    public function __construct(Mapa $mapa)
    {
        parent::__construct($mapa);
    }

    public function ObtenerZona($lat, $lon)
    {
        $response = Http::get(env("GeoCodeURL") . "reverse?lat=$lat&lon=$lon");
        return json_decode($response)->display_name;
    }

    public function all()
    {
        return $this->model->with("InfoPlantas")->get();
    }

    public function ObtenerPlantasActivas()
    {
        return $this->model->with("InfoPlantas")->where("estatus", "=", 1)->get();
    }

    public function find($id)
    {
        return $this->model->with("InfoPlantas")->find($id);
    }

    public function CambiarEstatus($id)
    {
        $planta = $this->find($id);
        if (isset($planta)) {
            $estatus = ($planta->estatus == "1") ? "0" : "1";
            $this->update($id, ["estatus" => $estatus]);

            return $estatus;
        }
        return null;
    }

    public function ObtenerEstadisticas()
    {
        return DB::select(
            "select (select count(*) from info_plantas) as plantas_registradas, 
            (select count(*) from mapa where estatus=1) as plantas_activas,
            (select count(*) from mapa where estatus=0) as plantas_inactivas;"
        )[0];
    }
}
