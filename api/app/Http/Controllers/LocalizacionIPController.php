<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\ConfiguracionRepository;
use Illuminate\Support\Facades\Http;

class LocalizacionIPController extends Controller
{
    private ConfiguracionRepository $_configuracionRepository;

    public  function __construct(ConfiguracionRepository $configuracionRepository)
    {
        $this->_configuracionRepository = $configuracionRepository;
    }
    public function ObtenerCoordenadas()
    {
        $token = $this->_configuracionRepository->find(1);
        if (isset($token->tokenipinfo)) {

            return Http::get(env("IPURL") . $token->tokenipinfo);;
        }
        return response()->json(Message::Observation("¡Ingrese el Token de IPInfo al Sistema!"), 400);
    }
}
