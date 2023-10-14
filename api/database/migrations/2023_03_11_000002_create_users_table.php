<?php

use GuzzleHttp\Psr7\Request;
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
        Schema::create('usuarios', function (Blueprint $table) {
             
            $table->id();
            $table->string('email')->unique();
            $table->string('password');
            $table->string("url_imagen")->default("/storage/images/default.png"); 
            $table->bigInteger("id_rol");
            $table->foreign("id_rol")->references("id_rol")->on("roles");//FK Users
            $table->bigInteger("id_genero");
            $table->foreign("id_genero")->references("id_genero")->on("generos");//FK Users
            $table->string("estatus")->default("ACTIVO");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Usuarios');
    }
};
