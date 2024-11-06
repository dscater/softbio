<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useMaterials } from "@/composables/materials/useMaterials";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
import MiDropZone from "@/Components/MiDropZone.vue";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oMaterial, limpiarMaterial } = useMaterials();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const listMaterias = ref([]);
let form = useForm(oMaterial);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            form.material_archivos = oMaterial.material_archivos;
            cargarListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oMaterial);
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `<i class="fa fa-plus"></i> Ver material`
        : `<i class="fa fa-edit"></i> Ver material`;
});

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const cargarListas = () => {
    cargarMaterias();
};

const cargarMaterias = () => {
    axios.get(route("materias.listado")).then((response) => {
        listMaterias.value = response.data.materias;
    });
};

const detectaArchivos = (files, nro_etapa, nro_nombre) => {
    form.material_archivos = files;
};

const detectaEliminados = (eliminados, nro_etapa, nro_nombre) => {
    form.eliminados = eliminados;
};

onMounted(() => {});
</script>

<template>
    <div
        class="modal fade"
        :class="{
            show: dialog,
        }"
        id="modal-dialog-form"
        :style="{
            display: dialog ? 'block' : 'none',
        }"
    >
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title" v-html="tituloDialog"></h4>
                    <button
                        type="button"
                        class="btn-close"
                        @click="cerrarDialog()"
                    ></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div
                            class="col-md-3 mt-3 text-center"
                            v-for="item in form.material_archivos"
                        >
                            <div class="border p-3">
                                <img :src="item.thumb" alt="" />
                                <br />
                                {{ item.archivo }}
                                <a
                                    :href="item.url_archivo"
                                    target="_blank"
                                    class="btn btn-outline-primary btn-block w-100 mt-1 btn-sm"
                                    >Descargar <i class="fa fa-download"></i
                                ></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a
                        href="javascript:;"
                        class="btn btn-white"
                        @click="cerrarDialog()"
                        ><i class="fa fa-times"></i> Cerrar</a
                    >
                </div>
            </div>
        </div>
    </div>
</template>
