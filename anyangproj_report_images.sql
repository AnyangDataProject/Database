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
-- Table structure for table `report_images`
--

DROP TABLE IF EXISTS `report_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `report_id` bigint NOT NULL,
  `image_url` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_report_images_report` (`report_id`),
  CONSTRAINT `fk_report_images_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_images`
--

LOCK TABLES `report_images` WRITE;
/*!40000 ALTER TABLE `report_images` DISABLE KEYS */;
INSERT INTO `report_images` VALUES (20,18,'https://anyang-project-bucket.s3.amazonaws.com/d77444d3-47c1-4448-ae99-1de431882e8c.png','image/jpeg','2026-09-12 18:27:46'),(21,19,'https://anyang-project-bucket.s3.amazonaws.com/f3fab19f-5b7e-4712-b025-72ba2b54c6e1.png','image/jpeg','2026-09-14 11:26:58'),(23,21,'https://anyang-project-bucket.s3.amazonaws.com/d8ab090e-a4f1-4c62-a383-085bbe0ab0c5.png','image/jpeg','2026-09-14 12:03:57'),(24,22,'https://anyang-project-bucket.s3.amazonaws.com/db72e45b-d8df-4080-b2fe-3a4a5e28c03c.png','image/png','2026-09-14 12:12:13'),(25,23,'https://anyang-project-bucket.s3.amazonaws.com/1376c051-d844-41f0-8399-ec7ef05f7fa4.png','image/png','2026-09-14 12:20:25'),(26,24,'https://anyang-project-bucket.s3.amazonaws.com/71f10185-f203-45d4-ac04-56a1da0ec20d.png','image/jpeg','2026-09-14 12:22:36'),(27,25,'https://anyang-project-bucket.s3.amazonaws.com/d54babb6-6e3a-49aa-9e60-4180334747b3.png','image/png','2026-09-14 12:24:00'),(28,26,'https://anyang-project-bucket.s3.amazonaws.com/68dc0552-8fe7-4268-919c-581790c61b7c.png','image/png','2026-09-14 13:08:24');
/*!40000 ALTER TABLE `report_images` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-14 13:58:56
