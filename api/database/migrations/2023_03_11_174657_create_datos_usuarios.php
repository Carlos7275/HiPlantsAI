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
        Schema::create('datos_usuarios', function (Blueprint $table) {
            $table->id();
            $table->foreign("id")->references("id")->on("usuarios")->onDelete("cascade"); //FK Users
            $table->string("nombres");
            $table->string("apellido_paterno");
            $table->string("apellido_materno")->nullable(true);
            $table->string("domicilio");
            $table->string("referencia");
            $table->integer("id_asenta_cpcons");
            $table->string("cp")->length(255);
            $table->string("telefono")->length(10);
            $table->foreign(["id_asenta_cpcons","cp"])->references(["id_asenta_cpcons","d_codigo"])->on("codigos_postales");//FK Users
            $table->date("fecha_nacimiento");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('datos_usuarios');
    }
};
