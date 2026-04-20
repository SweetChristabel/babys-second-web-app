-- MySQL dump 10.13  Distrib 9.5.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: Utstyrutleie
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `Utstyrutleie`
--

/*!40000 DROP DATABASE IF EXISTS `Utstyrutleie`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Utstyrutleie` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `Utstyrutleie`;

--
-- Table structure for table `adresseliste`
--

DROP TABLE IF EXISTS `adresseliste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adresseliste` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `gate` varchar(45) NOT NULL,
  `husnr` int NOT NULL,
  `postnr` varchar(4) DEFAULT NULL,
  `postboks` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_adresseliste_poststed1_idx` (`postnr`),
  CONSTRAINT `fk_adresseliste_poststed1` FOREIGN KEY (`postnr`) REFERENCES `poststed` (`postnr`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adresseliste`
--

LOCK TABLES `adresseliste` WRITE;
/*!40000 ALTER TABLE `adresseliste` DISABLE KEYS */;
INSERT INTO `adresseliste` VALUES (100,'Fjelltoppen',3,'8500',NULL),(101,'Lillegata',233,'8000',NULL),(102,'Veien',124,'8000',NULL),(103,'Murergata',2,'9000',NULL),(104,'Fjelltoppen',4,'8500',NULL),(105,'Øvregata',332,'8001',NULL),(106,'Nedreveien',223,'8000',NULL),(107,'Murergata',1,'9001',NULL),(109,'Jernbanegata',15,'3019',NULL),(110,'Bruket',4,'1505',NULL),(111,'Pettersvollen',2,'3019',NULL),(116,'Havnestredet',4,'1531',NULL),(117,'Storgata',10,'3019',NULL),(118,'Øvre Slottsgate',31,'1000',NULL),(119,'Torggata',59,'1000',NULL);
/*!40000 ALTER TABLE `adresseliste` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brukerliste`
--

DROP TABLE IF EXISTS `brukerliste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brukerliste` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `fornavn` varchar(45) DEFAULT NULL,
  `etternavn` varchar(45) DEFAULT NULL,
  `telefonnummer` bigint DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `username` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `beh_nr_UNIQUE` (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brukerliste`
--

LOCK TABLES `brukerliste` WRITE;
/*!40000 ALTER TABLE `brukerliste` DISABLE KEYS */;
INSERT INTO `brukerliste` VALUES (10,'Utvikler','Adminsen',NULL,'scrypt:32768:8:1$wEJFuUKkdAyPLIBh$6d1ed39b140d5fe23531049cfcc6cf5e1be250e70a03a32d4762b147598d0fa2c659022f3c944cb5db34d37af9362a21e338a529a11a99f69affb9631cc01a56','admin','admin10'),(11,'Berit','Hansen',10191999,'','user','berhan11'),(12,'Hans','Hansen',10291999,'','user','hanhan12'),(13,'Hilde','Pettersen',10090999,'','user','hilpet13'),(14,'Bruker','Kundebehandlersen',32893893,'scrypt:32768:8:1$YQR7PCEjEgqMN2jh$9d4b352d2e2a68c722373d442f6331d5ad07e101614b318b5070a4b227874001904a8d13d877f60ba88deca8a5d747af3583612097d76218a358bda9f0be9309','user','brukun14'),(15,'Junior','Adminsen',83928392,'scrypt:32768:8:1$CrzT70yv8OQIkxVo$e5b5f886c418927e3967a10e10a59f8b6666ffd1ddbe84b4cd446382fa34d6c65efb7581739c6cb0154cbc0d83af535d26eca836eda3b31b7562d49a3313f860','admin','junadm15'),(16,'Daniel','Hansen',92003492,'scrypt:32768:8:1$fjxrtuXeYVlk3aQX$d1d1f83a26b3b5ca94a246d9942c166ba422b8e1d41a3f07b9be3226982f942235a233029c0b28748f91b3cf7acfb9f9843828ad5dd96e60f600e0da1ef21301','user','danhan16'),(17,'Anne','Rud',1234982,'scrypt:32768:8:1$GszvNSdqJrnqPyel$4b64e1981c7741662baf5b93b44caa809235c9fa533d9f6a580cfd467484b49ab713fdba8f980cdf2711bbe7377ac16747e06c54d01eb4e51a0b8967f70078f2','user','annrud17'),(18,'Anita','Larssen',93024930,'scrypt:32768:8:1$sG0nRpM2SflUwFqo$dd7f7da967fa1e8c6104b6e39acc191a924bff6aec69643b3aba9f384234251969bd8a9b044b9ddcfcb71855786f26946684a9925f6e9af2bd646c0b5be54d35','user','anilar18'),(19,'Anita','Larssen',93024930,'scrypt:32768:8:1$8vAm8Bf9BA4e5ci8$92ab5c3d9627cfdacd7c5128f12af0a3869a874c2d072f555567870733c8abe468280c7b28024453dfc199c1f53e91e2f29df922b6eb5cb76e2026f7a25933bd','user','anilar19');
/*!40000 ALTER TABLE `brukerliste` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instans_utstyr`
--

DROP TABLE IF EXISTS `instans_utstyr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instans_utstyr` (
  `utstyr_id` int NOT NULL,
  `instans_id` int NOT NULL,
  `siste_vedlikehold` date DEFAULT NULL,
  `neste_vedlikehold` date DEFAULT NULL,
  PRIMARY KEY (`instans_id`,`utstyr_id`),
  KEY `fk_utstyr_lager_utstyr_type_idx` (`utstyr_id`),
  CONSTRAINT `fk_utstyr_lager_utstyr_type` FOREIGN KEY (`utstyr_id`) REFERENCES `mal_utstyr` (`utstyr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instans_utstyr`
--

LOCK TABLES `instans_utstyr` WRITE;
/*!40000 ALTER TABLE `instans_utstyr` DISABLE KEYS */;
INSERT INTO `instans_utstyr` VALUES (233,1,'2018-04-03','2021-04-03'),(234,1,'2021-02-10','2022-02-10'),(1001,1,'2019-09-01','2022-09-01'),(7653,1,'2016-12-11','2021-12-11'),(7654,1,'2019-03-20','2024-03-20'),(233,2,'2017-01-02','2022-01-02');
/*!40000 ALTER TABLE `instans_utstyr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunde`
--

DROP TABLE IF EXISTS `kunde`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunde` (
  `kunde_nr` int NOT NULL AUTO_INCREMENT,
  `navn` varchar(100) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `epost` varchar(100) DEFAULT NULL,
  `levering_adr` int DEFAULT NULL,
  `faktura_adr` int DEFAULT NULL,
  PRIMARY KEY (`kunde_nr`),
  UNIQUE KEY `kunde_nr_UNIQUE` (`kunde_nr`),
  KEY `fk_kunde_addresseliste2_idx` (`faktura_adr`),
  KEY `fk_kunde_addresseliste1_idx` (`levering_adr`),
  CONSTRAINT `fk_kunde_addresseliste1` FOREIGN KEY (`levering_adr`) REFERENCES `adresseliste` (`ID`),
  CONSTRAINT `fk_kunde_addresseliste2` FOREIGN KEY (`faktura_adr`) REFERENCES `adresseliste` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20018 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunde`
--

LOCK TABLES `kunde` WRITE;
/*!40000 ALTER TABLE `kunde` DISABLE KEYS */;
INSERT INTO `kunde` VALUES (8988,'Murer Pedersen AS','Bedrift','mu_pe@ånnlain.no',103,107),(10002,'Grøft og Kant AS','Bedrift','gm@uuiitt.nu',101,105),(11122,'Lokalbyggern AS','Bedrift','lok_bygg@no.no',102,106),(20011,'Anders Andersen','Privat','aa@post.no',104,100),(20012,'Korn Og Mel AS','Bedrift','korn@bedrift.no',109,110),(20015,'Båt og Havn AS','Bedrift','sjo@folk.no',111,116),(20016,'Kunde Kundersen','Privat','kunde@online.no',117,118),(20017,'Altmuligmann Andersen','Privat','altmulig@gmail.com',119,119);
/*!40000 ALTER TABLE `kunde` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `kundeoversikt`
--

DROP TABLE IF EXISTS `kundeoversikt`;
/*!50001 DROP VIEW IF EXISTS `kundeoversikt`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `kundeoversikt` AS SELECT 
 1 AS `KundeNr`,
 1 AS `Navn`,
 1 AS `Type`,
 1 AS `Antallordre`,
 1 AS `Epost`,
 1 AS `telefonnummer`,
 1 AS `Faktura_gate`,
 1 AS `Faktura_husnr`,
 1 AS `Faktura_postnr`,
 1 AS `Faktura_poststed`,
 1 AS `Levering_gate`,
 1 AS `Levering_husnr`,
 1 AS `Levering_postnr`,
 1 AS `Levering_poststed`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mal_utstyr`
--

DROP TABLE IF EXISTS `mal_utstyr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mal_utstyr` (
  `utstyr_id` int NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `merke` varchar(45) DEFAULT NULL,
  `modell` varchar(45) DEFAULT NULL,
  `kategori` varchar(45) DEFAULT NULL,
  `beskrivelse` text,
  `leiepris_døgn` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`utstyr_id`),
  UNIQUE KEY `utstyr_id_UNIQUE` (`utstyr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mal_utstyr`
--

LOCK TABLES `mal_utstyr` WRITE;
/*!40000 ALTER TABLE `mal_utstyr` DISABLE KEYS */;
INSERT INTO `mal_utstyr` VALUES (233,'Kompressor','Stanley','Vento 6L','Lette maskiner','Liten og hendig, med en motor på 1,5HK. Regulerbart trykk opp till 8bar, 180L luft i minuttet. ',79),(234,'Spikerpistol','ESSVE','Coil CN-15-65','Lette maskiner','ESSVE Coilpistol beregnet for spikring av bjelkelag, reisverk, kledning, utforinger, panel, sponplater m.m. Smidig spikerpistol med maskinkropp i magnesium, justerbart utblås og beltekrok.',100),(1001,'Minigraver','Hitachi','ZX10U-6','Tunge maskiner','Minigraveren ZX10U-6 fra Hitachi er vår minste minigraver og er laget for bruk på trange og små plasser',1200),(7653,'Stillas','Haki Stilas','150','Annleggsutstyr','Stilas på ca 150 kvadratmeter.',350),(7654,'Sementblander','Atika','130l 600w','Annleggsutstyr','Atika betongblander med kapasitet på 130 l og 600 W. Bruker 230 V. IP44',230);
/*!40000 ALTER TABLE `mal_utstyr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poststed`
--

DROP TABLE IF EXISTS `poststed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poststed` (
  `postnr` varchar(4) NOT NULL,
  `poststed` varchar(45) NOT NULL,
  PRIMARY KEY (`postnr`),
  UNIQUE KEY `postnr_UNIQUE` (`postnr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poststed`
--

LOCK TABLES `poststed` WRITE;
/*!40000 ALTER TABLE `poststed` DISABLE KEYS */;
INSERT INTO `poststed` VALUES ('1000','Oslo'),('1505','Fredrikstad'),('1531','Moss'),('3019','Drammen'),('8000','Bodø'),('8001','Bodø'),('8500','Narvik'),('8501','Narvik'),('9000','Tromsø'),('9001','Tromsø');
/*!40000 ALTER TABLE `poststed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefonliste`
--

DROP TABLE IF EXISTS `telefonliste`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefonliste` (
  `tel_nr` bigint NOT NULL,
  `kunde_kunde_nr` int DEFAULT NULL,
  PRIMARY KEY (`tel_nr`),
  UNIQUE KEY `tel_nr_UNIQUE` (`tel_nr`),
  KEY `fk_telefonliste_kunde1_idx` (`kunde_kunde_nr`),
  CONSTRAINT `fk_telefonliste_kunde1` FOREIGN KEY (`kunde_kunde_nr`) REFERENCES `kunde` (`kunde_nr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefonliste`
--

LOCK TABLES `telefonliste` WRITE;
/*!40000 ALTER TABLE `telefonliste` DISABLE KEYS */;
INSERT INTO `telefonliste` VALUES (90099888,8988),(76900111,10002),(99988877,10002),(70766554,11122),(22122333,20011),(76900112,20011),(99988777,20011),(90129402,20017);
/*!40000 ALTER TABLE `telefonliste` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utleie`
--

DROP TABLE IF EXISTS `utleie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utleie` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `utstyr_id` int NOT NULL,
  `instans_id` int NOT NULL,
  `kunde_nr` int NOT NULL,
  `utleid_dato` date NOT NULL,
  `innlevert_dato` date DEFAULT NULL,
  `betalingsmåte` varchar(45) DEFAULT NULL,
  `leveres` tinyint NOT NULL,
  `leveringskostnad` decimal(10,0) DEFAULT NULL,
  `behandler_id` int NOT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `fk_utleie_kundebehandler1_idx` (`behandler_id`),
  KEY `fk_utleie_instans_utstyr1_idx` (`instans_id`,`utstyr_id`),
  KEY `fk_utleie_kunde1_idx` (`kunde_nr`),
  CONSTRAINT `fk_utleie_instans_utstyr1` FOREIGN KEY (`instans_id`, `utstyr_id`) REFERENCES `instans_utstyr` (`instans_id`, `utstyr_id`),
  CONSTRAINT `fk_utleie_kunde1` FOREIGN KEY (`kunde_nr`) REFERENCES `kunde` (`kunde_nr`),
  CONSTRAINT `fk_utleie_kundebehandler1` FOREIGN KEY (`behandler_id`) REFERENCES `brukerliste` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utleie`
--

LOCK TABLES `utleie` WRITE;
/*!40000 ALTER TABLE `utleie` DISABLE KEYS */;
INSERT INTO `utleie` VALUES (1,233,1,20011,'2021-02-01','2026-04-15','Kort',1,150,13),(2,233,2,20011,'2019-03-05','2019-03-06','Kontant',0,0,11),(3,234,1,11122,'2019-02-01','2019-02-03','Kort',0,0,12),(4,1001,1,10002,'2021-02-05','2021-02-08','Kontant',1,500,13),(5,7653,1,11122,'2021-02-05','2026-04-15','Kort',0,0,11),(6,7654,1,8988,'2020-02-04','2020-02-10','Vipps',1,200,11),(7,233,1,20011,'2026-04-10','2026-04-15','Vipps',0,0,14),(8,234,1,11122,'2026-04-12','2026-04-15','Kort',1,100,15),(9,1001,1,10002,'2026-04-13','2026-04-15','Kontant',0,0,10),(10,7653,1,8988,'2026-04-14','2026-04-15','Vipps',1,250,12),(11,233,2,20011,'2026-04-14','2026-04-15','Kort',0,0,13),(12,7654,1,11122,'2026-04-15','2026-04-15','Kontant',1,150,11),(13,234,1,20011,'2026-04-08','2026-04-15','Kort',1,200,10),(14,1001,1,11122,'2026-04-09','2026-04-15','Vipps',0,0,14),(15,233,2,8988,'2026-04-10','2026-04-15','Kontant',0,0,15),(16,7654,1,10002,'2026-04-11','2026-04-15','Kort',1,300,11),(17,7653,1,20011,'2026-04-11','2026-04-17','Vipps',1,150,12),(18,233,1,8988,'2026-04-12','2026-04-17','Kort',0,0,13),(19,234,1,11122,'2026-04-13','2026-04-15','Kontant',1,100,10),(20,1001,1,20011,'2026-04-14','2026-04-15','Vipps',0,0,15),(21,7654,1,8988,'2026-04-14','2026-04-17','Kort',1,250,14),(22,233,2,10002,'2026-04-15','2026-04-17','Kontant',0,0,11),(25,233,1,8988,'2026-04-17','2026-04-17','Kontant',0,0,10),(26,234,1,20011,'2026-04-17','2026-04-17','Vipps',1,500,10),(27,1001,1,10002,'2026-04-17','2026-04-17','Kort',1,250,10),(28,7654,1,8988,'2026-04-17','2026-04-17','Kontant',0,0,10),(29,233,2,20011,'2026-04-17','2026-04-17','Vipps',1,1000,10),(30,7653,1,20011,'2026-04-17','2026-04-17','Kontant',0,0,10),(31,234,1,8988,'2026-04-17','2026-04-17','Kontant',0,0,10),(32,233,2,11122,'2026-04-17','2026-04-17','Kontant',0,0,10),(33,1001,1,10002,'2026-04-17','2026-04-19','Kort',1,250,10),(34,7654,1,10002,'2026-04-17',NULL,'Kort',1,250,10),(35,233,1,20011,'2026-04-17','2026-04-19','Vipps',1,100000000,14),(36,234,1,20011,'2026-04-17',NULL,'Vipps',1,100000000,14),(37,7653,1,20012,'2026-04-19',NULL,'Kontant',1,500,10);
/*!40000 ALTER TABLE `utleie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `utleieoversikt`
--

DROP TABLE IF EXISTS `utleieoversikt`;
/*!50001 DROP VIEW IF EXISTS `utleieoversikt`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `utleieoversikt` AS SELECT 
 1 AS `utleie_id`,
 1 AS `kunde_nr`,
 1 AS `behandler_id`,
 1 AS `Navn`,
 1 AS `utstyr_id`,
 1 AS `instans_id`,
 1 AS `Merke`,
 1 AS `Modell`,
 1 AS `Type`,
 1 AS `Kategori`,
 1 AS `Utleid`,
 1 AS `Innlevert`,
 1 AS `Kundebehandler`,
 1 AS `Dognpris`,
 1 AS `Leveringskostnad`,
 1 AS `Betalingsmåte`,
 1 AS `Leveres`,
 1 AS `Leveringsadresse`,
 1 AS `Fakturaadresse`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `utstyrsoversikt`
--

DROP TABLE IF EXISTS `utstyrsoversikt`;
/*!50001 DROP VIEW IF EXISTS `utstyrsoversikt`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `utstyrsoversikt` AS SELECT 
 1 AS `instans_id`,
 1 AS `utstyr_id`,
 1 AS `type`,
 1 AS `merke`,
 1 AS `modell`,
 1 AS `kategori`,
 1 AS `status`,
 1 AS `siste_vedlikehold`,
 1 AS `neste_vedlikehold`,
 1 AS `antall_utleier`,
 1 AS `dager_uteleid_totalt`,
 1 AS `leiepris_døgn`,
 1 AS `beskrivelse`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `Utstyrutleie`
--

USE `Utstyrutleie`;

--
-- Final view structure for view `kundeoversikt`
--

/*!50001 DROP VIEW IF EXISTS `kundeoversikt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `kundeoversikt` AS select `k`.`kunde_nr` AS `KundeNr`,`k`.`navn` AS `Navn`,`k`.`type` AS `Type`,count(distinct `o`.`kunde_nr`,`o`.`utstyr_id`,`o`.`instans_id`,`o`.`utleid_dato`) AS `Antallordre`,`k`.`epost` AS `Epost`,group_concat(distinct `t`.`tel_nr` separator ', ') AS `telefonnummer`,`f`.`gate` AS `Faktura_gate`,`f`.`husnr` AS `Faktura_husnr`,`f`.`postnr` AS `Faktura_postnr`,`pf`.`poststed` AS `Faktura_poststed`,`l`.`gate` AS `Levering_gate`,`l`.`husnr` AS `Levering_husnr`,`l`.`postnr` AS `Levering_postnr`,`pl`.`poststed` AS `Levering_poststed` from ((((((`kunde` `k` left join `telefonliste` `t` on((`k`.`kunde_nr` = `t`.`kunde_kunde_nr`))) left join `adresseliste` `f` on((`k`.`faktura_adr` = `f`.`ID`))) left join `adresseliste` `l` on((`k`.`levering_adr` = `l`.`ID`))) left join `poststed` `pf` on((`f`.`postnr` = `pf`.`postnr`))) left join `poststed` `pl` on((`l`.`postnr` = `pl`.`postnr`))) left join `utleie` `o` on((`k`.`kunde_nr` = `o`.`kunde_nr`))) group by `KundeNr`,`k`.`navn`,`k`.`type`,`k`.`epost` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `utleieoversikt`
--

/*!50001 DROP VIEW IF EXISTS `utleieoversikt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `utleieoversikt` AS select `o`.`rental_id` AS `utleie_id`,`o`.`kunde_nr` AS `kunde_nr`,`b`.`user_id` AS `behandler_id`,`k`.`Navn` AS `Navn`,`o`.`utstyr_id` AS `utstyr_id`,`o`.`instans_id` AS `instans_id`,`u`.`merke` AS `Merke`,`u`.`modell` AS `Modell`,`u`.`type` AS `Type`,`u`.`kategori` AS `Kategori`,`o`.`utleid_dato` AS `Utleid`,`o`.`innlevert_dato` AS `Innlevert`,concat(`b`.`fornavn`,' ',`b`.`etternavn`) AS `Kundebehandler`,`u`.`leiepris_døgn` AS `Dognpris`,`o`.`leveringskostnad` AS `Leveringskostnad`,`o`.`betalingsmåte` AS `Betalingsmåte`,if((`o`.`leveres` = 1),'Ja','Nei') AS `Leveres`,concat(`k`.`Levering_gate`,' ',`k`.`Levering_husnr`,', ',`k`.`Levering_postnr`,' ',`k`.`Levering_poststed`) AS `Leveringsadresse`,concat(`k`.`Faktura_gate`,' ',`k`.`Faktura_husnr`,', ',`k`.`Faktura_postnr`,' ',`k`.`Faktura_poststed`) AS `Fakturaadresse` from (((`utleie` `o` left join `kundeoversikt` `k` on((`o`.`kunde_nr` = `k`.`KundeNr`))) left join `utstyrsoversikt` `u` on(((`o`.`utstyr_id` = `u`.`utstyr_id`) and (`o`.`instans_id` = `u`.`instans_id`)))) left join `brukerliste` `b` on((`o`.`behandler_id` = `b`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `utstyrsoversikt`
--

/*!50001 DROP VIEW IF EXISTS `utstyrsoversikt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `utstyrsoversikt` AS select `i`.`instans_id` AS `instans_id`,`i`.`utstyr_id` AS `utstyr_id`,`m`.`type` AS `type`,`m`.`merke` AS `merke`,`m`.`modell` AS `modell`,`m`.`kategori` AS `kategori`,(case when (sum((case when (`u`.`innlevert_dato` is null) then 1 else 0 end)) > 0) then 'Utleid' else 'Tilgjengelig' end) AS `status`,`i`.`siste_vedlikehold` AS `siste_vedlikehold`,`i`.`neste_vedlikehold` AS `neste_vedlikehold`,coalesce(sum((case when (`u`.`innlevert_dato` is not null) then 1 else 0 end)),0) AS `antall_utleier`,coalesce(sum((case when (`u`.`innlevert_dato` is not null) then (to_days(`u`.`innlevert_dato`) - to_days(`u`.`utleid_dato`)) else (to_days(curdate()) - to_days(`u`.`utleid_dato`)) end)),0) AS `dager_uteleid_totalt`,`m`.`leiepris_døgn` AS `leiepris_døgn`,`m`.`beskrivelse` AS `beskrivelse` from ((`instans_utstyr` `i` join `mal_utstyr` `m` on((`i`.`utstyr_id` = `m`.`utstyr_id`))) left join `utleie` `u` on(((`i`.`instans_id` = `u`.`instans_id`) and (`i`.`utstyr_id` = `u`.`utstyr_id`)))) group by `i`.`instans_id`,`i`.`utstyr_id`,`m`.`type`,`m`.`merke`,`m`.`modell`,`m`.`kategori`,`i`.`siste_vedlikehold`,`i`.`neste_vedlikehold`,`m`.`leiepris_døgn`,`m`.`beskrivelse` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-19 22:25:23
