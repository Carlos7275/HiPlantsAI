<?php

namespace Database\Seeders;

use App\Models\CodigoPostales;
use App\Models\DatosUsuarios;
use Illuminate\Support\Facades\Hash;
use App\Models\Usuarios;
use DateTime;
use Illuminate\Database\Seeder;


class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        CodigoPostales::create([
            "id_asenta_cpcons" => 0,
            "d_asenta" => "NONE",
            "d_codigo" => "0",
            "d_ciudad" => "NONE",
            "c_oficina" => "NONE",
            "c_estado" => "0",
            "d_cp" => "NONE",
            "d_estado" => "NONE",
            "d_mnpio" => "NONE",
            "d_tipo_asenta" => "NONE",
            "c_cp" => "NONE",
            "c_tipo_asenta" => "NONE",
            "c_mnpio" => "NONE",
            "d_zona" => "NONE",
            "c_cve_ciudad" => "NONE"
        ]);

        Usuarios::create([
            "email" => "admin@admin.com",
            "password" => Hash::make("admin"),
            "id_rol" => 1,
            "id_genero" => 3
        ]);
        DatosUsuarios::create([
            "id" => 1,
            "nombres" => "Admin",
            "apellido_paterno" => "admin",
            "apellido_materno" => "admin",
            "domicilio" => "Enrique Segoviano",
            "referencia" => "Especifique referencia",
            "id_asenta_cpcons" => 0,
            "cp" => "0",
            "fecha_nacimiento" => new DateTime("1983-01-01"),
            "telefono" => "1234567890"
        ]);
    }
}
