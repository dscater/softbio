var preguntas = [];
fetch(url_assets + "assets/js/preguntas.json")
    .then((response) => response.json())
    .then((data) => {
        preguntas = data;
    })
    .catch((error) => {
        console.log(error);
    });
// {
//     "nro": 1,
//     "t": "ASTRONOMÍA: NUESTRO LUGAR EN EL UNIVERSO",
//     "p": [
//         {
//             "nro": 1,
//             "e": "¿Cuántos planetas hay en nuestro sistema solar?",
//             "o": [6, 9, 12, 8],
//             //  0, 1, 2, 3
//             "r": 3, // respuesta desde indice 0 en adelante
//         },
//         {
//             "nro": 2,
//             "e": "¿Cuál es el planeta más grande y pequeño del sistema solar?",
//             "o": [
//                 "El más pequeño es Marte y más grande Saturno",
//                 "El más pequeño es Mercurio y más grande Júpiter",
//                 "El más pequeño es Mercurio y más grande Venus",
//                 "El más pequeño es Júpiter y más grande Mercurio",
//             ],
//             "r": 1,
//         },
//         {
//             "nro": 3,
//             "e": "¿Cuál es la teoría más aceptada sobre el origen del universo?",
//             "o": [
//                 "Teoría de la Tierra Plana",
//                 "El Big Bang",
//                 "Teoría del Universo Estacionario",
//                 "Teoría de la Panspermia Cósmica",
//             ],
//             "r": 1,
//         },
//         {
//             "nro": 4,
//             "e": "¿Cuál es la edad del universo?",
//             "o": [
//                 "13 800 millones de años",
//                 "13 700 millones de años",
//                 "12 800 millones de años",
//                 "10 800 millones de años",
//             ],
//             "r": 0
//         },
//         {
//             "nro": 5,
//             "e": "¿Quién es el padre de la astronomía moderna?",
//             "o": [
//                 "Ptolomeo",
//                 "Aristóteles",
//                 "Nicolás Copérnico. Muchos también atribuyen a Galileo Galilei",
//                 "Isaac Newton",
//             ],
//             "r": 2,
//         },
//         {
//             "nro": 6,
//             "e": "¿Cuál es la distancia media entre la Tierra y el Sol?",
//             "o": [
//                 "130 000 000 km (130 millones de kilómetros)",
//                 "100 000 000 km (100 millones de kilómetros)",
//                 "155 000 000 km (155 millones de kilómetros)",
//                 "150 000 000 km (150 millones de kilómetros)",
//             ],
//             "r": 3,
//         },
//         {
//             "nro": 7,
//             "e": "¿Qué es una Unidad Astronómica (UA)?",
//             "o": [
//                 "Es una unidad de longitud que equivale aproximadamente a la distancia media entre la Tierra y el Sol. Una UA es igual a exactamente 149 597 870 700 metros",
//                 "Es una unidad de tiempo utilizada para medir la duración de un año en Marte",
//                 "Es la distancia promedio entre el Sol y Plutón",
//                 "Es la cantidad de tiempo que tarda la luz en llegar desde el Sol hasta la Tierra",
//             ],
//             "r": 0
//         }
//     ]
// },
