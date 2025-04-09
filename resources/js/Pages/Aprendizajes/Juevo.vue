<script setup>
import { onMounted, ref, watch } from "vue";

const props = defineProps({
    estadoJuego: {
        type: Boolean,
        default: false,
    },
    puntajeActual: {
        type: Number,
        default: 0,
    },
    respCorrecta: {
        type: Boolean,
        default: false,
    },
    etapaJuego: {
        type: Number,
        default: 1,
    },
});

const urlassets = ref(url_assets);
const juegoIniciado = ref(props.estadoJuego);
const valorPuntaje = ref(props.puntajeActual);
const estadoRespuesta = ref(props.respCorrecta);
const valEtapaJuego = ref(props.etapaJuego);
const muestra_etapa2 = ref(false);
let animacionComponent = null;
let animationFrameId = null;
let xBackground1 = 0;
let xBackground2 = 0;
var speedBackground1 = 1;
var speedBackground2 = 1;
var audioCorrecto = new Audio();
audioCorrecto.src = urlassets.value + "sounds/Rise03.mp3";

const personaje = new Image();
personaje.src = urlassets.value + "imgs/aprendizaje/idle.gif";

// Definimos las propiedades de la moneda
const moneda = {
    x: 0,
    y: 150,
    radius: 20,
    color: "gold",
    backgroundColor: "yellow",
    borderColor: "darkgoldenrod",
    puntos: valorPuntaje.value,
    animando: false, // Si la moneda está animando o no
    scale: 1, // Escala de la animación
    rotation: 0, // Rotación para animación
    speed: 1,
    xPosicionInicial: 0,
    yPosicionInicial: 0,
    actualizarEstilo: function () {
        // Cambiar el tamaño de la moneda en función de los puntos
        let nuevo_radio = 20 + Math.floor(this.puntos / 5);
        if (nuevo_radio < 30) {
            this.radius = nuevo_radio; // Aumentar el tamaño de la moneda conforme crece el puntaje
        }

        // Cambiar el color de la moneda de amarillo a rojo
        // El rojo aumenta con los puntos
        const red = 255; // Aumentar el rojo conforme suben los puntos
        // El verde se mantiene en un valor bajo para evitar el verde
        // const green = Math.min(230, Math.floor((this.puntos / 5) * 30)); // El verde empieza a disminuir a medida que sube el rojo, pero sin llegar a cero
        let green = parseInt(200 - this.puntos * 3); // El verde empieza a disminuir a medida que sube el rojo, pero sin llegar a cero
        if (green < 0) {
            green = 1;
        }
        // El azul se mantiene en cero para evitar tonos fríos
        const blue = 0;

        // Usar estos valores para el color de fondo
        this.backgroundColor = `rgb(${red},${green},${blue})`;
    },
    setEjeX: function (x) {
        this.x = x;
    },
    posicionInicial: function (cw) {
        this.x = cw / 1.69;
        this.y = 150;
        this.xPosicionInicial = this.x;
        this.yPosicionInicial = this.y;
    },
    dibujar: function (ctx, wc) {
        this.actualizarEstilo();
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.scale(this.scale, this.scale); // Escala para la animación
        ctx.rotate(this.rotation); // Rotación para la animación

        // Crear el borde de la moneda
        ctx.beginPath();
        ctx.arc(0, 0, this.radius, 0, Math.PI * 2);
        ctx.fillStyle = this.color;
        ctx.fill();
        ctx.lineWidth = 4;
        ctx.strokeStyle = this.borderColor;
        ctx.stroke();

        // Sombras para darle profundidad
        ctx.shadowColor = "rgba(0, 0, 0, 0.5)";
        ctx.shadowBlur = 10;
        ctx.shadowOffsetX = 5;
        ctx.shadowOffsetY = 5;

        // Crear la parte interna de la moneda (un efecto de profundidad)
        ctx.beginPath();
        ctx.arc(0, 0, this.radius - 4, 0, Math.PI * 2);
        ctx.fillStyle = this.backgroundColor;
        ctx.fill();

        ctx.restore();

        // Mostrar puntos en la moneda
        ctx.fillStyle = "rgba(225,255,225,1)";
        ctx.font = "16px Arial";
        ctx.textAlign = "center";
        ctx.textBaseline = "middle";
        ctx.fillText(`+${this.puntos}`, this.x, this.y);
    },
    animar: function (cw) {
        if (this.animando) {
            this.scale = 1.3; // Aumenta el tamaño durante la animación
            this.rotation += Math.PI / 20; // Rotación durante la animación
            setTimeout(() => {
                this.animando = false;
                this.scale = 1; // Vuelve a la escala original
                this.rotation = 0; // Restablecer la rotación
                this.x = this.xPosicionInicial;
                this.y = this.yPosicionInicial;
            }, 500);
        }
    },
};

const valla = {
    x: 0,
    y: 150,
    width: 30,
    height: 60,
    color: "saddlebrown",
    velocidad: 3,
    visible: true,
    xPosicionInicial: 0,
    yPosicionInicial: 0,
    moviendo: 0,
    moverIzquierda: function () {
        if (this.moviendo == 1) {
            this.x -= this.velocidad;
        } else {
            this.x = this.xPosicionInicial;
        }
    },
    setEstado: function (val) {
        this.moviendo = val;
    },
    setEjeX: function (x) {
        this.x = x;
    },
    posicionInicial: function (cw) {
        this.x = cw / 1.69;
        this.y = 150;
        this.xPosicionInicial = this.x;
        this.yPosicionInicial = this.y;
    },
    dibujar: function (ctx) {
        ctx.save();
        ctx.save();

        // Dibujar fondo con esquinas redondeadas
        const radius = 10; // Radio de esquina
        ctx.fillStyle = this.color;
        ctx.beginPath();
        ctx.moveTo(this.x + radius, this.y);
        ctx.lineTo(this.x + this.width - radius, this.y);
        ctx.quadraticCurveTo(
            this.x + this.width,
            this.y,
            this.x + this.width,
            this.y + radius
        );
        ctx.lineTo(this.x + this.width, this.y + this.height - radius);
        ctx.quadraticCurveTo(
            this.x + this.width,
            this.y + this.height,
            this.x + this.width - radius,
            this.y + this.height
        );
        ctx.lineTo(this.x + radius, this.y + this.height);
        ctx.quadraticCurveTo(
            this.x,
            this.y + this.height,
            this.x,
            this.y + this.height - radius
        );
        ctx.lineTo(this.x, this.y + radius);
        ctx.quadraticCurveTo(this.x, this.y, this.x + radius, this.y);
        ctx.closePath();
        ctx.fill();

        // Borde marrón/café
        ctx.strokeStyle = "#8B4513"; // Café estilo madera
        ctx.lineWidth = 4;
        ctx.stroke();

        // Listones horizontales
        ctx.strokeStyle = "black";
        ctx.lineWidth = 2;
        ctx.beginPath();
        ctx.moveTo(this.x + 5, this.y + 15);
        ctx.lineTo(this.x + this.width - 5, this.y + 15);
        ctx.moveTo(this.x + 5, this.y + 35);
        ctx.lineTo(this.x + this.width - 5, this.y + 35);
        ctx.stroke();

        ctx.restore();
    },
    colisionaCon: function (jugador) {
        return (
            this.x < jugador.x + jugador.width &&
            this.x + this.width > jugador.x &&
            this.y < jugador.y + jugador.height &&
            this.y + this.height > jugador.y
        );
    },
    detectarProximidad: function (jugador) {
        // Detecta si el jugador está a una distancia de 100 píxeles de la valla
        const distanciaSegura = 150;
        if (
            this.x - jugador.x < distanciaSegura &&
            this.x + 150 - jugador.x > 0
        ) {
            return true; // El jugador está lo suficientemente cerca para saltar
        }
        return false;
    },
};

const emit = defineEmits(["actualizaEstadoRespuesta"]);

var objPersonaje = {
    x: 0,
    y: 120,
    frame: 0,
    fw: 20,
    fh: 35,
    contFrames: 0,
    speedFrame: 3,
    maxFrames: 8,
    personaje: personaje,
    velocidad: 5,
    velocidadR: 8,
    irAdelante: 1,
    saltando: false,
    fuerzaSalto: 0,
    width: 40,
    height: 100,
    xPosicionInicial: 0,
    gravedad: 0.76, // Gravedad que afecta el salto
    sueloY: 120, // Suelo al que el personaje debe caer (puedes ajustarlo)
    mover: function (ctx) {
        if (this.contFrames > this.speedFrame) {
            if (this.frame < this.maxFrames) {
                this.frame++;
                this.personaje.src =
                    urlassets.value +
                    "imgs/aprendizaje/run" +
                    this.frame +
                    ".gif";
            } else {
                this.personaje.src =
                    urlassets.value + "imgs/aprendizaje/run9.gif";
                this.frame = 0;
            }
            this.contFrames = 0;
        } else {
            this.contFrames++;
        }
    },
    dibujar: function (ctx, cw) {
        // ctx.fillStyle = "white";
        // ctx.fillRect(this.x, this.y, this.width, this.height);
        ctx.drawImage(
            this.personaje,
            0,
            0,
            this.fw,
            this.fh,
            this.x,
            this.y,
            this.width,
            this.height
        );

        if (this.saltando) {
            const padding = 10;
            const texto = `+${valorPuntaje.value}`;
            const textoWidth = ctx.measureText(texto).width;
            const textoHeight = 35;
            const radius = 10; // Radio para esquinas redondeadas

            const rectX = this.x + this.width + 10 - padding;
            const rectY = this.y + this.height / 2 - textoHeight / 2 - padding;
            const rectWidth = textoWidth + 2 * padding;
            const rectHeight = textoHeight + 2 * padding;

            ctx.save();

            // Fondo redondeado
            ctx.beginPath();
            ctx.moveTo(rectX + radius, rectY);
            ctx.lineTo(rectX + rectWidth - radius, rectY);
            ctx.quadraticCurveTo(
                rectX + rectWidth,
                rectY,
                rectX + rectWidth,
                rectY + radius
            );
            ctx.lineTo(rectX + rectWidth, rectY + rectHeight - radius);
            ctx.quadraticCurveTo(
                rectX + rectWidth,
                rectY + rectHeight,
                rectX + rectWidth - radius,
                rectY + rectHeight
            );
            ctx.lineTo(rectX + radius, rectY + rectHeight);
            ctx.quadraticCurveTo(
                rectX,
                rectY + rectHeight,
                rectX,
                rectY + rectHeight - radius
            );
            ctx.lineTo(rectX, rectY + radius);
            ctx.quadraticCurveTo(rectX, rectY, rectX + radius, rectY);
            ctx.closePath();

            ctx.fillStyle = "rgba(255, 203, 0, 0.8)"; // Amarillo oro
            ctx.fill();

            // Borde del fondo
            ctx.strokeStyle = "#b8860b"; // Dorado oscuro (goldenrod)
            ctx.lineWidth = 2;
            ctx.stroke();

            // Texto
            ctx.font = "25px Arial";
            ctx.fillStyle = "white";
            ctx.lineWidth = 1.5;
            ctx.strokeStyle = "black"; // Contorno del texto
            ctx.strokeText(
                texto,
                this.x + this.width + 10,
                this.y + this.height / 2
            );
            ctx.fillText(
                texto,
                this.x + this.width + 10,
                this.y + this.height / 2
            );

            ctx.restore();
        }
    },
    posicionInicial: function (cw) {
        if (cw < 700) {
            this.x = cw / 3;
        } else {
            this.x = cw / 2.1;
        }
        this.xPosicionInicial = this.x;
    },
    setEstadoPersonaje: function (val) {
        this.irAdelante = val;
    },
    avanzar: function (cw) {
        if (this.irAdelante === 1) {
            if (valEtapaJuego.value == 2) {
                if (this.x < cw - this.width - 500) {
                    this.x += this.velocidad;
                } else {
                    this.irAdelante = -1;
                    this.x = cw / 2.5;
                }
            } else {
                if (this.x < cw - this.width) {
                    this.x += this.velocidad;
                } else {
                    this.x = cw / 2.5;
                }
            }
        }
    },
    retroceder: function (cw) {
        if (this.irAdelante === -1) {
            if (this.x > this.xPosicionInicial) {
                this.x -= this.velocidadR;
            } else {
                this.x = this.xPosicionInicial;
                this.irAdelante = 0;
                emit("actualizaEstadoRespuesta");
            }
        }
    },
    saltar: function () {
        if (!this.saltando) {
            this.saltando = true;
            this.fuerzaSalto = 12; // Altura inicial del salto
        }
    },
    caer: function () {
        if (this.saltando) {
            if (!audioCorrecto.played) {
                audioCorrecto.play();
            } else {
                audioCorrecto.currentTime = 0;
                audioCorrecto.play();
            }
        }

        this.saltando = false;
        this.fuerzaSalto = 0; // Altura inicial del salto
    },
    actualizar: function () {
        // Lógica del salto
        if (this.saltando) {
            this.y -= this.fuerzaSalto; // Mover al personaje hacia arriba
            this.fuerzaSalto -= this.gravedad; // Reducir la fuerza del salto (simulando gravedad)

            // Cuando el personaje llega al suelo, detener el salto
            if (this.y >= this.sueloY) {
                this.y = this.sueloY; // Asegurarse de que el personaje no baje de más
                this.saltando = false; // El salto ha terminado
                this.fuerzaSalto = 0; // Restablecer la fuerza de salto
            }
        } else {
            this.y = 120;
        }
    },
    setSpeed(s) {
        this.velocidad = s;
    },
    setSpeedR(s) {
        this.velocidadR = s;
    },
};

var score = 0;
// Comprobamos la colisión entre el personaje y la moneda
function colision(cw, ch, ctx) {
    const dx = objPersonaje.x + objPersonaje.width / 2 - moneda.x;
    const dy = objPersonaje.y + objPersonaje.height / 2 - moneda.y;
    const distancia = Math.sqrt(dx * dx + dy * dy);

    if (distancia < objPersonaje.width / 2 + moneda.radius) {
        score += moneda.puntos; // Añadimos los puntos de la moneda
        // Reposicionamos la moneda en una nueva posición
        moneda.x = -100;
        moneda.y = -100;
        moneda.animando = true; // Activamos la animación de la moneda
        objPersonaje.irAdelante = -1;
        if (!audioCorrecto.played) {
            audioCorrecto.play();
        } else {
            audioCorrecto.currentTime = 0;
            audioCorrecto.play();
        }
    }
}

watch(
    () => props.estadoJuego,
    (newVal) => {
        juegoIniciado.value = newVal;
        if (juegoIniciado.value && animacionComponent) {
            animacionComponent();
            if (!audioFondo.played) {
                audioFondo.play();
            } else {
                audioFondo.currentTime = 0;
                audioFondo.play();
            }
            audioFondo.loop = true;
        } else if (!juegoIniciado.value && animationFrameId) {
            if (audioFondo.played) {
                audioFondo.currentTime = 0;
                // audioFondo.pause();
            }
            // Detiene la animación si el juego está inactivo
            cancelAnimationFrame(animationFrameId);
            animationFrameId = null;
            personaje.src = urlassets.value + "imgs/aprendizaje/idle.gif";
        }
    }
);

watch(
    () => props.puntajeActual,
    (newVal) => {
        valorPuntaje.value = newVal;
        moneda.puntos = valorPuntaje.value;
    }
);

watch(
    () => props.etapaJuego,
    (newVal) => {
        valEtapaJuego.value = newVal;

        if (valEtapaJuego.value == 2) {
            muestra_etapa2.value = true;
        }
    }
);

watch(
    () => props.respCorrecta,
    (newVal) => {
        estadoRespuesta.value = newVal;
        if (estadoRespuesta.value) {
            objPersonaje.setEstadoPersonaje(1);
        } else {
            objPersonaje.setEstadoPersonaje(0);
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

    objPersonaje.posicionInicial(CANVAS_WIDTH);
    moneda.posicionInicial(CANVAS_WIDTH);
    valla.posicionInicial(CANVAS_WIDTH);
    objPersonaje.setEstadoPersonaje(0);
    const animacion = () => {
        contexto.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
        dibujarBackground(contexto);
        objPersonaje.dibujar(contexto, CANVAS_WIDTH);
        // console.log(muestra_etapa2.value);
        if (!muestra_etapa2.value) {
            moneda.dibujar(contexto, CANVAS_WIDTH);
            moneda.animar(CANVAS_WIDTH);
            moneda.setEjeX(moneda.xPosicionInicial);
            colision(CANVAS_WIDTH, CANVAS_HEIGHT);
        } else {
            if (muestra_etapa2.value) {
                // console.log("etapa 2");
                valla.dibujar(contexto, CANVAS_WIDTH);
                valla.setEjeX(valla.xPosicionInicial);
                valla.moverIzquierda();
                objPersonaje.actualizar();
                if (valla.detectarProximidad(objPersonaje)) {
                    valla.setEstado(1);
                    objPersonaje.saltar();
                } else {
                    objPersonaje.caer();
                }
                valla.moverIzquierda();
            }
        }
        // setTimeout(() => {
        objPersonaje.mover(contexto);
        objPersonaje.retroceder(CANVAS_WIDTH);
        objPersonaje.avanzar(CANVAS_WIDTH);
        // }, 500);
        if (juegoIniciado.value) {
            animationFrameId = requestAnimationFrame(animacion);
        }
    };

    const dibujarBackground = (ctx) => {
        // Obtiene el ancho de la imagen de fondo
        const bgWidth = background1.width;
        // Calcula cuántas veces es necesario dibujar la imagen para llenar el ancho del lienzo
        const nroFrames = Math.ceil(CANVAS_WIDTH / bgWidth) + 1;
        // Dibuja la imagen repetidamente para cubrir el lienzo completo
        for (let i = 0; i < nroFrames; i++) {
            ctx.drawImage(background1, xBackground1 + i * bgWidth, 0);
            ctx.drawImage(background2, xBackground1 + i * bgWidth, 0);
            ctx.drawImage(background3, xBackground1 + i * bgWidth, 0);
            ctx.drawImage(background4, xBackground1 + i * bgWidth, 0);
            ctx.drawImage(background5, xBackground1 + i * bgWidth, 0);
        }
        // dibujar el piso
        const nroFramesPiso = Math.ceil(CANVAS_WIDTH / 80) + 1;
        const bgWidth2 = 80;
        for (let i = 0; i < nroFramesPiso; i++) {
            ctx.drawImage(
                background6,
                0,
                200,
                80,
                50,
                xBackground2 + i * bgWidth2 - 20,
                150,
                100,
                120
            );
        }

        // Actualiza la posición del fondo para el efecto de desplazamiento
        xBackground1 -= speedBackground1;
        // Si el fondo se ha desplazado completamente reiniciar la posición
        if (xBackground1 <= -bgWidth) {
            xBackground1 = 0;
        }

        // Actualiza la posición del fondo para el efecto de desplazamiento
        xBackground2 -= speedBackground2;
        // Si el fondo se ha desplazado completamente reiniciar la posición
        if (xBackground2 <= -bgWidth2) {
            xBackground2 = 0;
        }
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
