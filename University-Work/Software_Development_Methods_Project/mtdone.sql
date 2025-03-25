-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: mt
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `booking_ID` int NOT NULL AUTO_INCREMENT,
  `trip_ID` int NOT NULL,
  `salesperson_ID` int NOT NULL,
  `traveller_ID` int NOT NULL,
  `to_cabin_ID` int NOT NULL,
  `to_bundle_ID` int NOT NULL,
  `to_movies_amount` int NOT NULL,
  `to_concert_amount` int NOT NULL,
  `to_theater_amount` int NOT NULL,
  `from_cabin_ID` int DEFAULT NULL,
  `from_bundle_ID` int DEFAULT NULL,
  `from_movies_amount` int DEFAULT NULL,
  `from_concert_amount` int DEFAULT NULL,
  `from_theater_amount` int DEFAULT NULL,
  PRIMARY KEY (`booking_ID`),
  UNIQUE KEY `booking_ID_UNIQUE` (`booking_ID`),
  KEY `trip_ID_idx` (`trip_ID`),
  KEY `salesperson_ID_idx` (`salesperson_ID`),
  KEY `bundle_ID_idx` (`to_bundle_ID`),
  KEY `cabin_ID_idx` (`to_cabin_ID`),
  KEY `travellers_id_idx` (`traveller_ID`),
  CONSTRAINT `bundle_ID` FOREIGN KEY (`to_bundle_ID`) REFERENCES `food_bundle` (`bundle_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cabin_ID` FOREIGN KEY (`to_cabin_ID`) REFERENCES `cabin` (`cabin_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `salesperson_ID` FOREIGN KEY (`salesperson_ID`) REFERENCES `salesperson` (`salesperson_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `travellers_id` FOREIGN KEY (`traveller_ID`) REFERENCES `traveller` (`traveller_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tripp_ID` FOREIGN KEY (`trip_ID`) REFERENCES `trip` (`trip_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabin`
--

DROP TABLE IF EXISTS `cabin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabin` (
  `cabin_ID` int NOT NULL AUTO_INCREMENT,
  `cabin_type_ID` int NOT NULL,
  `trip_ID` int NOT NULL,
  `available` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`cabin_ID`),
  UNIQUE KEY `cabin_ID_UNIQUE` (`cabin_ID`),
  KEY `trip_ID_idx` (`trip_ID`),
  KEY `trips_ID_idx` (`trip_ID`),
  KEY `cabin_type_ID_idx` (`cabin_type_ID`),
  CONSTRAINT `cabin_type_ID` FOREIGN KEY (`cabin_type_ID`) REFERENCES `cabin_types` (`cabin_type_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trips_ID` FOREIGN KEY (`trip_ID`) REFERENCES `trip` (`trip_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabin`
--

LOCK TABLES `cabin` WRITE;
/*!40000 ALTER TABLE `cabin` DISABLE KEYS */;
INSERT INTO `cabin` VALUES (1,1,1,0),(2,2,1,1),(3,3,1,0),(4,4,1,1),(5,5,1,0),(10,1,2,1),(11,2,2,0),(12,3,2,1),(13,4,2,0),(14,5,2,1),(19,1,3,1),(20,2,3,0),(21,3,3,1),(22,4,3,0),(23,5,3,0),(28,1,4,1),(29,2,4,0),(30,3,4,1),(31,4,4,0),(32,5,4,1),(37,1,5,0),(38,2,5,0),(39,3,5,1),(40,4,5,1),(41,5,5,1),(46,1,6,1),(47,2,6,1),(48,3,6,1),(49,4,6,1),(50,5,6,0),(55,1,7,1),(56,2,7,0),(57,3,7,0),(58,4,7,1),(59,5,7,1),(64,1,8,1),(65,2,8,1),(66,3,8,1),(67,4,8,0),(68,5,8,0),(73,1,9,1),(74,2,9,0),(75,3,9,0),(76,4,9,1),(77,5,9,1),(82,1,10,1),(83,2,10,1),(84,3,10,1),(85,4,10,1),(86,5,10,0),(91,1,11,1),(92,2,11,1),(93,3,11,1),(94,4,11,1),(95,5,11,1),(100,1,12,1),(101,2,12,1),(102,3,12,1),(103,4,12,1),(104,5,12,1);
/*!40000 ALTER TABLE `cabin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabin_types`
--

DROP TABLE IF EXISTS `cabin_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabin_types` (
  `cabin_type_ID` int NOT NULL AUTO_INCREMENT,
  `cabin_type` text NOT NULL,
  `description` text NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`cabin_type_ID`),
  UNIQUE KEY `cabin_type_ID_UNIQUE` (`cabin_type_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabin_types`
--

LOCK TABLES `cabin_types` WRITE;
/*!40000 ALTER TABLE `cabin_types` DISABLE KEYS */;
INSERT INTO `cabin_types` VALUES (1,'Sömnkapsel','Vill man sova hela resan igenom så kan man bli sövd och placerad i sömnkapsel. Specialutbildad personal har full kontroll över kapslarna 24/7.',2500000),(2,'Svit','Hytt med utsikt över rymden, separat vardags- och sovrum inklusive dubbelsäng. Dessutom skärm med stort utbud av film, serier, musik och spel. Badrum med badkar/dusch och toalett. Frukost ingår i priset.',1200000),(3,'Spaceside','Hytt med utsikt över rymden, dubbelsäng. Dessutom skärm med stort utbud av film, serier, musik och spel. Badrum med dusch och toalett.',700000),(4,'Inside','Insideshytt med två underbäddar som kan ändras till soffa dagtid. Badrum med dusch och toalett.',300000),(5,'Economy','Insideshytt med 4 bäddar (två under- och överbäddar) där underbäddarna kan ändras till soffa dagtid. Dusch finns till hytten, men toaletter finns i korridoren.',180000);
/*!40000 ALTER TABLE `cabin_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_card`
--

DROP TABLE IF EXISTS `credit_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit_card` (
  `credit_card_ID` int NOT NULL AUTO_INCREMENT,
  `traveller_ID` int NOT NULL,
  `amount` int NOT NULL DEFAULT '20000',
  PRIMARY KEY (`credit_card_ID`),
  UNIQUE KEY `credit_card_ID_UNIQUE` (`credit_card_ID`),
  UNIQUE KEY `traveller_ID_UNIQUE` (`traveller_ID`),
  CONSTRAINT `travellerr_ID` FOREIGN KEY (`traveller_ID`) REFERENCES `traveller` (`traveller_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_card`
--

LOCK TABLES `credit_card` WRITE;
/*!40000 ALTER TABLE `credit_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_types`
--

DROP TABLE IF EXISTS `event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_types` (
  `event_types_ID` int NOT NULL AUTO_INCREMENT,
  `event_description` text NOT NULL,
  `name` text NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`event_types_ID`),
  UNIQUE KEY `event_ID_UNIQUE` (`event_types_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_types`
--

LOCK TABLES `event_types` WRITE;
/*!40000 ALTER TABLE `event_types` DISABLE KEYS */;
INSERT INTO `event_types` VALUES (1,'Konserter med olika artister (en ny konsert varannan månad)','Konsert',1000),(2,'Filmpremiärer (en ny film varje månad)','Film',500),(3,'Teaterpremiärer (en ny föreställning varannan månad)','Teater',1500);
/*!40000 ALTER TABLE `event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_bundle`
--

DROP TABLE IF EXISTS `food_bundle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_bundle` (
  `bundle_ID` int NOT NULL AUTO_INCREMENT,
  `bundle_description` text NOT NULL,
  `bundle_name` text NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`bundle_ID`),
  UNIQUE KEY `bundle_ID_UNIQUE` (`bundle_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_bundle`
--

LOCK TABLES `food_bundle` WRITE;
/*!40000 ALTER TABLE `food_bundle` DISABLE KEYS */;
INSERT INTO `food_bundle` VALUES (1,'Samtliga måltider under resan intas på MarsDonalds.','Budget 1',27000),(2,'All frukost och lunch intas på MarsDonalds medan mellanmål och middagarna intas på\r\r\nMarsian Buffé.','Budget 2',40000),(3,'Samtliga måltider under resan intas på Marsian Buffé.','Budget 3',54000),(4,'All frukost intas på MarsDonalds, mellanmål och lunch på Marsian Buffé medan\r\r\nmiddagarna intas på Tellus Home.','Mellan 1',76000),(5,'All måltider förutom middag intas på Marsian Buffé. Middagarna intas på Tellus Home.','Mellan 2',90000),(6,'Samtliga måltider intas på Tellus Home.','Mellan 3',100000),(7,'All måltider förutom middag intas på Tellus Home medan middagarna intas på\r\r\nSpaceView.','Lyx 1',120000),(8,'Frukost och mellanmål intas på Tellus Home medan lunch och middag intas på\r\r\nSpaceView','Lyx 2',150000),(9,'Samtliga måltider intas på SpaceView. För de som valt hyttalternativet Svit serveras\r\r\nfrukosten i hytten från SpaceView.','Lyx 3',200000),(10,'Ingen mat under färd.','Sömnkapsel',0);
/*!40000 ALTER TABLE `food_bundle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `hotel_ID` int NOT NULL AUTO_INCREMENT,
  `hotel_description` text NOT NULL,
  `hotel_namn` text NOT NULL,
  `price` int NOT NULL,
  `room_type` text NOT NULL,
  PRIMARY KEY (`hotel_ID`),
  UNIQUE KEY `hotel_ID_UNIQUE` (`hotel_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Enkelt hotell där man delar ett 6-bäddsrum med andra människor, man betalar alltså för en bädd. Varje rum har egen dusch och toalett. Det finns en matsal där måltiderna serveras vid bestämda tider. Hotellet har flera olika lounger där man kan umgås, njuta vid den konstgjorda brasan i öppna spisen, läsa böcker, lyssna på musik eller spela spel. Det finns också en träningslokal för både kondition och styrketräning, samt gruppövningar.','Polar Landsdorp',3500,'Delat rum'),(2,'Enkelt hotell där man delar ett 4-bäddsrum med andra människor, man betalar alltså för en bädd. Varje rum har egen dusch och toalett. Det finns en matsal där måltiderna serveras vid bestämda tider. Hotellet har flera olika lounger där man kan umgås, njuta vid den konstgjorda brasan i öppna spisen, läsa böcker, lyssna på musik eller spela spel. Det finns också en träningslokal för både kondition och styrketräning, samt gruppövningar.','Polar Wielders',5000,'Delat rum'),(3,'Ligger vid ekvatorn på Mars och har både enkelrum och dubbelrum med egen dusch och toalett. Rummet är också inredd med en liten soffa och tv (filmer, serier och spel finns tillgängliga). I restaurangen serveras måltiderna, men man kan också få maten serverad på rummen. Flera olika lounger med olika teman finns så som bibliotek, biljardrum (där även andra spel finns), musikrum och bio. Träningslokal med redskap för styrke- och konditionsträning finns samt tränare för gruppövningar.','Hotel Phobos',7500,'Enkelrum'),(4,'Ligger vid ekvatorn på Mars och har både enkelrum och dubbelrum med egen dusch och toalett. Rummet är också inredd med en liten soffa och tv (filmer, serier och spel finns tillgängliga). I restaurangen serveras måltiderna, men man kan också få maten serverad på rummen. Flera olika lounger med olika teman finns så som bibliotek, biljardrum (där även andra spel finns), musikrum och bio. Träningslokal med redskap för styrke- och konditionsträning finns samt tränare för gruppövningar.','Hotel Phobos',12000,'Dubbelrum'),(5,'Ligger vid ekvatorn på Mars och har både enkelrum och dubbelrum med egen dusch och toalett. Rummet är också inredd med en liten soffa och tv (filmer, serier och spel finns tillgängliga). I restaurangen serveras måltiderna, men man kan också få maten serverad på rummen. Flera olika lounger med olika teman finns så som bibliotek, biljardrum (där även andra spel finns), musikrum och bio. Träningslokal med redskap för styrke- och konditionsträning finns samt tränare för gruppövningar.','Hotel Deimos',7500,'Enkelrum'),(6,'Ligger vid ekvatorn på Mars och har både enkelrum och dubbelrum med egen dusch och toalett. Rummet är också inredd med en liten soffa och tv (filmer, serier och spel finns tillgängliga). I restaurangen serveras måltiderna, men man kan också få maten serverad på rummen. Flera olika lounger med olika teman finns så som bibliotek, biljardrum (där även andra spel finns), musikrum och bio. Träningslokal med redskap för styrke- och konditionsträning finns samt tränare för gruppövningar.','Hotel Deimos',12000,'Dubbelrum'),(7,'Charmigt lyxhotell insprängt i berget i dalgången i Valles Marineris. Här finns sviter med dubbelsäng och vardagsrum där man kan få samtliga måltider serverade. Lyxrum med enkel eller dubbelbäddar och mini-loungedel finns också att tillgå. Restaurangen har de bästa kockarna och maten som serveras är inte bara en njutning smakmässigt utan även hälsosam. Lyxigt inredda bibliotek, teatersalong, lounge för att umgås och träningslokaler där flertalet personliga tränare är redo att skapa passande träningsprogram. I närheten finns en galleria.','Royal City',20000,'Enkel Lyx'),(8,'Charmigt lyxhotell insprängt i berget i dalgången i Valles Marineris. Här finns sviter med dubbelsäng och vardagsrum där man kan få samtliga måltider serverade. Lyxrum med enkel eller dubbelbäddar och mini-loungedel finns också att tillgå. Restaurangen har de bästa kockarna och maten som serveras är inte bara en njutning smakmässigt utan även hälsosam. Lyxigt inredda bibliotek, teatersalong, lounge för att umgås och träningslokaler där flertalet personliga tränare är redo att skapa passande träningsprogram. I närheten finns en galleria.','Royal City',35000,'Dubbel Lyx'),(9,'Charmigt lyxhotell insprängt i berget i dalgången i Valles Marineris. Här finns sviter med dubbelsäng och vardagsrum där man kan få samtliga måltider serverade. Lyxrum med enkel eller dubbelbäddar och mini-loungedel finns också att tillgå. Restaurangen har de bästa kockarna och maten som serveras är inte bara en njutning smakmässigt utan även hälsosam. Lyxigt inredda bibliotek, teatersalong, lounge för att umgås och träningslokaler där flertalet personliga tränare är redo att skapa passande träningsprogram. I närheten finns en galleria.','Royal City',50000,'Svit');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_duration`
--

DROP TABLE IF EXISTS `hotel_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_duration` (
  `booking_ID` int NOT NULL,
  `hotel_ID` int NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  KEY `booking_ID_idx` (`booking_ID`),
  KEY `hotel_ID_idx` (`hotel_ID`),
  CONSTRAINT `booking_ID` FOREIGN KEY (`booking_ID`) REFERENCES `booking` (`booking_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hotel_ID` FOREIGN KEY (`hotel_ID`) REFERENCES `hotel` (`hotel_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_duration`
--

LOCK TABLES `hotel_duration` WRITE;
/*!40000 ALTER TABLE `hotel_duration` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_duration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_room`
--

DROP TABLE IF EXISTS `hotel_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_room` (
  `hotelroom_ID` int NOT NULL AUTO_INCREMENT,
  `hotel_ID` int NOT NULL,
  `available` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`hotelroom_ID`),
  UNIQUE KEY `hotelroom_ID_UNIQUE` (`hotelroom_ID`),
  KEY `hotel_ID_idx` (`hotel_ID`),
  KEY `hotell_ID_idx` (`hotel_ID`),
  CONSTRAINT `hotell_ID` FOREIGN KEY (`hotel_ID`) REFERENCES `hotel` (`hotel_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_room`
--

LOCK TABLES `hotel_room` WRITE;
/*!40000 ALTER TABLE `hotel_room` DISABLE KEYS */;
INSERT INTO `hotel_room` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,9,1);
/*!40000 ALTER TABLE `hotel_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `restaurants_ID` int NOT NULL AUTO_INCREMENT,
  `restaurant_name` text NOT NULL,
  `restaurants_description` text NOT NULL,
  PRIMARY KEY (`restaurants_ID`),
  UNIQUE KEY `restaurants_ID_UNIQUE` (`restaurants_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'MarsDonald','Det billigaste alternativet är MarsDonald vars utbud är 2 olika frukostar, 3 olika luncher och 4 olika middagar, samt 3 olika kakor/desserter att tillgå mellan måltiderna.'),(2,'Marsian Buffé','Marsian Buffé är restaurangen som har buffé dygnet runt med olika rätter som kan passa oavsett tid på dagen. Alltifrån våfflor och omeletter till grillat och pizza.'),(3,'Tellus Home','Vi har också restaurangen Tellus Home som serverar en enklare frukostbuffé, 5 olika luncher (kött/fisk/veg/soppa/pasta) och 6 olika middagar (2 alternativ av fisk/kött/veg). Deras dessertbuffé som är öppen mellan måltiderna består av 3-5 olika kakor/desserter plus dryck.'),(4,'Spaceview','Spaceview restaurangen har specialiserat sig på ny och kreativ mat där kockarna tar favoriträtter från jorden och med inspiration från rymden gör om dem och ger dig en ny smakupplevelse.');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesperson`
--

DROP TABLE IF EXISTS `salesperson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesperson` (
  `salesperson_ID` int NOT NULL AUTO_INCREMENT,
  `f_name` text NOT NULL,
  `l_name` text NOT NULL,
  `login` varchar(12) NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`salesperson_ID`),
  UNIQUE KEY `salesperson_ID_UNIQUE` (`salesperson_ID`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesperson`
--

LOCK TABLES `salesperson` WRITE;
/*!40000 ALTER TABLE `salesperson` DISABLE KEYS */;
INSERT INTO `salesperson` VALUES (1,'Tilda','Sigfridsson','tsigfridsson','marstravelpassword'),(2,'Wala','Abusultan','wabusultan','marstravelpassword'),(3,'Oliver ','Brandt','obrandt','marstravelpassword'),(4,'Mohamed','Hussein','mhussein','marstravelpassword'),(5,'Adam','El Soudi','aelsoudi','marstravelpassword');
/*!40000 ALTER TABLE `salesperson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traveller`
--

DROP TABLE IF EXISTS `traveller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traveller` (
  `traveller_ID` int NOT NULL AUTO_INCREMENT,
  `personal_number` varchar(12) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `address` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `healthy` int NOT NULL,
  `chronic_pain` int NOT NULL,
  `info_chronicpain` varchar(255) DEFAULT NULL,
  `medicine` int NOT NULL,
  `info_medicine` varchar(255) DEFAULT NULL,
  `health_insurance` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`traveller_ID`),
  UNIQUE KEY `traveller_ID_UNIQUE` (`traveller_ID`),
  UNIQUE KEY `personal_number_UNIQUE` (`personal_number`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traveller`
--

LOCK TABLES `traveller` WRITE;
/*!40000 ALTER TABLE `traveller` DISABLE KEYS */;
/*!40000 ALTER TABLE `traveller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trip`
--

DROP TABLE IF EXISTS `trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trip` (
  `trip_ID` int NOT NULL AUTO_INCREMENT,
  `date` tinytext NOT NULL,
  PRIMARY KEY (`trip_ID`),
  UNIQUE KEY `trip_ID_UNIQUE` (`trip_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trip`
--

LOCK TABLES `trip` WRITE;
/*!40000 ALTER TABLE `trip` DISABLE KEYS */;
INSERT INTO `trip` VALUES (1,'23092022'),(2,'23102022'),(3,'23112022'),(4,'23122022'),(5,'23012023'),(6,'23022023'),(7,'23032023'),(8,'23042023'),(9,'23052023'),(10,'23062023'),(11,'23072023'),(12,'23082023');
/*!40000 ALTER TABLE `trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mt'
--
/*!50003 DROP PROCEDURE IF EXISTS `save_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_booking`(trip int, salep int, cabin int, bundle int, movie int, concert int, theater int, fcabin int, fbundle int, fmovie int, fconcert int, ftheater int)
begin
	declare travellerID int;
    set travellerID = (select max(traveller_ID) from traveller);
	insert into booking (trip_ID, salesperson_ID, traveller_ID, to_cabin_ID, to_bundle_ID, to_movies_amount, to_concert_amount, to_theater_amount, from_cabin_ID, from_bundle_ID, from_movies_amount, from_concert_amount, from_theater_amount) VALUES
    (trip, salep, travellerID, cabin, bundle, movie, concert, theater, fcabin, fbundle, fmovie, fconcert, ftheater);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `save_creditcart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_creditcart`(amount int)
begin
	declare travellerID int;
    set travellerID = (select max(traveller_ID) from traveller);
	insert into credit_card (traveller_ID, amount) values
    (travellerID, amount);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `save_hotel_booking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_hotel_booking`(hotel_ID int, startdate date, enddate date)
begin
    declare bookingID int;
    set bookingID = (select max(booking_ID) from booking);
    insert into hotel_duration VALUES (bookingID, hotel_ID, startdate, enddate);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `save_traveller` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `save_traveller`(personnr varchar(12), fname text, lname text, adress text, email varchar(50), frisk int, krämpa int, infokrämpa varchar(255), medicin int, infomedicin varchar(255), healthins int)
begin
	insert into traveller (personal_number, first_name, last_name, address, email, healthy, chronic_pain, info_chronicpain, medicine, info_medicine, health_insurance) VALUES
    (personnr, fname, lname, adress, email, frisk, krämpa, infokrämpa, medicin, infomedicin, healthins);
end ;;
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

-- Dump completed on 2022-03-15 11:55:06
