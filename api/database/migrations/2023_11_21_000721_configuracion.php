<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('configuracion', function (Blueprint $table) {
            $table->id();
            $table->string("tokentreffle")->nullable(true);
            $table->string("tokenplantsnet")->nullable(true);
            $table->string("tokenipinfo")->nullable(true);
            $table->double("distanciamin")->default(0);
            $table->double("distanciamax")->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('configuracion');
    }
};
