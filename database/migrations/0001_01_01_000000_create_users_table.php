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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('nombre');
            $table->string('paterno');
            $table->string('materno')->nullable();
            $table->string('ci');
            $table->string('ci_exp');
            $table->string('email', 255);
            $table->string('password');
            $table->string('tipo', 255);
            $table->string('foto', 255)->nullable();
            $table->date("fecha_registro");
            $table->integer("acceso");
            $table->unsignedBigInteger("curso_id")->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};
