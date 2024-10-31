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
import { Head, Link } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount } from "vue";
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
const cargarRespuestas = () => {
    loading.value = true;
    evaluacion_preguntas.value.forEach((el) => {
        let elemento_txt = `opcion${el.tema}${el.pregunta}${el.opcion}`;
        const elemento = document.getElementById(elemento_txt);
        if (el.correcto == 1) {
            elemento.classList.add("correcto");
        } else {
            elemento.classList.add("incorrecto");
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
    nro_tema.value = nro_tema.value + increment;
};

const getInciso = (index) => {
    const incisos = ["a", "b", "c", "d", "e", "f"];
    return incisos[index] + ")";
};

// verificacion de respuestas
const verificaRespuesta = (index_t, index_p, index_o, element) => {
    const elemento = document.getElementById(element);
    elemento.classList.remove("correcto");
    elemento.classList.remove("incorrecto");

    const contenedor_opciones = elemento.closest(".contenedor_opciones");
    const opciones = contenedor_opciones.querySelectorAll(".cont_opcion");
    opciones.forEach((elem) => {
        elem.classList.remove("correcto");
        elem.classList.remove("incorrecto");
    });

    const pregunta = listTemasPreguntas.value[index_t]["p"][index_p];
    let correcto = 0;
    if (index_o === pregunta.r) {
        elemento.classList.add("correcto");
        correcto = 1;
    } else {
        elemento.classList.add("incorrecto");
    }
    asignaPregunta(index_t, index_p, index_o, correcto);
};

// guardar array de respuestas
const guardarCambios = () => {
    loading.value = true;
    axios
        .post(route("evaluacions.update", props.evaluacion.id), {
            evaluacion_preguntas: evaluacion_preguntas.value,
            _method: "put",
        })
        .then((response) => {
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `Registro actualizado correctamente`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            loading.value = false;
        });
};

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
                            <h4 class="text-center">{{ tp.t }}</h4>
                        </div>
                        <small class="mb-2"
                            >Selecciona la respuesta correcta</small
                        >
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
                                        @click="
                                            verificaRespuesta(
                                                index_tp,
                                                index_p,
                                                index_o,
                                                `opcion${index_tp}${index_p}${index_o}`
                                            )
                                        "
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
                                class="btn btn-primary"
                                @click="guardarCambios"
                                :disabled="loading"
                            >
                                <i class="fa fa-save"></i> Guardar cambios
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
    cursor: pointer;
}
.cont_opcion:hover {
    background-color: rgb(223, 219, 219);
}

.cont_opcion.correcto {
    background-color: rgb(153, 238, 153);
}
.cont_opcion.incorrecto {
    background-color: rgb(248, 147, 147);
}
</style>
