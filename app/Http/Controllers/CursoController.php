<?php

namespace App\Http\Controllers;

use App\Models\Curso;
use App\Models\HistorialAccion;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class CursoController extends Controller
{
    public $validacion = [
        "nombre" => "required|min:1|unique:cursos,nombre",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
    ];

    public function index()
    {
        return Inertia::render("Cursos/Index");
    }

    public function listado()
    {
        $cursos = Curso::select("cursos.*")->get();
        return response()->JSON([
            "cursos" => $cursos
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $cursos = Curso::select("cursos.*");
        $cursos = $cursos->get();
        return response()->JSON([
            "data" => $cursos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $cursos = Curso::select("cursos.*");

        if (trim($search) != "") {
            $cursos->where("nombre", "LIKE", "%$search%");
        }

        $cursos = $cursos->paginate($request->itemsPerPage);
        return response()->JSON([
            "cursos" => $cursos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['fecha_registro'] = date('Y-m-d');
            // crear el Curso
            $nueva_curso = Curso::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_curso, "cursos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN CURSO',
                'datos_original' => $datos_original,
                'modulo' => 'CURSOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("cursos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Curso $curso)
    {
        return response()->JSON($curso);
    }

    public function update(Curso $curso, Request $request)
    {
        $this->validacion["nombre"] = "required|min:1|unique:cursos,nombre," . $curso->id;
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($curso, "cursos");
            $curso->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($curso, "cursos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN CURSO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CURSOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("cursos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Curso $curso)
    {
        DB::beginTransaction();
        try {
            $usos = User::where("curso_id", $curso->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($curso, "cursos");
            $curso->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN CURSO',
                'datos_original' => $datos_original,
                'modulo' => 'CURSOS',
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
