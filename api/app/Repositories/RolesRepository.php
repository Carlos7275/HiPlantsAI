<?php

namespace App\Repositories;

use App\Models\Roles;
use App\Repositories\EloquentRepository;

class RolesRepository extends EloquentRepository
{
    public function __construct(Roles $roles)
    {
        parent::__construct($roles);
    }
}
