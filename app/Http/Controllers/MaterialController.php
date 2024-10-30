<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Material;
use App\Models\MaterialArchivo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class MaterialController extends Controller
{
    public $validacion = [
        "materia_id" => "required",
    ];

    public $mensajes = [
        "materia_id.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Materials/Index");
    }

    public function listado()
    {
        $materials = Material::with(["materia"])->select("materials.*")->get();
        return response()->JSON([
            "materials" => $materials
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $materials = Material::with(["materia", "material_archivos"])->select("materials.*");
        $materials = $materials->get();
        return response()->JSON([
            "data" => $materials
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $materials = Material::with(["materia"])->select("materials.*");

        if (trim($search) != "") {
            $materials->where("nombre", "LIKE", "%$search%");
        }

        $materials = $materials->paginate($request->itemsPerPage);
        return response()->JSON([
            "materials" => $materials
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['fecha_registro'] = date('Y-m-d');
            // crear el Material
            $data = [
                "materia_id" => $request->materia_id,
                "fecha_registro" => $request->fecha_registro
            ];
            $nuevo_material = Material::create($data);

            if ($request->file("material_archivos")) {
                $material_archivos = $request->file('material_archivos');
                foreach ($material_archivos as $key => $value) {
                    $file = $value["file"];
                    $nom_archivo = "doc_" . $nuevo_material->id . "_" . time() . $key . "." . $file->getClientOriginalExtension();
                    $nuevo_material->material_archivos()->create([
                        "archivo" => $nom_archivo,
                    ]);
                    $file->move(public_path() . '/files/', $nom_archivo);
                }
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_material, "materials");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN MATERIAL DE APOYO',
                'datos_original' => $datos_original,
                'modulo' => 'MATERIAL DE APOYO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("materials.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Material $material)
    {
        return response()->JSON($material->load(["materia", "material_archivos"]));
    }

    public function update(Material $material, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $data = [
                "materia_id" => $request->materia_id,
            ];
            $datos_original = HistorialAccion::getDetalleRegistro($material, "materials");
            $material->update($data);

            if ($request->file("material_archivos")) {
                $material_archivos = $request->file('material_archivos');
                foreach ($material_archivos as $key => $value) {
                    $file = $value["file"];
                    $nom_archivo = "doc_" . $material->id . "_" . time() . $key . "." . $file->getClientOriginalExtension();
                    $material->material_archivos()->create([
                        "archivo" => $nom_archivo,
                    ]);
                    $file->move(public_path() . '/files/', $nom_archivo);
                }
            }

            if (isset($request->eliminados)) {
                foreach ($request->eliminados as $value) {
                    $ma = MaterialArchivo::find($value);
                    if (file_exists(public_path("files/" . $ma->archivo))); {
                        \File::delete(public_path("files/" . $ma->archivo));
                    }
                    $ma->delete();
                }
            }


            $datos_nuevo = HistorialAccion::getDetalleRegistro($material, "materials");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN MATERIAL DE APOYO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'MATERIAL DE APOYO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("materials.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Material $material)
    {
        DB::beginTransaction();
        try {
            $delete_paths = [];

            foreach ($material->material_archivos as $ma) {
                $path = public_path("files/" . $ma->archivo);
                if (file_exists($path)) {
                    $delete_paths[] = $path;
                }
                $ma->delete();
            }

            $datos_original = HistorialAccion::getDetalleRegistro($material, "materials");
            $material->delete();

            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN MATERIAL DE APOYO',
                'datos_original' => $datos_original,
                'modulo' => 'MATERIAL DE APOYO',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            foreach ($delete_paths as $value) {
                \File::delete($value);
            }
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
