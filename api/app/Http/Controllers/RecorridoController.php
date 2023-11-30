<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\RecorridosRepository;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class RecorridoController extends Controller
{
    private RecorridosRepository $_recorridoRepository;

    public function __construct(RecorridosRepository $recorridoRepository)
    {
        $this->middleware('auth:api', ['except' => []]);
        $this->_recorridoRepository = $recorridoRepository;
    }

    public function RegistrarRecorrido(Request $request)
    {
        try {

            $request->validate([
                "id_mapa" => "required|int",
                "id_usuario" => "required|int",
                "tiempo" => "required|int"
            ]);

            $array = $request->json()->all();
            $this->_recorridoRepository->create($array);

            return response()->json(Message::success("Se registro correctamente el recorrido"), 201);
        } catch (ValidationException $e1) {
            return response()->json(Message::Error(Utils::ConvertirErroresALinea($e1->errors())), 422);
        }
    }

    public function ObtenerRecorridos()
    {
        return response()->json(Message::success($this->_recorridoRepository->all()));
    }
    public function ObtenerMisRecorridos(Request $request)
    {
        try {

            $request->validate([
                "fechainicial" => "required|date",
                "fechafinal" => "required|date",
            ]);

            return response()->json(Message::success($this->_recorridoRepository->ObtenerMisRecorridos($request->fechainicial, $request->fechafinal)));
        } catch (ValidationException $e1) {
            return response()->json(Message::Error(Utils::ConvertirErroresALinea($e1->errors())), 422);
        }
    }
}
