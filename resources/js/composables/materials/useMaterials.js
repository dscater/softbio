import axios from "axios";
import { onMounted, reactive } from "vue";
import { usePage } from "@inertiajs/vue3";

const oMaterial = reactive({
    id: 0,
    materia_id: "",
    material_archivos: [],
    eliminados: [],
    _method: "POST",
});

export const useMaterials = () => {
    const { flash } = usePage().props;
    const getMaterials = async () => {
        try {
            const response = await axios.get(route("materials.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.materials;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getMaterialsByTipo = async (data) => {
        try {
            const response = await axios.get(route("materials.byTipo"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.materials;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getMaterialsApi = async (data) => {
        try {
            const response = await axios.get(
                route("materials.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.materials;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const saveMaterial = async (data) => {
        try {
            const response = await axios.post(route("materials.store", data), {
                headers: { Accept: "application/json" },
            });
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const deleteMaterial = async (id) => {
        try {
            const response = await axios.delete(
                route("materials.destroy", id),
                {
                    headers: { Accept: "application/json" },
                }
            );
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const setMaterial = (item = null) => {
        if (item) {
            oMaterial.id = item.id;
            oMaterial.materia_id = item.materia_id;
            oMaterial.material_archivos = [...item.material_archivos];
            oMaterial._method = "PUT";
            return oMaterial;
        }
        return false;
    };

    const limpiarMaterial = () => {
        oMaterial.id = 0;
        oMaterial.materia_id = "";
        oMaterial.material_archivos = [];
        oMaterial.eliminados = [];
        oMaterial._method = "POST";
    };

    onMounted(() => {});

    return {
        oMaterial,
        getMaterials,
        getMaterialsApi,
        saveMaterial,
        deleteMaterial,
        setMaterial,
        limpiarMaterial,
        getMaterialsByTipo,
    };
};
