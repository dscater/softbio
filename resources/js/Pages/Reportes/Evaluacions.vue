<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Evaluación",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>

<script setup>
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { useCursos } from "@/composables/cursos/useCursos";
import { useUsuarios } from "@/composables/usuarios/useUsuarios";
import { Head, usePage } from "@inertiajs/vue3";
const { props: props_page } = usePage();
const user = ref(props_page.auth?.user);
const { setLoading } = useApp();
const { getCursos } = useCursos();
const { getUsuariosByTipo } = useUsuarios();

const listCursos = ref([]);
const listEstudiantes = ref([]);

const cargarListas = () => {
    cargarCursos();
    cargarEstudiantes();
};

const cargarEstudiantes = async () => {
    listEstudiantes.value = await getUsuariosByTipo({ tipo: "ESTUDIANTE" });
    listEstudiantes.value.unshift({
        id: "todos",
        full_name: "TODOS",
    });
};

const cargarCursos = async () => {
    listCursos.value = await getCursos();
    listCursos.value.unshift({
        id: "todos",
        nombre: "TODOS",
    });
};

onMounted(() => {
    cargarListas();
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const form = ref({
    user_id: "todos",
    curso_id: user.value.tipo == "PROFESOR" ? user.value.curso_id : "todos",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_evaluacions", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};
</script>
<template>
    <Head title="Reporte Evaluación"></Head>
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Reportes > Evaluación</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Reportes > Evaluación</h1>
    <!-- END page-header -->
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card">
                <div class="card-body">
                    <form @submit.prevent="generarReporte">
                        <div class="row">
                            <div class="col-md-12">
                                <label>Seleccionar estudiante*</label>
                                <select
                                    :hide-details="
                                        form.errors?.user_id ? false : true
                                    "
                                    :error="form.errors?.user_id ? true : false"
                                    :error-messages="
                                        form.errors?.user_id
                                            ? form.errors?.user_id
                                            : ''
                                    "
                                    v-model="form.user_id"
                                    class="form-control"
                                >
                                    <option
                                        v-for="item in listEstudiantes"
                                        :value="item.id"
                                    >
                                        {{ item.full_name }}
                                    </option>
                                </select>
                            </div>
                            <div
                                class="col-md-12"
                                v-if="user.tipo != 'PROFESOR'"
                            >
                                <label>Seleccionar curso*</label>
                                <select
                                    :hide-details="
                                        form.errors?.curso_id ? false : true
                                    "
                                    :error="
                                        form.errors?.curso_id ? true : false
                                    "
                                    :error-messages="
                                        form.errors?.curso_id
                                            ? form.errors?.curso_id
                                            : ''
                                    "
                                    v-model="form.curso_id"
                                    class="form-control"
                                >
                                    <option
                                        v-for="item in listCursos"
                                        :value="item.id"
                                    >
                                        {{ item.nombre }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-md-12 text-center mt-3">
                                <button
                                    class="btn btn-primary"
                                    block
                                    @click="generarReporte"
                                    :disabled="generando"
                                    v-text="txtBtn"
                                ></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
