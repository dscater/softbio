<script setup>
import AprendizajeLayout from "@/Layouts/Aprendizaje.vue";
defineOptions({ layout: AprendizajeLayout });
import { useApp } from "@/composables/useApp";
import { Head, Link } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeUnmount } from "vue";

const listAprendizajes = ref([]);
const loading = ref(false);
const jugando = ref(false);
const puntaje = ref(0);

const iniciarJuego = () => {
    jugando.value = true;
};

const cargarListas = () => {
    cargaListAprendizajes();
};

const cargaListAprendizajes = () => {
    axios.get(route("aprendizajes.mejores")).then((response) => {
        listAprendizajes.value = response.data.aprendizajes;
    });
};

onMounted(() => {
    cargarListas();
});
onBeforeUnmount(() => {});
</script>
<template>
    <div class="container-fluid contenedor_juego">
        <div class="row">
            <div class="col-12" v-show="!jugando">
                <div class="listado_aprendizajes col-md-6 mx-auto text-center">
                    <h4 class="text-center font-weight-bold">
                        Mejores puntajes
                    </h4>
                    <template v-if="listAprendizajes.length > 0">
                        <div
                            class="elem_listado"
                            v-for="(item, index) in listAprendizajes"
                        >
                            {{ index + 1 }}){{ item.user.full_name }}
                        </div>
                    </template>
                    <template v-else>
                        <span class="vacio">Sin registros...</span>
                    </template>
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
                <div class="contenedor_animacion"></div>
                <div class="contenedor_preguntas"></div>
                <a :href="route('inicio')" class="boton btn-volver">
                    <i class="fa fa-arrow-left"></i> Volver
                </a>
            </div>
        </div>
    </div>
</template>

<style scoped>
.contenedor_juego {
    min-height: 100vh;
    background: rgb(75, 75, 73);
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
    position: fixed;
    left: 20px;
    bottom: 20px;
}

.contenedor_animacion {
    background-color: black;
    width: 100%;
    min-height: 400px;
}
.contenedor_preguntas {
    background-color: green;
    min-height: 200px;
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

.bg-verde:hover {
    background-color: rgb(79, 241, 38);
}
</style>
