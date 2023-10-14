<?php

namespace App\Repositories;

use App\Models\Generos;
use App\Repositories\EloquentRepository;

class GenerosRepository extends EloquentRepository
{
    public function __construct(Generos $generos)
    {
        parent::__construct($generos);
    }
}
