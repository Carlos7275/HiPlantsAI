<?php

namespace Database\Seeders;


use Illuminate\Database\Seeder;

class ConfiguracionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\Configuracion::create(["id" => 1]);
    }
    public function up()
    {
    }
}
