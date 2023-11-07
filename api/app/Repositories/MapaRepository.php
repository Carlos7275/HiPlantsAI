<?php
namespace App\Repositories;

use App\Models\Mapa;

class MapaRepository  extends EloquentRepository
{
    public function __construct(Mapa $mapa)
    {
        parent::__construct($mapa);
    }
}
?>