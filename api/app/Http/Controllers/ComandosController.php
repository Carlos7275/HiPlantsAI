<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\ComandosRepository;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class ComandosController extends Controller
{
    private ComandosRepository $_comandosRepository;

    public function __construct(ComandosRepository $comandosRepository)
    {
        $this->_comandosRepository = $comandosRepository;
        $this->middleware('auth:api', ['except' => ["ObtenerComandos"]]);
    }

    public function CrearComando(Request $request)
    {
        try {
            $request->validate([
                "comando" => 'required|string',
                "descripcion" => 'required|string',
            ]);

            $this->_comandosRepository->create($request->json()->all());

            return  response()->json(Message::success("¡El comando se creo correctamente!"));
        } catch (ValidationException $e) {
            return response()->json(Message::Error(Utils::ConvertirErroresALinea($e->errors())), 422);
        }
    }

    public function EditarComando(int $id, Request $request)
    {
        try {
            $request->validate([
                "comando" => 'required|string',
                "descripcion" => 'required|string',
            ]);

            $registro = $this->_comandosRepository->update($id, $request->json()->all());
            if ($registro)
                return  response()->json(Message::success("¡El comando se modifico correctamente!"));
            return response()->json(Message::Observation("¡No existe el comando a editar!"), 404);
        } catch (ValidationException $e) {
            return response()->json(Message::Error(Utils::ConvertirErroresALinea($e->errors())), 422);
        }
    }

    public function ObtenerComandos()
    {
        return response()->json(Message::success($this->_comandosRepository->all()));
    }

    public function EliminarComando($id)
    {
        $dato = $this->_comandosRepository->delete($id);
        if ($dato)
            return response()->json(Message::success("¡Se elimino correctamente el comando!"));
        return response()->json(Message::Observation("¡No existe el comando con id $id!"), 404);
    }
}
