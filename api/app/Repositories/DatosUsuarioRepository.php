<?php

namespace App\Repositories;

use App\Models\DatosUsuarios;
use App\Repositories\EloquentRepository;

class DatosUsuarioRepository extends EloquentRepository
{
    public function __construct(DatosUsuarios $datauser)
    {
        parent::__construct($datauser);
    }
}
