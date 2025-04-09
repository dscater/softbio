<script setup>
import AprendizajeLayout from "@/Layouts/Aprendizaje.vue";
defineOptions({ layout: AprendizajeLayout });
import { useApp } from "@/composables/useApp";
import { Head, Link } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount } from "vue";
import Juego from "@/Pages/Aprendizajes/Juevo.vue";

if (!audioFondo.played) {
    audioFondo.play();
} else {
    audioFondo.currentTime = 0;
    audioFondo.play();
}
audioFondo.loop = true;

const urlassets = ref(url_assets);
const listAprendizajes = ref([]);
const urlasset = ref(url_assets);
const loading = ref(false);
const jugando = ref(false);
const puntaje = ref(0);
const tiempoPorPregunta = ref(60);
const tiempoPregunta = ref(tiempoPorPregunta.value);
const puntajePorPregunta = ref(5);
const aumentaPuntajeCada = ref(10);
const loadingPregunta = ref(false);
const swRespCorrecta = ref(null);
const contPreguntasRespondidas = ref(0);
const listPreguntas = ref(preguntas.flatMap((tema) => tema.p));
const indexPreguntaActual = ref(0);
const preguntaActual = ref(listPreguntas.value[indexPreguntaActual.value]);
const intervalTiempoJuego = ref(null);
const etapaJuego = ref(1);
const iniciarJuego = () => {
    jugando.value = true;
    conteoDeTiempo();
};

const modalFinalizar = ref(false);

const conteoDeTiempo = () => {
    intervalTiempoJuego.value = setInterval(() => {
        tiempoPregunta.value--;
        if (tiempoPregunta.value < 0) {
            tiempoPregunta.value = tiempoPorPregunta.value;
            actualizaPregunta();
        }
    }, 1000);
};

const finalizaConteo = () => {
    clearInterval(intervalTiempoJuego.value);
};

const cargarListas = () => {
    cargaListAprendizajes();
};

const cargaListAprendizajes = () => {
    axios.get(route("aprendizajes.mejores")).then((response) => {
        listAprendizajes.value = response.data.aprendizajes;
    });
};

var audioerror = new Audio();
audioerror.src = urlassets.value + "sounds/error.mp3";

// JUEGO
const verificaOpcion = (index_opcion) => {
    if (preguntaActual.value.r === index_opcion) {
        console.log("Correcto");
        puntaje.value += parseInt(puntajePorPregunta.value);
        swRespCorrecta.value = true;
    } else {
        swRespCorrecta.value = false;
        loadingPregunta.value = false;
        console.log("Incorrecto");
        if (!audioerror.played) {
            audioerror.play();
        } else {
            audioerror.currentTime = 0;
            audioerror.play();
        }
    }
    contPreguntasRespondidas.value++;
    // verificar total preguntas para aumentar el puntaje
    if (contPreguntasRespondidas.value === aumentaPuntajeCada.value) {
        puntajePorPregunta.value += parseInt(5);
        contPreguntasRespondidas.value = 0;
    }
    actualizaPregunta();
};
const mitad_preguntas = ref(Math.round(listPreguntas.value.length / 2, 0));

const reiniciaSwRespuesta = () => {
    swRespCorrecta.value = false;
    loadingPregunta.value = false;
    if (indexPreguntaActual.value > mitad_preguntas.value) {
        // if (indexPreguntaActual.value > 0) {
        etapaJuego.value = 2;
    }
};

const actualizaPregunta = () => {
    loadingPregunta.value = true;
    if (!swRespCorrecta.value) {
        loadingPregunta.value = false;
    }

    if (indexPreguntaActual.value > mitad_preguntas.value) {
        // if (indexPreguntaActual.value > 0) {
        etapaJuego.value = 2;
    }

    indexPreguntaActual.value++;

    if (!listPreguntas.value[indexPreguntaActual.value]) {
        console.log("Termina el juego");
        finalizarJuego();
    }

    finalizaConteo();
    reiniciaTiempoPregunta();
    conteoDeTiempo();
    preguntaActual.value = listPreguntas.value[indexPreguntaActual.value];
};

const reiniciaTiempoPregunta = () => {
    tiempoPregunta.value = tiempoPorPregunta.value;
};

const getInciso = (index) => {
    const incisos = ["a", "b", "c", "d", "e", "f"];
    return incisos[index] + ")";
};

const volverInicio = () => {
    modalFinalizar.value = false;
    jugando.value = false;
    reiniciaJuego();
    cargarListas();
};

const reiniciaJuego = () => {
    puntaje.value = 0;
    tiempoPregunta.value = tiempoPorPregunta.value;
    puntajePorPregunta.value = 5;
    indexPreguntaActual.value = 0;
    preguntaActual.value = listPreguntas.value[indexPreguntaActual.value];
    contPreguntasRespondidas.value = 0;
    finalizaConteo();
};

const finalizarJuego = () => {
    finalizaConteo();
    axios
        .post(route("aprendizajes.store"), {
            puntaje: puntaje.value,
        })
        .then((response) => {
            modalFinalizar.value = true;
            console.log("finaliza");
        })
        .catch((error) => {
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `Ocurrió un error inesperado por lo que no se pudo guardar el puntaje`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        });
};

// FIN JUEGO

onMounted(() => {
    cargarListas();
});
onBeforeUnmount(() => {});
</script>
<template>
    <div
        class="container-fluid contenedor_juego"
        :style="{
            backgroundImage: 'url(' + urlassets + 'imgs/fondoAprendizaje.jpg)',
        }"
    >
        <div class="row">
            <div class="col-12" v-show="!jugando">
                <div class="listado_aprendizajes col-md-6 mx-auto text-center">
                    <h3 class="text-center font-weight-bold">
                        Mejores puntajes
                    </h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th class="text-white">N°</th>
                                <th class="text-white">Nombre</th>
                                <th class="text-white">Curso</th>
                                <th class="text-white">Puntaje</th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-if="listAprendizajes.length > 0">
                                <tr
                                    class="elem_listado"
                                    v-for="(item, index) in listAprendizajes"
                                >
                                    <td class="text-white">{{ index + 1 }})</td>
                                    <td class="text-white">
                                        {{ item.user.full_name }}
                                    </td>
                                    <td class="text-white">
                                        {{ item.user.curso.nombre }}
                                    </td>
                                    <td class="text-white">
                                        {{ item.puntaje }}
                                    </td>
                                </tr>
                            </template>
                            <template v-else>
                                <tr>
                                    <td class="vacio text-white" colspan="4">
                                        Sin registros...
                                    </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6 mx-auto pt-1">
                    <button
                        class="boton btn-opcion bg-verde"
                        @click="iniciarJuego"
                    >
                        <i class="fa fa-gamepad"></i> Jugar
                    </button>
                    <a :href="route('inicio')" class="boton btn-opcion">
                        <i class="fa fa-arrow-left"></i> Volver
                    </a>
                </div>
            </div>
            <div class="col-12" v-show="jugando">
                <div class="contenedor_animacion">
                    <div class="puntaje_juego bg-tablero">
                        <div class="txt-tablero">Puntaje:</div>
                        <span
                            class="txt_puntaje txt-tablero"
                            v-text="puntaje"
                        ></span>
                    </div>
                    <div class="temporizador bg-tablero">
                        <img
                            class="img_temporizador"
                            :src="
                                urlasset + 'imgs/aprendizaje/temporizador.png'
                            "
                            alt="Tiempo"
                        />
                        <span
                            class="txt_temporizador txt-tablero"
                            v-text="tiempoPregunta"
                        ></span>
                    </div>
                    <Juego
                        :estadoJuego="jugando"
                        :puntajeActual="puntajePorPregunta"
                        :respCorrecta="swRespCorrecta"
                        :etapaJuego="etapaJuego"
                        @actualizaEstadoRespuesta="reiniciaSwRespuesta"
                    ></Juego>
                </div>
                <div class="contenedor_preguntas">
                    <div class="loading_pregunta" v-show="loadingPregunta">
                        <i class="fa fa-spinner fa-spin"></i>
                    </div>
                    <div class="row pb-5" v-if="preguntaActual">
                        <div class="col-12">
                            <div class="pregunta">
                                <p class="enunciado">
                                    {{ indexPreguntaActual + 1 }})
                                    {{ preguntaActual.e }}
                                </p>
                                <div class="row">
                                    <div
                                        class="col-md-3 opcion"
                                        v-for="(
                                            item_o, index_o
                                        ) in preguntaActual.o"
                                        @click="verificaOpcion(index_o)"
                                    >
                                        <span
                                            v-text="getInciso(index_o)"
                                        ></span>
                                        {{ item_o }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button class="boton btn-volver" @click="volverInicio">
                        <i class="fa fa-arrow-left"></i> Volver
                    </button>
                    <button
                        class="boton btn-finalizar bg-rojo"
                        @click="finalizarJuego"
                    >
                        <i class="fa fa-flag"></i> Finalizar
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div
        class="modal fade"
        :class="{
            show: modalFinalizar,
        }"
        id="modal-dialog-finalizar"
        :style="{
            display: modalFinalizar ? 'block' : 'none',
        }"
    >
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title">Juego finalizado</h4>
                    <button
                        type="button"
                        class="btn-close"
                        @click="volverInicio()"
                    ></button>
                </div>
                <div class="modal-body bg-primary">
                    <div class="row">
                        <div class="col-12">
                            <p class="txtPuntajeFinal text-white">
                                <strong>Puntaje obtenido: </strong>{{ puntaje }}
                            </p>
                        </div>
                        <div class="col-12">
                            <button
                                type="button"
                                class="btn btn-warning bg-secundario w-100"
                                @click="volverInicio()"
                            >
                                Aceptar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.contenedor_juego {
    min-height: 100vh;
    /* background: rgb(75, 75, 73); */
    background-size: cover;
}

.boton {
    padding: 10px;
    border-radius: 15px;
    font-weight: bold;
    background-color: white;
    color: black;
    border: solid 2px black;
}

.btn-opcion {
    text-align: center;
    display: block;
    width: 100%;
}

.bg-tablero {
    background-color: #864a04;
    color: white;
}
.txt-tablero {
    font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
    z-index: 100;
    font-weight: bold;
    font-size: 1.8em;
}

.puntaje_juego {
    position: absolute;
    padding: 5px;
    left: 0px;
    top: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    border-right: double 3px #ffbb00;
    border-bottom: double 3px #ffbb00;
}

.temporizador {
    position: absolute;
    padding: 5px;
    padding-right: 15px;
    right: 0px;
    top: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-left: double 3px #ffbb00;
    border-bottom: double 3px #ffbb00;
}

.img_temporizador {
    width: 40px;
}

.txt_temporizador {
    text-align: center;
    width: 20px;
}

.txt_temporizador.red {
    color: red;
}

/* INICIO */
.listado_aprendizajes {
    margin-top: 20px;
    color: white;
    padding: 20px;
    background-color: rgb(4, 105, 163);
    border: solid px blue;
    border-radius: 10px;
}

/* JUEGO */
.btn-volver {
    position: absolute;
    left: 20px;
    bottom: 20px;
}
.btn-finalizar {
    position: absolute;
    right: 20px;
    bottom: 20px;
}

.contenedor_animacion {
    position: relative;
    background-color: rgb(8, 8, 8);
    width: 100%;
    min-height: 400px;
}
.contenedor_preguntas {
    position: relative;
    background-color: rgb(2, 14, 2);
    min-height: 200px;
}

.loading_pregunta {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.603);
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    padding-bottom: 80px;
}

.pregunta {
    border-radius: solid 2px brown;
    padding: 20px;
}

.enunciado {
    font-weight: bold;
}

.enunciado,
.opcion {
    font-size: 1.5em;
    color: white;
}

.opcion:hover {
    color: coral;
    cursor: pointer;
}

a.boton {
    text-decoration: none;
}

.boton:hover {
    cursor: pointer;
}

.bg-verde {
    color: black;
    background-color: rgb(72, 253, 17);
    border: solid 3px rgb(2, 131, 34);
}

.bg-rojo {
    color: rgb(243, 243, 243);
    background-color: rgb(240, 60, 6);
    border: solid 3px rgb(231, 1, 1);
}

.bg-rojo:hover {
    background-color: rgb(218, 55, 5);
}

.bg-verde:hover {
    background-color: rgb(79, 241, 38);
}

#modal-dialog-finalizar {
    background-color: rgba(0, 0, 0, 0.753);
}

.txtPuntajeFinal {
    text-align: center;
    font-size: 2em;
    font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
}
</style>
