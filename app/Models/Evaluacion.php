<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

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

    public static function getCorrectosTema($tema, $evaluacion_id)
    {
        $jsonPath = public_path("assets/js/preguntas.json");
        $jsonContent = file_get_contents($jsonPath);
        $data = json_decode($jsonContent, true);
        $totalPorTema = array_map(fn($tema) => count($tema['p']), $data);

        $total_tema = $totalPorTema[$tema];

        $correctos = EvaluacionPregunta::where("evaluacion_id", $evaluacion_id)
            ->where("tema", $tema)
            ->where("correcto", 1)->count();

        $p = $correctos /  $total_tema;
        $p = $p * 100;
        return round($p, 2);
    }
}
