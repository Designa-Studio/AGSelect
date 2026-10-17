-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 03-08-2026 a las 20:47:52
-- Versión del servidor: 10.11.18-MariaDB-cll-lve
-- Versión de PHP: 8.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `i10196611_hb8x1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_additional_services`
--

CREATE TABLE `jboo_agselect_additional_services` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price_car` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_jeepeta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_suv` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_camioneta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_camion` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_minivan` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_camion_dos_ejes` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_trailer` decimal(10,2) NOT NULL DEFAULT 0.00,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_bookings`
--

CREATE TABLE `jboo_agselect_bookings` (
  `id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `total_vehicles` int(11) NOT NULL DEFAULT 1,
  `total_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_bookings`
--

INSERT INTO `jboo_agselect_bookings` (`id`, `customer_id`, `total_vehicles`, `total_price`, `status`, `created_at`) VALUES
(1, 0, 3, 5900.00, 'completed', '2025-08-03 19:47:19'),
(2, 0, 1, 4250.00, 'completed', '2025-08-04 22:11:52'),
(3, 0, 1, 950.00, 'completed', '2025-08-08 22:23:01'),
(4, 2, 1, 1650.00, 'completed', '2025-08-09 20:02:22'),
(5, 7, 1, 1500.00, 'completed', '2025-08-09 22:02:53'),
(6, 0, 2, 3300.00, 'completed', '2025-08-10 14:45:34'),
(7, 0, 1, 2500.00, 'completed', '2025-08-10 19:08:07'),
(10, 0, 3, 5900.00, 'completed', '2025-08-16 17:21:38'),
(11, 0, 2, 1700.00, 'completed', '2025-08-17 15:55:49'),
(12, 0, 2, 2200.00, 'completed', '2025-08-17 18:08:46'),
(13, 0, 1, 850.00, 'completed', '2025-09-06 14:59:20'),
(14, 2, 3, 6200.00, 'completed', '2025-09-06 16:19:56'),
(15, 2, 2, 2200.00, 'completed', '2025-09-07 18:22:32'),
(16, 2, 1, 1750.00, 'completed', '2025-09-22 20:40:13'),
(17, 0, 3, 5450.00, 'completed', '2025-09-28 20:25:45'),
(18, 2, 2, 2200.00, 'completed', '2025-09-28 20:34:11'),
(19, 0, 1, 4250.00, 'completed', '2025-09-28 23:13:15'),
(22, 2, 1, 8500.00, 'completed', '2025-10-08 15:08:51'),
(23, 2, 1, 1950.00, 'completed', '2025-10-08 15:11:31'),
(24, 2, 5, 2750.00, 'completed', '2025-10-08 15:15:03'),
(25, 2, 1, 850.00, 'completed', '2025-10-08 15:22:33'),
(26, 0, 2, 2600.00, 'completed', '2025-10-12 12:55:10'),
(27, 0, 2, 3900.00, 'completed', '2025-10-18 17:13:41'),
(28, 0, 1, 1750.00, 'completed', '2025-11-03 15:43:46'),
(29, 0, 1, 1750.00, 'completed', '2025-11-08 16:02:23'),
(30, 2, 1, 1500.00, 'completed', '2025-11-11 12:27:08'),
(31, 2, 1, 1500.00, 'completed', '2025-11-11 14:27:37'),
(32, 2, 3, 4200.00, 'completed', '2025-11-16 18:40:32'),
(33, 2, 1, 1450.00, 'completed', '2025-11-16 18:44:13'),
(34, 0, 2, 3200.00, 'completed', '2025-11-23 19:01:18'),
(35, 0, 1, 3500.00, 'completed', '2025-11-23 19:04:31'),
(36, 0, 3, 4450.00, 'completed', '2025-11-28 14:23:39'),
(37, 2, 1, 1500.00, 'completed', '2025-11-29 23:34:32'),
(38, 2, 1, 850.00, 'completed', '2025-11-29 23:37:57'),
(39, 14, 1, 950.00, 'completed', '2025-11-30 15:38:47'),
(40, 2, 2, 5000.00, 'completed', '2025-12-01 20:55:43'),
(41, 14, 1, 950.00, 'completed', '2025-12-13 12:17:24'),
(43, 2, 1, 1550.00, 'completed', '2025-12-13 14:17:39'),
(44, 2, 1, 2500.00, 'completed', '2025-12-13 14:23:34'),
(46, 0, 4, 7650.00, 'completed', '2025-12-14 19:23:59'),
(47, 14, 1, 950.00, 'completed', '2025-12-20 10:38:28'),
(48, 2, 2, 4800.00, 'completed', '2025-12-20 18:27:01'),
(49, 2, 1, 3500.00, 'completed', '2025-12-26 21:07:53'),
(50, 14, 1, 950.00, 'completed', '2025-12-27 14:19:31'),
(51, 0, 1, 1650.00, 'completed', '2025-12-27 22:02:07'),
(52, 0, 1, 3500.00, 'completed', '2026-01-04 17:10:07'),
(53, 2, 1, 850.00, 'completed', '2026-01-08 12:55:09'),
(54, 0, 1, 1450.00, 'completed', '2026-01-08 18:56:55'),
(55, 14, 1, 950.00, 'completed', '2026-01-10 13:05:53'),
(56, 2, 2, 3950.00, 'completed', '2026-01-11 11:45:35'),
(57, 0, 1, 1550.00, 'completed', '2026-01-11 15:11:03'),
(58, 0, 1, 1500.00, 'completed', '2026-01-14 22:09:23'),
(59, 0, 2, 3000.00, 'completed', '2026-01-14 22:22:06'),
(61, 0, 2, 2400.00, 'completed', '2026-01-17 16:37:28'),
(62, 0, 3, 2750.00, 'completed', '2026-01-17 16:42:58'),
(63, 14, 1, 950.00, 'completed', '2026-01-18 12:06:42'),
(64, 0, 2, 4250.00, 'completed', '2026-01-18 18:05:03'),
(65, 0, 1, 1550.00, 'completed', '2026-01-18 18:17:50'),
(66, 0, 1, 1500.00, 'completed', '2026-01-20 12:47:00'),
(68, 0, 1, 850.00, 'completed', '2026-01-26 19:15:27'),
(69, 2, 1, 1500.00, 'completed', '2026-01-26 19:53:50'),
(70, 2, 2, 3000.00, 'completed', '2026-01-26 20:04:14'),
(71, 0, 1, 2000.00, 'completed', '2026-01-26 20:28:05'),
(72, 0, 1, 950.00, 'completed', '2026-01-31 12:09:11'),
(73, 0, 4, 5350.00, 'completed', '2026-02-01 20:53:28'),
(74, 0, 2, 2450.00, 'completed', '2026-02-07 16:17:52'),
(75, 2, 2, 2350.00, 'completed', '2026-02-07 16:27:35'),
(76, 0, 2, 5000.00, 'completed', '2026-02-08 20:17:43'),
(77, 0, 1, 2000.00, 'completed', '2026-02-08 20:42:11'),
(78, 0, 1, 950.00, 'completed', '2026-02-10 14:16:45'),
(80, 0, 1, 850.00, 'completed', '2026-02-15 16:18:50'),
(84, 0, 1, 950.00, 'completed', '2026-02-21 19:10:11'),
(85, 0, 1, 1500.00, 'completed', '2026-02-22 19:00:40'),
(86, 0, 2, 2350.00, 'completed', '2026-02-22 19:02:37'),
(87, 0, 1, 2000.00, 'completed', '2026-02-22 19:03:54'),
(88, 0, 1, 850.00, 'completed', '2026-02-26 18:58:04'),
(89, 0, 1, 1500.00, 'completed', '2026-02-26 18:59:05'),
(90, 0, 1, 1500.00, 'completed', '2026-03-02 17:55:25'),
(91, 0, 1, 1450.00, 'completed', '2026-03-02 17:58:02'),
(92, 0, 1, 1450.00, 'completed', '2026-03-06 09:39:47'),
(93, 0, 1, 3500.00, 'completed', '2026-03-08 15:57:03'),
(94, 0, 2, 2450.00, 'completed', '2026-03-08 23:37:26'),
(95, 0, 2, 2350.00, 'completed', '2026-03-08 23:41:22'),
(96, 0, 2, 2200.00, 'completed', '2026-03-14 16:41:10'),
(97, 0, 1, 1350.00, 'cancelled', '2026-03-14 16:42:54'),
(98, 0, 2, 2450.00, 'cancelled', '2026-03-14 16:46:07'),
(99, 0, 1, 850.00, 'completed', '2026-03-14 17:05:52'),
(100, 0, 1, 950.00, 'completed', '2026-03-14 18:01:13'),
(101, 0, 2, 2450.00, 'completed', '2026-03-22 17:35:27'),
(102, 0, 1, 1500.00, 'completed', '2026-03-22 17:39:53'),
(103, 0, 1, 850.00, 'completed', '2026-03-22 23:20:22'),
(104, 0, 1, 2000.00, 'completed', '2026-03-24 12:56:45'),
(105, 0, 3, 3050.00, 'completed', '2026-03-27 22:41:13'),
(106, 0, 4, 6800.00, 'completed', '2026-03-28 18:34:44'),
(107, 0, 2, 3000.00, 'completed', '2026-03-28 23:27:24'),
(108, 0, 1, 2300.00, 'completed', '2026-04-04 17:08:28'),
(109, 0, 2, 3600.00, 'completed', '2026-04-05 19:02:17'),
(110, 0, 1, 2300.00, 'completed', '2026-04-10 19:12:47'),
(111, 0, 1, 3450.00, 'completed', '2026-04-11 04:32:03'),
(112, 2, 1, 2950.00, 'completed', '2026-04-11 04:36:42'),
(113, 0, 2, 5100.00, 'completed', '2026-04-12 14:28:45'),
(115, 2, 1, 2000.00, 'completed', '2026-04-12 19:55:07'),
(116, 2, 1, 18000.00, 'completed', '2026-04-18 11:52:43'),
(117, 0, 1, 2300.00, 'completed', '2026-04-19 15:38:07'),
(118, 0, 2, 3800.00, 'completed', '2026-04-19 15:40:04'),
(119, 2, 2, 2700.00, 'completed', '2026-04-19 15:46:36'),
(120, 0, 2, 3350.00, 'completed', '2026-04-24 12:14:22'),
(121, 0, 1, 2300.00, 'completed', '2026-04-25 17:47:25'),
(122, 0, 2, 3300.00, 'completed', '2026-04-25 17:51:02'),
(123, 0, 1, 2300.00, 'completed', '2026-04-26 19:23:50'),
(124, 2, 1, 1500.00, 'completed', '2026-05-02 17:09:45'),
(125, 2, 2, 3500.00, 'completed', '2026-05-02 18:57:06'),
(126, 2, 1, 1500.00, 'completed', '2026-05-09 13:05:49'),
(127, 2, 2, 3800.00, 'completed', '2026-05-09 19:33:34'),
(128, 2, 1, 1800.00, 'completed', '2026-05-10 15:51:58'),
(129, 2, 1, 2300.00, 'completed', '2026-05-10 15:55:04'),
(130, 0, 4, 6700.00, 'completed', '2026-05-17 18:48:11'),
(131, 2, 1, 1500.00, 'completed', '2026-05-23 18:38:00'),
(132, 2, 2, 3600.00, 'completed', '2026-05-23 18:52:03'),
(133, 2, 1, 1800.00, 'completed', '2026-05-25 14:06:48'),
(134, 2, 1, 1500.00, 'completed', '2026-05-25 14:09:36'),
(135, 2, 1, 2300.00, 'completed', '2026-05-30 18:37:04'),
(136, 2, 1, 2300.00, 'completed', '2026-05-31 01:13:47'),
(137, 2, 1, 1200.00, 'completed', '2026-06-06 18:11:18'),
(138, 2, 1, 1500.00, 'completed', '2026-06-07 21:02:42'),
(139, 2, 1, 1800.00, 'completed', '2026-06-07 21:05:21'),
(140, 2, 1, 1700.00, 'completed', '2026-06-11 18:15:39'),
(141, 2, 1, 2500.00, 'completed', '2026-06-11 18:55:57'),
(142, 2, 2, 2900.00, 'pending', '2026-06-12 17:42:20'),
(143, 2, 1, 1500.00, 'completed', '2026-06-13 18:51:46'),
(144, 2, 2, 3000.00, 'completed', '2026-06-13 18:56:15'),
(145, 2, 1, 1800.00, 'completed', '2026-06-14 13:23:02'),
(146, 2, 1, 2300.00, 'completed', '2026-06-14 14:58:07'),
(147, 0, 1, 2800.00, 'completed', '2026-06-20 13:58:49'),
(148, 2, 2, 3600.00, 'completed', '2026-06-21 18:17:27'),
(149, 2, 2, 4100.00, 'completed', '2026-06-28 16:37:54'),
(150, 2, 1, 1800.00, 'completed', '2026-06-28 17:45:16'),
(151, 2, 1, 1500.00, 'completed', '2026-07-04 14:31:33'),
(152, 2, 1, 1800.00, 'completed', '2026-07-04 14:33:53'),
(153, 0, 1, 1500.00, 'completed', '2026-07-05 15:18:53'),
(154, 0, 1, 1800.00, 'completed', '2026-07-05 18:43:22'),
(155, 2, 1, 1200.00, 'completed', '2026-07-05 18:46:28'),
(156, 0, 3, 5400.00, 'completed', '2026-07-12 18:59:56'),
(157, 0, 1, 1800.00, 'completed', '2026-07-12 19:01:48'),
(158, 2, 1, 2000.00, 'completed', '2026-07-19 00:54:32'),
(159, 90, 1, 8500.00, 'completed', '2026-07-23 12:17:19'),
(160, 0, 5, 6500.00, 'completed', '2026-08-02 00:04:18'),
(161, 0, 1, 1500.00, 'completed', '2026-08-02 18:26:18'),
(162, 0, 1, 2300.00, 'completed', '2026-08-02 19:07:21'),
(163, 0, 4, 6600.00, 'pending', '2026-08-02 19:11:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_booking_delivery`
--

CREATE TABLE `jboo_agselect_booking_delivery` (
  `id` bigint(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `delivery_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_booking_delivery`
--

INSERT INTO `jboo_agselect_booking_delivery` (`id`, `booking_id`, `delivery_id`) VALUES
(2, 12, 1),
(3, 15, 1),
(4, 18, 1),
(7, 22, 1),
(8, 23, 1),
(9, 27, 1),
(10, 35, 1),
(11, 36, 1),
(12, 40, 1),
(13, 43, 1),
(15, 48, 1),
(16, 49, 1),
(17, 52, 1),
(18, 57, 1),
(20, 61, 1),
(21, 65, 1),
(22, 71, 1),
(23, 76, 1),
(25, 87, 1),
(26, 91, 1),
(27, 92, 1),
(28, 93, 1),
(29, 96, 1),
(30, 97, 1),
(31, 104, 1),
(32, 105, 1),
(33, 108, 1),
(34, 113, 1),
(35, 117, 1),
(36, 118, 1),
(37, 120, 1),
(38, 121, 1),
(39, 123, 1),
(40, 125, 1),
(41, 127, 1),
(42, 129, 1),
(43, 135, 1),
(44, 136, 1),
(45, 140, 1),
(46, 141, 1),
(47, 142, 1),
(48, 146, 1),
(49, 147, 1),
(50, 149, 1),
(51, 160, 1),
(52, 162, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_booking_details`
--

CREATE TABLE `jboo_agselect_booking_details` (
  `id` bigint(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `vehicle_info` text NOT NULL,
  `vehicle_type` varchar(20) NOT NULL,
  `selected_group` bigint(20) NOT NULL,
  `selected_services` text NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_booking_details`
--

INSERT INTO `jboo_agselect_booking_details` (`id`, `booking_id`, `vehicle_info`, `vehicle_type`, `selected_group`, `selected_services`, `subtotal`) VALUES
(1, 1, 'Toyota 4Runner SR5 2019 Gris', 'jeepeta', 1, '[]', 1650.00),
(2, 1, 'Ford F150 2010 Gris', 'camioneta', 1, '[]', 1750.00),
(3, 1, 'Hino N/A N/A Blanco', 'camion', 1, '[]', 2500.00),
(4, 2, 'Toyota Land Cruiser 2005 Blanca', 'suv', 2, '[]', 4250.00),
(5, 3, 'Fiat Fastback 2024 Rojo', 'car', 5, '[]', 950.00),
(6, 4, 'Toyota 4Runner SR5 2019 Gris', 'jeepeta', 1, '[]', 1650.00),
(7, 5, 'Fiat Fastback 2024 Rojo', 'car', 6, '[]', 1500.00),
(8, 6, 'Natan Cohen 2010 Gris', 'suv', 1, '[]', 2250.00),
(9, 6, 'Toyota Land Cruiser 2005 Blanca', 'suv', 4, '[]', 1050.00),
(10, 7, 'Hino 300 2010 Blanco', 'camion', 1, '[]', 2500.00),
(13, 10, 'Ford F150 2010 Gris', 'camioneta', 1, '[]', 1750.00),
(14, 10, 'Hino 300 2010 Blanco', 'camion', 1, '[]', 2500.00),
(15, 10, 'Toyota 4runner 2019 Gris', 'jeepeta', 1, '[]', 1650.00),
(16, 11, 'Chevrolet Corvette 1980 Rojo', 'car', 4, '[]', 850.00),
(17, 11, 'Mercedes Benz 380 SL 1983 Rojo', 'car', 4, '[]', 850.00),
(18, 12, 'Shelby Cobra 1955 Azul', 'car', 4, '[]', 850.00),
(19, 12, 'Porsche Speedster 1600 Super 1956 Verde', 'car', 4, '[]', 850.00),
(20, 13, 'Dodge Challenger SRT 6.4L 2018 Naranja', 'car', 4, '[]', 850.00),
(21, 14, 'Mercedes Benz GLS45 2020 Gris', 'suv', 1, '[]', 2250.00),
(22, 14, 'Mercedes Benz E300 2019 Azul', 'car', 1, '[]', 1450.00),
(23, 14, 'Hino 300 2015 Blanco', 'camion', 1, '[]', 2500.00),
(24, 15, 'Porsche Taycan 2024 Gris', 'car', 4, '[]', 850.00),
(25, 15, 'Porsche 911 2024 Rojo', 'car', 4, '[]', 850.00),
(26, 16, 'Ford F150 2015 gris', 'camioneta', 1, '[]', 1750.00),
(27, 17, 'Mercedes Benz E300 2019 Azul', 'car', 1, '[]', 1450.00),
(28, 17, 'Mercedes Benz GLS 43 2019 Gris', 'suv', 1, '[]', 2250.00),
(29, 17, 'Ford F150 2015 Gris', 'camioneta', 1, '[]', 1750.00),
(30, 18, 'Bugatti Bugatti 1927 rojo', 'car', 4, '[]', 850.00),
(31, 18, 'Allard Allard 1950 Rojo', 'car', 4, '[]', 850.00),
(32, 19, 'Toyota Land Cruiser Prado 2019 marrón', 'suv', 2, '[]', 4250.00),
(39, 22, 'Bugatti Type 35 1927 Rojo', 'car', 7, '[]', 8000.00),
(40, 23, 'Mercedes Benz 300 Diésel 1980 Crema', 'car', 1, '[]', 1450.00),
(41, 24, 'Chevrolet Corvette 1980 Rojo', 'car', 9, '[]', 550.00),
(42, 24, 'Porsche 953 Speedster 1950 verde', 'car', 9, '[]', 550.00),
(43, 24, 'Chevrolet Camaro ss 1980 Gris Oscuro', 'car', 9, '[]', 550.00),
(44, 24, 'Chevrolet Corvette 1955 Negro', 'car', 9, '[]', 550.00),
(45, 24, 'Mercedes Benz SL 1980 Rojo', 'car', 9, '[]', 550.00),
(46, 25, 'Dodge Challenger 6.4 2017 Naranja', 'car', 4, '[]', 850.00),
(47, 26, 'Mazda Cx3 2025 Negra', 'jeepeta', 4, '[]', 950.00),
(48, 26, 'Alfa Romeo Stelvio Quadrifoglio 2020 negro', 'jeepeta', 1, '[]', 1650.00),
(49, 27, 'Chevrolet Silverado 2025 negra', 'camioneta', 1, '[]', 1750.00),
(50, 27, 'Hyundai Tucson 2024 negro', 'jeepeta', 1, '[]', 1650.00),
(51, 28, 'Ford F150 2015 Gris', 'camioneta', 1, '[]', 1750.00),
(52, 29, 'Ford F150 2015 Gris', 'camioneta', 1, '[]', 1750.00),
(53, 30, 'Land Rover Discovery 2020 marrón', 'suv', 8, '[]', 1500.00),
(54, 31, 'Dodge Durango 2019 Blanca', 'suv', 8, '[]', 1500.00),
(55, 32, 'Changan Uni K 2024 Blanca', 'jeepeta', 2, '[]', 2500.00),
(56, 32, 'Geely Gx3 2024 Gris', 'car', 4, '[]', 850.00),
(57, 32, 'Dodge Challenger 2017 Naranja', 'car', 4, '[]', 850.00),
(58, 33, 'Mercedes Benz E300 2017 Azul', 'car', 1, '[]', 1450.00),
(59, 34, 'Mercedes Benz E300 2018 Azul', 'car', 1, '[]', 1450.00),
(60, 34, 'Ford F150 2016 Gris', 'camioneta', 1, '[]', 1750.00),
(61, 35, 'Toyota LandCruiser 2005 Blanca', 'suv', 2, '[]', 3000.00),
(62, 36, 'Honda CRV 2024 Blanca', 'jeepeta', 1, '[]', 1650.00),
(63, 36, 'Chevy Nova 1968 Blanco', 'car', 4, '[]', 850.00),
(64, 36, 'Ford Mustang 1969 Naranja', 'car', 1, '[]', 1450.00),
(65, 37, 'Chevrolet Camaro ZL1 2019 Blanco', 'car', 10, '[]', 1500.00),
(66, 38, 'Dodge Challenger 6.4L 2017 Naranja', 'car', 4, '[]', 850.00),
(67, 39, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(68, 40, 'Toyota LandCruiser 2005 Blanca', 'suv', 1, '[]', 2250.00),
(69, 40, 'Toyota Land Cruiser 2010 Gris', 'suv', 1, '[]', 2250.00),
(70, 41, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(72, 43, 'Toyota Land Cruiser 2005 Blanca', 'suv', 4, '[]', 1050.00),
(73, 44, 'Toyota 4runner 2017 Gris', 'jeepeta', 2, '[]', 2500.00),
(75, 46, 'Ford F150 2000 Blanco', 'camioneta', 1, '[]', 1750.00),
(76, 46, 'Ford F150 2017 Gris', 'camioneta', 1, '[]', 1750.00),
(77, 46, 'Toyota 4runner 2019 Gris', 'jeepeta', 1, '[]', 1650.00),
(78, 46, 'Hino 300 2010 Blanco', 'camion', 1, '[]', 2500.00),
(79, 47, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(80, 48, 'Toyota Prado Gris 2019', 'suv', 13, '[]', 3250.00),
(81, 48, 'Toyota Land Cruiser 2005 Blanca', 'suv', 4, '[]', 1050.00),
(82, 49, 'Ford Expedition 2018 Gris', 'suv', 2, '[]', 3000.00),
(83, 50, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(84, 51, 'Hyundai Tucson 2022 Blanca', 'jeepeta', 1, '[]', 1650.00),
(85, 52, 'Toyota Land Cruiser 2005 Blanca', 'suv', 2, '[]', 3000.00),
(86, 53, 'Dodge Challenger 2012 Negro', 'car', 4, '[]', 850.00),
(87, 54, 'Chevrolet Camaro 2020 Rojo', 'car', 1, '[]', 1450.00),
(88, 55, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(89, 56, 'Changan Unit k 2024 Blanca', 'jeepeta', 2, '[]', 2500.00),
(90, 56, 'Geely Gx3 2024 Gris', 'car', 1, '[]', 1450.00),
(91, 57, 'Toyota Land Cruiser 2005 Blanco', 'suv', 4, '[]', 1050.00),
(92, 58, 'Chevrolet Corvette 2019 Azul', 'car', 10, '[]', 1500.00),
(93, 59, 'Chevrolet Corvette 2019 Azul', 'car', 10, '[]', 1500.00),
(94, 59, 'Chevrolet Corvette 2019 Azul', 'car', 10, '[]', 1500.00),
(96, 61, 'Lexus LX 570 2015 Negro', 'suv', 4, '[]', 1050.00),
(97, 61, 'Ford Mustang GT 2015 Blanco', 'car', 4, '[]', 850.00),
(98, 62, 'Ford Mustang GT 2015 Blanco', 'car', 4, '[]', 850.00),
(99, 62, 'Porsche Cayenne 2020 Blanco', 'jeepeta', 4, '[]', 950.00),
(100, 62, 'Bestune N-a 2024 Blanca', 'jeepeta', 4, '[]', 950.00),
(101, 63, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(102, 64, 'Ford F150 2015 Gris', 'camioneta', 1, '[]', 1750.00),
(103, 64, 'Hino 300 2015 Blanco', 'camion', 1, '[]', 2500.00),
(104, 65, 'Toyota Land Cruiser 2005 Blanco', 'suv', 4, '[]', 1050.00),
(105, 66, 'Porsche GT3 911 2004 Negro', 'car', 1, '[]', 1500.00),
(107, 68, 'Dodge Challenger 2018 Naranja', 'car', 4, '[]', 850.00),
(108, 69, 'Cadillac Escalade 2025 Negra', 'suv', 4, '[]', 1500.00),
(109, 70, 'Ford F150 2014 Gris', 'camioneta', 4, '[]', 1500.00),
(110, 70, 'Mercedes Benz GLS 450 2018 Gris', 'suv', 4, '[]', 1500.00),
(111, 71, 'Toyota Land Cruiser 2005 Blanca', 'suv', 4, '[]', 1500.00),
(112, 72, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(113, 73, 'Ford F150 2015 Gris', 'camioneta', 4, '[]', 1500.00),
(114, 73, 'Mercedes Benz GLS 450 2018 Gris', 'suv', 4, '[]', 1500.00),
(115, 73, 'Mercedes Benz E300 2018 Azul', 'car', 4, '[]', 850.00),
(116, 73, 'Ford F150 2000 Blanco', 'camioneta', 4, '[]', 1500.00),
(117, 74, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(118, 74, 'Cadillac Escalade 2026 Negra', 'suv', 4, '[]', 1500.00),
(119, 75, 'Ford F150 2015 Gris', 'camioneta', 4, '[]', 1500.00),
(120, 75, 'Mercedes Benz E300 2018 Azul', 'car', 4, '[]', 850.00),
(121, 76, 'Land Cruiser VX 2010 Gris', 'suv', 2, '[]', 3000.00),
(122, 76, 'Land Cruiser VX 2005 Blanco', 'suv', 4, '[]', 1500.00),
(123, 77, 'Hino 300 2010 Blanco', 'camion', 4, '[]', 2000.00),
(124, 78, 'Alfa Romeo Stelvio 2020 Negro', 'jeepeta', 4, '[]', 950.00),
(126, 80, 'Mercedes Benz E300 2018 Azul', 'car', 4, '[]', 850.00),
(131, 84, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(132, 85, 'Cadillac Escalade 2026 Negro', 'suv', 4, '[]', 1500.00),
(133, 86, 'Ford F150 2015 Gris', 'camioneta', 4, '[]', 1500.00),
(134, 86, 'Mercedes Benz E300 2018 Azul', 'car', 4, '[]', 850.00),
(135, 87, 'Toyota Land Cruiser VX 2010 Gris', 'suv', 4, '[]', 1500.00),
(136, 88, 'Dodge Challenger 2018 Naranja', 'car', 4, '[]', 850.00),
(137, 89, 'Dodge Durango 2018 Blanco', 'suv', 4, '[]', 1500.00),
(138, 90, 'Ford F150 2000 Blanca', 'camioneta', 4, '[]', 1500.00),
(139, 91, 'Hyundai Tucson 2022 Blanca', 'jeepeta', 4, '[]', 950.00),
(140, 92, 'Toyota Landcruiser 1994 Blanco', 'jeepeta', 4, '[]', 950.00),
(141, 93, 'Toyota Land Cruiser 2020 Gris', 'suv', 2, '[]', 3000.00),
(142, 94, 'Porsche Macan Electric 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(143, 94, 'Cadillac Escalde 2025 Negra', 'suv', 4, '[]', 1500.00),
(144, 95, 'Mercedes Benz E300 2020 Azul', 'car', 4, '[]', 850.00),
(145, 95, 'Ford F150 2018 Gris', 'camioneta', 4, '[]', 1500.00),
(146, 96, 'Chevrolet Corvette 1955 Negro', 'car', 4, '[]', 850.00),
(147, 96, 'Chevrolet Corvette 1980 Rojo', 'car', 4, '[]', 850.00),
(148, 97, 'Ford Mustang GT 2015 Blanco', 'car', 4, '[]', 850.00),
(149, 98, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(150, 98, 'Cadillac Escalade 2026 Negro', 'suv', 4, '[]', 1500.00),
(151, 99, 'Ford Mustang GT 2015 Blanco', 'car', 4, '[]', 850.00),
(152, 100, 'Porsche Macan 2026 Gris', 'jeepeta', 4, '[]', 950.00),
(153, 101, 'Porsche Macan 2025 Gris', 'jeepeta', 4, '[]', 950.00),
(154, 101, 'Cadillac Escalade 2026 Negra', 'suv', 4, '[]', 1500.00),
(155, 102, 'Mercedes Benz GLS450 2026 Gris', 'suv', 4, '[]', 1500.00),
(156, 103, 'Mercedes Benz E300 2019 Azul', 'car', 4, '[]', 850.00),
(157, 104, 'Toyota LandCruiser VX 2005 Blanco', 'suv', 4, '[]', 1500.00),
(158, 105, 'Chevrolet Corvette 2006 Amarillo', 'car', 4, '[]', 850.00),
(159, 105, 'Chevy Nova 1968 Blanco', 'car', 4, '[]', 850.00),
(160, 105, 'Ford Mustang 1969 Naranja', 'car', 4, '[]', 850.00),
(161, 106, 'Ford F150 2000 Blanca', 'camioneta', 15, '[]', 1800.00),
(162, 106, 'Hino 300 2015 Blanco', 'camion', 15, '[]', 2000.00),
(163, 106, 'Mercedes Benz E300 2019 Azul', 'car', 15, '[]', 1200.00),
(164, 106, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(165, 107, 'Jeep Grand Cherokee 2018 Negra', 'jeepeta', 15, '[]', 1500.00),
(166, 107, 'Jetour X70 2025 Blanca', 'jeepeta', 15, '[]', 1500.00),
(167, 108, 'Toyota Land Cruiser VX 2005 Blanca', 'suv', 15, '[]', 1800.00),
(168, 109, 'Ford F150 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(169, 109, 'Mercedes Benz GLS450 2020 Gris', 'suv', 15, '[]', 1800.00),
(170, 110, 'Mazda Cx-30 2024 Roja', 'jeepeta', 20, '[]', 2300.00),
(171, 111, 'Mitsubishi L200 2020 Blanco', 'camioneta', 21, '[]', 3450.00),
(172, 112, 'Toyota Land Cruiser 2010 Gris', 'suv', 22, '[]', 2950.00),
(173, 113, 'Chevrolet Camaro SS 2016 Negro', 'car', 20, '[]', 2000.00),
(174, 113, 'Nissan Frontier 2020 Blanco', 'camioneta', 20, '[]', 2600.00),
(177, 115, 'Hino 300 2015 Blanco', 'camion', 15, '[]', 2000.00),
(178, 116, 'Hyundai Vesloster 2015 Gris', 'car', 18, '[]', 18000.00),
(179, 117, 'Toyota LandCruiser 1995 Blanco', 'suv', 15, '[]', 1800.00),
(180, 118, 'Honda CRV 2024 Blanco', 'jeepeta', 15, '[]', 1500.00),
(181, 118, 'Ford Expedition 2020 Gris', 'suv', 15, '[]', 1800.00),
(182, 119, 'Geely Gx3 2024 Gris', 'car', 15, '[]', 1200.00),
(183, 119, 'Changan Uni K 2024 Blanca', 'jeepeta', 15, '[]', 1500.00),
(184, 120, 'Chevrolet Corvette 2019 Blanco', 'car', 20, '[]', 2000.00),
(185, 120, 'Toyota Raize 2019 Blanco', 'car', 23, '[]', 850.00),
(186, 121, 'Toyota Land Cruiser VX 2020 Gris', 'suv', 15, '[]', 1800.00),
(187, 122, 'Porsche Macan 2025 Gris', 'jeepeta', 15, '[]', 1500.00),
(188, 122, 'Cadillac Escalade 2026 Negra', 'suv', 15, '[]', 1800.00),
(189, 123, 'Ford F150 2018 Gris', 'camioneta', 15, '[]', 1800.00),
(190, 124, 'Geely Starray 2026 Gris', 'jeepeta', 15, '[]', 1500.00),
(191, 125, 'Mercedes Benz E300 2018 Azul', 'car', 15, '[]', 1200.00),
(192, 125, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(193, 126, 'Porsche Macan 2025 Gris', 'jeepeta', 15, '[]', 1500.00),
(194, 127, 'Hyundai Tucson 2024 Blanca', 'jeepeta', 15, '[]', 1500.00),
(195, 127, 'Toyota Land Cruiser 2005 Blanca', 'suv', 15, '[]', 1800.00),
(196, 128, 'Cadillac Escalade 2026 Negra', 'suv', 15, '[]', 1800.00),
(197, 129, 'Toyota Land Cruiser Prado 2020 Gris', 'suv', 15, '[]', 1800.00),
(198, 130, 'Mercedes Benz E300 2019 Azul', 'car', 15, '[]', 1200.00),
(199, 130, 'Shampoo Ceramic wash N/A Verde', 'car', 24, '[]', 1700.00),
(200, 130, 'Mercedea Benz GLS450 2019 Gris', 'suv', 15, '[]', 1800.00),
(201, 130, 'Hino 300 2015 Blanco', 'camion', 15, '[]', 2000.00),
(202, 131, 'Porsche Macan 2025 Gris', 'jeepeta', 15, '[]', 1500.00),
(203, 132, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(204, 132, 'Ford F150 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(205, 133, 'Cadillac Escalade 2026 Negra', 'suv', 15, '[]', 1800.00),
(206, 134, 'Alfa Romeo Stelvio Quadrifoglio 2020 Negro', 'jeepeta', 15, '[]', 1500.00),
(207, 135, 'Toyota Land Cruiser Prado 2020 Gris', 'suv', 15, '[]', 1800.00),
(208, 136, 'Toyota Land Cruiser 2015 Gris', 'suv', 15, '[]', 1800.00),
(209, 137, 'Mercedes Benz E300 2018 Azul', 'car', 15, '[]', 1200.00),
(210, 138, 'Geely Starray 2026 Gris', 'jeepeta', 15, '[]', 1500.00),
(211, 139, 'Cadillac Escalade 2026 Negro', 'suv', 15, '[]', 1800.00),
(212, 140, 'Chevrolet Corvette 2006 Negro', 'car', 15, '[]', 1200.00),
(213, 141, 'Chevrolet Corvette 2006 Negro', 'car', 20, '[]', 2000.00),
(214, 142, 'Ford Mustang 1968 Naranja', 'car', 15, '[]', 1200.00),
(215, 142, 'Chevy Nova 1969 Blanco', 'car', 15, '[]', 1200.00),
(216, 143, 'Porsche Macan 2026 Gris', 'jeepeta', 15, '[]', 1500.00),
(217, 144, 'Mercedes Benz E300 2019 Azul', 'car', 15, '[]', 1200.00),
(218, 144, 'Ford F150 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(219, 145, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(220, 146, 'Toyota LandCruiser Prado 2020 Gris', 'suv', 15, '[]', 1800.00),
(221, 147, 'Mazda CX5 2025 Azul', 'jeepeta', 20, '[]', 2300.00),
(222, 148, 'Mercedes Benz GLS450 2019 Gris', 'suv', 15, '[]', 1800.00),
(223, 148, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(224, 149, 'Toyota LandCruiser VX 2010 Gris', 'suv', 15, '[]', 1800.00),
(225, 149, 'Toyota LandCruiser VX 2000 Blanco', 'suv', 15, '[]', 1800.00),
(226, 150, 'Ford F150 Lariat 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(227, 151, 'Changan Uni K 2024 Blanca', 'jeepeta', 15, '[]', 1500.00),
(228, 152, 'Ford F150 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(229, 153, 'Porsche Macan 2026 Gris', 'jeepeta', 15, '[]', 1500.00),
(230, 154, 'Cadillac Escalade 2026 Negra', 'suv', 15, '[]', 1800.00),
(231, 155, 'Mercedes Benz E300 2019 Azul', 'car', 15, '[]', 1200.00),
(232, 156, 'Ford F150 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(233, 156, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(234, 156, 'Mercedes Benz GLS450 2019 Gris', 'suv', 15, '[]', 1800.00),
(235, 157, 'Cadillac Escalade 2026 Negra', 'suv', 15, '[]', 1800.00),
(236, 158, 'Hino 300 2015 Blanco', 'camion', 15, '[]', 2000.00),
(237, 159, 'Kia Sportage 2019 Negri', 'jeepeta', 17, '[]', 8500.00),
(238, 160, 'Allard Allard 1950 Rojo', 'car', 15, '[]', 1200.00),
(239, 160, 'Shelby Cobra 1955 Azul', 'car', 15, '[]', 1200.00),
(240, 160, 'Bugatti Type 35 1927 Rojo', 'car', 15, '[]', 1200.00),
(241, 160, 'Chevrolet Corvette 1955 Negro', 'car', 15, '[]', 1200.00),
(242, 160, 'Chevrolet Camaro 1969 Gris', 'car', 15, '[]', 1200.00),
(243, 161, 'Porsche Macan 2026 Gris', 'jeepeta', 15, '[]', 1500.00),
(244, 162, 'Toyota Land Cruiser Prado 2020 Gris', 'suv', 15, '[]', 1800.00),
(245, 163, 'Mercedes Benz E300 2019 Azul', 'car', 15, '[]', 1200.00),
(246, 163, 'Ford F150 2015 Gris', 'camioneta', 15, '[]', 1800.00),
(247, 163, 'Mercedes Benz GLS450 2026 Gris', 'suv', 15, '[]', 1800.00),
(248, 163, 'Mercedes Benz GLS450 2019 Gris', 'suv', 15, '[]', 1800.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_booking_meta`
--

CREATE TABLE `jboo_agselect_booking_meta` (
  `id` bigint(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_booking_meta`
--

INSERT INTO `jboo_agselect_booking_meta` (`id`, `booking_id`, `meta_key`, `meta_value`) VALUES
(1, 1, 'user_name', 'Miguel Berroa'),
(2, 1, 'user_email', 'berroa.5@gmail.com'),
(3, 1, 'user_phone', '8098669567'),
(4, 1, 'booking_date', '2025-08-03 19:44'),
(5, 2, 'user_name', 'Natan Cohen'),
(6, 2, 'user_email', 'ginamarielcohen@gmail.com'),
(7, 2, 'user_phone', '8099773156'),
(8, 2, 'booking_date', '2025-08-04 21:46'),
(9, 3, 'user_name', 'Paloma rodriguez'),
(10, 3, 'user_email', 'kpalomarguez@gmail.com'),
(11, 3, 'user_phone', '8098042300'),
(12, 3, 'booking_date', '2025-08-08 22:21'),
(13, 4, 'user_name', 'Miguel Berroa'),
(14, 4, 'user_email', 'berroa.5@gmail.com'),
(15, 4, 'user_phone', '8098669567'),
(16, 4, 'booking_date', '2025-08-09 20:01'),
(17, 5, 'user_name', 'palomarodriguezv'),
(18, 5, 'user_email', 'kpalomarguez@gmail.com'),
(19, 5, 'user_phone', '8098042300'),
(20, 5, 'booking_date', '2025-08-09 22:01'),
(21, 6, 'user_name', 'Natan Cohen'),
(22, 6, 'user_email', 'ginamarielcohen@gmail.com'),
(23, 6, 'user_phone', '8099773156'),
(24, 6, 'booking_date', '2025-08-10 14:20'),
(25, 7, 'user_name', 'Miguel Berroa'),
(26, 7, 'user_email', 'berroa.5@gmail.com'),
(27, 7, 'user_phone', '8098669567'),
(28, 7, 'booking_date', '2025-08-10 19:06'),
(37, 10, 'user_name', 'Miguel Berroa'),
(38, 10, 'user_email', 'berroa.5@gmail.com'),
(39, 10, 'user_phone', '8098669567'),
(40, 10, 'booking_date', '2025-08-16 17:17'),
(41, 11, 'user_name', 'Miguel Franjul'),
(42, 11, 'user_email', 'franjulcorp1@gmail.com'),
(43, 11, 'user_phone', '8297627098'),
(44, 11, 'booking_date', '2025-08-17 15:43'),
(45, 12, 'user_name', 'Miguel Franjul'),
(46, 12, 'user_email', 'franjulcorp1@gmail.com'),
(47, 12, 'user_phone', '8297627098'),
(48, 12, 'booking_date', '2025-08-17 18:04'),
(49, 13, 'user_name', 'Oscar Perez'),
(50, 13, 'user_email', 'orpy85@gmail.com'),
(51, 13, 'user_phone', '8294217120'),
(52, 13, 'booking_date', '2025-09-06 13:35'),
(53, 14, 'user_name', 'Miguel Berroa'),
(54, 14, 'user_email', 'berroa.5@gmail.com'),
(55, 14, 'user_phone', '8098669567'),
(56, 14, 'booking_date', '2025-09-06 16:17'),
(57, 15, 'user_name', 'Miguel Franjul'),
(58, 15, 'user_email', 'franjulcorp1@gmail.com'),
(59, 15, 'user_phone', '8297627098'),
(60, 15, 'booking_date', '2025-09-07 18:21'),
(61, 16, 'user_name', 'Miguel Berroa'),
(62, 16, 'user_email', 'a.ganans@gmail.com'),
(63, 16, 'user_phone', '8098669567'),
(64, 16, 'booking_date', '2025-09-22 20:37'),
(65, 17, 'user_name', 'Miguel Berroa'),
(66, 17, 'user_email', 'berroa.5@gmail.com'),
(67, 17, 'user_phone', '8068669567'),
(68, 17, 'booking_date', '2025-09-28 20:23'),
(69, 18, 'user_name', 'Miguel Franjul'),
(70, 18, 'user_email', 'franjulcorp1@gmail.com'),
(71, 18, 'user_phone', '8297627098'),
(72, 18, 'booking_date', '2025-09-28 20:31'),
(73, 19, 'user_name', 'Natan Cohen'),
(74, 19, 'user_email', 'ginamarielcohen@gmail.com'),
(75, 19, 'user_phone', '8099773156'),
(76, 19, 'booking_date', '2025-09-28 23:07'),
(85, 22, 'user_name', 'Miguel Franjul'),
(86, 22, 'user_email', 'franjulcorp1@gmail.com'),
(87, 22, 'user_phone', '8297627098'),
(88, 22, 'booking_date', '2025-10-08 15:07'),
(89, 23, 'user_name', 'Miguel Franjul'),
(90, 23, 'user_email', 'franjulcorp1@gmail.com'),
(91, 23, 'user_phone', '8297627098'),
(92, 23, 'booking_date', '2025-10-08 15:09'),
(93, 24, 'user_name', 'Miguel Franjul'),
(94, 24, 'user_email', 'franjulcorp1@gmail.com'),
(95, 24, 'user_phone', '8297627098'),
(96, 24, 'booking_date', '2025-10-08 15:11'),
(97, 25, 'user_name', 'Óscar Perez'),
(98, 25, 'user_email', 'orpy85@gmail.com'),
(99, 25, 'user_phone', '8294217120'),
(100, 25, 'booking_date', '2025-10-08 15:15'),
(101, 26, 'user_name', 'Carlos Montero'),
(102, 26, 'user_email', 'calbertomontero@gmail.com'),
(103, 26, 'user_phone', '8296380522'),
(104, 26, 'booking_date', '2025-10-12 12:16'),
(105, 27, 'user_name', 'Miguel Dargam'),
(106, 27, 'user_email', 'mdcateringco@gmail.com'),
(107, 27, 'user_phone', '8297022466'),
(108, 27, 'booking_date', '2025-10-19 17:00'),
(109, 28, 'user_name', 'Miguel Berroa'),
(110, 28, 'user_email', 'berroa.5@gmail.com'),
(111, 28, 'user_phone', '8098669567'),
(112, 28, 'booking_date', '2025-11-03 15:41'),
(113, 29, 'user_name', 'Miguel Berroa'),
(114, 29, 'user_email', 'berroa.5@gmail.com'),
(115, 29, 'user_phone', '8098669567'),
(116, 29, 'booking_date', '2025-11-08 16:01'),
(117, 30, 'user_name', 'Ramses Ramirez'),
(118, 30, 'user_email', 'Ramsesramirezrr@gmail.com'),
(119, 30, 'user_phone', '8492206513'),
(120, 30, 'booking_date', '2025-11-11 12:25'),
(121, 31, 'user_name', 'Manuel Sanabia'),
(122, 31, 'user_email', 'mlsanabia@gmail.com'),
(123, 31, 'user_phone', '8098799689'),
(124, 31, 'booking_date', '2025-11-11 14:26'),
(125, 32, 'user_name', 'Oscar Perez'),
(126, 32, 'user_email', 'orpy85@gmail.com'),
(127, 32, 'user_phone', '8294217120'),
(128, 32, 'booking_date', '2025-11-16 18:33'),
(129, 33, 'user_name', 'Miguel Berroa'),
(130, 33, 'user_email', 'berroa.5@gmail.com'),
(131, 33, 'user_phone', '8098669567'),
(132, 33, 'booking_date', '2025-11-16 18:42'),
(133, 34, 'user_name', 'Miguel Berroa'),
(134, 34, 'user_email', 'berroa.5@gmail.com'),
(135, 34, 'user_phone', '8098669567'),
(136, 34, 'booking_date', '2025-11-23 18:59'),
(137, 35, 'user_name', 'Nathan Cohen'),
(138, 35, 'user_email', 'ginamarielcohen@gmail.com'),
(139, 35, 'user_phone', '8099773156'),
(140, 35, 'booking_date', '2025-11-23 19:02'),
(141, 36, 'user_name', 'Elwin Andrasoni'),
(142, 36, 'user_email', 'elwis@cemautomation.com'),
(143, 36, 'user_phone', '8297707251'),
(144, 36, 'booking_date', '2025-11-28 13:20'),
(145, 37, 'user_name', 'Carlos Montero'),
(146, 37, 'user_email', 'calbertomontero@gmail.com'),
(147, 37, 'user_phone', '8296380522'),
(148, 37, 'booking_date', '2025-11-29 22:32'),
(149, 38, 'user_name', 'Óscar Pérez'),
(150, 38, 'user_email', 'orpy85@gmail.com'),
(151, 38, 'user_phone', '8294217120'),
(152, 38, 'booking_date', '2025-11-29 22:34'),
(153, 39, 'user_name', 'alfpf'),
(154, 39, 'user_email', 'alfredompimentel@gmail.com'),
(155, 39, 'user_phone', '8297121920'),
(156, 39, 'booking_date', '2025-11-30 15:38'),
(157, 40, 'user_name', 'Nathan Cohen'),
(158, 40, 'user_email', 'ginamariecohen@gmail.com'),
(159, 40, 'user_phone', '8099773156'),
(160, 40, 'booking_date', '2025-12-01 20:53'),
(161, 41, 'user_name', 'alfpf'),
(162, 41, 'user_email', 'alfredompimentel@gmail.com'),
(163, 41, 'user_phone', '8297121920'),
(164, 41, 'booking_date', '2025-12-13 12:16'),
(169, 43, 'user_name', 'Nathan Cohen'),
(170, 43, 'user_email', 'ginamarielcohen@gmail.com'),
(171, 43, 'user_phone', '8099773156'),
(172, 43, 'booking_date', '2025-12-13 14:14'),
(173, 44, 'user_name', 'Elias Katime'),
(174, 44, 'user_email', 'arq.katime@gmail.com'),
(175, 44, 'user_phone', '8099105405'),
(176, 44, 'booking_date', '2025-12-13 14:21'),
(181, 46, 'user_name', 'Miguel Berroa'),
(182, 46, 'user_email', 'berroa.5@gmail.com'),
(183, 46, 'user_phone', '8098669567'),
(184, 46, 'booking_date', '2025-12-14 19:21'),
(185, 47, 'user_name', 'alfpf'),
(186, 47, 'user_email', 'alfredompimentel@gmail.com'),
(187, 47, 'user_phone', '8297121920'),
(188, 47, 'booking_date', '2025-12-20 10:37'),
(189, 48, 'user_name', 'Nathan Cohen'),
(190, 48, 'user_email', 'ginamarielcohen@gmail.com'),
(191, 48, 'user_phone', '8099773156'),
(192, 48, 'booking_date', '2025-12-20 16:23'),
(193, 49, 'user_name', 'Elwin Andrasoni'),
(194, 49, 'user_email', 'elwis@cemautomation.com'),
(195, 49, 'user_phone', '8297707251'),
(196, 49, 'booking_date', '2025-12-26 19:03'),
(197, 50, 'user_name', 'alfpf'),
(198, 50, 'user_email', 'alfredompimentel@gmail.com'),
(199, 50, 'user_phone', '8297121920'),
(200, 50, 'booking_date', '2025-12-27 14:18'),
(201, 51, 'user_name', 'Gina Cohen'),
(202, 51, 'user_email', 'ginamarielcohen@gmail.com'),
(203, 51, 'user_phone', '8099773156'),
(204, 51, 'booking_date', '2025-12-27 20:00'),
(205, 52, 'user_name', 'Nathan Cohen'),
(206, 52, 'user_email', 'ginamarielcohen@gmail.com'),
(207, 52, 'user_phone', '8099773156'),
(208, 52, 'booking_date', '2026-01-04 17:08'),
(209, 53, 'user_name', 'Manuel Sanabia'),
(210, 53, 'user_email', 'mlsanabia@gmail.com'),
(211, 53, 'user_phone', '8098799689'),
(212, 53, 'booking_date', '2026-01-08 12:51'),
(213, 54, 'user_name', 'Víctor Madera'),
(214, 54, 'user_email', 'Victor.e.madera@gmail.com'),
(215, 54, 'user_phone', '8099666040'),
(216, 54, 'booking_date', '2026-01-08 18:55'),
(217, 55, 'user_name', 'alfpf'),
(218, 55, 'user_email', 'alfredompimentel@gmail.com'),
(219, 55, 'user_phone', '8297121920'),
(220, 55, 'booking_date', '2026-01-10 12:05'),
(221, 56, 'user_name', 'Oscar Perez'),
(222, 56, 'user_email', 'orpy85@gmail.com'),
(223, 56, 'user_phone', '8294217120'),
(224, 56, 'booking_date', '2026-01-11 11:42'),
(225, 57, 'user_name', 'Nathan Cohen'),
(226, 57, 'user_email', 'ginamarielcohen@gmail.com'),
(227, 57, 'user_phone', '8099773156'),
(228, 57, 'booking_date', '2026-01-11 15:09\n'),
(229, 58, 'user_name', 'Welington Rosado'),
(230, 58, 'user_email', 'werosado@me.com'),
(231, 58, 'user_phone', '8098013096'),
(232, 58, 'booking_date', '2026-01-14 22:08'),
(233, 59, 'user_name', 'Welington Rosado'),
(234, 59, 'user_email', 'werosado@me.com'),
(235, 59, 'user_phone', '8098013096'),
(236, 59, 'booking_date', '2026-01-14 22:20'),
(241, 61, 'user_name', 'Marino Patiño'),
(242, 61, 'user_email', 'Manuel.patino@hotmail.es'),
(243, 61, 'user_phone', '8099912321'),
(244, 61, 'booking_date', '2026-01-17 16:32'),
(245, 62, 'user_name', 'Marino Patiño'),
(246, 62, 'user_email', 'Manuel.patino@hotmail.es'),
(247, 62, 'user_phone', '8099912321'),
(248, 62, 'booking_date', '2026-01-17 16:40'),
(249, 63, 'user_name', 'alfpf'),
(250, 63, 'user_email', 'alfredompimentel@gmail.com'),
(251, 63, 'user_phone', '8297121920'),
(252, 63, 'booking_date', '2026-01-18 11:06'),
(253, 64, 'user_name', 'Miguel Berroa'),
(254, 64, 'user_email', 'berroa.5@gmail.com'),
(255, 64, 'user_phone', '8098669567'),
(256, 64, 'booking_date', '2026-01-18 18:02'),
(257, 65, 'user_name', 'Nathan Cohen'),
(258, 65, 'user_email', 'ginamarielcohen@gmail.com'),
(259, 65, 'user_phone', '8099773156'),
(260, 65, 'booking_date', '2026-01-18 18:13'),
(261, 66, 'user_name', 'Carlos Montero'),
(262, 66, 'user_email', 'calbertomontero@gmail.com'),
(263, 66, 'user_phone', '8296380522'),
(264, 66, 'booking_date', '2026-01-20 12:43'),
(269, 68, 'user_name', 'Oscar Perez'),
(270, 68, 'user_email', 'orpy85@gmail.com'),
(271, 68, 'user_phone', '8294217120'),
(272, 68, 'booking_date', '2026-01-26 19:14'),
(273, 69, 'user_name', 'Alfredo Pimentel'),
(274, 69, 'user_email', 'alfredompimentel@gmail.com'),
(275, 69, 'user_phone', '8297121920'),
(276, 69, 'booking_date', '2026-01-26 19:51'),
(277, 70, 'user_name', 'Miguel Berroa'),
(278, 70, 'user_email', 'berroa5@gmail.com'),
(279, 70, 'user_phone', '8098669567'),
(280, 70, 'booking_date', '2026-01-26 19:56'),
(281, 71, 'user_name', 'Nathan Cohen'),
(282, 71, 'user_email', 'ginamarielcohen@gmail.com'),
(283, 71, 'user_phone', '8099773156'),
(284, 71, 'booking_date', '2026-01-26 20:25'),
(285, 72, 'user_name', 'Alfredo Pimentel'),
(286, 72, 'user_email', 'alfredompimentel@gmail.com'),
(287, 72, 'user_phone', '8297121920'),
(288, 72, 'booking_date', '2026-01-31 12:08'),
(289, 73, 'user_name', 'Miguel Berroa'),
(290, 73, 'user_email', 'berroa.5@gmail.com'),
(291, 73, 'user_phone', '8098669567'),
(292, 73, 'booking_date', '2026-02-01 20:50'),
(293, 74, 'user_name', 'Alfredo Pimentel'),
(294, 74, 'user_email', 'alfredompimentel@gmail.com'),
(295, 74, 'user_phone', '8297121920'),
(296, 74, 'booking_date', '2026-02-07 16:15'),
(297, 75, 'user_name', 'Miguel Berroa'),
(298, 75, 'user_email', 'berroa.5@gmail.com'),
(299, 75, 'user_phone', '8098669567'),
(300, 75, 'booking_date', '2026-02-07 16:25'),
(301, 76, 'user_name', 'Nathan Cohen'),
(302, 76, 'user_email', 'ginamarielcohen@gmail.com'),
(303, 76, 'user_phone', '8099773156'),
(304, 76, 'booking_date', '2026-02-08 20:16'),
(305, 77, 'user_name', 'Miguel Berroa'),
(306, 77, 'user_email', 'berroa.5@gmail.com'),
(307, 77, 'user_phone', '8098669567'),
(308, 77, 'booking_date', '2026-02-08 20:40'),
(309, 78, 'user_name', 'Carlos Montero'),
(310, 78, 'user_email', 'calbertomontero@gmail.com'),
(311, 78, 'user_phone', '8296380522'),
(312, 78, 'booking_date', '2026-02-10 14:16'),
(317, 80, 'user_name', 'Miguel Berroa'),
(318, 80, 'user_email', 'berroa.5@gmail.com'),
(319, 80, 'user_phone', '8098669567'),
(320, 80, 'booking_date', '2026-02-15 16:17'),
(333, 84, 'user_name', 'Alfredo Pimentel'),
(334, 84, 'user_email', 'alfredompimentel@gmail.com'),
(335, 84, 'user_phone', '8297121920'),
(336, 84, 'booking_date', '2026-02-21 19:08'),
(337, 85, 'user_name', 'Alfredo Pimentel'),
(338, 85, 'user_email', 'alfredompimentel@gmail.com'),
(339, 85, 'user_phone', '8297121920'),
(340, 85, 'booking_date', '2026-02-22 18:59'),
(341, 86, 'user_name', 'Miguel Berroa'),
(342, 86, 'user_email', 'berroa.5@gmail.com'),
(343, 86, 'user_phone', '8098669567'),
(344, 86, 'booking_date', '2026-02-22 19:00'),
(345, 87, 'user_name', 'Nathan Cohen'),
(346, 87, 'user_email', 'ginamarielcohen@gmail.com'),
(347, 87, 'user_phone', '8099773156'),
(348, 87, 'booking_date', '2026-02-22 19:02'),
(349, 88, 'user_name', 'Oscar Perez'),
(350, 88, 'user_email', 'orpy85@gmail.com'),
(351, 88, 'user_phone', '8294217120'),
(352, 88, 'booking_date', '2026-03-01 18:00'),
(353, 89, 'user_name', 'Manuel Sanabia'),
(354, 89, 'user_email', 'mlsanabia@gmail.com'),
(355, 89, 'user_phone', '8098799689'),
(356, 89, 'booking_date', '2026-03-01 18:00'),
(357, 90, 'user_name', 'Miguel Berroa'),
(358, 90, 'user_email', 'berroa.5@gmail.com'),
(359, 90, 'user_phone', '8098669567'),
(360, 90, 'booking_date', '2026-03-03 17:00'),
(361, 91, 'user_name', 'Gina Cohen'),
(362, 91, 'user_email', 'ginamarielcohen@gmail.com'),
(363, 91, 'user_phone', '8099773156'),
(364, 91, 'booking_date', '2026-03-02 17:55'),
(365, 92, 'user_name', 'Manuel Vasquez'),
(366, 92, 'user_email', 'manueldrummer14@gmail.com'),
(367, 92, 'user_phone', '8294750514'),
(368, 92, 'booking_date', '2026-03-06 13:00'),
(369, 93, 'user_name', 'Jorge Soto'),
(370, 93, 'user_email', 'jorgersoto10@hotmail.com'),
(371, 93, 'user_phone', '8098826449'),
(372, 93, 'booking_date', '2026-03-08 15:47'),
(373, 94, 'user_name', 'Alfredo Pimentel'),
(374, 94, 'user_email', 'alfredompimentel@gmail.com'),
(375, 94, 'user_phone', '8297121920'),
(376, 94, 'booking_date', '2026-03-08 23:35'),
(377, 95, 'user_name', 'Miguel Berroa'),
(378, 95, 'user_email', 'berroa.5@gmail.con'),
(379, 95, 'user_phone', '8068669567'),
(380, 95, 'booking_date', '2026-03-08 23:40'),
(381, 96, 'user_name', 'Miguel Franjul'),
(382, 96, 'user_email', 'franjulcorp1@gmail.com'),
(383, 96, 'user_phone', '8297627098'),
(384, 96, 'booking_date', '2026-03-14 16:39'),
(385, 97, 'user_name', 'Marino Patiño'),
(386, 97, 'user_email', 'manuel.patino@hotmail.com'),
(387, 97, 'user_phone', '8099912321'),
(388, 97, 'booking_date', '2026-03-14 16:41'),
(389, 98, 'user_name', 'Alfredo Pimentel'),
(390, 98, 'user_email', 'alfredompimentel@gmail.com'),
(391, 98, 'user_phone', '8297121920'),
(392, 98, 'booking_date', '2026-03-14 16:43'),
(393, 99, 'user_name', 'Manuel Patiño'),
(394, 99, 'user_email', 'manuel.patino@hotmail.com'),
(395, 99, 'user_phone', '8099912321'),
(396, 99, 'booking_date', '2026-03-14 17:04'),
(397, 100, 'user_name', 'Alfredo Pimentel'),
(398, 100, 'user_email', 'alfredompimentel@gmail.com'),
(399, 100, 'user_phone', '8297121920'),
(400, 100, 'booking_date', '2026-03-14 17:59'),
(401, 101, 'user_name', 'Alfredo Pimentel'),
(402, 101, 'user_email', 'alfredompimentel@gmail.com'),
(403, 101, 'user_phone', '8297121920'),
(404, 101, 'booking_date', '2026-03-22 17:33'),
(405, 102, 'user_name', 'Miguel Berroa'),
(406, 102, 'user_email', 'berroa.5@gmail.com'),
(407, 102, 'user_phone', '8098669567'),
(408, 102, 'booking_date', '2026-03-22 17:38'),
(409, 103, 'user_name', 'Miguel Berroa'),
(410, 103, 'user_email', 'berroa.5@gmail.com'),
(411, 103, 'user_phone', '8098669567'),
(412, 103, 'booking_date', '2026-03-22 23:19'),
(413, 104, 'user_name', 'Nathan Cohen'),
(414, 104, 'user_email', 'ginamarielcohen@gmail.com'),
(415, 104, 'user_phone', '8099773156'),
(416, 104, 'booking_date', '2026-03-24 12:54'),
(417, 105, 'user_name', 'Elwin Andrasoni'),
(418, 105, 'user_email', 'elwis@cemautomation.com'),
(419, 105, 'user_phone', '8297707251'),
(420, 105, 'booking_date', '2026-03-27 22:38'),
(421, 106, 'user_name', 'Miguel Berroa'),
(422, 106, 'user_email', 'berroa.5@gmail.com'),
(423, 106, 'user_phone', '8098669567'),
(424, 106, 'booking_date', '2026-03-28 18:31'),
(425, 107, 'user_name', 'Marino Patiño'),
(426, 107, 'user_email', 'manuel.patino@hotmail.com'),
(427, 107, 'user_phone', '8099912321'),
(428, 107, 'booking_date', '2026-03-28 23:23'),
(429, 108, 'user_name', 'Nathan Cohen'),
(430, 108, 'user_email', 'ginamarielcohen@gmail.com'),
(431, 108, 'user_phone', '8099773156'),
(432, 108, 'booking_date', '2026-04-04 17:07'),
(433, 109, 'user_name', 'Miguel Berroa'),
(434, 109, 'user_email', 'berroa.5@gmail.com'),
(435, 109, 'user_phone', '8098669567'),
(436, 109, 'booking_date', '2026-04-05 18:59'),
(437, 110, 'user_name', 'Carlos Montero'),
(438, 110, 'user_email', 'calbertomontero@gmail.com'),
(439, 110, 'user_phone', '8296380522'),
(440, 110, 'booking_date', '2026-04-10 19:10'),
(441, 111, 'user_name', 'Elias Katime'),
(442, 111, 'user_email', 'arq.katime@gmail.com'),
(443, 111, 'user_phone', '8099105405'),
(444, 111, 'booking_date', '2026-04-12 08:00'),
(445, 112, 'user_name', 'Nathan Cohen'),
(446, 112, 'user_email', 'ginamarielcohen@gmail.com'),
(447, 112, 'user_phone', '8099773156'),
(448, 112, 'booking_date', '2026-04-11 08:00'),
(449, 113, 'user_name', 'Erick Rafael'),
(450, 113, 'user_email', 'erickmm@outlook.com'),
(451, 113, 'user_phone', '8496296100'),
(452, 113, 'booking_date', '2026-04-12 14:21'),
(457, 115, 'user_name', 'Miguel Berroa'),
(458, 115, 'user_email', 'berroa.5@gmail.com'),
(459, 115, 'user_phone', '8098669567'),
(460, 115, 'booking_date', '2026-04-12 19:53'),
(461, 116, 'user_name', 'Hector Minaya'),
(462, 116, 'user_email', 'hectorminaya84@gmail.com'),
(463, 116, 'user_phone', '8294309010'),
(464, 116, 'booking_date', '2026-04-18 11:49'),
(465, 117, 'user_name', 'Manuel Vasquez'),
(466, 117, 'user_email', 'manueldrummer14@gmail.com'),
(467, 117, 'user_phone', '8294750514'),
(468, 117, 'booking_date', '2026-04-19 15:36'),
(469, 118, 'user_name', 'Elwin Andrasoni'),
(470, 118, 'user_email', 'elwis@cemautomatio.com'),
(471, 118, 'user_phone', '8297707251'),
(472, 118, 'booking_date', '2026-04-19 15:38'),
(473, 119, 'user_name', 'Oscar Perez'),
(474, 119, 'user_email', 'orpy85@gmail.com'),
(475, 119, 'user_phone', '8294217120'),
(476, 119, 'booking_date', '2026-04-19 15:43'),
(477, 120, 'user_name', 'Alejandro Tavarez'),
(478, 120, 'user_email', 'alejandrotavarez01@hotmail.com'),
(479, 120, 'user_phone', '8292900275'),
(480, 120, 'booking_date', '2026-04-24 12:12'),
(481, 121, 'user_name', 'Jorge Soto'),
(482, 121, 'user_email', 'jorgersoto10@gmail.com'),
(483, 121, 'user_phone', '8098826449'),
(484, 121, 'booking_date', '2026-04-25 17:46'),
(485, 122, 'user_name', 'Alfredo Pimentel'),
(486, 122, 'user_email', 'alfredompimentel@gmail.com'),
(487, 122, 'user_phone', '8297121920'),
(488, 122, 'booking_date', '2026-04-25 17:49'),
(489, 123, 'user_name', 'Miguel Berroa'),
(490, 123, 'user_email', 'berroa.5@gmail.com'),
(491, 123, 'user_phone', '8098669567'),
(492, 123, 'booking_date', '2026-04-26 19:22'),
(493, 124, 'user_name', 'Marivic Pimentel'),
(494, 124, 'user_email', 'pimentelmaryvic@gmail.com'),
(495, 124, 'user_phone', '8096966777'),
(496, 124, 'booking_date', '2026-05-02 16:53'),
(497, 125, 'user_name', 'Miguel Berroa'),
(498, 125, 'user_email', 'berroa.5@gmail.com'),
(499, 125, 'user_phone', '8098669567'),
(500, 125, 'booking_date', '2026-05-02 18:53'),
(501, 126, 'user_name', 'Alfredo Pimentel'),
(502, 126, 'user_email', 'alfredompimentel@gmail.com'),
(503, 126, 'user_phone', '8297121920'),
(504, 126, 'booking_date', '2026-05-09 13:04'),
(505, 127, 'user_name', 'Nathan Cohen'),
(506, 127, 'user_email', 'ginamarielcohen@gmail.com'),
(507, 127, 'user_phone', '8099773156'),
(508, 127, 'booking_date', '2026-05-09 19:29'),
(509, 128, 'user_name', 'Alfredo Pimentel'),
(510, 128, 'user_email', 'alfredompimentel@gmail.com'),
(511, 128, 'user_phone', '8297121920'),
(512, 128, 'booking_date', '2026-05-10 15:50'),
(513, 129, 'user_name', 'Jorge Soto'),
(514, 129, 'user_email', 'jorgersoto10@gmail.com'),
(515, 129, 'user_phone', '8098826449'),
(516, 129, 'booking_date', '2026-05-10 15:52'),
(517, 130, 'user_name', 'Miguel Berroa'),
(518, 130, 'user_email', 'berroa.5@gmail.com'),
(519, 130, 'user_phone', '8068669567'),
(520, 130, 'booking_date', '2026-05-17 18:44'),
(521, 131, 'user_name', 'Alfredo Pimentel'),
(522, 131, 'user_email', 'alfredompimentel@gmail.com'),
(523, 131, 'user_phone', '8297121920'),
(524, 131, 'booking_date', '2026-05-23 18:36'),
(525, 132, 'user_name', 'Miguel Berroa'),
(526, 132, 'user_email', 'berroa.5@gmail.com'),
(527, 132, 'user_phone', '8298669567'),
(528, 132, 'booking_date', '2026-05-23 18:38'),
(529, 133, 'user_name', 'Alfredo Pimentel'),
(530, 133, 'user_email', 'alfredompimentel@gmail.com'),
(531, 133, 'user_phone', '8297121920'),
(532, 133, 'booking_date', '2026-05-25 14:05'),
(533, 134, 'user_name', 'Carlos Montero'),
(534, 134, 'user_email', 'calbertomontero@gmail.com'),
(535, 134, 'user_phone', '8296380522'),
(536, 134, 'booking_date', '2026-05-25 14:06'),
(537, 135, 'user_name', 'Jorge Soto'),
(538, 135, 'user_email', 'jorgersoto10@gmail.com'),
(539, 135, 'user_phone', '8098826449'),
(540, 135, 'booking_date', '2026-05-30 18:35'),
(541, 136, 'user_name', 'Nathan Cohen'),
(542, 136, 'user_email', 'ginamarielcohen@gmail.com'),
(543, 136, 'user_phone', '8099773156'),
(544, 136, 'booking_date', '2026-05-31 08:00'),
(545, 137, 'user_name', 'Miguel Berroa'),
(546, 137, 'user_email', 'berroa.5@gmail.com'),
(547, 137, 'user_phone', '8098669567'),
(548, 137, 'booking_date', '2026-06-06 18:09'),
(549, 138, 'user_name', 'Marivic Pimentel'),
(550, 138, 'user_email', 'pimentelmaryvic@gmail.com'),
(551, 138, 'user_phone', '8096966777'),
(552, 138, 'booking_date', '2026-06-07 20:59'),
(553, 139, 'user_name', 'Alfredo Pimentel'),
(554, 139, 'user_email', 'alfredompimentel@gmail.com'),
(555, 139, 'user_phone', '8297121920'),
(556, 139, 'booking_date', '2026-06-07 21:03'),
(557, 140, 'user_name', 'Saul Faringthon'),
(558, 140, 'user_email', 'saulfaringthon@gmail.com'),
(559, 140, 'user_phone', '8493540737'),
(560, 140, 'booking_date', '2026-06-11 18:14'),
(561, 141, 'user_name', 'Saul Faringthon'),
(562, 141, 'user_email', 'saulfaringthon@gmail.com'),
(563, 141, 'user_phone', '8493540737'),
(564, 141, 'booking_date', '2026-06-11 18:53'),
(565, 142, 'user_name', 'Elwin Andrasoni'),
(566, 142, 'user_email', 'elwis@cemautomation.com'),
(567, 142, 'user_phone', '8297707251'),
(568, 142, 'booking_date', '2026-06-12 17:37'),
(569, 143, 'user_name', 'Alfredo Pimentel'),
(570, 143, 'user_email', 'alfredompimentel@gmail.com'),
(571, 143, 'user_phone', '8297121920'),
(572, 143, 'booking_date', '2026-06-13 18:49'),
(573, 144, 'user_name', 'Miguel Berroa'),
(574, 144, 'user_email', 'berroa.5@gmail.com'),
(575, 144, 'user_phone', '8098669567'),
(576, 144, 'booking_date', '2026-06-13 18:51'),
(577, 145, 'user_name', 'Miguel Berroa'),
(578, 145, 'user_email', 'berroa.5@gmail.com'),
(579, 145, 'user_phone', '8098669567'),
(580, 145, 'booking_date', '2026-06-14 13:22'),
(581, 146, 'user_name', 'Jorge Soto'),
(582, 146, 'user_email', 'jorgersoto10@gmail.com'),
(583, 146, 'user_phone', '8098826449'),
(584, 146, 'booking_date', '2026-06-14 14:56'),
(585, 147, 'user_name', 'Mauricia Dominguez'),
(586, 147, 'user_email', 'maudoquez@gmail.com'),
(587, 147, 'user_phone', '8097561465'),
(588, 147, 'booking_date', '2026-06-20 13:55'),
(589, 148, 'user_name', 'Miguel Berroa'),
(590, 148, 'user_email', 'berroa.5@gmail.com'),
(591, 148, 'user_phone', '8098669567'),
(592, 148, 'booking_date', '2026-06-21 18:15'),
(593, 149, 'user_name', 'Nathan Cohen'),
(594, 149, 'user_email', 'ginamarielcohen@gmail.com'),
(595, 149, 'user_phone', '8099773156'),
(596, 149, 'booking_date', '2026-06-28 16:33'),
(597, 150, 'user_name', 'Miguel Berroa'),
(598, 150, 'user_email', 'berroa.5@gmail.com'),
(599, 150, 'user_phone', '8098669567'),
(600, 150, 'booking_date', '2026-06-28 17:44'),
(601, 151, 'user_name', 'Oscar Perez'),
(602, 151, 'user_email', 'orpy85@gmail.com'),
(603, 151, 'user_phone', '8294217120'),
(604, 151, 'booking_date', '2026-07-04 14:28'),
(605, 152, 'user_name', 'Miguel Berroa'),
(606, 152, 'user_email', 'berroa.5@gmail.com'),
(607, 152, 'user_phone', '8098669567'),
(608, 152, 'booking_date', '2026-07-04 14:32'),
(609, 153, 'user_name', 'Alfredo Pimentel'),
(610, 153, 'user_email', 'alfredompimentel@gmail.com'),
(611, 153, 'user_phone', '8297121920'),
(612, 153, 'booking_date', '2026-07-05 15:16'),
(613, 154, 'user_name', 'Alfredo Pimentel'),
(614, 154, 'user_email', 'alfredompimentel@gmail.com'),
(615, 154, 'user_phone', '8297121920'),
(616, 154, 'booking_date', '2026-07-05 18:42'),
(617, 155, 'user_name', 'Miguel Berroa'),
(618, 155, 'user_email', 'berroa.5@gmail.com'),
(619, 155, 'user_phone', '8098669567'),
(620, 155, 'booking_date', '2026-07-05 18:44'),
(621, 156, 'user_name', 'Miguel Berroa'),
(622, 156, 'user_email', 'berroa.5@gmail.com'),
(623, 156, 'user_phone', '8098669567'),
(624, 156, 'booking_date', '2026-07-12 18:58'),
(625, 157, 'user_name', 'Alfredo Pimentel'),
(626, 157, 'user_email', 'alfredompimentel@gmail.com'),
(627, 157, 'user_phone', '8297121920'),
(628, 157, 'booking_date', '2026-07-12 19:00'),
(629, 158, 'user_name', 'Miguel Berroa'),
(630, 158, 'user_email', 'berro.5@gmail.com'),
(631, 158, 'user_phone', '8098669567'),
(632, 158, 'booking_date', '2026-07-19 08:00'),
(633, 159, 'user_name', 'Paul Garcia'),
(634, 159, 'user_email', 'Pafilih@outlook.com'),
(635, 159, 'user_phone', '8299212528'),
(636, 159, 'booking_date', '2026-07-25 08:00'),
(637, 160, 'user_name', 'Miguel Franjul'),
(638, 160, 'user_email', 'franjulcorp1@gmail.com'),
(639, 160, 'user_phone', '8297627098'),
(640, 160, 'booking_date', '2026-08-02 08:00'),
(641, 161, 'user_name', 'Alfredo Pimentel'),
(642, 161, 'user_email', 'alfredompimentel@gmail.com'),
(643, 161, 'user_phone', '8297121920'),
(644, 161, 'booking_date', '2026-08-02 18:25'),
(645, 162, 'user_name', 'Jorge Soto'),
(646, 162, 'user_email', 'jorgersoto10@hotmail.com'),
(647, 162, 'user_phone', '8098826449'),
(648, 162, 'booking_date', '2026-08-02 19:05'),
(649, 163, 'user_name', 'Miguel Berroa'),
(650, 163, 'user_email', 'berroa.5@gmail.com'),
(651, 163, 'user_phone', '8098669567'),
(652, 163, 'booking_date', '2026-08-02 19:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_deliverys`
--

CREATE TABLE `jboo_agselect_deliverys` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_deliverys`
--

INSERT INTO `jboo_agselect_deliverys` (`id`, `name`, `price`, `status`, `created_at`) VALUES
(1, 'Distrito Nacional', 500.00, 'active', '2025-08-11 11:27:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_error_logs`
--

CREATE TABLE `jboo_agselect_error_logs` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `context` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `details` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_membresias`
--

CREATE TABLE `jboo_agselect_membresias` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `completed_bookings` int(11) NOT NULL DEFAULT 0,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_membresias`
--

INSERT INTO `jboo_agselect_membresias` (`id`, `user_id`, `completed_bookings`, `updated_at`) VALUES
(1, 2, 1, '2026-07-20 22:30:05'),
(2, 1, 2, '2026-02-17 23:32:04'),
(3, 7, 1, '2025-08-11 11:53:05'),
(4, 14, 7, '2026-02-10 18:39:57'),
(5, 90, 1, '2026-07-25 19:41:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_membresias_historico`
--

CREATE TABLE `jboo_agselect_membresias_historico` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `completed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_membresias_historico`
--

INSERT INTO `jboo_agselect_membresias_historico` (`id`, `user_id`, `completed_at`) VALUES
(1, 2, '2025-10-12 21:16:28'),
(2, 2, '2025-12-03 20:43:55'),
(3, 2, '2026-01-27 08:57:13'),
(4, 2, '2026-04-20 19:38:54'),
(5, 2, '2026-05-25 14:14:47'),
(6, 2, '2026-06-11 18:56:29'),
(7, 2, '2026-06-30 12:30:51'),
(8, 2, '2026-07-20 22:30:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jboo_agselect_service_groups`
--

CREATE TABLE `jboo_agselect_service_groups` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price_car` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_jeepeta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_suv` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_camioneta` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_camion` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_minivan` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_camion_dos_ejes` decimal(10,2) NOT NULL DEFAULT 0.00,
  `price_trailer` decimal(10,2) NOT NULL DEFAULT 0.00,
  `image` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Volcado de datos para la tabla `jboo_agselect_service_groups`
--

INSERT INTO `jboo_agselect_service_groups` (`id`, `name`, `description`, `price_car`, `price_jeepeta`, `price_suv`, `price_camioneta`, `price_camion`, `price_minivan`, `price_camion_dos_ejes`, `price_trailer`, `image`, `status`, `created_at`) VALUES
(15, '1. Lavado Premium', 'Incluye:\r\n	•	lavado con foam\r\n	•	limpieza interior básica\r\n	•	aspirado\r\n	•	cristales\r\n	•	llantas\r\n💰 Precio:\r\n	•	Carro: RD$1,200\r\n	•	Jeepeta: RD$1,500\r\n	•	SUV: RD$1,800', 1200.00, 1500.00, 1800.00, 1800.00, 2000.00, 1200.00, 2500.00, 2500.00, '', 'active', '2026-03-27 23:48:20'),
(16, '2. Limpieza Profunda Interior', 'Incluye:\r\n	•	vapor\r\n	•	limpieza profunda de asientos y alfombras\r\n	•	eliminación de olores\r\n\r\n💰 Precio:\r\n	• 	Carro: RD$4.000\r\n	•	Jeepeta: RD$6,000\r\n	•	SUV: RD$7,000\r\n	•.     Camioneta: RD$6,000\r\n\r\n            RD$6,000', 4000.00, 6000.00, 7000.00, 7000.00, 7000.00, 4000.00, 7000.00, 0.00, '', 'active', '2026-03-27 23:51:38'),
(17, '3. Brillado + Cera', 'Incluye:\r\n	•	descontaminación química y mecánica\r\n	•	protección con cera\r\n💰 Precio:\r\n•	Carro: RD$6,500\r\n•	Jeepeta: RD$8,500\r\n•	SUV y Camioneta: RD$11,000', 6500.00, 8500.00, 11000.00, 11000.00, 11000.00, 6500.00, 0.00, 0.00, '', 'active', '2026-03-27 23:55:20'),
(18, '4. 🛡️Corrección + Cerámica M888', 'Incluye:\r\n	•	descontaminación completa\r\n	•	pulido correctivo\r\n	•	preparación técnica\r\n	•	aplicación de cerámica (3–4 años)\r\n\r\n💰 Precio:\r\n	•	Carro: RD$18,000\r\n	•	Jeepeta: RD$22,000\r\n	•	SUV: RD$28,000\r\n	•	Camioneta: RD$25,000', 18000.00, 22000.00, 28000.00, 25000.00, 0.00, 0.00, 0.00, 0.00, '', 'active', '2026-03-27 23:57:08'),
(19, '5. 🏆 Plan Premium Mensual', 'Incluye:\r\n	•	4 lavados Premium al mes (1 semanal)\r\n	•	prioridad en agenda\r\n	•	seguimiento del vehículo\r\n💰 Precio:\r\n        •.      Carro: RD$10,000\r\n	•	Jeepeta: RD$12,000\r\n	•	SUV: RD$16,000\r\n	•	Camioneta: RD$14,000\r\n', 10000.00, 12000.00, 16000.00, 14000.00, 0.00, 0.00, 0.00, 0.00, '', 'active', '2026-03-28 00:46:30'),
(20, '1.5 Lavado Premium & Cera', 'Incluye: • lavado con foam • limpieza interior básica • aspirado • cristales • llantas, cera a mano 💰 Precio: • Carro: RD$2,000 • Jeepeta: RD$2,300 • SUV: RD$2,600  •  Camioneta 2,600', 2000.00, 2300.00, 2600.00, 2600.00, 0.00, 0.00, 0.00, 0.00, '', 'active', '2026-04-10 19:09:06'),
(23, 'Lavado Premium', '', 850.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, '', 'inactive', '2026-04-24 11:55:22'),
(24, 'Meguiar’s Ultimate Wash & Wax®', 'Producto en presentación de 48 oz, diseñado para el lavado y mantenimiento de vehículos con recubrimiento cerámico, ayudando a conservar su protección y brillo. Precio RD$1,700 pesos. ', 1700.00, 1700.00, 1700.00, 1700.00, 1700.00, 1700.00, 1700.00, 1700.00, '', 'active', '2026-05-11 16:29:50');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `jboo_agselect_additional_services`
--
ALTER TABLE `jboo_agselect_additional_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indices de la tabla `jboo_agselect_bookings`
--
ALTER TABLE `jboo_agselect_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indices de la tabla `jboo_agselect_booking_delivery`
--
ALTER TABLE `jboo_agselect_booking_delivery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `delivery_id` (`delivery_id`);

--
-- Indices de la tabla `jboo_agselect_booking_details`
--
ALTER TABLE `jboo_agselect_booking_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indices de la tabla `jboo_agselect_booking_meta`
--
ALTER TABLE `jboo_agselect_booking_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `meta_key` (`meta_key`);

--
-- Indices de la tabla `jboo_agselect_deliverys`
--
ALTER TABLE `jboo_agselect_deliverys`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `jboo_agselect_error_logs`
--
ALTER TABLE `jboo_agselect_error_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `context` (`context`),
  ADD KEY `created_at` (`created_at`);

--
-- Indices de la tabla `jboo_agselect_membresias`
--
ALTER TABLE `jboo_agselect_membresias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indices de la tabla `jboo_agselect_membresias_historico`
--
ALTER TABLE `jboo_agselect_membresias_historico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `jboo_agselect_service_groups`
--
ALTER TABLE `jboo_agselect_service_groups`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_additional_services`
--
ALTER TABLE `jboo_agselect_additional_services`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_bookings`
--
ALTER TABLE `jboo_agselect_bookings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_booking_delivery`
--
ALTER TABLE `jboo_agselect_booking_delivery`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_booking_details`
--
ALTER TABLE `jboo_agselect_booking_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=249;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_booking_meta`
--
ALTER TABLE `jboo_agselect_booking_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=653;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_deliverys`
--
ALTER TABLE `jboo_agselect_deliverys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_error_logs`
--
ALTER TABLE `jboo_agselect_error_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_membresias`
--
ALTER TABLE `jboo_agselect_membresias`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_membresias_historico`
--
ALTER TABLE `jboo_agselect_membresias_historico`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `jboo_agselect_service_groups`
--
ALTER TABLE `jboo_agselect_service_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
