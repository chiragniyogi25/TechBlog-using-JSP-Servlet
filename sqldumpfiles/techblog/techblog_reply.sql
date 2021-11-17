CREATE DATABASE  IF NOT EXISTS `techblog` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `techblog`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: techblog
-- ------------------------------------------------------
-- Server version	5.7.31-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `r_post_id` int(11) NOT NULL,
  `r_comm_id` int(11) NOT NULL,
  `r_uid` int(11) NOT NULL,
  `r_comment` longtext,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`r_id`),
  KEY `r_post_id_idx` (`r_post_id`),
  KEY `comm_id_idx` (`r_comm_id`),
  KEY `r_uid_idx` (`r_uid`),
  CONSTRAINT `r_comm_id` FOREIGN KEY (`r_comm_id`) REFERENCES `comment` (`comment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_post_id` FOREIGN KEY (`r_post_id`) REFERENCES `posts` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_uid` FOREIGN KEY (`r_uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (1,5,1,6,'very nice','2021-11-15 22:17:57'),(2,5,1,6,'jhgfhjf','2021-11-16 00:02:31'),(3,5,1,6,'zfdgfsg','2021-11-16 02:30:47'),(4,5,1,4,'@Ila Niyogi true','2021-11-17 00:36:08'),(5,5,2,4,'yoyoyoy','2021-11-17 09:47:09'),(6,5,1,4,'@Ila Niyogi youi','2021-11-17 09:47:41'),(7,5,4,4,'doing good','2021-11-17 12:59:50'),(8,4,6,4,'bhai','2021-11-17 20:11:41');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-18  3:27:12
