<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('info_plantas', function (Blueprint $table) {
            $table->bigInteger("id");
            $table->primary("id");
            $table->string("nombre_planta");
            $table->string("nombre_cientifico");
            $table->string("toxicidad")->nullable(true);
            $table->integer("año");
            $table->string("familia");
            $table->json("nombres_comunes")->nullable(true);
            $table->json("distribucion")->nullable(true);
            $table->json("colores")->nullable(true);
            $table->string("humedad_atmosferica")->nullable(true);
            $table->string("cantidad_luz")->nullable(true);
            $table->json("meses_crecimiento")->nullable(true);
            $table->string("genero")->nullable(true);
            $table->string("estatus")->nullable(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('info_plantas');
    }
};
