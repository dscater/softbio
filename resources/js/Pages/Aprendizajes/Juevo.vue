<script setup>
import { onMounted, ref, watch } from "vue";

const props = defineProps({
    estadoJuego: {
        type: Boolean,
        default: false,
    },
});

const urlassets = ref(url_assets);
const juegoIniciado = ref(props.estadoJuego);
let animacionComponent = null;
let animationFrameId = null;
let xBackground1 = 0;

watch(
    () => props.estadoJuego,
    (newVal) => {
        juegoIniciado.value = newVal;
        if (juegoIniciado.value && animacionComponent) {
            animacionComponent();
        } else if (!juegoIniciado.value && animationFrameId) {
            // Detiene la animación si el juego está inactivo
            cancelAnimationFrame(animationFrameId);
            animationFrameId = null;
        }
    }
);

onMounted(() => {
    const canvas = document.getElementById("canvas");
    canvas.width = window.innerWidth - 100;
    canvas.height = 400;
    const CANVAS_WIDTH = canvas.width;
    const CANVAS_HEIGHT = canvas.height;
    const contexto = canvas.getContext("2d");

    const background1 = new Image();
    background1.src = urlassets.value + "imgs/aprendizaje/plx1.png";
    const background2 = new Image();
    background2.src = urlassets.value + "imgs/aprendizaje/plx2.png";
    const background3 = new Image();
    background3.src = urlassets.value + "imgs/aprendizaje/plx3.png";
    const background4 = new Image();
    background4.src = urlassets.value + "imgs/aprendizaje/plx4.png";
    const background5 = new Image();
    background5.src = urlassets.value + "imgs/aprendizaje/plx5.png";
    const background6 = new Image();
    background6.src = urlassets.value + "imgs/aprendizaje/jungletileset.png";

    const animacion = () => {
        contexto.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);

        // Obtiene el ancho de la imagen de fondo
        const bgWidth = background1.width;
        // Calcula cuántas veces es necesario dibujar la imagen para llenar el ancho del lienzo
        const nroFrames = Math.ceil(CANVAS_WIDTH / bgWidth) + 1;
        // Dibuja la imagen repetidamente para cubrir el lienzo completo
        for (let i = 0; i < nroFrames; i++) {
            contexto.drawImage(background1, xBackground1 + i * bgWidth, 0);
            contexto.drawImage(background2, xBackground1 + i * bgWidth, 0);
            contexto.drawImage(background3, xBackground1 + i * bgWidth, 0);
            contexto.drawImage(background4, xBackground1 + i * bgWidth, 0);
            contexto.drawImage(background5, xBackground1 + i * bgWidth, 0);
        }
        // dibujar el piso
        const nroFramesPiso = Math.ceil(CANVAS_WIDTH / 80) + 1;
        for (let i = 0; i < nroFramesPiso; i++) {
            contexto.drawImage(
                background6,
                0,
                200,
                80,
                50,
                i * 80 - 20,
                150,
                100,
                120
            );
        }

        // dibujar

        // Actualiza la posición del fondo para el efecto de desplazamiento
        xBackground1 -= 1;
        // Si el fondo se ha desplazado completamente reiniciar la posición
        if (xBackground1 <= -bgWidth) {
            xBackground1 = 0;
        }

        animationFrameId = requestAnimationFrame(animacion);
    };

    animacionComponent = animacion;

    if (juegoIniciado.value) {
        animacion();
    }
});

const iniciaJuego = () => {
    document.addEventListener("load", () => {});
};
</script>
<template>
    <h4>JUEGO</h4>
    <canvas id="canvas"></canvas>
    <!-- <img :src="urlassets + 'imgs/aprendizaje/plx1.png'" alt="" /> -->
</template>

<style>
canvas {
    position: absolute;
    top: 140px;
    left: 50%;
    transform: translate(-50%, -60px);
}
</style>
