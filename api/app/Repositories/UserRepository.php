<?php

namespace App\Repositories;

use App\Models\Usuarios;
use App\Repositories\EloquentRepository;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

use function Laravel\Prompts\password;

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

    public function logout()
    {
        auth()->logout();
    }

    public function refresh()
    {
        return auth()->refresh();
    }

    public function me()
    {
        $id = auth()->user()->id;

        return Usuarios::select("usuarios.*")
            ->find($id)
            ->join('datos_usuarios', "usuarios.id", "=", ".datos_usuarios.id")
            ->find($id); //Obtendremos 
    }

    public function CambiarEstatus($id)
    {
        $usuario = $this->find($id);

        $estatus = ($usuario->estatus == "ACTIVO") ? "INACTIVO" : "ACTIVO";
        $this->update($id, ["estatus" => $estatus]);

        return $estatus;
    }

    public function ValidarToken()
    {
        return auth()->check();
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
