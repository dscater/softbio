<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Materials",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useMaterials } from "@/composables/materials/useMaterials";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
// import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
import Ver from "./Ver.vue";
// const { mobile, identificaDispositivo } = useMenu();
const { props: props_page } = usePage();
const user = ref(props_page.auth?.user);
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getMaterials, setMaterial, limpiarMaterial, deleteMaterial } =
    useMaterials();

const columns = [
    {
        title: "",
        data: "id",
    },
    {
        title: "MATERIA",
        data: null,
        render: function (data, type, row) {
            return row.materia.nombre;
        },
    },
    {
        title: "ACCIONES",
        data: null,
        render: function (data, type, row) {
            let buttons = `<button class="mx-0 rounded-0 btn btn-info ver" data-id="${row.id}"><i class="fa fa-eye"></i></button> `;
            if (user.value.permisos.includes("materials.edit")) {
                buttons += `<button class="mx-0 rounded-0 btn btn-warning editar" data-id="${row.id}"><i class="fa fa-edit"></i></button>`;
            }
            if (user.value.permisos.includes("materials.destroy")) {
                buttons += `  <button class="mx-0 rounded-0 btn btn-danger eliminar"
                 data-id="${row.id}" 
                 data-nombre="${row.materia.nombre}" 
                 data-url="${route(
                     "materials.destroy",
                     row.id
                 )}"><i class="fa fa-trash"></i></button>`;
            }
            return buttons;
        },
    },
];
const loading = ref(false);
const accion_dialog = ref(0);
const open_dialog = ref(false);
const accion_dialog_ver = ref(0);
const open_dialog_ver = ref(false);

const agregarRegistro = () => {
    limpiarMaterial();
    accion_dialog.value = 0;
    open_dialog.value = true;
};

const accionesRow = () => {
    // ver
    $("#table-material").on("click", "button.ver", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        axios.get(route("materials.show", id)).then((response) => {
            setMaterial(response.data);
            accion_dialog_ver.value = 1;
            open_dialog_ver.value = true;
        });
    });
    // editar
    $("#table-material").on("click", "button.editar", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        axios.get(route("materials.show", id)).then((response) => {
            setMaterial(response.data);
            accion_dialog.value = 1;
            open_dialog.value = true;
        });
    });
    // eliminar
    $("#table-material").on("click", "button.eliminar", function (e) {
        e.preventDefault();
        let nombre = $(this).attr("data-nombre");
        let id = $(this).attr("data-id");
        Swal.fire({
            title: "¿Quierés eliminar este registro?",
            html: `<strong>${nombre}</strong>`,
            showCancelButton: true,
            confirmButtonColor: "#B61431",
            confirmButtonText: "Si, eliminar",
            cancelButtonText: "No, cancelar",
            denyButtonText: `No, cancelar`,
        }).then(async (result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                let respuesta = await deleteMaterial(id);
                if (respuesta && respuesta.sw) {
                    updateDatatable();
                }
            }
        });
    });
};

var datatable = null;
const datatableInitialized = ref(false);
const updateDatatable = () => {
    datatable.ajax.reload();
};

onMounted(async () => {
    datatable = initDataTable(
        "#table-material",
        columns,
        route("materials.api")
    );
    datatableInitialized.value = true;
    accionesRow();
});
onBeforeUnmount(() => {
    if (datatable) {
        datatable.clear();
        datatable.destroy(false); // Destruye la instancia del DataTable
        datatable = null;
        datatableInitialized.value = false;
    }
});
</script>
<template>
    <Head title="Materiales de Apoyo"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Materiales de Apoyo</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Materiales de Apoyo</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4 class="panel-title btn-nuevo">
                        <button
                            v-if="user.permisos.includes('materials.create')"
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nuevo
                        </button>
                    </h4>
                    <panel-toolbar
                        :mostrar_loading="loading"
                        @loading="updateDatatable"
                    />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <table
                        id="table-material"
                        width="100%"
                        class="table table-striped table-bordered align-middle text-nowrap tabla_datos"
                    >
                        <thead>
                            <tr>
                                <th width="5%"></th>
                                <th></th>
                                <th width="5%"></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <!-- END panel-body -->
            </div>
            <!-- END panel -->
        </div>
    </div>

    <Formulario
        :open_dialog="open_dialog"
        :accion_dialog="accion_dialog"
        @envio-formulario="updateDatatable"
        @cerrar-dialog="open_dialog = false"
    ></Formulario>
    <Ver
        :open_dialog="open_dialog_ver"
        :accion_dialog="accion_dialog_ver"
        @envio-formulario=""
        @cerrar-dialog="open_dialog_ver = false"
    ></Ver>
</template>
