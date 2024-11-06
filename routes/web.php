<?php

use App\Http\Controllers\AprendizajeController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\CursoController;
use App\Http\Controllers\EvaluacionController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\MateriaController;
use App\Http\Controllers\MaterialController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("porta.index");

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

Route::middleware('auth')->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisos", [UserController::class, 'permisos']);

    // USUARIOS
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/api", [UsuarioController::class, 'api'])->name("usuarios.api");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // CURSOS
    Route::get("cursos/api", [CursoController::class, 'api'])->name("cursos.api");
    Route::get("cursos/paginado", [CursoController::class, 'paginado'])->name("cursos.paginado");
    Route::get("cursos/listado", [CursoController::class, 'listado'])->name("cursos.listado");
    Route::resource("cursos", CursoController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // MATERIAS
    Route::get("materias/api", [MateriaController::class, 'api'])->name("materias.api");
    Route::get("materias/paginado", [MateriaController::class, 'paginado'])->name("materias.paginado");
    Route::get("materias/listado", [MateriaController::class, 'listado'])->name("materias.listado");

    // MATERIALES
    Route::get("materials/api", [MaterialController::class, 'api'])->name("materials.api");
    Route::get("materials/paginado", [MaterialController::class, 'paginado'])->name("materials.paginado");
    Route::get("materials/listado", [MaterialController::class, 'listado'])->name("materials.listado");
    Route::resource("materials", MaterialController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // EVALUACION
    Route::get("evaluacions/api", [EvaluacionController::class, 'api'])->name("evaluacions.api");
    Route::get("evaluacions/paginado", [EvaluacionController::class, 'paginado'])->name("evaluacions.paginado");
    Route::get("evaluacions/listado", [EvaluacionController::class, 'listado'])->name("evaluacions.listado");
    Route::get("evaluacions/edit", [EvaluacionController::class, 'edit'])->name("evaluacions.edit");
    Route::resource("evaluacions", EvaluacionController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // APRENDIZAJE
    Route::get("aprendizajes/api", [AprendizajeController::class, 'api'])->name("aprendizajes.api");
    Route::get("aprendizajes/puntajesCurso", [AprendizajeController::class, 'puntajesCurso'])->name("aprendizajes.puntajesCurso");
    Route::get("aprendizajes/listaPuntajes", [AprendizajeController::class, 'listaPuntajes'])->name("aprendizajes.listaPuntajes");
    Route::get("aprendizajes/paginado", [AprendizajeController::class, 'paginado'])->name("aprendizajes.paginado");
    Route::get("aprendizajes/listado", [AprendizajeController::class, 'listado'])->name("aprendizajes.listado");
    Route::get("aprendizajes/mejores", [AprendizajeController::class, 'mejores'])->name("aprendizajes.mejores");
    Route::resource("aprendizajes", AprendizajeController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");
});
require __DIR__ . '/auth.php';
