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

        return $this->model
            ->where("id_usuario", $id)
            ->whereBetween(DB::raw('DATE(created_at)'), [$fechainicial, $fechafinal])
            ->get();
    }
}
