<?php

namespace Database\Seeders;


use Illuminate\Database\Seeder;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $role1 = \App\Models\Roles::create(["id_rol" => 1, "nombre" => "Admin"]);
        $role2 = \App\Models\Roles::create(["id_rol" => 2, "nombre" => "Usuario Común"]);
    }
    public function up()
    {
    }
}
