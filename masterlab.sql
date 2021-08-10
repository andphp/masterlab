/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 127.0.0.1:3306
 Source Schema         : masterlab

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 10/08/2021 10:45:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for agile_board
-- ----------------------------
DROP TABLE IF EXISTS `agile_board`;
CREATE TABLE `agile_board`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `type` enum('status','issue_type','label','module','resolve','priority','assignee') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_filter_backlog` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `is_filter_closed` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `range_type` enum('current_sprint','all','sprints','modules','issue_types') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '看板数据范围',
  `range_data` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '范围数据',
  `is_system` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  INDEX `weight`(`weight`) USING BTREE,
  INDEX `test`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agile_board
-- ----------------------------
INSERT INTO `agile_board` VALUES (1, '进行中的迭代', 0, 'status', 0, 1, 99999, 'current_sprint', '', 1);
INSERT INTO `agile_board` VALUES (2, '整个项目', 0, 'status', 0, 1, 99998, 'all', '', 1);

-- ----------------------------
-- Table structure for agile_board_column
-- ----------------------------
DROP TABLE IF EXISTS `agile_board_column`;
CREATE TABLE `agile_board_column`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `board_id` int(10) UNSIGNED NOT NULL,
  `data` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `board_id`(`board_id`) USING BTREE,
  INDEX `id_and_weight`(`id`, `weight`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agile_board_column
-- ----------------------------
INSERT INTO `agile_board_column` VALUES (1, '准 备', 1, '{\"status\":[\"open\",\"reopen\",\"in_review\",\"delay\"],\"resolve\":[],\"label\":[],\"assignee\":[]}', 3);
INSERT INTO `agile_board_column` VALUES (2, '进行中', 1, '{\"status\":[\"in_progress\"],\"resolve\":[],\"label\":[],\"assignee\":[]}', 2);
INSERT INTO `agile_board_column` VALUES (3, '已完成', 1, '{\"status\":[\"closed\",\"done\"],\"resolve\":[],\"label\":[],\"assignee\":[]}', 1);
INSERT INTO `agile_board_column` VALUES (4, '准备中', 2, '{\"status\":[\"open\",\"reopen\",\"in_review\",\"delay\"],\"resolve\":[],\"label\":[],\"assignee\":[]}', 0);
INSERT INTO `agile_board_column` VALUES (5, '进行中', 2, '{\"status\":[\"in_progress\"],\"resolve\":[],\"label\":[],\"assignee\":[]}', 0);
INSERT INTO `agile_board_column` VALUES (6, '已完成', 2, '{\"status\":[\"closed\",\"done\"],\"resolve\":[],\"label\":[],\"assignee\":[]}', 0);
INSERT INTO `agile_board_column` VALUES (63, '准备中', 19, '{\"status\":[\"open\",\"reopen\",\"in_review\",\"delay\"],\"resolve\":null,\"label\":null,\"assignee\":null}', 3);
INSERT INTO `agile_board_column` VALUES (64, '进行中', 19, '{\"status\":[\"in_progress\"],\"resolve\":null,\"label\":null,\"assignee\":null}', 2);
INSERT INTO `agile_board_column` VALUES (65, '已解决', 19, '{\"status\":[\"closed\",\"done\"],\"resolve\":null,\"label\":null,\"assignee\":null}', 1);

-- ----------------------------
-- Table structure for agile_sprint
-- ----------------------------
DROP TABLE IF EXISTS `agile_sprint`;
CREATE TABLE `agile_sprint`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1为准备中，2为已完成，3为已归档',
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `target` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'sprint目标内容',
  `inspect` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Sprint 评审会议内容',
  `review` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Sprint 回顾会议内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agile_sprint
-- ----------------------------
INSERT INTO `agile_sprint` VALUES (1, 1, '1.0迭代', '', 1, 1, 0, '2020-12-01', '2021-01-11', '', '', '');
INSERT INTO `agile_sprint` VALUES (2, 1, '2.0迭代', '', 0, 1, 0, '2021-02-01', '2021-03-01', '', '', '');
INSERT INTO `agile_sprint` VALUES (4, 46, '2.0迭代', 'xxxx', 1, 1, 0, '2020-02-19', '2020-03-01', '', '', '');
INSERT INTO `agile_sprint` VALUES (5, 46, '1.0迭代', '', 0, 1, 0, '2020-01-17', '2020-07-01', '', '', '');

-- ----------------------------
-- Table structure for agile_sprint_issue_report
-- ----------------------------
DROP TABLE IF EXISTS `agile_sprint_issue_report`;
CREATE TABLE `agile_sprint_issue_report`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sprint_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(3) UNSIGNED DEFAULT NULL,
  `month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `done_count` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数',
  `no_done_count` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `done_count_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `no_done_count_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(10) UNSIGNED DEFAULT 0 COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(10) UNSIGNED DEFAULT 0 COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sprint_id`(`sprint_id`) USING BTREE,
  INDEX `sprintIdAndDate`(`sprint_id`, `date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for field_custom_value
-- ----------------------------
DROP TABLE IF EXISTS `field_custom_value`;
CREATE TABLE `field_custom_value`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` int(10) UNSIGNED DEFAULT NULL,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `custom_field_id` int(11) DEFAULT NULL,
  `parent_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `string_value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `number_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `text_value` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `date_value` datetime(0) DEFAULT NULL,
  `value_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'string',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_index`(`issue_id`, `project_id`, `custom_field_id`) USING BTREE,
  INDEX `issue_id`(`issue_id`) USING BTREE,
  INDEX `issue_id_2`(`issue_id`, `project_id`) USING BTREE,
  INDEX `union_issue_custom`(`issue_id`, `custom_field_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for field_layout_default
-- ----------------------------
DROP TABLE IF EXISTS `field_layout_default`;
CREATE TABLE `field_layout_default`  (
  `id` int(10) UNSIGNED NOT NULL,
  `issue_type` int(10) UNSIGNED DEFAULT NULL,
  `issue_ui_type` tinyint(3) UNSIGNED DEFAULT 1,
  `field_id` int(10) UNSIGNED DEFAULT 0,
  `verticalposition` decimal(18, 0) DEFAULT NULL,
  `ishidden` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `isrequired` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sequence` int(10) UNSIGNED DEFAULT NULL,
  `tab` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_layout_default
-- ----------------------------
INSERT INTO `field_layout_default` VALUES (11192, NULL, NULL, 11192, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11193, NULL, NULL, 11193, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11194, NULL, NULL, 11194, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11195, NULL, NULL, 11195, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11196, NULL, NULL, 11196, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11197, NULL, NULL, 11197, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11198, NULL, NULL, 11198, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11199, NULL, NULL, 11199, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11200, NULL, NULL, 11200, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11201, NULL, NULL, 11201, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11202, NULL, NULL, 11202, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11203, NULL, NULL, 11203, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11204, NULL, NULL, 11204, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11205, NULL, NULL, 11205, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11206, NULL, NULL, 11206, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11207, NULL, NULL, 11207, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11208, NULL, NULL, 11208, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11209, NULL, NULL, 11209, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11210, NULL, NULL, 11210, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11211, NULL, NULL, 11211, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11212, NULL, NULL, 11212, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11213, NULL, NULL, 11213, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11214, NULL, NULL, 11214, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11215, NULL, NULL, 11215, NULL, 'false', 'true', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11216, NULL, NULL, 11216, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11217, NULL, NULL, 11217, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11218, NULL, NULL, 11218, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11219, NULL, NULL, 11219, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11220, NULL, NULL, 11220, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11221, NULL, NULL, 11221, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11222, NULL, NULL, 11222, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11223, NULL, NULL, 11223, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11224, NULL, NULL, 11224, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11225, NULL, NULL, 11225, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11226, NULL, NULL, 11226, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11227, NULL, NULL, 11227, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11228, NULL, NULL, 11228, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11229, NULL, NULL, 11229, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11230, NULL, NULL, 11230, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11231, NULL, NULL, 11231, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11232, NULL, NULL, 11232, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11233, NULL, NULL, 11233, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11234, NULL, NULL, 11234, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11235, NULL, NULL, 11235, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11236, NULL, NULL, 11236, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11237, NULL, NULL, 11237, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11238, NULL, NULL, 11238, NULL, 'false', 'false', NULL, NULL);
INSERT INTO `field_layout_default` VALUES (11239, NULL, NULL, 11239, NULL, 'false', 'false', NULL, NULL);

-- ----------------------------
-- Table structure for field_layout_project_custom
-- ----------------------------
DROP TABLE IF EXISTS `field_layout_project_custom`;
CREATE TABLE `field_layout_project_custom`  (
  `id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `issue_type` int(10) UNSIGNED DEFAULT NULL,
  `issue_ui_type` tinyint(3) UNSIGNED DEFAULT NULL,
  `field_id` int(10) UNSIGNED DEFAULT 0,
  `verticalposition` decimal(18, 0) DEFAULT NULL,
  `ishidden` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `isrequired` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sequence` int(10) UNSIGNED DEFAULT NULL,
  `tab` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for field_main
-- ----------------------------
DROP TABLE IF EXISTS `field_main`;
CREATE TABLE `field_main`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `default_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0,
  `options` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '{}',
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `extra_attr` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '额外的html属性',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_fli_fieldidentifier`(`name`) USING BTREE,
  INDEX `order_weight`(`order_weight`) USING BTREE,
  INDEX `is_system`(`is_system`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_main
-- ----------------------------
INSERT INTO `field_main` VALUES (1, 'summary', '标 题', NULL, 'TEXT', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (2, 'priority', '优先级', NULL, 'PRIORITY', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (3, 'fix_version', '解决版本', NULL, 'VERSION', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (4, 'assignee', '经办人', NULL, 'USER', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (5, 'reporter', '报告人', NULL, 'USER', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (6, 'description', '描 述', NULL, 'MARKDOWN', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (7, 'module', '模 块', NULL, 'MODULE', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (8, 'labels', '标 签', NULL, 'LABELS', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (9, 'environment', '运行环境', '如操作系统，软件平台，硬件环境', 'TEXT', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (10, 'resolve', '解决结果', '主要是面向测试工作着和产品经理', 'RESOLUTION', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (11, 'attachment', '附 件', NULL, 'UPLOAD_FILE', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (12, 'start_date', '开始日期', NULL, 'DATE', NULL, 1, '', 0, '');
INSERT INTO `field_main` VALUES (13, 'due_date', '结束日期', NULL, 'DATE', NULL, 1, NULL, 0, '');
INSERT INTO `field_main` VALUES (14, 'milestone', '里程碑', NULL, 'MILESTONE', NULL, 1, '', 0, '');
INSERT INTO `field_main` VALUES (15, 'sprint', '迭 代', NULL, 'SPRINT', NULL, 1, '', 0, '');
INSERT INTO `field_main` VALUES (17, 'parent_issue', '父事项', NULL, 'ISSUES', NULL, 1, '', 0, '');
INSERT INTO `field_main` VALUES (18, 'effect_version', '影响版本', NULL, 'VERSION', NULL, 1, '', 0, ' multiple');
INSERT INTO `field_main` VALUES (19, 'status', '状 态', NULL, 'STATUS', '1', 1, '', 950, '');
INSERT INTO `field_main` VALUES (20, 'assistants', '协助人', '协助人', 'USER_MULTI', NULL, 1, '', 900, '');
INSERT INTO `field_main` VALUES (21, 'weight', '权 重', '待办事项中的权重值', 'NUMBER', '0', 1, '', 0, 'min=\"0\"');
INSERT INTO `field_main` VALUES (23, 'source', '来源', '', 'TEXT', NULL, 0, 'null', 0, '');
INSERT INTO `field_main` VALUES (26, 'progress', '完成度', '', 'PROGRESS', '0', 1, '', 0, 'min=\"0\" max=\"100\"');
INSERT INTO `field_main` VALUES (27, 'duration', '用时(天)', '', 'TEXT', '1', 1, '', 0, '');
INSERT INTO `field_main` VALUES (28, 'is_start_milestone', '是否起始里程碑', '', 'TEXT', '0', 1, '', 0, '');
INSERT INTO `field_main` VALUES (29, 'is_end_milestone', '是否结束里程碑', '', 'TEXT', '0', 1, '', 0, '');

-- ----------------------------
-- Table structure for field_type
-- ----------------------------
DROP TABLE IF EXISTS `field_type`;
CREATE TABLE `field_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of field_type
-- ----------------------------
INSERT INTO `field_type` VALUES (1, 'TEXT', NULL, 'TEXT');
INSERT INTO `field_type` VALUES (2, 'TEXT_MULTI_LINE', NULL, 'TEXT_MULTI_LINE');
INSERT INTO `field_type` VALUES (3, 'TEXTAREA', NULL, 'TEXTAREA');
INSERT INTO `field_type` VALUES (4, 'RADIO', NULL, 'RADIO');
INSERT INTO `field_type` VALUES (5, 'CHECKBOX', NULL, 'CHECKBOX');
INSERT INTO `field_type` VALUES (6, 'SELECT', NULL, 'SELECT');
INSERT INTO `field_type` VALUES (7, 'SELECT_MULTI', NULL, 'SELECT_MULTI');
INSERT INTO `field_type` VALUES (8, 'DATE', NULL, 'DATE');
INSERT INTO `field_type` VALUES (9, 'LABEL', NULL, 'LABELS');
INSERT INTO `field_type` VALUES (10, 'UPLOAD_IMG', NULL, 'UPLOAD_IMG');
INSERT INTO `field_type` VALUES (11, 'UPLOAD_FILE', NULL, 'UPLOAD_FILE');
INSERT INTO `field_type` VALUES (12, 'VERSION', NULL, 'VERSION');
INSERT INTO `field_type` VALUES (16, 'USER', NULL, 'USER');
INSERT INTO `field_type` VALUES (18, 'GROUP', '已废弃', 'GROUP');
INSERT INTO `field_type` VALUES (19, 'GROUP_MULTI', '已经废弃', 'GROUP_MULTI');
INSERT INTO `field_type` VALUES (20, 'MODULE', NULL, 'MODULE');
INSERT INTO `field_type` VALUES (21, 'Milestone', NULL, 'MILESTONE');
INSERT INTO `field_type` VALUES (22, 'Sprint', NULL, 'SPRINT');
INSERT INTO `field_type` VALUES (25, 'Reslution', NULL, 'RESOLUTION');
INSERT INTO `field_type` VALUES (26, 'Issues', NULL, 'ISSUES');
INSERT INTO `field_type` VALUES (27, 'Markdown', NULL, 'MARKDOWN');
INSERT INTO `field_type` VALUES (28, 'USER_MULTI', NULL, 'USER_MULTI');
INSERT INTO `field_type` VALUES (29, 'NUMBER', '数字输入框', 'NUMBER');
INSERT INTO `field_type` VALUES (30, 'PROGRESS', '进度值', 'PROGRESS');

-- ----------------------------
-- Table structure for hornet_cache_key
-- ----------------------------
DROP TABLE IF EXISTS `hornet_cache_key`;
CREATE TABLE `hornet_cache_key`  (
  `key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `datetime` datetime(0) DEFAULT NULL,
  `expire` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  UNIQUE INDEX `module_key`(`key`, `module`) USING BTREE,
  INDEX `module`(`module`) USING BTREE,
  INDEX `expire`(`expire`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hornet_user
-- ----------------------------
DROP TABLE IF EXISTS `hornet_user`;
CREATE TABLE `hornet_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '用户状态:1正常,2禁用',
  `reg_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `last_login_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone_unique`(`phone`) USING BTREE,
  INDEX `phone`(`phone`, `password`) USING BTREE,
  INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for integrates_repo
-- ----------------------------
DROP TABLE IF EXISTS `integrates_repo`;
CREATE TABLE `integrates_repo`  (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT 0 COMMENT '组织id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '仓库名',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '路径',
  `encoding` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'utf-8' COMMENT '编码',
  `scm` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型：git/gitlab',
  `client` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户端:/usr/bin/git',
  `commits` mediumint(8) UNSIGNED NOT NULL COMMENT '提交次数',
  `account` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `encrypt` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'plain' COMMENT '加密方式：base64',
  `synced` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否异步：1是，0否',
  `last_sync` datetime(0) NOT NULL COMMENT '上次更新时间',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  `extra` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '扩展',
  `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除：1是，0否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of integrates_repo
-- ----------------------------
INSERT INTO `integrates_repo` VALUES (1, 146, 'testZentao', '/www/git_code/test-zentao', 'utf-8', 'Git', '/usr/bin/git', 4, '', '', 'base64', 1, '2021-07-29 16:03:37', '测试版本库', '', 0);
INSERT INTO `integrates_repo` VALUES (2, 0, 'zzs', '/www/git', 'ss', 'git', '/usr/git', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', 'sss', '', 0);
INSERT INTO `integrates_repo` VALUES (3, 0, 'df', 'ddd', 'fff', 'fff', 'dds', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', 'sd', '', 0);
INSERT INTO `integrates_repo` VALUES (4, 92, '项目测试库', 'F:/wwwroot/laravel-manage-api', 'utf-8', 'git', 'git', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', 'saffsss', '', 0);
INSERT INTO `integrates_repo` VALUES (5, 92, 'dssg', 'F:/wwwroot/test-zentao', 'sf', 'git', 'git', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', '', '', 0);
INSERT INTO `integrates_repo` VALUES (6, 92, 'rrr2', 'tttww', 'eredd', 'tttww', 'dfd', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', 'ffsss', '', 1);
INSERT INTO `integrates_repo` VALUES (8, 92, 'dsfgs', 'xxfvb', 'dfg', 'dg', 'dfg', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', 'dg', '', 1);
INSERT INTO `integrates_repo` VALUES (9, 92, 'fgcf', 'cvbcvb', 'bvb', 'vc', '', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', '', '', 1);
INSERT INTO `integrates_repo` VALUES (10, 92, 'fdffff', 'dfdf', 'c', 'cf', '', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', '', '', 0);
INSERT INTO `integrates_repo` VALUES (11, 92, 'cfvbdfb', 'fdgfd', '', 'dfd', 'df', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', '', '', 1);
INSERT INTO `integrates_repo` VALUES (12, 92, 'dfgdf', 'dccv', 'cbvc', 'cvb', 'bcb', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', 'cbc', '', 1);
INSERT INTO `integrates_repo` VALUES (13, 92, 'zbz', 'xcv', '', 'bbxx', '', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', '', '', 1);
INSERT INTO `integrates_repo` VALUES (14, 92, 'cbvxcvb', 'xcvcb', 'xvbx', 'xcvbxvb', 'xbvx', 0, '', '', 'plain', 0, '0000-00-00 00:00:00', '', '', 1);

-- ----------------------------
-- Table structure for issue_assistant
-- ----------------------------
DROP TABLE IF EXISTS `issue_assistant`;
CREATE TABLE `issue_assistant`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `join_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `issue_id`(`issue_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_assistant
-- ----------------------------
INSERT INTO `issue_assistant` VALUES (3, 116, 12165, 0);
INSERT INTO `issue_assistant` VALUES (4, 116, 12166, 0);
INSERT INTO `issue_assistant` VALUES (5, 218, 12164, 0);
INSERT INTO `issue_assistant` VALUES (6, 218, 12165, 0);
INSERT INTO `issue_assistant` VALUES (7, 226, 12164, 0);

-- ----------------------------
-- Table structure for issue_description_template
-- ----------------------------
DROP TABLE IF EXISTS `issue_description_template`;
CREATE TABLE `issue_description_template`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updated` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新增事项时描述的模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_description_template
-- ----------------------------
INSERT INTO `issue_description_template` VALUES (1, 'bug', '\r\n这里输入对bug做出清晰简洁的描述.\r\n\r\n**重现步骤**\r\n1. xx\r\n2. xxx\r\n3. xxxx\r\n4. xxxxxx\r\n\r\n**期望结果**\r\n简洁清晰的描述期望结果\r\n\r\n**实际结果**\r\n简述实际看到的结果，这里可以配上截图\r\n\r\n\r\n**附加说明**\r\n附加或额外的信息\r\n', 0, 1562299460);
INSERT INTO `issue_description_template` VALUES (2, '新功能', '**功能描述**\r\n一句话简洁清晰的描述功能，例如：\r\n作为一个<用户角色>，在<某种条件或时间>下，我想要<完成活动>，以便于<实现价值>\r\n\r\n**功能点**\r\n1. xx\r\n2. xxx\r\n3. xxxx\r\n\r\n**规则和影响**\r\n1. xx\r\n2. xxx\r\n\r\n**解决方案**\r\n 解决方案的描述\r\n\r\n**备用方案**\r\n 备用方案的描述\r\n\r\n**附加内容**\r\n\r\n', 0, 1562300466);

-- ----------------------------
-- Table structure for issue_effect_version
-- ----------------------------
DROP TABLE IF EXISTS `issue_effect_version`;
CREATE TABLE `issue_effect_version`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` int(10) UNSIGNED DEFAULT NULL,
  `version_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of issue_effect_version
-- ----------------------------
INSERT INTO `issue_effect_version` VALUES (1, 219, 2);
INSERT INTO `issue_effect_version` VALUES (2, 220, 1);
INSERT INTO `issue_effect_version` VALUES (3, 220, 2);
INSERT INTO `issue_effect_version` VALUES (4, 221, 1);
INSERT INTO `issue_effect_version` VALUES (5, 221, 2);
INSERT INTO `issue_effect_version` VALUES (6, 230, 1);

-- ----------------------------
-- Table structure for issue_extra_worker_day
-- ----------------------------
DROP TABLE IF EXISTS `issue_extra_worker_day`;
CREATE TABLE `issue_extra_worker_day`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `day` date NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for issue_field_layout_project
-- ----------------------------
DROP TABLE IF EXISTS `issue_field_layout_project`;
CREATE TABLE `issue_field_layout_project`  (
  `id` decimal(18, 0) NOT NULL,
  `fieldlayout` decimal(18, 0) DEFAULT NULL,
  `fieldidentifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `verticalposition` decimal(18, 0) DEFAULT NULL,
  `ishidden` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `isrequired` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `renderertype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_fli_fieldidentifier`(`fieldidentifier`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for issue_file_attachment
-- ----------------------------
DROP TABLE IF EXISTS `issue_file_attachment`;
CREATE TABLE `issue_file_attachment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `issue_id` int(11) DEFAULT 0,
  `tmp_issue_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mime_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `origin_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `created` int(11) DEFAULT 0,
  `file_size` int(11) DEFAULT 0,
  `author` int(11) DEFAULT 0,
  `file_ext` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `attach_issue`(`issue_id`) USING BTREE,
  INDEX `uuid`(`uuid`) USING BTREE,
  INDEX `tmp_issue_id`(`tmp_issue_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_file_attachment
-- ----------------------------
INSERT INTO `issue_file_attachment` VALUES (1, 'XZ1xNpXdRC7P1V2L836231', 0, '', 'image/png', 'be7833db9bddb4494d2a7c3dd659199a.png', 'image/20210803/20210803130738_51771.png', 1627967258, 0, 1, 'png');
INSERT INTO `issue_file_attachment` VALUES (2, 'qbrE9hZhQOpiGyLt378933', 0, '', 'image/png', 'be7833db9bddb4494d2a7c3dd659199a.png', 'image/20210803/20210803130944_15568.png', 1627967384, 0, 1, 'png');

-- ----------------------------
-- Table structure for issue_filter
-- ----------------------------
DROP TABLE IF EXISTS `issue_filter`;
CREATE TABLE `issue_filter`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `author` int(11) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `share_obj` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `share_scope` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'all,group,uid,project,origin',
  `projectid` decimal(18, 0) DEFAULT NULL,
  `filter` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `fav_count` decimal(18, 0) DEFAULT NULL,
  `name_lower` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_adv_query` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为高级查询',
  `adv_query_sort_field` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '高级查询的排序字段',
  `adv_query_sort_by` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'desc' COMMENT '高级查询的排序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sr_author`(`author`) USING BTREE,
  INDEX `searchrequest_filternameLower`(`name_lower`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_filter
-- ----------------------------
INSERT INTO `issue_filter` VALUES (10, '我报告的bug', 1, '', NULL, '', 1, '报告人:@master 类型:Bug sort_field:id sort_by:desc', NULL, NULL, 0, '', 'desc');
INSERT INTO `issue_filter` VALUES (11, '我进行中的', 1, '', NULL, '', 1, '报告人:@master 状态:进行中 sort_field:id sort_by:desc', NULL, NULL, 0, '', 'desc');
INSERT INTO `issue_filter` VALUES (12, '我优先级中的', 1, '', NULL, '', 1, '报告人:@master 优先级:中 sort_field:id sort_by:desc', NULL, NULL, 0, '', 'desc');
INSERT INTO `issue_filter` VALUES (13, '我2.0迭代的事项', 1, '', NULL, '', 1, '报告人:@master 迭代:2.0迭代 sort_field:id sort_by:desc', NULL, NULL, 0, '', 'desc');
INSERT INTO `issue_filter` VALUES (14, '新功能的', 1, '', NULL, '', 1, '类型:新功能 sort_field:id sort_by:desc', NULL, NULL, 0, '', 'desc');

-- ----------------------------
-- Table structure for issue_fix_version
-- ----------------------------
DROP TABLE IF EXISTS `issue_fix_version`;
CREATE TABLE `issue_fix_version`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` int(10) UNSIGNED DEFAULT NULL,
  `version_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_fix_version
-- ----------------------------
INSERT INTO `issue_fix_version` VALUES (1, 218, 2);
INSERT INTO `issue_fix_version` VALUES (2, 219, 2);
INSERT INTO `issue_fix_version` VALUES (3, 220, 0);
INSERT INTO `issue_fix_version` VALUES (4, 221, 1);
INSERT INTO `issue_fix_version` VALUES (5, 230, 1);

-- ----------------------------
-- Table structure for issue_follow
-- ----------------------------
DROP TABLE IF EXISTS `issue_follow`;
CREATE TABLE `issue_follow`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `issue_id`(`issue_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_follow
-- ----------------------------
INSERT INTO `issue_follow` VALUES (1, 116, 1);

-- ----------------------------
-- Table structure for issue_holiday
-- ----------------------------
DROP TABLE IF EXISTS `issue_holiday`;
CREATE TABLE `issue_holiday`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `day` date NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 794 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_holiday
-- ----------------------------
INSERT INTO `issue_holiday` VALUES (780, 1, '2021-10-01', '');
INSERT INTO `issue_holiday` VALUES (781, 1, '2022-01-01', '');
INSERT INTO `issue_holiday` VALUES (782, 1, '2020-10-02', '');
INSERT INTO `issue_holiday` VALUES (783, 1, '2020-10-03', '');
INSERT INTO `issue_holiday` VALUES (784, 1, '2020-10-04', '');
INSERT INTO `issue_holiday` VALUES (785, 1, '2020-10-05', '');
INSERT INTO `issue_holiday` VALUES (786, 1, '2020-10-06', '');
INSERT INTO `issue_holiday` VALUES (787, 1, '2020-10-07', '');
INSERT INTO `issue_holiday` VALUES (788, 1, '2021-10-02', '');
INSERT INTO `issue_holiday` VALUES (789, 1, '2021-10-03', '');
INSERT INTO `issue_holiday` VALUES (790, 1, '2021-10-04', '');
INSERT INTO `issue_holiday` VALUES (791, 1, '2021-10-05', '');
INSERT INTO `issue_holiday` VALUES (792, 1, '2021-10-06', '');
INSERT INTO `issue_holiday` VALUES (793, 1, '2021-10-07', '');

-- ----------------------------
-- Table structure for issue_label
-- ----------------------------
DROP TABLE IF EXISTS `issue_label`;
CREATE TABLE `issue_label`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bg_color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_label
-- ----------------------------
INSERT INTO `issue_label` VALUES (1, 0, '错 误', '#FFFFFF', '#FF0000');
INSERT INTO `issue_label` VALUES (2, 0, '成 功', '#FFFFFF', '#69D100');
INSERT INTO `issue_label` VALUES (3, 0, '警 告', '#FFFFFF', '#F0AD4E');

-- ----------------------------
-- Table structure for issue_label_data
-- ----------------------------
DROP TABLE IF EXISTS `issue_label_data`;
CREATE TABLE `issue_label_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_id` int(10) UNSIGNED DEFAULT NULL,
  `label_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `issue_id`(`issue_id`) USING BTREE,
  INDEX `label_id`(`label_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_label_data
-- ----------------------------
INSERT INTO `issue_label_data` VALUES (3, 120, 4);
INSERT INTO `issue_label_data` VALUES (4, 120, 5);
INSERT INTO `issue_label_data` VALUES (5, 116, 8);
INSERT INTO `issue_label_data` VALUES (6, 116, 10);
INSERT INTO `issue_label_data` VALUES (7, 116, 12);
INSERT INTO `issue_label_data` VALUES (8, 116, 6);
INSERT INTO `issue_label_data` VALUES (9, 116, 8);
INSERT INTO `issue_label_data` VALUES (10, 116, 10);
INSERT INTO `issue_label_data` VALUES (11, 116, 12);
INSERT INTO `issue_label_data` VALUES (12, 116, 6);
INSERT INTO `issue_label_data` VALUES (13, 116, 1);
INSERT INTO `issue_label_data` VALUES (14, 120, 4);
INSERT INTO `issue_label_data` VALUES (15, 120, 5);
INSERT INTO `issue_label_data` VALUES (16, 120, 1);
INSERT INTO `issue_label_data` VALUES (33, 120, 1);
INSERT INTO `issue_label_data` VALUES (34, 120, 4);
INSERT INTO `issue_label_data` VALUES (35, 120, 5);
INSERT INTO `issue_label_data` VALUES (36, 218, 3);
INSERT INTO `issue_label_data` VALUES (37, 220, 1);
INSERT INTO `issue_label_data` VALUES (38, 220, 2);
INSERT INTO `issue_label_data` VALUES (39, 220, 3);
INSERT INTO `issue_label_data` VALUES (40, 221, 1);
INSERT INTO `issue_label_data` VALUES (41, 221, 2);
INSERT INTO `issue_label_data` VALUES (42, 221, 4);
INSERT INTO `issue_label_data` VALUES (43, 226, 3);
INSERT INTO `issue_label_data` VALUES (44, 226, 4);
INSERT INTO `issue_label_data` VALUES (45, 227, 1);
INSERT INTO `issue_label_data` VALUES (46, 227, 2);
INSERT INTO `issue_label_data` VALUES (47, 230, 1);
INSERT INTO `issue_label_data` VALUES (48, 230, 2);
INSERT INTO `issue_label_data` VALUES (49, 230, 3);
INSERT INTO `issue_label_data` VALUES (50, 139, 3);
INSERT INTO `issue_label_data` VALUES (51, 139, 4);

-- ----------------------------
-- Table structure for issue_main
-- ----------------------------
DROP TABLE IF EXISTS `issue_main`;
CREATE TABLE `issue_main`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pkey` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issue_num` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_id` int(11) DEFAULT 0,
  `issue_type` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `creator` int(10) UNSIGNED DEFAULT 0,
  `modifier` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reporter` int(11) DEFAULT 0,
  `assignee` int(11) DEFAULT 0,
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `environment` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `priority` int(11) DEFAULT 0,
  `resolve` int(11) DEFAULT 0,
  `status` int(11) DEFAULT 0,
  `created` int(11) DEFAULT 0,
  `updated` int(11) DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `duration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `resolve_date` date DEFAULT NULL,
  `module` int(11) DEFAULT 0,
  `milestone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sprint` int(11) NOT NULL DEFAULT 0,
  `weight` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '优先级权重值',
  `backlog_weight` int(11) NOT NULL DEFAULT 0 COMMENT 'backlog排序权重',
  `sprint_weight` int(11) NOT NULL DEFAULT 0 COMMENT 'sprint排序权重',
  `assistants` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '甘特图级别',
  `master_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父任务的id,非0表示子任务',
  `have_children` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '是否拥有子任务',
  `followed_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '被关注人数',
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `progress` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '完成百分比',
  `depends` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '前置任务',
  `gant_sprint_weight` int(11) NOT NULL DEFAULT 0 COMMENT '迭代甘特图中该事项在同级的排序权重',
  `gant_hide` tinyint(1) NOT NULL DEFAULT 0 COMMENT '甘特图中是否隐藏该事项',
  `is_start_milestone` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `is_end_milestone` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `issue_created`(`created`) USING BTREE,
  INDEX `issue_updated`(`updated`) USING BTREE,
  INDEX `issue_duedate`(`due_date`) USING BTREE,
  INDEX `issue_assignee`(`assignee`) USING BTREE,
  INDEX `issue_reporter`(`reporter`) USING BTREE,
  INDEX `pkey`(`pkey`) USING BTREE,
  INDEX `summary`(`summary`) USING BTREE,
  INDEX `backlog_weight`(`backlog_weight`) USING BTREE,
  INDEX `sprint_weight`(`sprint_weight`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `gant_sprint_weight`(`gant_sprint_weight`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 140 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_main
-- ----------------------------
INSERT INTO `issue_main` VALUES (1, 'example', '1', 1, 3, 1, 1, 1, 12166, '数据库设计', 'xxxxxx', '', 4, 2, 1, 1579249719, 1582133907, '2021-01-18', '2021-01-19', 2, NULL, 2, NULL, 0, 80, 100000, 1600000, '', 0, 0, 3, 0, 0, 0, '', 999900000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (2, 'example', '2', 1, 3, 1, 1, 1, 1, '服务器端架构设计', 'xxxxxxxxxxxxxxxxxxxxx\r\n1**xxxxxxxx**', '', 3, 2, 1, 1579250062, 1582133914, '2021-01-07', '2021-01-08', 2, NULL, 1, NULL, 1, 80, 0, 1800000, '', 0, 106, 0, 0, 0, 1, '', 998500000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (3, 'example', '3', 1, 2, 1, 1, 1, 12168, '业务模块开发', 'xxxxx', '', 3, 10000, 6, 1579423228, 1579423228, '2020-11-10', '2020-11-24', 1, NULL, 3, NULL, 1, 60, 0, 100000, '', 0, 0, 4, 0, 0, 0, '', 999500000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (4, 'example', '4', 1, 3, 1, 1, 1, 1, '数据库表结构设计', '', '', 4, 2, 1, 1579423320, 1583079970, '2021-04-05', '2021-04-06', 2, NULL, 3, NULL, 1, 0, 200000, 1300000, '', 0, 1, 0, 0, 0, 0, '', 999800000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (5, 'example', '5', 1, 3, 1, 1, 1, 12165, '可行性分析', '', '', 4, 10000, 6, 1581321497, 1581321497, '2020-12-29', '2020-12-30', 2, NULL, 3, NULL, 1, 0, 0, 1700000, '', 0, 0, 3, 0, 0, 0, '', 998300000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (8, 'example', '8', 1, 3, 1, 1, 1, 1, '技术可行性分析', '', '', 4, 10000, 6, 1582199367, 1582199367, '2020-12-25', '2020-12-28', 2, NULL, 3, NULL, 1, 0, 0, 1600000, '', 0, 5, 0, 0, 0, 0, '', 1000000000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (53, 'example', '53', 1, 2, 1, 1, 1, 1, '优化改进事项1', '', '', 4, 2, 1, 1582602961, 1582602961, '2020-12-23', '2020-12-24', 2, NULL, 3, NULL, 2, 0, 0, 100000, '', 0, 0, 0, 0, 5, 0, '', 1000000000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (54, 'example', '54', 1, 2, 1, 1, 1, 1, 'ER关系设计', '', '', 4, 2, 1, 1582602962, 1582602962, '2020-12-21', '2020-12-22', 2, NULL, 3, NULL, 1, 0, 0, 400000, '', 0, 1, 0, 0, 0, 0, '', 1000000000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (64, 'example', '64', 1, 3, 1, 1, 1, 12164, '前端架构设计', '', '', 3, 2, 1, 1582623716, 1582623716, '2020-12-16', '2020-12-17', 2, NULL, 3, NULL, 1, 0, 0, 500000, '', 0, 106, 1, 0, 0, 0, '', 998600000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (87, 'example', '87', 1, 3, 1, 1, 1, 12164, '产品功能说明书', '', '', 3, 10000, 6, 1582693628, 1582693628, '2020-12-15', '2020-12-16', 2, NULL, 3, NULL, 1, 0, 0, 600000, '', 0, 90, 0, 0, 0, 1, '', 998800000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (90, 'example', '90', 1, 3, 1, 1, 1, 1, '产品设计', '', '', 3, 2, 6, 1582983902, 1582983902, '2020-12-01', '2020-12-16', 3, NULL, 3, NULL, 1, 0, 0, 200000, '', 0, 0, 4, 0, 0, 0, '', 1000000000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (94, 'example', '94', 1, 1, 1, 1, 1, 1, '市场可行性分析', '\r\n这里输入对bug做出清晰简洁的描述.\r\n\r\n**重现步骤**\r\n1. xx\r\n2. xxx\r\n3. xxxx\r\n4. xxxxxx\r\n\r\n**期望结果**\r\n简洁清晰的描述期望结果\r\n\r\n**实际结果**\r\n简述实际看到的结果，这里可以配上截图\r\n\r\n\r\n**附加说明**\r\n附加或额外的信息\r\n', '', 2, 2, 6, 1582992127, 1582992127, '2020-12-09', '2020-12-10', 2, NULL, 3, NULL, 1, 0, 0, 1500000, '', 0, 5, 0, 0, 0, 0, '', 999900000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (95, 'example', '95', 1, 3, 1, 1, 1, 1, '交互设计', '', '', 3, 2, 1, 1582993508, 1582993508, '2020-12-07', '2020-12-08', 2, NULL, 3, NULL, 1, 0, 0, 700000, '', 0, 90, 0, 0, 0, 1, '', 999100000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (96, 'example', '96', 1, 3, 1, 1, 1, 1, 'UI设计', '', '', 3, 2, 3, 1582993557, 1582993557, '2020-12-04', '2020-12-05', 1, NULL, 3, NULL, 1, 0, 0, 800000, '', 0, 90, 0, 0, 0, 0, '', 998900000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (97, 'example', '97', 1, 3, 1, 1, 1, 1, '流程图设计', '', '', 3, 2, 1, 1582993719, 1582993719, '2020-12-01', '2020-12-02', 2, NULL, 3, NULL, 1, 0, 0, 900000, '', 0, 90, 0, 0, 0, 2, '', 999000000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (106, 'example', '106', 1, 3, 1, 1, 1, 1, '架构设计', '', '', 3, 2, 3, 1583041489, 1583041489, '2020-12-16', '2021-01-08', 1, NULL, 3, NULL, 1, 0, 0, 1000000, '', 0, 0, 2, 0, 1, 0, '', 998700000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (107, 'example', '107', 1, 3, 1, 1, 1, 1, '用户模块开发编码1', '', '', 3, 2, 1, 1583041630, 1583041630, '2020-11-23', '2020-11-24', 2, NULL, 3, NULL, 1, 0, 0, 1100000, '', 0, 3, 0, 0, 0, 0, '', 999400000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (108, 'example', '108', 1, 3, 1, 1, 1, 1, '产品模块开发编码1', '', '', 3, 2, 3, 1583043244, 1583043244, '2020-11-19', '2020-11-20', 2, NULL, 3, NULL, 1, 0, 0, 1200000, '', 0, 3, 0, 0, 4, 0, '', 999300000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (116, 'example', '116', 1, 3, 1, 1, 1, 1, '日志模块开发x', '', '', 3, 2, 1, 1583044099, 1583079970, '2020-11-17', '2020-11-18', 2, NULL, 3, NULL, 1, 0, 0, 1400000, '12165,12166', 0, 0, 0, 1, 0, 0, '', 998400000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (120, 'example', '120', 1, 3, 1, 1, 1, 1, '优化改进事项2', '![](http://www.masterlab21.com/attachment/image/20200622/20200622195934_26594.jpg)', '', 3, 2, 1, 1583232765, 1583232765, '2020-11-16', '2020-11-17', 2, NULL, 3, NULL, 2, 0, 0, 200000, '', 0, 0, 0, 0, 0, 0, '', 999900000, 0, 0, 0);
INSERT INTO `issue_main` VALUES (139, 'example', '139', 1, 3, 1, 1, 1, 12167, '商城模块编码', '![1cut-202004181604013986.png](/attachment/image/20200418/1cut-202004181604013986.png \"截图-1cut-202004181604013986.png\")', '', 3, 2, 1, 1583242645, 1583242645, '2020-11-10', '2020-11-13', 4, NULL, 3, NULL, 1, 0, 0, 300000, '', 0, 3, 0, 0, 0, 1, '', 999250000, 0, 0, 0);

-- ----------------------------
-- Table structure for issue_moved_issue_key
-- ----------------------------
DROP TABLE IF EXISTS `issue_moved_issue_key`;
CREATE TABLE `issue_moved_issue_key`  (
  `id` decimal(18, 0) NOT NULL,
  `old_issue_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `issue_id` decimal(18, 0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_old_issue_key`(`old_issue_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for issue_priority
-- ----------------------------
DROP TABLE IF EXISTS `issue_priority`;
CREATE TABLE `issue_priority`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sequence` int(10) UNSIGNED DEFAULT 0,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `iconurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status_color` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `font_awesome` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `_key`(`_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_priority
-- ----------------------------
INSERT INTO `issue_priority` VALUES (1, 1, '紧 急', 'very_import', '阻塞开发或测试的工作进度，或影响系统无法运行的错误', '/images/icons/priorities/blocker.png', 'red', NULL, 1);
INSERT INTO `issue_priority` VALUES (2, 2, '重 要', 'import', '系统崩溃，丢失数据或内存溢出等严重错误、或者必需完成的任务', '/images/icons/priorities/critical.png', '#cc0000', NULL, 1);
INSERT INTO `issue_priority` VALUES (3, 3, '高', 'high', '主要的功能无效或流程异常', '/images/icons/priorities/major.png', '#ff0000', NULL, 1);
INSERT INTO `issue_priority` VALUES (4, 4, '中', 'normal', '功能部分无效或对现有系统的改进', '/images/icons/priorities/minor.png', '#006600', NULL, 1);
INSERT INTO `issue_priority` VALUES (5, 5, '低', 'low', '不影响功能和流程的问题', '/images/icons/priorities/trivial.png', '#003300', NULL, 1);

-- ----------------------------
-- Table structure for issue_recycle
-- ----------------------------
DROP TABLE IF EXISTS `issue_recycle`;
CREATE TABLE `issue_recycle`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `delete_user_id` int(10) UNSIGNED NOT NULL,
  `issue_id` int(10) UNSIGNED DEFAULT NULL,
  `pkey` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `issue_num` decimal(18, 0) DEFAULT NULL,
  `project_id` int(11) DEFAULT 0,
  `issue_type` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `creator` int(10) UNSIGNED DEFAULT 0,
  `modifier` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `reporter` int(11) DEFAULT 0,
  `assignee` int(11) DEFAULT 0,
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `environment` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `priority` int(11) DEFAULT 0,
  `resolve` int(11) DEFAULT 0,
  `status` int(11) DEFAULT 0,
  `created` int(11) DEFAULT 0,
  `updated` int(11) DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `resolve_date` datetime(0) DEFAULT NULL,
  `workflow_id` int(11) DEFAULT 0,
  `module` int(11) DEFAULT 0,
  `milestone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sprint` int(11) NOT NULL DEFAULT 0,
  `assistants` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `master_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父任务的id,非0表示子任务',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `time` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `issue_assignee`(`assignee`) USING BTREE,
  INDEX `summary`(`summary`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for issue_resolve
-- ----------------------------
DROP TABLE IF EXISTS `issue_resolve`;
CREATE TABLE `issue_resolve`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sequence` int(10) UNSIGNED DEFAULT 0,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `font_awesome` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `_key`(`_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10102 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_resolve
-- ----------------------------
INSERT INTO `issue_resolve` VALUES (1, 1, '已解决', 'fixed', '事项已经解决', NULL, '#1aaa55', 1);
INSERT INTO `issue_resolve` VALUES (2, 2, '未解决', 'not_fix', '事项不可抗拒原因无法解决', NULL, '#db3b21', 1);
INSERT INTO `issue_resolve` VALUES (3, 3, '事项重复', 'require_duplicate', '事项需要的描述需要有重现步骤', NULL, '#db3b21', 1);
INSERT INTO `issue_resolve` VALUES (4, 4, '信息不完整', 'not_complete', '事项信息描述不完整', NULL, '#db3b21', 1);
INSERT INTO `issue_resolve` VALUES (5, 5, '不能重现', 'not_reproduce', '事项不能重现', NULL, '#db3b21', 1);
INSERT INTO `issue_resolve` VALUES (10000, 6, '结束', 'done', '事项已经解决并关闭掉', NULL, '#1aaa55', 1);
INSERT INTO `issue_resolve` VALUES (10100, 8, '问题不存在', 'issue_not_exists', '事项不存在', NULL, 'rgba(0,0,0,0.85)', 1);
INSERT INTO `issue_resolve` VALUES (10101, 9, '延迟处理', 'delay', '事项将推迟处理', NULL, 'rgba(0,0,0,0.85)', 1);

-- ----------------------------
-- Table structure for issue_status
-- ----------------------------
DROP TABLE IF EXISTS `issue_status`;
CREATE TABLE `issue_status`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sequence` int(10) UNSIGNED DEFAULT 0,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_key` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `font_awesome` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'Default Primary Success Info Warning Danger可选',
  `text_color` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'black' COMMENT '字体颜色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key`(`_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10101 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_status
-- ----------------------------
INSERT INTO `issue_status` VALUES (1, 1, '打 开', 'open', '表示事项被提交等待有人处理', '/images/icons/statuses/open.png', 1, 'info', 'blue');
INSERT INTO `issue_status` VALUES (3, 3, '进行中', 'in_progress', '表示事项在处理当中，尚未完成', '/images/icons/statuses/inprogress.png', 1, 'primary', 'blue');
INSERT INTO `issue_status` VALUES (4, 4, '重新打开', 'reopen', '事项重新被打开,重新进行解决', '/images/icons/statuses/reopened.png', 1, 'warning', 'blue');
INSERT INTO `issue_status` VALUES (5, 5, '已解决', 'resolved', '事项已经解决', '/images/icons/statuses/resolved.png', 1, 'success', 'green');
INSERT INTO `issue_status` VALUES (6, 6, '已关闭', 'closed', '问题处理结果确认后，置于关闭状态。', '/images/icons/statuses/closed.png', 1, 'success', 'green');
INSERT INTO `issue_status` VALUES (10001, 0, '完成', 'done', '表明一件事项已经解决且被实践验证过', '', 1, 'success', 'green');
INSERT INTO `issue_status` VALUES (10002, 9, '回 顾', 'in_review', '该事项正在回顾或检查中', '/images/icons/statuses/information.png', 1, 'info', 'black');
INSERT INTO `issue_status` VALUES (10100, 10, '延迟处理', 'delay', '延迟处理', '/images/icons/statuses/generic.png', 1, 'info', 'black');

-- ----------------------------
-- Table structure for issue_type
-- ----------------------------
DROP TABLE IF EXISTS `issue_type`;
CREATE TABLE `issue_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sequence` decimal(18, 0) DEFAULT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `catalog` enum('Custom','Kanban','Scrum','Standard') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'Standard' COMMENT '类型',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `font_awesome` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `custom_icon_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0,
  `form_desc_tpl_id` int(10) UNSIGNED DEFAULT 0 COMMENT '创建事项时,描述字段对应的模板id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `_key`(`_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_type
-- ----------------------------
INSERT INTO `issue_type` VALUES (1, 1, 'Bug', 'bug', 'Standard', '测试过程、维护过程发现影响系统运行的缺陷', 'fa-bug', NULL, 1, 1);
INSERT INTO `issue_type` VALUES (2, 2, '新功能', 'new_feature', 'Standard', '对系统提出的新功能', 'fa-plus', NULL, 1, 2);
INSERT INTO `issue_type` VALUES (3, 3, '任务', 'task', 'Standard', '需要完成的任务', 'fa-tasks', NULL, 1, 0);
INSERT INTO `issue_type` VALUES (4, 4, '优化改进', 'improve', 'Standard', '对现有系统功能的改进', 'fa-arrow-circle-o-up', NULL, 1, 5);
INSERT INTO `issue_type` VALUES (5, 0, '子任务', 'child_task', 'Standard', '', 'fa-subscript', NULL, 1, 5);
INSERT INTO `issue_type` VALUES (6, 2, '用户故事', 'user_story', 'Scrum', '从用户的角度来描述用户渴望得到的功能。一个好的用户故事包括三个要素：1. 角色；2. 活动　3. 商业价值', 'fa-users', NULL, 1, 2);
INSERT INTO `issue_type` VALUES (7, 3, '技术任务', 'tech_task', 'Scrum', '技术性的任务,如架构设计,数据库选型', 'fa-cogs', NULL, 1, 2);
INSERT INTO `issue_type` VALUES (8, 5, '史诗任务', 'epic', 'Scrum', '大型的或大量的工作，包含许多用户故事', 'fa-address-book-o', NULL, 1, 0);
INSERT INTO `issue_type` VALUES (12, NULL, '甘特图', 'gantt', 'Custom', '', 'fa-exchange', NULL, 0, 0);

-- ----------------------------
-- Table structure for issue_type_scheme
-- ----------------------------
DROP TABLE IF EXISTS `issue_type_scheme`;
CREATE TABLE `issue_type_scheme`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_default` tinyint(3) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '问题方案表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_type_scheme
-- ----------------------------
INSERT INTO `issue_type_scheme` VALUES (1, '默认事项方案', '系统默认的事项方案', 1);
INSERT INTO `issue_type_scheme` VALUES (2, '敏捷开发事项方案', '敏捷开发适用的方案', 1);
INSERT INTO `issue_type_scheme` VALUES (5, '任务管理事项解决方案', '任务管理', 1);

-- ----------------------------
-- Table structure for issue_type_scheme_data
-- ----------------------------
DROP TABLE IF EXISTS `issue_type_scheme_data`;
CREATE TABLE `issue_type_scheme_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scheme_id` int(10) UNSIGNED DEFAULT NULL,
  `type_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `scheme_id`(`scheme_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 496 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '问题方案字表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_type_scheme_data
-- ----------------------------
INSERT INTO `issue_type_scheme_data` VALUES (3, 3, 1);
INSERT INTO `issue_type_scheme_data` VALUES (17, 4, 10000);
INSERT INTO `issue_type_scheme_data` VALUES (471, 2, 1);
INSERT INTO `issue_type_scheme_data` VALUES (472, 2, 2);
INSERT INTO `issue_type_scheme_data` VALUES (473, 2, 3);
INSERT INTO `issue_type_scheme_data` VALUES (474, 2, 4);
INSERT INTO `issue_type_scheme_data` VALUES (475, 2, 6);
INSERT INTO `issue_type_scheme_data` VALUES (476, 2, 7);
INSERT INTO `issue_type_scheme_data` VALUES (477, 2, 8);
INSERT INTO `issue_type_scheme_data` VALUES (488, 5, 3);
INSERT INTO `issue_type_scheme_data` VALUES (489, 5, 4);
INSERT INTO `issue_type_scheme_data` VALUES (490, 5, 5);
INSERT INTO `issue_type_scheme_data` VALUES (491, 1, 1);
INSERT INTO `issue_type_scheme_data` VALUES (492, 1, 2);
INSERT INTO `issue_type_scheme_data` VALUES (493, 1, 3);
INSERT INTO `issue_type_scheme_data` VALUES (494, 1, 4);
INSERT INTO `issue_type_scheme_data` VALUES (495, 1, 5);

-- ----------------------------
-- Table structure for issue_ui
-- ----------------------------
DROP TABLE IF EXISTS `issue_ui`;
CREATE TABLE `issue_ui`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schem_id` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '所属方案id',
  `issue_type_id` int(10) UNSIGNED DEFAULT NULL,
  `ui_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `field_id` int(10) UNSIGNED DEFAULT NULL,
  `order_weight` int(10) UNSIGNED DEFAULT NULL,
  `tab_id` int(10) UNSIGNED DEFAULT 0,
  `required` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否必填项',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2283 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_ui
-- ----------------------------
INSERT INTO `issue_ui` VALUES (205, 1, 8, 'create', 1, 3, 0, 1);
INSERT INTO `issue_ui` VALUES (206, 1, 8, 'create', 2, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (207, 1, 8, 'create', 3, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (208, 1, 8, 'create', 4, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (209, 1, 8, 'create', 5, 0, 2, 0);
INSERT INTO `issue_ui` VALUES (210, 1, 8, 'create', 6, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (211, 1, 8, 'create', 7, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (212, 1, 8, 'create', 8, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (213, 1, 8, 'create', 9, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (214, 1, 8, 'create', 10, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (215, 1, 8, 'create', 11, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (216, 1, 8, 'create', 12, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (217, 1, 8, 'create', 13, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (218, 1, 8, 'create', 14, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (219, 1, 8, 'create', 15, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (220, 1, 8, 'create', 16, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (221, 1, 8, 'edit', 1, 3, 0, 1);
INSERT INTO `issue_ui` VALUES (222, 1, 8, 'edit', 2, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (223, 1, 8, 'edit', 3, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (224, 1, 8, 'edit', 4, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (225, 1, 8, 'edit', 5, 0, 2, 0);
INSERT INTO `issue_ui` VALUES (226, 1, 8, 'edit', 6, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (227, 1, 8, 'edit', 7, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (228, 1, 8, 'edit', 8, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (229, 1, 8, 'edit', 9, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (230, 1, 8, 'edit', 10, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (231, 1, 8, 'edit', 11, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (232, 1, 8, 'edit', 12, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (233, 1, 8, 'edit', 13, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (234, 1, 8, 'edit', 14, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (235, 1, 8, 'edit', 15, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (236, 1, 8, 'edit', 16, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (422, 1, 4, 'create', 1, 14, 0, 1);
INSERT INTO `issue_ui` VALUES (423, 1, 4, 'create', 6, 13, 0, 0);
INSERT INTO `issue_ui` VALUES (424, 1, 4, 'create', 2, 12, 0, 0);
INSERT INTO `issue_ui` VALUES (425, 1, 4, 'create', 3, 11, 0, 0);
INSERT INTO `issue_ui` VALUES (426, 1, 4, 'create', 7, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (427, 1, 4, 'create', 9, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (428, 1, 4, 'create', 8, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (429, 1, 4, 'create', 4, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (430, 1, 4, 'create', 19, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (431, 1, 4, 'create', 10, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (432, 1, 4, 'create', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (433, 1, 4, 'create', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (434, 1, 4, 'create', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (435, 1, 4, 'create', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (436, 1, 4, 'create', 20, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (452, 1, 5, 'create', 1, 14, 0, 1);
INSERT INTO `issue_ui` VALUES (453, 1, 5, 'create', 6, 13, 0, 0);
INSERT INTO `issue_ui` VALUES (454, 1, 5, 'create', 2, 12, 0, 0);
INSERT INTO `issue_ui` VALUES (455, 1, 5, 'create', 7, 11, 0, 0);
INSERT INTO `issue_ui` VALUES (456, 1, 5, 'create', 9, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (457, 1, 5, 'create', 8, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (458, 1, 5, 'create', 3, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (459, 1, 5, 'create', 4, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (460, 1, 5, 'create', 19, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (461, 1, 5, 'create', 10, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (462, 1, 5, 'create', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (463, 1, 5, 'create', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (464, 1, 5, 'create', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (465, 1, 5, 'create', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (466, 1, 5, 'create', 20, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (467, 1, 5, 'edit', 1, 14, 0, 1);
INSERT INTO `issue_ui` VALUES (468, 1, 5, 'edit', 6, 13, 0, 0);
INSERT INTO `issue_ui` VALUES (469, 1, 5, 'edit', 2, 12, 0, 0);
INSERT INTO `issue_ui` VALUES (470, 1, 5, 'edit', 7, 11, 0, 0);
INSERT INTO `issue_ui` VALUES (471, 1, 5, 'edit', 9, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (472, 1, 5, 'edit', 8, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (473, 1, 5, 'edit', 3, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (474, 1, 5, 'edit', 4, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (475, 1, 5, 'edit', 19, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (476, 1, 5, 'edit', 10, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (477, 1, 5, 'edit', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (478, 1, 5, 'edit', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (479, 1, 5, 'edit', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (480, 1, 5, 'edit', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (481, 1, 5, 'edit', 20, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (587, 1, 6, 'create', 1, 7, 0, 1);
INSERT INTO `issue_ui` VALUES (588, 1, 6, 'create', 6, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (589, 1, 6, 'create', 2, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (590, 1, 6, 'create', 8, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (591, 1, 6, 'create', 11, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (592, 1, 6, 'create', 4, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (593, 1, 6, 'create', 21, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (594, 1, 6, 'create', 15, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (595, 1, 6, 'create', 19, 6, 33, 0);
INSERT INTO `issue_ui` VALUES (596, 1, 6, 'create', 10, 5, 33, 0);
INSERT INTO `issue_ui` VALUES (597, 1, 6, 'create', 7, 4, 33, 0);
INSERT INTO `issue_ui` VALUES (598, 1, 6, 'create', 20, 3, 33, 0);
INSERT INTO `issue_ui` VALUES (599, 1, 6, 'create', 9, 2, 33, 0);
INSERT INTO `issue_ui` VALUES (600, 1, 6, 'create', 13, 1, 33, 0);
INSERT INTO `issue_ui` VALUES (601, 1, 6, 'create', 12, 0, 33, 0);
INSERT INTO `issue_ui` VALUES (602, 1, 6, 'edit', 1, 7, 0, 1);
INSERT INTO `issue_ui` VALUES (603, 1, 6, 'edit', 6, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (604, 1, 6, 'edit', 2, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (605, 1, 6, 'edit', 8, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (606, 1, 6, 'edit', 4, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (607, 1, 6, 'edit', 11, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (608, 1, 6, 'edit', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (609, 1, 6, 'edit', 21, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (610, 1, 6, 'edit', 19, 6, 34, 0);
INSERT INTO `issue_ui` VALUES (611, 1, 6, 'edit', 10, 5, 34, 0);
INSERT INTO `issue_ui` VALUES (612, 1, 6, 'edit', 7, 4, 34, 0);
INSERT INTO `issue_ui` VALUES (613, 1, 6, 'edit', 20, 3, 34, 0);
INSERT INTO `issue_ui` VALUES (614, 1, 6, 'edit', 9, 2, 34, 0);
INSERT INTO `issue_ui` VALUES (615, 1, 6, 'edit', 12, 1, 34, 0);
INSERT INTO `issue_ui` VALUES (616, 1, 6, 'edit', 13, 0, 34, 0);
INSERT INTO `issue_ui` VALUES (646, 1, 7, 'create', 1, 7, 0, 1);
INSERT INTO `issue_ui` VALUES (647, 1, 7, 'create', 6, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (648, 1, 7, 'create', 2, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (649, 1, 7, 'create', 8, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (650, 1, 7, 'create', 4, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (651, 1, 7, 'create', 11, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (652, 1, 7, 'create', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (653, 1, 7, 'create', 21, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (654, 1, 7, 'create', 19, 6, 37, 0);
INSERT INTO `issue_ui` VALUES (655, 1, 7, 'create', 10, 5, 37, 0);
INSERT INTO `issue_ui` VALUES (656, 1, 7, 'create', 7, 4, 37, 0);
INSERT INTO `issue_ui` VALUES (657, 1, 7, 'create', 20, 3, 37, 0);
INSERT INTO `issue_ui` VALUES (658, 1, 7, 'create', 9, 2, 37, 0);
INSERT INTO `issue_ui` VALUES (659, 1, 7, 'create', 13, 1, 37, 0);
INSERT INTO `issue_ui` VALUES (660, 1, 7, 'create', 12, 0, 37, 0);
INSERT INTO `issue_ui` VALUES (1060, 1, 9, 'create', 1, 4, 0, 1);
INSERT INTO `issue_ui` VALUES (1061, 1, 9, 'create', 19, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1062, 1, 9, 'create', 3, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1063, 1, 9, 'create', 6, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1064, 1, 9, 'create', 4, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1080, 1, 7, 'edit', 1, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (1081, 1, 7, 'edit', 6, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (1082, 1, 7, 'edit', 2, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (1083, 1, 7, 'edit', 8, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1084, 1, 7, 'edit', 4, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1085, 1, 7, 'edit', 11, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1086, 1, 7, 'edit', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1087, 1, 7, 'edit', 21, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1088, 1, 7, 'edit', 19, 6, 63, 0);
INSERT INTO `issue_ui` VALUES (1089, 1, 7, 'edit', 10, 5, 63, 0);
INSERT INTO `issue_ui` VALUES (1090, 1, 7, 'edit', 7, 4, 63, 0);
INSERT INTO `issue_ui` VALUES (1091, 1, 7, 'edit', 9, 3, 63, 0);
INSERT INTO `issue_ui` VALUES (1092, 1, 7, 'edit', 20, 2, 63, 0);
INSERT INTO `issue_ui` VALUES (1093, 1, 7, 'edit', 12, 1, 63, 0);
INSERT INTO `issue_ui` VALUES (1094, 1, 7, 'edit', 13, 0, 63, 0);
INSERT INTO `issue_ui` VALUES (1095, 1, 4, 'edit', 1, 11, 0, 0);
INSERT INTO `issue_ui` VALUES (1096, 1, 4, 'edit', 6, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (1097, 1, 4, 'edit', 2, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (1098, 1, 4, 'edit', 7, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (1099, 1, 4, 'edit', 4, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (1100, 1, 4, 'edit', 19, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (1101, 1, 4, 'edit', 11, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (1102, 1, 4, 'edit', 12, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1103, 1, 4, 'edit', 13, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1104, 1, 4, 'edit', 15, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1105, 1, 4, 'edit', 20, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1106, 1, 4, 'edit', 21, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1107, 1, 4, 'edit', 8, 3, 64, 0);
INSERT INTO `issue_ui` VALUES (1108, 1, 4, 'edit', 9, 2, 64, 0);
INSERT INTO `issue_ui` VALUES (1109, 1, 4, 'edit', 3, 1, 64, 0);
INSERT INTO `issue_ui` VALUES (1110, 1, 4, 'edit', 10, 0, 64, 0);
INSERT INTO `issue_ui` VALUES (1414, 1, 12, 'edit', 1, 8, 0, 1);
INSERT INTO `issue_ui` VALUES (1415, 1, 12, 'edit', 4, 7, 0, 1);
INSERT INTO `issue_ui` VALUES (1416, 1, 12, 'edit', 15, 6, 0, 1);
INSERT INTO `issue_ui` VALUES (1417, 1, 12, 'edit', 12, 5, 0, 1);
INSERT INTO `issue_ui` VALUES (1418, 1, 12, 'edit', 13, 4, 0, 1);
INSERT INTO `issue_ui` VALUES (1419, 1, 12, 'edit', 27, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1420, 1, 12, 'edit', 28, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1421, 1, 12, 'edit', 29, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1422, 1, 12, 'edit', 6, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1423, 1, 12, 'create', 1, 8, 0, 1);
INSERT INTO `issue_ui` VALUES (1424, 1, 12, 'create', 4, 7, 0, 1);
INSERT INTO `issue_ui` VALUES (1425, 1, 12, 'create', 15, 6, 0, 1);
INSERT INTO `issue_ui` VALUES (1426, 1, 12, 'create', 12, 5, 0, 1);
INSERT INTO `issue_ui` VALUES (1427, 1, 12, 'create', 27, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1428, 1, 12, 'create', 13, 3, 0, 1);
INSERT INTO `issue_ui` VALUES (1429, 1, 12, 'create', 28, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1430, 1, 12, 'create', 29, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1431, 1, 12, 'create', 6, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1432, 1, 2, 'create', 1, 10, 0, 1);
INSERT INTO `issue_ui` VALUES (1433, 1, 2, 'create', 6, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (1434, 1, 2, 'create', 19, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (1435, 1, 2, 'create', 2, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (1436, 1, 2, 'create', 7, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (1437, 1, 2, 'create', 4, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (1438, 1, 2, 'create', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1439, 1, 2, 'create', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1440, 1, 2, 'create', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1441, 1, 2, 'create', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1442, 1, 2, 'create', 21, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1443, 1, 2, 'create', 10, 4, 81, 0);
INSERT INTO `issue_ui` VALUES (1444, 1, 2, 'create', 20, 3, 81, 0);
INSERT INTO `issue_ui` VALUES (1445, 1, 2, 'create', 9, 2, 81, 0);
INSERT INTO `issue_ui` VALUES (1446, 1, 2, 'create', 3, 1, 81, 0);
INSERT INTO `issue_ui` VALUES (1447, 1, 2, 'create', 26, 0, 81, 0);
INSERT INTO `issue_ui` VALUES (1448, 1, 2, 'edit', 1, 11, 0, 1);
INSERT INTO `issue_ui` VALUES (1449, 1, 2, 'edit', 19, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (1450, 1, 2, 'edit', 10, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (1451, 1, 2, 'edit', 6, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (1452, 1, 2, 'edit', 2, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (1453, 1, 2, 'edit', 7, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (1454, 1, 2, 'edit', 4, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (1455, 1, 2, 'edit', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1456, 1, 2, 'edit', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1457, 1, 2, 'edit', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1458, 1, 2, 'edit', 15, 1, 0, 1);
INSERT INTO `issue_ui` VALUES (1459, 1, 2, 'edit', 21, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1460, 1, 2, 'edit', 20, 3, 82, 0);
INSERT INTO `issue_ui` VALUES (1461, 1, 2, 'edit', 9, 2, 82, 0);
INSERT INTO `issue_ui` VALUES (1462, 1, 2, 'edit', 3, 1, 82, 0);
INSERT INTO `issue_ui` VALUES (1463, 1, 2, 'edit', 26, 0, 82, 0);
INSERT INTO `issue_ui` VALUES (1625, 1, 3, 'create', 1, 12, 0, 1);
INSERT INTO `issue_ui` VALUES (1626, 1, 3, 'create', 6, 11, 0, 0);
INSERT INTO `issue_ui` VALUES (1627, 1, 3, 'create', 2, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (1628, 1, 3, 'create', 7, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (1629, 1, 3, 'create', 8, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (1630, 1, 3, 'create', 4, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (1631, 1, 3, 'create', 20, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (1632, 1, 3, 'create', 19, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (1633, 1, 3, 'create', 10, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1634, 1, 3, 'create', 11, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1635, 1, 3, 'create', 12, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1636, 1, 3, 'create', 13, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1637, 1, 3, 'create', 15, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1638, 1, 3, 'create', 3, 4, 90, 0);
INSERT INTO `issue_ui` VALUES (1639, 1, 3, 'create', 9, 3, 90, 0);
INSERT INTO `issue_ui` VALUES (1640, 1, 3, 'create', 21, 2, 90, 0);
INSERT INTO `issue_ui` VALUES (1641, 1, 3, 'create', 23, 1, 90, 0);
INSERT INTO `issue_ui` VALUES (1642, 1, 3, 'create', 26, 0, 90, 0);
INSERT INTO `issue_ui` VALUES (1643, 1, 3, 'edit', 1, 13, 0, 1);
INSERT INTO `issue_ui` VALUES (1644, 1, 3, 'edit', 6, 12, 0, 0);
INSERT INTO `issue_ui` VALUES (1645, 1, 3, 'edit', 2, 11, 0, 0);
INSERT INTO `issue_ui` VALUES (1646, 1, 3, 'edit', 7, 10, 0, 0);
INSERT INTO `issue_ui` VALUES (1647, 1, 3, 'edit', 8, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (1648, 1, 3, 'edit', 4, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (1649, 1, 3, 'edit', 20, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (1650, 1, 3, 'edit', 19, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (1651, 1, 3, 'edit', 10, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (1652, 1, 3, 'edit', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (1653, 1, 3, 'edit', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (1654, 1, 3, 'edit', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (1655, 1, 3, 'edit', 26, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (1656, 1, 3, 'edit', 15, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (1657, 1, 3, 'edit', 9, 3, 91, 0);
INSERT INTO `issue_ui` VALUES (1658, 1, 3, 'edit', 3, 2, 91, 0);
INSERT INTO `issue_ui` VALUES (1659, 1, 3, 'edit', 23, 1, 91, 0);
INSERT INTO `issue_ui` VALUES (1660, 1, 3, 'edit', 21, 0, 91, 0);
INSERT INTO `issue_ui` VALUES (2229, 1, 1, 'create', 1, 9, 0, 1);
INSERT INTO `issue_ui` VALUES (2230, 1, 1, 'create', 6, 8, 0, 0);
INSERT INTO `issue_ui` VALUES (2231, 1, 1, 'create', 2, 7, 0, 1);
INSERT INTO `issue_ui` VALUES (2232, 1, 1, 'create', 7, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (2233, 1, 1, 'create', 4, 5, 0, 1);
INSERT INTO `issue_ui` VALUES (2234, 1, 1, 'create', 11, 4, 0, 0);
INSERT INTO `issue_ui` VALUES (2235, 1, 1, 'create', 12, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (2236, 1, 1, 'create', 13, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (2237, 1, 1, 'create', 15, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (2238, 1, 1, 'create', 23, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (2239, 1, 1, 'create', 19, 9, 119, 0);
INSERT INTO `issue_ui` VALUES (2240, 1, 1, 'create', 10, 8, 119, 0);
INSERT INTO `issue_ui` VALUES (2241, 1, 1, 'create', 20, 7, 119, 0);
INSERT INTO `issue_ui` VALUES (2242, 1, 1, 'create', 18, 6, 119, 0);
INSERT INTO `issue_ui` VALUES (2243, 1, 1, 'create', 3, 5, 119, 0);
INSERT INTO `issue_ui` VALUES (2244, 1, 1, 'create', 21, 4, 119, 0);
INSERT INTO `issue_ui` VALUES (2245, 1, 1, 'create', 8, 3, 119, 0);
INSERT INTO `issue_ui` VALUES (2246, 1, 1, 'create', 9, 2, 119, 0);
INSERT INTO `issue_ui` VALUES (2247, 1, 1, 'create', 29, 1, 119, 0);
INSERT INTO `issue_ui` VALUES (2248, 1, 1, 'create', 28, 0, 119, 0);
INSERT INTO `issue_ui` VALUES (2266, 1, 1, 'edit', 1, 10, 0, 1);
INSERT INTO `issue_ui` VALUES (2267, 1, 1, 'edit', 6, 9, 0, 0);
INSERT INTO `issue_ui` VALUES (2268, 1, 1, 'edit', 2, 8, 0, 1);
INSERT INTO `issue_ui` VALUES (2269, 1, 1, 'edit', 19, 7, 0, 0);
INSERT INTO `issue_ui` VALUES (2270, 1, 1, 'edit', 10, 6, 0, 0);
INSERT INTO `issue_ui` VALUES (2271, 1, 1, 'edit', 7, 5, 0, 0);
INSERT INTO `issue_ui` VALUES (2272, 1, 1, 'edit', 4, 4, 0, 1);
INSERT INTO `issue_ui` VALUES (2273, 1, 1, 'edit', 11, 3, 0, 0);
INSERT INTO `issue_ui` VALUES (2274, 1, 1, 'edit', 12, 2, 0, 0);
INSERT INTO `issue_ui` VALUES (2275, 1, 1, 'edit', 13, 1, 0, 0);
INSERT INTO `issue_ui` VALUES (2276, 1, 1, 'edit', 15, 0, 0, 0);
INSERT INTO `issue_ui` VALUES (2277, 1, 1, 'edit', 3, 5, 121, 0);
INSERT INTO `issue_ui` VALUES (2278, 1, 1, 'edit', 18, 4, 121, 0);
INSERT INTO `issue_ui` VALUES (2279, 1, 1, 'edit', 20, 3, 121, 0);
INSERT INTO `issue_ui` VALUES (2280, 1, 1, 'edit', 21, 2, 121, 0);
INSERT INTO `issue_ui` VALUES (2281, 1, 1, 'edit', 8, 1, 121, 0);
INSERT INTO `issue_ui` VALUES (2282, 1, 1, 'edit', 9, 0, 121, 0);

-- ----------------------------
-- Table structure for issue_ui_scheme
-- ----------------------------
DROP TABLE IF EXISTS `issue_ui_scheme`;
CREATE TABLE `issue_ui_scheme`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '事项表单配置方案' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_ui_scheme
-- ----------------------------
INSERT INTO `issue_ui_scheme` VALUES (1, '默认方案', 1, 0);

-- ----------------------------
-- Table structure for issue_ui_tab
-- ----------------------------
DROP TABLE IF EXISTS `issue_ui_tab`;
CREATE TABLE `issue_ui_tab`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scheme_id` int(10) UNSIGNED DEFAULT 1,
  `issue_type_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `order_weight` int(11) DEFAULT NULL,
  `ui_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `issue_id`(`issue_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of issue_ui_tab
-- ----------------------------
INSERT INTO `issue_ui_tab` VALUES (33, 1, 6, '更多', 0, 'create');
INSERT INTO `issue_ui_tab` VALUES (34, 1, 6, '\n            \n            更多\n             \n            \n        \n             \n            \n        ', 0, 'edit');
INSERT INTO `issue_ui_tab` VALUES (37, 1, 7, '更 多', 0, 'create');
INSERT INTO `issue_ui_tab` VALUES (63, 1, 7, '\n            \n            \n            \n            更 多\n             \n            \n        \n             \n            \n        \n             \n            \n        \n             \n            \n        ', 0, 'edit');
INSERT INTO `issue_ui_tab` VALUES (64, 1, 4, '\n            \n            \n            更多\n             \n            \n        \n             \n            \n        \n             \n            \n        ', 0, 'edit');
INSERT INTO `issue_ui_tab` VALUES (81, 1, 2, '更 多', 0, 'create');
INSERT INTO `issue_ui_tab` VALUES (82, 1, 2, '\n            \n            \n            \n            \n            \n            \n            \n            \n            \n            更 多\n             \n            \n        \n             \n            \n        \n             \n            \n        \n             ', 0, 'edit');
INSERT INTO `issue_ui_tab` VALUES (90, 1, 3, '其他', 0, 'create');
INSERT INTO `issue_ui_tab` VALUES (91, 1, 3, '\n            \n            \n            \n            \n            \n            \n            \n            其他\n             \n            \n        \n             \n            \n        \n             \n            \n        \n             \n            \n        \n    ', 0, 'edit');
INSERT INTO `issue_ui_tab` VALUES (119, 1, 1, '更 多', 0, 'create');
INSERT INTO `issue_ui_tab` VALUES (121, 1, 1, '\n            更多\n             \n            \n        ', 0, 'edit');

-- ----------------------------
-- Table structure for log_base
-- ----------------------------
DROP TABLE IF EXISTS `log_base`;
CREATE TABLE `log_base`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属模块',
  `obj_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作记录所关联的对象id,如现货id 订单id',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作者id,0为系统操作',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作者用户名',
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `page` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '页面',
  `pre_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `cur_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `action` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作动作',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '动作',
  `pre_data` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `cur_data` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作者ip地址 ',
  `time` int(10) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `obj_id`(`obj_id`) USING BTREE,
  INDEX `like_query`(`uid`, `action`, `remark`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组合模糊查询索引' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_operating
-- ----------------------------
DROP TABLE IF EXISTS `log_operating`;
CREATE TABLE `log_operating`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属模块',
  `obj_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作记录所关联的对象id,如现货id 订单id',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作者id,0为系统操作',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作者用户名',
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `page` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '页面',
  `pre_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `cur_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `action` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '操作动作',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '动作',
  `pre_data` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `cur_data` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '{}' COMMENT '操作记录前的数据,json格式',
  `ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '操作者ip地址 ',
  `time` int(10) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `obj_id`(`obj_id`) USING BTREE,
  INDEX `like_query`(`uid`, `action`, `remark`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组合模糊查询索引' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log_operating
-- ----------------------------
INSERT INTO `log_operating` VALUES (1, 0, '项目', 0, 1, 'master', 'Master', '/project/main/create', NULL, NULL, '新增', '新建项目', '[]', '{\"name\":\"NewCity\",\"org_id\":\"1\",\"key\":\"city\",\"lead\":\"1\",\"description\":\"wwwww\",\"project_tpl_id\":1,\"category\":0,\"url\":\"\",\"create_time\":1604403288,\"create_uid\":\"1\",\"avatar\":\"\",\"detail\":\"\",\"org_path\":\"default\"}', '127.0.0.1', 1604403289);
INSERT INTO `log_operating` VALUES (2, 0, '项目', 0, 1, 'master', 'Master', '/project/main/create', NULL, NULL, '新增', '新建项目', '[]', '{\"name\":\"NewCity2\",\"org_id\":\"1\",\"key\":\"city2\",\"lead\":\"1\",\"description\":\"wwwww\",\"project_tpl_id\":1,\"category\":0,\"url\":\"\",\"create_time\":1604404475,\"create_uid\":\"1\",\"avatar\":\"\",\"detail\":\"\",\"org_path\":\"default\"}', '127.0.0.1', 1604404475);
INSERT INTO `log_operating` VALUES (3, 0, '项目', 0, 1, 'master', 'Master', '/project/main/create', NULL, NULL, '新增', '新建项目', '[]', '{\"name\":\"NewCity3\",\"org_id\":\"1\",\"key\":\"city3\",\"lead\":\"1\",\"description\":\"wwwww\",\"project_tpl_id\":1,\"category\":0,\"url\":\"\",\"create_time\":1604404565,\"create_uid\":\"1\",\"avatar\":\"\",\"detail\":\"\",\"org_path\":\"default\"}', '127.0.0.1', 1604404565);
INSERT INTO `log_operating` VALUES (4, 1, '事项', 139, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"139\",\"pkey\":\"example\",\"issue_num\":\"139\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12167\",\"summary\":\"\\u5546\\u57ce\\u6a21\\u5757\\u7f16\\u7801\",\"description\":\"![1cut-202004181604013986.png](\\/attachment\\/image\\/20200418\\/1cut-202004181604013986.png \\\"\\u622a\\u56fe-1cut-202004181604013986.png\\\")\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583242645\",\"updated\":\"1583242645\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-11\",\"duration\":\"7\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"999250000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"139\",\"pkey\":\"example\",\"issue_num\":\"139\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12167\",\"summary\":\"\\u5546\\u57ce\\u6a21\\u5757\\u7f16\\u7801\",\"description\":\"![1cut-202004181604013986.png](\\/attachment\\/image\\/20200418\\/1cut-202004181604013986.png \\\"\\u622a\\u56fe-1cut-202004181604013986.png\\\")\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583242645\",\"updated\":\"1583242645\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-11\",\"duration\":\"7\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"999250000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604404921);
INSERT INTO `log_operating` VALUES (5, 0, '项目', 0, 1, 'master', 'Master', '/project/main/create', NULL, NULL, '新增', '新建项目', '[]', '{\"name\":\"TestProject\",\"org_id\":\"1\",\"key\":\"testproject\",\"lead\":\"1\",\"description\":\"\",\"project_tpl_id\":1,\"category\":0,\"url\":\"\",\"create_time\":1604924929,\"create_uid\":\"1\",\"avatar\":\"\",\"detail\":\"\",\"org_path\":\"default\"}', '127.0.0.1', 1604924929);
INSERT INTO `log_operating` VALUES (6, 1, '事项', 139, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"139\",\"pkey\":\"example\",\"issue_num\":\"139\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12167\",\"summary\":\"\\u5546\\u57ce\\u6a21\\u5757\\u7f16\\u7801\",\"description\":\"![1cut-202004181604013986.png](\\/attachment\\/image\\/20200418\\/1cut-202004181604013986.png \\\"\\u622a\\u56fe-1cut-202004181604013986.png\\\")\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583242645\",\"updated\":\"1583242645\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-11\",\"duration\":\"7\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"300000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"999250000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"139\",\"pkey\":\"example\",\"issue_num\":\"139\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12167\",\"summary\":\"\\u5546\\u57ce\\u6a21\\u5757\\u7f16\\u7801\",\"description\":\"![1cut-202004181604013986.png](\\/attachment\\/image\\/20200418\\/1cut-202004181604013986.png \\\"\\u622a\\u56fe-1cut-202004181604013986.png\\\")\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583242645\",\"updated\":\"1583242645\",\"start_date\":\"2020-11-10\",\"due_date\":\"2020-11-13\",\"duration\":\"7\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"300000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"999250000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974636);
INSERT INTO `log_operating` VALUES (7, 1, '事项', 120, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"120\",\"pkey\":\"example\",\"issue_num\":\"120\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4f18\\u5316\\u6539\\u8fdb\\u4e8b\\u98792\",\"description\":\"![](http:\\/\\/www.masterlab21.com\\/attachment\\/image\\/20200622\\/20200622195934_26594.jpg)\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583232765\",\"updated\":\"1583232765\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-11\",\"duration\":\"7\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"2\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"200000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999900000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"120\",\"pkey\":\"example\",\"issue_num\":\"120\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4f18\\u5316\\u6539\\u8fdb\\u4e8b\\u98792\",\"description\":\"![](http:\\/\\/www.masterlab21.com\\/attachment\\/image\\/20200622\\/20200622195934_26594.jpg)\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583232765\",\"updated\":\"1583232765\",\"start_date\":\"2020-11-16\",\"due_date\":\"2020-11-17\",\"duration\":\"7\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"2\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"200000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999900000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974652);
INSERT INTO `log_operating` VALUES (8, 1, '事项', 116, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"116\",\"pkey\":\"example\",\"issue_num\":\"116\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u65e5\\u5fd7\\u6a21\\u5757\\u5f00\\u53d1x\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583044099\",\"updated\":\"1583079970\",\"start_date\":\"2020-03-02\",\"due_date\":\"2020-03-27\",\"duration\":\"20\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1400000\",\"assistants\":\"12165,12166\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"0\",\"followed_count\":\"1\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998400000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"116\",\"pkey\":\"example\",\"issue_num\":\"116\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u65e5\\u5fd7\\u6a21\\u5757\\u5f00\\u53d1x\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583044099\",\"updated\":\"1583079970\",\"start_date\":\"2020-11-17\",\"due_date\":\"2020-11-18\",\"duration\":\"20\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1400000\",\"assistants\":\"12165,12166\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"0\",\"followed_count\":\"1\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998400000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974665);
INSERT INTO `log_operating` VALUES (9, 1, '事项', 108, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"108\",\"pkey\":\"example\",\"issue_num\":\"108\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4ea7\\u54c1\\u6a21\\u5757\\u5f00\\u53d1\\u7f16\\u78011\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"3\",\"created\":\"1583043244\",\"updated\":\"1583043244\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-13\",\"duration\":\"9\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1200000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"4\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999300000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"108\",\"pkey\":\"example\",\"issue_num\":\"108\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4ea7\\u54c1\\u6a21\\u5757\\u5f00\\u53d1\\u7f16\\u78011\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"3\",\"created\":\"1583043244\",\"updated\":\"1583043244\",\"start_date\":\"2020-11-19\",\"due_date\":\"2020-11-20\",\"duration\":\"9\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1200000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"4\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999300000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974688);
INSERT INTO `log_operating` VALUES (10, 1, '事项', 107, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"107\",\"pkey\":\"example\",\"issue_num\":\"107\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u7528\\u6237\\u6a21\\u5757\\u5f00\\u53d1\\u7f16\\u78011\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583041630\",\"updated\":\"1583041630\",\"start_date\":\"2020-03-02\",\"due_date\":\"2020-03-09\",\"duration\":\"11\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1100000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999400000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"107\",\"pkey\":\"example\",\"issue_num\":\"107\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u7528\\u6237\\u6a21\\u5757\\u5f00\\u53d1\\u7f16\\u78011\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1583041630\",\"updated\":\"1583041630\",\"start_date\":\"2020-11-23\",\"due_date\":\"2020-11-24\",\"duration\":\"11\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1100000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"3\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999400000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974699);
INSERT INTO `log_operating` VALUES (11, 1, '事项', 106, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"106\",\"pkey\":\"example\",\"issue_num\":\"106\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"0\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"3\",\"created\":\"1583041489\",\"updated\":\"1583041489\",\"start_date\":\"2020-03-02\",\"due_date\":\"2020-03-27\",\"duration\":\"20\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1000000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"2\",\"followed_count\":\"0\",\"comment_count\":\"1\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998700000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"106\",\"pkey\":\"example\",\"issue_num\":\"106\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"3\",\"created\":\"1583041489\",\"updated\":\"1583041489\",\"start_date\":\"2020-11-25\",\"due_date\":\"2020-11-27\",\"duration\":\"20\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1000000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"2\",\"followed_count\":\"0\",\"comment_count\":\"1\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998700000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974712);
INSERT INTO `log_operating` VALUES (12, 1, '事项', 97, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"97\",\"pkey\":\"example\",\"issue_num\":\"97\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"0\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6d41\\u7a0b\\u56fe\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582993719\",\"updated\":\"1582993719\",\"start_date\":\"2020-03-02\",\"due_date\":\"2020-03-20\",\"duration\":\"15\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"900000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"2\",\"depends\":\"\",\"gant_sprint_weight\":\"999000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"97\",\"pkey\":\"example\",\"issue_num\":\"97\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6d41\\u7a0b\\u56fe\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582993719\",\"updated\":\"1582993719\",\"start_date\":\"2020-11-30\",\"due_date\":\"2020-3-20\",\"duration\":\"15\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"900000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"2\",\"depends\":\"\",\"gant_sprint_weight\":\"999000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974724);
INSERT INTO `log_operating` VALUES (13, 1, '事项', 97, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"97\",\"pkey\":\"example\",\"issue_num\":\"97\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6d41\\u7a0b\\u56fe\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582993719\",\"updated\":\"1582993719\",\"start_date\":\"2020-11-30\",\"due_date\":\"2020-03-20\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"900000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"2\",\"depends\":\"\",\"gant_sprint_weight\":\"999000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"97\",\"pkey\":\"example\",\"issue_num\":\"97\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6d41\\u7a0b\\u56fe\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582993719\",\"updated\":\"1582993719\",\"start_date\":\"2020-12-1\",\"due_date\":\"2020-12-2\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"900000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"2\",\"depends\":\"\",\"gant_sprint_weight\":\"999000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604974737);
INSERT INTO `log_operating` VALUES (14, 1, '事项', 96, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"96\",\"pkey\":\"example\",\"issue_num\":\"96\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"0\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"UI\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"3\",\"created\":\"1582993557\",\"updated\":\"1582993557\",\"start_date\":\"2020-03-01\",\"due_date\":\"2020-03-13\",\"duration\":\"10\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"800000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998900000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"96\",\"pkey\":\"example\",\"issue_num\":\"96\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"UI\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"3\",\"created\":\"1582993557\",\"updated\":\"1582993557\",\"start_date\":\"2020-12-4\",\"due_date\":\"2020-12-5\",\"duration\":\"10\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"800000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998900000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975363);
INSERT INTO `log_operating` VALUES (15, 1, '事项', 95, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"95\",\"pkey\":\"example\",\"issue_num\":\"95\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4ea4\\u4e92\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582993508\",\"updated\":\"1582993508\",\"start_date\":\"2020-03-09\",\"due_date\":\"2020-03-20\",\"duration\":\"10\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"700000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"999100000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"95\",\"pkey\":\"example\",\"issue_num\":\"95\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4ea4\\u4e92\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582993508\",\"updated\":\"1582993508\",\"start_date\":\"2020-12-7\",\"due_date\":\"2020-12-8\",\"duration\":\"10\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"700000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"999100000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975370);
INSERT INTO `log_operating` VALUES (16, 1, '事项', 94, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"94\",\"pkey\":\"example\",\"issue_num\":\"94\",\"project_id\":\"1\",\"issue_type\":\"1\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u5e02\\u573a\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\\r\\n\\u8fd9\\u91cc\\u8f93\\u5165\\u5bf9bug\\u505a\\u51fa\\u6e05\\u6670\\u7b80\\u6d01\\u7684\\u63cf\\u8ff0.\\r\\n\\r\\n**\\u91cd\\u73b0\\u6b65\\u9aa4**\\r\\n1. xx\\r\\n2. xxx\\r\\n3. xxxx\\r\\n4. xxxxxx\\r\\n\\r\\n**\\u671f\\u671b\\u7ed3\\u679c**\\r\\n\\u7b80\\u6d01\\u6e05\\u6670\\u7684\\u63cf\\u8ff0\\u671f\\u671b\\u7ed3\\u679c\\r\\n\\r\\n**\\u5b9e\\u9645\\u7ed3\\u679c**\\r\\n\\u7b80\\u8ff0\\u5b9e\\u9645\\u770b\\u5230\\u7684\\u7ed3\\u679c\\uff0c\\u8fd9\\u91cc\\u53ef\\u4ee5\\u914d\\u4e0a\\u622a\\u56fe\\r\\n\\r\\n\\r\\n**\\u9644\\u52a0\\u8bf4\\u660e**\\r\\n\\u9644\\u52a0\\u6216\\u989d\\u5916\\u7684\\u4fe1\\u606f\\r\\n\",\"environment\":\"\",\"priority\":\"2\",\"resolve\":\"2\",\"status\":\"6\",\"created\":\"1582992127\",\"updated\":\"1582992127\",\"start_date\":\"0000-00-00\",\"due_date\":\"0000-00-00\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"s', '{\"id\":\"94\",\"pkey\":\"example\",\"issue_num\":\"94\",\"project_id\":\"1\",\"issue_type\":\"1\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u5e02\\u573a\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\\r\\n\\u8fd9\\u91cc\\u8f93\\u5165\\u5bf9bug\\u505a\\u51fa\\u6e05\\u6670\\u7b80\\u6d01\\u7684\\u63cf\\u8ff0.\\r\\n\\r\\n**\\u91cd\\u73b0\\u6b65\\u9aa4**\\r\\n1. xx\\r\\n2. xxx\\r\\n3. xxxx\\r\\n4. xxxxxx\\r\\n\\r\\n**\\u671f\\u671b\\u7ed3\\u679c**\\r\\n\\u7b80\\u6d01\\u6e05\\u6670\\u7684\\u63cf\\u8ff0\\u671f\\u671b\\u7ed3\\u679c\\r\\n\\r\\n**\\u5b9e\\u9645\\u7ed3\\u679c**\\r\\n\\u7b80\\u8ff0\\u5b9e\\u9645\\u770b\\u5230\\u7684\\u7ed3\\u679c\\uff0c\\u8fd9\\u91cc\\u53ef\\u4ee5\\u914d\\u4e0a\\u622a\\u56fe\\r\\n\\r\\n\\r\\n**\\u9644\\u52a0\\u8bf4\\u660e**\\r\\n\\u9644\\u52a0\\u6216\\u989d\\u5916\\u7684\\u4fe1\\u606f\\r\\n\",\"environment\":\"\",\"priority\":\"2\",\"resolve\":\"2\",\"status\":\"6\",\"created\":\"1582992127\",\"updated\":\"1582992127\",\"start_date\":\"2020-12-8\",\"due_date\":\"2020-12-9\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"spr', '127.0.0.1', 1604975378);
INSERT INTO `log_operating` VALUES (17, 1, '事项', 94, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"94\",\"pkey\":\"example\",\"issue_num\":\"94\",\"project_id\":\"1\",\"issue_type\":\"1\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u5e02\\u573a\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\\r\\n\\u8fd9\\u91cc\\u8f93\\u5165\\u5bf9bug\\u505a\\u51fa\\u6e05\\u6670\\u7b80\\u6d01\\u7684\\u63cf\\u8ff0.\\r\\n\\r\\n**\\u91cd\\u73b0\\u6b65\\u9aa4**\\r\\n1. xx\\r\\n2. xxx\\r\\n3. xxxx\\r\\n4. xxxxxx\\r\\n\\r\\n**\\u671f\\u671b\\u7ed3\\u679c**\\r\\n\\u7b80\\u6d01\\u6e05\\u6670\\u7684\\u63cf\\u8ff0\\u671f\\u671b\\u7ed3\\u679c\\r\\n\\r\\n**\\u5b9e\\u9645\\u7ed3\\u679c**\\r\\n\\u7b80\\u8ff0\\u5b9e\\u9645\\u770b\\u5230\\u7684\\u7ed3\\u679c\\uff0c\\u8fd9\\u91cc\\u53ef\\u4ee5\\u914d\\u4e0a\\u622a\\u56fe\\r\\n\\r\\n\\r\\n**\\u9644\\u52a0\\u8bf4\\u660e**\\r\\n\\u9644\\u52a0\\u6216\\u989d\\u5916\\u7684\\u4fe1\\u606f\\r\\n\",\"environment\":\"\",\"priority\":\"2\",\"resolve\":\"2\",\"status\":\"6\",\"created\":\"1582992127\",\"updated\":\"1582992127\",\"start_date\":\"2020-12-08\",\"due_date\":\"2020-12-09\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"s', '{\"id\":\"94\",\"pkey\":\"example\",\"issue_num\":\"94\",\"project_id\":\"1\",\"issue_type\":\"1\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u5e02\\u573a\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\\r\\n\\u8fd9\\u91cc\\u8f93\\u5165\\u5bf9bug\\u505a\\u51fa\\u6e05\\u6670\\u7b80\\u6d01\\u7684\\u63cf\\u8ff0.\\r\\n\\r\\n**\\u91cd\\u73b0\\u6b65\\u9aa4**\\r\\n1. xx\\r\\n2. xxx\\r\\n3. xxxx\\r\\n4. xxxxxx\\r\\n\\r\\n**\\u671f\\u671b\\u7ed3\\u679c**\\r\\n\\u7b80\\u6d01\\u6e05\\u6670\\u7684\\u63cf\\u8ff0\\u671f\\u671b\\u7ed3\\u679c\\r\\n\\r\\n**\\u5b9e\\u9645\\u7ed3\\u679c**\\r\\n\\u7b80\\u8ff0\\u5b9e\\u9645\\u770b\\u5230\\u7684\\u7ed3\\u679c\\uff0c\\u8fd9\\u91cc\\u53ef\\u4ee5\\u914d\\u4e0a\\u622a\\u56fe\\r\\n\\r\\n\\r\\n**\\u9644\\u52a0\\u8bf4\\u660e**\\r\\n\\u9644\\u52a0\\u6216\\u989d\\u5916\\u7684\\u4fe1\\u606f\\r\\n\",\"environment\":\"\",\"priority\":\"2\",\"resolve\":\"2\",\"status\":\"6\",\"created\":\"1582992127\",\"updated\":\"1582992127\",\"start_date\":\"2020-12-9\",\"due_date\":\"2020-12-10\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sp', '127.0.0.1', 1604975384);
INSERT INTO `log_operating` VALUES (18, 1, '事项', 90, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"90\",\"pkey\":\"example\",\"issue_num\":\"90\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4ea7\\u54c1\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"6\",\"created\":\"1582983902\",\"updated\":\"1582983902\",\"start_date\":\"2020-02-28\",\"due_date\":\"2020-03-03\",\"duration\":\"3\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"200000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"4\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"90\",\"pkey\":\"example\",\"issue_num\":\"90\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4ea7\\u54c1\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"6\",\"created\":\"1582983902\",\"updated\":\"1582983902\",\"start_date\":\"2020-12-11\",\"due_date\":\"2020-12-14\",\"duration\":\"3\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"200000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"4\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975395);
INSERT INTO `log_operating` VALUES (19, 1, '事项', 87, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"87\",\"pkey\":\"example\",\"issue_num\":\"87\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12164\",\"summary\":\"\\u4ea7\\u54c1\\u529f\\u80fd\\u8bf4\\u660e\\u4e66\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1582693628\",\"updated\":\"1582693628\",\"start_date\":\"2020-03-01\",\"due_date\":\"2020-03-16\",\"duration\":\"11\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"998800000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"87\",\"pkey\":\"example\",\"issue_num\":\"87\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12164\",\"summary\":\"\\u4ea7\\u54c1\\u529f\\u80fd\\u8bf4\\u660e\\u4e66\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1582693628\",\"updated\":\"1582693628\",\"start_date\":\"2020-12-15\",\"due_date\":\"2020-12-16\",\"duration\":\"11\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"90\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"998800000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975403);
INSERT INTO `log_operating` VALUES (20, 1, '事项', 64, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"64\",\"pkey\":\"example\",\"issue_num\":\"64\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12164\",\"summary\":\"\\u524d\\u7aef\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582623716\",\"updated\":\"1582623716\",\"start_date\":\"2020-03-04\",\"due_date\":\"2020-03-06\",\"duration\":\"3\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"500000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"106\",\"have_children\":\"1\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998600000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"64\",\"pkey\":\"example\",\"issue_num\":\"64\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12164\",\"summary\":\"\\u524d\\u7aef\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582623716\",\"updated\":\"1582623716\",\"start_date\":\"2020-12-16\",\"due_date\":\"2020-12-17\",\"duration\":\"3\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"500000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"106\",\"have_children\":\"1\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998600000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975414);
INSERT INTO `log_operating` VALUES (21, 1, '事项', 54, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"54\",\"pkey\":\"example\",\"issue_num\":\"54\",\"project_id\":\"1\",\"issue_type\":\"2\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"ER\\u5173\\u7cfb\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582602962\",\"updated\":\"1582602962\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-06\",\"duration\":\"4\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"400000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"1\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"54\",\"pkey\":\"example\",\"issue_num\":\"54\",\"project_id\":\"1\",\"issue_type\":\"2\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"ER\\u5173\\u7cfb\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582602962\",\"updated\":\"1582602962\",\"start_date\":\"2020-12-21\",\"due_date\":\"2020-12-22\",\"duration\":\"4\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"400000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"1\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975456);
INSERT INTO `log_operating` VALUES (22, 1, '事项', 53, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"53\",\"pkey\":\"example\",\"issue_num\":\"53\",\"project_id\":\"1\",\"issue_type\":\"2\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4f18\\u5316\\u6539\\u8fdb\\u4e8b\\u98791\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582602961\",\"updated\":\"1582602961\",\"start_date\":\"2020-01-17\",\"due_date\":\"2020-02-29\",\"duration\":\"31\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"2\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"100000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"5\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"53\",\"pkey\":\"example\",\"issue_num\":\"53\",\"project_id\":\"1\",\"issue_type\":\"2\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u4f18\\u5316\\u6539\\u8fdb\\u4e8b\\u98791\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1582602961\",\"updated\":\"1582602961\",\"start_date\":\"2020-12-23\",\"due_date\":\"2020-12-24\",\"duration\":\"31\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"2\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"100000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"5\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975469);
INSERT INTO `log_operating` VALUES (23, 1, '事项', 8, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"8\",\"pkey\":\"example\",\"issue_num\":\"8\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6280\\u672f\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1582199367\",\"updated\":\"1582199367\",\"start_date\":\"0000-00-00\",\"due_date\":\"0000-00-00\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"5\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"8\",\"pkey\":\"example\",\"issue_num\":\"8\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6280\\u672f\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1582199367\",\"updated\":\"1582199367\",\"start_date\":\"2020-12-25\",\"due_date\":\"2020-12-28\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"5\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"1000000000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975476);
INSERT INTO `log_operating` VALUES (24, 1, '事项', 5, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"5\",\"pkey\":\"example\",\"issue_num\":\"5\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12165\",\"summary\":\"\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1581321497\",\"updated\":\"1581321497\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-04\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1700000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"3\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998300000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"5\",\"pkey\":\"example\",\"issue_num\":\"5\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12165\",\"summary\":\"\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1581321497\",\"updated\":\"1581321497\",\"start_date\":\"2020-4-29\",\"due_date\":\"2020-4-30\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1700000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"3\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998300000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975485);
INSERT INTO `log_operating` VALUES (25, 1, '事项', 5, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"5\",\"pkey\":\"example\",\"issue_num\":\"5\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12165\",\"summary\":\"\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1581321497\",\"updated\":\"1581321497\",\"start_date\":\"2020-04-29\",\"due_date\":\"2020-04-30\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1700000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"3\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998300000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"5\",\"pkey\":\"example\",\"issue_num\":\"5\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12165\",\"summary\":\"\\u53ef\\u884c\\u6027\\u5206\\u6790\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1581321497\",\"updated\":\"1581321497\",\"start_date\":\"2020-12-29\",\"due_date\":\"2020-12-30\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1700000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"3\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"998300000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975501);
INSERT INTO `log_operating` VALUES (26, 1, '事项', 4, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"4\",\"pkey\":\"example\",\"issue_num\":\"4\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6570\\u636e\\u5e93\\u8868\\u7ed3\\u6784\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579423320\",\"updated\":\"1583079970\",\"start_date\":\"2020-03-02\",\"due_date\":\"2020-01-01\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"200000\",\"sprint_weight\":\"1300000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"1\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999800000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"4\",\"pkey\":\"example\",\"issue_num\":\"4\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u6570\\u636e\\u5e93\\u8868\\u7ed3\\u6784\\u8bbe\\u8ba1\",\"description\":\"\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579423320\",\"updated\":\"1583079970\",\"start_date\":\"2021-4-5\",\"due_date\":\"2021-4-6\",\"duration\":\"0\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"0\",\"backlog_weight\":\"200000\",\"sprint_weight\":\"1300000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"1\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999800000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975531);
INSERT INTO `log_operating` VALUES (27, 1, '事项', 3, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"3\",\"pkey\":\"example\",\"issue_num\":\"3\",\"project_id\":\"1\",\"issue_type\":\"2\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12168\",\"summary\":\"\\u4e1a\\u52a1\\u6a21\\u5757\\u5f00\\u53d1\",\"description\":\"xxxxx\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1579423228\",\"updated\":\"1579423228\",\"start_date\":\"2020-01-20\",\"due_date\":\"2020-01-24\",\"duration\":\"5\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"60\",\"backlog_weight\":\"0\",\"sprint_weight\":\"100000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"4\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999500000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"3\",\"pkey\":\"example\",\"issue_num\":\"3\",\"project_id\":\"1\",\"issue_type\":\"2\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12168\",\"summary\":\"\\u4e1a\\u52a1\\u6a21\\u5757\\u5f00\\u53d1\",\"description\":\"xxxxx\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"10000\",\"status\":\"6\",\"created\":\"1579423228\",\"updated\":\"1579423228\",\"start_date\":\"2021-1-6\",\"due_date\":\"2021-1-7\",\"duration\":\"5\",\"resolve_date\":null,\"module\":\"3\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"60\",\"backlog_weight\":\"0\",\"sprint_weight\":\"100000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"4\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999500000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975547);
INSERT INTO `log_operating` VALUES (28, 1, '事项', 2, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"2\",\"pkey\":\"example\",\"issue_num\":\"2\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u670d\\u52a1\\u5668\\u7aef\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"xxxxxxxxxxxxxxxxxxxxx\\r\\n1**xxxxxxxx**\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579250062\",\"updated\":\"1582133914\",\"start_date\":\"2020-03-03\",\"due_date\":\"2020-03-06\",\"duration\":\"4\",\"resolve_date\":null,\"module\":\"1\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"80\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1800000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"106\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"998500000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"2\",\"pkey\":\"example\",\"issue_num\":\"2\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u670d\\u52a1\\u5668\\u7aef\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"xxxxxxxxxxxxxxxxxxxxx\\r\\n1**xxxxxxxx**\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579250062\",\"updated\":\"1582133914\",\"start_date\":\"2021-3-8\",\"due_date\":\"2021-3-9\",\"duration\":\"4\",\"resolve_date\":null,\"module\":\"1\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"80\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1800000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"106\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"998500000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975562);
INSERT INTO `log_operating` VALUES (29, 1, '事项', 2, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"2\",\"pkey\":\"example\",\"issue_num\":\"2\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u670d\\u52a1\\u5668\\u7aef\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"xxxxxxxxxxxxxxxxxxxxx\\r\\n1**xxxxxxxx**\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579250062\",\"updated\":\"1582133914\",\"start_date\":\"2021-03-08\",\"due_date\":\"2021-03-09\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"1\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"80\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1800000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"106\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"998500000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"2\",\"pkey\":\"example\",\"issue_num\":\"2\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"1\",\"summary\":\"\\u670d\\u52a1\\u5668\\u7aef\\u67b6\\u6784\\u8bbe\\u8ba1\",\"description\":\"xxxxxxxxxxxxxxxxxxxxx\\r\\n1**xxxxxxxx**\",\"environment\":\"\",\"priority\":\"3\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579250062\",\"updated\":\"1582133914\",\"start_date\":\"2021-1-7\",\"due_date\":\"2021-1-8\",\"duration\":\"2\",\"resolve_date\":null,\"module\":\"1\",\"milestone\":null,\"sprint\":\"1\",\"weight\":\"80\",\"backlog_weight\":\"0\",\"sprint_weight\":\"1800000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"106\",\"have_children\":\"0\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"1\",\"depends\":\"\",\"gant_sprint_weight\":\"998500000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975576);
INSERT INTO `log_operating` VALUES (30, 1, '事项', 1, 1, 'master', 'Master', '/issue/main/update', NULL, NULL, '编辑', '修改事项', '{\"id\":\"1\",\"pkey\":\"example\",\"issue_num\":\"1\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12166\",\"summary\":\"\\u6570\\u636e\\u5e93\\u8bbe\\u8ba1\",\"description\":\"xxxxxx\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579249719\",\"updated\":\"1582133907\",\"start_date\":\"2020-01-17\",\"due_date\":\"2020-01-30\",\"duration\":\"10\",\"resolve_date\":null,\"module\":\"2\",\"milestone\":null,\"sprint\":\"0\",\"weight\":\"80\",\"backlog_weight\":\"100000\",\"sprint_weight\":\"1600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"3\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999900000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '{\"id\":\"1\",\"pkey\":\"example\",\"issue_num\":\"1\",\"project_id\":\"1\",\"issue_type\":\"3\",\"creator\":\"1\",\"modifier\":\"1\",\"reporter\":\"1\",\"assignee\":\"12166\",\"summary\":\"\\u6570\\u636e\\u5e93\\u8bbe\\u8ba1\",\"description\":\"xxxxxx\",\"environment\":\"\",\"priority\":\"4\",\"resolve\":\"2\",\"status\":\"1\",\"created\":\"1579249719\",\"updated\":\"1582133907\",\"start_date\":\"2021-1-18\",\"due_date\":\"2021-1-19\",\"duration\":\"10\",\"resolve_date\":null,\"module\":\"2\",\"milestone\":null,\"sprint\":\"0\",\"weight\":\"80\",\"backlog_weight\":\"100000\",\"sprint_weight\":\"1600000\",\"assistants\":\"\",\"level\":\"0\",\"master_id\":\"0\",\"have_children\":\"3\",\"followed_count\":\"0\",\"comment_count\":\"0\",\"progress\":\"0\",\"depends\":\"\",\"gant_sprint_weight\":\"999900000\",\"gant_hide\":\"0\",\"is_start_milestone\":\"0\",\"is_end_milestone\":\"0\"}', '127.0.0.1', 1604975597);
INSERT INTO `log_operating` VALUES (31, 0, '组织', 0, 1, 'master', 'Master', '/org/add', NULL, NULL, '新增', '创建组织', '[]', '{\"path\":\"bilan\",\"name\":\"\\u835c\\u84dd\\u79d1\\u6280\",\"description\":\"\\u835c\\u84dd\\u79d1\\u6280\\u835c\\u84dd\\u79d1\\u6280\",\"scope\":\"1\",\"created\":1627433933,\"create_uid\":\"1\"}', '127.0.0.1', 1627433933);
INSERT INTO `log_operating` VALUES (32, 0, '项目', 0, 1, 'master', 'Master', '/project/main/create', NULL, NULL, '新增', '新建项目', '[]', '{\"name\":\"\\u897f\\u90e8\\u822a\\u7a7a\",\"org_id\":\"146\",\"key\":\"bestAir\",\"lead\":\"1\",\"description\":\"dsfssd\",\"project_tpl_id\":2,\"category\":0,\"url\":\"\",\"create_time\":1627434023,\"create_uid\":\"1\",\"avatar\":\"\",\"detail\":\"### dfsds\",\"org_path\":\"bilan\"}', '127.0.0.1', 1627434023);

-- ----------------------------
-- Table structure for log_runtime_error
-- ----------------------------
DROP TABLE IF EXISTS `log_runtime_error`;
CREATE TABLE `log_runtime_error`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `line` smallint(5) UNSIGNED NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `err` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `errstr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `file_line_unique`(`md5`) USING BTREE,
  INDEX `date`(`date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_action
-- ----------------------------
DROP TABLE IF EXISTS `main_action`;
CREATE TABLE `main_action`  (
  `id` decimal(18, 0) NOT NULL,
  `issueid` decimal(18, 0) DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `actiontype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `actionlevel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `rolelevel` decimal(18, 0) DEFAULT NULL,
  `actionbody` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `created` datetime(0) DEFAULT NULL,
  `updateauthor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updated` datetime(0) DEFAULT NULL,
  `actionnum` decimal(18, 0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `action_author_created`(`author`, `created`) USING BTREE,
  INDEX `action_issue`(`issueid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_activity
-- ----------------------------
DROP TABLE IF EXISTS `main_activity`;
CREATE TABLE `main_activity`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '动作说明,如 关闭了，创建了，修复了',
  `content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `type` enum('agile','user','issue','issue_comment','org','project') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'issue' COMMENT 'project,issue,user,agile,issue_comment',
  `obj_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '相关的事项标题',
  `date` date DEFAULT NULL,
  `time` int(10) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  INDEX `date`(`date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_activity
-- ----------------------------
INSERT INTO `main_activity` VALUES (1, 1, 91, '创建了项目', '', 'project', 91, 'TestProject', '2020-11-09', 1604924929);
INSERT INTO `main_activity` VALUES (2, 1, 1, '修改事项', '', 'issue', 139, '商城模块编码', '2020-11-10', 1604974636);
INSERT INTO `main_activity` VALUES (3, 1, 1, '修改事项', '', 'issue', 120, '优化改进事项2', '2020-11-10', 1604974652);
INSERT INTO `main_activity` VALUES (4, 1, 1, '修改事项', '', 'issue', 116, '日志模块开发x', '2020-11-10', 1604974665);
INSERT INTO `main_activity` VALUES (5, 1, 1, '修改事项', '', 'issue', 108, '产品模块开发编码1', '2020-11-10', 1604974688);
INSERT INTO `main_activity` VALUES (6, 1, 1, '修改事项', '', 'issue', 107, '用户模块开发编码1', '2020-11-10', 1604974699);
INSERT INTO `main_activity` VALUES (7, 1, 1, '修改事项', '', 'issue', 106, '架构设计', '2020-11-10', 1604974712);
INSERT INTO `main_activity` VALUES (8, 1, 1, '修改事项', '', 'issue', 97, '流程图设计', '2020-11-10', 1604974724);
INSERT INTO `main_activity` VALUES (9, 1, 1, '修改事项', '', 'issue', 97, '流程图设计', '2020-11-10', 1604974737);
INSERT INTO `main_activity` VALUES (10, 1, 1, '修改事项', '', 'issue', 96, 'UI设计', '2020-11-10', 1604975363);
INSERT INTO `main_activity` VALUES (11, 1, 1, '修改事项', '', 'issue', 95, '交互设计', '2020-11-10', 1604975370);
INSERT INTO `main_activity` VALUES (12, 1, 1, '修改事项', '', 'issue', 94, '市场可行性分析', '2020-11-10', 1604975378);
INSERT INTO `main_activity` VALUES (13, 1, 1, '修改事项', '', 'issue', 94, '市场可行性分析', '2020-11-10', 1604975384);
INSERT INTO `main_activity` VALUES (14, 1, 1, '修改事项', '', 'issue', 90, '产品设计', '2020-11-10', 1604975395);
INSERT INTO `main_activity` VALUES (15, 1, 1, '修改事项', '', 'issue', 87, '产品功能说明书', '2020-11-10', 1604975403);
INSERT INTO `main_activity` VALUES (16, 1, 1, '修改事项', '', 'issue', 64, '前端架构设计', '2020-11-10', 1604975414);
INSERT INTO `main_activity` VALUES (17, 1, 1, '修改事项', '', 'issue', 54, 'ER关系设计', '2020-11-10', 1604975457);
INSERT INTO `main_activity` VALUES (18, 1, 1, '修改事项', '', 'issue', 53, '优化改进事项1', '2020-11-10', 1604975469);
INSERT INTO `main_activity` VALUES (19, 1, 1, '修改事项', '', 'issue', 8, '技术可行性分析', '2020-11-10', 1604975476);
INSERT INTO `main_activity` VALUES (20, 1, 1, '修改事项', '', 'issue', 5, '可行性分析', '2020-11-10', 1604975485);
INSERT INTO `main_activity` VALUES (21, 1, 1, '修改事项', '', 'issue', 5, '可行性分析', '2020-11-10', 1604975501);
INSERT INTO `main_activity` VALUES (22, 1, 1, '修改事项', '', 'issue', 4, '数据库表结构设计', '2020-11-10', 1604975531);
INSERT INTO `main_activity` VALUES (23, 1, 1, '修改事项', '', 'issue', 3, '业务模块开发', '2020-11-10', 1604975547);
INSERT INTO `main_activity` VALUES (24, 1, 1, '修改事项', '', 'issue', 2, '服务器端架构设计', '2020-11-10', 1604975562);
INSERT INTO `main_activity` VALUES (25, 1, 1, '修改事项', '', 'issue', 2, '服务器端架构设计', '2020-11-10', 1604975576);
INSERT INTO `main_activity` VALUES (26, 1, 1, '修改事项', '', 'issue', 1, '数据库设计', '2020-11-10', 1604975597);
INSERT INTO `main_activity` VALUES (27, 1, 1, '更新了迭代', '', 'agile', 2, '', '2020-11-10', 1604975701);
INSERT INTO `main_activity` VALUES (28, 1, 1, '更新了迭代', '', 'agile', 1, '', '2020-11-10', 1604975727);
INSERT INTO `main_activity` VALUES (29, 1, 1, '设置迭代状态为进行中', '', 'agile', 1, '1.0迭代', '2020-11-10', 1604975789);
INSERT INTO `main_activity` VALUES (30, 1, 0, '创建了组织', '', 'org', 146, '荜蓝科技', '2021-07-28', 1627433933);
INSERT INTO `main_activity` VALUES (31, 1, 92, '创建了项目', '', 'project', 92, '西部航空', '2021-07-28', 1627434023);

-- ----------------------------
-- Table structure for main_announcement
-- ----------------------------
DROP TABLE IF EXISTS `main_announcement`;
CREATE TABLE `main_announcement`  (
  `id` int(10) UNSIGNED NOT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '0为禁用,1为发布中',
  `flag` int(11) DEFAULT 0 COMMENT '每次发布将自增该字段',
  `expire_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_cache_key
-- ----------------------------
DROP TABLE IF EXISTS `main_cache_key`;
CREATE TABLE `main_cache_key`  (
  `key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `module` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `datetime` datetime(0) DEFAULT NULL,
  `expire` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  UNIQUE INDEX `module_key`(`key`, `module`) USING BTREE,
  INDEX `module`(`module`) USING BTREE,
  INDEX `expire`(`expire`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_eventtype
-- ----------------------------
DROP TABLE IF EXISTS `main_eventtype`;
CREATE TABLE `main_eventtype`  (
  `id` decimal(18, 0) NOT NULL,
  `template_id` decimal(18, 0) DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `event_type` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_group
-- ----------------------------
DROP TABLE IF EXISTS `main_group`;
CREATE TABLE `main_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `created_date` datetime(0) DEFAULT NULL,
  `updated_date` datetime(0) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `group_type` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `directory_id` decimal(18, 0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_group
-- ----------------------------
INSERT INTO `main_group` VALUES (1, 'administrators', 1, NULL, NULL, NULL, '1', NULL);
INSERT INTO `main_group` VALUES (2, 'developers', 1, NULL, NULL, NULL, '1', NULL);
INSERT INTO `main_group` VALUES (3, 'users', 1, NULL, NULL, NULL, '1', NULL);
INSERT INTO `main_group` VALUES (4, 'qas', 1, NULL, NULL, NULL, '1', NULL);
INSERT INTO `main_group` VALUES (5, 'ui-designers', 1, NULL, NULL, NULL, '1', NULL);

-- ----------------------------
-- Table structure for main_mail_queue
-- ----------------------------
DROP TABLE IF EXISTS `main_mail_queue`;
CREATE TABLE `main_mail_queue`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seq` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` int(10) UNSIGNED DEFAULT NULL,
  `error` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `seq`(`seq`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_mail_queue
-- ----------------------------
INSERT INTO `main_mail_queue` VALUES (1, '1591062920170', 'default/ex (189) XXXXXXXXXXXXXXX', '121642038@qq.com;797206999@qq.com', 'ready', 1591062920, '');
INSERT INTO `main_mail_queue` VALUES (2, '1591063059169', 'default/ex (189) XXXXXXXXXXXXXXX', '121642038@qq.com;797206999@qq.com', 'ready', 1591063059, '');
INSERT INTO `main_mail_queue` VALUES (3, '1591187233335', 'default/example (190) 1111111', '121642038@qq.com', 'error', 1591187234, 'fsockopen failed:10061 由于目标计算机积极拒绝，无法连接。\r\n');

-- ----------------------------
-- Table structure for main_notify_scheme
-- ----------------------------
DROP TABLE IF EXISTS `main_notify_scheme`;
CREATE TABLE `main_notify_scheme`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_notify_scheme
-- ----------------------------
INSERT INTO `main_notify_scheme` VALUES (1, '默认通知方案', 1);

-- ----------------------------
-- Table structure for main_notify_scheme_data
-- ----------------------------
DROP TABLE IF EXISTS `main_notify_scheme_data`;
CREATE TABLE `main_notify_scheme_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scheme_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `flag` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[]' COMMENT '项目成员,经办人,报告人,关注人',
  `title_tpl` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `body_tpl` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_notify_scheme_data
-- ----------------------------
INSERT INTO `main_notify_scheme_data` VALUES (1, 1, '事项创建', 'issue@create', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '<br>\r\n\r\n{display_name} 创建了事项 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (2, 1, '事项更新', 'issue@update', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 更新了 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (3, 1, '事项分配', 'issue@assign', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 更新了 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (4, 1, '事项已解决', 'issue@resolve@complete', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 更新了 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (5, 1, '事项已关闭', 'issue@close', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 更新了 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (6, 1, '事项评论', 'issue@comment@create', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '<br><br>  [ {issue_link} ]<br>\r\n\r\n{display_name} 评论了  {issue_title}<br>\r\n> --------------------------------------<br>\r\n><br>\r\n>     {comment_content}<br>\r\n>  <br>\r\n\r\n\r\n\r\n<br><br>\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (7, 1, '删除评论', 'issue@comment@remove', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '<br><br>  [ {issue_link} ]<br>\r\n\r\n{display_name} 删除评论  {issue_title}<br>\r\n> --------------------------------------<br>\r\n><br>\r\n>     {comment_content}<br>\r\n>  <br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (8, 1, '开始解决事项', 'issue@resolve@start', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 更新了 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (9, 1, '停止解决事项', 'issue@resolve@stop', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 更新了 {issue_title}<br>\r\n> --------------------------------------<br>\r\n>\r\n>    键值: {issue_key}<br>\r\n>    网址: {issue_link}<br>\r\n>    项目: {project_title}<br>\r\n>    问题类型: {issue_type_title}<br>\r\n>    模块: {issue_module_title}<br>\r\n>    报告人: {report_display_name}<br>\r\n>    经办人: {assignee_display_name}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (10, 1, '新增迭代', 'sprint@create', '[\"project\"]', '{project_path}  {sprint_title}', ' <br><br>\r\n\r\n{display_name} 新增迭代： {sprint_title}:<br>\r\n \r\n\r\n> --------------------------------------<br>\r\n><br>\r\n>    项目: {project_title}<br>\r\n>    开始日期: {sprint_start_date}<br>\r\n>    截止日期: {sprint_end_date}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (11, 1, '设置迭代进行时', 'sprint@start', '[\"project\"]', '{project_path}  {sprint_title}', ' <br><br>\r\n\r\n{display_name} 更新了迭代： {sprint_title}:<br>\r\n \r\n\r\n> --------------------------------------<br>\r\n><br>\r\n>    项目: {project_title}<br>\r\n>    开始日期: {sprint_start_date}<br>\r\n>    截止日期: {sprint_end_date}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (12, 1, '删除迭代', 'sprint@remove', '[\"project\"]', '{project_path}  {sprint_title}', ' \r\n<br>\r\n{display_name} 删除迭代： {sprint_title}:<br>\r\n<br>\r\n<br>\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (13, 1, '更新迭代', 'sprint@update', '[\"project\"]', '{project_path}  {sprint_title}', ' <br><br>\r\n\r\n{display_name} 更新了迭代： {sprint_title}:<br>\r\n \r\n\r\n> --------------------------------------<br>\r\n><br>\r\n>    项目: {project_title}<br>\r\n>    开始日期: {sprint_start_date}<br>\r\n>    截止日期: {sprint_end_date}<br>\r\n\r\n><br>\r\n><br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');
INSERT INTO `main_notify_scheme_data` VALUES (14, 1, '事项已删除', 'issue@delete', '[\"assigee\",\"reporter\",\"follow\"]', '{project_path} ({issue_key}) {issue_title}', '\r\n<br>\r\n{display_name} 删除了事项<br>\r\n\r\n\r\n\r\n\r\n--<br>\r\n这条信息是由Masterlab发送的<br>\r\n(v2.1.4)<br>');

-- ----------------------------
-- Table structure for main_org
-- ----------------------------
DROP TABLE IF EXISTS `main_org`;
CREATE TABLE `main_org`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatar` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `create_uid` int(11) NOT NULL DEFAULT 0,
  `created` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `updated` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `scope` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 private, 2 internal , 3 public',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `path`(`path`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 147 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_org
-- ----------------------------
INSERT INTO `main_org` VALUES (1, 'default', 'Default', 'Default organization', 'org/default.jpg', 0, 0, 1535263464, 3);
INSERT INTO `main_org` VALUES (146, 'bilan', '荜蓝科技', '荜蓝科技荜蓝科技', '', 1, 1627433933, 0, 1);

-- ----------------------------
-- Table structure for main_plugin
-- ----------------------------
DROP TABLE IF EXISTS `main_plugin`;
CREATE TABLE `main_plugin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `index_page` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1已安装,2未安装,0无效(插件目录不存在)',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chmod_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon_file` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `install_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `enable` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用',
  `is_display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `order_weight`(`order_weight`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_plugin
-- ----------------------------
INSERT INTO `main_plugin` VALUES (1, 'activity', '活动日志', 'ctrl@index@pageIndex', '默认自带的插件：活动日志', '1.0', 1, 'project_module', '', 'http://www.masterlab.vip', '/attachment/plugin/1.png', 'Masterlab官方', 0, 0, 1, 1, 1);
INSERT INTO `main_plugin` VALUES (22, 'webhook', 'webhook', '', '默认自带的插件：webhook', '1.0', 1, 'admin_module', '', 'http://www.masterlab.vip', '/attachment/plugin/webhook.png', 'Masterlab官方', 0, 0, 1, 1, 1);
INSERT INTO `main_plugin` VALUES (86, 'integrates', '开发集成', '', '开发集成', '1.0', 1, 'project_module', '', '', '/attachment/plugin/develop.png', '', 0, 0, 0, 1, 1);
INSERT INTO `main_plugin` VALUES (87, 'appinte', 'appinte', '', '', '1.0', 1, 'app', '', '', '/attachment/image/20210803/20210803130738_51771.png', '', 0, 0, 0, 1, 1);
INSERT INTO `main_plugin` VALUES (88, 'devinte', 'devinte', '', 'ss', '1.0', 1, 'theme', '', '', '/attachment/image/20210803/20210803130944_15568.png', '', 0, 0, 0, 1, 1);
INSERT INTO `main_plugin` VALUES (89, 'integrateCode', 'integrateCode', '', '', '1.0', 1, 'app', '', '', '/attachment/plugin/develop.png', '', 0, 0, 0, 1, 1);

-- ----------------------------
-- Table structure for main_setting
-- ----------------------------
DROP TABLE IF EXISTS `main_setting`;
CREATE TABLE `main_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关键字',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '所属模块,basic,advance,ui,datetime,languge,attachment可选',
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `default_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '默认值',
  `format` enum('string','int','float','json') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'string' COMMENT '数据类型',
  `form_input_type` enum('datetime','date','textarea','select','checkbox','radio','img','color','file','int','number','text') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'text' COMMENT '表单项类型',
  `form_optional_value` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '待选的值定义,为json格式',
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `_key`(`_key`) USING BTREE,
  INDEX `module`(`module`) USING BTREE,
  INDEX `module_2`(`module`, `order_weight`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_setting
-- ----------------------------
INSERT INTO `main_setting` VALUES (1, 'title', '网站的页面标题', 'basic', 0, '荜蓝科技', 'MasterLab', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (2, 'open_status', '启用状态', 'basic', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (3, 'max_login_error', '最大尝试验证登录次数', 'basic', 0, '4', '4', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (4, 'login_require_captcha', '登录时需要验证码', 'basic', 0, '0', '0', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (5, 'reg_require_captcha', '注册时需要验证码', 'basic', 0, '0', '0', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (6, 'sender_format', '邮件发件人显示格式', 'basic', 0, '${fullname} (Masterlab)', '${fullname} (Hornet)', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (7, 'description', '说明', 'basic', 0, '', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (8, 'date_timezone', '默认用户时区', 'basic', 0, 'Asia/Shanghai', 'Asia/Shanghai', 'string', 'text', '', '');
INSERT INTO `main_setting` VALUES (11, 'allow_share_public', '允许用户分享过滤器或面部', 'basic', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (12, 'max_project_name', '项目名称最大长度', 'basic', 0, '80', '80', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (13, 'max_project_key', '项目键值最大长度', 'basic', 0, '20', '20', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (15, 'email_public', '邮件地址可见性', 'basic', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (20, 'allow_gravatars', '允许使用Gravatars用户头像', 'basic', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (21, 'gravatar_server', 'Gravatar服务器', 'basic', 0, '', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (24, 'send_mail_format', '默认发送个邮件的格式', 'user_default', 0, 'text', 'text', 'string', 'radio', '{\"text\":\"text\",\"html\":\"html\"}', '');
INSERT INTO `main_setting` VALUES (25, 'issue_page_size', '事项分页数量', 'user_default', 0, '100', '100', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (39, 'time_format', '时间格式', 'datetime', 0, 'H:i:s', 'HH:mm:ss', 'string', 'text', NULL, '例如 11:55:47');
INSERT INTO `main_setting` VALUES (40, 'week_format', '星期格式', 'datetime', 0, 'l H:i:s', 'EEEE HH:mm:ss', 'string', 'text', NULL, '例如 Wednesday 11:55:47');
INSERT INTO `main_setting` VALUES (41, 'full_datetime_format', '完整日期/时间格式', 'datetime', 0, 'Y-m-d H:i:s', 'yyyy-MM-dd  HH:mm:ss', 'string', 'text', NULL, '例如 2007-05-23  11:55:47');
INSERT INTO `main_setting` VALUES (42, 'datetime_format', '日期格式(年月日)', 'datetime', 0, 'Y-m-d', 'yyyy-MM-dd', 'string', 'text', NULL, '例如 2007-05-23');
INSERT INTO `main_setting` VALUES (43, 'use_iso', '在日期选择器中使用 ISO8601 标准', 'datetime', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '打开这个选项，在日期选择器中，以星期一作为每周的开始第一天');
INSERT INTO `main_setting` VALUES (45, 'attachment_dir', '附件路径', 'attachment', 0, '{{PUBLIC_PATH}}attachment', '{{STORAGE_PATH}}attachment', 'string', 'text', NULL, '附件存放的绝对或相对路径, 一旦被修改, 你需要手工拷贝原来目录下所有的附件到新的目录下');
INSERT INTO `main_setting` VALUES (46, 'attachment_size', '附件大小(单位M)', 'attachment', 0, '128.0', '10.0', 'float', 'text', NULL, '超过大小,无法上传,修改该值后同时还要修改 php.ini 的 post_max_size 和 upload_max_filesize');
INSERT INTO `main_setting` VALUES (47, 'enbale_thum', '启用缩略图', 'attachment', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '允许创建图像附件的缩略图');
INSERT INTO `main_setting` VALUES (48, 'enable_zip', '启用ZIP支持', 'attachment', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '允许用户将一个问题的所有附件打包成一个ZIP文件下载');
INSERT INTO `main_setting` VALUES (49, 'password_strategy', '密码策略', 'password_strategy', 0, '1', '2', 'int', 'radio', '{\"1\":\"禁用\",\"2\":\"简单\",\"3\":\"安全\"}', '');
INSERT INTO `main_setting` VALUES (50, 'send_mailer', '发信人', 'mail', 940, 'xx@163.com', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (51, 'mail_prefix', '前缀', 'mail', 930, 'Masterlab', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (52, 'mail_host', 'SMTP服务器', 'mail', 999, 'smtp.163.com', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (53, 'mail_port', 'SMTP端口', 'mail', 980, '25', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (54, 'mail_account', '账号', 'mail', 970, 'xxx@163.com', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (55, 'mail_password', '密码', 'mail', 960, 'XJXMSWLVCWDMPCEI1', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (56, 'mail_timeout', '发送超时', 'mail', 950, '10', '', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (57, 'page_layout', '页面布局', 'user_default', 0, 'float', 'fixed', 'string', 'radio', '{\"fixed\":\"固定\",\"float\":\"自适应\"}', '');
INSERT INTO `main_setting` VALUES (58, 'project_view', '项目默认显示页', 'user_default', 0, 'issues', 'issues', 'string', 'radio', '{\"issues\":\"事项列表\",\"summary\":\"项目摘要\",\"backlog\":\"待办事项\",\"sprints\":\"迭代列表\",\"board\":\"迭代看板\"}', '');
INSERT INTO `main_setting` VALUES (59, 'company', '公司名称(暂不可用)', 'basic', 0, '荜蓝科技', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (60, 'company_logo', '公司logo(暂不可用)', 'basic', 0, 'logo', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (61, 'company_linkman', '联系人', 'basic', 0, '大雄', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (62, 'company_phone', '联系电话', 'basic', 0, '13983854512', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (63, 'enable_async_mail', '是否使用异步方式发送邮件', 'mail', 890, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (64, 'enable_mail', '是否开启邮件推送', 'mail', 1024, '0', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (70, 'socket_server_host', 'MasterlabSocket服务器地址', 'mail', 880, '127.0.0.1', '127.0.0.1', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (71, 'socket_server_port', 'MasterlabSocket服务器端口', 'mail', 870, '9002', '9002', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (72, 'allow_user_reg', '允许用户注册', 'basic', 0, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '如关闭，则用户无法注册系统用户');
INSERT INTO `main_setting` VALUES (73, 'ldap_hosts', '服务器地址', 'ldap', 94, '192.168.0.129', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (74, 'ldap_port', '服务器端口', 'ldap', 90, '389', '389', 'int', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (75, 'ldap_schema', '服务器类型', 'ldap', 96, 'OpenLDAP', 'ActiveDirectory', 'string', 'select', '{\"ActiveDirectory\":\"ActiveDirectory\",\"OpenLDAP\":\"OpenLDAP\",\"FreeIPA\": \"FreeIPA\"}', '');
INSERT INTO `main_setting` VALUES (76, 'ldap_username', '管理员DN值', 'ldap', 70, 'CN=Administrator,CN=Users,DC=extest,DC=cn', 'cn=Manager,dc=masterlab,dc=vip', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (77, 'ldap_password', '管理员密码', 'ldap', 60, 'testtest', '', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (78, 'ldap_base_dn', 'BASE_DN', 'ldap', 76, 'dc=extest,dc=cn', 'dc=masterlab,dc=vip', 'string', 'text', NULL, '不能为空');
INSERT INTO `main_setting` VALUES (79, 'ldap_timeout', '连接超时时间', 'ldap', 88, '10', '10', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (80, 'ldap_version', '版本', 'ldap', 80, '3', '3', 'string', 'text', NULL, '');
INSERT INTO `main_setting` VALUES (81, 'ldap_security protocol', '安全协议', 'ldap', 84, '', '', 'string', 'select', '{\"\":\"普通\",\"ssl\":\"SSL\",\"tls\":\"TLS\"}', '');
INSERT INTO `main_setting` VALUES (82, 'ldap_enable', '启用', 'ldap', 99, '1', '1', 'int', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (83, 'ldap_match_attr', '匹配属性', 'ldap', 74, 'cn', 'cn', 'string', 'text', '', '设置什么属性作为匹配用户名，建议使用 cn 或 dn ');
INSERT INTO `main_setting` VALUES (84, 'is_exchange_server', '服务器为ExchangeServer', 'mail', 910, '0', '0', 'string', 'radio', '{\"1\":\"是\",\"0\":\"否\"}', '');
INSERT INTO `main_setting` VALUES (85, 'is_ssl', 'SSL', 'mail', 920, '0', '0', 'string', 'radio', '{\"1\":\"开启\",\"0\":\"关闭\"}', '');
INSERT INTO `main_setting` VALUES (86, 'socket_server_type', '服务器类型', 'mail', 920, 'golang', 'golang', 'string', 'radio', '{\"golang\":\"Golang\",\"swoole\":\"Swoole\"}', '异步服务的类型');

-- ----------------------------
-- Table structure for main_timeline
-- ----------------------------
DROP TABLE IF EXISTS `main_timeline`;
CREATE TABLE `main_timeline`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `type` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `origin_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `issue_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `action` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `action_icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_html` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_timeline
-- ----------------------------
INSERT INTO `main_timeline` VALUES (2, 1, 'issue', 0, 0, 141, 'commented', '', 'xxxxx:scream: :scream:', '<p>xxxxx<img src=\"/dev/lib/editor.md/plugins/emoji-dialog/emoji/scream.png\" class=\"emoji\" title=\"&#58;scream&#58;\" alt=\"&#58;scream&#58;\" /> <img src=\"/dev/lib/editor.md/plugins/emoji-dialog/emoji/scream.png\" class=\"emoji\" title=\"&#58;scream&#58;\" alt=\"&#58;scream&#58;\" /></p>\n', 1584364965);
INSERT INTO `main_timeline` VALUES (3, 1, 'issue', 0, 0, 53, 'commented', '', 'xxxxxxxxxxxxxxxx', '<p>xxxxxxxxxxxxxxxx</p>\n', 1587180329);
INSERT INTO `main_timeline` VALUES (4, 1, 'issue', 0, 0, 53, 'commented', '', '![1cut-202004181104262556.png](/attachment/image/20200418/1cut-202004181104262556.png &quot;截图-1cut-202004181104262556.png&quot;)\nQQQQ\n&lt;?php\necho &quot;luck!~~~&quot;;\nswwwwww\ndie\n?&gt;\n\n![1cut-202004181204416274.png](/attachment/image/20200418/1cut-202004181204416274.png &quot;截图-1cut-202004181204416274.png&quot;)\nxxxxx', '<p><img src=\"/attachment/image/20200418/1cut-202004181104262556.png\" alt=\"1cut-202004181104262556.png\" title=\"截图-1cut-202004181104262556.png\"><br>QQQQ<br>&lt;?php<br>echo “luck!~~~”;<br>swwwwww<br>die<br>?&gt;</p>\n<p><img src=\"/attachment/image/20200418/1cut-202004181204416274.png\" alt=\"1cut-202004181204416274.png\" title=\"截图-1cut-202004181204416274.png\"><br>xxxxx</p>\n', 1587181129);
INSERT INTO `main_timeline` VALUES (5, 1, 'issue', 0, 0, 53, 'commented', '', '\n\n![1cut-202004181204502776.png](/attachment/image/20200418/1cut-202004181204502776.png &quot;截图-1cut-202004181204502776.png&quot;)\n\nwwww', '<p><img src=\"/attachment/image/20200418/1cut-202004181204502776.png\" alt=\"1cut-202004181204502776.png\" title=\"截图-1cut-202004181204502776.png\"></p>\n<p>wwww</p>\n', 1587183534);
INSERT INTO `main_timeline` VALUES (6, 1, 'issue', 0, 0, 53, 'commented', '', '\n![1cut-202004181204156780.png](/attachment/image/20200418/1cut-202004181204156780.png &quot;截图-1cut-202004181204156780.png&quot;)\n\nssssssssssssss', '<p><img src=\"/attachment/image/20200418/1cut-202004181204156780.png\" alt=\"1cut-202004181204156780.png\" title=\"截图-1cut-202004181204156780.png\"></p>\n<p>ssssssssssssss</p>\n', 1587183559);
INSERT INTO `main_timeline` VALUES (7, 1, 'issue', 0, 0, 53, 'commented', '', '![1cut-202004181204289139.png](/attachment/image/20200418/1cut-202004181204289139.png &quot;截图-1cut-202004181204289139.png&quot;)\nwwwwwwwwwwwwwww\n\n![1cut-202004181204518758.png](/attachment/image/20200418/1cut-202004181204518758.png &quot;截图-1cut-202004181204518758.png&quot;)\n\nsssssssssssssssssssss', '<p><img src=\"/attachment/image/20200418/1cut-202004181204289139.png\" alt=\"1cut-202004181204289139.png\" title=\"截图-1cut-202004181204289139.png\"><br>wwwwwwwwwwwwwww</p>\n<p><img src=\"/attachment/image/20200418/1cut-202004181204518758.png\" alt=\"1cut-202004181204518758.png\" title=\"截图-1cut-202004181204518758.png\"></p>\n<p>sssssssssssssssssssss</p>\n', 1587183571);
INSERT INTO `main_timeline` VALUES (8, 1, 'issue', 0, 0, 108, 'commented', '', 'xxxxxxxxxxxxxx\nsdfsdfsdfsdf\ndsffsdfds\n![1cut-202004181404358718.png](/attachment/image/20200418/1cut-202004181404358718.png &quot;截图-1cut-202004181404358718.png&quot;)\n\nxxxxxxxsssss\n\n\n![1cut-202004181404564473.png](/attachment/image/20200418/1cut-202004181404564473.png &quot;截图-1cut-202004181404564473.png&quot;)', '<p>xxxxxxxxxxxxxx<br>sdfsdfsdfsdf<br>dsffsdfds<br><img src=\"/attachment/image/20200418/1cut-202004181404358718.png\" alt=\"1cut-202004181404358718.png\" title=\"截图-1cut-202004181404358718.png\"></p>\n<p>xxxxxxxsssss</p>\n<p><img src=\"/attachment/image/20200418/1cut-202004181404564473.png\" alt=\"1cut-202004181404564473.png\" title=\"截图-1cut-202004181404564473.png\"></p>\n', 1587190884);
INSERT INTO `main_timeline` VALUES (9, 1, 'issue', 0, 0, 108, 'commented', '', 'sdfsdfsd\nsdfsdf\n![1cut-202004181404529314.png](/attachment/image/20200418/1cut-202004181404529314.png &quot;截图-1cut-202004181404529314.png&quot;)', '<p>sdfsdfsd<br>sdfsdf<br><img src=\"/attachment/image/20200418/1cut-202004181404529314.png\" alt=\"1cut-202004181404529314.png\" title=\"截图-1cut-202004181404529314.png\"></p>\n', 1587191693);
INSERT INTO `main_timeline` VALUES (10, 1, 'issue', 0, 0, 108, 'commented', '', 'sdfdsfsd\nfsdfdsfsdf\n![1cut-202004181404576182.png](/attachment/image/20200418/1cut-202004181404576182.png &quot;截图-1cut-202004181404576182.png&quot;)', '<p>sdfdsfsd<br>fsdfdsfsdf<br><img src=\"/attachment/image/20200418/1cut-202004181404576182.png\" alt=\"1cut-202004181404576182.png\" title=\"截图-1cut-202004181404576182.png\"></p>\n', 1587191819);
INSERT INTO `main_timeline` VALUES (13, 1, 'issue', 0, 0, 108, 'commented', '', '![1cut-202004181504144786.png](/attachment/image/20200418/1cut-202004181504144786.png &quot;截图-1cut-202004181504144786.png&quot;)', '<p><img src=\"/attachment/image/20200418/1cut-202004181504144786.png\" alt=\"1cut-202004181504144786.png\" title=\"截图-1cut-202004181504144786.png\"></p>\n', 1587196035);
INSERT INTO `main_timeline` VALUES (14, 1, 'issue', 0, 0, 106, 'commented', '', 'xxxxxxxxxxx\nsdfdf\n![1cut-202004181604342388.png](/attachment/image/20200418/1cut-202004181604342388.png &quot;截图-1cut-202004181604342388.png&quot;)\nsdcfsdcsdcsd\nzxczczxczxc\nzxczx', '<p>xxxxxxxxxxx<br>sdfdf<br><img src=\"/attachment/image/20200418/1cut-202004181604342388.png\" alt=\"1cut-202004181604342388.png\" title=\"截图-1cut-202004181604342388.png\"><br>sdcfsdcsdcsd<br>zxczczxczxc<br>zxc</p>\n', 1587198025);
INSERT INTO `main_timeline` VALUES (15, 1, 'issue', 0, 0, 106, 'updated_comment', '', 'updated comment', '<p>xxxxxxxxxxx<br>sdfdf<br><img src=\"/attachment/image/20200418/1cut-202004181604342388.png\" alt=\"1cut-202004181604342388.png\" title=\"截图-1cut-202004181604342388.png\"></p>\n', 1587198035);
INSERT INTO `main_timeline` VALUES (16, 1, 'issue', 0, 0, 180, 'commented', '', '![](http://www.masterlab213.com/attachment/image/20200528/20200528180045_84904.png)', '<p><img src=\"http://www.masterlab213.com/attachment/image/20200528/20200528180045_84904.png\" alt=\"\"></p>\n', 1590660049);
INSERT INTO `main_timeline` VALUES (17, 1, 'issue', 0, 0, 186, 'commented', '', 'xxxxxxxxxxxxxxxxxxxxxx', '<p>xxxxxxxxxxxxxxxxxxx</p>\n', 1591000636);
INSERT INTO `main_timeline` VALUES (18, 1, 'issue', 0, 0, 186, 'commented', '', 'xxxxx', '<p>xxxxx</p>\n', 1591001139);
INSERT INTO `main_timeline` VALUES (19, 1, 'issue', 0, 0, 186, 'commented', '', 'test', '<p>test</p>\n', 1591001192);
INSERT INTO `main_timeline` VALUES (20, 1, 'issue', 0, 0, 186, 'commented', '', 'test', '<p>test</p>\n', 1591001226);
INSERT INTO `main_timeline` VALUES (21, 1, 'issue', 0, 0, 186, 'commented', '', 'test', '<p>test</p>\n', 1591001263);
INSERT INTO `main_timeline` VALUES (22, 1, 'issue', 0, 0, 186, 'commented', '', 'test', '<p>test</p>\n', 1591001347);
INSERT INTO `main_timeline` VALUES (23, 1, 'issue', 0, 0, 186, 'commented', '', 'test', '<p>test</p>\n', 1591001369);
INSERT INTO `main_timeline` VALUES (24, 1, 'issue', 0, 0, 186, 'commented', '', 'test', '<p>test</p>\n', 1591001441);
INSERT INTO `main_timeline` VALUES (25, 1, 'issue', 0, 0, 207, 'commented', '', 'www', '<p>www</p>\n', 1596635923);

-- ----------------------------
-- Table structure for main_webhook
-- ----------------------------
DROP TABLE IF EXISTS `main_webhook`;
CREATE TABLE `main_webhook`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_json` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用',
  `timeout` tinyint(3) UNSIGNED NOT NULL DEFAULT 10,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hook_event_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '定义触发哪些事件',
  UNIQUE INDEX `id`(`id`) USING BTREE,
  INDEX `enable`(`enable`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_webhook_log
-- ----------------------------
DROP TABLE IF EXISTS `main_webhook_log`;
CREATE TABLE `main_webhook_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `webhook_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `event_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0准备中;1执行成功;2异步发送失败;3队列中;4执行失败',
  `time` int(10) UNSIGNED NOT NULL,
  `timeout` tinyint(3) UNSIGNED NOT NULL DEFAULT 15 COMMENT '超时时间',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '提交的当前用户id',
  `err_msg` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for main_widget
-- ----------------------------
DROP TABLE IF EXISTS `main_widget`;
CREATE TABLE `main_widget`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工具名称',
  `_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `method` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` enum('list','chart_line','chart_pie','chart_bar','text') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '工具类型',
  `status` tinyint(4) DEFAULT 1 COMMENT '状态（1可用，0不可用）',
  `is_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `required_param` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否需要参数才能获取数据',
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '描述',
  `parameter` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '{}' COMMENT '支持的参数说明',
  `order_weight` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `_key`(`_key`) USING BTREE,
  INDEX `order_weight`(`order_weight`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of main_widget
-- ----------------------------
INSERT INTO `main_widget` VALUES (1, '我参与的项目', 'my_projects', 'fetchUserHaveJoinProjects', '通用', 'my_projects.png', 'list', 1, 1, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (2, '分配给我的事项', 'assignee_my', 'fetchAssigneeIssues', '通用', 'assignee_my.png', 'list', 1, 1, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (3, '活动日志', 'activity', 'fetchActivity', '通用', 'activity.png', 'list', 1, 1, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (4, '便捷导航', 'nav', 'fetchNav', '通用', 'nav.png', 'list', 1, 1, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (5, '组织', 'org', 'fetchOrgs', '通用', 'org.png', 'list', 1, 1, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (6, '项目-汇总', 'project_stat', 'fetchProjectStat', '项目', 'project_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (7, '项目-解决与未解决对比图', 'project_abs', 'fetchProjectAbs', '项目', 'abs.png', 'chart_bar', 1, 0, 1, '', '\r\n[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"时间\",\"field\":\"by_time\",\"type\":\"select\",\"value\":[{\"title\":\"天\",\"value\":\"date\"},{\"title\":\"周\",\"value\":\"week\"},{\"title\":\"月\",\"value\":\"month\"}]},{\"name\":\"几日之内\",\"field\":\"within_date\",\"type\":\"text\",\"value\":\"\"}]', 0);
INSERT INTO `main_widget` VALUES (8, '项目-优先级统计', 'project_priority_stat', 'fetchProjectPriorityStat', '项目', 'priority_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"状态\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]\r\n', 0);
INSERT INTO `main_widget` VALUES (9, '项目-状态统计', 'project_status_stat', 'fetchProjectStatusStat', '项目', 'status_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (10, '项目-开发者统计', 'project_developer_stat', 'fetchProjectDeveloperStat', '项目', 'developer_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"状态\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]', 0);
INSERT INTO `main_widget` VALUES (11, '项目-事项统计', 'project_issue_type_stat', 'fetchProjectIssueTypeStat', '项目', 'issue_type_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (12, '项目-饼状图', 'project_pie', 'fetchProjectPie', '项目', 'chart_pie.png', 'chart_pie', 1, 0, 1, '', '[{\"name\":\"项目\",\"field\":\"project_id\",\"type\":\"my_projects_select\",\"value\":[]},{\"name\":\"数据源\",\"field\":\"data_field\",\"type\":\"select\",\"value\":[{\"title\":\"经办人\",\"value\":\"assignee\"},{\"title\":\"优先级\",\"value\":\"priority\"},{\"title\":\"事项类型\",\"value\":\"issue_type\"},{\"title\":\"状态\",\"value\":\"status\"}]},{\"name\":\"开始时间\",\"field\":\"start_date\",\"type\":\"date\",\"value\":\"\"},{\"name\":\"结束时间\",\"field\":\"end_date\",\"type\":\"date\",\"value\":\"\"}]', 0);
INSERT INTO `main_widget` VALUES (13, '迭代-汇总', 'sprint_stat', 'fetchSprintStat', '迭代', 'sprint_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (14, '迭代-倒计时', 'sprint_countdown', 'fetchSprintCountdown', '项目', 'countdown.png', 'text', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (15, '迭代-燃尽图', 'sprint_burndown', 'fetchSprintBurndown', '迭代', 'burndown.png', 'text', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (16, '迭代-速率图', 'sprint_speed', 'fetchSprintSpeedRate', '迭代', 'sprint_speed.png', 'text', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (17, '迭代-饼状图', 'sprint_pie', 'fetchSprintPie', '迭代', 'chart_pie.png', 'chart_pie', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]},{\"name\":\"数据源\",\"field\":\"data_field\",\"type\":\"select\",\"value\":[{\"title\":\"经办人\",\"value\":\"assignee\"},{\"title\":\"优先级\",\"value\":\"priority\"},{\"title\":\"事项类型\",\"value\":\"issue_type\"},{\"title\":\"状态\",\"value\":\"status\"}]}]', 0);
INSERT INTO `main_widget` VALUES (18, '迭代-解决与未解决对比图', 'sprint_abs', 'fetchSprintAbs', '迭代', 'abs.png', 'chart_bar', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (19, '迭代-优先级统计', 'sprint_priority_stat', 'fetchSprintPriorityStat', '迭代', 'priority_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]},{\"name\":\"状态\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]', 0);
INSERT INTO `main_widget` VALUES (20, '迭代-状态统计', 'sprint_status_stat', 'fetchSprintStatusStat', '迭代', 'status_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (21, '迭代-开发者统计', 'sprint_developer_stat', 'fetchSprintDeveloperStat', '迭代', 'developer_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]},{\"name\":\"迭代\",\"field\":\"status\",\"type\":\"select\",\"value\":[{\"title\":\"全部\",\"value\":\"all\"},{\"title\":\"未解决\",\"value\":\"unfix\"}]}]', 0);
INSERT INTO `main_widget` VALUES (22, '迭代-事项统计', 'sprint_issue_type_stat', 'fetchSprintIssueTypeStat', '迭代', 'issue_type_stat.png', 'list', 1, 0, 1, '', '[{\"name\":\"迭代\",\"field\":\"sprint_id\",\"type\":\"my_projects_sprint_select\",\"value\":[]}]', 0);
INSERT INTO `main_widget` VALUES (23, '分配给我未解决的事项', 'unresolve_assignee_my', 'fetchUnResolveAssigneeIssues', '通用', 'assignee_my.png', 'list', 1, 1, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (24, '我关注的事项', 'my_follow', 'fetchFollowIssues', '通用', 'my_follow.png', 'list', 1, 0, 0, '', '[]', 0);
INSERT INTO `main_widget` VALUES (25, '我协助的事项', 'my_assistant_issue', 'fetchAssistantIssues', '通用', 'my_assistant_issue.png', 'list', 1, 0, 0, '', '[]', 0);

-- ----------------------------
-- Table structure for mind_issue_attribute
-- ----------------------------
DROP TABLE IF EXISTS `mind_issue_attribute`;
CREATE TABLE `mind_issue_attribute`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `issue_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `source` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `group_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `layout` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shape` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_family` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_size` tinyint(4) NOT NULL DEFAULT 1,
  `font_bold` tinyint(1) NOT NULL DEFAULT 0,
  `font_italic` tinyint(1) NOT NULL DEFAULT 0,
  `bg_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text_color` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `side` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id_2`(`project_id`, `issue_id`, `source`, `group_by`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mind_issue_attribute
-- ----------------------------
INSERT INTO `mind_issue_attribute` VALUES (110, 3, 234, 'all', 'module', '', '', '#EE3333', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (112, 3, 174, '5', 'module', '', '', '#EE3333', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (113, 3, 170, '5', 'module', '', '', '#EE3333', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (118, 3, 239, '44', 'module', '', '', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (119, 3, 754, '44', 'module', '', 'ellipse', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (122, 3, 218, '44', 'module', '', '', '#3740A7', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (126, 3, 186, '44', 'module', '', '', '', '', '', 1, 1, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (127, 3, 171, '44', 'module', '', 'ellipse', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (128, 3, 747, '44', 'module', '', 'ellipse', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (129, 3, 760, '44', 'module', '', 'ellipse', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_issue_attribute` VALUES (130, 3, 758, '44', 'module', '', 'ellipse', '', '', '', 1, 0, 0, '', '', '');

-- ----------------------------
-- Table structure for mind_project_attribute
-- ----------------------------
DROP TABLE IF EXISTS `mind_project_attribute`;
CREATE TABLE `mind_project_attribute`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `layout` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shape` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_family` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_size` tinyint(4) NOT NULL DEFAULT 1,
  `font_bold` tinyint(1) NOT NULL DEFAULT 0,
  `font_italic` tinyint(1) NOT NULL DEFAULT 0,
  `bg_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `side` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mind_project_attribute
-- ----------------------------
INSERT INTO `mind_project_attribute` VALUES (4, 3, '', '', '', '', '', 1, 0, 0, '', '#9C27B0E6', '');
INSERT INTO `mind_project_attribute` VALUES (14, 1, '', '', '', '', '', 3, 0, 0, '', '', '');

-- ----------------------------
-- Table structure for mind_second_attribute
-- ----------------------------
DROP TABLE IF EXISTS `mind_second_attribute`;
CREATE TABLE `mind_second_attribute`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `source` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `group_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `group_by_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `layout` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shape` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_family` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_size` tinyint(4) NOT NULL DEFAULT 1,
  `font_bold` tinyint(1) NOT NULL DEFAULT 0,
  `font_italic` tinyint(1) NOT NULL DEFAULT 0,
  `bg_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `side` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `mind_unique`(`project_id`, `source`, `group_by`, `group_by_id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  INDEX `source_group_by`(`project_id`, `source`, `group_by`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 239 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mind_second_attribute
-- ----------------------------
INSERT INTO `mind_second_attribute` VALUES (4, 3, '44', 'module', '11', 'tree-left', '', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_second_attribute` VALUES (6, 3, '44', 'module', 'module_10', '', '', '', '', '', 2, 0, 0, '', '', '');
INSERT INTO `mind_second_attribute` VALUES (7, 3, '44', 'module', 'module_9', '', '', '', '', '', 2, 0, 0, '', '', '');
INSERT INTO `mind_second_attribute` VALUES (18, 3, '44', 'module', '6', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (23, 3, '44', 'module', '9', '', '', '', '', '', 1, 0, 0, '', '#9C27B0E6', '');
INSERT INTO `mind_second_attribute` VALUES (24, 3, '44', 'module', '10', '', '', '', '', '', 1, 0, 0, '', '#9C27B0E6', '');
INSERT INTO `mind_second_attribute` VALUES (26, 3, '44', 'module', '8', '', 'ellipse', '', '', '', 1, 0, 0, '', '', '');
INSERT INTO `mind_second_attribute` VALUES (29, 3, '44', 'module', '7', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (110, 1, '1', 'module', '5', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (111, 1, '1', 'module', '4', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (112, 1, '1', 'module', '6', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (114, 1, '1', 'module', '1', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (116, 1, '1', 'module', '2', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (136, 1, '1', 'module', '3', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (174, 1, 'all', 'sprint', '0', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (229, 1, 'all', 'sprint', '1', '', '', '', '', '', 1, 0, 0, '', '#000000', '');
INSERT INTO `mind_second_attribute` VALUES (238, 1, 'all', 'sprint', '2', '', '', '', '', '', 1, 0, 0, '', '#000000', '');

-- ----------------------------
-- Table structure for mind_sprint_attribute
-- ----------------------------
DROP TABLE IF EXISTS `mind_sprint_attribute`;
CREATE TABLE `mind_sprint_attribute`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sprint_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `layout` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shape` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_family` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `font_size` tinyint(4) NOT NULL DEFAULT 1,
  `font_bold` tinyint(1) NOT NULL DEFAULT 0,
  `font_italic` tinyint(1) NOT NULL DEFAULT 0,
  `bg_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text_color` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `side` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sprint_id`(`sprint_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mind_sprint_attribute
-- ----------------------------
INSERT INTO `mind_sprint_attribute` VALUES (24, 44, '', '', '', '', '', 1, 0, 0, '', '#2196F3BF', '');

-- ----------------------------
-- Table structure for permission_default_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_default_role`;
CREATE TABLE `permission_default_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `project_id` int(10) UNSIGNED DEFAULT 0 COMMENT '3.0版本后废弃',
  `project_tpl_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属的项目模板id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_tpl_id`(`project_tpl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10020 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_default_role
-- ----------------------------
INSERT INTO `permission_default_role` VALUES (10000, 'Users', '普通用户', 0, 0);
INSERT INTO `permission_default_role` VALUES (10001, 'Developers', '开发者,如程序员，架构师', 0, 0);
INSERT INTO `permission_default_role` VALUES (10002, 'Administrators', '项目管理员，如项目经理，技术经理', 0, 0);
INSERT INTO `permission_default_role` VALUES (10003, 'QA', '测试工程师', 0, 0);
INSERT INTO `permission_default_role` VALUES (10006, 'PO', '产品经理，产品负责人', 0, 0);
INSERT INTO `permission_default_role` VALUES (10007, '测试人员', '', 0, 1);
INSERT INTO `permission_default_role` VALUES (10008, '开发人员', '', 0, 1);
INSERT INTO `permission_default_role` VALUES (10009, '普通成员', '', 0, 1);
INSERT INTO `permission_default_role` VALUES (10010, '项目经理', '项目的管理者', 0, 1);
INSERT INTO `permission_default_role` VALUES (10011, '测试', '', 0, 2);
INSERT INTO `permission_default_role` VALUES (10012, '开发者', '', 0, 2);
INSERT INTO `permission_default_role` VALUES (10013, '项目经理', '', 0, 2);
INSERT INTO `permission_default_role` VALUES (10015, '产品经理', '', 0, 2);
INSERT INTO `permission_default_role` VALUES (10016, '运维', '', 0, 2);
INSERT INTO `permission_default_role` VALUES (10017, 'PO', '产品负责人', 0, 3);
INSERT INTO `permission_default_role` VALUES (10018, 'Master', '以各种方式服务于产品负责人，开发人员以及团队', 0, 3);
INSERT INTO `permission_default_role` VALUES (10019, 'Member', '开发人员可包括具有专业技能的人员，如前端开发人员，后端开发人员，开发人员，QA专家，业务分析师，DBA等，他们都被称为开发人员;', 0, 3);

-- ----------------------------
-- Table structure for permission_default_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `permission_default_role_relation`;
CREATE TABLE `permission_default_role_relation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `perm_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `default_role_id`(`role_id`) USING BTREE,
  INDEX `role_id-and-perm_id`(`role_id`, `perm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 313 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_default_role_relation
-- ----------------------------
INSERT INTO `permission_default_role_relation` VALUES (42, 10000, 10005);
INSERT INTO `permission_default_role_relation` VALUES (43, 10000, 10006);
INSERT INTO `permission_default_role_relation` VALUES (44, 10000, 10007);
INSERT INTO `permission_default_role_relation` VALUES (45, 10000, 10008);
INSERT INTO `permission_default_role_relation` VALUES (46, 10000, 10013);
INSERT INTO `permission_default_role_relation` VALUES (47, 10001, 10005);
INSERT INTO `permission_default_role_relation` VALUES (48, 10001, 10006);
INSERT INTO `permission_default_role_relation` VALUES (49, 10001, 10007);
INSERT INTO `permission_default_role_relation` VALUES (50, 10001, 10008);
INSERT INTO `permission_default_role_relation` VALUES (51, 10001, 10013);
INSERT INTO `permission_default_role_relation` VALUES (52, 10001, 10014);
INSERT INTO `permission_default_role_relation` VALUES (53, 10001, 10015);
INSERT INTO `permission_default_role_relation` VALUES (79, 10001, 10016);
INSERT INTO `permission_default_role_relation` VALUES (54, 10001, 10028);
INSERT INTO `permission_default_role_relation` VALUES (55, 10002, 10004);
INSERT INTO `permission_default_role_relation` VALUES (56, 10002, 10005);
INSERT INTO `permission_default_role_relation` VALUES (57, 10002, 10006);
INSERT INTO `permission_default_role_relation` VALUES (58, 10002, 10007);
INSERT INTO `permission_default_role_relation` VALUES (59, 10002, 10008);
INSERT INTO `permission_default_role_relation` VALUES (60, 10002, 10013);
INSERT INTO `permission_default_role_relation` VALUES (61, 10002, 10014);
INSERT INTO `permission_default_role_relation` VALUES (62, 10002, 10015);
INSERT INTO `permission_default_role_relation` VALUES (80, 10002, 10016);
INSERT INTO `permission_default_role_relation` VALUES (81, 10002, 10017);
INSERT INTO `permission_default_role_relation` VALUES (63, 10002, 10028);
INSERT INTO `permission_default_role_relation` VALUES (64, 10002, 10902);
INSERT INTO `permission_default_role_relation` VALUES (65, 10002, 10903);
INSERT INTO `permission_default_role_relation` VALUES (66, 10002, 10904);
INSERT INTO `permission_default_role_relation` VALUES (82, 10002, 10905);
INSERT INTO `permission_default_role_relation` VALUES (83, 10002, 10906);
INSERT INTO `permission_default_role_relation` VALUES (100, 10002, 10907);
INSERT INTO `permission_default_role_relation` VALUES (101, 10002, 10908);
INSERT INTO `permission_default_role_relation` VALUES (91, 10003, 10005);
INSERT INTO `permission_default_role_relation` VALUES (92, 10003, 10006);
INSERT INTO `permission_default_role_relation` VALUES (93, 10003, 10007);
INSERT INTO `permission_default_role_relation` VALUES (94, 10003, 10008);
INSERT INTO `permission_default_role_relation` VALUES (95, 10003, 10013);
INSERT INTO `permission_default_role_relation` VALUES (96, 10003, 10014);
INSERT INTO `permission_default_role_relation` VALUES (97, 10003, 10015);
INSERT INTO `permission_default_role_relation` VALUES (99, 10003, 10017);
INSERT INTO `permission_default_role_relation` VALUES (98, 10003, 10028);
INSERT INTO `permission_default_role_relation` VALUES (67, 10006, 10004);
INSERT INTO `permission_default_role_relation` VALUES (68, 10006, 10005);
INSERT INTO `permission_default_role_relation` VALUES (69, 10006, 10006);
INSERT INTO `permission_default_role_relation` VALUES (70, 10006, 10007);
INSERT INTO `permission_default_role_relation` VALUES (71, 10006, 10008);
INSERT INTO `permission_default_role_relation` VALUES (72, 10006, 10013);
INSERT INTO `permission_default_role_relation` VALUES (73, 10006, 10014);
INSERT INTO `permission_default_role_relation` VALUES (74, 10006, 10015);
INSERT INTO `permission_default_role_relation` VALUES (87, 10006, 10016);
INSERT INTO `permission_default_role_relation` VALUES (84, 10006, 10017);
INSERT INTO `permission_default_role_relation` VALUES (75, 10006, 10028);
INSERT INTO `permission_default_role_relation` VALUES (76, 10006, 10902);
INSERT INTO `permission_default_role_relation` VALUES (77, 10006, 10903);
INSERT INTO `permission_default_role_relation` VALUES (78, 10006, 10904);
INSERT INTO `permission_default_role_relation` VALUES (85, 10006, 10905);
INSERT INTO `permission_default_role_relation` VALUES (86, 10006, 10906);
INSERT INTO `permission_default_role_relation` VALUES (102, 10006, 10907);
INSERT INTO `permission_default_role_relation` VALUES (103, 10006, 10908);
INSERT INTO `permission_default_role_relation` VALUES (140, 10007, 10005);
INSERT INTO `permission_default_role_relation` VALUES (141, 10007, 10006);
INSERT INTO `permission_default_role_relation` VALUES (142, 10007, 10007);
INSERT INTO `permission_default_role_relation` VALUES (143, 10007, 10008);
INSERT INTO `permission_default_role_relation` VALUES (144, 10007, 10013);
INSERT INTO `permission_default_role_relation` VALUES (145, 10007, 10014);
INSERT INTO `permission_default_role_relation` VALUES (146, 10007, 10015);
INSERT INTO `permission_default_role_relation` VALUES (147, 10007, 10016);
INSERT INTO `permission_default_role_relation` VALUES (148, 10007, 10017);
INSERT INTO `permission_default_role_relation` VALUES (149, 10007, 10028);
INSERT INTO `permission_default_role_relation` VALUES (150, 10007, 10902);
INSERT INTO `permission_default_role_relation` VALUES (151, 10007, 10903);
INSERT INTO `permission_default_role_relation` VALUES (152, 10007, 10904);
INSERT INTO `permission_default_role_relation` VALUES (153, 10007, 10905);
INSERT INTO `permission_default_role_relation` VALUES (154, 10007, 10906);
INSERT INTO `permission_default_role_relation` VALUES (155, 10007, 10907);
INSERT INTO `permission_default_role_relation` VALUES (156, 10007, 10908);
INSERT INTO `permission_default_role_relation` VALUES (157, 10008, 10005);
INSERT INTO `permission_default_role_relation` VALUES (158, 10008, 10006);
INSERT INTO `permission_default_role_relation` VALUES (159, 10008, 10007);
INSERT INTO `permission_default_role_relation` VALUES (160, 10008, 10008);
INSERT INTO `permission_default_role_relation` VALUES (161, 10008, 10013);
INSERT INTO `permission_default_role_relation` VALUES (162, 10008, 10014);
INSERT INTO `permission_default_role_relation` VALUES (163, 10008, 10015);
INSERT INTO `permission_default_role_relation` VALUES (164, 10008, 10016);
INSERT INTO `permission_default_role_relation` VALUES (165, 10008, 10017);
INSERT INTO `permission_default_role_relation` VALUES (166, 10008, 10028);
INSERT INTO `permission_default_role_relation` VALUES (167, 10008, 10902);
INSERT INTO `permission_default_role_relation` VALUES (168, 10008, 10903);
INSERT INTO `permission_default_role_relation` VALUES (169, 10008, 10904);
INSERT INTO `permission_default_role_relation` VALUES (170, 10008, 10905);
INSERT INTO `permission_default_role_relation` VALUES (171, 10008, 10906);
INSERT INTO `permission_default_role_relation` VALUES (172, 10008, 10907);
INSERT INTO `permission_default_role_relation` VALUES (173, 10008, 10908);
INSERT INTO `permission_default_role_relation` VALUES (122, 10009, 10005);
INSERT INTO `permission_default_role_relation` VALUES (123, 10009, 10006);
INSERT INTO `permission_default_role_relation` VALUES (124, 10009, 10007);
INSERT INTO `permission_default_role_relation` VALUES (125, 10009, 10008);
INSERT INTO `permission_default_role_relation` VALUES (126, 10009, 10013);
INSERT INTO `permission_default_role_relation` VALUES (104, 10010, 10004);
INSERT INTO `permission_default_role_relation` VALUES (105, 10010, 10005);
INSERT INTO `permission_default_role_relation` VALUES (106, 10010, 10006);
INSERT INTO `permission_default_role_relation` VALUES (107, 10010, 10007);
INSERT INTO `permission_default_role_relation` VALUES (108, 10010, 10008);
INSERT INTO `permission_default_role_relation` VALUES (109, 10010, 10013);
INSERT INTO `permission_default_role_relation` VALUES (110, 10010, 10014);
INSERT INTO `permission_default_role_relation` VALUES (111, 10010, 10015);
INSERT INTO `permission_default_role_relation` VALUES (112, 10010, 10016);
INSERT INTO `permission_default_role_relation` VALUES (113, 10010, 10017);
INSERT INTO `permission_default_role_relation` VALUES (114, 10010, 10028);
INSERT INTO `permission_default_role_relation` VALUES (115, 10010, 10902);
INSERT INTO `permission_default_role_relation` VALUES (116, 10010, 10903);
INSERT INTO `permission_default_role_relation` VALUES (117, 10010, 10904);
INSERT INTO `permission_default_role_relation` VALUES (118, 10010, 10905);
INSERT INTO `permission_default_role_relation` VALUES (119, 10010, 10906);
INSERT INTO `permission_default_role_relation` VALUES (120, 10010, 10907);
INSERT INTO `permission_default_role_relation` VALUES (121, 10010, 10908);
INSERT INTO `permission_default_role_relation` VALUES (259, 10011, 10005);
INSERT INTO `permission_default_role_relation` VALUES (260, 10011, 10006);
INSERT INTO `permission_default_role_relation` VALUES (261, 10011, 10007);
INSERT INTO `permission_default_role_relation` VALUES (262, 10011, 10008);
INSERT INTO `permission_default_role_relation` VALUES (263, 10011, 10013);
INSERT INTO `permission_default_role_relation` VALUES (264, 10011, 10014);
INSERT INTO `permission_default_role_relation` VALUES (265, 10011, 10015);
INSERT INTO `permission_default_role_relation` VALUES (266, 10011, 10016);
INSERT INTO `permission_default_role_relation` VALUES (267, 10011, 10017);
INSERT INTO `permission_default_role_relation` VALUES (251, 10012, 10005);
INSERT INTO `permission_default_role_relation` VALUES (252, 10012, 10006);
INSERT INTO `permission_default_role_relation` VALUES (253, 10012, 10007);
INSERT INTO `permission_default_role_relation` VALUES (254, 10012, 10008);
INSERT INTO `permission_default_role_relation` VALUES (255, 10012, 10013);
INSERT INTO `permission_default_role_relation` VALUES (256, 10012, 10014);
INSERT INTO `permission_default_role_relation` VALUES (257, 10012, 10016);
INSERT INTO `permission_default_role_relation` VALUES (258, 10012, 10028);
INSERT INTO `permission_default_role_relation` VALUES (192, 10013, 10004);
INSERT INTO `permission_default_role_relation` VALUES (193, 10013, 10005);
INSERT INTO `permission_default_role_relation` VALUES (194, 10013, 10006);
INSERT INTO `permission_default_role_relation` VALUES (195, 10013, 10007);
INSERT INTO `permission_default_role_relation` VALUES (196, 10013, 10008);
INSERT INTO `permission_default_role_relation` VALUES (197, 10013, 10013);
INSERT INTO `permission_default_role_relation` VALUES (198, 10013, 10014);
INSERT INTO `permission_default_role_relation` VALUES (199, 10013, 10015);
INSERT INTO `permission_default_role_relation` VALUES (200, 10013, 10016);
INSERT INTO `permission_default_role_relation` VALUES (201, 10013, 10017);
INSERT INTO `permission_default_role_relation` VALUES (202, 10013, 10028);
INSERT INTO `permission_default_role_relation` VALUES (203, 10013, 10902);
INSERT INTO `permission_default_role_relation` VALUES (204, 10013, 10903);
INSERT INTO `permission_default_role_relation` VALUES (205, 10013, 10904);
INSERT INTO `permission_default_role_relation` VALUES (206, 10013, 10905);
INSERT INTO `permission_default_role_relation` VALUES (207, 10013, 10906);
INSERT INTO `permission_default_role_relation` VALUES (208, 10013, 10907);
INSERT INTO `permission_default_role_relation` VALUES (209, 10013, 10908);
INSERT INTO `permission_default_role_relation` VALUES (174, 10015, 10004);
INSERT INTO `permission_default_role_relation` VALUES (175, 10015, 10005);
INSERT INTO `permission_default_role_relation` VALUES (176, 10015, 10006);
INSERT INTO `permission_default_role_relation` VALUES (177, 10015, 10007);
INSERT INTO `permission_default_role_relation` VALUES (178, 10015, 10008);
INSERT INTO `permission_default_role_relation` VALUES (179, 10015, 10013);
INSERT INTO `permission_default_role_relation` VALUES (180, 10015, 10014);
INSERT INTO `permission_default_role_relation` VALUES (181, 10015, 10015);
INSERT INTO `permission_default_role_relation` VALUES (182, 10015, 10016);
INSERT INTO `permission_default_role_relation` VALUES (183, 10015, 10017);
INSERT INTO `permission_default_role_relation` VALUES (184, 10015, 10028);
INSERT INTO `permission_default_role_relation` VALUES (185, 10015, 10902);
INSERT INTO `permission_default_role_relation` VALUES (186, 10015, 10903);
INSERT INTO `permission_default_role_relation` VALUES (187, 10015, 10904);
INSERT INTO `permission_default_role_relation` VALUES (188, 10015, 10905);
INSERT INTO `permission_default_role_relation` VALUES (189, 10015, 10906);
INSERT INTO `permission_default_role_relation` VALUES (190, 10015, 10907);
INSERT INTO `permission_default_role_relation` VALUES (191, 10015, 10908);
INSERT INTO `permission_default_role_relation` VALUES (244, 10016, 10005);
INSERT INTO `permission_default_role_relation` VALUES (245, 10016, 10006);
INSERT INTO `permission_default_role_relation` VALUES (246, 10016, 10007);
INSERT INTO `permission_default_role_relation` VALUES (247, 10016, 10008);
INSERT INTO `permission_default_role_relation` VALUES (248, 10016, 10013);
INSERT INTO `permission_default_role_relation` VALUES (249, 10016, 10015);
INSERT INTO `permission_default_role_relation` VALUES (250, 10016, 10016);
INSERT INTO `permission_default_role_relation` VALUES (295, 10017, 10004);
INSERT INTO `permission_default_role_relation` VALUES (296, 10017, 10005);
INSERT INTO `permission_default_role_relation` VALUES (297, 10017, 10006);
INSERT INTO `permission_default_role_relation` VALUES (298, 10017, 10007);
INSERT INTO `permission_default_role_relation` VALUES (299, 10017, 10008);
INSERT INTO `permission_default_role_relation` VALUES (300, 10017, 10013);
INSERT INTO `permission_default_role_relation` VALUES (301, 10017, 10014);
INSERT INTO `permission_default_role_relation` VALUES (302, 10017, 10015);
INSERT INTO `permission_default_role_relation` VALUES (303, 10017, 10016);
INSERT INTO `permission_default_role_relation` VALUES (304, 10017, 10017);
INSERT INTO `permission_default_role_relation` VALUES (305, 10017, 10028);
INSERT INTO `permission_default_role_relation` VALUES (306, 10017, 10902);
INSERT INTO `permission_default_role_relation` VALUES (307, 10017, 10903);
INSERT INTO `permission_default_role_relation` VALUES (308, 10017, 10904);
INSERT INTO `permission_default_role_relation` VALUES (309, 10017, 10905);
INSERT INTO `permission_default_role_relation` VALUES (310, 10017, 10906);
INSERT INTO `permission_default_role_relation` VALUES (311, 10017, 10907);
INSERT INTO `permission_default_role_relation` VALUES (312, 10017, 10908);
INSERT INTO `permission_default_role_relation` VALUES (277, 10018, 10004);
INSERT INTO `permission_default_role_relation` VALUES (278, 10018, 10005);
INSERT INTO `permission_default_role_relation` VALUES (279, 10018, 10006);
INSERT INTO `permission_default_role_relation` VALUES (280, 10018, 10007);
INSERT INTO `permission_default_role_relation` VALUES (281, 10018, 10008);
INSERT INTO `permission_default_role_relation` VALUES (282, 10018, 10013);
INSERT INTO `permission_default_role_relation` VALUES (283, 10018, 10014);
INSERT INTO `permission_default_role_relation` VALUES (284, 10018, 10015);
INSERT INTO `permission_default_role_relation` VALUES (285, 10018, 10016);
INSERT INTO `permission_default_role_relation` VALUES (286, 10018, 10017);
INSERT INTO `permission_default_role_relation` VALUES (287, 10018, 10028);
INSERT INTO `permission_default_role_relation` VALUES (288, 10018, 10902);
INSERT INTO `permission_default_role_relation` VALUES (289, 10018, 10903);
INSERT INTO `permission_default_role_relation` VALUES (290, 10018, 10904);
INSERT INTO `permission_default_role_relation` VALUES (291, 10018, 10905);
INSERT INTO `permission_default_role_relation` VALUES (292, 10018, 10906);
INSERT INTO `permission_default_role_relation` VALUES (293, 10018, 10907);
INSERT INTO `permission_default_role_relation` VALUES (294, 10018, 10908);
INSERT INTO `permission_default_role_relation` VALUES (268, 10019, 10005);
INSERT INTO `permission_default_role_relation` VALUES (269, 10019, 10006);
INSERT INTO `permission_default_role_relation` VALUES (270, 10019, 10007);
INSERT INTO `permission_default_role_relation` VALUES (271, 10019, 10008);
INSERT INTO `permission_default_role_relation` VALUES (272, 10019, 10013);
INSERT INTO `permission_default_role_relation` VALUES (273, 10019, 10016);
INSERT INTO `permission_default_role_relation` VALUES (274, 10019, 10902);
INSERT INTO `permission_default_role_relation` VALUES (275, 10019, 10905);
INSERT INTO `permission_default_role_relation` VALUES (276, 10019, 10907);

-- ----------------------------
-- Table structure for permission_global
-- ----------------------------
DROP TABLE IF EXISTS `permission_global`;
CREATE TABLE `permission_global`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `permission_global_key_idx`(`_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_global
-- ----------------------------
INSERT INTO `permission_global` VALUES (1, 0, '系统设置', '可以对整个系统进行基本，界面，安全，邮件设置，同时还可以查看操作日志', 'MANAGER_SYSTEM_SETTING');
INSERT INTO `permission_global` VALUES (2, 0, '管理用户', '', 'MANAGER_USER');
INSERT INTO `permission_global` VALUES (3, 0, '事项管理', '', 'MANAGER_ISSUE');
INSERT INTO `permission_global` VALUES (4, 0, '项目管理', '可以对全部项目进行管理，包括创建新项目。', 'MANAGER_PROJECT');
INSERT INTO `permission_global` VALUES (5, 0, '组织管理', '', 'MANAGER_ORG');

-- ----------------------------
-- Table structure for permission_global_group
-- ----------------------------
DROP TABLE IF EXISTS `permission_global_group`;
CREATE TABLE `permission_global_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `perm_global_id` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `perm_global_id`(`perm_global_id`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_global_group
-- ----------------------------
INSERT INTO `permission_global_group` VALUES (1, 10000, 1);

-- ----------------------------
-- Table structure for permission_global_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_global_role`;
CREATE TABLE `permission_global_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '是否是默认角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_global_role
-- ----------------------------
INSERT INTO `permission_global_role` VALUES (1, '超级管理员', NULL, 1);
INSERT INTO `permission_global_role` VALUES (2, '系统设置管理员', '', 0);
INSERT INTO `permission_global_role` VALUES (3, '项目管理员', NULL, 0);
INSERT INTO `permission_global_role` VALUES (4, '用户管理员', NULL, 0);
INSERT INTO `permission_global_role` VALUES (5, '事项设置管理员', NULL, 0);
INSERT INTO `permission_global_role` VALUES (6, '组织管理员', '', 0);

-- ----------------------------
-- Table structure for permission_global_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `permission_global_role_relation`;
CREATE TABLE `permission_global_role_relation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `perm_global_id` int(10) UNSIGNED DEFAULT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '是否系统自带',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique`(`perm_global_id`, `role_id`) USING BTREE,
  INDEX `perm_global_id`(`perm_global_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组拥有的全局权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_global_role_relation
-- ----------------------------
INSERT INTO `permission_global_role_relation` VALUES (2, 1, 1, 1);
INSERT INTO `permission_global_role_relation` VALUES (8, 2, 1, 1);
INSERT INTO `permission_global_role_relation` VALUES (9, 3, 1, 1);
INSERT INTO `permission_global_role_relation` VALUES (10, 4, 1, 1);
INSERT INTO `permission_global_role_relation` VALUES (11, 5, 1, 1);
INSERT INTO `permission_global_role_relation` VALUES (13, 1, 2, 1);
INSERT INTO `permission_global_role_relation` VALUES (14, 2, 2, 1);

-- ----------------------------
-- Table structure for permission_global_user_role
-- ----------------------------
DROP TABLE IF EXISTS `permission_global_user_role`;
CREATE TABLE `permission_global_user_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT 0,
  `role_id` int(10) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique`(`user_id`, `role_id`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5672 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_global_user_role
-- ----------------------------
INSERT INTO `permission_global_user_role` VALUES (5613, 1, 1);
INSERT INTO `permission_global_user_role` VALUES (5671, 12167, 1);

-- ----------------------------
-- Table structure for plugin_document_project_relation
-- ----------------------------
DROP TABLE IF EXISTS `plugin_document_project_relation`;
CREATE TABLE `plugin_document_project_relation`  (
  `project_id` int(10) UNSIGNED NOT NULL,
  `doc_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_catalog_label
-- ----------------------------
DROP TABLE IF EXISTS `project_catalog_label`;
CREATE TABLE `project_catalog_label`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label_id_json` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `font_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'blueviolet' COMMENT '字体颜色',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `order_weight` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  INDEX `project_id_2`(`project_id`, `order_weight`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 870 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '项目的分类定义' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_catalog_label
-- ----------------------------
INSERT INTO `project_catalog_label` VALUES (1, 1, '产 品', '[\"1\"]', 'blueviolet', '', 99);
INSERT INTO `project_catalog_label` VALUES (2, 1, '运营推广', '[\"2\",\"3\"]', 'blueviolet', '', 98);
INSERT INTO `project_catalog_label` VALUES (3, 1, '开 发', '[\"4\",\"7\",\"8\"]', 'blueviolet', '', 90);
INSERT INTO `project_catalog_label` VALUES (4, 1, '测 试', '[5,6]', 'blueviolet', '', 0);
INSERT INTO `project_catalog_label` VALUES (5, 1, 'UI设计', '[\"9\"]', 'blueviolet', '', 96);
INSERT INTO `project_catalog_label` VALUES (7, 1, '运 维', '[\"1\",\"2\"]', 'blueviolet', '', 88);
INSERT INTO `project_catalog_label` VALUES (29, 36, '产 品', '[\"35\",\"36\"]', 'blueviolet', '', 105);
INSERT INTO `project_catalog_label` VALUES (30, 36, '运 营', '[\"37\",\"38\"]', 'blueviolet', '', 104);
INSERT INTO `project_catalog_label` VALUES (31, 36, '开发', '[\"39\",\"40\",\"41\"]', 'blueviolet', '', 103);
INSERT INTO `project_catalog_label` VALUES (32, 36, '测 试', '[\"42\",\"43\"]', 'blueviolet', '', 102);
INSERT INTO `project_catalog_label` VALUES (33, 36, 'UI设计', '[\"44\"]', 'blueviolet', '', 101);
INSERT INTO `project_catalog_label` VALUES (34, 36, '运 维', '[\"45\"]', 'blueviolet', '', 100);
INSERT INTO `project_catalog_label` VALUES (89, 1, '增长', '[\"146\"]', '#D9534F', '', 0);
INSERT INTO `project_catalog_label` VALUES (868, 91, '产品', '[\"612\",\"613\"]', '#0033CC', '', 102);
INSERT INTO `project_catalog_label` VALUES (869, 91, '开发和BUG', '[\"614\",\"615\"]', '#0033CC', '', 101);

-- ----------------------------
-- Table structure for project_category
-- ----------------------------
DROP TABLE IF EXISTS `project_category`;
CREATE TABLE `project_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_project_category_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_flag
-- ----------------------------
DROP TABLE IF EXISTS `project_flag`;
CREATE TABLE `project_flag`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL,
  `flag` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `update_time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id`(`project_id`, `flag`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_flag
-- ----------------------------
INSERT INTO `project_flag` VALUES (32, 1, 'backlog_weight', '{\"1\":100000}', 1604494117);
INSERT INTO `project_flag` VALUES (33, 1, 'sprint_2_weight', '{\"120\":200000,\"53\":100000}', 1604494121);
INSERT INTO `project_flag` VALUES (34, 1, 'sprint_1_weight', '{\"2\":1800000,\"5\":1700000,\"8\":1600000,\"94\":1500000,\"116\":1400000,\"4\":1300000,\"108\":1200000,\"107\":1100000,\"106\":1000000,\"97\":900000,\"96\":800000,\"95\":700000,\"87\":600000,\"64\":500000,\"54\":400000,\"139\":300000,\"90\":200000,\"3\":100000}', 1604494122);

-- ----------------------------
-- Table structure for project_gantt_setting
-- ----------------------------
DROP TABLE IF EXISTS `project_gantt_setting`;
CREATE TABLE `project_gantt_setting`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `source_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'project,active_sprint',
  `source_from` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_display_backlog` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否在甘特图中显示待办事项',
  `hide_issue_types` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '要隐藏的事项类型key以逗号分隔',
  `work_dates` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_check_date` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 1 COMMENT '是否检查开始和结束日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_gantt_setting
-- ----------------------------
INSERT INTO `project_gantt_setting` VALUES (1, 1, 'project', NULL, 0, 'bug,gantt', '[1,2,3,4,5]', 0);
INSERT INTO `project_gantt_setting` VALUES (6, 36, 'project', NULL, 0, '', '[1,2,3,4,5]', 0);
INSERT INTO `project_gantt_setting` VALUES (16, 91, 'project', NULL, 1, '', '[1,2,3,4,5]', 0);
INSERT INTO `project_gantt_setting` VALUES (17, 92, 'project', NULL, 1, '', '[1,2,3,4,5]', 1);

-- ----------------------------
-- Table structure for project_issue_report
-- ----------------------------
DROP TABLE IF EXISTS `project_issue_report`;
CREATE TABLE `project_issue_report`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(3) UNSIGNED DEFAULT NULL,
  `month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `done_count` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数',
  `no_done_count` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `done_count_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `no_done_count_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(10) UNSIGNED DEFAULT 0 COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(10) UNSIGNED DEFAULT 0 COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE,
  INDEX `projectIdAndDate`(`project_id`, `date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_issue_type_scheme_data
-- ----------------------------
DROP TABLE IF EXISTS `project_issue_type_scheme_data`;
CREATE TABLE `project_issue_type_scheme_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `issue_type_scheme_id` int(10) UNSIGNED DEFAULT NULL,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id`(`project_id`) USING BTREE,
  INDEX `issue_type_scheme_id`(`issue_type_scheme_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_issue_type_scheme_data
-- ----------------------------
INSERT INTO `project_issue_type_scheme_data` VALUES (1, 1, 1);
INSERT INTO `project_issue_type_scheme_data` VALUES (2, 2, 2);
INSERT INTO `project_issue_type_scheme_data` VALUES (3, 2, 3);
INSERT INTO `project_issue_type_scheme_data` VALUES (4, 2, 4);
INSERT INTO `project_issue_type_scheme_data` VALUES (5, 2, 5);
INSERT INTO `project_issue_type_scheme_data` VALUES (6, 2, 6);
INSERT INTO `project_issue_type_scheme_data` VALUES (7, 2, 7);
INSERT INTO `project_issue_type_scheme_data` VALUES (8, 2, 8);
INSERT INTO `project_issue_type_scheme_data` VALUES (9, 2, 9);
INSERT INTO `project_issue_type_scheme_data` VALUES (10, 2, 10);
INSERT INTO `project_issue_type_scheme_data` VALUES (11, 2, 11);
INSERT INTO `project_issue_type_scheme_data` VALUES (12, 2, 36);
INSERT INTO `project_issue_type_scheme_data` VALUES (13, 2, 37);
INSERT INTO `project_issue_type_scheme_data` VALUES (14, 2, 38);
INSERT INTO `project_issue_type_scheme_data` VALUES (15, 2, 39);
INSERT INTO `project_issue_type_scheme_data` VALUES (16, 2, 40);
INSERT INTO `project_issue_type_scheme_data` VALUES (17, 2, 41);
INSERT INTO `project_issue_type_scheme_data` VALUES (18, 2, 42);
INSERT INTO `project_issue_type_scheme_data` VALUES (26, 2, 43);
INSERT INTO `project_issue_type_scheme_data` VALUES (27, 2, 45);
INSERT INTO `project_issue_type_scheme_data` VALUES (28, 2, 47);
INSERT INTO `project_issue_type_scheme_data` VALUES (29, 2, 48);
INSERT INTO `project_issue_type_scheme_data` VALUES (30, 2, 49);
INSERT INTO `project_issue_type_scheme_data` VALUES (31, 2, 50);
INSERT INTO `project_issue_type_scheme_data` VALUES (32, 2, 51);
INSERT INTO `project_issue_type_scheme_data` VALUES (33, 2, 52);
INSERT INTO `project_issue_type_scheme_data` VALUES (34, 2, 53);
INSERT INTO `project_issue_type_scheme_data` VALUES (35, 2, 54);
INSERT INTO `project_issue_type_scheme_data` VALUES (36, 2, 55);
INSERT INTO `project_issue_type_scheme_data` VALUES (37, 2, 56);
INSERT INTO `project_issue_type_scheme_data` VALUES (38, 2, 57);
INSERT INTO `project_issue_type_scheme_data` VALUES (39, 2, 58);
INSERT INTO `project_issue_type_scheme_data` VALUES (40, 2, 59);
INSERT INTO `project_issue_type_scheme_data` VALUES (41, 2, 60);
INSERT INTO `project_issue_type_scheme_data` VALUES (42, 2, 61);
INSERT INTO `project_issue_type_scheme_data` VALUES (43, 2, 62);
INSERT INTO `project_issue_type_scheme_data` VALUES (44, 2, 63);
INSERT INTO `project_issue_type_scheme_data` VALUES (45, 2, 64);
INSERT INTO `project_issue_type_scheme_data` VALUES (46, 2, 65);
INSERT INTO `project_issue_type_scheme_data` VALUES (47, 2, 66);
INSERT INTO `project_issue_type_scheme_data` VALUES (48, 2, 67);
INSERT INTO `project_issue_type_scheme_data` VALUES (49, 2, 68);
INSERT INTO `project_issue_type_scheme_data` VALUES (50, 2, 69);
INSERT INTO `project_issue_type_scheme_data` VALUES (51, 2, 70);
INSERT INTO `project_issue_type_scheme_data` VALUES (52, 2, 71);
INSERT INTO `project_issue_type_scheme_data` VALUES (53, 2, 72);
INSERT INTO `project_issue_type_scheme_data` VALUES (54, 2, 73);
INSERT INTO `project_issue_type_scheme_data` VALUES (55, 2, 74);
INSERT INTO `project_issue_type_scheme_data` VALUES (56, 2, 75);
INSERT INTO `project_issue_type_scheme_data` VALUES (57, 2, 76);
INSERT INTO `project_issue_type_scheme_data` VALUES (58, 2, 77);
INSERT INTO `project_issue_type_scheme_data` VALUES (59, 2, 78);
INSERT INTO `project_issue_type_scheme_data` VALUES (61, NULL, 80);
INSERT INTO `project_issue_type_scheme_data` VALUES (62, NULL, 81);
INSERT INTO `project_issue_type_scheme_data` VALUES (63, 0, 82);
INSERT INTO `project_issue_type_scheme_data` VALUES (64, 0, 83);
INSERT INTO `project_issue_type_scheme_data` VALUES (65, 0, 87);
INSERT INTO `project_issue_type_scheme_data` VALUES (66, 0, 88);
INSERT INTO `project_issue_type_scheme_data` VALUES (67, 0, 89);
INSERT INTO `project_issue_type_scheme_data` VALUES (68, 0, 90);
INSERT INTO `project_issue_type_scheme_data` VALUES (69, 0, 91);
INSERT INTO `project_issue_type_scheme_data` VALUES (70, 1, 92);

-- ----------------------------
-- Table structure for project_key
-- ----------------------------
DROP TABLE IF EXISTS `project_key`;
CREATE TABLE `project_key`  (
  `id` decimal(18, 0) NOT NULL,
  `project_id` decimal(18, 0) DEFAULT NULL,
  `project_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_all_project_keys`(`project_key`) USING BTREE,
  INDEX `idx_all_project_ids`(`project_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_label
-- ----------------------------
DROP TABLE IF EXISTS `project_label`;
CREATE TABLE `project_label`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bg_color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 616 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_label
-- ----------------------------
INSERT INTO `project_label` VALUES (1, 1, '产 品', '#FFFFFF', '#428BCA', '');
INSERT INTO `project_label` VALUES (2, 1, '运 营', '#FFFFFF', '#44AD8E', '');
INSERT INTO `project_label` VALUES (3, 1, '推 广', '#FFFFFF', '#A8D695', '');
INSERT INTO `project_label` VALUES (4, 1, '编码规范', '#FFFFFF', '#69D100', '');
INSERT INTO `project_label` VALUES (5, 1, '测试用例', '#FFFFFF', '#69D100', '');
INSERT INTO `project_label` VALUES (6, 1, '测试规范', '#FFFFFF', '#69D100', '');
INSERT INTO `project_label` VALUES (7, 1, '架构设计', '#FFFFFF', '#A295D6', '');
INSERT INTO `project_label` VALUES (8, 1, '数据协议', '#FFFFFF', '#AD4363', '');
INSERT INTO `project_label` VALUES (9, 1, 'UI设计', '#FFFFFF', '#D10069', '');
INSERT INTO `project_label` VALUES (10, 1, '交互文档', '#FFFFFF', '#CC0033', '');
INSERT INTO `project_label` VALUES (12, 1, '运 维', '#FFFFFF', '#D1D100', '');
INSERT INTO `project_label` VALUES (35, 36, '产 品', '#FFFFFF', '#428BCA', '');
INSERT INTO `project_label` VALUES (36, 36, '交互文档', '#FFFFFF', '#CC0033', '');
INSERT INTO `project_label` VALUES (37, 36, '运 营', '#FFFFFF', '#44AD8E', '');
INSERT INTO `project_label` VALUES (38, 36, '推 广', '#FFFFFF', '#A8D695', '');
INSERT INTO `project_label` VALUES (39, 36, '编码规范', '#FFFFFF', '#69D100', '');
INSERT INTO `project_label` VALUES (40, 36, '架构设计', '#FFFFFF', '#A295D6', '');
INSERT INTO `project_label` VALUES (41, 36, '数据协议', '#FFFFFF', '#AD4363', '');
INSERT INTO `project_label` VALUES (42, 36, '测试用例', '#FFFFFF', '#69D100', '');
INSERT INTO `project_label` VALUES (43, 36, '测试规范', '#FFFFFF', '#69D100', '');
INSERT INTO `project_label` VALUES (44, 36, 'UI设计', '#FFFFFF', '#D10069', '');
INSERT INTO `project_label` VALUES (45, 36, '运 维', '#FFFFFF', '#D1D100', '');
INSERT INTO `project_label` VALUES (612, 91, '产品', '#FFFFFF', '#5843AD', '');
INSERT INTO `project_label` VALUES (613, 91, '文档', '#FFFFFF', '#004E00', '');
INSERT INTO `project_label` VALUES (614, 91, '开发', '#FFFFFF', '', '');
INSERT INTO `project_label` VALUES (615, 91, 'BUG', '#FFFFFF', '#FF0000', '');

-- ----------------------------
-- Table structure for project_list_count
-- ----------------------------
DROP TABLE IF EXISTS `project_list_count`;
CREATE TABLE `project_list_count`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_type_id` smallint(5) UNSIGNED DEFAULT NULL,
  `project_total` int(10) UNSIGNED DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_main
-- ----------------------------
DROP TABLE IF EXISTS `project_main`;
CREATE TABLE `project_main`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org_id` int(11) NOT NULL DEFAULT 1,
  `org_path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lead` int(10) UNSIGNED DEFAULT 0,
  `description` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pcounter` decimal(18, 0) DEFAULT NULL,
  `default_assignee` int(10) UNSIGNED DEFAULT 0,
  `assignee_type` int(11) DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` int(10) UNSIGNED DEFAULT NULL,
  `type` tinyint(4) DEFAULT 1,
  `type_child` tinyint(4) DEFAULT 0,
  `permission_scheme_id` int(10) UNSIGNED DEFAULT 0,
  `workflow_scheme_id` int(10) UNSIGNED NOT NULL,
  `create_uid` int(10) UNSIGNED DEFAULT 0,
  `create_time` int(10) UNSIGNED DEFAULT 0,
  `un_done_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '未完成事项数',
  `done_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '已经完成事项数',
  `closed_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `archived` enum('Y','N') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N' COMMENT '已归档',
  `issue_update_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '事项最新更新时间',
  `is_display_issue_catalog` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否在事项列表显示分类',
  `subsystem_json` varchar(5012) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]' COMMENT '当前项目启用的子系统',
  `project_view` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'issue' COMMENT '进入项目默认打开的那个页面',
  `issue_view` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'detail' COMMENT '点击事项的交互',
  `issue_ui_scheme_id` int(11) NOT NULL DEFAULT 0 COMMENT '所属的界面方案id',
  `project_tpl_id` int(11) NOT NULL DEFAULT 1 COMMENT '所属的项目模板id',
  `default_issue_type_id` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '创建事项时默认的类型',
  `is_remember_last_issue` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否记住上次创建事项的数据',
  `remember_last_issue_field` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '[]' COMMENT '上次创建事项的数据字段',
  `remember_last_issue_data` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '{}' COMMENT '上次创建事项时的一些数据',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_project_key`(`key`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `uid`(`create_uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_main
-- ----------------------------
INSERT INTO `project_main` VALUES (1, 1, 'default', '示例项目', '', 1, 'Masterlab的示例项目', 'example', NULL, 1, NULL, 'project/avatar/1.png', 0, 0, 0, 0, 1, 1, 1579247230, 15, 6, 4, 'N', 1583220515, 1, '[]', 'issue', 'detail', 0, 1, 3, 1, '[\"issue_type\",\"module\",\"assignee\",\"fix_version\",\"labels\"]', '{}');
INSERT INTO `project_main` VALUES (36, 1, 'default', '空项目', 'http://master.888zb.com/about.php', 12164, 'good luck!', 'ex', NULL, 1, NULL, 'project/avatar/2.png', 0, 10, 0, 0, 1, 1, 1585132124, 2, 0, 0, 'N', 1585132124, 1, '[]', 'issue', 'detail', 0, 1, 1, 0, '[]', '{}');
INSERT INTO `project_main` VALUES (91, 1, 'default', 'TestProject', '', 1, '', 'testproject', NULL, 1, NULL, '', 0, 1, 0, 0, 0, 1, 1604924929, 0, 0, 0, 'N', 1604924929, 1, '[\"issues\",\"gantt\",\"kanban\",\"sprint\",\"mind\",\"backlog\",\"stat\",\"chart\",\"activity\",\"webhook\"]', 'summary', '', 0, 1, 1, 0, '[]', '{}');
INSERT INTO `project_main` VALUES (92, 146, 'bilan', '西部航空', '', 1, 'dsfssd', 'bestAir', NULL, 1, NULL, '', 0, 1, 0, 0, 1, 1, 1627434023, 0, 0, 0, 'N', 1627434023, 1, '[\"issues\",\"kanban\",\"mind\",\"gantt\",\"activity\",\"chart\",\"stat\"]', 'issues', 'detail', 1, 2, 1, 0, '[]', '{}');

-- ----------------------------
-- Table structure for project_main_extra
-- ----------------------------
DROP TABLE IF EXISTS `project_main_extra`;
CREATE TABLE `project_main_extra`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED DEFAULT 0,
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project_main_extra
-- ----------------------------
INSERT INTO `project_main_extra` VALUES (1, 1, '该项目展示了，如何将敏捷开发和Masterlab结合在一起.\r\n');
INSERT INTO `project_main_extra` VALUES (12, 36, ':tw-1f41f: :tw-1f40b: :tw-1f40b: :tw-1f40e: :tw-1f40e: :tw-1f40e: :tw-1f42c: :tw-1f42c:');
INSERT INTO `project_main_extra` VALUES (63, 91, '');
INSERT INTO `project_main_extra` VALUES (64, 92, '### dfsds');

-- ----------------------------
-- Table structure for project_mind_setting
-- ----------------------------
DROP TABLE IF EXISTS `project_mind_setting`;
CREATE TABLE `project_mind_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `setting_key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `setting_value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_id`(`project_id`, `setting_key`) USING BTREE,
  INDEX `project_id_2`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 218 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_mind_setting
-- ----------------------------
INSERT INTO `project_mind_setting` VALUES (14, 3, 'default_source_id', '');
INSERT INTO `project_mind_setting` VALUES (15, 3, 'fold_count', '16');
INSERT INTO `project_mind_setting` VALUES (16, 3, 'default_source', 'sprint');
INSERT INTO `project_mind_setting` VALUES (17, 3, 'is_display_label', '1');
INSERT INTO `project_mind_setting` VALUES (23, 1, 'is_display_label', '1');
INSERT INTO `project_mind_setting` VALUES (210, 1, 'fold_count', '15');
INSERT INTO `project_mind_setting` VALUES (211, 1, 'default_source', 'all');
INSERT INTO `project_mind_setting` VALUES (212, 1, 'is_display_assignee', '1');
INSERT INTO `project_mind_setting` VALUES (213, 1, 'is_display_priority', '0');
INSERT INTO `project_mind_setting` VALUES (214, 1, 'is_display_status', '1');
INSERT INTO `project_mind_setting` VALUES (215, 1, 'is_display_type', '0');
INSERT INTO `project_mind_setting` VALUES (216, 1, 'is_display_progress', '1');
INSERT INTO `project_mind_setting` VALUES (217, 1, 'default_source_id', '');

-- ----------------------------
-- Table structure for project_module
-- ----------------------------
DROP TABLE IF EXISTS `project_module`;
CREATE TABLE `project_module`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lead` int(10) UNSIGNED DEFAULT NULL,
  `default_assignee` int(10) UNSIGNED DEFAULT NULL,
  `ctime` int(10) UNSIGNED DEFAULT 0,
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_module
-- ----------------------------
INSERT INTO `project_module` VALUES (1, 1, '后端架构', '', 0, 0, 1579249107, 0);
INSERT INTO `project_module` VALUES (2, 1, '前端架构', '', 0, 0, 1579249118, 0);
INSERT INTO `project_module` VALUES (3, 1, '用户', '', 0, 0, 1579249127, 0);
INSERT INTO `project_module` VALUES (4, 1, '首页', '', 0, 0, 1579249131, 0);
INSERT INTO `project_module` VALUES (5, 1, '引擎', '', 0, 0, 1579249144, 0);
INSERT INTO `project_module` VALUES (6, 1, '测试', '', 0, 0, 1579423336, 0);
INSERT INTO `project_module` VALUES (13, 1, 'XXX', 'XX', 0, 0, 1597251981, 0);

-- ----------------------------
-- Table structure for project_permission
-- ----------------------------
DROP TABLE IF EXISTS `project_permission`;
CREATE TABLE `project_permission`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_permission_key_idx`(`_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10909 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_permission
-- ----------------------------
INSERT INTO `project_permission` VALUES (10004, 0, '管理项目', '可以对项目进行设置', 'ADMINISTER_PROJECTS');
INSERT INTO `project_permission` VALUES (10005, 0, '访问事项列表(已废弃)', '', 'BROWSE_ISSUES');
INSERT INTO `project_permission` VALUES (10006, 0, '创建事项', '', 'CREATE_ISSUES');
INSERT INTO `project_permission` VALUES (10007, 0, '评论', '', 'ADD_COMMENTS');
INSERT INTO `project_permission` VALUES (10008, 0, '上传和删除附件', '', 'CREATE_ATTACHMENTS');
INSERT INTO `project_permission` VALUES (10013, 0, '编辑事项', '项目的事项都可以编辑', 'EDIT_ISSUES');
INSERT INTO `project_permission` VALUES (10014, 0, '删除事项', '项目的所有事项可以删除', 'DELETE_ISSUES');
INSERT INTO `project_permission` VALUES (10015, 0, '关闭事项', '项目的所有事项可以关闭', 'CLOSE_ISSUES');
INSERT INTO `project_permission` VALUES (10016, 0, '修改事项状态', '修改事项状态', 'EDIT_ISSUES_STATUS');
INSERT INTO `project_permission` VALUES (10017, 0, '修改事项解决结果', '修改事项解决结果', 'EDIT_ISSUES_RESOLVE');
INSERT INTO `project_permission` VALUES (10028, 0, '删除评论', '项目的所有的评论均可以删除', 'DELETE_COMMENTS');
INSERT INTO `project_permission` VALUES (10902, 0, '管理backlog', '', 'MANAGE_BACKLOG');
INSERT INTO `project_permission` VALUES (10903, 0, '管理sprint', '', 'MANAGE_SPRINT');
INSERT INTO `project_permission` VALUES (10904, 0, '管理kanban', NULL, 'MANAGE_KANBAN');
INSERT INTO `project_permission` VALUES (10905, 0, '导入事项', '可以到导入excel数据到项目中', 'IMPORT_EXCEL');
INSERT INTO `project_permission` VALUES (10906, 0, '导出事项', '可以将项目中的数据导出为excel格式', 'EXPORT_EXCEL');
INSERT INTO `project_permission` VALUES (10907, 0, '管理甘特图', '是否拥有权限操作甘特图中的事项和设置', 'ADMIN_GANTT');
INSERT INTO `project_permission` VALUES (10908, 0, '事项分解设置', '是否拥有权限修改事项分解的设置', 'MIND_SETTING');

-- ----------------------------
-- Table structure for project_role
-- ----------------------------
DROP TABLE IF EXISTS `project_role`;
CREATE TABLE `project_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '是否是默认角色',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `p[roject_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 515 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_role
-- ----------------------------
INSERT INTO `project_role` VALUES (1, 1, 'Users', '普通用户', 1);
INSERT INTO `project_role` VALUES (2, 1, 'Developers', '开发者,如程序员，架构师', 1);
INSERT INTO `project_role` VALUES (3, 1, 'Administrators', '项目管理员，如项目经理，技术经理', 1);
INSERT INTO `project_role` VALUES (4, 1, 'QA', '测试工程师', 1);
INSERT INTO `project_role` VALUES (5, 1, 'PO', '产品经理，产品负责人', 1);
INSERT INTO `project_role` VALUES (177, 36, 'Users', '普通用户', 1);
INSERT INTO `project_role` VALUES (178, 36, 'Developers', '开发者,如程序员，架构师', 1);
INSERT INTO `project_role` VALUES (179, 36, 'Administrators', '项目管理员，如项目经理，技术经理', 1);
INSERT INTO `project_role` VALUES (180, 36, 'QA', '测试工程师', 1);
INSERT INTO `project_role` VALUES (181, 36, 'PO', '产品经理，产品负责人', 1);
INSERT INTO `project_role` VALUES (506, 91, 'xxx', 'xxxxx', 1);
INSERT INTO `project_role` VALUES (507, 91, 'QQQQ', 'xxxxxx', 1);
INSERT INTO `project_role` VALUES (508, 91, 'QQQQ', 'xxxxxx', 1);
INSERT INTO `project_role` VALUES (509, 91, 'xxx', 'xxxxx', 1);
INSERT INTO `project_role` VALUES (510, 92, '运维', '', 1);
INSERT INTO `project_role` VALUES (511, 92, '产品经理', '', 1);
INSERT INTO `project_role` VALUES (512, 92, '项目经理', '', 1);
INSERT INTO `project_role` VALUES (513, 92, '开发者', '', 1);
INSERT INTO `project_role` VALUES (514, 92, '测试', '', 1);

-- ----------------------------
-- Table structure for project_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `project_role_relation`;
CREATE TABLE `project_role_relation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `perm_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `role_id-and-perm_id`(`role_id`, `perm_id`) USING BTREE,
  INDEX `unique_data`(`project_id`, `role_id`, `perm_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2255 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_role_relation
-- ----------------------------
INSERT INTO `project_role_relation` VALUES (1, 1, 1, 10005);
INSERT INTO `project_role_relation` VALUES (2, 1, 1, 10006);
INSERT INTO `project_role_relation` VALUES (3, 1, 1, 10007);
INSERT INTO `project_role_relation` VALUES (4, 1, 1, 10008);
INSERT INTO `project_role_relation` VALUES (5, 1, 1, 10013);
INSERT INTO `project_role_relation` VALUES (38, 1, 2, 10005);
INSERT INTO `project_role_relation` VALUES (39, 1, 2, 10006);
INSERT INTO `project_role_relation` VALUES (40, 1, 2, 10007);
INSERT INTO `project_role_relation` VALUES (41, 1, 2, 10008);
INSERT INTO `project_role_relation` VALUES (42, 1, 2, 10013);
INSERT INTO `project_role_relation` VALUES (43, 1, 2, 10014);
INSERT INTO `project_role_relation` VALUES (44, 1, 2, 10015);
INSERT INTO `project_role_relation` VALUES (45, 1, 2, 10016);
INSERT INTO `project_role_relation` VALUES (46, 1, 2, 10017);
INSERT INTO `project_role_relation` VALUES (47, 1, 2, 10028);
INSERT INTO `project_role_relation` VALUES (387, 1, 3, 10004);
INSERT INTO `project_role_relation` VALUES (388, 1, 3, 10005);
INSERT INTO `project_role_relation` VALUES (389, 1, 3, 10006);
INSERT INTO `project_role_relation` VALUES (390, 1, 3, 10007);
INSERT INTO `project_role_relation` VALUES (391, 1, 3, 10008);
INSERT INTO `project_role_relation` VALUES (392, 1, 3, 10013);
INSERT INTO `project_role_relation` VALUES (393, 1, 3, 10014);
INSERT INTO `project_role_relation` VALUES (394, 1, 3, 10015);
INSERT INTO `project_role_relation` VALUES (395, 1, 3, 10016);
INSERT INTO `project_role_relation` VALUES (396, 1, 3, 10017);
INSERT INTO `project_role_relation` VALUES (397, 1, 3, 10028);
INSERT INTO `project_role_relation` VALUES (398, 1, 3, 10902);
INSERT INTO `project_role_relation` VALUES (399, 1, 3, 10903);
INSERT INTO `project_role_relation` VALUES (400, 1, 3, 10904);
INSERT INTO `project_role_relation` VALUES (401, 1, 3, 10905);
INSERT INTO `project_role_relation` VALUES (402, 1, 3, 10906);
INSERT INTO `project_role_relation` VALUES (403, 1, 3, 10907);
INSERT INTO `project_role_relation` VALUES (404, 1, 3, 10908);
INSERT INTO `project_role_relation` VALUES (2130, 1, 4, 10005);
INSERT INTO `project_role_relation` VALUES (2131, 1, 4, 10006);
INSERT INTO `project_role_relation` VALUES (2132, 1, 4, 10007);
INSERT INTO `project_role_relation` VALUES (2133, 1, 4, 10008);
INSERT INTO `project_role_relation` VALUES (2134, 1, 4, 10013);
INSERT INTO `project_role_relation` VALUES (2135, 1, 4, 10014);
INSERT INTO `project_role_relation` VALUES (2136, 1, 4, 10015);
INSERT INTO `project_role_relation` VALUES (2137, 1, 4, 10017);
INSERT INTO `project_role_relation` VALUES (2138, 1, 4, 10028);
INSERT INTO `project_role_relation` VALUES (2139, 1, 4, 10905);
INSERT INTO `project_role_relation` VALUES (2140, 1, 4, 10906);
INSERT INTO `project_role_relation` VALUES (421, 1, 5, 10004);
INSERT INTO `project_role_relation` VALUES (422, 1, 5, 10005);
INSERT INTO `project_role_relation` VALUES (423, 1, 5, 10006);
INSERT INTO `project_role_relation` VALUES (424, 1, 5, 10007);
INSERT INTO `project_role_relation` VALUES (425, 1, 5, 10008);
INSERT INTO `project_role_relation` VALUES (426, 1, 5, 10013);
INSERT INTO `project_role_relation` VALUES (427, 1, 5, 10014);
INSERT INTO `project_role_relation` VALUES (428, 1, 5, 10015);
INSERT INTO `project_role_relation` VALUES (429, 1, 5, 10016);
INSERT INTO `project_role_relation` VALUES (430, 1, 5, 10017);
INSERT INTO `project_role_relation` VALUES (431, 1, 5, 10028);
INSERT INTO `project_role_relation` VALUES (432, 1, 5, 10902);
INSERT INTO `project_role_relation` VALUES (433, 1, 5, 10903);
INSERT INTO `project_role_relation` VALUES (434, 1, 5, 10904);
INSERT INTO `project_role_relation` VALUES (435, 1, 5, 10905);
INSERT INTO `project_role_relation` VALUES (436, 1, 5, 10906);
INSERT INTO `project_role_relation` VALUES (437, 1, 5, 10907);
INSERT INTO `project_role_relation` VALUES (438, 1, 5, 10908);
INSERT INTO `project_role_relation` VALUES (2075, 36, 177, 10005);
INSERT INTO `project_role_relation` VALUES (2076, 36, 177, 10006);
INSERT INTO `project_role_relation` VALUES (2077, 36, 177, 10007);
INSERT INTO `project_role_relation` VALUES (2078, 36, 177, 10008);
INSERT INTO `project_role_relation` VALUES (2079, 36, 177, 10013);
INSERT INTO `project_role_relation` VALUES (2080, 36, 178, 10005);
INSERT INTO `project_role_relation` VALUES (2081, 36, 178, 10006);
INSERT INTO `project_role_relation` VALUES (2082, 36, 178, 10007);
INSERT INTO `project_role_relation` VALUES (2083, 36, 178, 10008);
INSERT INTO `project_role_relation` VALUES (2084, 36, 178, 10013);
INSERT INTO `project_role_relation` VALUES (2085, 36, 178, 10014);
INSERT INTO `project_role_relation` VALUES (2086, 36, 178, 10015);
INSERT INTO `project_role_relation` VALUES (2088, 36, 178, 10016);
INSERT INTO `project_role_relation` VALUES (2087, 36, 178, 10028);
INSERT INTO `project_role_relation` VALUES (2141, 36, 179, 10004);
INSERT INTO `project_role_relation` VALUES (2142, 36, 179, 10005);
INSERT INTO `project_role_relation` VALUES (2143, 36, 179, 10006);
INSERT INTO `project_role_relation` VALUES (2144, 36, 179, 10007);
INSERT INTO `project_role_relation` VALUES (2145, 36, 179, 10008);
INSERT INTO `project_role_relation` VALUES (2146, 36, 179, 10013);
INSERT INTO `project_role_relation` VALUES (2147, 36, 179, 10014);
INSERT INTO `project_role_relation` VALUES (2148, 36, 179, 10015);
INSERT INTO `project_role_relation` VALUES (2149, 36, 179, 10016);
INSERT INTO `project_role_relation` VALUES (2150, 36, 179, 10017);
INSERT INTO `project_role_relation` VALUES (2151, 36, 179, 10028);
INSERT INTO `project_role_relation` VALUES (2152, 36, 179, 10902);
INSERT INTO `project_role_relation` VALUES (2153, 36, 179, 10903);
INSERT INTO `project_role_relation` VALUES (2154, 36, 179, 10904);
INSERT INTO `project_role_relation` VALUES (2155, 36, 179, 10905);
INSERT INTO `project_role_relation` VALUES (2156, 36, 179, 10906);
INSERT INTO `project_role_relation` VALUES (2157, 36, 179, 10907);
INSERT INTO `project_role_relation` VALUES (2158, 36, 179, 10908);
INSERT INTO `project_role_relation` VALUES (2105, 36, 180, 10005);
INSERT INTO `project_role_relation` VALUES (2106, 36, 180, 10006);
INSERT INTO `project_role_relation` VALUES (2107, 36, 180, 10007);
INSERT INTO `project_role_relation` VALUES (2108, 36, 180, 10008);
INSERT INTO `project_role_relation` VALUES (2109, 36, 180, 10013);
INSERT INTO `project_role_relation` VALUES (2110, 36, 180, 10014);
INSERT INTO `project_role_relation` VALUES (2111, 36, 180, 10015);
INSERT INTO `project_role_relation` VALUES (2113, 36, 180, 10017);
INSERT INTO `project_role_relation` VALUES (2112, 36, 180, 10028);
INSERT INTO `project_role_relation` VALUES (2177, 36, 181, 10004);
INSERT INTO `project_role_relation` VALUES (2178, 36, 181, 10005);
INSERT INTO `project_role_relation` VALUES (2179, 36, 181, 10006);
INSERT INTO `project_role_relation` VALUES (2180, 36, 181, 10007);
INSERT INTO `project_role_relation` VALUES (2181, 36, 181, 10008);
INSERT INTO `project_role_relation` VALUES (2182, 36, 181, 10013);
INSERT INTO `project_role_relation` VALUES (2183, 36, 181, 10014);
INSERT INTO `project_role_relation` VALUES (2184, 36, 181, 10015);
INSERT INTO `project_role_relation` VALUES (2185, 36, 181, 10016);
INSERT INTO `project_role_relation` VALUES (2186, 36, 181, 10017);
INSERT INTO `project_role_relation` VALUES (2187, 36, 181, 10028);
INSERT INTO `project_role_relation` VALUES (2188, 36, 181, 10902);
INSERT INTO `project_role_relation` VALUES (2189, 36, 181, 10903);
INSERT INTO `project_role_relation` VALUES (2190, 36, 181, 10904);
INSERT INTO `project_role_relation` VALUES (2191, 36, 181, 10905);
INSERT INTO `project_role_relation` VALUES (2192, 36, 181, 10906);
INSERT INTO `project_role_relation` VALUES (2193, 36, 181, 10907);
INSERT INTO `project_role_relation` VALUES (2194, 36, 181, 10908);
INSERT INTO `project_role_relation` VALUES (2195, 92, 510, 10005);
INSERT INTO `project_role_relation` VALUES (2196, 92, 510, 10006);
INSERT INTO `project_role_relation` VALUES (2197, 92, 510, 10007);
INSERT INTO `project_role_relation` VALUES (2198, 92, 510, 10008);
INSERT INTO `project_role_relation` VALUES (2199, 92, 510, 10013);
INSERT INTO `project_role_relation` VALUES (2200, 92, 510, 10015);
INSERT INTO `project_role_relation` VALUES (2201, 92, 510, 10016);
INSERT INTO `project_role_relation` VALUES (2202, 92, 511, 10004);
INSERT INTO `project_role_relation` VALUES (2203, 92, 511, 10005);
INSERT INTO `project_role_relation` VALUES (2204, 92, 511, 10006);
INSERT INTO `project_role_relation` VALUES (2205, 92, 511, 10007);
INSERT INTO `project_role_relation` VALUES (2206, 92, 511, 10008);
INSERT INTO `project_role_relation` VALUES (2207, 92, 511, 10013);
INSERT INTO `project_role_relation` VALUES (2208, 92, 511, 10014);
INSERT INTO `project_role_relation` VALUES (2209, 92, 511, 10015);
INSERT INTO `project_role_relation` VALUES (2210, 92, 511, 10016);
INSERT INTO `project_role_relation` VALUES (2211, 92, 511, 10017);
INSERT INTO `project_role_relation` VALUES (2212, 92, 511, 10028);
INSERT INTO `project_role_relation` VALUES (2213, 92, 511, 10902);
INSERT INTO `project_role_relation` VALUES (2214, 92, 511, 10903);
INSERT INTO `project_role_relation` VALUES (2215, 92, 511, 10904);
INSERT INTO `project_role_relation` VALUES (2216, 92, 511, 10905);
INSERT INTO `project_role_relation` VALUES (2217, 92, 511, 10906);
INSERT INTO `project_role_relation` VALUES (2218, 92, 511, 10907);
INSERT INTO `project_role_relation` VALUES (2219, 92, 511, 10908);
INSERT INTO `project_role_relation` VALUES (2220, 92, 512, 10004);
INSERT INTO `project_role_relation` VALUES (2221, 92, 512, 10005);
INSERT INTO `project_role_relation` VALUES (2222, 92, 512, 10006);
INSERT INTO `project_role_relation` VALUES (2223, 92, 512, 10007);
INSERT INTO `project_role_relation` VALUES (2224, 92, 512, 10008);
INSERT INTO `project_role_relation` VALUES (2225, 92, 512, 10013);
INSERT INTO `project_role_relation` VALUES (2226, 92, 512, 10014);
INSERT INTO `project_role_relation` VALUES (2227, 92, 512, 10015);
INSERT INTO `project_role_relation` VALUES (2228, 92, 512, 10016);
INSERT INTO `project_role_relation` VALUES (2229, 92, 512, 10017);
INSERT INTO `project_role_relation` VALUES (2230, 92, 512, 10028);
INSERT INTO `project_role_relation` VALUES (2231, 92, 512, 10902);
INSERT INTO `project_role_relation` VALUES (2232, 92, 512, 10903);
INSERT INTO `project_role_relation` VALUES (2233, 92, 512, 10904);
INSERT INTO `project_role_relation` VALUES (2234, 92, 512, 10905);
INSERT INTO `project_role_relation` VALUES (2235, 92, 512, 10906);
INSERT INTO `project_role_relation` VALUES (2236, 92, 512, 10907);
INSERT INTO `project_role_relation` VALUES (2237, 92, 512, 10908);
INSERT INTO `project_role_relation` VALUES (2238, 92, 513, 10005);
INSERT INTO `project_role_relation` VALUES (2239, 92, 513, 10006);
INSERT INTO `project_role_relation` VALUES (2240, 92, 513, 10007);
INSERT INTO `project_role_relation` VALUES (2241, 92, 513, 10008);
INSERT INTO `project_role_relation` VALUES (2242, 92, 513, 10013);
INSERT INTO `project_role_relation` VALUES (2243, 92, 513, 10014);
INSERT INTO `project_role_relation` VALUES (2244, 92, 513, 10016);
INSERT INTO `project_role_relation` VALUES (2245, 92, 513, 10028);
INSERT INTO `project_role_relation` VALUES (2246, 92, 514, 10005);
INSERT INTO `project_role_relation` VALUES (2247, 92, 514, 10006);
INSERT INTO `project_role_relation` VALUES (2248, 92, 514, 10007);
INSERT INTO `project_role_relation` VALUES (2249, 92, 514, 10008);
INSERT INTO `project_role_relation` VALUES (2250, 92, 514, 10013);
INSERT INTO `project_role_relation` VALUES (2251, 92, 514, 10014);
INSERT INTO `project_role_relation` VALUES (2252, 92, 514, 10015);
INSERT INTO `project_role_relation` VALUES (2253, 92, 514, 10016);
INSERT INTO `project_role_relation` VALUES (2254, 92, 514, 10017);

-- ----------------------------
-- Table structure for project_template
-- ----------------------------
DROP TABLE IF EXISTS `project_template`;
CREATE TABLE `project_template`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `image_bg` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` int(10) UNSIGNED DEFAULT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `issue_type_scheme_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '事项类型方案id',
  `issue_workflow_scheme_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '事项工作流方案id',
  `issue_ui_scheme_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `nav_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'left' COMMENT '导航风格：left,top可选',
  `ui_style` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'dark' COMMENT '整体风格设置',
  `theme_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'blue' COMMENT '主题色',
  `is_fix_header` tinyint(1) NOT NULL DEFAULT 0 COMMENT '固定 Header',
  `is_fix_left` tinyint(1) NOT NULL DEFAULT 0 COMMENT '固定侧边菜单',
  `subsystem_json` varchar(5120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '[]' COMMENT '子系统',
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否系统自带的模板',
  `page_layout` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `project_view` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `issue_view` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `default_issue_type_id` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '创建事项时默认的类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = ' 项目模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_template
-- ----------------------------
INSERT INTO `project_template` VALUES (1, '默认模板', 0, '系统初始化创建的项目模板，不可编辑和删除', '/dev/img/project_tpl/default.png', 100000, NULL, NULL, NULL, 1, 1, 1, 'left', 'dark', 'blue', 0, 0, '[\"issues\",\"gantt\",\"mind\",\"kanban\",\"activity\",\"chart\",\"stat\"]', 1, 'fluid', 'summary', '', 1);
INSERT INTO `project_template` VALUES (2, '软件开发', 1, '模板描述', '/dev/img/project_tpl/software.png', 0, NULL, NULL, NULL, 1, 1, 1, 'left', 'dark', 'blue', 0, 0, '[\"issues\",\"kanban\",\"mind\",\"gantt\",\"activity\",\"chart\",\"stat\"]', 0, 'fluid', 'issues', 'detail', 1);
INSERT INTO `project_template` VALUES (3, 'Scrum敏捷开发', 1, '模板描述', '/dev/img/project_tpl/scrum.png', 0, NULL, NULL, NULL, 1, 1, 1, 'left', 'dark', 'blue', 0, 0, '[\"issues\",\"backlog\",\"sprints\",\"kanban\",\"mind\",\"chart\",\"stat\",\"activity\"]', 0, '', 'issues', '', 1);

-- ----------------------------
-- Table structure for project_template_display_category
-- ----------------------------
DROP TABLE IF EXISTS `project_template_display_category`;
CREATE TABLE `project_template_display_category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_template_display_category
-- ----------------------------
INSERT INTO `project_template_display_category` VALUES (1, '产品研发', 999, NULL);
INSERT INTO `project_template_display_category` VALUES (2, '市场营销', 998, NULL);
INSERT INTO `project_template_display_category` VALUES (3, '教育培训', 997, NULL);
INSERT INTO `project_template_display_category` VALUES (4, '客户服务', 996, NULL);
INSERT INTO `project_template_display_category` VALUES (5, '生产制造', 995, NULL);
INSERT INTO `project_template_display_category` VALUES (6, '政务管理', 994, NULL);
INSERT INTO `project_template_display_category` VALUES (7, '个人计划', 993, NULL);
INSERT INTO `project_template_display_category` VALUES (8, '产品研发', 0, NULL);

-- ----------------------------
-- Table structure for project_tpl_category
-- ----------------------------
DROP TABLE IF EXISTS `project_tpl_category`;
CREATE TABLE `project_tpl_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_project_category_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_tpl_category_label
-- ----------------------------
DROP TABLE IF EXISTS `project_tpl_category_label`;
CREATE TABLE `project_tpl_category_label`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_tpl_id` int(11) NOT NULL,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label_id_json` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `font_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'blueviolet' COMMENT '字体颜色',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `order_weight` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_tpl_id`(`project_tpl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '项目的分类定义' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_tpl_category_label
-- ----------------------------
INSERT INTO `project_tpl_category_label` VALUES (1, 1, '产品', '[\"3\",\"4\"]', '#0033CC', '', 0);
INSERT INTO `project_tpl_category_label` VALUES (3, 1, '开发和BUG', '[\"1\",\"2\"]', '#0033CC', '', 0);

-- ----------------------------
-- Table structure for project_tpl_label
-- ----------------------------
DROP TABLE IF EXISTS `project_tpl_label`;
CREATE TABLE `project_tpl_label`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_tpl_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bg_color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_tpl_id`(`project_tpl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_tpl_label
-- ----------------------------
INSERT INTO `project_tpl_label` VALUES (1, 1, '开发', '#FFFFFF', '', '');
INSERT INTO `project_tpl_label` VALUES (2, 1, 'BUG', '#FFFFFF', '#FF0000', '');
INSERT INTO `project_tpl_label` VALUES (3, 1, '产品', '#FFFFFF', '#5843AD', '');
INSERT INTO `project_tpl_label` VALUES (4, 1, '文档', '#FFFFFF', '#004E00', '');
INSERT INTO `project_tpl_label` VALUES (5, 1, '运维', '#FFFFFF', '#8E44AD', '');
INSERT INTO `project_tpl_label` VALUES (6, 1, '运营', '#FFFFFF', '#F0AD4E', '');

-- ----------------------------
-- Table structure for project_tpl_module
-- ----------------------------
DROP TABLE IF EXISTS `project_tpl_module`;
CREATE TABLE `project_tpl_module`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_tpl_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_at` int(10) UNSIGNED DEFAULT 0,
  `order_weight` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_tpl_id`(`project_tpl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_tpl_widget
-- ----------------------------
DROP TABLE IF EXISTS `project_tpl_widget`;
CREATE TABLE `project_tpl_widget`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `project_tpl_id` int(10) UNSIGNED NOT NULL COMMENT '项目模板id',
  `widget_id` int(11) NOT NULL COMMENT 'main_widget主键id',
  `order_weight` int(10) UNSIGNED DEFAULT NULL COMMENT '工具顺序',
  `panel` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parameter` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_saved_parameter` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否保存了过滤参数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `project_tpl_id`(`project_tpl_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_user_role
-- ----------------------------
DROP TABLE IF EXISTS `project_user_role`;
CREATE TABLE `project_user_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT 0,
  `project_id` int(10) UNSIGNED DEFAULT 0,
  `role_id` int(10) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique`(`user_id`, `project_id`, `role_id`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE,
  INDEX `uid_project`(`user_id`, `project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 282 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_user_role
-- ----------------------------
INSERT INTO `project_user_role` VALUES (3, 1, 1, 2);
INSERT INTO `project_user_role` VALUES (4, 1, 1, 3);
INSERT INTO `project_user_role` VALUES (150, 1, 36, 177);
INSERT INTO `project_user_role` VALUES (153, 1, 36, 179);
INSERT INTO `project_user_role` VALUES (155, 1, 37, 182);
INSERT INTO `project_user_role` VALUES (156, 1, 37, 184);
INSERT INTO `project_user_role` VALUES (157, 1, 38, 189);
INSERT INTO `project_user_role` VALUES (158, 1, 39, 194);
INSERT INTO `project_user_role` VALUES (159, 1, 40, 199);
INSERT INTO `project_user_role` VALUES (160, 1, 41, 204);
INSERT INTO `project_user_role` VALUES (161, 1, 42, 209);
INSERT INTO `project_user_role` VALUES (168, 1, 43, 215);
INSERT INTO `project_user_role` VALUES (214, 1, 57, 282);
INSERT INTO `project_user_role` VALUES (216, 1, 58, 289);
INSERT INTO `project_user_role` VALUES (218, 1, 59, 296);
INSERT INTO `project_user_role` VALUES (220, 1, 60, 303);
INSERT INTO `project_user_role` VALUES (222, 1, 61, 310);
INSERT INTO `project_user_role` VALUES (224, 1, 62, 317);
INSERT INTO `project_user_role` VALUES (226, 1, 63, 324);
INSERT INTO `project_user_role` VALUES (228, 1, 64, 331);
INSERT INTO `project_user_role` VALUES (230, 1, 65, 338);
INSERT INTO `project_user_role` VALUES (232, 1, 66, 345);
INSERT INTO `project_user_role` VALUES (234, 1, 67, 352);
INSERT INTO `project_user_role` VALUES (236, 1, 68, 359);
INSERT INTO `project_user_role` VALUES (238, 1, 69, 366);
INSERT INTO `project_user_role` VALUES (240, 1, 70, 373);
INSERT INTO `project_user_role` VALUES (242, 1, 71, 380);
INSERT INTO `project_user_role` VALUES (244, 1, 72, 387);
INSERT INTO `project_user_role` VALUES (246, 1, 73, 394);
INSERT INTO `project_user_role` VALUES (248, 1, 74, 401);
INSERT INTO `project_user_role` VALUES (250, 1, 75, 408);
INSERT INTO `project_user_role` VALUES (276, 1, 91, 0);
INSERT INTO `project_user_role` VALUES (277, 1, 92, 510);
INSERT INTO `project_user_role` VALUES (278, 1, 92, 511);
INSERT INTO `project_user_role` VALUES (279, 1, 92, 512);
INSERT INTO `project_user_role` VALUES (280, 1, 92, 513);
INSERT INTO `project_user_role` VALUES (281, 1, 92, 514);
INSERT INTO `project_user_role` VALUES (5, 12164, 1, 2);
INSERT INTO `project_user_role` VALUES (210, 12164, 1, 4);
INSERT INTO `project_user_role` VALUES (154, 12164, 37, 184);
INSERT INTO `project_user_role` VALUES (165, 12165, 1, 2);
INSERT INTO `project_user_role` VALUES (8, 12166, 1, 5);
INSERT INTO `project_user_role` VALUES (7, 12167, 1, 2);
INSERT INTO `project_user_role` VALUES (175, 12168, 1, 2);
INSERT INTO `project_user_role` VALUES (187, 12170, 1, 3);
INSERT INTO `project_user_role` VALUES (188, 12170, 1, 4);
INSERT INTO `project_user_role` VALUES (212, 12170, 1, 5);
INSERT INTO `project_user_role` VALUES (213, 12170, 57, 284);
INSERT INTO `project_user_role` VALUES (215, 12170, 58, 291);
INSERT INTO `project_user_role` VALUES (164, 12227, 5, 10002);
INSERT INTO `project_user_role` VALUES (185, 12255, 36, 178);
INSERT INTO `project_user_role` VALUES (217, 12256, 59, 298);
INSERT INTO `project_user_role` VALUES (219, 12256, 60, 305);
INSERT INTO `project_user_role` VALUES (221, 12256, 61, 312);
INSERT INTO `project_user_role` VALUES (223, 12256, 62, 319);
INSERT INTO `project_user_role` VALUES (225, 12256, 63, 326);
INSERT INTO `project_user_role` VALUES (227, 12256, 64, 333);
INSERT INTO `project_user_role` VALUES (229, 12256, 65, 340);
INSERT INTO `project_user_role` VALUES (231, 12256, 66, 347);
INSERT INTO `project_user_role` VALUES (233, 12256, 67, 354);
INSERT INTO `project_user_role` VALUES (235, 12256, 68, 361);
INSERT INTO `project_user_role` VALUES (237, 12256, 69, 368);
INSERT INTO `project_user_role` VALUES (239, 12256, 70, 375);
INSERT INTO `project_user_role` VALUES (241, 12256, 71, 382);
INSERT INTO `project_user_role` VALUES (243, 12262, 72, 389);
INSERT INTO `project_user_role` VALUES (245, 12262, 73, 396);
INSERT INTO `project_user_role` VALUES (247, 12262, 74, 403);
INSERT INTO `project_user_role` VALUES (249, 12262, 75, 410);

-- ----------------------------
-- Table structure for project_version
-- ----------------------------
DROP TABLE IF EXISTS `project_version`;
CREATE TABLE `project_version`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `sequence` decimal(18, 0) DEFAULT NULL,
  `released` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '0未发布 1已发布',
  `archived` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `start_date` int(10) UNSIGNED DEFAULT NULL,
  `release_date` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `project_name_unique`(`project_id`, `name`) USING BTREE,
  INDEX `idx_version_project`(`project_id`) USING BTREE,
  INDEX `idx_version_sequence`(`sequence`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_version
-- ----------------------------
INSERT INTO `project_version` VALUES (1, 1, 'v1.0', '', 0, 1, NULL, '', 1595520000, 1596124800);
INSERT INTO `project_version` VALUES (2, 1, 'v2.0', '', 0, 1, NULL, '', 0, 0);

-- ----------------------------
-- Table structure for project_workflow_status
-- ----------------------------
DROP TABLE IF EXISTS `project_workflow_status`;
CREATE TABLE `project_workflow_status`  (
  `id` decimal(18, 0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `parentname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_name`(`parentname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_workflows
-- ----------------------------
DROP TABLE IF EXISTS `project_workflows`;
CREATE TABLE `project_workflows`  (
  `id` decimal(18, 0) NOT NULL,
  `workflowname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `creatorname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `descriptor` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `islocked` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for report_project_issue
-- ----------------------------
DROP TABLE IF EXISTS `report_project_issue`;
CREATE TABLE `report_project_issue`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(3) UNSIGNED DEFAULT NULL,
  `month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `count_done` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数',
  `count_no_done` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `count_done_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `count_no_done_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(10) UNSIGNED DEFAULT 0 COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(10) UNSIGNED DEFAULT 0 COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `projectIdAndDate`(`project_id`, `date`) USING BTREE,
  INDEX `project_id`(`project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for report_sprint_issue
-- ----------------------------
DROP TABLE IF EXISTS `report_sprint_issue`;
CREATE TABLE `report_sprint_issue`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sprint_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `week` tinyint(3) UNSIGNED DEFAULT NULL,
  `month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `count_done` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数',
  `count_no_done` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,安装状态进行统计',
  `count_done_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总完成的事项总数,按照解决结果进行统计',
  `count_no_done_by_resolve` int(10) UNSIGNED DEFAULT 0 COMMENT '今天汇总未完成的事项总数,按照解决结果进行统计',
  `today_done_points` int(10) UNSIGNED DEFAULT 0 COMMENT '敏捷开发中的事项工作量或点数',
  `today_done_number` int(10) UNSIGNED DEFAULT 0 COMMENT '当天完成的事项数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sprintIdAndDate`(`sprint_id`, `date`) USING BTREE,
  INDEX `sprint_id`(`sprint_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for service_config
-- ----------------------------
DROP TABLE IF EXISTS `service_config`;
CREATE TABLE `service_config`  (
  `id` decimal(18, 0) NOT NULL,
  `delaytime` decimal(18, 0) DEFAULT NULL,
  `clazz` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `servicename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_application
-- ----------------------------
DROP TABLE IF EXISTS `user_application`;
CREATE TABLE `user_application`  (
  `id` decimal(18, 0) NOT NULL,
  `application_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lower_application_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_date` datetime(0) DEFAULT NULL,
  `updated_date` datetime(0) DEFAULT NULL,
  `active` decimal(9, 0) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `application_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `credential` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_application_name`(`lower_application_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_application
-- ----------------------------
INSERT INTO `user_application` VALUES (1, 'crowd-embedded', 'crowd-embedded', '2013-02-28 11:57:51', '2013-02-28 11:57:51', 1, '', 'CROWD', 'X');

-- ----------------------------
-- Table structure for user_attributes
-- ----------------------------
DROP TABLE IF EXISTS `user_attributes`;
CREATE TABLE `user_attributes`  (
  `id` decimal(18, 0) NOT NULL,
  `user_id` decimal(18, 0) DEFAULT NULL,
  `directory_id` decimal(18, 0) DEFAULT NULL,
  `attribute_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `attribute_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `lower_attribute_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uk_user_attr_name_lval`(`user_id`, `attribute_name`) USING BTREE,
  INDEX `idx_user_attr_dir_name_lval`(`directory_id`, `attribute_name`(240), `lower_attribute_value`(240)) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_email_active
-- ----------------------------
DROP TABLE IF EXISTS `user_email_active`;
CREATE TABLE `user_email_active`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uid` int(10) UNSIGNED NOT NULL,
  `verify_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `email`(`email`, `verify_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_email_active
-- ----------------------------
INSERT INTO `user_email_active` VALUES (1, '19018891771', '19018891771@masterlab.org', 12217, '123456', 1585854569);

-- ----------------------------
-- Table structure for user_email_find_password
-- ----------------------------
DROP TABLE IF EXISTS `user_email_find_password`;
CREATE TABLE `user_email_find_password`  (
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(10) UNSIGNED NOT NULL,
  `verify_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  UNIQUE INDEX `email`(`email`, `verify_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_email_find_password
-- ----------------------------
INSERT INTO `user_email_find_password` VALUES ('19054399592@masterlab.org', 0, '123456', 1585854569);

-- ----------------------------
-- Table structure for user_email_token
-- ----------------------------
DROP TABLE IF EXISTS `user_email_token`;
CREATE TABLE `user_email_token`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(10) UNSIGNED NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expired` int(10) UNSIGNED NOT NULL COMMENT '有效期',
  `created_at` int(10) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1-有效，0-无效',
  `used_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用于哪个模型或功能',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED DEFAULT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_group
-- ----------------------------
INSERT INTO `user_group` VALUES (2, 1, 1);

-- ----------------------------
-- Table structure for user_invite
-- ----------------------------
DROP TABLE IF EXISTS `user_invite`;
CREATE TABLE `user_invite`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `project_roles` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '项目的角色id，可以是多个以逗号,分隔',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  INDEX `token`(`token`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_ip_login_times
-- ----------------------------
DROP TABLE IF EXISTS `user_ip_login_times`;
CREATE TABLE `user_ip_login_times`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `times` int(11) NOT NULL DEFAULT 0,
  `up_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_issue_display_fields
-- ----------------------------
DROP TABLE IF EXISTS `user_issue_display_fields`;
CREATE TABLE `user_issue_display_fields`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `fields` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_fields`(`user_id`, `project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_issue_display_fields
-- ----------------------------
INSERT INTO `user_issue_display_fields` VALUES (13, 1, 3, 'issue_num,issue_type,priority,module,sprint,summary,assignee,status,plan_date');
INSERT INTO `user_issue_display_fields` VALUES (16, 1, 0, 'issue_num,issue_type,priority,project_id,module,summary,assignee,status,resolve,plan_date');
INSERT INTO `user_issue_display_fields` VALUES (30, 1, 1, 'issue_num,issue_type,priority,module,sprint,summary,label,assignee,status,resolve,plan_date');

-- ----------------------------
-- Table structure for user_issue_last_create_data
-- ----------------------------
DROP TABLE IF EXISTS `user_issue_last_create_data`;
CREATE TABLE `user_issue_last_create_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `project_id` int(10) UNSIGNED NOT NULL,
  `issue_data` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `project_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_issue_last_create_data
-- ----------------------------
INSERT INTO `user_issue_last_create_data` VALUES (3, 1, 36, '{\"issue_type\":1,\"issue_module\":\"\\u8bf7\\u9009\\u62e9\",\"assignee\":12255,\"fix_version\":[\"\"],\"labels\":null}');
INSERT INTO `user_issue_last_create_data` VALUES (8, 1, 1, '{\"issue_type\":1,\"module\":\"1\",\"assignee\":12164,\"fix_version\":[\"1\"],\"labels\":[\"1\",\"2\",\"3\"]}');

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `token` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ip` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_login_log
-- ----------------------------
INSERT INTO `user_login_log` VALUES (1, 'mjpf86t2aqovhpmqlk132qv280', '', 1, 1627371818, '127.0.0.1');
INSERT INTO `user_login_log` VALUES (2, 'f1n2bh66nguo6rrb6qa9usi7e7', '', 1, 1628235930, '127.0.0.1');

-- ----------------------------
-- Table structure for user_main
-- ----------------------------
DROP TABLE IF EXISTS `user_main`;
CREATE TABLE `user_main`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `schema_source` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'inner' COMMENT '用户数据源: inner ldap wechat weibo github等',
  `directory_id` int(11) DEFAULT NULL,
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `openid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` tinyint(4) DEFAULT 1 COMMENT '0 审核中;1 正常; 2 禁用',
  `first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '1男2女',
  `birthday` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_time` int(10) UNSIGNED DEFAULT 0,
  `update_time` int(11) DEFAULT 0,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `source` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `ios_token` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `android_token` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `version` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `last_login_time` int(10) UNSIGNED DEFAULT 0,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0 COMMENT '是否系统自带的用户,不可删除',
  `login_counter` int(10) UNSIGNED DEFAULT 0 COMMENT '登录次数',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sign` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12264 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_main
-- ----------------------------
INSERT INTO `user_main` VALUES (1, 'inner', 1, '13983854512', 'master', 'q7a752741f667201b54780c926faec4e', 1, '', 'master', 'Master', '417170808@qq.com', '$2y$10$rbkeYdCHN9T3Rt6haRYHyuD.RCDFDhGFqdcXE04x4KemGc3EQ/d5u', 1, '2019-01-13', 0, 0, 'avatar/1.png?t=1604387178', '', NULL, NULL, NULL, NULL, 1628235930, 1, 0, '管理员', '简化项目管理，保障结果，快乐团队！');
INSERT INTO `user_main` VALUES (12164, 'inner', NULL, NULL, 'json', '87655dd189dc13a7eb36f62a3a8eed4c', 1, NULL, NULL, 'Json', '23335096@qq.com', '$2y$10$hW2HeFe4kUO/IDxGW5A68e7r.sERM6.VtP3VrYLXeyHVb0ZjXo2Sm', 0, NULL, 1579247721, 0, 'avatar/12164.png?t=1579247721', '', NULL, NULL, NULL, '', 0, 0, 0, 'Java开发工程师', NULL);
INSERT INTO `user_main` VALUES (12165, 'inner', NULL, NULL, 'shelly', '74eb77b447ad46f0ba76dba8de3e8489', 1, NULL, NULL, 'Shelly', '460399316@qq.com', '$2y$10$RXindYr74f9I1GyaGtovE.KgD6pgcjE6Z9SZyqLO9UykzImG6n2kS', 0, NULL, 1579247769, 0, 'avatar/12165.png?t=1579247769', '', NULL, NULL, NULL, '', 1583827161, 0, 0, '软件测试工程师', NULL);
INSERT INTO `user_main` VALUES (12166, 'inner', NULL, NULL, 'alex', '22778739b6553330c4f9e8a29d0e1d5f', 1, NULL, NULL, 'Alex', '2823335096@qq.com', '$2y$10$ENToGF7kfUrXm0i6DISJ6utmjq076tSCaVuEyeqQRdQocgUwxZKZ6', 0, NULL, 1579247886, 0, 'avatar/12166.png?t=1579247886', '', NULL, NULL, NULL, '', 0, 0, 0, '产品经理', NULL);
INSERT INTO `user_main` VALUES (12167, 'inner', NULL, NULL, 'max', '9b0e7dc465b9398c2e270e6da415341c', 1, NULL, NULL, 'Max', 'colderwinter@qq.com', '$2y$10$qbv7OEhHuFQFmC4zJK50T.CDN7alvBaSf2FfqCXwSwcaC3FojM0GS', 0, NULL, 1579247926, 0, 'avatar/12167.png?t=1579247926', '', NULL, NULL, NULL, '', 0, 0, 0, '前端开发工程师', NULL);
INSERT INTO `user_main` VALUES (12168, 'inner', NULL, NULL, 'sandy', '322436f4d5a63425e7973a5406b13057', 1, NULL, NULL, 'Sandy', '398509320@qq.com', '$2y$10$9Y0SadlCrjBKGJtniCG/OepxWnAkfdo4e9iUzXz/6hWWQjFfVzyGK', 0, NULL, 1579247959, 0, 'avatar/12168.png?t=1582043474', '', NULL, NULL, NULL, '', 0, 0, 0, 'UI设计师', NULL);
INSERT INTO `user_main` VALUES (12170, 'inner', NULL, NULL, 'moxao', 'ca78502344a2ca38a80f4fcc77917534', 1, NULL, NULL, 'moxao', 'moxao@vip.qq.com', '$2y$10$eWWFeZAXwrlBYQxAxl85TuzxPdNi2p5jsg2hbX317Sx1HQAQR3Rm2', 0, NULL, 1582044202, 0, 'avatar/12170.png?t=1582044202', '', NULL, NULL, NULL, '', 1585123124, 0, 0, 'gaga', NULL);
INSERT INTO `user_main` VALUES (12255, 'inner', NULL, NULL, '797206999', '0d7edf3afc7c0f9f69219d3ff591df15', 1, NULL, NULL, '79720699', '797206999@qq.com', '$2y$10$56h6VqsLEf1WlI2dXqKjgeV6VZ/Z/c/sgm7P4Mhs5Qdk331t7yH.e', 0, NULL, 1587373206, 0, 'avatar/12255.jpeg?t=1588749295', '', NULL, NULL, NULL, '', 1590829530, 0, 0, '前端开发工程师', NULL);
INSERT INTO `user_main` VALUES (12256, 'inner', NULL, NULL, '1043423813@qq.com', 'f433a284f8f7c957e839fb920fbbf73c', 1, NULL, NULL, '谢', '1043423813@qq.com', '$2y$10$O1bzCNM4JGaaV4rc7H3/3.QsbmmJWdc43.9KXfMKMzNOHm0QnWwMC', 0, NULL, 1589183156, 0, 'avatar/12256.jpeg?t=1589183156', '', NULL, NULL, NULL, '', 1591078783, 0, 0, '前端', NULL);
INSERT INTO `user_main` VALUES (12263, 'inner', NULL, NULL, '12164208@qq.com', '38fb9b406c997f198dafe06252d16577', 1, NULL, NULL, '韦哥', '12164208@qq.com', '$2y$10$z0ZHkiLSKSGYdUtYMdrP5eP4b3L07CurTxkWdG8N8B9cG25o6NNMi', 0, NULL, 1604490559, 0, '', '', NULL, NULL, NULL, '', 0, 0, 0, '', NULL);

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_uid` int(10) UNSIGNED NOT NULL,
  `sender_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direction` smallint(5) UNSIGNED NOT NULL,
  `receiver_uid` int(10) UNSIGNED NOT NULL,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `readed` tinyint(3) UNSIGNED NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL,
  `create_time` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_password
-- ----------------------------
DROP TABLE IF EXISTS `user_password`;
CREATE TABLE `user_password`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `hash` varchar(72) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT 'password_hash()值',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_password_strategy
-- ----------------------------
DROP TABLE IF EXISTS `user_password_strategy`;
CREATE TABLE `user_password_strategy`  (
  `id` int(10) UNSIGNED NOT NULL,
  `strategy` tinyint(3) UNSIGNED DEFAULT NULL COMMENT '1允许所有密码;2不允许非常简单的密码;3要求强密码  关于安全密码策略',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_password_strategy
-- ----------------------------
INSERT INTO `user_password_strategy` VALUES (1, 2);

-- ----------------------------
-- Table structure for user_phone_find_password
-- ----------------------------
DROP TABLE IF EXISTS `user_phone_find_password`;
CREATE TABLE `user_phone_find_password`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `verify_code` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '找回密码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_phone_find_password
-- ----------------------------
INSERT INTO `user_phone_find_password` VALUES (1, '19082292994', '123456', 1585854569);

-- ----------------------------
-- Table structure for user_posted_flag
-- ----------------------------
DROP TABLE IF EXISTS `user_posted_flag`;
CREATE TABLE `user_posted_flag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `_date` date NOT NULL,
  `ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`, `_date`, `ip`) USING BTREE,
  INDEX `user_id_2`(`user_id`, `_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_posted_flag
-- ----------------------------
INSERT INTO `user_posted_flag` VALUES (1, 0, '2021-07-27', '127.0.0.1');
INSERT INTO `user_posted_flag` VALUES (2, 1, '2021-07-27', '127.0.0.1');
INSERT INTO `user_posted_flag` VALUES (3, 1, '2021-08-04', '127.0.0.1');
INSERT INTO `user_posted_flag` VALUES (4, 1, '2021-08-06', '127.0.0.1');

-- ----------------------------
-- Table structure for user_refresh_token
-- ----------------------------
DROP TABLE IF EXISTS `user_refresh_token`;
CREATE TABLE `user_refresh_token`  (
  `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `refresh_token` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `refresh_token`(`refresh_token`(255)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户刷新的token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_setting
-- ----------------------------
DROP TABLE IF EXISTS `user_setting`;
CREATE TABLE `user_setting`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `_value` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id`, `_key`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 615 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_setting
-- ----------------------------
INSERT INTO `user_setting` VALUES (51, 1, 'scheme_style', 'left');
INSERT INTO `user_setting` VALUES (53, 1, 'project_view', 'issues');
INSERT INTO `user_setting` VALUES (54, 1, 'issue_view', 'list');
INSERT INTO `user_setting` VALUES (198, 1, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (201, 1, 'initialized_widget', '1');
INSERT INTO `user_setting` VALUES (353, 1, 'page_layout', 'fixed');
INSERT INTO `user_setting` VALUES (516, 1, 'projects_sort', 'latest_activity_desc');
INSERT INTO `user_setting` VALUES (521, 12165, 'layout', 'aa');
INSERT INTO `user_setting` VALUES (522, 12165, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (523, 12170, 'layout', 'aa');
INSERT INTO `user_setting` VALUES (524, 12170, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (525, 12170, 'projects_sort', 'created_desc');
INSERT INTO `user_setting` VALUES (565, 12255, 'layout', 'aa');
INSERT INTO `user_setting` VALUES (566, 12255, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (567, 12260, 'layout', 'aa');
INSERT INTO `user_setting` VALUES (568, 12260, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (569, 12261, 'layout', 'aa');
INSERT INTO `user_setting` VALUES (570, 12261, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (572, 12256, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (597, 12256, 'layout', 'aaa');
INSERT INTO `user_setting` VALUES (598, 12256, 'projects_sort', 'created_desc');
INSERT INTO `user_setting` VALUES (602, 12262, 'layout', 'aa');
INSERT INTO `user_setting` VALUES (603, 12262, 'initializedWidget', '1');
INSERT INTO `user_setting` VALUES (604, 12262, 'projects_sort', 'created_desc');
INSERT INTO `user_setting` VALUES (614, 1, 'layout', 'aaa');

-- ----------------------------
-- Table structure for user_token
-- ----------------------------
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE `user_token`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'token',
  `token_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'token过期时间',
  `refresh_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '刷新token',
  `refresh_token_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '刷新token过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_token
-- ----------------------------
INSERT INTO `user_token` VALUES (1, 1, '540fe53f43e51eb6192cb6eacfb62fad3654e7d5a20639adb6493f09b88abfce', 1627371818, 'd27e8981b95d4ade32d6d4e74d2c0fa15b3eb0f3d2246b922f5b1a7759aa70a4', 1627371818);
INSERT INTO `user_token` VALUES (2, 12165, '289782df047c0639a1de60ec30df81be53d3aa23f5e7cee5ef5aa4b20f672467', 1583827161, 'f2e9f12ee857d126d36df54e03e4f0cf98a48d68c05a484f1469710b20a19d3b', 1583827161);
INSERT INTO `user_token` VALUES (3, 12170, '091ec9b5343b945a2a879dbfdfc6dcae84ba0e8eafae9c81d63f741f94164677', 1585123124, 'de5f7da9538959dd325522b5526e9ad6bd2aaef4485b9bc5c66971bc6c3c3e01', 1585123124);
INSERT INTO `user_token` VALUES (4, 12256, 'ea8a1052074fffe62ee5e9100ed0540c48a812fa8aa80b165908bf5f62a88cea', 1590482533, '807d05146a7385e017feeadb25642c431276ca280e9d78e7d60c9cbf36c98ad3', 1590482533);
INSERT INTO `user_token` VALUES (5, 12255, '1900f267de67e2c589a673ea9dd7fa6e3aaef718953de171acc5efd0f7d7df5c', 1590829475, '4b2dc1cf0a9c7b165bd84d943f49fc0d0b8a73ee4155e896616bb50c969545de', 1590829475);
INSERT INTO `user_token` VALUES (6, 12260, '2a3d355be7ad548fcdb5cb678c3f954a40b7af3e01ae2315a6b8b8366cab8a2d', 1590941255, '3809c705052ff05d5c7c8df9462f0f2835fc93d257caf06eab6c344a1c462375', 1590941255);
INSERT INTO `user_token` VALUES (7, 12261, '9e24d6373c5604e7929a47ac3b8cf66d9ab0af7f5f5ba86c5f293d085872739b', 1590941546, '9cd87f6c48e515f4889fdd5f39ecfa05cba9d6feea987d82b61f9d0806df49aa', 1590941546);
INSERT INTO `user_token` VALUES (8, 12262, '4df8c02c95d4262ea8e1656cf56cc24358a7c10d2f92307759bc504a988dc1c5', 1593856423, '702f97f1753c239b384f81c35bf676d6a6f9ba4bc1f247428990e2c3bd22fead', 1593856423);

-- ----------------------------
-- Table structure for user_widget
-- ----------------------------
DROP TABLE IF EXISTS `user_widget`;
CREATE TABLE `user_widget`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `widget_id` int(11) NOT NULL COMMENT 'main_widget主键id',
  `order_weight` int(10) UNSIGNED DEFAULT NULL COMMENT '工具顺序',
  `panel` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parameter` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_saved_parameter` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否保存了过滤参数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`, `widget_id`) USING BTREE,
  INDEX `order_weight`(`order_weight`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2916 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_widget
-- ----------------------------
INSERT INTO `user_widget` VALUES (1, 0, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2, 0, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (3, 0, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (4, 0, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (5, 0, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2460, 12165, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2461, 12165, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2462, 12165, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2463, 12165, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2464, 12165, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2465, 12170, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2466, 12170, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2467, 12170, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2468, 12170, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2469, 12170, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2470, 12173, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2471, 12173, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2472, 12173, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2473, 12173, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2474, 12173, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2475, 12180, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2476, 12180, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2477, 12180, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2478, 12180, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2479, 12180, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2480, 12182, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2481, 12182, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2482, 12182, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2483, 12182, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2484, 12182, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2485, 12183, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2486, 12183, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2487, 12183, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2488, 12183, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2489, 12183, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2490, 12185, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2491, 12185, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2492, 12185, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2493, 12185, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2494, 12185, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2495, 12186, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2496, 12186, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2497, 12186, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2498, 12186, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2499, 12186, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2500, 12212, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2501, 12212, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2502, 12212, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2503, 12212, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2504, 12212, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2505, 12213, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2506, 12213, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2507, 12213, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2508, 12213, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2509, 12213, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2666, 12255, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2667, 12255, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2668, 12255, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2669, 12255, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2670, 12255, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2671, 12260, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2672, 12260, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2673, 12260, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2674, 12260, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2675, 12260, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2676, 12261, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2677, 12261, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2678, 12261, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2679, 12261, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2680, 12261, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2805, 12256, 7, 1, 'first', '[{\"name\":\"by_time\",\"value\":\"week\"},{\"name\":\"within_date\",\"value\":\"\"}]', 1);
INSERT INTO `user_widget` VALUES (2806, 12256, 1, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2807, 12256, 2, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2808, 12256, 3, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2809, 12256, 23, 1, 'third', '', 0);
INSERT INTO `user_widget` VALUES (2829, 12262, 1, 1, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2830, 12262, 4, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2831, 12262, 5, 2, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2832, 12262, 23, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2833, 12262, 3, 3, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2908, 1, 1, 2, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2911, 1, 24, 5, 'first', '', 0);
INSERT INTO `user_widget` VALUES (2912, 1, 3, 1, 'second', '', 0);
INSERT INTO `user_widget` VALUES (2915, 1, 23, 3, 'third', '', 0);

-- ----------------------------
-- Table structure for workflow
-- ----------------------------
DROP TABLE IF EXISTS `workflow`;
CREATE TABLE `workflow`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '',
  `create_uid` int(10) UNSIGNED DEFAULT NULL,
  `create_time` int(10) UNSIGNED DEFAULT NULL,
  `update_uid` int(10) UNSIGNED DEFAULT NULL,
  `update_time` int(10) UNSIGNED DEFAULT NULL,
  `steps` tinyint(3) UNSIGNED DEFAULT NULL,
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `is_system` tinyint(3) UNSIGNED DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of workflow
-- ----------------------------
INSERT INTO `workflow` VALUES (1, '默认状态流', '', 1, 0, NULL, 1582439359, NULL, '{\"blocks\":[{\"id\":\"state_begin\",\"positionX\":469,\"positionY\":19,\"innerHTML\":\"BEGIN<div class=\\\"ep\\\" action=\\\"begin\\\"></div>\",\"innerText\":\"BEGIN\"},{\"id\":\"state_open\",\"positionX\":442,\"positionY\":142,\"innerHTML\":\"打开<div class=\\\"ep\\\" action=\\\"OPEN\\\"></div>\",\"innerText\":\"打开\"},{\"id\":\"state_resolved\",\"positionX\":755,\"positionY\":136,\"innerHTML\":\"已解决<div class=\\\"ep\\\" action=\\\"resolved\\\"></div>\",\"innerText\":\"已解决\"},{\"id\":\"state_reopen\",\"positionX\":942,\"positionY\":305,\"innerHTML\":\"重新打开<div class=\\\"ep\\\" action=\\\"reopen\\\"></div>\",\"innerText\":\"重新打开\"},{\"id\":\"state_in_progress\",\"positionX\":463,\"positionY\":457,\"innerHTML\":\"处理中<div class=\\\"ep\\\" action=\\\"in_progress\\\"></div>\",\"innerText\":\"处理中\"},{\"id\":\"state_closed\",\"positionX\":767,\"positionY\":429,\"innerHTML\":\"已关闭<div class=\\\"ep\\\" action=\\\"closed\\\"></div>\",\"innerText\":\"已关闭\"},{\"id\":\"state_delay\",\"positionX\":303,\"positionY\":252,\"innerHTML\":\"延迟处理  <div class=\\\"ep\\\" action=\\\"延迟处理\\\"></div>\",\"innerText\":\"延迟处理  \"},{\"id\":\"state_in_review\",\"positionX\":1243,\"positionY\":153,\"innerHTML\":\"回 顾  <div class=\\\"ep\\\" action=\\\"回 顾\\\"></div>\",\"innerText\":\"回 顾  \"},{\"id\":\"state_done\",\"positionX\":1247,\"positionY\":247,\"innerHTML\":\"完 成  <div class=\\\"ep\\\" action=\\\"完 成\\\"></div>\",\"innerText\":\"完 成  \"}],\"connections\":[{\"id\":\"con_3\",\"sourceId\":\"state_begin\",\"targetId\":\"state_open\"},{\"id\":\"con_10\",\"sourceId\":\"state_open\",\"targetId\":\"state_resolved\"},{\"id\":\"con_17\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_closed\"},{\"id\":\"con_24\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_closed\"},{\"id\":\"con_31\",\"sourceId\":\"state_open\",\"targetId\":\"state_closed\"},{\"id\":\"con_38\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_closed\"},{\"id\":\"con_45\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_reopen\"},{\"id\":\"con_52\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_open\"},{\"id\":\"con_59\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_resolved\"},{\"id\":\"con_66\",\"sourceId\":\"state_closed\",\"targetId\":\"state_open\"},{\"id\":\"con_73\",\"sourceId\":\"state_open\",\"targetId\":\"state_delay\"},{\"id\":\"con_80\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_open\"},{\"id\":\"con_87\",\"sourceId\":\"state_delay\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_94\",\"sourceId\":\"state_closed\",\"targetId\":\"state_reopen\"},{\"id\":\"con_101\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_resolved\"},{\"id\":\"con_108\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_delay\"},{\"id\":\"con_115\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_122\",\"sourceId\":\"state_open\",\"targetId\":\"state_in_progress\"}]}', 1);
INSERT INTO `workflow` VALUES (2, '软件开发状态流', '针对软件开发的过程状态流', 1, NULL, NULL, 1529647857, NULL, '{\"blocks\":[{\"id\":\"state_begin\",\"positionX\":506,\"positionY\":40,\"innerHTML\":\"BEGIN<div class=\\\"ep\\\" action=\\\"begin\\\"></div>\",\"innerText\":\"BEGIN\"},{\"id\":\"state_open\",\"positionX\":511,\"positionY\":159,\"innerHTML\":\"打开<div class=\\\"ep\\\" action=\\\"OPEN\\\"></div>\",\"innerText\":\"打开\"},{\"id\":\"state_resolved\",\"positionX\":830,\"positionY\":150,\"innerHTML\":\"已解决<div class=\\\"ep\\\" action=\\\"resolved\\\"></div>\",\"innerText\":\"已解决\"},{\"id\":\"state_reopen\",\"positionX\":942,\"positionY\":305,\"innerHTML\":\"重新打开<div class=\\\"ep\\\" action=\\\"reopen\\\"></div>\",\"innerText\":\"重新打开\"},{\"id\":\"state_in_progress\",\"positionX\":490,\"positionY\":395,\"innerHTML\":\"处理中<div class=\\\"ep\\\" action=\\\"in_progress\\\"></div>\",\"innerText\":\"处理中\"},{\"id\":\"state_closed\",\"positionX\":767,\"positionY\":429,\"innerHTML\":\"已关闭<div class=\\\"ep\\\" action=\\\"closed\\\"></div>\",\"innerText\":\"已关闭\"},{\"id\":\"state_delay\",\"positionX\":394,\"positionY\":276,\"innerHTML\":\"延迟处理  <div class=\\\"ep\\\" action=\\\"延迟处理\\\"></div>\",\"innerText\":\"延迟处理  \"},{\"id\":\"state_in_review\",\"positionX\":1243,\"positionY\":153,\"innerHTML\":\"回 顾  <div class=\\\"ep\\\" action=\\\"回 顾\\\"></div>\",\"innerText\":\"回 顾  \"},{\"id\":\"state_done\",\"positionX\":1247,\"positionY\":247,\"innerHTML\":\"完 成  <div class=\\\"ep\\\" action=\\\"完 成\\\"></div>\",\"innerText\":\"完 成  \"}],\"connections\":[{\"id\":\"con_3\",\"sourceId\":\"state_begin\",\"targetId\":\"state_open\"},{\"id\":\"con_10\",\"sourceId\":\"state_open\",\"targetId\":\"state_resolved\"},{\"id\":\"con_17\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_closed\"},{\"id\":\"con_24\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_closed\"},{\"id\":\"con_31\",\"sourceId\":\"state_open\",\"targetId\":\"state_closed\"},{\"id\":\"con_38\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_closed\"},{\"id\":\"con_45\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_reopen\"},{\"id\":\"con_52\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_open\"},{\"id\":\"con_59\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_resolved\"},{\"id\":\"con_66\",\"sourceId\":\"state_closed\",\"targetId\":\"state_open\"},{\"id\":\"con_73\",\"sourceId\":\"state_open\",\"targetId\":\"state_delay\"},{\"id\":\"con_80\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_open\"},{\"id\":\"con_87\",\"sourceId\":\"state_delay\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_94\",\"sourceId\":\"state_closed\",\"targetId\":\"state_reopen\"},{\"id\":\"con_101\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_resolved\"},{\"id\":\"con_108\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_delay\"},{\"id\":\"con_115\",\"sourceId\":\"state_reopen\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_125\",\"sourceId\":\"state_open\",\"targetId\":\"state_in_progress\"}]}', 1);
INSERT INTO `workflow` VALUES (3, 'Task状态流', '', 1, NULL, NULL, 1539675552, NULL, '{\"blocks\":[{\"id\":\"state_begin\",\"positionX\":506,\"positionY\":40,\"innerHTML\":\"BEGIN<div class=\\\"ep\\\" action=\\\"begin\\\"></div>\",\"innerText\":\"BEGIN\"},{\"id\":\"state_open\",\"positionX\":516,\"positionY\":170,\"innerHTML\":\"打开<div class=\\\"ep\\\" action=\\\"OPEN\\\"></div>\",\"innerText\":\"打开\"},{\"id\":\"state_resolved\",\"positionX\":807,\"positionY\":179,\"innerHTML\":\"已解决<div class=\\\"ep\\\" action=\\\"resolved\\\"></div>\",\"innerText\":\"已解决\"},{\"id\":\"state_reopen\",\"positionX\":1238,\"positionY\":81,\"innerHTML\":\"重新打开<div class=\\\"ep\\\" action=\\\"reopen\\\"></div>\",\"innerText\":\"重新打开\"},{\"id\":\"state_in_progress\",\"positionX\":494,\"positionY\":425,\"innerHTML\":\"处理中<div class=\\\"ep\\\" action=\\\"in_progress\\\"></div>\",\"innerText\":\"处理中\"},{\"id\":\"state_closed\",\"positionX\":784,\"positionY\":424,\"innerHTML\":\"已关闭<div class=\\\"ep\\\" action=\\\"closed\\\"></div>\",\"innerText\":\"已关闭\"},{\"id\":\"state_delay\",\"positionX\":385,\"positionY\":307,\"innerHTML\":\"延迟处理  <div class=\\\"ep\\\" action=\\\"延迟处理\\\"></div>\",\"innerText\":\"延迟处理  \"},{\"id\":\"state_in_review\",\"positionX\":1243,\"positionY\":153,\"innerHTML\":\"回 顾  <div class=\\\"ep\\\" action=\\\"回 顾\\\"></div>\",\"innerText\":\"回 顾  \"},{\"id\":\"state_done\",\"positionX\":1247,\"positionY\":247,\"innerHTML\":\"完 成  <div class=\\\"ep\\\" action=\\\"完 成\\\"></div>\",\"innerText\":\"完 成  \"}],\"connections\":[{\"id\":\"con_3\",\"sourceId\":\"state_begin\",\"targetId\":\"state_open\"},{\"id\":\"con_10\",\"sourceId\":\"state_open\",\"targetId\":\"state_resolved\"},{\"id\":\"con_17\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_closed\"},{\"id\":\"con_24\",\"sourceId\":\"state_open\",\"targetId\":\"state_closed\"},{\"id\":\"con_31\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_closed\"},{\"id\":\"con_38\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_open\"},{\"id\":\"con_45\",\"sourceId\":\"state_in_progress\",\"targetId\":\"state_resolved\"},{\"id\":\"con_52\",\"sourceId\":\"state_closed\",\"targetId\":\"state_open\"},{\"id\":\"con_59\",\"sourceId\":\"state_open\",\"targetId\":\"state_delay\"},{\"id\":\"con_66\",\"sourceId\":\"state_resolved\",\"targetId\":\"state_open\"},{\"id\":\"con_73\",\"sourceId\":\"state_delay\",\"targetId\":\"state_in_progress\"},{\"id\":\"con_83\",\"sourceId\":\"state_open\",\"targetId\":\"state_in_progress\"}]}', 1);

-- ----------------------------
-- Table structure for workflow_block
-- ----------------------------
DROP TABLE IF EXISTS `workflow_block`;
CREATE TABLE `workflow_block`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `workflow_id` int(10) UNSIGNED DEFAULT NULL,
  `status_id` int(10) UNSIGNED DEFAULT NULL,
  `blcok_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `position_x` smallint(5) UNSIGNED DEFAULT NULL,
  `position_y` smallint(5) UNSIGNED DEFAULT NULL,
  `inner_html` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `workflow_id`(`workflow_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for workflow_connector
-- ----------------------------
DROP TABLE IF EXISTS `workflow_connector`;
CREATE TABLE `workflow_connector`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `workflow_id` int(10) UNSIGNED DEFAULT NULL,
  `connector_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `source_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `target_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `workflow_id`(`workflow_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for workflow_scheme
-- ----------------------------
DROP TABLE IF EXISTS `workflow_scheme`;
CREATE TABLE `workflow_scheme`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_system` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10103 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of workflow_scheme
-- ----------------------------
INSERT INTO `workflow_scheme` VALUES (1, '默认状态流方案', '', 1);
INSERT INTO `workflow_scheme` VALUES (10100, '敏捷开发状态流方案', '敏捷开发适用', 1);
INSERT INTO `workflow_scheme` VALUES (10101, '普通的软件开发状态流方案', '', 1);
INSERT INTO `workflow_scheme` VALUES (10102, '流程管理状态流方案', '', 1);

-- ----------------------------
-- Table structure for workflow_scheme_data
-- ----------------------------
DROP TABLE IF EXISTS `workflow_scheme_data`;
CREATE TABLE `workflow_scheme_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `scheme_id` int(10) UNSIGNED DEFAULT NULL,
  `issue_type_id` int(10) UNSIGNED DEFAULT NULL,
  `workflow_id` int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `workflow_scheme`(`scheme_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10326 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of workflow_scheme_data
-- ----------------------------
INSERT INTO `workflow_scheme_data` VALUES (10000, 1, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10105, 10100, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10200, 10200, 10105, 1);
INSERT INTO `workflow_scheme_data` VALUES (10201, 10200, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10202, 10201, 10105, 1);
INSERT INTO `workflow_scheme_data` VALUES (10203, 10201, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10300, 10300, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10307, 10307, 1, 1);
INSERT INTO `workflow_scheme_data` VALUES (10308, 10307, 2, 2);
INSERT INTO `workflow_scheme_data` VALUES (10311, 10101, 2, 1);
INSERT INTO `workflow_scheme_data` VALUES (10312, 10101, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10319, 10305, 1, 2);
INSERT INTO `workflow_scheme_data` VALUES (10320, 10305, 2, 2);
INSERT INTO `workflow_scheme_data` VALUES (10321, 10305, 4, 2);
INSERT INTO `workflow_scheme_data` VALUES (10322, 10305, 5, 2);
INSERT INTO `workflow_scheme_data` VALUES (10323, 10102, 2, 1);
INSERT INTO `workflow_scheme_data` VALUES (10324, 10102, 0, 1);
INSERT INTO `workflow_scheme_data` VALUES (10325, 10102, 10105, 1);

SET FOREIGN_KEY_CHECKS = 1;
