-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `create_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'도구리','hello@naver.com',NULL,NULL,24,NULL,'user',NULL,NULL,100),
(2,NULL,'hello2@naver.com',NULL,NULL,16,NULL,'user',NULL,NULL,0),
(5,NULL,'abcd5@naver.com',NULL,NULL,30,NULL,'user',NULL,NULL,0),
(10,'김길동','9@mail.com',NULL,NULL,28,NULL,'admin',NULL,NULL,0),
(11,'james','11@mail.com',NULL,NULL,22,NULL,'user','1997-05-21',NULL,0),
(12,'tom','12@mail.com',NULL,NULL,20,NULL,'user',NULL,'2024-05-17 12:22:21',0),
(13,'초코','13@mail.com',NULL,NULL,19,NULL,'user',NULL,'2024-05-17 12:33:36',0),
(31,'김망고','abcd@naver.com',NULL,NULL,26,NULL,'user',NULL,NULL,0),
(52,'kim','kimm@naver.com',NULL,NULL,27,NULL,'user',NULL,'2024-05-20 15:37:29',0),
(53,'kim22','kimm222@naver.com',NULL,NULL,13,NULL,'user',NULL,'2024-05-20 15:38:23',0),
(54,'kim333','kimm333@naver.com',NULL,NULL,33,NULL,'user',NULL,'2024-05-20 15:39:23',0),
(55,'kim444','kimm444@naver.com',NULL,NULL,29,NULL,'user',NULL,'2024-05-20 15:40:05',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `create_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello',NULL,1,500.000,NULL,'046eed17-141f-11ef-8c3c-c8154ece55c1'),
(2,'hello',NULL,2,300.000,NULL,'046eedcb-141f-11ef-8c3c-c8154ece55c1'),
(3,'hello',NULL,NULL,5000.000,'2022-05-17 09:14:21','046eedf2-141f-11ef-8c3c-c8154ece55c1'),
(4,'hehe',NULL,1,8000.000,'2022-05-17 09:14:21','046eee13-141f-11ef-8c3c-c8154ece55c1'),
(5,'hello kaka',NULL,NULL,3000.000,'2023-05-17 16:15:00','046eee49-141f-11ef-8c3c-c8154ece55c1'),
(6,'immmmmmm titleeeeeeeee yeeee',NULL,31,1000.000,'2023-05-17 16:28:53','1cd71eb9-141f-11ef-8c3c-c8154ece55c1'),
(14,'hello world java',NULL,5,100.000,'2023-05-20 14:34:49','ae259a1e-166a-11ef-9fe3-c8154ece55c1'),
(15,'hello world java',NULL,5,2000.000,'2024-05-20 14:35:06','b866f757-166a-11ef-9fe3-c8154ece55c1'),
(16,'hello world java',NULL,5,3000.000,'2024-05-20 14:35:51','d32cba04-166a-11ef-9fe3-c8154ece55c1');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:27:24
