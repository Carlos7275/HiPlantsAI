<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class GeneroSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\Generos::create(["id_genero" => 1, "descripcion" => "Masculino"]);
        \App\Models\Generos::create(["id_genero" => 2, "descripcion" => "Femenino"]);
        \App\Models\Generos::create(["id_genero" => 3, "descripcion" => "Indefinido"]);
    }
}
