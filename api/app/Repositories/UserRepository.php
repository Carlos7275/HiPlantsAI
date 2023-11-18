<?php

namespace App\Repositories;

use App\Models\Response\Message;
use App\Models\Usuarios;
use App\Repositories\EloquentRepository;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class UserRepository extends EloquentRepository
{
    public function __construct(Usuarios $user)
    {
        parent::__construct($user);
    }

    public  function  find($id)
    {
        if ($this->exists($id)) {
            $Usuario = $this->model::select("usuarios.*")
                ->find($id)
                ->join('datos_usuarios', "usuarios.id", "=", ".datos_usuarios.id")
                ->find($id);
            return $Usuario;
        }
        return null;
    }

    public function all()
    {
        return $this->model::select()
            ->join('datos_usuarios', "usuarios.id", "=", "datos_usuarios.id")
            ->get();
    }

    public function Login($credentials)
    {
        $token = Auth::attempt([
            "email" => $credentials["email"],
            "password" => $credentials["password"],
            "estatus" => function ($query) {
                $query->where("estatus", "!=", "INACTIVO");
            }
        ]);

        if (!$token)
            return null;

        return $token;
    }

    public function LoginAdmin($credentials)
    {
        $token = Auth::attempt([
            "email" => $credentials["email"],
            "password" => $credentials["password"],
            "estatus" => function ($query) {
                $query->where("estatus", "!=", "INACTIVO")
                    ->where("id_rol", "1");
            }
        ]);

        if (!$token)
            return null;

        return $token;
    }

    public function logout()
    {
        auth()->logout();
    }

    public function refresh()
    {
        return auth()->refresh();
    }

    public function ObtenerTokenEmail($email)
    {
        $datos = $this->model->where("email", "=", $email)->first();

        if ($datos)
            return JWTAuth::fromUser($datos);

        return null;
    }
    public function me()
    {
        $id = auth()->user()->id;

        return $this->model::select("usuarios.*")
            ->find($id)
            ->join('datos_usuarios', "usuarios.id", "=", ".datos_usuarios.id")
            ->find($id); //Obtendremos 
    }

    public function CambiarEstatus($id)
    {
        $usuario = $this->find($id);

        if (isset($usuario)) {
            $estatus = ($usuario->estatus == "ACTIVO") ? "INACTIVO" : "ACTIVO";
            $this->update($id, ["estatus" => $estatus]);
            return $estatus;
        }

        return null;
    }

    public function ValidarToken()
    {
        return auth()->check();
    }

    public function CrearContraseña($passwordNueva)
    {
        $id = auth()->user()->id;

        $this->update($id, ["password" => Hash::make($passwordNueva)]);
    }
    public function CambiarContraseña($passwordActual, $passwordNueva)
    {
        $id = auth()->user()->id;
        $usuario = $this->find($id);

        $coinciden = Hash::check($passwordActual, $usuario->password);
        if ($coinciden) {
            $this->update($id, ["password" => Hash::make($passwordNueva)]);
            return true;
        }
        return false;
    }
}
