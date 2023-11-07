<?php
namespace App\Repositories;

use App\Models\InfoPlantas;

class InfoPlantasRepository  extends EloquentRepository
{
    public function __construct(InfoPlantas $infoPlantas)
    {
        parent::__construct($infoPlantas);
    }
}
?>