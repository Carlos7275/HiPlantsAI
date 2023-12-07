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

 Date: 07/12/2023 10:08:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comandos
-- ----------------------------
DROP TABLE IF EXISTS `comandos`;
CREATE TABLE `comandos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `comando` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comandos
-- ----------------------------
INSERT INTO `comandos` VALUES (1, '¿Que plantas me recomiendas?', 'comando que nos recomienda plantas que no he visitado.', '2023-12-06 21:18:37', '2023-12-06 22:11:45');
INSERT INTO `comandos` VALUES (2, '¿Qué plantas cercanas no he visitado?', 'este comando nos dará las plantas cercanas que no he visitado', '2023-12-06 22:20:17', '2023-12-06 22:20:17');
INSERT INTO `comandos` VALUES (3, '¿Cuales son las plantas mas visitadas?', 'Comando para obtener las plantas mas visitadas', '2023-12-07 17:03:46', '2023-12-07 17:03:46');
INSERT INTO `comandos` VALUES (4, '¿Cuales son las plantas mas visitadas por tiempo?', 'Obtiene las plantas mas visitadas por tiempo', '2023-12-07 17:04:43', '2023-12-07 17:04:43');
INSERT INTO `comandos` VALUES (5, '¿Cuales son las plantas menos visitadas por tiempo?', 'Comando para obtener las plantas menos visitadas por tiempo', '2023-12-07 17:05:10', '2023-12-07 17:05:10');
INSERT INTO `comandos` VALUES (6, '¿Cuales son las Areas mas visitadas?', 'Obtiene las areas mas visitadas', '2023-12-07 17:06:06', '2023-12-07 17:06:06');
INSERT INTO `comandos` VALUES (7, '¿Cuales son las areas menos visitadas?', 'Areas menos visitadas', '2023-12-07 17:06:28', '2023-12-07 17:06:28');

SET FOREIGN_KEY_CHECKS = 1;
