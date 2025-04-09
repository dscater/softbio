<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Evaluacions",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link, router } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount, computed } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
const props = defineProps({
    evaluacion: {
        type: Object,
        default: {
            user_id: 0,
            evaluacion_preguntas: [],
        },
    },
});
const loading = ref(false);
const listTemasPreguntas = ref(preguntas);
const nro_tema = ref(1);
const { setLoading } = useApp();
const evaluacion_preguntas = ref(props.evaluacion.evaluacion_preguntas);
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

// cargar respuestas obtenidas de la BD
const total_correctos = ref(0);
const cargarRespuestas = () => {
    loading.value = true;
    total_correctos.value = 0;
    evaluacion_preguntas.value.forEach((el) => {
        let elemento_txt = `opcion${el.tema}${el.pregunta}${el.opcion}`;
        const elemento = document.getElementById(elemento_txt);
        if (el.correcto == 1) {
            if (el.tema == nro_tema.value - 1) {
                total_correctos.value++;
            }
            elemento.classList.add("correcto");
        } else {
            elemento.classList.add("incorrecto");
        }
    });
    loading.value = false;
};

const cargarPorTema = () => {
    loading.value = true;
    total_correctos.value = 0;
    evaluacion_preguntas.value.forEach((el) => {
        if (el.tema == nro_tema.value - 1) {
            let elemento_txt = `opcion${el.tema}${el.pregunta}${el.opcion}`;
            // const elemento = document.getElementById(elemento_txt);
            if (el.correcto == 1) {
                total_correctos.value++;
            }
        }
    });
    loading.value = false;
};

// asignar respuesta al clickar sobre una opcion
const asignaPregunta = (tema, pregunta, opcion, correcto) => {
    const index = evaluacion_preguntas.value.findIndex((elem) => {
        return elem.tema === tema && elem.pregunta === pregunta;
    });

    if (index !== -1) {
        evaluacion_preguntas.value[index]["opcion"] = opcion;
        evaluacion_preguntas.value[index]["correcto"] = correcto;
        console.log("Elemento modificado:", evaluacion_preguntas.value[index]);
    } else {
        evaluacion_preguntas.value.push({
            id: 0,
            evaluacion_id: 0,
            tema: tema,
            pregunta: pregunta,
            opcion: opcion,
            correcto: correcto,
        });
        console.log("Nuevo elemento agregado:", {
            tema,
            pregunta,
            opcion,
            correcto,
        });
    }
};

const cambiaTema = (increment) => {
    total_correctos.value = 0;
    nro_tema.value = nro_tema.value + increment;
    cargarPorTema();
};

const getInciso = (index) => {
    const incisos = ["a", "b", "c", "d", "e", "f"];
    return incisos[index] + ")";
};

//porcentaje de porcentaje
const getPorcentajeTema = computed(() => {
    const total = listTemasPreguntas.value[nro_tema.value - 1]["p"].length;
    const p = (total_correctos.value / total) * 100;
    return Math.round(p, 2);
});

onMounted(() => {
    cargarRespuestas();
});
onBeforeUnmount(() => {});
</script>
<template>
    <Head title="Evaluación"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Evaluación</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Evaluación</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4 class="panel-title btn-nuevo"></h4>
                    <panel-toolbar :mostrar_loading="loading" />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <div
                        class="row"
                        v-for="(tp, index_tp) in listTemasPreguntas"
                        v-show="tp.nro == nro_tema"
                    >
                        <div class="col-12">
                            <h4 class="text-center">
                                {{ tp.t }}
                                <div class="puntaje">
                                    {{ getPorcentajeTema }}%
                                </div>
                            </h4>
                            <p>
                                <strong>Estudiante: </strong
                                >{{ props.evaluacion.user.full_name }}
                            </p>
                            <p>
                                <strong>Curso: </strong
                                >{{ props.evaluacion.user.curso.nombre }}
                            </p>
                        </div>
                        <div class="col-12 mb-3" v-for="(p, index_p) in tp.p">
                            <p class="font-weight-bold mb-1">
                                {{ p.nro }}) {{ p.e }}
                            </p>
                            <div class="row contenedor_opciones">
                                <div
                                    class="col-md-4"
                                    v-for="(o, index_o) in p.o"
                                >
                                    <p
                                        class="cont_opcion mb-2"
                                        :id="`opcion${index_tp}${index_p}${index_o}`"
                                    >
                                        <span
                                            v-text="getInciso(index_o)"
                                        ></span>
                                        {{ o }}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button
                                class="btn btn-default rounded-0"
                                :disabled="nro_tema == 1"
                                @click="cambiaTema(-1)"
                            >
                                <i class="fa fa-arrow-left"></i>
                            </button>
                            <button
                                class="btn btn-default rounded-0"
                                :disabled="
                                    nro_tema == listTemasPreguntas.length
                                "
                                @click="cambiaTema(1)"
                            >
                                <i class="fa fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <button
                                class="btn btn-default"
                                @click="router.get(route('evaluacions.index'))"
                            >
                                <i class="fa fa-arrow-left"></i> Volver
                            </button>
                        </div>
                    </div>
                </div>
                <!-- END panel-body -->
            </div>
            <!-- END panel -->
        </div>
    </div>
</template>
<style scoped>
.cont_opcion {
    padding: 4px;
    width: 100%;
}

.cont_opcion.correcto {
    background-color: rgb(153, 238, 153);
}
.cont_opcion.incorrecto {
    background-color: rgb(248, 147, 147);
}
</style>
