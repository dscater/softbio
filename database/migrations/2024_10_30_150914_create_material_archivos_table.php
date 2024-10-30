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
        Schema::create('material_archivos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("material_id");
            $table->string("archivo", 300);
            $table->timestamps();

            $table->foreign("material_id")->on("materials")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('material_archivos');
    }
};
