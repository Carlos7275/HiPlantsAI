<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Response\Message;
use App\Repositories\RolesRepository;

class RolesController extends Controller
{

    private RolesRepository $_rolesRepository;

    public function __construct(RolesRepository $rolesRepository)
    {
        $this->_rolesRepository = $rolesRepository;
        $this->middleware('auth:api', ['except' => []]);

    }

    public function ObtenerRoles(){
        return response()->json(Message::success($this->_rolesRepository->all()));
    }
}
