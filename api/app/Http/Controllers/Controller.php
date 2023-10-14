<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

/**
 * @OA\Info(title="API Base", version="1.0")
 *
 * @OA\Server(url="http://localhost")
 */
class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;
}
