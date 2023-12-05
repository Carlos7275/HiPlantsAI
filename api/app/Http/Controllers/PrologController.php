<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\UserRepository;
use Illuminate\Support\Facades\Http;

class PrologController extends Controller
{
    var $prologURL;
    var UserRepository $_usuarioRepository; 

    public function __construct(UserRepository $usuarioRepository)
    {
        $this->middleware('auth:api', ['except' => []]);
        $this->prologURL = env("PrologURL");
        $this->_usuarioRepository=$usuarioRepository;
    }

    public function ObtenerPlantasNoVisitadas()
    {
        $id=auth()->user()->id;

        $id=urlencode($id);
        $url = "{$this->prologURL}/plantasNoVisitadas?idusuario=$id";
        $response = json_decode(Http::get($url));
        return response()->json(Message::success($response->resultado));
    }

    public function ObtenerPlantasNoVisitadasCercanas($Lat,$Long)
    {
        $id=auth()->user()->id;
        $Lat=urlencode($Lat);
        $Long=urlencode($Long);
        $id=urlencode($id);
        $url = "{$this->prologURL}/plantasNoVisitadas/Cercanas?lat=$Lat&long=$Long&idusuario=$id";
        $response = json_decode(Http::get($url));
        return response()->json(Message::success($response->resultado));
    }
}
