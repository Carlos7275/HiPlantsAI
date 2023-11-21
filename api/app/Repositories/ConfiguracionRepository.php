<?php

namespace App\Repositories;

use App\Models\Configuracion;
use App\Repositories\EloquentRepository;

class ConfiguracionRepository extends EloquentRepository
{
    public function __construct(Configuracion $configuracion)
    {
        parent::__construct($configuracion);
    }

    public function ObtenerDistancias()
    {
        return $this->model->select("distanciamin", "distanciamax")->first();
    }
}
