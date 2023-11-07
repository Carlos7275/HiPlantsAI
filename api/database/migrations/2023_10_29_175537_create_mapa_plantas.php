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
        Schema::create('mapa', function (Blueprint $table) {
            $table->id();
            $table->bigInteger("id_planta");
            $table->foreign("id_planta")->references("id")->on("info_plantas"); //FK Users
            $table->string("zona");
            $table->double("latitud");
            $table->double("longitud");
            $table->string("url_imagen");
            $table->integer("estatus")->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('plantas');
    }
};
