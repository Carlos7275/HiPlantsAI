<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Response\Message;
use App\Repositories\CodigoPostalRepository;

class CodigoPostalController extends Controller
{

    private $_codigoPostalRepository;

    public function __construct(CodigoPostalRepository $codigoPostalRepository)
    {
        $this->_codigoPostalRepository = $codigoPostalRepository;
    }

    function ObtenerCP()
    {
        return response()->json(Message::success($this->_codigoPostalRepository->all()));
    }
    function ObtenerCPEspecifico($id_asenta, $cp)
    {
        return response()->json(Message::success($this->_codigoPostalRepository->BuscarColonia($id_asenta, $cp)));
    }

    function BuscarCP($cp)
    {
        return response()->json(Message::success($this->_codigoPostalRepository->find($cp)));
    }
}
