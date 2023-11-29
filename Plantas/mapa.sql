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

 Date: 28/11/2023 20:51:29
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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mapa
-- ----------------------------
INSERT INTO `mapa` VALUES (1, 61554, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8162875, -109.0110877, '/storage/images/655ff96839d00.jpeg', 0, '2023-11-24 01:16:33', '2023-11-26 21:45:29');
INSERT INTO `mapa` VALUES (2, 66428, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8160348, -109.0106446, '/storage/images/6560f4ae9f746.png', 1, '2023-11-24 19:08:37', '2023-11-24 19:08:37');
INSERT INTO `mapa` VALUES (3, 69574, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8155861, -109.0098561, '/storage/images/6560f5f43a795.png', 1, '2023-11-24 19:14:01', '2023-11-24 21:05:00');
INSERT INTO `mapa` VALUES (4, 53325, 'Universidad Autónoma de Sinaloa, Boulevard Poseidon, Los Mochis, Ahome, Sinaloa, 81210, Mexico', 25.8145482, -108.9804586, '/storage/images/6560f71b1b124.jpeg', 1, '2023-11-24 19:18:55', '2023-11-24 21:05:13');
INSERT INTO `mapa` VALUES (5, 78454, 'Jardín Botánico Benjamin Francis Johnston (Parque Sinaloa), 750, Antonio Rosales, Los Mochis, Ahome, Sinaloa, 81200, Mexico', 25.7900944, -109.0044555, '/storage/images/6560f7fd67e25.png', 1, '2023-11-24 19:22:43', '2023-11-24 20:31:33');
INSERT INTO `mapa` VALUES (6, 168420, 'El Fuerte Pte., Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8167137, -109.0108023, '/storage/images/6560f9f162dfa.png', 1, '2023-11-24 19:31:03', '2023-11-28 21:54:48');
INSERT INTO `mapa` VALUES (7, 296871, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8162875, -109.0110877, '/storage/images/656661792b65d.png', 1, '2023-11-28 21:54:14', '2023-11-28 21:54:57');
INSERT INTO `mapa` VALUES (8, 72540, 'Ahome, Los Mochis, Ahome, Sinaloa, 81236, Mexico', 25.8162399, -109.0110013, '/storage/images/6566622683dd8.png', 1, '2023-11-28 21:57:09', '2023-11-28 21:57:09');

SET FOREIGN_KEY_CHECKS = 1;
