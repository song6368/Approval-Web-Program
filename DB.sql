-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: no_solicitation
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluation` (
  `eval_no` int NOT NULL AUTO_INCREMENT,
  `target_no` int NOT NULL,
  `eval_score1_1` int NOT NULL,
  `eval_score1_2` int NOT NULL,
  `eval_score1_3` int NOT NULL,
  `eval_score2_1` int NOT NULL,
  `eval_score2_2` int NOT NULL,
  `eval_score2_3` int NOT NULL,
  `eval_score3_1` int NOT NULL,
  `eval_score3_2` int NOT NULL,
  `eval_score3_3` int NOT NULL,
  `eval_image1` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `eval_image2` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `eval_image3` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `eval_score1_4` int NOT NULL,
  `eval_score2_4` int NOT NULL,
  `eval_score3_4` int NOT NULL,
  `interview_id1` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `interview_id2` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `interview_id3` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`eval_no`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation`
--

LOCK TABLES `evaluation` WRITE;
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` VALUES (21,40,5,5,5,6,6,6,7,7,7,'C:\\u\\pic\\김태식_test1.png','C:\\u\\pic\\김태식_test2.png','C:\\u\\pic\\김태식_test3.png',15,18,21,'test1','test2','test3'),(22,41,5,5,5,5,5,5,6,6,6,'C:\\u\\pic\\방승원_test1.png','C:\\u\\pic\\방승원_test2.png','C:\\u\\pic\\방승원_test3.png',15,15,18,'test1','test2','test3'),(23,42,8,7,6,5,6,7,3,8,2,'C:\\u\\pic\\김범진_test1.png','C:\\u\\pic\\김범진_test2.png','C:\\u\\pic\\김범진_test3.png',21,18,13,'test1','test2','test3'),(24,43,5,5,5,6,6,6,7,7,7,'C:\\u\\pic\\park_test1.png','C:\\u\\pic\\park_test2.png','C:\\u\\pic\\park_test3.png',15,18,21,'test1','test3','test4'),(28,47,6,5,5,6,6,6,7,7,7,'C:\\u\\pic\\송정현_test1.png','C:\\u\\pic\\송정현_test2.png','',15,18,21,'test1','test2','test4');
/*!40000 ALTER TABLE `evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interview`
--

DROP TABLE IF EXISTS `interview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interview` (
  `check_no` int NOT NULL AUTO_INCREMENT,
  `eval_no` int NOT NULL,
  `interview_id` varchar(150) NOT NULL,
  `check1` int NOT NULL DEFAULT '0',
  `check2` int NOT NULL DEFAULT '0',
  `check3` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`check_no`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interview`
--

LOCK TABLES `interview` WRITE;
/*!40000 ALTER TABLE `interview` DISABLE KEYS */;
INSERT INTO `interview` VALUES (40,21,'test1',1,1,0),(41,21,'test2',0,1,1),(42,21,'test3',0,0,0),(49,22,'test1',0,0,0),(50,22,'test2',0,0,0),(51,22,'test3',0,0,0),(52,23,'test1',1,0,0),(53,23,'test2',0,0,0),(54,23,'test3',0,0,0),(58,24,'test1',0,0,0),(59,24,'test3',0,0,0),(60,24,'test4',0,0,0),(70,28,'test1',1,0,0),(71,28,'test2',0,0,0),(72,28,'test4',0,0,0);
/*!40000 ALTER TABLE `interview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target` (
  `target_no` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dept` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `register` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`target_no`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target`
--

LOCK TABLES `target` WRITE;
/*!40000 ALTER TABLE `target` DISABLE KEYS */;
INSERT INTO `target` VALUES (40,'김태식','전산과','010-3333-3333','kim@naver.com','root'),(41,'방승원','웹개발부','01011111111','bang@naver.com','root'),(42,'김범진','ui/ux','01022222222','beom@naver.com','root'),(43,'park','전산과','010-1111-1111','park@gmail.com','root'),(47,'송정현','전산','010-6368-0793','thdwjdgus079@naver.com','ttt');
/*!40000 ALTER TABLE `target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_no` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_pw` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'root','1234','0:0:0:0:0:0:0:1',''),(9,'test1','1234','0:0:0:0:0:0:0:1',''),(10,'test2','1234','0:0:0:0:0:0:0:1',''),(11,'test3','1234','0:0:0:0:0:0:0:1',''),(12,'test4','1234','0:0:0:0:0:0:0:1','');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-19  4:57:02
