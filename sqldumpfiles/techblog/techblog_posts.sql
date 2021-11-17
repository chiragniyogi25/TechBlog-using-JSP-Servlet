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
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `pid` int(12) NOT NULL AUTO_INCREMENT,
  `pTitle` varchar(150) NOT NULL,
  `pContent` longtext,
  `pCode` longtext,
  `pPic` varchar(100) DEFAULT NULL,
  `pDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `plink` longtext,
  `catId` int(12) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `catId_idx` (`catId`),
  KEY `userId_idx` (`userId`),
  CONSTRAINT `catId` FOREIGN KEY (`catId`) REFERENCES `categories` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'Exception Handling','The Exception Handling in Java is one of the powerful mechanism to handle the runtime errors so that the normal flow of the application can be maintained.','public class JavaExceptionExample{  \r\n  public static void main(String args[]){  \r\n   try{  \r\n      //code that may raise exception  \r\n      int data=100/0;  \r\n   }catch(ArithmeticException e){System.out.println(e);}  \r\n   //rest code of the program   \r\n   System.out.println(\"rest of the code...\");  \r\n  }  \r\n}  ','hmtmilan.jpg','2021-10-28 08:36:32','https://www.javatpoint.com/exception-handling-in-java,https://www.geeksforgeeks.org/exceptions-in-java/',1,2),(2,'Fetch Api','The Fetch API provides a JavaScript interface for accessing and manipulating parts of the HTTP pipeline, such as requests and responses. It also provides a global fetch() method that provides an easy, logical way to fetch resources asynchronously across the network.\r\n\r\nThis kind of functionality was previously achieved using XMLHttpRequest. Fetch provides a better alternative that can be easily used by other technologies such as Service Workers. Fetch also provides a single logical place to define other HTTP-related concepts such as CORS and extensions to HTTP.','// Example POST method implementation:\r\nasync function postData(url = \'\', data = {}) {\r\n  // Default options are marked with *\r\n  const response = await fetch(url, {\r\n    method: \'POST\', // *GET, POST, PUT, DELETE, etc.\r\n    mode: \'cors\', // no-cors, *cors, same-origin\r\n    cache: \'no-cache\', // *default, no-cache, reload, force-cache, only-if-cached\r\n    credentials: \'same-origin\', // include, *same-origin, omit\r\n    headers: {\r\n      \'Content-Type\': \'application/json\'\r\n      // \'Content-Type\': \'application/x-www-form-urlencoded\',\r\n    },\r\n    redirect: \'follow\', // manual, *follow, error\r\n    referrerPolicy: \'no-referrer\', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url\r\n    body: JSON.stringify(data) // body data type must match \"Content-Type\" header\r\n  });\r\n  return response.json(); // parses JSON response into native JavaScript objects\r\n}\r\n\r\npostData(\'https://example.com/answer\', { answer: 42 })\r\n  .then(data => {\r\n    console.log(data); // JSON data parsed by `data.json()` call\r\n  });\r\n','johnzok.jpg','2021-10-28 08:59:28','https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch',2,2),(3,'What is python','Python is a popular programming language.\r\n\r\nPython can be used on a server to create web applications.','print(\"Hello, World!\")','H&W.jpg','2021-10-28 09:05:38','https://www.w3schools.com/python/',3,6),(4,'StringBuffer','Java StringBuffer class is used to create mutable (modifiable) String objects. The StringBuffer class in Java is the same as String class except it is mutable i.e. it can be changed.','class StringBufferExample{  \r\n   public static void main(String args[]){  \r\n   StringBuffer sb=new StringBuffer(\"Hello \");  \r\n   sb.append(\"Java\");//now original string is changed  \r\n   System.out.println(sb);//prints Hello Java  \r\n }  \r\n}  ','Cannon EOS.jpg','2021-10-28 18:35:30','https://www.javatpoint.com/StringBuffer-class',1,4),(5,'String','String is used to stored string','String str =\"Chirag\";','background1.jpeg','2021-10-31 21:58:54','www.javatpoint.com',1,6);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
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
