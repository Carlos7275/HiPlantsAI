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
        Schema::create('recorridos', function (Blueprint $table) {
            $table->id();
            $table->bigInteger("id_mapa", false, true);
            $table->bigInteger("id_usuario", false, true);
            $table->foreign("id_usuario")->references("id")->on("usuarios"); //FK Users
            $table->foreign("id_mapa")->references("id")->on("mapa"); //FK mapa
            $table->integer("tiempo");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recorridos');
    }
};
