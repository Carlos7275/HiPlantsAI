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
                "puntos" => "required|array",
                "puntos.*" => "int|min:1",
                "tiempo" => "required|int"
            ]);

            $idusuario = auth()->user()->id;
            $array = $request->json()->all();

            foreach ($array["puntos"] as $dato) {
                $datos = array(
                    "id_mapa" => $dato,
                    "id_usuario" => $idusuario,
                    "tiempo" => $array["tiempo"]
                );
                $this->_recorridoRepository->create($datos);
            }

            return response()->json(Message::success("Se registro correctamente el recorrido"), 200);
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
            $recorridos=$this->_recorridoRepository->ObtenerMisRecorridos($request->fechainicial, $request->fechafinal);

            return response()->json(Message::success($recorridos));
        } catch (ValidationException $e1) {
            return response()->json(Message::Error(Utils::ConvertirErroresALinea($e1->errors())), 422);
        }
    }
}
