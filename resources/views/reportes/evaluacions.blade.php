<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>evaluacion</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 2cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 7pt;
        }

        table tbody tr td {
            font-size: 6pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 100px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .txt_rojo {}

        .img_celda img {
            width: 45px;
        }

        .break_page {
            page-break-after: always;
        }

        .txtInfo {
            font-size: 10pt;
        }

        .tituloTema {
            font-size: 11pt;
            font-weight: bold;
            width: 100%;
            text-align: center;
        }

        .pregunta {
            font-size: 9.6pt;
        }

        .contenedor_opciones {
            font-size: 9.4pt;
            padding-left: 20px;
        }

        .seleccionado {
            display: inline-block;
            border: solid 1px black;
            padding: 2px;
            margin-top: 2px;
            margin-bottom: 2px;
            border-radius: 6px;
        }

        .correcto {
            color: green;
        }

        .incorrecto {
            color: red;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @php
        $contador = 0;
        $incisos = ['a)', 'b)', 'c)', 'd)', 'e)', 'f)', 'g)', 'h)'];
    @endphp
    @foreach ($usuarios as $usuario)
        <div class="encabezado">
            <div class="logo">
                <img src="{{ $configuracion->first()->logo_b64 }}">
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">EVALUACIÓN</h4>
            <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
        </div>
        @php
            $evaluacion = $usuario->evaluacion;
        @endphp
        @if ($evaluacion)
            @foreach ($preguntas as $key_item => $item)
                <p class="tituloTema">{{ $item['t'] }}</p>
                <p class="txtInfo"><strong>Estudiante:</strong> {{ $usuario->full_name }}</p>
                <p class="txtInfo"><strong>Curso:</strong> {{ $usuario->curso ? $usuario->curso->nombre : '' }}</p>
                @foreach ($item['p'] as $index_preg => $item_preg)
                    <p class="pregunta">{{ $index_preg + 1 }}) {{ $item_preg['e'] }}</p>
                    <div class="contenedor_opciones">
                        @foreach ($item_preg['o'] as $index_opcion => $opcion)
                            @php
                                $clase1 = '';
                                $clase2 = '';
                                $evaluacionPregunta = App\Models\EvaluacionPregunta::where(
                                    'evaluacion_id',
                                    $evaluacion->id,
                                )
                                    ->where('tema', $key_item)
                                    ->where('pregunta', $index_preg)
                                    ->get()
                                    ->first();
                                if ($evaluacionPregunta) {
                                    if ($evaluacionPregunta->opcion == $index_opcion) {
                                        $clase1 = 'seleccionado';
                                        if ($evaluacionPregunta->correcto == 1) {
                                            $clase2 = ' correcto';
                                        } else {
                                            $clase2 = ' incorrecto';
                                        }
                                    }
                                }

                            @endphp
                            <span class="opcion {{ $clase1 }}{{ $clase2 }}">{{ $incisos[$index_opcion] }}
                                {{ $opcion }}</span><br>
                        @endforeach
                    </div>
                @endforeach
                @if ($key_item < count($preguntas) - 1)
                    <div class="break_page"></div>
                @endif
            @endforeach
        @else
            <p class="txtInfo"><strong>Estudiante:</strong> {{ $usuario->full_name }}</p>
            <p class="txtInfo"><strong>Curso:</strong> {{ $usuario->curso ? $usuario->curso->nombre : '' }}</p>
            <p>Aún no se registro ninguna evaluación</p>
        @endif
        @php
            $contador++;
        @endphp
        @if ($contador < count($usuarios))
            <div class="break_page"></div>
        @endif
    @endforeach
</body>

</html>
