<?php

use App\Http\Controllers\UserController;
use App\Http\Controllers\CodigoPostalController;
use App\Http\Controllers\EmailController;
use App\Http\Controllers\GenerosController;
use App\Http\Controllers\RecorridoController;
use App\Http\Controllers\RolesController;
use Illuminate\Support\Facades\Route;

Route::group([
    'middleware' => 'api',
    'prefix' => 'auth' //Le asignamos el prefijo auth ejemplo api/auth/login
], function ($router) {
    Route::post("login", [UserController::class, "IniciarSesion"]);
    Route::post('logout', [UserController::class, 'CerrarSesion']);
    Route::post('refresh', [UserController::class, 'RefrescarToken']);
    Route::get('me', [UserController::class, 'me']);
    Route::post('valid', [UserController::class, 'ValidarToken']);
});
Route::middleware(['role:1'])->group(function () {
    Route::get("Roles", [RolesController::class, "ObtenerRoles"]);
    Route::get("Recorridos", [RecorridoController::class, "ObtenerRecorridos"]);
});

Route::controller(UserController::class)->group(function () {
    Route::get('Usuario/{id}', "ObtenerUsuarioEspecifico");
    Route::get('Usuarios', "ObtenerUsuarios");
    Route::post('Registrar/Usuario', "CrearUsuario");
    Route::put('Modificar/Usuario/{id}', "ModificarUsuario");
    Route::put("Cambiar/Contraseña/", "CambiarContraseña");
    Route::put("Crear/Contraseña/", "CrearContraseña");
    Route::get("Validar/Token/", "ValidarJWT");
    Route::delete("Cambiar/Estatus/Usuario/{id}", "CambiarEstatus");
});

Route::controller(RecorridoController::class)->group(function () {
    Route::post("Registrar/Recorrido", "RegistrarRecorrido");
    Route::get("MisRecorridos", "ObtenerMisRecorridos");
});

Route::controller(CodigoPostalController::class)->group(function () {
    Route::get("CodigosPostales", "ObtenerCP");
    Route::get("CodigoPostal/{id_asenta}/{cp}", "ObtenerCPEspecifico");
    Route::get("CodigoPostal/{cp}", "BuscarCP");
});

Route::controller(GenerosController::class)->group(function () {
    Route::get("Generos", "ObtenerGeneros");
});

Route::controller(EmailController::class)->group(function () {
    Route::post("Recuperar/Cuenta", "RecuperarCuenta");
});
