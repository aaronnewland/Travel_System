CREATE DATABASE  IF NOT EXISTS `travel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `travel`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: travel
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `Aircrafts`
--

DROP TABLE IF EXISTS `Aircrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aircrafts` (
  `aircraft_id` int NOT NULL,
  `num_seats` int DEFAULT NULL,
  `airline_id` char(2) NOT NULL,
  PRIMARY KEY (`aircraft_id`,`airline_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `aircrafts_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `Airline` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aircrafts`
--

LOCK TABLES `Aircrafts` WRITE;
/*!40000 ALTER TABLE `Aircrafts` DISABLE KEYS */;
INSERT INTO `Aircrafts` VALUES (1,3,'AL'),(1,100,'SW'),(2,100,'AL'),(2,19,'UA'),(35,120,'AA'),(35,100,'SW'),(45,100,'JB'),(45,95,'SW'),(45,100,'UA'),(59,100,'JB'),(59,11,'SA'),(59,100,'SW'),(134,100,'AL'),(285,100,'AA'),(300,3000,'bc'),(300,3000,'de'),(300,100,'SA'),(300,100,'UA'),(321,100,'JB'),(357,100,'UA'),(452,100,'SW'),(478,100,'AA'),(567,100,'SA'),(690,100,'JB'),(719,100,'AL'),(786,100,'UA'),(812,100,'SW'),(872,100,'SA'),(873,100,'AL'),(954,100,'AA'),(954,100,'AL'),(954,250,'JB'),(9999,4000,'ab'),(9999,100,'SA');
/*!40000 ALTER TABLE `Aircrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Airline`
--

DROP TABLE IF EXISTS `Airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airline` (
  `id` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airline`
--

LOCK TABLES `Airline` WRITE;
/*!40000 ALTER TABLE `Airline` DISABLE KEYS */;
INSERT INTO `Airline` VALUES ('AA'),('ab'),('AL'),('bc'),('de'),('JB'),('SA'),('SW'),('UA');
/*!40000 ALTER TABLE `Airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Airport`
--

DROP TABLE IF EXISTS `Airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airport` (
  `ID` varchar(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airport`
--

LOCK TABLES `Airport` WRITE;
/*!40000 ALTER TABLE `Airport` DISABLE KEYS */;
INSERT INTO `Airport` VALUES ('ewr'),('jfk'),('lax'),('lga'),('LHR'),('mia'),('phl'),('sfo'),('XHO');
/*!40000 ALTER TABLE `Airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `associated`
--

DROP TABLE IF EXISTS `associated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `associated` (
  `airport_id` varchar(3) NOT NULL,
  `airline_id` varchar(2) NOT NULL,
  PRIMARY KEY (`airport_id`,`airline_id`),
  KEY `airline_id` (`airline_id`),
  CONSTRAINT `associated_ibfk_1` FOREIGN KEY (`airport_id`) REFERENCES `airport` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `associated_ibfk_2` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `associated`
--

LOCK TABLES `associated` WRITE;
/*!40000 ALTER TABLE `associated` DISABLE KEYS */;
INSERT INTO `associated` VALUES ('ewr','AA'),('jfk','AA'),('lax','AA'),('lga','AA'),('mia','AA'),('phl','AA'),('sfo','AA'),('ewr','AL'),('jfk','AL'),('lax','AL'),('lga','AL'),('mia','AL'),('phl','AL'),('sfo','AL'),('ewr','JB'),('jfk','JB'),('lax','JB'),('lga','JB'),('mia','JB'),('phl','JB'),('sfo','JB'),('ewr','SA'),('jfk','SA'),('lax','SA'),('lga','SA'),('mia','SA'),('phl','SA'),('sfo','SA'),('ewr','SW'),('jfk','SW'),('lax','SW'),('lga','SW'),('mia','SW'),('phl','SW'),('sfo','SW'),('ewr','UA'),('jfk','UA'),('lax','UA'),('lga','UA'),('mia','UA'),('phl','UA'),('sfo','UA');
/*!40000 ALTER TABLE `associated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_first_ticket`
--

DROP TABLE IF EXISTS `business_first_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_first_ticket` (
  `ticket_number` int NOT NULL,
  `total_fare` float NOT NULL,
  `seat_number` int NOT NULL,
  `booking_fee` float NOT NULL,
  `purchase_date` datetime NOT NULL,
  `cust_id` int NOT NULL,
  `is_first` tinyint(1) NOT NULL,
  `is_economy` tinyint(1) NOT NULL,
  PRIMARY KEY (`ticket_number`,`cust_id`),
  KEY `business_first_ticket_ibfk_1` (`cust_id`),
  CONSTRAINT `business_first_ticket_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `business_fk` FOREIGN KEY (`ticket_number`, `cust_id`) REFERENCES `ticketed_flights` (`ticket_number`, `cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_first_ticket`
--

LOCK TABLES `business_first_ticket` WRITE;
/*!40000 ALTER TABLE `business_first_ticket` DISABLE KEYS */;
INSERT INTO `business_first_ticket` VALUES (22,359.5,3,24.4,'2023-12-20 00:00:00',1,1,0),(23,759.5,3,11.4,'2023-12-10 00:00:00',2,1,0),(24,259.5,3,29.4,'2023-12-15 00:00:00',3,0,0);
/*!40000 ALTER TABLE `business_first_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Billy','Johnson','M','bob'),(2,'Mike','Michaels','M',NULL),(3,'Steve','Stevenson','M',NULL),(4,'Tom','Thompson','M',NULL),(5,'Phil','Phillips','M',NULL),(6,'Paul','Paulerson','J',NULL),(7,'Ringo','Ringoson','M',NULL),(103,'a','b','',NULL),(105,'e','g','f',NULL),(106,'a','c','b',NULL),(107,'a','c','b',NULL),(108,'a','c','b',NULL),(109,'a','c','b',NULL),(111,'a','c','b',NULL),(112,NULL,NULL,NULL,NULL),(113,'a','c','b',NULL),(114,'John','Smith','J',NULL),(115,'jon','stevenson','b',NULL),(116,'steve','smith','m',NULL),(117,'John','Targ','M',NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `economy_ticket`
--

DROP TABLE IF EXISTS `economy_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `economy_ticket` (
  `ticket_number` int NOT NULL,
  `total_fare` float NOT NULL,
  `seat_number` int NOT NULL,
  `booking_fee` float NOT NULL,
  `purchase_date` date NOT NULL,
  `purchase_time` time NOT NULL,
  `cust_id` int NOT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `is_economy` tinyint(1) NOT NULL,
  PRIMARY KEY (`ticket_number`,`cust_id`),
  KEY `economy_ticket_ibfk_1` (`cust_id`),
  CONSTRAINT `economy_fk` FOREIGN KEY (`ticket_number`, `cust_id`) REFERENCES `ticketed_flights` (`ticket_number`, `cust_id`),
  CONSTRAINT `economy_ticket_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `economy_ticket`
--

LOCK TABLES `economy_ticket` WRITE;
/*!40000 ALTER TABLE `economy_ticket` DISABLE KEYS */;
INSERT INTO `economy_ticket` VALUES (25,159.5,3,24.4,'2023-12-20','15:02:11',4,1,1),(26,259.5,3,11.4,'2023-12-10','09:02:11',5,1,1),(27,359.5,3,29.4,'2023-12-15','14:02:11',6,0,1);
/*!40000 ALTER TABLE `economy_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FAQ`
--

DROP TABLE IF EXISTS `FAQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FAQ` (
  `qid` int NOT NULL AUTO_INCREMENT,
  `question` text,
  `answer` text,
  PRIMARY KEY (`qid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FAQ`
--

LOCK TABLES `FAQ` WRITE;
/*!40000 ALTER TABLE `FAQ` DISABLE KEYS */;
INSERT INTO `FAQ` VALUES (1,'apple25apple25','apple25apple25'),(2,'test',NULL),(3,'test',NULL),(4,'test',NULL),(5,'testpost',NULL),(6,'testpost','akjfhskahf'),(7,'testpost',NULL),(8,'testpost','akjfhskahf'),(9,'testpost',NULL),(10,'test',NULL),(11,NULL,NULL);
/*!40000 ALTER TABLE `FAQ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `airline_id` varchar(50) NOT NULL,
  `aircraft_id` int NOT NULL,
  `f_id` int NOT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `departure_apt` varchar(3) DEFAULT NULL,
  `arrival_apt` varchar(3) DEFAULT NULL,
  `day_of_week` varchar(9) DEFAULT NULL,
  `is_international` tinyint(1) DEFAULT NULL,
  `fare` float DEFAULT NULL,
  `booking_fee` float DEFAULT NULL,
  `duration` time GENERATED ALWAYS AS (timediff(cast(`arrival_time` as time),cast(`departure_time` as time))) VIRTUAL,
  `duration_minutes` int GENERATED ALWAYS AS (coalesce(timestampdiff(MINUTE,`departure_time`,`arrival_time`),0)) VIRTUAL,
  PRIMARY KEY (`airline_id`,`aircraft_id`,`f_id`),
  UNIQUE KEY `idx_flight_airline_id_aircraft_id_f_id` (`airline_id`,`aircraft_id`,`f_id`) COMMENT 'test, foreign key constraint for wl',
  KEY `idx_flight_reference` (`f_id`,`aircraft_id`,`airline_id`),
  KEY `flight_ibfk_2` (`aircraft_id`),
  CONSTRAINT `fk_flight_aircraft` FOREIGN KEY (`airline_id`, `aircraft_id`) REFERENCES `aircrafts` (`airline_id`, `aircraft_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` (`airline_id`, `aircraft_id`, `f_id`, `departure_time`, `arrival_time`, `departure_apt`, `arrival_apt`, `day_of_week`, `is_international`, `fare`, `booking_fee`) VALUES ('AA',35,3,'2023-12-15 23:59:59','2023-12-15 23:59:59','jfk','lhr','Monday',1,100,50),('AA',35,8,'2023-12-31 23:59:59','2023-12-31 23:59:59','ewr','sfo','Monday',0,100,50),('AA',35,10,NULL,NULL,'lax','jfk',NULL,NULL,100,50),('AA',35,44,'2023-01-01 08:00:00','2023-01-01 11:00:00','JFK','LAX','Monday',0,150,20),('AA',35,45,'2023-01-02 09:00:00','2023-01-02 12:00:00','LAX','JFK','Tuesday',0,160,20),('AA',35,52,'2023-01-06 09:00:00','2023-01-06 12:00:00','LAX','EWR','Friday',1,200,30),('AA',35,1001,'2023-12-20 08:00:00','2023-12-20 10:00:00','LAX','SFO','Wednesday',0,180,30),('AA',35,1002,'2023-12-21 09:00:00','2023-12-21 11:00:00','JFK','MIA','Thursday',0,200,35),('AA',35,1020,'2023-12-30 07:00:00','2023-12-30 09:00:00','SFO','LAX','Friday',0,190,25),('AA',285,1008,'2023-12-27 15:00:00','2023-12-27 17:00:00','SFO','JFK','Wednesday',1,230,35),('AA',285,1014,'2024-01-02 21:00:00','2024-01-02 23:00:00','LAX','SFO','Tuesday',1,250,37),('AA',285,1020,'2024-01-08 04:00:00','2024-01-08 06:00:00','SFO','LAX','Monday',1,240,38),('AL',1,1,'2023-12-10 06:59:59','2023-12-10 15:59:59','ewr','lax','Monday',0,200,50),('AL',1,7,'2023-12-30 23:59:59','2023-12-30 23:59:59','mia','XHO','Monday',1,100,50),('AL',1,11,NULL,NULL,'mia','lax',NULL,NULL,100,50),('AL',1,12,'2023-12-12 04:59:48','2023-12-12 07:00:00','ewr','lax',NULL,NULL,NULL,NULL),('AL',1,47,'2023-01-01 07:00:00','2023-01-01 09:30:00','JFK','MIA','Monday',0,120,15),('AL',1,53,'2023-01-07 08:00:00','2023-01-07 11:00:00','EWR','LAX','Saturday',1,210,30),('AL',1,87,'2023-12-12 17:00:00','2023-12-12 19:00:00','lax','ewr','Friday',0,200,30),('AL',1,1009,'2023-12-28 16:00:00','2023-12-28 18:00:00','MIA','LAX','Thursday',0,180,28),('AL',1,1015,'2024-01-03 22:00:00','2024-01-03 00:00:00','MIA','JFK','Wednesday',0,190,29),('JB',321,1010,'2023-12-29 17:00:00','2023-12-29 19:30:00','JFK','SFO','Friday',0,260,42),('JB',321,1016,'2024-01-04 23:00:00','2024-01-05 01:30:00','SFO','LAX','Thursday',0,270,43),('JB',954,6,'2023-12-24 23:59:59','2023-12-24 23:59:59','sfo','phl','Monday',0,100,50),('JB',954,48,'2023-01-04 12:00:00','2023-01-04 15:00:00','SFO','PHL','Thursday',0,180,25),('JB',954,1004,'2023-12-23 11:00:00','2023-12-23 13:30:00','LAX','JFK','Saturday',1,250,40),('SA',59,5,'2023-12-22 23:59:59','2023-12-22 23:59:59','sfo','lax','Monday',0,100,50),('SA',59,49,'2023-01-02 06:00:00','2023-01-02 08:00:00','PHL','SFO','Tuesday',0,140,20),('SA',59,1007,'2023-12-26 14:00:00','2023-12-26 16:00:00','LAX','MIA','Tuesday',0,210,33),('SA',59,1013,'2024-01-01 20:00:00','2024-01-01 22:00:00','JFK','LAX','Monday',0,220,32),('SA',59,1019,'2024-01-07 03:00:00','2024-01-07 05:00:00','MIA','JFK','Sunday',0,230,33),('SW',45,4,'2023-12-19 23:59:59','2023-12-19 23:59:59','ewr','mia','Friday',0,100,50),('SW',45,50,'2023-01-05 14:00:00','2023-01-05 17:00:00','EWR','MIA','Friday',0,170,25),('SW',45,1006,'2023-12-25 13:00:00','2023-12-25 15:00:00','JFK','SFO','Monday',0,190,25),('SW',45,1012,'2023-12-31 19:00:00','2023-12-31 21:00:00','SFO','MIA','Sunday',0,200,30),('SW',45,1018,'2024-01-06 02:00:00','2024-01-06 04:00:00','LAX','SFO','Saturday',0,210,31),('UA',2,2,'2023-12-12 14:59:59','2023-12-12 17:59:59','lax','ewr','Wednesday',0,100,50),('UA',2,9,NULL,NULL,'sfo','jfk',NULL,NULL,100,50),('UA',2,46,'2023-01-03 10:00:00','2023-01-03 13:30:00','MIA','JFK','Wednesday',0,130,15),('UA',2,51,'2023-01-03 15:00:00','2023-01-03 18:00:00','MIA','EWR','Wednesday',0,160,20),('UA',2,1005,'2023-12-24 12:00:00','2023-12-24 14:00:00','MIA','LAX','Sunday',0,220,30),('UA',2,1011,'2023-12-30 18:00:00','2023-12-30 20:00:00','LAX','JFK','Saturday',0,240,36),('UA',2,1017,'2024-01-05 01:00:00','2024-01-05 03:00:00','JFK','MIA','Friday',0,230,34),('UA',45,53,'2023-12-15 21:59:59','2023-12-15 22:59:59','jfk','lhr','Monday',1,150,NULL);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itinerary`
--

DROP TABLE IF EXISTS `itinerary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itinerary` (
  `ite_id` varchar(50) DEFAULT NULL,
  `f_id` int DEFAULT NULL,
  `aircraft_id` int DEFAULT NULL,
  `airline_id` varchar(50) DEFAULT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `duration` time GENERATED ALWAYS AS (timediff(cast(`arrival_time` as time),cast(`departure_time` as time))) VIRTUAL,
  `cost` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itinerary`
--

LOCK TABLES `itinerary` WRITE;
/*!40000 ALTER TABLE `itinerary` DISABLE KEYS */;
/*!40000 ALTER TABLE `itinerary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolio`
--

DROP TABLE IF EXISTS `portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `portfolio` (
  `cust_id` int NOT NULL,
  `f_id` int NOT NULL,
  `aircraft_id` int NOT NULL,
  `airline_id` varchar(50) NOT NULL,
  PRIMARY KEY (`cust_id`,`f_id`,`aircraft_id`,`airline_id`),
  KEY `portfolio_ibfk_2` (`f_id`,`aircraft_id`,`airline_id`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `portfolio_ibfk_2` FOREIGN KEY (`f_id`, `aircraft_id`, `airline_id`) REFERENCES `flight` (`f_id`, `aircraft_id`, `airline_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio`
--

LOCK TABLES `portfolio` WRITE;
/*!40000 ALTER TABLE `portfolio` DISABLE KEYS */;
/*!40000 ALTER TABLE `portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticketed_flights`
--

DROP TABLE IF EXISTS `ticketed_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticketed_flights` (
  `ticket_number` int NOT NULL,
  `f_id` int NOT NULL,
  `cust_id` int NOT NULL,
  `aircraft_id` int NOT NULL,
  `airline_id` varchar(50) NOT NULL,
  `purchase_date` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_number`,`f_id`,`aircraft_id`,`airline_id`,`cust_id`),
  KEY `ticket_flights_ibfk_1` (`f_id`,`aircraft_id`,`airline_id`),
  KEY `FK_ticket_cust` (`cust_id`),
  KEY `idx_ticket_cust` (`ticket_number`,`cust_id`),
  CONSTRAINT `FK_ticket_cust` FOREIGN KEY (`cust_id`) REFERENCES `Customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticketed_flights_ibfk_1` FOREIGN KEY (`f_id`, `aircraft_id`, `airline_id`) REFERENCES `flight` (`f_id`, `aircraft_id`, `airline_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketed_flights`
--

LOCK TABLES `ticketed_flights` WRITE;
/*!40000 ALTER TABLE `ticketed_flights` DISABLE KEYS */;
INSERT INTO `ticketed_flights` VALUES (22,3,1,35,'AA','2023-12-12 22:39:31'),(23,2,2,2,'UA','2023-12-12 22:39:31'),(24,1,3,1,'AL','2023-12-12 22:39:31'),(25,4,4,45,'SW','2023-12-12 22:39:31'),(26,5,5,59,'SA','2023-12-12 22:39:31'),(27,6,6,954,'JB','2023-12-12 22:39:31'),(28,1,1,1,'AL','2023-12-12 22:39:31'),(1001,3,1,35,'AA','2023-12-17 00:00:00'),(1002,2,2,2,'UA','2023-12-18 00:00:00'),(1003,1,3,1,'AL','2023-12-19 00:00:00'),(1004,4,4,45,'SW','2023-12-20 00:00:00'),(1005,5,5,59,'SA','2023-12-21 00:00:00'),(10021,8,2,35,'AA','2023-12-16 00:00:00'),(10031,10,3,35,'AA','2023-12-17 00:00:00'),(10041,44,4,35,'AA','2023-12-18 00:00:00'),(10051,45,5,35,'AA','2023-12-19 00:00:00'),(10061,52,6,35,'AA','2023-12-20 00:00:00'),(10071,1001,1,35,'AA','2023-12-21 00:00:00'),(10081,1002,2,35,'AA','2023-12-22 00:00:00'),(10091,1020,3,35,'AA','2023-12-23 00:00:00'),(10101,1008,4,285,'AA','2023-12-24 00:00:00'),(10111,3,1,35,'AA','2023-12-15 00:00:00'),(10111,1014,5,285,'AA','2023-12-25 00:00:00'),(10121,1020,6,285,'AA','2023-12-26 00:00:00'),(10131,1,1,1,'AL','2023-12-27 00:00:00'),(10141,7,2,1,'AL','2023-12-28 00:00:00'),(10151,11,3,1,'AL','2023-12-29 00:00:00'),(10161,47,4,1,'AL','2023-12-30 00:00:00'),(10171,53,5,1,'AL','2023-12-31 00:00:00'),(10181,87,6,1,'AL','2024-01-01 00:00:00'),(10191,1009,1,1,'AL','2024-01-02 00:00:00'),(10201,1015,2,1,'AL','2024-01-03 00:00:00');
/*!40000 ALTER TABLE `ticketed_flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `access` enum('admin','user','rep') NOT NULL,
  `fName` varchar(50) DEFAULT NULL,
  `mName` varchar(50) DEFAULT NULL,
  `lName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('alice','alicepassword','rep','alice','in','chains'),('bob','bobpassword','user',NULL,NULL,NULL),('Paul','paulpassword','admin',NULL,NULL,NULL),('John','johnpassword','admin',NULL,NULL,NULL),('George','georgepassword','admin',NULL,NULL,NULL),('Ringo','ringopassword','admin',NULL,NULL,NULL),('vb123','vb123','admin','Van','M','Bir');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `waitlist` (
  `wl_id` int NOT NULL AUTO_INCREMENT,
  `f_id` int NOT NULL,
  `aircraft_id` int NOT NULL,
  `airline_id` varchar(50) NOT NULL,
  `time_added` time DEFAULT NULL,
  `cust_id` int DEFAULT NULL,
  PRIMARY KEY (`wl_id`,`f_id`,`aircraft_id`,`airline_id`),
  KEY `waitlist_ibfk_1` (`f_id`,`aircraft_id`,`airline_id`),
  CONSTRAINT `waitlist_ibfk_1` FOREIGN KEY (`f_id`, `aircraft_id`, `airline_id`) REFERENCES `flight` (`f_id`, `aircraft_id`, `airline_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
INSERT INTO `waitlist` VALUES (1,1,1,'AL','08:00:00',1),(2,2,2,'UA','09:00:00',2),(3,3,35,'AA','10:00:00',3),(4,1,1,'AL','13:48:41',99),(5,1,1,'AL','13:49:23',99),(6,1,1,'AL','17:32:45',99);
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wl_customers`
--

DROP TABLE IF EXISTS `wl_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wl_customers` (
  `wl_id` int NOT NULL,
  `cust_id` int NOT NULL,
  PRIMARY KEY (`wl_id`,`cust_id`),
  KEY `wl_customers_ibfk_2` (`cust_id`),
  CONSTRAINT `WL_customer_fk` FOREIGN KEY (`wl_id`) REFERENCES `waitlist` (`wl_id`),
  CONSTRAINT `wl_customers_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wl_customers`
--

LOCK TABLES `wl_customers` WRITE;
/*!40000 ALTER TABLE `wl_customers` DISABLE KEYS */;
INSERT INTO `wl_customers` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `wl_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'travel'
--
/*!50003 DROP PROCEDURE IF EXISTS `flightpathtesting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `flightpathtesting`(IN start_apt CHAR(3), IN end_apt CHAR(3),IN no_connections int,IN flightdate date)
BEGIN
    WITH RECURSIVE FlightPaths AS (
        SELECT 
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(f.departure_time) = flightdate

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
    )
    SELECT
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPath` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPath`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathFlex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathFlex`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
		AND DATE(f.departure_time) >= DATE_SUB(@flightdate_var, INTERVAL 3 DAY) 
        AND DATE(f.departure_time) <= DATE_ADD(@flightdate_var, INTERVAL 3 DAY)

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbyarrivalasc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbyarrivalasc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by arrival_time asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbyarrivaldesc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbyarrivaldesc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by arrival_time desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbycostasc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbycostasc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by total_cost asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbycostdesc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbycostdesc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by total_cost desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbydepartasc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbydepartasc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by depart_time asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbydepartdesc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbydepartdesc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by depart_time desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbydurationasc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbydurationasc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by total_duration asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbydurationdesc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbydurationdesc`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt
    ORDER by total_duration desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathorderbytest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathorderbytest`(
    IN start_apt CHAR(3), 
    IN end_apt CHAR(3), 
    IN no_connections INT, 
    IN flightdate DATE, 
    IN orderby CHAR(50),
    IN ascdesc CHAR(4)
)
BEGIN
    SET @flightdate_var = flightdate;
    SET @sql = CONCAT('
        WITH RECURSIVE FlightPaths AS (
            SELECT
                departure_apt AS final_departure,
                arrival_apt AS arrival,
                departure_time as depart_time,
                arrival_time as arrival_time,
                CAST(f_id AS CHAR(100)) AS flight_ids,
                CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
                CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
                CAST(f.airline_id as CHAR(100)) AS airline_ids,
                CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
                CAST(duration_minutes as unsigned) AS total_duration,
                1 AS connections
            FROM flight f
            WHERE departure_apt = "', start_apt, '"
            AND DATE(departure_time) = "', @flightdate_var, '"
            UNION ALL
            SELECT 
                f.departure_apt AS final_departure,
                f.arrival_apt AS arrival,
                f.departure_time as depart_time,
                f.arrival_time as arrival_time,
                CONCAT(fp.flight_ids, ",", CAST(f.f_id AS CHAR(100))) AS flight_ids,
                fp.total_booking_fees + f.booking_fee AS total_booking_fees,
                fp.total_fares + f.fare AS total_fares,
                CONCAT(fp.airline_ids, ",", CAST(f.airline_id AS CHAR(100))) as airline_ids,
                CONCAT(fp.aircraft_ids, ",", CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
                fp.total_duration + f.duration_minutes AS total_duration,
                fp.connections + 1 AS connections
            FROM flight f
            JOIN FlightPaths fp ON f.departure_apt = fp.arrival
            WHERE fp.connections < ', no_connections, '
            AND f.arrival_apt <> final_departure
            AND f.departure_time > fp.arrival_time
        )
        SELECT
            final_departure,
            depart_time,
            arrival_time,
            arrival,
            total_booking_fees AS sum_of_booking_fees,
            total_fares AS sum_of_fares,
            flight_ids,
            (total_booking_fees + total_fares) AS total_cost,
            airline_ids,
            aircraft_ids,
            total_duration
        FROM FlightPaths fp
        WHERE arrival = "', end_apt, '" 
        ORDER BY ', orderby, ' ', ascdesc);

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPaths` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPaths`(IN start_apt CHAR(3), IN end_apt CHAR(3),IN no_connections int,IN flightdate date)
BEGIN
	SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        and DATE(departure_time) = flightdate

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            fp.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
    )
    SELECT
		final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathsFlex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathsFlex`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
		AND DATE(f.departure_time) >= DATE_SUB(@flightdate_var, INTERVAL 3 DAY) 
        AND DATE(f.departure_time) <= DATE_ADD(@flightdate_var, INTERVAL 3 DAY)

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathsflexorderbytest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathsflexorderbytest`(
    IN start_apt CHAR(3), 
    IN end_apt CHAR(3), 
    IN no_connections INT, 
    IN flightdate DATE, 
    IN orderby CHAR(50),
    IN ascdesc CHAR(4)
)
BEGIN
    SET @flightdate_var = flightdate;
    SET @sql = CONCAT('
        WITH RECURSIVE FlightPaths AS (
            SELECT
                departure_apt AS final_departure,
                arrival_apt AS arrival,
                departure_time as depart_time,
                arrival_time as arrival_time,
                CAST(f_id AS CHAR(100)) AS flight_ids,
                CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
                CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
                CAST(f.airline_id as CHAR(100)) AS airline_ids,
                CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
                CAST(duration_minutes as unsigned) AS total_duration,
                1 AS connections
            FROM flight f
            WHERE departure_apt = "', start_apt, '"
            AND DATE(f.departure_time) >= DATE_SUB(@flightdate_var, INTERVAL 3 DAY) 
			AND DATE(f.departure_time) <= DATE_ADD(@flightdate_var, INTERVAL 3 DAY)
            UNION ALL
            SELECT 
                f.departure_apt AS final_departure,
                f.arrival_apt AS arrival,
                f.departure_time as depart_time,
                f.arrival_time as arrival_time,
                CONCAT(fp.flight_ids, ",", CAST(f.f_id AS CHAR(100))) AS flight_ids,
                fp.total_booking_fees + f.booking_fee AS total_booking_fees,
                fp.total_fares + f.fare AS total_fares,
                CONCAT(fp.airline_ids, ",", CAST(f.airline_id AS CHAR(100))) as airline_ids,
                CONCAT(fp.aircraft_ids, ",", CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
                fp.total_duration + f.duration_minutes AS total_duration,
                fp.connections + 1 AS connections
            FROM flight f
            JOIN FlightPaths fp ON f.departure_apt = fp.arrival
            WHERE fp.connections < ', no_connections, '
            AND f.arrival_apt <> final_departure
            AND f.departure_time > fp.arrival_time
        )
        SELECT
            final_departure,
            depart_time,
            arrival_time,
            arrival,
            total_booking_fees AS sum_of_booking_fees,
            total_fares AS sum_of_fares,
            flight_ids,
            (total_booking_fees + total_fares) AS total_cost,
            airline_ids,
            aircraft_ids,
            total_duration
        FROM FlightPaths fp
        WHERE arrival = "', end_apt, '" 
        ORDER BY ', orderby, ' ', ascdesc);

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPathTest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPathTest`(IN start_apt CHAR(3), IN end_apt CHAR(3), IN no_connections INT, IN flightdate DATE)
BEGIN
    SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        AND DATE(departure_time) = @flightdate_var

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            f.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
        AND f.departure_time > fp.arrival_time
    )
    SELECT
        final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetFlightPath_outdated` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightPath_outdated`(IN start_apt CHAR(3), IN end_apt CHAR(3),IN no_connections int,IN flightdate date)
BEGIN
	SET @flightdate_var = flightdate;
    WITH RECURSIVE FlightPaths AS (
        SELECT
            departure_apt AS final_departure,
            arrival_apt AS arrival,
            departure_time as depart_time,
            arrival_time as arrival_time,
            CAST(f_id AS CHAR(100)) AS flight_ids,
            CAST(f.booking_fee AS DECIMAL(10,2)) AS total_booking_fees,
            CAST(f.fare AS DECIMAL(10,2)) AS total_fares,
            CAST(f.airline_id as CHAR(100)) AS airline_ids,
            CAST(f.aircraft_id as CHAR(100)) AS aircraft_ids,
            CAST(duration_minutes as unsigned) AS total_duration,
            1 AS connections
        FROM flight f
        WHERE departure_apt = start_apt
        and DATE(departure_time) = flightdate

        UNION ALL

        SELECT 
            f.departure_apt AS final_departure,
            f.arrival_apt AS arrival,
            f.departure_time as depart_time,
            fp.arrival_time as arrival_time,
            CONCAT(fp.flight_ids, ',', CAST(f.f_id AS CHAR(100))) AS flight_ids,
            fp.total_booking_fees + f.booking_fee AS total_booking_fees,
            fp.total_fares + f.fare AS total_fares,
            CONCAT(fp.airline_ids, ',',CAST(f.airline_id AS CHAR(100))) as airline_ids,
            CONCAT(fp.aircraft_ids, ',',CAST(f.aircraft_id AS CHAR(100))) as aircraft_ids,
            fp.total_duration + f.duration_minutes AS total_duration,
            fp.connections + 1 AS connections
        FROM flight f
        JOIN FlightPaths fp ON f.departure_apt = fp.arrival
        WHERE fp.connections < no_connections
        AND f.arrival_apt <> final_departure
    )
    SELECT
		final_departure,
        depart_time,
        arrival_time,
        arrival,
        total_booking_fees AS sum_of_booking_fees,
        total_fares AS sum_of_fares,
        flight_ids,
        (total_booking_fees + total_fares) AS total_cost,
        airline_ids,
        aircraft_ids,
        total_duration
    FROM FlightPaths 
    WHERE arrival = end_apt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16  1:06:41
