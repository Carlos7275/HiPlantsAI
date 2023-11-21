<?php

namespace Database\Seeders;


use Illuminate\Database\Seeder;

class RolesSeeder extends Seeder
{
    public function run(): void
    {
        \App\Models\Roles::create(["id_rol" => 1, "nombre" => "Admin"]);
        \App\Models\Roles::create(["id_rol" => 2, "nombre" => "Usuario Común"]);
    }
    public function up()
    {
    }
}
