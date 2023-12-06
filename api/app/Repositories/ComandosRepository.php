<?php

namespace App\Repositories;

use App\Models\Comandos;
use App\Repositories\EloquentRepository;

class ComandosRepository extends EloquentRepository
{
    public function __construct(Comandos $comandos)
    {
        parent::__construct($comandos);
    }

}
