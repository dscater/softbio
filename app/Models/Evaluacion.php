<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Evaluacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "fecha_registro",
    ];


    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function evaluacion_preguntas()
    {
        return $this->hasMany(EvaluacionPregunta::class, 'evaluacion_id');
    }
}
