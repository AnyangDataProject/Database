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
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `damage_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `severity` enum('LOW','MEDIUM','HIGH') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('RECEIVED','AI_ANALYZED','CONFIRMED','IN_PROGRESS','COMPLETED','REJECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RECEIVED',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `inspection_cluster_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reports_user` (`user_id`),
  KEY `fk_reports_inspection_cluster` (`inspection_cluster_id`),
  CONSTRAINT `fk_reports_inspection_cluster` FOREIGN KEY (`inspection_cluster_id`) REFERENCES `inspection_clusters` (`id`),
  CONSTRAINT `fk_reports_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (18,1,'ㅇㅇ',37.5682000,126.9977000,'안양시 위치 확인 완료 (37.56820, 126.99770)','pothole','MEDIUM','IN_PROGRESS','2026-09-12 18:27:40','2026-09-12 19:46:28',NULL),(19,2,'ㄴㄴ',37.6174697,127.0207965,'안양시 위치 확인 완료 (37.61747, 127.02080)','sign','HIGH','RECEIVED','2026-09-14 11:26:55','2026-09-14 11:26:55',NULL),(21,2,'ㄴ',37.6174700,127.0207980,'안양시 위치 확인 완료 (37.40166, 126.97041)','crack','LOW','RECEIVED','2026-09-14 12:03:55','2026-09-14 12:03:55',NULL),(22,2,'ㄴㄴ',37.6172277,127.0208123,'안양시 위치 확인 완료 (37.39130, 126.95255)','pothole','LOW','RECEIVED','2026-09-14 12:12:11','2026-09-14 12:12:11',NULL),(23,2,'ㄴ',37.3913021,126.9525590,'37.3913020917335, 126.952559','pothole','LOW','RECEIVED','2026-09-14 12:20:24','2026-09-14 12:20:24',1),(24,2,'ㄴ',37.3913021,126.9525591,'37.3913020917335, 126.95255906460235','crack','MEDIUM','RECEIVED','2026-09-14 12:22:34','2026-09-14 12:22:34',1),(25,2,'ㄴ',37.3913021,126.9525590,'37.3913020917335, 126.952559','pothole','LOW','RECEIVED','2026-09-14 12:23:59','2026-09-14 12:23:59',1),(26,2,'ㄴㄴ',37.3913021,126.9525591,'37.3913020917335, 126.95255906460235','pothole','LOW','RECEIVED','2026-09-14 13:08:22','2026-09-14 13:08:22',1);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
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
