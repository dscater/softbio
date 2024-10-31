<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EvaluacionPregunta extends Model
{
    use HasFactory;

    protected $fillable = [
        "evaluacion_id",
        "tema",
        "pregunta",
        "opcion",
        "correcto",
    ];

    public function evaluacion()
    {
        return $this->belongsTo(Evaluacion::class, 'evaluacion_id');
    }
}
