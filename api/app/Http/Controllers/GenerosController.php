<?php
namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use App\Models\Response\Message;
use App\Repositories\GenerosRepository;

class GenerosController extends Controller
{

    private GenerosRepository $_generosRepository;

    public function __construct(GenerosRepository $generosRepository)
    {
        $this->_generosRepository = $generosRepository;
    }

    public function ObtenerGeneros(){
        return response()->json(Message::success($this->_generosRepository->all()));
    }
}
