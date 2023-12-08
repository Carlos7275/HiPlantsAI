<?php

namespace App\Repositories;

use App\Models\Recorridos;
use Illuminate\Support\Facades\DB;

class RecorridosRepository  extends EloquentRepository
{
    public function __construct(Recorridos $recorridos)
    {
        parent::__construct($recorridos);
    }

    public function ObtenerMisRecorridos($fechainicial, $fechafinal)
    {
        $id = auth()->user()->id;

        $result = $this->model
            ->join("mapa as m", "m.id", "=", "recorridos.id_mapa")
            ->join("info_plantas as p", "p.id", "=", "m.id_planta")
            ->where("recorridos.id_usuario", $id)
            ->whereBetween(DB::raw('DATE(recorridos.created_at)'), [$fechainicial, $fechafinal])
            ->groupBy('m.id', 'p.id', 'p.nombre_planta', 'm.zona', 'p.nombre_cientifico', 'p.año', 'p.familia', 'p.toxicidad', 'm.latitud', 'm.longitud', 'm.url_imagen') // Agrupa por la combinación de id_mapa y id_planta
            ->selectRaw('m.id, p.id as id_planta ,p.nombre_planta,p.nombre_cientifico,p.familia,p.año,m.zona,p.toxicidad,m.latitud,m.longitud, SUM(recorridos.tiempo) as tiempo,m.url_imagen')
            ->where("m.estatus","=",1)
            ->get();
        return $result;
    }
}
