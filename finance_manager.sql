/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : localhost:3306
 Source Schema         : finance_manager

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 13/05/2022 13:51:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fm_business
-- ----------------------------
DROP TABLE IF EXISTS `fm_business`;
CREATE TABLE `fm_business`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务名',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务描述',
  `state` tinyint(2) NULL DEFAULT 1 COMMENT '业务状态 1 待完成 2已完成',
  `money` float NULL DEFAULT NULL COMMENT '业务奖金',
  `start_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `end_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `department_id` int(11) NULL DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fm_business
-- ----------------------------
INSERT INTO `fm_business` VALUES (1, '开发小程序', '开发一个购物小程序', 1, 1002, '2022-05-05', '2022-05-31', 1);
INSERT INTO `fm_business` VALUES (6, '测试1', '测试描述', 1, 10055, '2022-05-16', '2022-05-30', 4);
INSERT INTO `fm_business` VALUES (7, '测试2', '测试2描述', 1, 100, '2021-04-25', '2021-04-27', 2);

-- ----------------------------
-- Table structure for fm_company
-- ----------------------------
DROP TABLE IF EXISTS `fm_company`;
CREATE TABLE `fm_company`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司名',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司地址',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `count` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规模人员',
  `money` float NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fm_company
-- ----------------------------
INSERT INTO `fm_company` VALUES (1, 'xxxx科技有限公司', 'xx省xx市xx广场xx栋101', '2022-05-09 22:08:06', '100人以上', 10000000, 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2083601046,169018592&fm=11&gp=0.jpg');

-- ----------------------------
-- Table structure for fm_department
-- ----------------------------
DROP TABLE IF EXISTS `fm_department`;
CREATE TABLE `fm_department`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门描述',
  `money` float NULL DEFAULT NULL COMMENT '部门工资',
  `business_amount` float NULL DEFAULT NULL COMMENT '业务金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fm_department
-- ----------------------------
INSERT INTO `fm_department` VALUES (1, '技术部', '2021-04-22 00:11:34', '这是技术部6666', 18022, 500);
INSERT INTO `fm_department` VALUES (2, '销售部', '2021-04-22 00:11:37', '这是销售部', 8300, 1000);
INSERT INTO `fm_department` VALUES (3, '人事部', '2021-04-21 13:48:29', '这是人事部', 6000, 3000);
INSERT INTO `fm_department` VALUES (4, '行政部', '2021-04-21 13:48:31', '这是行政部', 45220, 2000);

-- ----------------------------
-- Table structure for fm_money_info
-- ----------------------------
DROP TABLE IF EXISTS `fm_money_info`;
CREATE TABLE `fm_money_info`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支出名称',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支出描述',
  `money` float NULL DEFAULT NULL COMMENT '支出金额',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `money_type_id` bigint(20) NULL DEFAULT NULL COMMENT '类型',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fm_money_info
-- ----------------------------
INSERT INTO `fm_money_info` VALUES (1, '购买电脑', '给公司购买了20台Mac电脑', 200000, 1, 1, '2021-04-21 12:55:07');

-- ----------------------------
-- Table structure for fm_money_type
-- ----------------------------
DROP TABLE IF EXISTS `fm_money_type`;
CREATE TABLE `fm_money_type`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` tinyint(2) NULL DEFAULT 1 COMMENT '1 支出  2收入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fm_money_type
-- ----------------------------
INSERT INTO `fm_money_type` VALUES (1, '购买电脑', 1);
INSERT INTO `fm_money_type` VALUES (2, '购买机器', 1);
INSERT INTO `fm_money_type` VALUES (3, '员工工资', 1);
INSERT INTO `fm_money_type` VALUES (4, '项目盈利', 2);
INSERT INTO `fm_money_type` VALUES (5, '项目奖金', 2);

-- ----------------------------
-- Table structure for fm_notice
-- ----------------------------
DROP TABLE IF EXISTS `fm_notice`;
CREATE TABLE `fm_notice`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `user_id` bigint(20) NULL DEFAULT NULL,
  `type` tinyint(2) NULL DEFAULT 1 COMMENT '类型 1 公告 2留言',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fm_notice
-- ----------------------------
INSERT INTO `fm_notice` VALUES (2, 'test', '今天测试66', '2021-04-21 22:16:16', 1, 2);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '基本信息管理', '/basic', 0, 'el-icon-s-platform', 1);
INSERT INTO `sys_menu` VALUES (2, 1, '员工管理', '/basic/user', 1, 'el-icon-user-solid\r\n', 1);
INSERT INTO `sys_menu` VALUES (3, 1, '管理员管理', '/basic/admin', 1, 'el-icon-s-custom', 2);
INSERT INTO `sys_menu` VALUES (6, 0, '工资管理', '/wages', 0, 'el-icon-money', 1);
INSERT INTO `sys_menu` VALUES (7, 6, '员工工资管理', '/wages/user', 1, 'el-icon-user-solid\r\n', 2);
INSERT INTO `sys_menu` VALUES (8, 6, '管理员工资管理', '/wages/admin', 1, 'el-icon-s-custom', 3);
INSERT INTO `sys_menu` VALUES (9, 0, '业务管理', '/business', 0, 'el-icon-s-promotion', 1);
INSERT INTO `sys_menu` VALUES (10, 9, '员工业务管理', '/business/user', 1, 'el-icon-user-solid', 1);
INSERT INTO `sys_menu` VALUES (11, 9, '管理员业务管理', '/business/admin', 1, 'el-icon-s-custom', 2);
INSERT INTO `sys_menu` VALUES (12, 0, '系统管理', '/system', 0, 'el-icon-s-tools', 1);
INSERT INTO `sys_menu` VALUES (13, 12, '系统留言公告', '/system/notice', 1, 'el-icon-s-comment', 2);
INSERT INTO `sys_menu` VALUES (14, 12, '用户管理', '/system/user', 1, 'el-icon-user-solid', 3);
INSERT INTO `sys_menu` VALUES (15, 12, '公告留言管理', '/system/admin', 1, 'el-icon-edit-outline', 4);
INSERT INTO `sys_menu` VALUES (16, 0, '统计汇总管理', '/summary', 0, 'el-icon-discover', 1);
INSERT INTO `sys_menu` VALUES (17, 16, '收入汇总', '/summary/income', 1, 'el-icon-files', 2);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户编号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `bank_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `sex` tinyint(2) NOT NULL DEFAULT 1 COMMENT '性别 1男 2女',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `role` tinyint(2) NULL DEFAULT 1 COMMENT '角色 0管理员 1用户',
  `department_id` bigint(20) NULL DEFAULT 1 COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '成都', '1234544434', 'xxxx@qq.com', '963852741', 1, '2022-05-09 22:18:01', 1, 1);
INSERT INTO `sys_user` VALUES (2, 'test', 'u1335523995', 'e10adc3949ba59abbe56e057f20f883e', '1212', '1335523995', '212', '12', 1, '2021-04-22 09:52:14', 2, 2);
INSERT INTO `sys_user` VALUES (4, 'guest', 'u1335523665', 'e10adc3949ba59abbe56e057f20f883e', '1212', '1335523995', '212', '12', 1, '2021-04-22 09:52:14', 2, 2);

SET FOREIGN_KEY_CHECKS = 1;
