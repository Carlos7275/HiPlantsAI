<?php

namespace App\Repositories;

use App\Models\CodigoPostales;
use App\Repositories\EloquentRepository;

class CodigoPostalRepository extends EloquentRepository
{
    public function __construct(CodigoPostales $cp)
    {
        parent::__construct($cp);
    }

    public function all(){
       return $this->model::select("d_codigo")->groupBy("d_codigo")->get();
    }

    public function BuscarColonia($id_asenta,$cp){
       return $this->model::where("id_asenta_cp_cpcons", $id_asenta)->where("d_codigo", $cp)->firstOrFail();
    }
    
    public function find($id){
        return $this->model::select()->where('d_codigo', $id)->get();
    }

}
