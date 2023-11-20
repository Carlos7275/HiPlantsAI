<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\InfoPlantasRepository;

class InfoPlantasController extends Controller
{
    private InfoPlantasRepository $_infoPlantasRepository;

    public  function __construct(InfoPlantasRepository $infoPlantasRepository)
    {
        $this->_infoPlantasRepository = $infoPlantasRepository;
    }

    public function ObtenerPlantas()
    {
        return response()->json(Message::success($this->_infoPlantasRepository->ObtenerPlantasRegistradas()));
    }

    public function ObtenerPlanta($id)
    {
        return response()->json(Message::success($this->_infoPlantasRepository->ObtenerPlantasEspecifica($id)));
    }
}
