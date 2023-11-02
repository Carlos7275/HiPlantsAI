<?php

namespace App\Http\Controllers;

use App\Models\Response\Message;
use App\Repositories\UserRepository;
use App\Services\EmailService;
use App\Utils\Utils;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\ValidationException;

class EmailController extends Controller
{
    private UserRepository $_usuarioRepository;

    public function __construct(
        UserRepository $usuarioRepository
    ) {
        $this->_usuarioRepository = $usuarioRepository;
    }
    public function RecuperarCuenta(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required|string|email',
            ]);
            $existe = $this->_usuarioRepository->ObtenerTokenEmail($request->email);

            if (isset($existe)) {
                Mail::to($request->email)->send(new EmailService($existe, $request->email));
                return response()->json(Message::success("¡Se envio correctamente el correo!"));
            }

            return response()->json(Message::Observation("¡El correo no se encuentra registrado en el sistema!"), 400);
        } catch (ValidationException $exception) {
            return response()->json(
                Message::Error(Utils::ConvertirErroresALinea($exception->errors())),
                422
            );
        }
    }
}
