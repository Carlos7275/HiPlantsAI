<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('codigos_postales', function (Blueprint $table) {
            $table->integer("id_asenta_cpcons");
            $table->string("d_codigo");
            $table->primary(["id_asenta_cpcons", "d_codigo"]);
            $table->string("d_asenta");
            $table->string("d_tipo_asenta");
            $table->string("d_mnpio");
            $table->string("d_estado");
            $table->string("d_ciudad");
            $table->string("d_cp");
            $table->string("c_estado");
            $table->string("c_oficina");
            $table->string("c_cp");
            $table->string("c_tipo_asenta");
            $table->string("c_mnpio");
            $table->string("d_zona");
            $table->string("c_cve_ciudad");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('codigos_postales');
    }
};
