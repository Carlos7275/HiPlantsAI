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
            $table->string("toxicidad");
            $table->year("año");
            $table->string("familia");
            $table->json("nombres_comunes");
            $table->json("distribucion");
            $table->string("color");
            $table->string("humedad_atmosferica");
            $table->string("cantidad_luz");
            $table->json("meses_crecimiento");
            $table->string("genero");
            $table->string("estatus");
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
