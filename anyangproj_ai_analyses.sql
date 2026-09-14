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
-- Table structure for table `ai_analyses`
--

DROP TABLE IF EXISTS `ai_analyses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_analyses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `report_id` bigint NOT NULL,
  `model_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result_image_url` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `analyzed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `report_image_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ai_analyses_report` (`report_id`),
  KEY `fk_ai_analysis_report_image` (`report_image_id`),
  CONSTRAINT `fk_ai_analyses_report` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ai_analysis_report_image` FOREIGN KEY (`report_image_id`) REFERENCES `report_images` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_analyses`
--

LOCK TABLES `ai_analyses` WRITE;
/*!40000 ALTER TABLE `ai_analyses` DISABLE KEYS */;
INSERT INTO `ai_analyses` VALUES (18,18,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/aa32c94a-e333-4ce1-a491-716a9610c0b2.jpg','2026-09-12 18:27:50',20),(19,21,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/c4ecdda4-bd3a-45e5-8d74-7e41213b2351.jpg','2026-09-14 12:04:05',23),(20,22,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/e34457cd-cdd9-41ed-a233-c5d9a7010f34.jpg','2026-09-14 12:12:16',24),(21,23,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/7e05fae8-bc6d-4b4b-85d0-1ccb3598c956.jpg','2026-09-14 12:20:26',25),(22,24,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/00df8f2f-fa6e-4fb8-a9ab-d6644f7cccf5.jpg','2026-09-14 12:22:36',26),(23,25,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/1fb50c60-0cb3-4498-950b-3392cf2f8976.jpg','2026-09-14 12:24:01',27),(24,26,'yolov8s','rdd2022','https://anyang-project-bucket.s3.amazonaws.com/6cbc6326-ae4d-4091-9462-e26c0decc641.jpg','2026-09-14 13:08:25',28);
/*!40000 ALTER TABLE `ai_analyses` ENABLE KEYS */;
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
