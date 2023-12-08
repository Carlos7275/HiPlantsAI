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
            ->get();

        foreach ($result as $row) {
            $row->nombres_comunes = json_decode($row->nombres_comunes);
            $row->distribucion = json_decode($row->distribucion);
        }
        return $result;
    }
}
