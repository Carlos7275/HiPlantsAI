<?php

namespace App\Repositories;

use App\Models\Recorridos;

class RecorridosRepository  extends EloquentRepository
{
    public function __construct(Recorridos $recorridos)
    {
        parent::__construct($recorridos);
    }

    public function ObtenerMisRecorridos()
    {
        $id = auth()->user()->id;
        return $this->model->where("id_usuario", $id)->get();
    }
}
