<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Image;
use App\Models\Paths;
use App\Models\Response\Message;
use App\Repositories\DatosUsuarioRepository;
use App\Repositories\UserRepository;
use App\Utils\Utils;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserController extends Controller
{
    private $_usuarioRepository, $_datosUsuarioRepository;

    public function __construct(
        UserRepository $usuarioRepository,
        DatosUsuarioRepository $datosUsuarioRepository
    ) {
        $this->_usuarioRepository = $usuarioRepository;
        $this->_datosUsuarioRepository = $datosUsuarioRepository;
        $this->middleware('auth:api', ['except' => ['IniciarSesion', 'TokenValido', 'CrearUsuario']]);
    }

    public function ObtenerUsuarioEspecifico($id)
    {
        $usuario = $this->_usuarioRepository->find($id);

        if ($usuario)
            return response()->json(Message::success($usuario));

        return response()->json(Message::notFound(), 404);
    }

    public function ObtenerUsuarios()
    {
        return response()->json(Message::success($this->_usuarioRepository->all()));
    }

    public function IniciarSesion(Request $request)
    {
        try {
            $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);

            $credentials = $request->only('email', 'password');
            $token = $this->_usuarioRepository->Login($credentials);
            if ($token)
                return response()->json(Message::success($token));

            return response()->json(Message::Observation("¡Verifique sus credenciales!"), 400);
        } catch (ValidationException $exception) {

            return response()->json(
                Message::Error(Utils::ConvertirErroresALinea($exception->errors())),
                422
            );
        }
    }

    public function RefrescarToken()
    {
        return response()->json(Message::success($this->_usuarioRepository->refresh()));
    }

    public function Me()
    {
        return response()->json(Message::success($this->_usuarioRepository->me()));
    }

    public function CerrarSesion()
    {
        $this->_usuarioRepository->logout();
        return response()->json(Message::success("¡Se cerro sesión con exito!"));
    }
    public function CrearUsuario(Request $request)
    {
        try {
            $request->validate(
                [
                    'email' => 'required|email|unique:Usuarios|max:255',
                    'password' => 'required|max:10',
                    'nombres' => 'required',
                    'domicilio' => 'required|max:255',
                    'id_rol' => 'required| int',
                    "id_genero" => "required | int",
                    "id_asenta" => "required| int",
                    "cp" => "required| max:6",
                    'fecha_nacimiento' => 'required|date',
                ]
            );

            $idrol = $this->_usuarioRepository->ValidarToken() ? $request->Id_Rol : 2;

            DB::transaction(function () use ($idrol) { // Si falla la transaccion no se registrara nada

                $arrayUser =  array(
                    'email' => request("email"),
                    "password" => Hash::make(request("password")),
                    "id_rol" => $idrol,
                    "id_genero" => request("id_genero"),
                    "urlImagen" => "/storage/images/default.png"
                );

                $datos = $this->_usuarioRepository->create($arrayUser);

                $arrayDataUser = array(
                    "id" => $datos["id"],
                    "nombres" => request("nombres"),
                    "apellido_paterno" => request("apellido_paterno"),
                    "apellido_materno" => request("apellido_materno"),
                    "domicilio" => request("domicilio"),
                    "fecha_nacimiento" => request("fecha_nacimiento"),
                    "referencia" => request("referencia"),
                    "id_asenta_cpcons" => request("id_asenta"),
                    "cp" => request("cp"),
                    "telefono" => request("telefono")
                );

                $this->_datosUsuarioRepository->create($arrayDataUser);
            });

            return response()->json(Message::success("Se registro correctamente el usuario"));
        } catch (ValidationException $exception) {

            return response()->json(
                Message::Error(Utils::ConvertirErroresALinea($exception->errors())),
                422
            );
        }
    }

    public function ModificarUsuario($id, Request $request)
    {
        try {
            $request->validate(
                [
                    'email' => 'required|email|max:255',
                    'nombres' => 'required',
                    'domicilio' => 'required|max:255',
                    'fecha_nacimiento' => 'required|date',
                    "id_asenta" => "required| int",
                    "cp" => "required| max:6",
                ]
            );

            DB::transaction(function () use ($request, $id) {
                $datosUsuario = $this->_usuarioRepository->find($id);

                if ($request->has("imagen") && isset($request->imagen)) {
                    $request->validate(["url_imagen" => 'image']);

                    if ($datosUsuario->url_imagen != "/storage/images/default.png")
                        Image::DeleteImage(Paths::getRelativePath($datosUsuario->url_imagen));

                    $ruta = Image::base64toUrl($request->imagen);
                    $this->_usuarioRepository->update($id, ["url_imagen" => $ruta]);
                }
                $arrayUser =  array(
                    'email' => request("email"),
                    "id_rol" => request("id_rol"),
                    "id_genero" => request("id_genero"),
                );

                $arrayDataUser = array(
                    "id" => request("id"),
                    "nombres" => request("nombres"),
                    "apellido_paterno" => request("apellido_paterno"),
                    "apellido_materno" => request("apellido_Materno"),
                    "domicilio" => request("domicilio"),
                    "fecha_nacimiento" => request("fecha_nacimiento"),
                    "id_asenta_cpcons" => request("id_asenta"),
                    "cp" => request("cp")
                );

                $this->_usuarioRepository->update($id, $arrayUser);
                $this->_datosUsuarioRepository->update($id, $arrayDataUser);
            });

            return response()->json(Message::success("Se modifico correctamente el usuario"));
        } catch (ValidationException $exception) {

            return response()->json(
                Message::Error(Utils::ConvertirErroresALinea($exception->errors())),
                422
            );
        }
    }

    public function ValidarToken()
    {
        if ($this->_usuarioRepository->ValidarToken())
            return response()->json(Message::success(true));

        return response()->json(Message::Forbidden(), 400);
    }

    public function CambiarEstatus($id)
    {
        $estatus = $this->_usuarioRepository->CambiarEstatus($id);

        return response()->json(Message::success("¡Se cambio el estatus del usuario a {$estatus}!"));
    }
}
