<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Lista de Estudiantes",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>

<script setup>
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { Head, usePage } from "@inertiajs/vue3";
import Highcharts from "highcharts";
import exporting from "highcharts/modules/exporting";

exporting(Highcharts);
Highcharts.setOptions({
    lang: {
        downloadPNG: "Descargar PNG",
        downloadJPEG: "Descargar JPEG",
        downloadPDF: "Descargar PDF",
        downloadSVG: "Descargar SVG",
        printChart: "Imprimir gráfico",
        contextButtonTitle: "Menú de exportación",
        viewFullscreen: "Pantalla completa",
        exitFullscreen: "Salir de pantalla completa",
    },
});
const { setLoading } = useApp();

const cargarListas = () => {};

onMounted(() => {
    cargarListas();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const form = ref({
    tipo: "todos",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte Pdf";
});
const txtBtn2 = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte Gráfico";
});

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_aprendizajes", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

const generarReporte2 = () => {
    generando.value = true;
    axios.get(route("reportes.rg_aprendizajes")).then((response) => {
        // Create the chart
        Highcharts.chart("container", {
            chart: {
                type: "column",
            },
            title: {
                align: "center",
                text: "Ranking de juego",
            },
            subtitle: {
                align: "left",
                text: "",
            },
            accessibility: {
                announceNewData: {
                    enabled: true,
                },
            },
            xAxis: {
                type: "category",
            },
            yAxis: {
                title: {
                    text: "Total Pts.",
                },
            },
            legend: {
                enabled: true,
            },
            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true,
                    },
                },
            },

            series: [
                {
                    name: "Usuario",
                    data: response.data.data,
                    colorByPoint: true,
                },
            ],
        });
        generando.value = false;
    });
};
</script>
<template>
    <Head title="Reporte Lista de Estudiantes"></Head>
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Reportes > Lista de Estudiantes</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Reportes > Lista de Estudiantes</h1>
    <!-- END page-header -->
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card">
                <div class="card-body">
                    <form @submit.prevent="generarReporte">
                        <div class="row">
                            <div class="col-md-12 text-center mt-3">
                                <button
                                    class="btn btn-primary"
                                    block
                                    @click="generarReporte"
                                    :disabled="generando"
                                    v-text="txtBtn"
                                ></button
                                ><br />
                                <button
                                    class="btn btn-info mt-3"
                                    block
                                    @click="generarReporte2"
                                    :disabled="generando"
                                    v-text="txtBtn2"
                                ></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-12" id="container"></div>
    </div>
</template>
