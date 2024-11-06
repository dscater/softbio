<?php

namespace App\Http\Controllers;

use App\Models\Aprendizaje;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class AprendizajeController extends Controller
{
    public function index()
    {
        return Inertia::render("Aprendizajes/Index");
    }


    public function puntajesCurso()
    {
        return Inertia::render("Aprendizajes/PuntajesCurso");
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
        $aprendizajes = Aprendizaje::select("aprendizajes.*")->with(["user.curso"])->orderBy("puntaje", "desc")->get()->take(10);
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

    public function listaPuntajes(Request $request)
    {
        $user = Auth::user();
        $aprendizajes = Aprendizaje::with(["user.curso"])->select("aprendizajes.*")
            ->join("users", "users.id", "=", "aprendizajes.user_id")
            ->where("users.curso_id", $user->curso_id);
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

    public function store(Request $request)
    {
        DB::beginTransaction();
        try {
            $existe = Aprendizaje::where("user_id", Auth::user()->id)->get()->first();

            if (!$existe) {
                $data = [
                    "user_id" => Auth::user()->id,
                    "puntaje" => $request->puntaje
                ];

                Aprendizaje::create($data);
            } else {
                $puntaje = (int)$existe->puntaje + $request->puntaje;
                $existe->puntaje = $puntaje;
                $existe->save();
            }

            DB::commit();
            return response()->JSON(true);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON(["message" => "Ocurrio un error"], 500);
        }
    }
}
