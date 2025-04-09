-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 09-04-2025 a las 19:21:43
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `softbio_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprendizajes`
--

CREATE TABLE `aprendizajes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `puntaje` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `aprendizajes`
--

INSERT INTO `aprendizajes` (`id`, `user_id`, `puntaje`, `created_at`, `updated_at`) VALUES
(1, 5, 435, '2024-11-06 22:49:28', '2025-04-09 19:27:27'),
(2, 4, 55, '2024-11-06 23:14:10', '2024-11-06 23:14:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `ciudad`, `dir`, `fono`, `correo`, `web`, `actividad`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SOFTBIO', 'SB', 'SOFTBIO S.A.', 'LA PAZ', 'LOS OLIVOS', '222222', 'softbio@gmail.com', 'softbio.com', 'ACTIVIDAD', '1730735405_1.jpg', NULL, '2024-11-04 19:50:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'CURSO 1', '2024-10-30 18:38:07', '2024-10-30 18:38:07'),
(2, 'CURSO 2', '2024-10-30 18:39:13', '2024-10-30 18:39:13'),
(3, 'CURSO 3', '2024-10-30 18:39:18', '2024-10-30 18:39:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacions`
--

CREATE TABLE `evaluacions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `evaluacions`
--

INSERT INTO `evaluacions` (`id`, `user_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 5, '2024-10-31', '2024-10-31 18:44:27', '2024-10-31 18:44:27'),
(2, 6, '2025-04-09', '2025-04-09 17:14:15', '2025-04-09 17:14:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_preguntas`
--

CREATE TABLE `evaluacion_preguntas` (
  `id` bigint UNSIGNED NOT NULL,
  `evaluacion_id` bigint UNSIGNED NOT NULL,
  `tema` int NOT NULL,
  `pregunta` int NOT NULL,
  `opcion` int NOT NULL,
  `correcto` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `evaluacion_preguntas`
--

INSERT INTO `evaluacion_preguntas` (`id`, `evaluacion_id`, `tema`, `pregunta`, `opcion`, `correcto`, `created_at`, `updated_at`) VALUES
(1, 2, 0, 0, 3, 1, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(2, 2, 0, 1, 2, 0, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(3, 2, 0, 2, 1, 1, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(4, 2, 0, 4, 2, 1, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(5, 2, 0, 3, 1, 0, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(6, 2, 0, 5, 1, 0, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(7, 2, 0, 6, 1, 0, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(8, 2, 0, 7, 1, 0, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(9, 2, 0, 8, 1, 0, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(10, 2, 0, 9, 3, 1, '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(11, 2, 1, 0, 0, 1, '2025-04-09 18:50:27', '2025-04-09 18:50:27'),
(12, 2, 1, 1, 1, 0, '2025-04-09 18:50:27', '2025-04-09 18:50:27'),
(13, 2, 1, 2, 1, 1, '2025-04-09 18:50:27', '2025-04-09 18:50:27'),
(14, 2, 1, 3, 1, 1, '2025-04-09 18:50:27', '2025-04-09 18:50:27'),
(15, 2, 1, 4, 0, 1, '2025-04-09 18:50:27', '2025-04-09 18:50:27'),
(16, 2, 1, 5, 0, 1, '2025-04-09 18:50:27', '2025-04-09 18:53:22'),
(17, 2, 1, 6, 1, 0, '2025-04-09 18:50:27', '2025-04-09 18:50:47'),
(18, 2, 1, 7, 3, 0, '2025-04-09 18:50:28', '2025-04-09 18:50:28'),
(19, 2, 1, 8, 1, 0, '2025-04-09 18:50:28', '2025-04-09 18:50:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CURSO', 'id: 1<br/>nombre: CURSO 1<br/>created_at: 2024-10-30 14:38:07<br/>updated_at: 2024-10-30 14:38:07<br/>', NULL, 'CURSOS', '2024-10-30', '14:38:07', '2024-10-30 18:38:07', '2024-10-30 18:38:07'),
(2, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CURSO', 'id: 2<br/>nombre: CURSO 2<br/>created_at: 2024-10-30 14:38:27<br/>updated_at: 2024-10-30 14:38:27<br/>', NULL, 'CURSOS', '2024-10-30', '14:38:27', '2024-10-30 18:38:27', '2024-10-30 18:38:27'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN CURSO', 'id: 2<br/>nombre: CURSO 2<br/>created_at: 2024-10-30 14:38:27<br/>updated_at: 2024-10-30 14:38:27<br/>', 'id: 2<br/>nombre: CURSO 2ASD<br/>created_at: 2024-10-30 14:38:27<br/>updated_at: 2024-10-30 14:38:31<br/>', 'CURSOS', '2024-10-30', '14:38:31', '2024-10-30 18:38:31', '2024-10-30 18:38:31'),
(4, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN CURSO', 'id: 2<br/>nombre: CURSO 2ASD<br/>created_at: 2024-10-30 14:38:27<br/>updated_at: 2024-10-30 14:38:31<br/>', NULL, 'CURSOS', '2024-10-30', '14:38:34', '2024-10-30 18:38:34', '2024-10-30 18:38:34'),
(5, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CURSO', 'id: 2<br/>nombre: CURSO 2<br/>created_at: 2024-10-30 14:39:13<br/>updated_at: 2024-10-30 14:39:13<br/>', NULL, 'CURSOS', '2024-10-30', '14:39:13', '2024-10-30 18:39:13', '2024-10-30 18:39:13'),
(6, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN CURSO', 'id: 3<br/>nombre: CURSO 3<br/>created_at: 2024-10-30 14:39:18<br/>updated_at: 2024-10-30 14:39:18<br/>', NULL, 'CURSOS', '2024-10-30', '14:39:18', '2024-10-30 18:39:18', '2024-10-30 18:39:18'),
(7, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 2<br/>nombre: JUAN<br/>paterno: PERES MAMANI<br/>materno: MAMANI<br/>ci: 1111<br/>ci_exp: LP<br/>email: juan@gmail.com<br/>password: $2y$12$.dtup51bSOjUoa2sWUfi0OYb3CS44PsPy/pq1CmDut5v6CeonH9VK<br/>tipo: ADMINISTRADOR<br/>foto: 1730299412_.jpg<br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: <br/>created_at: 2024-10-30 14:43:32<br/>updated_at: 2024-10-30 14:43:32<br/>', NULL, 'USUARIOS', '2024-10-30', '14:43:32', '2024-10-30 18:43:32', '2024-10-30 18:43:32'),
(8, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: ADMINISTRADOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: <br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:45:47<br/>', NULL, 'USUARIOS', '2024-10-30', '14:45:47', '2024-10-30 18:45:47', '2024-10-30 18:45:47'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: ADMINISTRADOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: <br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:45:47<br/>', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: <br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:45:52<br/>', 'USUARIOS', '2024-10-30', '14:45:52', '2024-10-30 18:45:52', '2024-10-30 18:45:52'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: 1<br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:45:52<br/>', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:52:22<br/>', 'USUARIOS', '2024-10-30', '14:52:22', '2024-10-30 18:52:22', '2024-10-30 18:52:22'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:52:22<br/>', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 2<br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:52:27<br/>', 'USUARIOS', '2024-10-30', '14:52:27', '2024-10-30 18:52:27', '2024-10-30 18:52:27'),
(12, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 14:55:21<br/>', NULL, 'USUARIOS', '2024-10-30', '14:55:21', '2024-10-30 18:55:21', '2024-10-30 18:55:21'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 14:55:21<br/>', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 14:55:50<br/>', 'USUARIOS', '2024-10-30', '14:55:50', '2024-10-30 18:55:50', '2024-10-30 18:55:50'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 14:55:50<br/>', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 3<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 14:59:42<br/>', 'USUARIOS', '2024-10-30', '14:59:42', '2024-10-30 18:59:42', '2024-10-30 18:59:42'),
(15, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 2<br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:52:27<br/>', 'id: 3<br/>nombre: MARCOS<br/>paterno: RAMIRES<br/>materno: GONZALES<br/>ci: 2222<br/>ci_exp: LP<br/>email: marcos@gmail.com<br/>password: $2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 14:45:47<br/>updated_at: 2024-10-30 14:59:55<br/>', 'USUARIOS', '2024-10-30', '14:59:55', '2024-10-30 18:59:55', '2024-10-30 18:59:55'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 3<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 14:59:42<br/>', 'id: 4<br/>nombre: RAMIRO<br/>paterno: PAREDES<br/>materno: PAREDES<br/>ci: 3333<br/>ci_exp: LP<br/>email: ramiro@gmail.com<br/>password: $2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 2<br/>created_at: 2024-10-30 14:55:21<br/>updated_at: 2024-10-30 15:00:01<br/>', 'USUARIOS', '2024-10-30', '15:00:01', '2024-10-30 19:00:01', '2024-10-30 19:00:01'),
(17, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 5<br/>nombre: CARLOS<br/>paterno: CHOQUE<br/>materno: MAMANI<br/>ci: 4444<br/>ci_exp: CB<br/>email: carlos@gmail.com<br/>password: $2y$12$JkAwVYMtNJy9UFwQv6RxAOq/jONkgTn2CiIHuGJQfSvztvmrO6.sW<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: 1<br/>created_at: 2024-10-30 15:02:02<br/>updated_at: 2024-10-30 15:02:02<br/>', NULL, 'USUARIOS', '2024-10-30', '15:02:02', '2024-10-30 19:02:02', '2024-10-30 19:02:02'),
(18, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 6<br/>nombre: ELVIS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 55555<br/>ci_exp: LP<br/>email: elvis@gmail.com<br/>password: $2y$12$tNAY1SfzaAgOubTFXDapOOCfeT.cQ/IkOwvaBYNItrtqemPft4UCu<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: 1<br/>created_at: 2024-10-30 15:02:21<br/>updated_at: 2024-10-30 15:02:22<br/>', NULL, 'USUARIOS', '2024-10-30', '15:02:22', '2024-10-30 19:02:22', '2024-10-30 19:02:22'),
(19, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 7<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: SOLIZ<br/>ci: 1212<br/>ci_exp: LP<br/>email: maria@gmail.com<br/>password: $2y$12$Zby7HK96VjwbYcG9PbwhZud0qQBrjLf75L1Ger1ZSO2rGFFoHP1JK<br/>tipo: PROFESOR<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 3<br/>created_at: 2024-10-30 15:02:43<br/>updated_at: 2024-10-30 15:02:43<br/>', NULL, 'USUARIOS', '2024-10-30', '15:02:43', '2024-10-30 19:02:43', '2024-10-30 19:02:43'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 6<br/>nombre: ELVIS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 55555<br/>ci_exp: LP<br/>email: elvis@gmail.com<br/>password: $2y$12$tNAY1SfzaAgOubTFXDapOOCfeT.cQ/IkOwvaBYNItrtqemPft4UCu<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: 1<br/>created_at: 2024-10-30 15:02:21<br/>updated_at: 2024-10-30 15:02:22<br/>', 'id: 6<br/>nombre: ELVIS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 55555<br/>ci_exp: LP<br/>email: elvis@gmail.com<br/>password: $2y$12$tNAY1SfzaAgOubTFXDapOOCfeT.cQ/IkOwvaBYNItrtqemPft4UCu<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 2<br/>created_at: 2024-10-30 15:02:21<br/>updated_at: 2024-10-30 15:02:52<br/>', 'USUARIOS', '2024-10-30', '15:02:52', '2024-10-30 19:02:52', '2024-10-30 19:02:52'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 6<br/>nombre: ELVIS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 55555<br/>ci_exp: LP<br/>email: elvis@gmail.com<br/>password: $2y$12$tNAY1SfzaAgOubTFXDapOOCfeT.cQ/IkOwvaBYNItrtqemPft4UCu<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 2<br/>created_at: 2024-10-30 15:02:21<br/>updated_at: 2024-10-30 15:02:52<br/>', 'id: 6<br/>nombre: ELVIS<br/>paterno: MAMANI<br/>materno: MAMANI<br/>ci: 55555<br/>ci_exp: LP<br/>email: elvis@gmail.com<br/>password: $2y$12$tNAY1SfzaAgOubTFXDapOOCfeT.cQ/IkOwvaBYNItrtqemPft4UCu<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 15:02:21<br/>updated_at: 2024-10-30 15:02:57<br/>', 'USUARIOS', '2024-10-30', '15:02:57', '2024-10-30 19:02:57', '2024-10-30 19:02:57'),
(22, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN USUARIO', 'id: 8<br/>nombre: PABLO<br/>paterno: SUAREZ<br/>materno: MAMANI<br/>ci: 2121<br/>ci_exp: CB<br/>email: pablo@gmail.com<br/>password: $2y$12$QcTuK5kdIh/uflN8YnrS0.OfgBV3/9ltOBA.Jfo5GwDvyYezF4fnC<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 15:03:29<br/>updated_at: 2024-10-30 15:03:29<br/>', NULL, 'USUARIOS', '2024-10-30', '15:03:29', '2024-10-30 19:03:29', '2024-10-30 19:03:29'),
(23, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN MATERIAL DE APOYO', 'id: 2<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:05:23<br/>updated_at: 2024-10-30 16:05:23<br/>', NULL, 'MATERIAL DE APOYO', '2024-10-30', '16:05:23', '2024-10-30 20:05:23', '2024-10-30 20:05:23'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN MATERIAL DE APOYO', 'id: 2<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:05:23<br/>updated_at: 2024-10-30 16:05:23<br/>', 'id: 2<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:05:23<br/>updated_at: 2024-10-30 16:05:23<br/>', 'MATERIAL DE APOYO', '2024-10-30', '16:26:32', '2024-10-30 20:26:32', '2024-10-30 20:26:32'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN MATERIAL DE APOYO', 'id: 2<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:05:23<br/>updated_at: 2024-10-30 16:05:23<br/>', 'id: 2<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:05:23<br/>updated_at: 2024-10-30 16:05:23<br/>', 'MATERIAL DE APOYO', '2024-10-30', '16:26:53', '2024-10-30 20:26:53', '2024-10-30 20:26:53'),
(26, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN MATERIAL DE APOYO', 'id: 2<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:05:23<br/>updated_at: 2024-10-30 16:05:23<br/>', NULL, 'MATERIAL DE APOYO', '2024-10-30', '16:29:31', '2024-10-30 20:29:31', '2024-10-30 20:29:31'),
(27, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN MATERIAL DE APOYO', 'id: 3<br/>materia_id: 1<br/>fecha_registro: 2024-10-30<br/>created_at: 2024-10-30 16:29:41<br/>updated_at: 2024-10-30 16:29:41<br/>', NULL, 'MATERIAL DE APOYO', '2024-10-30', '16:29:41', '2024-10-30 20:29:41', '2024-10-30 20:29:41'),
(28, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN USUARIO', 'id: 5<br/>nombre: CARLOS<br/>paterno: CHOQUE<br/>materno: MAMANI<br/>ci: 4444<br/>ci_exp: CB<br/>email: carlos@gmail.com<br/>password: $2y$12$JkAwVYMtNJy9UFwQv6RxAOq/jONkgTn2CiIHuGJQfSvztvmrO6.sW<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 0<br/>curso_id: 1<br/>created_at: 2024-10-30 15:02:02<br/>updated_at: 2024-10-30 15:02:02<br/>', 'id: 5<br/>nombre: CARLOS<br/>paterno: CHOQUE<br/>materno: MAMANI<br/>ci: 4444<br/>ci_exp: CB<br/>email: carlos@gmail.com<br/>password: $2y$12$JkAwVYMtNJy9UFwQv6RxAOq/jONkgTn2CiIHuGJQfSvztvmrO6.sW<br/>tipo: ESTUDIANTE<br/>foto: <br/>fecha_registro: 2024-10-30<br/>acceso: 1<br/>curso_id: 1<br/>created_at: 2024-10-30 15:02:02<br/>updated_at: 2024-10-31 14:42:30<br/>', 'USUARIOS', '2024-10-31', '14:42:30', '2024-10-31 18:42:30', '2024-10-31 18:42:30'),
(29, 5, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 1<br/>user_id: 5<br/>fecha_registro: 2024-10-31<br/>created_at: 2024-10-31 14:44:27<br/>updated_at: 2024-10-31 14:44:27<br/>', '', 'EVALUACIONES', '2024-10-31', '17:08:56', '2024-10-31 21:08:56', '2024-10-31 21:08:56'),
(30, 5, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 1<br/>user_id: 5<br/>fecha_registro: 2024-10-31<br/>created_at: 2024-10-31 14:44:27<br/>updated_at: 2024-10-31 14:44:27<br/>', '', 'EVALUACIONES', '2024-10-31', '17:09:43', '2024-10-31 21:09:43', '2024-10-31 21:09:43'),
(31, 5, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 1<br/>user_id: 5<br/>fecha_registro: 2024-10-31<br/>created_at: 2024-10-31 14:44:27<br/>updated_at: 2024-10-31 14:44:27<br/>', '', 'EVALUACIONES', '2024-10-31', '17:18:32', '2024-10-31 21:18:32', '2024-10-31 21:18:32'),
(32, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:14:42', '2025-04-09 17:14:42', '2025-04-09 17:14:42'),
(33, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:51:56', '2025-04-09 17:51:56', '2025-04-09 17:51:56'),
(34, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:53:03', '2025-04-09 17:53:03', '2025-04-09 17:53:03'),
(35, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:53:53', '2025-04-09 17:53:53', '2025-04-09 17:53:53'),
(36, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:56:29', '2025-04-09 17:56:29', '2025-04-09 17:56:29'),
(37, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:57:24', '2025-04-09 17:57:24', '2025-04-09 17:57:24'),
(38, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:57:40', '2025-04-09 17:57:40', '2025-04-09 17:57:40'),
(39, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:57:46', '2025-04-09 17:57:46', '2025-04-09 17:57:46'),
(40, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '13:57:56', '2025-04-09 17:57:56', '2025-04-09 17:57:56'),
(41, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:30:27', '2025-04-09 18:30:27', '2025-04-09 18:30:27'),
(42, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:32:35', '2025-04-09 18:32:35', '2025-04-09 18:32:35'),
(43, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:33:10', '2025-04-09 18:33:10', '2025-04-09 18:33:10'),
(44, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:33:45', '2025-04-09 18:33:45', '2025-04-09 18:33:45'),
(45, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:33:52', '2025-04-09 18:33:52', '2025-04-09 18:33:52'),
(46, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:33:58', '2025-04-09 18:33:58', '2025-04-09 18:33:58'),
(47, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:34:04', '2025-04-09 18:34:04', '2025-04-09 18:34:04'),
(48, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:34:31', '2025-04-09 18:34:31', '2025-04-09 18:34:31'),
(49, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:35:51', '2025-04-09 18:35:51', '2025-04-09 18:35:51'),
(50, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:36:04', '2025-04-09 18:36:04', '2025-04-09 18:36:04'),
(51, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:36:52', '2025-04-09 18:36:52', '2025-04-09 18:36:52'),
(52, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:37:34', '2025-04-09 18:37:34', '2025-04-09 18:37:34'),
(53, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:38:09', '2025-04-09 18:38:09', '2025-04-09 18:38:09'),
(54, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:44:11', '2025-04-09 18:44:11', '2025-04-09 18:44:11'),
(55, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:44:29', '2025-04-09 18:44:29', '2025-04-09 18:44:29'),
(56, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:44:42', '2025-04-09 18:44:42', '2025-04-09 18:44:42'),
(57, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:49:08', '2025-04-09 18:49:08', '2025-04-09 18:49:08'),
(58, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:50:01', '2025-04-09 18:50:01', '2025-04-09 18:50:01'),
(59, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:50:28', '2025-04-09 18:50:28', '2025-04-09 18:50:28'),
(60, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:50:47', '2025-04-09 18:50:47', '2025-04-09 18:50:47'),
(61, 6, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA EVALUACIÓN', 'id: 2<br/>user_id: 6<br/>fecha_registro: 2025-04-09<br/>created_at: 2025-04-09 13:14:15<br/>updated_at: 2025-04-09 13:14:15<br/>', '', 'EVALUACIONES', '2025-04-09', '14:53:22', '2025-04-09 18:53:22', '2025-04-09 18:53:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materials`
--

CREATE TABLE `materials` (
  `id` bigint UNSIGNED NOT NULL,
  `materia_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `materials`
--

INSERT INTO `materials` (`id`, `materia_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(3, 1, '2024-10-30', '2024-10-30 20:29:41', '2024-10-30 20:29:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `material_archivos`
--

CREATE TABLE `material_archivos` (
  `id` bigint UNSIGNED NOT NULL,
  `material_id` bigint UNSIGNED NOT NULL,
  `archivo` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `material_archivos`
--

INSERT INTO `material_archivos` (`id`, `material_id`, `archivo`, `created_at`, `updated_at`) VALUES
(6, 3, 'doc_3_17303057810.pdf', '2024-10-30 20:29:41', '2024-10-30 20:29:41'),
(7, 3, 'doc_3_17303057811.docx', '2024-10-30 20:29:41', '2024-10-30 20:29:41'),
(8, 3, 'doc_3_17303057812.pdf', '2024-10-30 20:29:41', '2024-10-30 20:29:41'),
(9, 3, 'doc_3_17303057813.pdf', '2024-10-30 20:29:41', '2024-10-30 20:29:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`id`, `nombre`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'Geografía: Astronomía Nuestro lugar en el Universo', NULL, NULL, NULL),
(2, 'Biología como ciencia en la vida y para la vida', NULL, NULL, NULL),
(3, 'La diversidad de seres vivos que habitan en la madre tierra', NULL, NULL, NULL),
(4, 'La célula: Unidad anatómica funcional y genética para la preservación de la \r\nvida', NULL, NULL, NULL),
(5, 'Sexualidad humana integral y holística', NULL, NULL, NULL),
(6, 'Transformación química y sostenible de la materia', NULL, NULL, NULL),
(7, 'Matemática aplicada en las ciencias naturales', NULL, NULL, NULL),
(8, 'Estudio de los Suelos en la madre tierra geología', NULL, NULL, NULL),
(9, 'Ecología relaciones de interdependencia en la madre tierra', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '2024_01_31_165641_create_configuracions_table', 1),
(3, '2024_02_02_205431_create_historial_accions_table', 1),
(4, '2024_10_29_162111_create_cursos_table', 1),
(5, '2024_10_29_162221_create_materias_table', 1),
(6, '2024_10_29_162306_create_aprendizajes_table', 1),
(7, '2024_10_29_162435_create_evaluacions_table', 1),
(8, '2024_10_29_162546_create_evaluacion_preguntas_table', 1),
(9, '2024_10_30_150911_create_materials_table', 2),
(10, '2024_10_30_150914_create_material_archivos_table', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `acceso` int NOT NULL,
  `curso_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `email`, `password`, `tipo`, `foto`, `fecha_registro`, `acceso`, `curso_id`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', NULL, '0', '', 'admin@admin.com', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 'ADMINISTRADOR', NULL, '2024-10-29', 1, NULL, NULL, NULL),
(2, 'JUAN', 'PERES MAMANI', 'MAMANI', '1111', 'LP', 'juan@gmail.com', '$2y$12$.dtup51bSOjUoa2sWUfi0OYb3CS44PsPy/pq1CmDut5v6CeonH9VK', 'ADMINISTRADOR', '1730299412_.jpg', '2024-10-30', 1, NULL, '2024-10-30 18:43:32', '2024-10-30 18:43:32'),
(3, 'MARCOS', 'RAMIRES', 'GONZALES', '2222', 'LP', 'marcos@gmail.com', '$2y$12$mwtsLVMd/DLyRcmHTyPsyOwlnZ8pWRfODl6zIsPWFiZUYyXNjU96O', 'PROFESOR', NULL, '2024-10-30', 1, 1, '2024-10-30 18:45:47', '2024-10-30 18:59:55'),
(4, 'RAMIRO', 'PAREDES', 'PAREDES', '3333', 'LP', 'ramiro@gmail.com', '$2y$12$k7lD3UagGy60cTCuHuGpbeOLiNcupKhMXcRhefzjf0RwmMVu3Z7Z.', 'PROFESOR', NULL, '2024-10-30', 1, 2, '2024-10-30 18:55:21', '2024-10-30 19:00:01'),
(5, 'CARLOS', 'CHOQUE', 'MAMANI', '4444', 'CB', 'carlos@gmail.com', '$2y$12$JkAwVYMtNJy9UFwQv6RxAOq/jONkgTn2CiIHuGJQfSvztvmrO6.sW', 'ESTUDIANTE', NULL, '2024-10-30', 1, 1, '2024-10-30 19:02:02', '2024-10-31 18:42:30'),
(6, 'ELVIS', 'MAMANI', 'MAMANI', '55555', 'LP', 'elvis@gmail.com', '$2y$12$tNAY1SfzaAgOubTFXDapOOCfeT.cQ/IkOwvaBYNItrtqemPft4UCu', 'ESTUDIANTE', NULL, '2024-10-30', 1, 1, '2024-10-30 19:02:21', '2024-10-30 19:02:57'),
(7, 'MARIA', 'MAMANI', 'SOLIZ', '1212', 'LP', 'maria@gmail.com', '$2y$12$Zby7HK96VjwbYcG9PbwhZud0qQBrjLf75L1Ger1ZSO2rGFFoHP1JK', 'PROFESOR', NULL, '2024-10-30', 1, 3, '2024-10-30 19:02:43', '2024-10-30 19:02:43'),
(8, 'PABLO', 'SUAREZ', 'MAMANI', '2121', 'CB', 'pablo@gmail.com', '$2y$12$QcTuK5kdIh/uflN8YnrS0.OfgBV3/9ltOBA.Jfo5GwDvyYezF4fnC', 'ESTUDIANTE', NULL, '2024-10-30', 1, 2, '2024-10-30 19:03:29', '2024-10-30 19:03:29');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aprendizajes`
--
ALTER TABLE `aprendizajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `aprendizajes_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cursos_nombre_unique` (`nombre`);

--
-- Indices de la tabla `evaluacions`
--
ALTER TABLE `evaluacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `evaluacion_preguntas`
--
ALTER TABLE `evaluacion_preguntas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `materials_materia_id_foreign` (`materia_id`);

--
-- Indices de la tabla `material_archivos`
--
ALTER TABLE `material_archivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `material_archivos_material_id_foreign` (`material_id`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `materias_nombre_unique` (`nombre`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aprendizajes`
--
ALTER TABLE `aprendizajes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `evaluacions`
--
ALTER TABLE `evaluacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `evaluacion_preguntas`
--
ALTER TABLE `evaluacion_preguntas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `materials`
--
ALTER TABLE `materials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `material_archivos`
--
ALTER TABLE `material_archivos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aprendizajes`
--
ALTER TABLE `aprendizajes`
  ADD CONSTRAINT `aprendizajes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `materials_materia_id_foreign` FOREIGN KEY (`materia_id`) REFERENCES `materias` (`id`);

--
-- Filtros para la tabla `material_archivos`
--
ALTER TABLE `material_archivos`
  ADD CONSTRAINT `material_archivos_material_id_foreign` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
