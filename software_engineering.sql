/*
 Navicat Premium Data Transfer

 Source Server         : server
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : 43.142.182.70:3306
 Source Schema         : software_engineering

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 28/05/2023 22:00:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `sId` int NOT NULL COMMENT '教职工编号',
  `sName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教职工姓名',
  `sType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类别',
  `sPosition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '职称',
  PRIMARY KEY (`sId`) USING BTREE,
  INDEX `sId`(`sId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (100001, '张三', '教师', '讲师');
INSERT INTO `staff` VALUES (100002, '程鹤', '教师', '助教');
INSERT INTO `staff` VALUES (100003, '刘梦', '教师', '副教授');
INSERT INTO `staff` VALUES (100004, '帅哥', '职工', '保卫科工作人员');
INSERT INTO `staff` VALUES (200001, '李四', '教师', '教授');
INSERT INTO `staff` VALUES (300003, '猪八戒', '职工', '保卫科工作人员');
INSERT INTO `staff` VALUES (400008, '孙悟空', '职工', '保卫科工作人员');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_pic_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (60, 'zkd', '$2a$10$SHgFj6jmfoZ4PkEGc4e/YuBg48CggxsBsvKbEqMpDssNLbWpR0.i.', NULL, NULL, NULL);
INSERT INTO `user` VALUES (62, 'tianya', '$2a$10$AZC2gKmQkXJkIb6GjPDteeaBK/1T8a0fujY75Zf.i1x/wPUBjQMBS', NULL, NULL, NULL);
INSERT INTO `user` VALUES (63, 'tianya1', '$2a$10$C7XUAN8xAAdhnpIaycxSR.3GLR0vJuzaVXhhYJFLR9GdmSco0rD7i', NULL, NULL, NULL);
INSERT INTO `user` VALUES (64, 'tianya2', '$2a$10$cj5.cl1PcR5ENqMBIvrOiu594HGA522UpeoMcP8y1mI4g7B8eDP1m', NULL, NULL, NULL);
INSERT INTO `user` VALUES (65, 'hychmy', '$2a$10$Y2n4EmTa.rEvd6iQOwFNIez2E75nx0QtNVQjSGsBsHesTyQg3/J3y', NULL, NULL, NULL);
INSERT INTO `user` VALUES (66, 'aZure', '$2a$10$wnZIHRINNL.yiDQ0epN/ueTLTS87OHOsaB21bLEXdpM7Kg7pA8Jym', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for wagetable
-- ----------------------------
DROP TABLE IF EXISTS `wagetable`;
CREATE TABLE `wagetable`  (
  `wId` int NOT NULL AUTO_INCREMENT COMMENT '工资明细表编号',
  `sId` int NOT NULL COMMENT '教职工编号',
  `year` int NOT NULL COMMENT '年份',
  `month` int NOT NULL COMMENT '月份',
  `basePay` double NULL DEFAULT NULL COMMENT '基本工资',
  `livingAllowance` double NULL DEFAULT NULL COMMENT '生活补贴',
  `bookFee` double(255, 0) NULL DEFAULT NULL COMMENT '书报费',
  `carFare` double(255, 0) NULL DEFAULT NULL COMMENT '交通费',
  `cleaningFee` double(255, 0) NULL DEFAULT NULL COMMENT '洗理费',
  `classfee` double(255, 0) NULL DEFAULT NULL COMMENT '课时费',
  `jobsubsidy` double(255, 0) NULL DEFAULT NULL COMMENT '岗位津贴',
  `totalWage` double(255, 0) NULL DEFAULT NULL COMMENT '工资总额',
  `individualIncomeTax` double(255, 0) NULL DEFAULT NULL COMMENT '个人所得税',
  `housingProvidentFund` double(255, 0) NULL DEFAULT NULL COMMENT '住房公积金',
  `premium` double(255, 0) NULL DEFAULT NULL COMMENT '保险费',
  `netPayroll` double(255, 0) NULL DEFAULT NULL COMMENT '实发工资',
  PRIMARY KEY (`wId`) USING BTREE,
  INDEX `sId`(`sId`) USING BTREE,
  CONSTRAINT `wagetable_ibfk_1` FOREIGN KEY (`sId`) REFERENCES `staff` (`sId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wagetable
-- ----------------------------
INSERT INTO `wagetable` VALUES (2, 100002, 2023, 1, 4000, 1000, 200, 200, 100, 500, 200, 6200, 36, 1000, 200, 4964);
INSERT INTO `wagetable` VALUES (4, 100001, 2023, 11, 5000, 1000, 200, 200, 100, 5400, 300, 12200, 216, 1500, 200, 10284);
INSERT INTO `wagetable` VALUES (5, 100001, 2023, 3, 5000, 1000, 200, 200, 100, 600, 300, 7400, 72, 1500, 200, 5628);
INSERT INTO `wagetable` VALUES (9, 100004, 2023, 1, 10000, 1000, 200, 200, 100, 1200, 500, 13200, 246, 2500, 200, 10254);
INSERT INTO `wagetable` VALUES (11, 100002, 2023, 1, 4000, 1000, 200, 200, 100, 500, 200, 6200, 36, 1000, 200, 4964);
INSERT INTO `wagetable` VALUES (24, 200001, 2023, 2, 4000, 1000, 200, 200, 100, 1000, 200, 6700, 51, 1000, 200, 5449);
INSERT INTO `wagetable` VALUES (25, 100003, 2023, 12, 7000, 1000, 200, 200, 100, 1840, 400, 10740, 172, 2000, 200, 8368);
INSERT INTO `wagetable` VALUES (26, 200001, 2023, 12, 4000, 1000, 200, 200, 100, 2700, 200, 8400, 102, 1000, 200, 7098);
INSERT INTO `wagetable` VALUES (27, 100004, 2023, 12, 10000, 1000, 200, 200, 100, 2200, 500, 14200, 276, 2500, 200, 11224);
INSERT INTO `wagetable` VALUES (28, 200001, 2023, 2, 4000, 1000, 200, 200, 100, 1000, 200, 6700, 51, 1000, 200, 5449);
INSERT INTO `wagetable` VALUES (29, 200001, 2023, 1, 4000, 1000, 200, 200, 100, 1150, 200, 6850, 55, 1000, 200, 5594);
INSERT INTO `wagetable` VALUES (35, 100002, 2023, 1, 4000, 1000, 200, 200, 100, 500, 200, 6200, 36, 1000, 200, 4964);
INSERT INTO `wagetable` VALUES (37, 100001, 2023, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `wagetable` VALUES (40, 100002, 2023, 12, 4000, 1000, 200, 200, 100, 1100, 200, 6800, 54, 1000, 200, 5546);
INSERT INTO `wagetable` VALUES (41, 100001, 2023, 1, 5000, 1000, 200, 200, 100, 600, 300, 7400, 72, 1500, 200, 5628);
INSERT INTO `wagetable` VALUES (43, 100001, 2023, 6, 5000, 1000, 200, 200, 100, 1200, 300, 8000, 90, 1500, 200, 6210);

-- ----------------------------
-- Table structure for workhours
-- ----------------------------
DROP TABLE IF EXISTS `workhours`;
CREATE TABLE `workhours`  (
  `sId` int NOT NULL COMMENT '教职工编号',
  `year` int NOT NULL COMMENT '年份',
  `month` int NOT NULL COMMENT '月份',
  `hours` int NOT NULL COMMENT '工作时长',
  `checked` int UNSIGNED NOT NULL COMMENT '是否审核，0为未审核，1为已审核,2为审核不通过',
  PRIMARY KEY (`sId`, `year`, `month`) USING BTREE,
  INDEX `sId`(`sId`) USING BTREE,
  CONSTRAINT `workhours_ibfk_1` FOREIGN KEY (`sId`) REFERENCES `staff` (`sId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of workhours
-- ----------------------------
INSERT INTO `workhours` VALUES (100001, 2023, 1, 10, 1);
INSERT INTO `workhours` VALUES (100001, 2023, 5, 20, 2);
INSERT INTO `workhours` VALUES (100001, 2023, 6, 20, 1);
INSERT INTO `workhours` VALUES (100001, 2023, 12, 12, 1);
INSERT INTO `workhours` VALUES (100002, 2023, 1, 10, 1);
INSERT INTO `workhours` VALUES (100002, 2023, 12, 22, 1);
INSERT INTO `workhours` VALUES (100003, 2023, 12, 23, 1);
INSERT INTO `workhours` VALUES (100004, 2023, 1, 12, 2);
INSERT INTO `workhours` VALUES (100004, 2023, 3, 30, 2);
INSERT INTO `workhours` VALUES (100004, 2023, 12, 22, 1);
INSERT INTO `workhours` VALUES (200001, 2023, 1, 23, 1);
INSERT INTO `workhours` VALUES (200001, 2023, 2, 20, 1);

SET FOREIGN_KEY_CHECKS = 1;
