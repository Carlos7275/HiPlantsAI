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

 Date: 06/12/2023 13:39:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for recorridos
-- ----------------------------
DROP TABLE IF EXISTS `recorridos`;
CREATE TABLE `recorridos`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_mapa` bigint UNSIGNED NOT NULL,
  `id_usuario` bigint UNSIGNED NOT NULL,
  `tiempo` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `recorridos_id_usuario_foreign`(`id_usuario` ASC) USING BTREE,
  INDEX `recorridos_id_mapa_foreign`(`id_mapa` ASC) USING BTREE,
  CONSTRAINT `recorridos_id_mapa_foreign` FOREIGN KEY (`id_mapa`) REFERENCES `mapa` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `recorridos_id_usuario_foreign` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recorridos
-- ----------------------------
INSERT INTO `recorridos` VALUES (25, 16, 1, 21, '2023-12-04 01:11:08', '2023-12-04 01:11:08');
INSERT INTO `recorridos` VALUES (26, 16, 1, 4, '2023-12-04 01:11:55', '2023-12-04 01:11:55');
INSERT INTO `recorridos` VALUES (27, 16, 1, 244, '2023-12-04 01:16:38', '2023-12-04 01:16:38');
INSERT INTO `recorridos` VALUES (28, 16, 1, 5, '2023-12-04 01:16:49', '2023-12-04 01:16:49');
INSERT INTO `recorridos` VALUES (29, 16, 1, 28, '2023-12-04 01:17:37', '2023-12-04 01:17:37');
INSERT INTO `recorridos` VALUES (30, 16, 1, 30, '2023-12-04 01:18:13', '2023-12-04 01:18:13');
INSERT INTO `recorridos` VALUES (31, 16, 1, 2, '2023-12-04 01:18:37', '2023-12-04 01:18:37');
INSERT INTO `recorridos` VALUES (32, 16, 1, 45, '2023-12-04 01:19:45', '2023-12-04 01:19:45');
INSERT INTO `recorridos` VALUES (33, 16, 1, 11, '2023-12-04 01:25:57', '2023-12-04 01:25:57');
INSERT INTO `recorridos` VALUES (34, 16, 1, 3, '2023-12-04 01:34:31', '2023-12-04 01:34:31');
INSERT INTO `recorridos` VALUES (35, 16, 1, 13, '2023-12-04 01:41:30', '2023-12-04 01:41:30');
INSERT INTO `recorridos` VALUES (36, 16, 1, 5, '2023-12-04 01:42:56', '2023-12-04 01:42:56');
INSERT INTO `recorridos` VALUES (37, 16, 1, 5, '2023-12-04 01:43:38', '2023-12-04 01:43:38');
INSERT INTO `recorridos` VALUES (38, 16, 1, 381, '2023-12-04 01:50:07', '2023-12-04 01:50:07');
INSERT INTO `recorridos` VALUES (39, 16, 1, 119, '2023-12-04 01:53:45', '2023-12-04 01:53:45');
INSERT INTO `recorridos` VALUES (40, 16, 1, 18, '2023-12-04 01:54:06', '2023-12-04 01:54:06');
INSERT INTO `recorridos` VALUES (41, 16, 1, 41, '2023-12-04 01:54:55', '2023-12-04 01:54:55');
INSERT INTO `recorridos` VALUES (42, 17, 1, 4, '2023-12-05 01:51:05', '2023-12-05 01:51:05');
INSERT INTO `recorridos` VALUES (43, 17, 1, 4, '2023-12-05 01:51:45', '2023-12-05 01:51:45');
INSERT INTO `recorridos` VALUES (44, 17, 1, 37, '2023-12-05 01:53:24', '2023-12-05 01:53:24');
INSERT INTO `recorridos` VALUES (45, 17, 1, 5, '2023-12-05 01:53:38', '2023-12-05 01:53:38');
INSERT INTO `recorridos` VALUES (46, 17, 1, 19, '2023-12-05 01:53:38', '2023-12-05 01:53:38');
INSERT INTO `recorridos` VALUES (47, 18, 1, 62, '2023-12-05 01:54:53', '2023-12-05 01:54:53');
INSERT INTO `recorridos` VALUES (48, 18, 1, 17, '2023-12-05 01:55:18', '2023-12-05 01:55:18');
INSERT INTO `recorridos` VALUES (49, 17, 1, 5, '2023-12-05 01:55:50', '2023-12-05 01:55:50');
INSERT INTO `recorridos` VALUES (50, 17, 1, 5, '2023-12-05 01:55:51', '2023-12-05 01:55:51');
INSERT INTO `recorridos` VALUES (51, 17, 1, 1, '2023-12-05 01:55:53', '2023-12-05 01:55:53');
INSERT INTO `recorridos` VALUES (52, 17, 1, 10, '2023-12-05 01:56:28', '2023-12-05 01:56:28');
INSERT INTO `recorridos` VALUES (53, 17, 1, 37, '2023-12-05 01:56:28', '2023-12-05 01:56:28');
INSERT INTO `recorridos` VALUES (54, 17, 1, 5, '2023-12-05 01:56:46', '2023-12-05 01:56:46');
INSERT INTO `recorridos` VALUES (55, 17, 1, 5, '2023-12-05 01:56:46', '2023-12-05 01:56:46');
INSERT INTO `recorridos` VALUES (56, 17, 1, 10, '2023-12-05 01:57:09', '2023-12-05 01:57:09');
INSERT INTO `recorridos` VALUES (57, 17, 1, 70, '2023-12-05 01:58:01', '2023-12-05 01:58:01');
INSERT INTO `recorridos` VALUES (58, 17, 1, 13, '2023-12-05 03:20:49', '2023-12-05 03:20:49');
INSERT INTO `recorridos` VALUES (59, 17, 1, 25, '2023-12-05 03:24:37', '2023-12-05 03:24:37');
INSERT INTO `recorridos` VALUES (60, 17, 1, 18, '2023-12-05 03:25:00', '2023-12-05 03:25:00');
INSERT INTO `recorridos` VALUES (61, 17, 1, 3, '2023-12-05 03:27:19', '2023-12-05 03:27:19');
INSERT INTO `recorridos` VALUES (62, 18, 1, 5, '2023-12-05 03:28:47', '2023-12-05 03:28:47');
INSERT INTO `recorridos` VALUES (63, 17, 1, 18, '2023-12-05 03:31:49', '2023-12-05 03:31:49');
INSERT INTO `recorridos` VALUES (64, 17, 1, 77, '2023-12-05 03:33:46', '2023-12-05 03:33:46');
INSERT INTO `recorridos` VALUES (65, 18, 1, 4, '2023-12-05 03:33:56', '2023-12-05 03:33:56');
INSERT INTO `recorridos` VALUES (66, 19, 1, 15, '2023-12-05 03:34:01', '2023-12-05 03:34:01');
INSERT INTO `recorridos` VALUES (67, 20, 1, 5, '2023-12-05 03:34:18', '2023-12-05 03:34:18');
INSERT INTO `recorridos` VALUES (68, 17, 1, 5, '2023-12-05 03:34:30', '2023-12-05 03:34:30');
INSERT INTO `recorridos` VALUES (69, 17, 1, 5, '2023-12-05 03:34:30', '2023-12-05 03:34:30');
INSERT INTO `recorridos` VALUES (70, 19, 1, 5, '2023-12-05 03:34:30', '2023-12-05 03:34:30');
INSERT INTO `recorridos` VALUES (71, 17, 1, 9, '2023-12-05 03:34:49', '2023-12-05 03:34:49');
INSERT INTO `recorridos` VALUES (72, 17, 1, 9, '2023-12-05 03:34:50', '2023-12-05 03:34:50');
INSERT INTO `recorridos` VALUES (73, 17, 1, 30, '2023-12-05 03:35:35', '2023-12-05 03:35:35');
INSERT INTO `recorridos` VALUES (74, 17, 1, 30, '2023-12-05 03:35:35', '2023-12-05 03:35:35');
INSERT INTO `recorridos` VALUES (75, 20, 1, 5, '2023-12-05 03:37:10', '2023-12-05 03:37:10');
INSERT INTO `recorridos` VALUES (76, 17, 1, 100, '2023-12-05 03:37:32', '2023-12-05 03:37:32');
INSERT INTO `recorridos` VALUES (77, 17, 1, 100, '2023-12-05 03:37:32', '2023-12-05 03:37:32');
INSERT INTO `recorridos` VALUES (78, 17, 1, 320, '2023-12-05 03:42:57', '2023-12-05 03:42:57');
INSERT INTO `recorridos` VALUES (79, 17, 1, 320, '2023-12-05 03:42:58', '2023-12-05 03:42:58');
INSERT INTO `recorridos` VALUES (80, 17, 1, 13, '2023-12-05 03:45:39', '2023-12-05 03:45:39');
INSERT INTO `recorridos` VALUES (81, 19, 1, 18, '2023-12-05 03:45:40', '2023-12-05 03:45:40');

SET FOREIGN_KEY_CHECKS = 1;
