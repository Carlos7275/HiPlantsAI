/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : hiplantsai

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 06/12/2023 13:39:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mapa
-- ----------------------------
DROP TABLE IF EXISTS `mapa`;
CREATE TABLE `mapa`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_planta` bigint NOT NULL,
  `zona` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  `url_imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estatus` int NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mapa_id_planta_foreign`(`id_planta` ASC) USING BTREE,
  CONSTRAINT `mapa_id_planta_foreign` FOREIGN KEY (`id_planta`) REFERENCES `info_plantas` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mapa
-- ----------------------------
INSERT INTO `mapa` VALUES (4, 53325, 'Universidad Autónoma de Sinaloa, Boulevard Poseidon, Los Mochis, Ahome, Sinaloa, 81210, Mexico', 25.8145482, -108.9804586, '/storage/images/6560f71b1b124.jpeg', 1, '2023-11-24 19:18:55', '2023-12-05 01:56:08');
INSERT INTO `mapa` VALUES (5, 78454, 'Jardín Botánico Benjamin Francis Johnston (Parque Sinaloa), 750, Antonio Rosales, Los Mochis, Ahome, Sinaloa, 81200, Mexico', 25.7900944, -109.0044555, '/storage/images/6560f7fd67e25.png', 1, '2023-11-24 19:22:43', '2023-11-24 20:31:33');
INSERT INTO `mapa` VALUES (6, 168420, 'El Fuerte Pte., Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8167137, -109.0108023, '/storage/images/6560f9f162dfa.png', 1, '2023-11-24 19:31:03', '2023-12-04 00:48:52');
INSERT INTO `mapa` VALUES (16, 66339, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8164196, -109.0110177, '/storage/images/656d26ae210e3.jpeg', 1, '2023-12-04 01:09:23', '2023-12-04 01:09:23');
INSERT INTO `mapa` VALUES (17, 64135, 'Universidad Autónoma de Sinaloa, Boulevard Poseidon, Los Mochis, Ahome, Sinaloa, 81210, Mexico', 25.8145289, -108.9798347, '/storage/images/656e81e7d7246.jpeg', 1, '2023-12-05 01:50:48', '2023-12-05 03:20:55');
INSERT INTO `mapa` VALUES (18, 149420, 'Universidad Autónoma de Sinaloa, Boulevard Poseidon, Los Mochis, Ahome, Sinaloa, 81210, Mexico', 25.8146106, -108.9798053, '/storage/images/656e8277c7c68.jpeg', 1, '2023-12-05 01:53:06', '2023-12-05 03:21:36');
INSERT INTO `mapa` VALUES (19, 64135, 'Universidad Autónoma de Sinaloa, Boulevard Poseidon, Los Mochis, Ahome, Sinaloa, 81210, Mexico', 25.8145535, -108.9798948, '/storage/images/656e99fd1ae0e.jpeg', 1, '2023-12-05 03:33:30', '2023-12-05 03:33:30');
INSERT INTO `mapa` VALUES (20, 3666, 'Universidad Autónoma de Sinaloa, Boulevard Poseidon, Los Mochis, Ahome, Sinaloa, 81210, Mexico', 25.814628029544, -108.97966242582, '/storage/images/656e9a0bc2977.jpeg', 0, '2023-12-05 03:33:35', '2023-12-05 03:45:25');
INSERT INTO `mapa` VALUES (21, 130544, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8162875, -109.0110877, '/storage/images/656f780a9bba1.png', 1, '2023-12-05 19:20:55', '2023-12-05 19:20:55');

SET FOREIGN_KEY_CHECKS = 1;
