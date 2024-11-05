<?php

namespace App\Http\Controllers;

use App\Models\Aprendizaje;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AprendizajeController extends Controller
{
    public function index()
    {
        return Inertia::render("Aprendizajes/Index");
    }

    public function listado()
    {
        $aprendizajes = Aprendizaje::select("aprendizajes.*")->get();
        return response()->JSON([
            "aprendizajes" => $aprendizajes
        ]);
    }

    public function mejores()
    {
        $aprendizajes = Aprendizaje::select("aprendizajes.*")->with(["user"])->orderBy("puntaje", "desc")->get()->take(10);
        return response()->JSON([
            "aprendizajes" => $aprendizajes
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $aprendizajes = Aprendizaje::select("aprendizajes.*");
        $aprendizajes = $aprendizajes->get();
        return response()->JSON([
            "data" => $aprendizajes
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $aprendizajes = Aprendizaje::select("aprendizajes.*");

        if (trim($search) != "") {
            $aprendizajes->where("nombre", "LIKE", "%$search%");
        }

        $aprendizajes = $aprendizajes->paginate($request->itemsPerPage);
        return response()->JSON([
            "aprendizajes" => $aprendizajes
        ]);
    }
}
