<?php
namespace App\Repositories;

use App\Models\Recorridos;

class RecorridosRepository  extends EloquentRepository
{
    public function __construct(Recorridos $recorridos)
    {
        parent::__construct($recorridos);
    }
}
