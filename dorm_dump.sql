-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: dorm
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `answer_for_resettlement`
--

DROP TABLE IF EXISTS `answer_for_resettlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_for_resettlement` (
  `id` bigint NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `if_agree` bit(1) DEFAULT NULL,
  `is_answered` bit(1) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `who_want` varchar(255) DEFAULT NULL,
  `application_for_resettlement_with_answer_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKosc3g1ixtlc83dyqhvaje6ky8` (`application_for_resettlement_with_answer_id`),
  CONSTRAINT `FKosc3g1ixtlc83dyqhvaje6ky8` FOREIGN KEY (`application_for_resettlement_with_answer_id`) REFERENCES `resettlement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_for_resettlement`
--

LOCK TABLES `answer_for_resettlement` WRITE;
/*!40000 ALTER TABLE `answer_for_resettlement` DISABLE KEYS */;
INSERT INTO `answer_for_resettlement` VALUES (2,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL),(53,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL),(103,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL),(153,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL),(155,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL),(157,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL),(203,'ок',_binary '\0',_binary '\0',NULL,'Иван Иванович Иванов1',NULL);
/*!40000 ALTER TABLE `answer_for_resettlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_for_resettlement_seq`
--

DROP TABLE IF EXISTS `answer_for_resettlement_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_for_resettlement_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_for_resettlement_seq`
--

LOCK TABLES `answer_for_resettlement_seq` WRITE;
/*!40000 ALTER TABLE `answer_for_resettlement_seq` DISABLE KEYS */;
INSERT INTO `answer_for_resettlement_seq` VALUES (301);
/*!40000 ALTER TABLE `answer_for_resettlement_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_for_repair`
--

DROP TABLE IF EXISTS `application_for_repair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_for_repair` (
  `id` bigint NOT NULL,
  `fio` varchar(255) DEFAULT NULL,
  `user_done` bit(1) DEFAULT NULL,
  `worker_done` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `number_of_room_for_resettlement` varchar(255) DEFAULT NULL,
  `specialization` tinyint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKr2wid1nco6f8qvx1yt298wr21` (`user_id`),
  CONSTRAINT `FKr2wid1nco6f8qvx1yt298wr21` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `application_for_repair_chk_1` CHECK ((`specialization` between 0 and 2)),
  CONSTRAINT `application_for_repair_chk_2` CHECK ((`status` between 0 and 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_for_repair`
--

LOCK TABLES `application_for_repair` WRITE;
/*!40000 ALTER TABLE `application_for_repair` DISABLE KEYS */;
INSERT INTO `application_for_repair` VALUES (652,'Иван Иванович Иванов1',_binary '\0',_binary '\0','w','2',2,9,_binary '',0);
/*!40000 ALTER TABLE `application_for_repair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_for_repair_seq`
--

DROP TABLE IF EXISTS `application_for_repair_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_for_repair_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_for_repair_seq`
--

LOCK TABLES `application_for_repair_seq` WRITE;
/*!40000 ALTER TABLE `application_for_repair_seq` DISABLE KEYS */;
INSERT INTO `application_for_repair_seq` VALUES (751);
/*!40000 ALTER TABLE `application_for_repair_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resettlement`
--

DROP TABLE IF EXISTS `resettlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resettlement` (
  `id` bigint NOT NULL,
  `status` tinyint DEFAULT NULL,
  `is_apply` bit(1) DEFAULT NULL,
  `number_of_room_for_resettlement` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `resettlement_chk_1` CHECK ((`status` between 0 and 2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resettlement`
--

LOCK TABLES `resettlement` WRITE;
/*!40000 ALTER TABLE `resettlement` DISABLE KEYS */;
INSERT INTO `resettlement` VALUES (1,2,_binary '\0','2',''),(2,2,_binary '\0','1','oiutr'),(52,2,_binary '\0','2','надоел сосед'),(102,2,_binary '\0','2','kjenf'),(103,2,_binary '\0','2','личная'),(104,2,_binary '\0','1','кдшпо'),(152,2,_binary '\0','2','FWAE');
/*!40000 ALTER TABLE `resettlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resettlement_seq`
--

DROP TABLE IF EXISTS `resettlement_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resettlement_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resettlement_seq`
--

LOCK TABLES `resettlement_seq` WRITE;
/*!40000 ALTER TABLE `resettlement_seq` DISABLE KEYS */;
INSERT INTO `resettlement_seq` VALUES (251);
/*!40000 ALTER TABLE `resettlement_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` bigint NOT NULL,
  `conditions` varchar(255) DEFAULT NULL,
  `number_of_available_seats` int DEFAULT NULL,
  `number_of_room` varchar(255) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_of_room_UNIQUE` (`number_of_room`),
  CONSTRAINT `rooms_chk_1` CHECK ((`type` between 0 and 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'хорошо',5,'1',3000,0),(2,'хорошо',3,'2',4000,0),(152,'хорошо',5,'3',5000,1),(202,';KMWT4\'L',5,'4',12457,1);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms_seq`
--

DROP TABLE IF EXISTS `rooms_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_seq`
--

LOCK TABLES `rooms_seq` WRITE;
/*!40000 ALTER TABLE `rooms_seq` DISABLE KEYS */;
INSERT INTO `rooms_seq` VALUES (301);
/*!40000 ALTER TABLE `rooms_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_id` bigint NOT NULL,
  `roles` enum('ROLE_USER','ROLE_ADMIN','ROLE_WORKER') DEFAULT NULL,
  KEY `FKj345gk1bovqvfame88rcx7yyx` (`user_id`),
  CONSTRAINT `FKj345gk1bovqvfame88rcx7yyx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'ROLE_ADMIN'),(3,'ROLE_WORKER'),(4,'ROLE_WORKER'),(5,'ROLE_WORKER'),(6,'ROLE_USER'),(9,'ROLE_USER');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fio` varchar(255) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `is_answer` bit(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` tinyint DEFAULT NULL,
  `specialization` tinyint DEFAULT NULL,
  `answer_for_resettlement_id` bigint DEFAULT NULL,
  `application_for_resettlement_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`),
  KEY `FKlrksemiw6ourpxhkcri6j57c5` (`answer_for_resettlement_id`),
  KEY `FKn0ge91spycqxxk5op2236p27b` (`application_for_resettlement_id`),
  KEY `FKlp7mqwp35k0xb2vyjw7rsi9gb` (`room_id`),
  CONSTRAINT `FKlp7mqwp35k0xb2vyjw7rsi9gb` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  CONSTRAINT `FKlrksemiw6ourpxhkcri6j57c5` FOREIGN KEY (`answer_for_resettlement_id`) REFERENCES `answer_for_resettlement` (`id`),
  CONSTRAINT `FKn0ge91spycqxxk5op2236p27b` FOREIGN KEY (`application_for_resettlement_id`) REFERENCES `resettlement` (`id`),
  CONSTRAINT `users_chk_1` CHECK ((`sex` between 0 and 1)),
  CONSTRAINT `users_chk_2` CHECK ((`specialization` between 0 and 2))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Иван Иванович Иванов',_binary '','','ivan@mail.ru',_binary '\0','$2a$08$kr59TBjQbMJtKtq.WoTu0uVZVlbmTm.gcNez8zOMj2TcyP9WYRkFC',0,NULL,NULL,NULL,NULL),(3,'Егор Артёмович Мельников',_binary '','','egor@mail.ru',_binary '\0','$2a$08$XnBsAp2ZtpZ2FPuA2F7Rb.RympYiDDfMyJD3YE9fnERc8/UrhY6cu',0,2,NULL,NULL,NULL),(4,'Максим Максимович Кудряшов',_binary '','','maxim@mail.ru',_binary '\0','$2a$08$B/MRkeM191JBzCkaGEA4huSFaB9DrHOlQWks6zHEzrLJrA8n7eRpu',0,0,NULL,NULL,NULL),(5,'Лев Александрович Уткин',_binary '','','lev@mail.ru',_binary '\0','$2a$08$l/BLfAmt25PF9UorIa0pbeqtGo4DP8LbwDTL6JTadUia8oLjcdTHK',0,1,NULL,NULL,NULL),(6,'Иван Иванович Иванов2',_binary '','ок','ivan2@mail.ru',_binary '','$2a$08$ZAh6z5N0j7Qg.I2vq7QLWuI09qIeuz2V1gTdu3iI12pE0DoG2E2IK',0,NULL,NULL,NULL,2),(9,'Иван Иванович Иванов1',_binary '','ок','ivan1@mail.ru',_binary '\0','$2a$08$fHwAWo1XiwJqAhGTKi7x/umCVtLVrbXHNj/wZjH2o.Dz2Wh.xTCY6',0,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-03 19:02:24
