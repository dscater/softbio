<?php

namespace App\Http\Controllers;

use App\Models\Evaluacion;
use App\Models\EvaluacionPregunta;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class EvaluacionController extends Controller
{
    public $validacion = [];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
    ];

    public function index()
    {
        return Inertia::render("Evaluacions/Index");
    }

    public function listado()
    {
        $evaluacions = Evaluacion::with(["user.curso"])->select("evaluacions.*")->get();
        return response()->JSON([
            "evaluacions" => $evaluacions
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $evaluacions = Evaluacion::with(["user.curso"])->select("evaluacions.*");
        $evaluacions = $evaluacions->get();
        return response()->JSON([
            "data" => $evaluacions
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $evaluacions = Evaluacion::with(["user.curso"])->select("evaluacions.*");

        if (trim($search) != "") {
            $evaluacions->where("nombre", "LIKE", "%$search%");
        }

        $evaluacions = $evaluacions->paginate($request->itemsPerPage);
        return response()->JSON([
            "evaluacions" => $evaluacions
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['fecha_registro'] = date('Y-m-d');
            // crear el Evaluacion
            $nueva_evaluacion = Evaluacion::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_evaluacion, "evaluacions");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA EVALUACIÓN',
                'datos_original' => $datos_original,
                'modulo' => 'EVALUACIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("evaluacions.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function edit()
    {
        $evaluacion = null;
        if (Auth::user()->tipo == 'ESTUDIANTE') {
            $evaluacion = Evaluacion::where("user_id", Auth::user()->id)->get()->first();
            if (!$evaluacion) {
                $evaluacion = Evaluacion::create([
                    "user_id" => Auth::user()->id,
                    "fecha_registro" => date("Y-m-d")
                ]);
            }
            $evaluacion = $evaluacion->load(["evaluacion_preguntas"]);
        }
        return Inertia::render("Evaluacions/Edit", compact("evaluacion"));
    }

    public function show(Evaluacion $evaluacion)
    {
        $evaluacion = $evaluacion->load(["user.curso", "evaluacion_preguntas"]);
        return Inertia::render("Evaluacions/Show", compact("evaluacion"));
    }

    public function update(Evaluacion $evaluacion, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            if (isset($request->evaluacion_preguntas) && count($request->evaluacion_preguntas) > 0) {
                $datos_original = HistorialAccion::getDetalleRegistro($evaluacion, "evaluacions");
                $evaluacion_preguntas = $request->evaluacion_preguntas;

                foreach ($evaluacion_preguntas as $ep) {
                    $data = [
                        "evaluacion_id" => $evaluacion->id,
                        "tema" => $ep["tema"],
                        "pregunta" => $ep["pregunta"],
                        "opcion" => $ep["opcion"],
                        "correcto" => $ep["correcto"],
                    ];
                    if ($ep["id"] == 0) {
                        $evaluacion->evaluacion_preguntas()->create($data);
                    } else {
                        $evaluacion_pregunta = EvaluacionPregunta::find($ep["id"]);
                        $evaluacion_pregunta->update($data);
                    }
                }

                HistorialAccion::create([
                    'user_id' => Auth::user()->id,
                    'accion' => 'MODIFICACIÓN',
                    'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA EVALUACIÓN',
                    'datos_original' => $datos_original,
                    'datos_nuevo' => "",
                    'modulo' => 'EVALUACIONES',
                    'fecha' => date('Y-m-d'),
                    'hora' => date('H:i:s')
                ]);
            }

            DB::commit();

            if ($request->ajax()) {
                Log::debug("ASDSD");
                return response()->JSON([
                    "evaluacion" => $evaluacion->load(["evaluacion_preguntas"])
                ]);
            }
            Log::debug("BBB");

            // return redirect()->route("evaluacions.edit", $evaluacion->id)->with("bien", "Registro actualizado");
            return redirect()->route("evaluacions.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Evaluacion $evaluacion)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($evaluacion, "evaluacions");
            $evaluacion->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA EVALUACIÓN',
                'datos_original' => $datos_original,
                'modulo' => 'EVALUACIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
