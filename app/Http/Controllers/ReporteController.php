<?php

namespace App\Http\Controllers;

use App\Models\Aprendizaje;
use App\Models\KardexProducto;
use App\Models\Producto;
use App\Models\User;
use App\Models\VentaDetalle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;

class ReporteController extends Controller
{
    public function usuarios()
    {
        return Inertia::render("Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        $tipo =  $request->tipo;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($tipo != 'todos') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios->where('tipo', $tipo);
        }

        $usuarios = $usuarios->orderBy("paterno", "ASC")->get();

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('usuarios.pdf');
    }

    public function estudiantes()
    {
        return Inertia::render("Reportes/Estudiantes");
    }

    public function r_estudiantes(Request $request)
    {
        $estudiantes = User::select("users.*")
            ->where('id', '!=', 1);
        $estudiantes->where('tipo', "ESTUDIANTE");

        if (Auth::user()->tipo == 'PROFESOR') {
            $estudiantes->where('curso_id', Auth::user()->curso_id);
        }

        $estudiantes = $estudiantes->orderBy("paterno", "ASC")->get();

        $pdf = PDF::loadView('reportes.estudiantes', compact('estudiantes'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('estudiantes.pdf');
    }

    public function evaluacions()
    {
        return Inertia::render("Reportes/Evaluacions");
    }

    public function r_evaluacions(Request $request)
    {
        $curso_id =  $request->curso_id;
        $user_id =  $request->user_id;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($curso_id != 'todos') {
            $usuarios->where("curso_id", $curso_id);
        }

        if ($user_id != 'todos') {
            $usuarios->where("id", $user_id);
        }

        $preguntas = json_decode(file_get_contents(public_path('assets/js/preguntas.json')), true);

        $usuarios = $usuarios->where("tipo", "ESTUDIANTE")->orderBy("paterno", "ASC")->get();

        $pdf = PDF::loadView('reportes.evaluacions', compact('usuarios', 'preguntas'))->setPaper('legal', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('evaluacions.pdf');
    }

    public function aprendizajes()
    {
        return Inertia::render("Reportes/Aprendizajes");
    }

    public function r_aprendizajes(Request $request)
    {
        $tipo =  $request->tipo;
        $aprendizajes = Aprendizaje::orderBy("puntaje", "desc")->get()->take(10);

        $pdf = PDF::loadView('reportes.aprendizajes', compact('aprendizajes'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('aprendizajes.pdf');
    }

    public function rg_aprendizajes(Request $request)
    {
        $data = [];
        $aprendizajes = Aprendizaje::orderBy("puntaje", "desc")->get()->take(10);
        foreach ($aprendizajes as $item) {
            $data[] = [$item->user->full_name, (float)$item->puntaje];
        }

        return response()->JSON([
            "data" => $data
        ]);
    }
}
