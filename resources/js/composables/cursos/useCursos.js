import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oCurso = ref({
    id: 0,
    nombre: "",
    _method: "POST",
});

export const useCursos = () => {
    const { flash } = usePage().props;
    const getCursos = async () => {
        try {
            const response = await axios.get(route("cursos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.cursos;
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

    const getCursosByTipo = async (data) => {
        try {
            const response = await axios.get(route("cursos.byTipo"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.cursos;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getCursosApi = async (data) => {
        try {
            const response = await axios.get(route("cursos.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.cursos;
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
    const saveCurso = async (data) => {
        try {
            const response = await axios.post(route("cursos.store", data), {
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

    const deleteCurso = async (id) => {
        try {
            const response = await axios.delete(route("cursos.destroy", id), {
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

    const setCurso = (item = null) => {
        if (item) {
            oCurso.value.id = item.id;
            oCurso.value.nombre = item.nombre;
            oCurso.value._method = "PUT";
            return oCurso;
        }
        return false;
    };

    const limpiarCurso = () => {
        oCurso.value.id = 0;
        oCurso.value.nombre = "";
        oCurso.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCurso,
        getCursos,
        getCursosApi,
        saveCurso,
        deleteCurso,
        setCurso,
        limpiarCurso,
        getCursosByTipo,
    };
};
