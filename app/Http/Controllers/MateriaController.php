<?php

namespace App\Http\Controllers;

use App\Models\Materia;
use Illuminate\Http\Request;

class MateriaController extends Controller
{
    public function listado()
    {
        $materias = Materia::select("materias.*")->get();
        return response()->JSON([
            "materias" => $materias
        ]);
    }

    public function api(Request $request)
    {
        $materias = Materia::select("materias.*");
        $materias = $materias->get();
        return response()->JSON([
            "data" => $materias
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $materias = Materia::select("materias.*");

        if (trim($search) != "") {
            $materias->where("nombre", "LIKE", "%$search%");
        }

        $materias = $materias->paginate($request->itemsPerPage);
        return response()->JSON([
            "materias" => $materias
        ]);
    }
}
