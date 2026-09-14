-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: anyangproj
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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('CITIZEN','ADMIN') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CITIZEN',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'sally20114@gmail.com','$2a$10$F6A8/lbissBuikoUMqRRHejxWvq7icY1HYKYWtPgjBBkHOtykJ7oy','사용자','010-1231-123','CITIZEN','2026-09-12 14:20:33','LOCAL',NULL,'SUSPENDED'),(2,'leenayeon0915@gmail.com','$2a$10$wQPs2vHDG5sQi.yKOf6MXu1luDGaOWCXylsTila0wpoGea0RwmaB.','관리자','010-1231-123','ADMIN','2026-09-12 19:25:00','LOCAL','2026-09-14 00:36:13','ACTIVE'),(3,'g@gmail.com','$2a$10$W3AvKw0gE.tpRaf7FAA0Eejn1LfWtQzYBP5zc3Evi9HVXwa7ifYYG','ㅎ','010-1231-123','CITIZEN','2026-09-13 14:04:50','LOCAL','2026-09-13 14:05:25','ACTIVE'),(4,'a@a','$2a$10$YDNrQrwc9Qn5q51/Vujhhuo6q7wFbEqZxFpp6LByMXLa7RzK/H5RS','ㅁ','010-3034-0595','CITIZEN','2026-09-13 14:06:46','LOCAL','2026-09-13 14:06:51','ACTIVE'),(5,'a@aa','$2a$10$4MbAzv6hIKkNTW2i8dt55e8krAyQ2N2pU0WFke7rjIHNwJqko4hve','ㅁ','010-1231-123','CITIZEN','2026-09-13 14:15:41','LOCAL','2026-09-13 14:15:51','ACTIVE');
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

-- Dump completed on 2026-09-14 13:58:57
