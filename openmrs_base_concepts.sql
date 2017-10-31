-- MySQL dump 10.13  Distrib 5.6.37, for Linux (x86_64)
--
-- Host: localhost    Database: openmrs
-- ------------------------------------------------------
-- Server version	5.6.37

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
-- Table structure for table `address_hierarchy_address_to_entry_map`
--

DROP TABLE IF EXISTS `address_hierarchy_address_to_entry_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_hierarchy_address_to_entry_map` (
  `address_to_entry_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`address_to_entry_map_id`),
  KEY `address_id_to_person_address_table` (`address_id`),
  KEY `entry_id_to_address_hierarchy_table` (`entry_id`),
  CONSTRAINT `address_id_to_person_address_table` FOREIGN KEY (`address_id`) REFERENCES `person_address` (`person_address_id`),
  CONSTRAINT `entry_id_to_address_hierarchy_table` FOREIGN KEY (`entry_id`) REFERENCES `address_hierarchy_entry` (`address_hierarchy_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_hierarchy_address_to_entry_map`
--

LOCK TABLES `address_hierarchy_address_to_entry_map` WRITE;
/*!40000 ALTER TABLE `address_hierarchy_address_to_entry_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_hierarchy_address_to_entry_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_hierarchy_entry`
--

DROP TABLE IF EXISTS `address_hierarchy_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_hierarchy_entry` (
  `address_hierarchy_entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(160) DEFAULT NULL,
  `level_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_generated_id` varchar(11) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `elevation` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`address_hierarchy_entry_id`),
  KEY `parent_name` (`parent_id`,`name`(20)),
  KEY `level_name` (`level_id`,`name`(20)),
  KEY `address_hierarchy_entry_name_idx` (`name`(10)),
  CONSTRAINT `level_to_level` FOREIGN KEY (`level_id`) REFERENCES `address_hierarchy_level` (`address_hierarchy_level_id`),
  CONSTRAINT `parent-to-parent` FOREIGN KEY (`parent_id`) REFERENCES `address_hierarchy_entry` (`address_hierarchy_entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_hierarchy_entry`
--

LOCK TABLES `address_hierarchy_entry` WRITE;
/*!40000 ALTER TABLE `address_hierarchy_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_hierarchy_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_hierarchy_level`
--

DROP TABLE IF EXISTS `address_hierarchy_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_hierarchy_level` (
  `address_hierarchy_level_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(160) DEFAULT NULL,
  `parent_level_id` int(11) DEFAULT NULL,
  `address_field` varchar(50) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`address_hierarchy_level_id`),
  UNIQUE KEY `parent_level_id_unique` (`parent_level_id`),
  KEY `address_field_unique` (`address_field`),
  CONSTRAINT `parent_level` FOREIGN KEY (`parent_level_id`) REFERENCES `address_hierarchy_level` (`address_hierarchy_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_hierarchy_level`
--

LOCK TABLES `address_hierarchy_level` WRITE;
/*!40000 ALTER TABLE `address_hierarchy_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_hierarchy_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allergy`
--

DROP TABLE IF EXISTS `allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy` (
  `allergy_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `severity_concept_id` int(11) DEFAULT NULL,
  `coded_allergen` int(11) NOT NULL,
  `non_coded_allergen` varchar(255) DEFAULT NULL,
  `allergen_type` varchar(50) NOT NULL,
  `comment` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '1',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_id`),
  UNIQUE KEY `allergy_id` (`allergy_id`),
  KEY `allergy_patient_id_fk` (`patient_id`),
  KEY `allergy_coded_allergen_fk` (`coded_allergen`),
  KEY `allergy_severity_concept_id_fk` (`severity_concept_id`),
  KEY `allergy_creator_fk` (`creator`),
  KEY `allergy_changed_by_fk` (`changed_by`),
  KEY `allergy_voided_by_fk` (`voided_by`),
  CONSTRAINT `allergy_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `allergy_coded_allergen_fk` FOREIGN KEY (`coded_allergen`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `allergy_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `allergy_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `allergy_severity_concept_id_fk` FOREIGN KEY (`severity_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `allergy_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy`
--

LOCK TABLES `allergy` WRITE;
/*!40000 ALTER TABLE `allergy` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allergy_reaction`
--

DROP TABLE IF EXISTS `allergy_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy_reaction` (
  `allergy_reaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `allergy_id` int(11) NOT NULL,
  `reaction_concept_id` int(11) NOT NULL,
  `reaction_non_coded` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_reaction_id`),
  UNIQUE KEY `allergy_reaction_id` (`allergy_reaction_id`),
  KEY `allergy_reaction_allergy_id_fk` (`allergy_id`),
  KEY `allergy_reaction_reaction_concept_id_fk` (`reaction_concept_id`),
  CONSTRAINT `allergy_reaction_allergy_id_fk` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`allergy_id`),
  CONSTRAINT `allergy_reaction_reaction_concept_id_fk` FOREIGN KEY (`reaction_concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy_reaction`
--

LOCK TABLES `allergy_reaction` WRITE;
/*!40000 ALTER TABLE `allergy_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy_reaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appframework_component_state`
--

DROP TABLE IF EXISTS `appframework_component_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appframework_component_state` (
  `component_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `component_id` varchar(255) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`component_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appframework_component_state`
--

LOCK TABLES `appframework_component_state` WRITE;
/*!40000 ALTER TABLE `appframework_component_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `appframework_component_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appframework_user_app`
--

DROP TABLE IF EXISTS `appframework_user_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appframework_user_app` (
  `app_id` varchar(50) NOT NULL,
  `json` mediumtext NOT NULL,
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appframework_user_app`
--

LOCK TABLES `appframework_user_app` WRITE;
/*!40000 ALTER TABLE `appframework_user_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `appframework_user_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_service`
--

DROP TABLE IF EXISTS `appointment_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_service` (
  `appointment_service_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  `max_appointments_limit` int(11) DEFAULT NULL,
  `duration_mins` int(11) DEFAULT NULL,
  `color` varchar(8) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(4) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  PRIMARY KEY (`appointment_service_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_appointment_service_speciality_idx` (`speciality_id`),
  KEY `fk_appointment_service_location_idx` (`location_id`),
  CONSTRAINT `fk_appointment_service_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `fk_appointment_service_speciality` FOREIGN KEY (`speciality_id`) REFERENCES `appointment_speciality` (`speciality_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_service`
--

LOCK TABLES `appointment_service` WRITE;
/*!40000 ALTER TABLE `appointment_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_service_type`
--

DROP TABLE IF EXISTS `appointment_service_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_service_type` (
  `appointment_service_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_service_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `duration_mins` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(4) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  PRIMARY KEY (`appointment_service_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_appointment_service_idx` (`appointment_service_id`),
  CONSTRAINT `fk_appointment_service` FOREIGN KEY (`appointment_service_id`) REFERENCES `appointment_service` (`appointment_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_service_type`
--

LOCK TABLES `appointment_service_type` WRITE;
/*!40000 ALTER TABLE `appointment_service_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_service_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_service_weekly_availability`
--

DROP TABLE IF EXISTS `appointment_service_weekly_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_service_weekly_availability` (
  `service_weekly_availability_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `day_of_week` varchar(45) NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `max_appointments_limit` int(11) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  `voided` tinyint(4) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`service_weekly_availability_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_weekly_availability_appointment_service_idx` (`service_id`),
  KEY `service_enterer` (`creator`),
  KEY `user_who_deleted_service` (`voided_by`),
  CONSTRAINT `appointment_service` FOREIGN KEY (`service_id`) REFERENCES `appointment_service` (`appointment_service_id`),
  CONSTRAINT `service_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_deleted_service` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_service_weekly_availability`
--

LOCK TABLES `appointment_service_weekly_availability` WRITE;
/*!40000 ALTER TABLE `appointment_service_weekly_availability` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_service_weekly_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment_speciality`
--

DROP TABLE IF EXISTS `appointment_speciality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_speciality` (
  `speciality_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  `voided` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`speciality_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_speciality`
--

LOCK TABLES `appointment_speciality` WRITE;
/*!40000 ALTER TABLE `appointment_speciality` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment_speciality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit_log` (
  `audit_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `event_type` varchar(100) NOT NULL,
  `message` longblob NOT NULL,
  `date_created` datetime NOT NULL,
  `uuid` varchar(38) NOT NULL,
  `module` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`audit_log_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_patient_id` (`patient_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `audit_log_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,1,NULL,'VIEWED_REGISTRATION_PATIENT_SEARCH','VIEWED_REGISTRATION_PATIENT_SEARCH_MESSAGE','2017-10-30 15:28:43','0f1abd05-e338-4e84-bf1c-afc96b2e0dda','MODULE_LABEL_REGISTRATION_KEY'),(2,1,NULL,'VIEWED_NEW_PATIENT_PAGE','VIEWED_NEW_PATIENT_PAGE_MESSAGE','2017-10-30 15:28:44','2ba81a72-a1d1-485f-a51f-6f3125831570','MODULE_LABEL_REGISTRATION_KEY');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bahmni_config`
--

DROP TABLE IF EXISTS `bahmni_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bahmni_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_name` varchar(255) NOT NULL,
  `app_name` varchar(255) NOT NULL,
  `config` longtext NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `bahmni_config_unique_app_config_name` (`config_name`,`app_name`),
  UNIQUE KEY `bahmni_config_unique_uuid` (`uuid`),
  KEY `bahmni_config_creator_fk` (`creator`),
  KEY `bahmni_config_changed_by_fk` (`changed_by`),
  CONSTRAINT `bahmni_config_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bahmni_config_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bahmni_config`
--

LOCK TABLES `bahmni_config` WRITE;
/*!40000 ALTER TABLE `bahmni_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `bahmni_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bahmni_config_version`
--

DROP TABLE IF EXISTS `bahmni_config_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bahmni_config_version` (
  `config_version_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_uuid` char(38) NOT NULL,
  `config_diff` blob NOT NULL,
  `date_created` datetime NOT NULL,
  `version_name` varchar(255) NOT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`config_version_id`),
  UNIQUE KEY `bahmni_config_unique_version_name` (`version_name`),
  UNIQUE KEY `bahmni_config_version_unique_uuid` (`uuid`),
  KEY `bahmni_config_uuid_fk` (`config_uuid`),
  CONSTRAINT `bahmni_config_uuid_fk` FOREIGN KEY (`config_uuid`) REFERENCES `bahmni_config` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bahmni_config_version`
--

LOCK TABLES `bahmni_config_version` WRITE;
/*!40000 ALTER TABLE `bahmni_config_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `bahmni_config_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed` (
  `bed_id` int(11) NOT NULL AUTO_INCREMENT,
  `bed_number` varchar(50) NOT NULL,
  `status` varchar(255) DEFAULT 'AVAILABLE',
  `bed_type_id` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bed_id`),
  UNIQUE KEY `bed_unique_uuid` (`uuid`),
  KEY `bed_bed_type_fk` (`bed_type_id`),
  KEY `bed_creator` (`creator`),
  KEY `bed_changed_by_fk` (`changed_by`),
  KEY `bed_voided_by_fk` (`voided_by`),
  CONSTRAINT `bed_bed_type_fk` FOREIGN KEY (`bed_type_id`) REFERENCES `bed_type` (`bed_type_id`),
  CONSTRAINT `bed_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed`
--

LOCK TABLES `bed` WRITE;
/*!40000 ALTER TABLE `bed` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_location_map`
--

DROP TABLE IF EXISTS `bed_location_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_location_map` (
  `bed_location_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `row_number` smallint(6) NOT NULL,
  `column_number` smallint(6) NOT NULL,
  `bed_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bed_location_map_id`),
  KEY `bed_location_map_location_fk` (`location_id`),
  CONSTRAINT `bed_location_map_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_location_map`
--

LOCK TABLES `bed_location_map` WRITE;
/*!40000 ALTER TABLE `bed_location_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_location_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_patient_assignment_map`
--

DROP TABLE IF EXISTS `bed_patient_assignment_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_patient_assignment_map` (
  `bed_patient_assignment_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `bed_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bed_patient_assignment_map_id`),
  UNIQUE KEY `bed_unique_uuid` (`uuid`),
  KEY `bed_id_fk` (`bed_id`),
  KEY `bed_patient_assignment_map_patient_fk` (`patient_id`),
  KEY `bed_patient_assignment_map_encounter_fk` (`encounter_id`),
  KEY `bed_patient_assignment_map_creator` (`creator`),
  KEY `bed_patient_assignment_map_changed_by_fk` (`changed_by`),
  KEY `bed_patient_assignment_map_voided_by_fk` (`voided_by`),
  KEY `bed_patient_assignment_map_date_stopped` (`date_stopped`),
  CONSTRAINT `bed_id_fk` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`bed_id`),
  CONSTRAINT `bed_patient_assignment_map_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_patient_assignment_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_patient_assignment_map_encounter_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `bed_patient_assignment_map_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `bed_patient_assignment_map_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_patient_assignment_map`
--

LOCK TABLES `bed_patient_assignment_map` WRITE;
/*!40000 ALTER TABLE `bed_patient_assignment_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_patient_assignment_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_tag`
--

DROP TABLE IF EXISTS `bed_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_tag` (
  `bed_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`bed_tag_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `bed_tag_creator_fk` (`creator`),
  KEY `bed_tag_changed_by_fk` (`changed_by`),
  KEY `bed_tag_voided_by_fk` (`voided_by`),
  CONSTRAINT `bed_tag_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_tag_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_tag_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_tag`
--

LOCK TABLES `bed_tag` WRITE;
/*!40000 ALTER TABLE `bed_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_tag_map`
--

DROP TABLE IF EXISTS `bed_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_tag_map` (
  `bed_tag_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `bed_id` int(11) NOT NULL,
  `bed_tag_id` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bed_tag_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `bed_tag_map_bed_fk` (`bed_id`),
  KEY `bed_tag_map_tag_fk` (`bed_tag_id`),
  KEY `bed_tag_map_creator_fk` (`creator`),
  KEY `bed_tag_map_changed_by_fk` (`changed_by`),
  KEY `bed_tag_map_voided_by_fk` (`voided_by`),
  CONSTRAINT `bed_tag_map_bed_fk` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`bed_id`),
  CONSTRAINT `bed_tag_map_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_tag_map_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bed_tag_map_tag_fk` FOREIGN KEY (`bed_tag_id`) REFERENCES `bed_tag` (`bed_tag_id`),
  CONSTRAINT `bed_tag_map_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_tag_map`
--

LOCK TABLES `bed_tag_map` WRITE;
/*!40000 ALTER TABLE `bed_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed_type`
--

DROP TABLE IF EXISTS `bed_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_type` (
  `bed_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(10) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bed_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed_type`
--

LOCK TABLES `bed_type` WRITE;
/*!40000 ALTER TABLE `bed_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `bed_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calculation_registration`
--

DROP TABLE IF EXISTS `calculation_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calculation_registration` (
  `calculation_registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `provider_class_name` varchar(512) NOT NULL,
  `calculation_name` varchar(512) NOT NULL,
  `configuration` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`calculation_registration_id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calculation_registration`
--

LOCK TABLES `calculation_registration` WRITE;
/*!40000 ALTER TABLE `calculation_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `calculation_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `care_setting`
--

DROP TABLE IF EXISTS `care_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `care_setting` (
  `care_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `care_setting_type` varchar(50) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`care_setting_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name` (`name`),
  KEY `care_setting_creator` (`creator`),
  KEY `care_setting_retired_by` (`retired_by`),
  KEY `care_setting_changed_by` (`changed_by`),
  CONSTRAINT `care_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `care_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `care_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `care_setting`
--

LOCK TABLES `care_setting` WRITE;
/*!40000 ALTER TABLE `care_setting` DISABLE KEYS */;
INSERT INTO `care_setting` VALUES (1,'Outpatient','Out-patient care setting','OUTPATIENT',1,'2013-12-27 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'6f0c9a92-6f24-11e3-af88-005056821db0'),(2,'Inpatient','In-patient care setting','INPATIENT',1,'2013-12-27 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'c365e560-c3ec-11e3-9c1a-0800200c9a66');
/*!40000 ALTER TABLE `care_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chunking_history`
--

DROP TABLE IF EXISTS `chunking_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chunking_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chunk_length` bigint(20) DEFAULT NULL,
  `start` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chunking_history`
--

LOCK TABLES `chunking_history` WRITE;
/*!40000 ALTER TABLE `chunking_history` DISABLE KEYS */;
INSERT INTO `chunking_history` VALUES (1,5,1);
/*!40000 ALTER TABLE `chunking_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clob_datatype_storage`
--

DROP TABLE IF EXISTS `clob_datatype_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clob_datatype_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `clob_datatype_storage_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clob_datatype_storage`
--

LOCK TABLES `clob_datatype_storage` WRITE;
/*!40000 ALTER TABLE `clob_datatype_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `clob_datatype_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `cohort_uuid_index` (`uuid`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_cohort` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_cohort` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort`
--

LOCK TABLES `cohort` WRITE;
/*!40000 ALTER TABLE `cohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `cohort_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `member_patient` (`patient_id`),
  KEY `cohort_member_creator` (`creator`),
  KEY `parent_cohort` (`cohort_id`),
  CONSTRAINT `cohort_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort_member`
--

LOCK TABLES `cohort_member` WRITE;
/*!40000 ALTER TABLE `cohort_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `short_name` varchar(255) DEFAULT NULL,
  `description` text,
  `form_text` text,
  `datatype_id` int(11) NOT NULL DEFAULT '0',
  `class_id` int(11) NOT NULL DEFAULT '0',
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `concept_uuid_index` (`uuid`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`),
  CONSTRAINT `user_who_changed_concept` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept`
--

LOCK TABLES `concept` WRITE;
/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
INSERT INTO `concept` VALUES (1,0,'','',NULL,4,11,0,1,'2016-03-07 11:44:32',NULL,1,'2017-10-30 14:58:51',NULL,NULL,NULL,'033a436b-dad8-4079-8b78-d4e092e2731a'),(2,0,'','',NULL,4,11,0,1,'2016-03-07 11:44:32',NULL,1,'2017-10-30 14:59:56',NULL,NULL,NULL,'1e208f48-55ab-4f20-852d-04f6ca536f36'),(3,0,NULL,NULL,NULL,4,10,1,1,'2013-07-23 11:26:35',NULL,1,'2013-07-23 11:26:35',NULL,NULL,NULL,'7e06a142-e42f-11e5-8c3e-08002715d519'),(4,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e16cd3c-e42f-11e5-8c3e-08002715d519'),(5,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e190361-e42f-11e5-8c3e-08002715d519'),(6,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1abf11-e42f-11e5-8c3e-08002715d519'),(7,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1c3578-e42f-11e5-8c3e-08002715d519'),(8,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1e15a9-e42f-11e5-8c3e-08002715d519'),(9,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1ebf76-e42f-11e5-8c3e-08002715d519'),(10,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1ee132-e42f-11e5-8c3e-08002715d519'),(11,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1f29f1-e42f-11e5-8c3e-08002715d519'),(12,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e1f7103-e42f-11e5-8c3e-08002715d519'),(13,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e24d07f-e42f-11e5-8c3e-08002715d519'),(14,0,NULL,NULL,NULL,3,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2524c9-e42f-11e5-8c3e-08002715d519'),(15,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2575ee-e42f-11e5-8c3e-08002715d519'),(16,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e25bd20-e42f-11e5-8c3e-08002715d519'),(17,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e264499-e42f-11e5-8c3e-08002715d519'),(18,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2690d3-e42f-11e5-8c3e-08002715d519'),(19,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e27077d-e42f-11e5-8c3e-08002715d519'),(20,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e277357-e42f-11e5-8c3e-08002715d519'),(21,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e27c7b1-e42f-11e5-8c3e-08002715d519'),(22,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2a1581-e42f-11e5-8c3e-08002715d519'),(23,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2a579f-e42f-11e5-8c3e-08002715d519'),(24,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2a96f5-e42f-11e5-8c3e-08002715d519'),(25,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2af61f-e42f-11e5-8c3e-08002715d519'),(26,0,NULL,NULL,NULL,4,11,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2b720f-e42f-11e5-8c3e-08002715d519'),(27,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2bdbd0-e42f-11e5-8c3e-08002715d519'),(28,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2db26b-e42f-11e5-8c3e-08002715d519'),(29,0,NULL,NULL,NULL,4,11,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e2f6bf1-e42f-11e5-8c3e-08002715d519'),(30,0,NULL,NULL,NULL,4,11,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e324ebf-e42f-11e5-8c3e-08002715d519'),(31,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e3c5622-e42f-11e5-8c3e-08002715d519'),(32,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e3c7ba1-e42f-11e5-8c3e-08002715d519'),(33,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e3c9c77-e42f-11e5-8c3e-08002715d519'),(34,0,'Adt Notes','Adt Notes',NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e3e0fa6-e42f-11e5-8c3e-08002715d519'),(35,0,'Document','Document',NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e43559a-e42f-11e5-8c3e-08002715d519'),(36,0,NULL,NULL,NULL,4,5,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e52e57e-e42f-11e5-8c3e-08002715d519'),(37,0,NULL,NULL,NULL,3,5,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e53413d-e42f-11e5-8c3e-08002715d519'),(38,0,NULL,NULL,NULL,3,5,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e538a2a-e42f-11e5-8c3e-08002715d519'),(39,0,NULL,NULL,NULL,1,5,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e53d023-e42f-11e5-8c3e-08002715d519'),(40,0,NULL,NULL,NULL,1,5,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e541b2b-e42f-11e5-8c3e-08002715d519'),(41,0,NULL,NULL,NULL,10,5,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e546164-e42f-11e5-8c3e-08002715d519'),(42,0,NULL,NULL,NULL,10,11,1,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e60a750-e42f-11e5-8c3e-08002715d519'),(44,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:33',NULL,1,'2016-03-07 12:10:33',NULL,NULL,NULL,'7e66764b-e42f-11e5-8c3e-08002715d519'),(45,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:33',NULL,NULL,NULL,NULL,NULL,NULL,'7e67abb5-e42f-11e5-8c3e-08002715d519'),(46,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:34',NULL,NULL,NULL,NULL,NULL,NULL,'7e69433d-e42f-11e5-8c3e-08002715d519'),(47,0,NULL,NULL,NULL,10,5,0,1,'2016-03-07 12:10:34',NULL,NULL,NULL,NULL,NULL,NULL,'7e697913-e42f-11e5-8c3e-08002715d519'),(48,0,NULL,NULL,NULL,4,11,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7e6c4007-e42f-11e5-8c3e-08002715d519'),(49,0,NULL,NULL,NULL,2,11,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7e735416-e42f-11e5-8c3e-08002715d519'),(50,0,NULL,NULL,NULL,3,11,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7e737708-e42f-11e5-8c3e-08002715d519'),(51,0,NULL,NULL,NULL,10,11,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7e7395c4-e42f-11e5-8c3e-08002715d519'),(52,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7e753542-e42f-11e5-8c3e-08002715d519'),(53,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7e78280e-e42f-11e5-8c3e-08002715d519'),(55,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:34',NULL,1,'2017-10-30 14:24:34',NULL,NULL,NULL,'7ea60429-e42f-11e5-8c3e-08002715d519'),(63,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:34',NULL,1,'2017-10-30 14:25:06',NULL,NULL,NULL,'7ea9af58-e42f-11e5-8c3e-08002715d519'),(73,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7eafb27b-e42f-11e5-8c3e-08002715d519'),(79,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:34',NULL,1,'2017-10-30 14:37:36',NULL,NULL,NULL,'7eb425fa-e42f-11e5-8c3e-08002715d519'),(88,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7eb83ffc-e42f-11e5-8c3e-08002715d519'),(89,0,NULL,NULL,NULL,3,25,1,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7ec9ab24-e42f-11e5-8c3e-08002715d519'),(93,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:34',NULL,1,'2016-03-07 12:10:34',NULL,NULL,NULL,'7efa591c-e42f-11e5-8c3e-08002715d519'),(94,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f144927-e42f-11e5-8c3e-08002715d519'),(96,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f165c6d-e42f-11e5-8c3e-08002715d519'),(119,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f5a7e90-e42f-11e5-8c3e-08002715d519'),(125,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f670e33-e42f-11e5-8c3e-08002715d519'),(126,0,NULL,NULL,NULL,4,11,1,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f6b5bad-e42f-11e5-8c3e-08002715d519'),(127,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f6f7971-e42f-11e5-8c3e-08002715d519'),(128,0,NULL,NULL,NULL,10,11,0,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f748379-e42f-11e5-8c3e-08002715d519'),(129,0,NULL,NULL,NULL,4,10,1,1,'2016-03-07 12:10:35',NULL,1,'2016-03-07 12:10:35',NULL,NULL,NULL,'7f84e270-e42f-11e5-8c3e-08002715d519'),(130,0,NULL,NULL,NULL,1,10,1,1,'2016-03-07 12:10:36',NULL,1,'2016-03-07 12:10:36',NULL,NULL,NULL,'801a22dc-e42f-11e5-8c3e-08002715d519'),(131,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:36',NULL,1,'2016-03-07 12:10:36',NULL,NULL,NULL,'80215a4d-e42f-11e5-8c3e-08002715d519'),(132,0,NULL,NULL,NULL,2,7,0,1,'2016-03-07 12:10:36',NULL,1,'2016-03-07 12:10:36',NULL,NULL,NULL,'802c213f-e42f-11e5-8c3e-08002715d519'),(133,0,NULL,NULL,NULL,4,11,0,1,'2016-03-07 12:10:36',NULL,1,'2016-03-07 12:10:36',NULL,NULL,NULL,'802c7c8d-e42f-11e5-8c3e-08002715d519'),(134,0,NULL,NULL,NULL,4,11,1,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d144a0-e42f-11e5-8c3e-08002715d519'),(135,0,NULL,NULL,NULL,6,11,0,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d1c312-e42f-11e5-8c3e-08002715d519'),(136,0,NULL,NULL,NULL,2,11,0,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d25db2-e42f-11e5-8c3e-08002715d519'),(137,0,NULL,NULL,NULL,3,14,0,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d2e6cb-e42f-11e5-8c3e-08002715d519'),(138,0,NULL,NULL,NULL,4,17,1,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d3921f-e42f-11e5-8c3e-08002715d519'),(139,0,NULL,NULL,NULL,4,18,1,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d3da61-e42f-11e5-8c3e-08002715d519'),(140,0,NULL,NULL,NULL,3,11,0,1,'2016-03-07 12:10:38',NULL,1,'2016-03-07 12:10:38',NULL,NULL,NULL,'80d8c9df-e42f-11e5-8c3e-08002715d519'),(141,0,NULL,NULL,NULL,4,11,1,1,'2017-04-04 15:47:14',NULL,1,'2017-04-04 15:47:14',NULL,NULL,NULL,'df91f350-191f-11e7-bbfc-9206fc7c228b'),(142,0,NULL,NULL,NULL,3,7,0,1,'2017-10-30 14:22:08',NULL,1,'2017-10-30 14:22:08',NULL,NULL,NULL,'9c8bda0f-bd4f-11e7-8025-08002715d519'),(143,0,NULL,NULL,NULL,3,11,0,1,'2017-10-30 14:22:08',NULL,1,'2017-10-30 14:22:08',NULL,NULL,NULL,'9c968cdc-bd4f-11e7-8025-08002715d519'),(144,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'c67b91fb-3661-49d6-9bd1-612a40ab27d1'),(145,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'1d74dce0-4565-4069-8476-68524d609fb3'),(146,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'e7e86b09-493a-4029-8cab-ded4b013c368'),(147,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'53bfaec7-1507-419f-932b-ad0ce59b7081'),(148,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'02e88d78-b40d-4165-8c1d-fe371401f0da'),(149,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'a1d96f91-76c9-49d5-8ae4-b0e589f47dda'),(150,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'f12cf6c2-74ce-42ed-8d53-0ffa14aada68'),(151,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:47',NULL,1,'2017-10-31 11:52:47',NULL,NULL,NULL,'1ce06e0f-72dc-466f-b6ab-f181e42b6019'),(152,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'0922ea82-faa0-48a5-9953-01a44c5d4451'),(153,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'705fc29c-521d-406b-b309-6dc45a1cb78a'),(154,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'33c472b7-b0c2-4485-b0eb-ede7948355ae'),(155,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'53f23dfc-906e-4d04-8605-4beb36218747'),(156,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'0c458690-558b-494c-ae3c-7539ca581bf9'),(157,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'f15ea1b8-4de8-4305-a030-07c9e1df5aac'),(158,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'8bc7bbfb-8a61-4b2d-9570-392be6d6a551'),(159,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'79cf9862-e692-4196-af5a-1f8ae9cc17ce'),(160,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'f29e7a79-5b60-47f6-bb7c-495234158552'),(161,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'8698fe67-0bef-4c96-8265-607a389748ad'),(162,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'ff040d2f-9511-4943-8248-47e8875c7469'),(163,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'21d5b498-b9e7-4785-8c50-f9e02cbf61d7'),(164,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'11ea5858-56eb-4f82-a522-74874661389a'),(165,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'e5b51b8a-8229-455d-a474-e2ce535150ee'),(166,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'7adf1bb4-a2e6-4471-a26d-9cffb9b6018a'),(167,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:48',NULL,1,'2017-10-31 11:52:48',NULL,NULL,NULL,'73ad1b12-55dc-41ac-a88f-a36f7f52b35a'),(168,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'ee96fd39-aa3a-4c15-9b82-62d02d2b8edf'),(169,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'f7ef52e6-3f4a-4258-9ab9-08f9879de0c9'),(170,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'a0d43a75-b410-4fc5-a975-e9bf498bc5a2'),(171,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'f7396e70-b0a0-49af-b011-9181f15cf9c3'),(172,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'6f462f6c-07ee-4166-aec4-9b9235b88ca0'),(173,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'3c515ee7-8b34-4e45-a7e2-67c8bfec28c9'),(174,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'714dd11c-4649-4067-98d3-9afecc038436'),(175,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'d52fa76f-1414-486d-9bfc-3ad61fb25195'),(176,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'54371ed8-a757-4b14-a580-c1147615fdbd'),(177,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'49c1da13-8703-453d-9902-90da3daa2dfb'),(178,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'43b375d0-f5c5-43e3-aec2-e760563d7941'),(179,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'3d0c2de9-54f0-4132-94dd-fa46faaaa830'),(180,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'389bbf20-375b-4810-9be0-02f1b7ef5bf0'),(181,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'fe134c2d-baaa-4542-b2ec-e8f25e28a2a9'),(182,0,NULL,NULL,NULL,4,11,0,1,'2017-10-31 11:52:49',NULL,1,'2017-10-31 11:52:49',NULL,NULL,NULL,'e8bb2f33-3261-44ff-8af5-be8e2e01c5c2'),(183,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'8793893f-e75c-4254-8b4b-b00e82322fdb'),(184,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'df2efc25-1928-4b12-b92c-1c0fee2f5c91'),(185,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'ce4d9e75-0638-4634-af57-9fe574e7c47d'),(186,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'9aca2cb2-b024-4d73-b565-55de7b4ac9cc'),(187,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'422e2637-0e2e-4fb2-bfea-71550ad521c4'),(188,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'f19f321f-287c-4626-8581-f4d7614532c4'),(189,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'e09f268d-16f5-4be8-9633-46dc80605707'),(190,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'8c125c6d-3309-48cb-82f1-8486882b6fca'),(191,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'6132ce51-e427-4788-8954-3b38a8fd653f'),(192,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'612e315d-076b-4c7d-8c1d-ef127a4c7dba'),(193,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'8a6f755a-25fb-429a-accf-a92e25393074'),(194,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'f8d69cff-1538-4568-ae30-05f7a3fa6f51'),(195,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'c1a16626-8a76-4f3a-a0eb-393dd4078686'),(196,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:50',NULL,1,'2017-10-31 11:52:50',NULL,NULL,NULL,'37643092-7fd9-412e-8a8b-002fa1fff0c5'),(197,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:51',NULL,1,'2017-10-31 11:52:51',NULL,NULL,NULL,'d044ab05-f41e-47fc-b9b2-734b8fd64fed'),(198,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:51',NULL,1,'2017-10-31 11:52:51',NULL,NULL,NULL,'8fac5097-a7e4-4669-b943-d896ee5aa0c2'),(199,0,NULL,NULL,NULL,4,16,0,1,'2017-10-31 11:52:51',NULL,1,'2017-10-31 11:52:51',NULL,NULL,NULL,'d70b573b-fd96-4be9-8b44-8324835402d0');
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `concept_answer_uuid_index` (`uuid`),
  KEY `answer` (`answer_concept`),
  KEY `answers_for_concept` (`concept_id`),
  KEY `answer_creator` (`creator`),
  KEY `answer_answer_drug_fk` (`answer_drug`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_answer_drug_fk` FOREIGN KEY (`answer_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_answer`
--

LOCK TABLES `concept_answer` WRITE;
/*!40000 ALTER TABLE `concept_answer` DISABLE KEYS */;
INSERT INTO `concept_answer` VALUES (1,4,5,NULL,1,'2016-03-07 12:10:33',1,'7e1926eb-e42f-11e5-8c3e-08002715d519'),(2,4,6,NULL,1,'2016-03-07 12:10:33',2,'7e1bf0a5-e42f-11e5-8c3e-08002715d519'),(3,4,7,NULL,1,'2016-03-07 12:10:33',3,'7e1ddf8c-e42f-11e5-8c3e-08002715d519'),(4,4,8,NULL,1,'2016-03-07 12:10:33',4,'7e1e36e0-e42f-11e5-8c3e-08002715d519'),(5,9,10,NULL,1,'2016-03-07 12:10:33',1,'7e1efd49-e42f-11e5-8c3e-08002715d519'),(6,9,11,NULL,1,'2016-03-07 12:10:33',2,'7e1f440a-e42f-11e5-8c3e-08002715d519'),(7,9,12,NULL,1,'2016-03-07 12:10:33',3,'7e1f87a1-e42f-11e5-8c3e-08002715d519'),(8,16,17,NULL,1,'2016-03-07 12:10:33',1,'7e26d8c8-e42f-11e5-8c3e-08002715d519'),(9,16,18,NULL,1,'2016-03-07 12:10:33',1,'7e26ed1a-e42f-11e5-8c3e-08002715d519'),(10,19,20,NULL,1,'2016-03-07 12:10:33',1,'7e281c7e-e42f-11e5-8c3e-08002715d519'),(11,19,21,NULL,1,'2016-03-07 12:10:33',1,'7e282fdd-e42f-11e5-8c3e-08002715d519'),(12,25,22,NULL,1,'2016-03-07 12:10:33',10,'7e2b365d-e42f-11e5-8c3e-08002715d519'),(13,25,23,NULL,1,'2016-03-07 12:10:33',100,'7e2b46ae-e42f-11e5-8c3e-08002715d519'),(14,25,24,NULL,1,'2016-03-07 12:10:33',200,'7e2b5964-e42f-11e5-8c3e-08002715d519'),(15,25,127,NULL,1,'2016-03-07 12:10:35',3,'7f6fcf6b-e42f-11e5-8c3e-08002715d519'),(16,132,133,NULL,1,'2016-03-07 12:10:36',1,'802ca41f-e42f-11e5-8c3e-08002715d519');
/*!40000 ALTER TABLE `concept_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute`
--

DROP TABLE IF EXISTS `concept_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute` (
  `concept_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_concept_fk` (`concept_id`),
  KEY `concept_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `concept_attribute_creator_fk` (`creator`),
  KEY `concept_attribute_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `concept_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `concept_attribute_type` (`concept_attribute_type_id`),
  CONSTRAINT `concept_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_concept_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `concept_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute`
--

LOCK TABLES `concept_attribute` WRITE;
/*!40000 ALTER TABLE `concept_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute_type`
--

DROP TABLE IF EXISTS `concept_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute_type` (
  `concept_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_type_creator_fk` (`creator`),
  KEY `concept_attribute_type_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `concept_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute_type`
--

LOCK TABLES `concept_attribute_type` WRITE;
/*!40000 ALTER TABLE `concept_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `concept_class_uuid_index` (`uuid`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `concept_class_creator` (`creator`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  KEY `concept_class_name_index` (`name`),
  KEY `concept_class_changed_by` (`changed_by`),
  CONSTRAINT `concept_class_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_class` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_class`
--

LOCK TABLES `concept_class` WRITE;
/*!40000 ALTER TABLE `concept_class` DISABLE KEYS */;
INSERT INTO `concept_class` VALUES (1,'Test','Acq. during patient encounter (vitals, labs, etc.)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4907b2-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(2,'Procedure','Describes a clinical procedure',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d490bf4-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(3,'Drug','Drug',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d490dfc-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(4,'Diagnosis','Conclusion drawn through findings',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4918b0-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(5,'Finding','Practitioner observation/finding',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491a9a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(6,'Anatomy','Anatomic sites / descriptors',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491c7a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(7,'Question','Question (eg, patient history, SF36 items)',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491e50-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(8,'LabSet','Panels',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492026-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(9,'MedSet','Term to describe medication sets',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4923b4-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(10,'ConvSet','Term to describe convenience sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492594-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(11,'Misc','Terms which don\'t fit other categories',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492774-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(12,'Symptom','Patient-reported observation',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492954-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(13,'Symptom/Finding','Observation that can be reported from patient or found on exam',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492b2a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(14,'Specimen','Body or fluid specimen',1,'2004-12-02 00:00:00',0,NULL,NULL,NULL,'8d492d0a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(15,'Misc Order','Orderable items which aren\'t tests or drugs',1,'2005-02-17 00:00:00',0,NULL,NULL,NULL,'8d492ee0-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(16,'Frequency','A class for order frequencies',1,'2014-03-06 00:00:00',0,NULL,NULL,NULL,'8e071bfe-520c-44c0-a89b-538e9129b42a',NULL,NULL),(17,'Bacteriology Attributes','Bacteriology Attributes Concept Class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'ff1e8d17-e42d-11e5-8c3e-08002715d519',NULL,NULL),(18,'Bacteriology Results','Bacteriology Results Concept Class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'ff20b54c-e42d-11e5-8c3e-08002715d519',NULL,NULL),(19,'Concept Attribute','Concept Attribute class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e7b3121-e42f-11e5-8c3e-08002715d519',NULL,NULL),(20,'Abnormal','Abnormal class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e7e36c0-e42f-11e5-8c3e-08002715d519',NULL,NULL),(21,'Duration','Duration class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e7f5999-e42f-11e5-8c3e-08002715d519',NULL,NULL),(22,'Concept Details','Concept Details class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e8235d5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(23,'Image','Image class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e9aa30a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(24,'Computed','Computed',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e9bfb82-e42f-11e5-8c3e-08002715d519',NULL,NULL),(25,'URL','URL',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7ec83f58-e42f-11e5-8c3e-08002715d519',NULL,NULL),(26,'Sample','Lab Samples Concept Class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7f0d1595-e42f-11e5-8c3e-08002715d519',NULL,NULL),(27,'Department','Lab Departments Concept Class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7f0e9bbd-e42f-11e5-8c3e-08002715d519',NULL,NULL),(28,'LabTest','Lab Tests',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7f51b10e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(29,'Radiology','Radiology Orders',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7f533909-e42f-11e5-8c3e-08002715d519',NULL,NULL),(30,'Computed/Editable','Computed/Editable',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7f606a9f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(31,'Case Intake','Case Intake class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7f6c9253-e42f-11e5-8c3e-08002715d519',NULL,NULL),(32,'Unknown','Unknown class',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'802fb1b7-e42f-11e5-8c3e-08002715d519',NULL,NULL),(33,'Video','Video class',1,'2017-04-04 00:00:00',0,NULL,NULL,NULL,'df8b4b3a-191f-11e7-bbfc-9206fc7c228b',NULL,NULL);
/*!40000 ALTER TABLE `concept_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_complex`
--

LOCK TABLES `concept_complex` WRITE;
/*!40000 ALTER TABLE `concept_complex` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `hl7_abbreviation` varchar(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `concept_datatype_uuid_index` (`uuid`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  KEY `concept_datatype_name_index` (`name`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_datatype` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_datatype`
--

LOCK TABLES `concept_datatype` WRITE;
/*!40000 ALTER TABLE `concept_datatype` DISABLE KEYS */;
INSERT INTO `concept_datatype` VALUES (1,'Numeric','NM','Numeric value, including integer or float (e.g., creatinine, weight)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4488-c2cc-11de-8d13-0010c6dffd0f'),(2,'Coded','CWE','Value determined by term dictionary lookup (i.e., term identifier)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a48b6-c2cc-11de-8d13-0010c6dffd0f'),(3,'Text','ST','Free text',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f'),(4,'N/A','ZZ','Not associated with a datatype (e.g., term answers, sets)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4c94-c2cc-11de-8d13-0010c6dffd0f'),(5,'Document','RP','Pointer to a binary or text-based document (e.g., clinical document, RTF, XML, EKG, image, etc.) stored in complex_obs table',1,'2004-04-15 00:00:00',0,NULL,NULL,NULL,'8d4a4e74-c2cc-11de-8d13-0010c6dffd0f'),(6,'Date','DT','Absolute date',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a505e-c2cc-11de-8d13-0010c6dffd0f'),(7,'Time','TM','Absolute time of day',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a591e-c2cc-11de-8d13-0010c6dffd0f'),(8,'Datetime','TS','Absolute date and time',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a5af4-c2cc-11de-8d13-0010c6dffd0f'),(10,'Boolean','BIT','Boolean value (yes/no, true/false)',1,'2004-08-26 00:00:00',0,NULL,NULL,NULL,'8d4a5cca-c2cc-11de-8d13-0010c6dffd0f'),(11,'Rule','ZZ','Value derived from other data',1,'2006-09-11 00:00:00',0,NULL,NULL,NULL,'8d4a5e96-c2cc-11de-8d13-0010c6dffd0f'),(12,'Structured Numeric','SN','Complex numeric values possible (ie, <5, 1-10, etc.)',1,'2005-08-06 00:00:00',0,NULL,NULL,NULL,'8d4a606c-c2cc-11de-8d13-0010c6dffd0f'),(13,'Complex','ED','Complex value.  Analogous to HL7 Embedded Datatype',1,'2008-05-28 12:25:34',0,NULL,NULL,NULL,'8d4a6242-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_datatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `concept_description_uuid_index` (`uuid`),
  KEY `user_who_changed_description` (`changed_by`),
  KEY `description_for_concept` (`concept_id`),
  KEY `user_who_created_description` (`creator`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_description` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_description` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_description`
--

LOCK TABLES `concept_description` WRITE;
/*!40000 ALTER TABLE `concept_description` DISABLE KEYS */;
INSERT INTO `concept_description` VALUES (1,5,'EVERY DAY','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1aa33b-e42f-11e5-8c3e-08002715d519'),(2,6,'TWICE A DAY','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1c11aa-e42f-11e5-8c3e-08002715d519'),(3,7,'THREE A DAY','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1df772-e42f-11e5-8c3e-08002715d519'),(4,8,'FOUR A DAY','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1e5746-e42f-11e5-8c3e-08002715d519'),(5,10,'BEFORE A MEAL','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1f1126-e42f-11e5-8c3e-08002715d519'),(6,11,'AFTER A MEAL','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1f58ec-e42f-11e5-8c3e-08002715d519'),(7,12,'AT BEDTIME','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e1f9a13-e42f-11e5-8c3e-08002715d519'),(8,28,'Consultation Note','en',1,'2016-03-07 12:10:33',NULL,NULL,'7e2dd2c0-e42f-11e5-8c3e-08002715d519');
/*!40000 ALTER TABLE `concept_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_map_type`
--

DROP TABLE IF EXISTS `concept_map_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_map_type` (
  `concept_map_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_creator_concept_map_type` (`creator`),
  KEY `mapped_user_changed_concept_map_type` (`changed_by`),
  KEY `mapped_user_retired_concept_map_type` (`retired_by`),
  CONSTRAINT `mapped_user_changed_concept_map_type` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator_concept_map_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_retired_concept_map_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_map_type`
--

LOCK TABLES `concept_map_type` WRITE;
/*!40000 ALTER TABLE `concept_map_type` DISABLE KEYS */;
INSERT INTO `concept_map_type` VALUES (1,'SAME-AS',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'35543629-7d8c-11e1-909d-c80aa9edcf4e'),(2,'NARROWER-THAN',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'43ac5109-7d8c-11e1-909d-c80aa9edcf4e'),(3,'BROADER-THAN',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'4b9d9421-7d8c-11e1-909d-c80aa9edcf4e'),(4,'Associated finding',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'55e02065-7d8c-11e1-909d-c80aa9edcf4e'),(5,'Associated morphology',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'605f4a61-7d8c-11e1-909d-c80aa9edcf4e'),(6,'Associated procedure',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'6eb1bfce-7d8c-11e1-909d-c80aa9edcf4e'),(7,'Associated with',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'781bdc8f-7d8c-11e1-909d-c80aa9edcf4e'),(8,'Causative agent',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'808f9e19-7d8c-11e1-909d-c80aa9edcf4e'),(9,'Finding site',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'889c3013-7d8c-11e1-909d-c80aa9edcf4e'),(10,'Has specimen',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'929600b9-7d8c-11e1-909d-c80aa9edcf4e'),(11,'Laterality',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'999c6fc0-7d8c-11e1-909d-c80aa9edcf4e'),(12,'Severity',NULL,1,'2016-03-07 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'a0e52281-7d8c-11e1-909d-c80aa9edcf4e'),(13,'Access',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f9e90b29-7d8c-11e1-909d-c80aa9edcf4e'),(14,'After',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'01b60e29-7d8d-11e1-909d-c80aa9edcf4e'),(15,'Clinical course',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5f7c3702-7d8d-11e1-909d-c80aa9edcf4e'),(16,'Component',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'67debecc-7d8d-11e1-909d-c80aa9edcf4e'),(17,'Direct device',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'718c00da-7d8d-11e1-909d-c80aa9edcf4e'),(18,'Direct morphology',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7b9509cb-7d8d-11e1-909d-c80aa9edcf4e'),(19,'Direct substance',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'82bb495d-7d8d-11e1-909d-c80aa9edcf4e'),(20,'Due to',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8b77f7d3-7d8d-11e1-909d-c80aa9edcf4e'),(21,'Episodicity',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'94a81179-7d8d-11e1-909d-c80aa9edcf4e'),(22,'Finding context',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'9d23c22e-7d8d-11e1-909d-c80aa9edcf4e'),(23,'Finding informer',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a4524368-7d8d-11e1-909d-c80aa9edcf4e'),(24,'Finding method',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'af089254-7d8d-11e1-909d-c80aa9edcf4e'),(25,'Has active ingredient',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b65aa605-7d8d-11e1-909d-c80aa9edcf4e'),(26,'Has definitional manifestation',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c2b7b2fa-7d8d-11e1-909d-c80aa9edcf4'),(27,'Has dose form',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'cc3878e6-7d8d-11e1-909d-c80aa9edcf4e'),(28,'Has focus',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d67c5840-7d8d-11e1-909d-c80aa9edcf4e'),(29,'Has intent',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'de2fb2c5-7d8d-11e1-909d-c80aa9edcf4e'),(30,'Has interpretation',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e758838b-7d8d-11e1-909d-c80aa9edcf4e'),(31,'Indirect device',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ee63c142-7d8d-11e1-909d-c80aa9edcf4e'),(32,'Indirect morphology',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f4f36681-7d8d-11e1-909d-c80aa9edcf4e'),(33,'Interprets',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fc7f5fed-7d8d-11e1-909d-c80aa9edcf4e'),(34,'Measurement method',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06b11d79-7d8e-11e1-909d-c80aa9edcf4e'),(35,'Method',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0efb4753-7d8e-11e1-909d-c80aa9edcf4e'),(36,'Occurrence',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'16e7b617-7d8e-11e1-909d-c80aa9edcf4e'),(37,'Part of',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1e82007b-7d8e-11e1-909d-c80aa9edcf4e'),(38,'Pathological process',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2969915e-7d8e-11e1-909d-c80aa9edcf4e'),(39,'Priority',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32d57796-7d8e-11e1-909d-c80aa9edcf4e'),(40,'Procedure context',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3f11904c-7d8e-11e1-909d-c80aa9edcf4e'),(41,'Procedure device',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'468c4aa3-7d8e-11e1-909d-c80aa9edcf4e'),(42,'Procedure morphology',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5383e889-7d8e-11e1-909d-c80aa9edcf4e'),(43,'Procedure site',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5ad2655d-7d8e-11e1-909d-c80aa9edcf4e'),(44,'Procedure site - Direct',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'66085196-7d8e-11e1-909d-c80aa9edcf4e'),(45,'Procedure site - Indirect',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7080e843-7d8e-11e1-909d-c80aa9edcf4e'),(46,'Property',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'76bfb796-7d8e-11e1-909d-c80aa9edcf4e'),(47,'Recipient category',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7e7d00e4-7d8e-11e1-909d-c80aa9edcf4e'),(48,'Revision status',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'851e14c1-7d8e-11e1-909d-c80aa9edcf4e'),(49,'Route of administration',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8ee5b13d-7d8e-11e1-909d-c80aa9edcf4e'),(50,'Scale type',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'986acf48-7d8e-11e1-909d-c80aa9edcf4e'),(51,'Specimen procedure',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a6937642-7d8e-11e1-909d-c80aa9edcf4e'),(52,'Specimen source identity',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b1d6941e-7d8e-11e1-909d-c80aa9edcf4e'),(53,'Specimen source morphology',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b7c793c1-7d8e-11e1-909d-c80aa9edcf4e'),(54,'Specimen source topography',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'be9f9eb8-7d8e-11e1-909d-c80aa9edcf4e'),(55,'Specimen substance',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c8f2bacb-7d8e-11e1-909d-c80aa9edcf4e'),(56,'Subject of information',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d0664c4f-7d8e-11e1-909d-c80aa9edcf4e'),(57,'Subject relationship context',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'dace9d13-7d8e-11e1-909d-c80aa9edcf4e'),(58,'Surgical approach',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e3cd666d-7d8e-11e1-909d-c80aa9edcf4e'),(59,'Temporal context',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ed96447d-7d8e-11e1-909d-c80aa9edcf4e'),(60,'Time aspect',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f415bcce-7d8e-11e1-909d-c80aa9edcf4e'),(61,'Using access device',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fa9538a9-7d8e-11e1-909d-c80aa9edcf4e'),(62,'Using device',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06588655-7d8f-11e1-909d-c80aa9edcf4e'),(63,'Using energy',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0c2ae0bc-7d8f-11e1-909d-c80aa9edcf4e'),(64,'Using substance',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'13d2c607-7d8f-11e1-909d-c80aa9edcf4e'),(65,'IS A',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1ce7a784-7d8f-11e1-909d-c80aa9edcf4e'),(66,'MAY BE A',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'267812a3-7d8f-11e1-909d-c80aa9edcf4e'),(67,'MOVED FROM',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2de3168e-7d8f-11e1-909d-c80aa9edcf4e'),(68,'MOVED TO',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32f0fd99-7d8f-11e1-909d-c80aa9edcf4e'),(69,'REPLACED BY',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3b3b9a7d-7d8f-11e1-909d-c80aa9edcf4e'),(70,'WAS A',NULL,1,'2016-03-07 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'41a034da-7d8f-11e1-909d-c80aa9edcf4e'),(71,'Is a (attribute)','SNOMED CT ATTRIBUTE',1,'2017-10-31 11:48:26',NULL,NULL,0,0,NULL,NULL,NULL,'4fcd2d12-01ec-463d-8701-9434d479011f'),(72,'SAME AS (attribute)','SNOMED CT ATTRIBUTE',1,'2017-10-31 11:49:58',NULL,NULL,0,0,NULL,NULL,NULL,'cf5a3d04-85a7-4e34-8f00-dae436c1e70b');
/*!40000 ALTER TABLE `concept_map_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name` (
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `locale` varchar(50) NOT NULL DEFAULT '',
  `locale_preferred` tinyint(1) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `concept_name_type` varchar(50) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `concept_name_uuid_index` (`uuid`),
  KEY `name_of_concept` (`name`),
  KEY `name_for_concept` (`concept_id`),
  KEY `user_who_created_name` (`creator`),
  KEY `user_who_voided_this_name` (`voided_by`),
  KEY `concept_name_changed_by` (`changed_by`),
  CONSTRAINT `concept_name_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_this_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name`
--

LOCK TABLES `concept_name` WRITE;
/*!40000 ALTER TABLE `concept_name` DISABLE KEYS */;
INSERT INTO `concept_name` VALUES (1,1,'Vero','it',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'56c4fed3-f1b1-43c3-99b0-10ffe75ce30e','2017-10-30 14:58:51',1),(2,1,'Sì','it',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'cd16d9ad-16b7-4976-8a16-9c318d4c60a5',NULL,NULL),(3,1,'Verdadeiro','pt',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'908649b5-315f-404b-8bd6-69d990d92cd7','2017-10-30 14:58:51',1),(4,1,'Sim','pt',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'54fb50c8-81b0-48c0-ba2f-5cd390ae6313',NULL,NULL),(5,1,'Vrai','fr',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'b43d6ef9-6dd5-4d5e-837f-42c73ad2f152','2017-10-30 14:58:51',1),(6,1,'Oui','fr',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'f888f979-66fd-4fc0-b6a4-5b413a4a9547',NULL,NULL),(7,1,'True','en',0,1,'2016-03-07 11:44:32',NULL,1,1,'2017-10-30 14:58:51','Deleted due to change of name','8626cf53-a9b7-4974-b257-4976ccb8774e','2017-10-30 14:58:51',1),(8,1,'Yes','en',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'3c0527d5-58c2-49be-8c28-2c6cb6c70162',NULL,NULL),(9,1,'Verdadero','es',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'c0904516-4534-4ef5-8b66-38f40a733900',NULL,NULL),(10,1,'Sí','es',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'6ca29bfe-a7ad-46e7-b640-3cfc725c5115','2017-10-30 14:58:51',1),(11,2,'Falso','it',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'aa96576c-9b9a-49e0-a1e4-164bb19862f5','2017-10-30 14:59:56',1),(12,2,'No','it',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'fdd1c0e4-7bee-40f1-b75e-d871887ea9c5',NULL,NULL),(13,2,'Falso','pt',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'068e07e0-6aef-4f5b-8ef6-376038c28007','2017-10-30 14:59:56',1),(14,2,'Não','pt',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'348cc6db-03ae-4422-b799-eaa00e67d2ad',NULL,NULL),(15,2,'Faux','fr',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'f12bb761-3784-4803-add8-0ec6e30ea787','2017-10-30 14:59:56',1),(16,2,'Non','fr',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'f287af94-732d-492f-881c-90fe9bb7cdc8',NULL,NULL),(17,2,'False','en',0,1,'2016-03-07 11:44:32',NULL,1,1,'2017-10-30 14:59:56','Deleted due to change of name','4d99c74a-d86d-41f7-94e0-4ea946508642','2017-10-30 14:59:56',1),(18,2,'No','en',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'9667f236-c6b9-4bc1-bd92-32a9a6e7a360',NULL,NULL),(19,2,'Falso','es',1,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'4fad0c13-e08a-49a5-99f3-3be780e1826d','2017-10-30 14:59:56',1),(20,2,'No','es',0,1,'2016-03-07 11:44:32',NULL,0,NULL,NULL,NULL,'24797aaa-77f2-4dae-8f9c-8477a954984e',NULL,NULL),(21,3,'Lab Samples','en',1,1,'2013-07-23 11:26:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e06cea6-e42f-11e5-8c3e-08002715d519',NULL,NULL),(22,4,'dosagefrequency','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e16d520-e42f-11e5-8c3e-08002715d519',NULL,NULL),(23,4,'Dosage Frequency','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e17373f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(24,5,'qd','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1907d4-e42f-11e5-8c3e-08002715d519',NULL,NULL),(25,5,'qD','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e190cb4-e42f-11e5-8c3e-08002715d519',NULL,NULL),(26,6,'bid','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1ac35e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(27,6,'BID','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1ac75a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(28,7,'tid','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1dc568-e42f-11e5-8c3e-08002715d519',NULL,NULL),(29,7,'TID','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1dc8e3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(30,8,'qid','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1e1921-e42f-11e5-8c3e-08002715d519',NULL,NULL),(31,8,'QID','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1e1c02-e42f-11e5-8c3e-08002715d519',NULL,NULL),(32,9,'dosage instructions','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1ec284-e42f-11e5-8c3e-08002715d519',NULL,NULL),(33,9,'Dosage Instructions','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1ec511-e42f-11e5-8c3e-08002715d519',NULL,NULL),(34,10,'ac','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1ee52d-e42f-11e5-8c3e-08002715d519',NULL,NULL),(35,10,'AC','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1ee7b2-e42f-11e5-8c3e-08002715d519',NULL,NULL),(36,11,'pc','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1f2c9d-e42f-11e5-8c3e-08002715d519',NULL,NULL),(37,11,'PC','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1f2eec-e42f-11e5-8c3e-08002715d519',NULL,NULL),(38,12,'hs','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e1f73c1-e42f-11e5-8c3e-08002715d519',NULL,NULL),(39,12,'HS','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e1f7602-e42f-11e5-8c3e-08002715d519',NULL,NULL),(40,13,'Visit Diagnoses','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e24d485-e42f-11e5-8c3e-08002715d519',NULL,NULL),(41,13,'Visit Diagnoses','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e24d85d-e42f-11e5-8c3e-08002715d519',NULL,NULL),(42,14,'Non-coded Diagnosis','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2527b9-e42f-11e5-8c3e-08002715d519',NULL,NULL),(43,14,'Non-coded Diagnosis','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e252a05-e42f-11e5-8c3e-08002715d519',NULL,NULL),(44,15,'Coded Diagnosis','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2578d3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(45,15,'Coded Diagnosis','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e257b45-e42f-11e5-8c3e-08002715d519',NULL,NULL),(46,16,'Diagnosis Certainty','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e25c0c2-e42f-11e5-8c3e-08002715d519',NULL,NULL),(47,16,'Diagnosis Certainty','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e25c49f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(48,17,'Presumed','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e264896-e42f-11e5-8c3e-08002715d519',NULL,NULL),(49,17,'Presumed','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e264b4b-e42f-11e5-8c3e-08002715d519',NULL,NULL),(50,18,'Confirmed','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2693c8-e42f-11e5-8c3e-08002715d519',NULL,NULL),(51,18,'Confirmed','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e269628-e42f-11e5-8c3e-08002715d519',NULL,NULL),(52,19,'Diagnosis order','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e270a85-e42f-11e5-8c3e-08002715d519',NULL,NULL),(53,19,'Diagnosis order','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e270d0a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(54,20,'Secondary','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e277647-e42f-11e5-8c3e-08002715d519',NULL,NULL),(55,20,'Secondary','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2778a4-e42f-11e5-8c3e-08002715d519',NULL,NULL),(56,21,'Primary','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e27cbf5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(57,21,'Primary','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e27cfaa-e42f-11e5-8c3e-08002715d519',NULL,NULL),(58,22,'Admit Patient','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2a1914-e42f-11e5-8c3e-08002715d519',NULL,NULL),(59,22,'Admit Patient','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2a1ba3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(60,23,'Discharge Patient','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2a5a6e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(61,23,'Discharge Patient','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2a5cd3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(62,24,'Transfer Patient','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2a99c5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(63,24,'Transfer Patient','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2a9c1d-e42f-11e5-8c3e-08002715d519',NULL,NULL),(64,25,'Disposition','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2af8ec-e42f-11e5-8c3e-08002715d519',NULL,NULL),(65,25,'Disposition','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2afb45-e42f-11e5-8c3e-08002715d519',NULL,NULL),(66,26,'Disposition Set','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2b74c7-e42f-11e5-8c3e-08002715d519',NULL,NULL),(67,26,'Disposition Set','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2b7716-e42f-11e5-8c3e-08002715d519',NULL,NULL),(68,27,'Disposition Note','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2bdf9b-e42f-11e5-8c3e-08002715d519',NULL,NULL),(69,27,'Disposition Note','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2be2cd-e42f-11e5-8c3e-08002715d519',NULL,NULL),(70,28,'consultation note','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2db69d-e42f-11e5-8c3e-08002715d519',NULL,NULL),(71,28,'Consultation Note','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2db95e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(72,29,'Admission','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e2f7026-e42f-11e5-8c3e-08002715d519',NULL,NULL),(73,29,'Admission','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e2f72f3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(74,30,'DISCHARGE','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e32523f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(75,30,'DISCHARGE','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e3254c7-e42f-11e5-8c3e-08002715d519',NULL,NULL),(76,31,'Lab departments','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e3c5ad7-e42f-11e5-8c3e-08002715d519',NULL,NULL),(77,31,'Lab Departments','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e3c5d9f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(78,32,'Other Investigations','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e3c7f56-e42f-11e5-8c3e-08002715d519',NULL,NULL),(79,32,'Other Investigations','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e3c81c3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(80,33,'Other Investigations Categories','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e3c9f5c-e42f-11e5-8c3e-08002715d519',NULL,NULL),(81,33,'Other Investigations Categories','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e3ca1b5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(82,34,'Adt Notes','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e3f9eda-e42f-11e5-8c3e-08002715d519',NULL,NULL),(83,35,'Document','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e451262-e42f-11e5-8c3e-08002715d519',NULL,NULL),(84,36,'LABRESULTS_CONCEPT','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e52ecbf-e42f-11e5-8c3e-08002715d519',NULL,NULL),(85,36,'LABRESULTS_CONCEPT','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e52f0f6-e42f-11e5-8c3e-08002715d519',NULL,NULL),(86,37,'LAB_RESULT','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e534465-e42f-11e5-8c3e-08002715d519',NULL,NULL),(87,37,'LAB_RESULT','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e5349a4-e42f-11e5-8c3e-08002715d519',NULL,NULL),(88,38,'LAB_NOTES','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e538d1a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(89,38,'LAB_NOTES','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e538f9a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(90,39,'LAB_MINNORMAL','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e53d308-e42f-11e5-8c3e-08002715d519',NULL,NULL),(91,39,'LAB_MINNORMAL','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e53d668-e42f-11e5-8c3e-08002715d519',NULL,NULL),(92,40,'LAB_MAXNORMAL','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e541e07-e42f-11e5-8c3e-08002715d519',NULL,NULL),(93,40,'LAB_MAXNORMAL','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e54206e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(94,41,'LAB_ABNORMAL','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e546498-e42f-11e5-8c3e-08002715d519',NULL,NULL),(95,41,'LAB_ABNORMAL','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e54673d-e42f-11e5-8c3e-08002715d519',NULL,NULL),(96,42,'REFERRED_OUT','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e60ab95-e42f-11e5-8c3e-08002715d519',NULL,NULL),(97,42,'REFERRED_OUT','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e60aec4-e42f-11e5-8c3e-08002715d519',NULL,NULL),(99,44,'Lab Order Notes','en',0,1,'2016-03-07 12:10:33','SHORT',0,NULL,NULL,NULL,'7e667a54-e42f-11e5-8c3e-08002715d519',NULL,NULL),(100,44,'Lab Order Notes','en',1,1,'2016-03-07 12:10:33','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e667cfb-e42f-11e5-8c3e-08002715d519',NULL,NULL),(101,45,'All_Tests_and_Panels','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e67df6f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(102,45,'A_T_and_P','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e67f4c8-e42f-11e5-8c3e-08002715d519',NULL,NULL),(103,46,'XCompoundObservation','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e6964a3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(104,47,'IS_ABNORMAL','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e699bbf-e42f-11e5-8c3e-08002715d519',NULL,NULL),(105,48,'Ruled Out Diagnosis','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e6c43bb-e42f-11e5-8c3e-08002715d519',NULL,NULL),(106,48,'Ruled Out Diagnosis','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e6c4655-e42f-11e5-8c3e-08002715d519',NULL,NULL),(107,49,'Bahmni Diagnosis Status','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e735812-e42f-11e5-8c3e-08002715d519',NULL,NULL),(108,49,'Bahmni Diagnosis Status','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e735ad3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(109,50,'Bahmni Initial Diagnosis','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e7379d9-e42f-11e5-8c3e-08002715d519',NULL,NULL),(110,50,'Bahmni Initial Diagnosis','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e737c38-e42f-11e5-8c3e-08002715d519',NULL,NULL),(111,51,'Bahmni Diagnosis Revised','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e739893-e42f-11e5-8c3e-08002715d519',NULL,NULL),(112,51,'Bahmni Diagnosis Revised','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e739ade-e42f-11e5-8c3e-08002715d519',NULL,NULL),(113,52,'Lab Manager Notes','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e7539af-e42f-11e5-8c3e-08002715d519',NULL,NULL),(114,52,'Lab Manager Notes','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e753cd6-e42f-11e5-8c3e-08002715d519',NULL,NULL),(115,53,'Accession Uuid','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7e782b8c-e42f-11e5-8c3e-08002715d519',NULL,NULL),(116,53,'Accession Uuid','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7e782e18-e42f-11e5-8c3e-08002715d519',NULL,NULL),(119,55,'dosing  units','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7ea60889-e42f-11e5-8c3e-08002715d519',NULL,NULL),(120,55,'Dosing Units','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7ea60b6e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(135,63,'drug routes','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7ea9b36f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(136,63,'Drug Routes','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7ea9b635-e42f-11e5-8c3e-08002715d519',NULL,NULL),(155,73,'duration units','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7eafb5e8-e42f-11e5-8c3e-08002715d519',NULL,NULL),(156,73,'Duration Units','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7eafb875-e42f-11e5-8c3e-08002715d519',NULL,NULL),(167,79,'Dosing Instructions','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7eb42a9a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(168,79,'Dosing Instructions','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7eb42d89-e42f-11e5-8c3e-08002715d519',NULL,NULL),(185,88,'All Observation templates','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7eb843b4-e42f-11e5-8c3e-08002715d519',NULL,NULL),(186,88,'All Observation Templates','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7eb8465f-e42f-11e5-8c3e-08002715d519',NULL,NULL),(187,89,'LAB_REPORT','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7ec9b101-e42f-11e5-8c3e-08002715d519',NULL,NULL),(188,89,'LAB_REPORT','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7ec9b518-e42f-11e5-8c3e-08002715d519',NULL,NULL),(195,93,'Impression','en',0,1,'2016-03-07 12:10:34','SHORT',0,NULL,NULL,NULL,'7efa5cf7-e42f-11e5-8c3e-08002715d519',NULL,NULL),(196,93,'Impression','en',1,1,'2016-03-07 12:10:34','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7efa5fbc-e42f-11e5-8c3e-08002715d519',NULL,NULL),(197,94,'All Disease Templates','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f144cdd-e42f-11e5-8c3e-08002715d519',NULL,NULL),(198,94,'All Disease Templates','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f144f97-e42f-11e5-8c3e-08002715d519',NULL,NULL),(201,96,'unit(s)','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f16611a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(202,96,'Unit(s)','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f1664d5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(247,119,'RESPIR','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f56e0be-e42f-11e5-8c3e-08002715d519',NULL,NULL),(248,119,'Inhalation','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f56e52c-e42f-11e5-8c3e-08002715d519',NULL,NULL),(259,125,'Deny Admission','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f671231-e42f-11e5-8c3e-08002715d519',NULL,NULL),(260,125,'Deny Admission','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f67155e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(261,126,'Order Attributes','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f6b622a-e42f-11e5-8c3e-08002715d519',NULL,NULL),(262,126,'Order Attributes','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f6b6558-e42f-11e5-8c3e-08002715d519',NULL,NULL),(263,127,'Undo Discharge','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f6f7e4c-e42f-11e5-8c3e-08002715d519',NULL,NULL),(264,127,'Undo Discharge','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f6f8189-e42f-11e5-8c3e-08002715d519',NULL,NULL),(265,128,'D','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f748851-e42f-11e5-8c3e-08002715d519',NULL,NULL),(266,128,'Dispensed','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f748b77-e42f-11e5-8c3e-08002715d519',NULL,NULL),(267,129,'All Orderables','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f84e6d9-e42f-11e5-8c3e-08002715d519',NULL,NULL),(268,129,'All Orderables','en',1,1,'2016-03-07 12:10:35','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7f84ea14-e42f-11e5-8c3e-08002715d519',NULL,NULL),(269,3,'Laboratory','en',0,1,'2016-03-07 12:10:35','SHORT',0,NULL,NULL,NULL,'7f866bd2-e42f-11e5-8c3e-08002715d519',NULL,NULL),(270,130,'REGISTRATION_CONCEPTS','en',1,1,'2016-03-07 12:10:36','FULLY_SPECIFIED',0,NULL,NULL,NULL,'801a5c1c-e42f-11e5-8c3e-08002715d519',NULL,NULL),(271,131,'DrugOther','en',0,1,'2016-03-07 12:10:36','SHORT',0,NULL,NULL,NULL,'80216009-e42f-11e5-8c3e-08002715d519',NULL,NULL),(272,131,'DrugOther','en',1,1,'2016-03-07 12:10:36','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80216473-e42f-11e5-8c3e-08002715d519',NULL,NULL),(273,132,'Stopped Order Reason','en',0,1,'2016-03-07 12:10:36','SHORT',0,NULL,NULL,NULL,'802c25c3-e42f-11e5-8c3e-08002715d519',NULL,NULL),(274,132,'Stopped Order Reason','en',1,1,'2016-03-07 12:10:36','FULLY_SPECIFIED',0,NULL,NULL,NULL,'802c2908-e42f-11e5-8c3e-08002715d519',NULL,NULL),(275,133,'Refused To Take','en',0,1,'2016-03-07 12:10:36','SHORT',0,NULL,NULL,NULL,'802c80a5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(276,133,'Refused To Take','en',1,1,'2016-03-07 12:10:36','FULLY_SPECIFIED',0,NULL,NULL,NULL,'802c8441-e42f-11e5-8c3e-08002715d519',NULL,NULL),(277,134,'Bacteriology Concept Set','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d14958-e42f-11e5-8c3e-08002715d519',NULL,NULL),(278,134,'BACTERIOLOGY CONCEPT SET','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d14c70-e42f-11e5-8c3e-08002715d519',NULL,NULL),(279,135,'Collection Date','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d1c634-e42f-11e5-8c3e-08002715d519',NULL,NULL),(280,135,'Specimen Collection Date','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d1c8de-e42f-11e5-8c3e-08002715d519',NULL,NULL),(281,136,'Sample Source','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d260f6-e42f-11e5-8c3e-08002715d519',NULL,NULL),(282,136,'Specimen Sample Source','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d263b0-e42f-11e5-8c3e-08002715d519',NULL,NULL),(283,137,'Id','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d2e9fc-e42f-11e5-8c3e-08002715d519',NULL,NULL),(284,137,'Specimen Id','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d2eca5-e42f-11e5-8c3e-08002715d519',NULL,NULL),(285,138,'Additional Attributes','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d39664-e42f-11e5-8c3e-08002715d519',NULL,NULL),(286,138,'Bacteriology Additional Attributes','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d39a82-e42f-11e5-8c3e-08002715d519',NULL,NULL),(287,139,'Results','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d3ddca-e42f-11e5-8c3e-08002715d519',NULL,NULL),(288,139,'Bacteriology Results','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d3e090-e42f-11e5-8c3e-08002715d519',NULL,NULL),(289,140,'Specimen Sample Source NonCoded','en',0,1,'2016-03-07 12:10:38','SHORT',0,NULL,NULL,NULL,'80d8cf3e-e42f-11e5-8c3e-08002715d519',NULL,NULL),(290,140,'Specimen Sample Source NonCoded','en',1,1,'2016-03-07 12:10:38','FULLY_SPECIFIED',0,NULL,NULL,NULL,'80d8d487-e42f-11e5-8c3e-08002715d519',NULL,NULL),(291,141,'Cured Diagnosis','en',0,1,'2017-04-04 15:47:14','SHORT',0,NULL,NULL,NULL,'df91ffa9-191f-11e7-bbfc-9206fc7c228b',NULL,NULL),(292,141,'Cured Diagnosis','en',1,1,'2017-04-04 15:47:14','FULLY_SPECIFIED',0,NULL,NULL,NULL,'df920d90-191f-11e7-bbfc-9206fc7c228b',NULL,NULL),(293,142,'Non-Coded Condition','en',0,1,'2017-10-30 14:22:08','SHORT',0,NULL,NULL,NULL,'9c8beee6-bd4f-11e7-8025-08002715d519',NULL,NULL),(294,142,'Non-Coded Condition','en',1,1,'2017-10-30 14:22:08','FULLY_SPECIFIED',0,NULL,NULL,NULL,'9c8bf3bf-bd4f-11e7-8025-08002715d519',NULL,NULL),(295,143,'Follow-up Condition','en',0,1,'2017-10-30 14:22:08','SHORT',0,NULL,NULL,NULL,'9c9691ae-bd4f-11e7-8025-08002715d519',NULL,NULL),(296,143,'Follow-up Condition','en',1,1,'2017-10-30 14:22:08','FULLY_SPECIFIED',0,NULL,NULL,NULL,'9c9694ea-bd4f-11e7-8025-08002715d519',NULL,NULL),(297,1,'True','en',0,1,'2017-10-30 14:58:51','SHORT',0,NULL,NULL,NULL,'375db553-427c-4a84-a74f-18311bcb698c',NULL,NULL),(298,1,'True (qualifier value)','en',1,1,'2017-10-30 14:58:51','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c6f5aaa1-98a0-44cd-9a4e-86fd61eb421f','2017-10-30 14:58:51',1),(299,2,'False','en',0,1,'2017-10-30 14:59:56','SHORT',0,NULL,NULL,NULL,'7ba9dd53-5598-44fa-bdb2-92faa15029d0',NULL,NULL),(300,2,'False (qualifier value)','en',1,1,'2017-10-30 14:59:56','FULLY_SPECIFIED',0,NULL,NULL,NULL,'57946208-561b-48c2-a3be-14391d6c1be2','2017-10-30 14:59:56',1),(301,144,'Capsule - unit of product usage','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'257ffb0c-fb2b-4624-a46e-83470444301c',NULL,NULL),(302,144,'Capsule','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'1780cb74-7adb-4db7-9d40-96782f948e9b',NULL,NULL),(303,144,'Capsule - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'fada9dc8-c313-458e-871c-d7deea32a8b2',NULL,NULL),(304,144,'Capsule - unit of product usage (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'321a2c63-70e7-4d76-89ac-a4568e54df95',NULL,NULL),(305,145,'Tablet','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'74abc249-5549-4567-8583-626fe82c9223',NULL,NULL),(306,145,'Tablet - unit of product usage (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'b3fdae63-375a-48ba-803a-d1e59054a55b',NULL,NULL),(307,145,'Tablet - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'3c79a3ea-e5ff-4382-8d3e-ea28c5d5c449',NULL,NULL),(308,145,'Tablet - unit of product usage','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'596ce1b4-3ac8-4308-b9cf-a2a897406ca4',NULL,NULL),(309,146,'Teaspoon','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'c3dc5158-3ca9-4800-868a-3d3bd145b5f2',NULL,NULL),(310,146,'Tsp','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'7558a8c7-29c0-4dda-8ed6-daa8a2e0f279',NULL,NULL),(311,146,'Teaspoonful','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'4d9712f9-1069-4d83-a266-d34952aebb71',NULL,NULL),(312,146,'Teaspoonful - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'dbb5a90d-e8f7-4c7c-9170-52518b751bdc',NULL,NULL),(313,146,'Teaspoon - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'0ea80860-44fb-425d-bba1-5d6f353b94f9',NULL,NULL),(314,146,'Teaspoonful - unit of product usage (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'3fb57a90-3f10-4e51-b27c-255d2bda21f5',NULL,NULL),(315,146,'Teaspoonful - unit of product usage','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'fa6f67ed-4b2a-48bd-8a22-ef653cc18cf2',NULL,NULL),(316,147,'Tablespoonful - unit of product usage (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1f0f1f6b-b885-4166-9d94-9273938e8846',NULL,NULL),(317,147,'Tablespoonful','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'0b56d2be-c29f-40af-89d0-8c37ec67b98c',NULL,NULL),(318,147,'Tablespoon - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'e92c8edb-f38d-4df0-9b70-faed0e48ba36',NULL,NULL),(319,147,'Tablespoonful - unit of product usage','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'8dff2d1e-a9cd-4f3f-97de-945f902f0805',NULL,NULL),(320,147,'Tablespoonful - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'0f99080a-d1e6-4b22-8483-b3f9cc568a75',NULL,NULL),(321,147,'Tbsp','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'d2553789-2691-4b06-b353-4c34d2b53f78',NULL,NULL),(322,147,'Tablespoon','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'e624f94d-4ecc-42f5-82ad-10f2cd45d74e',NULL,NULL),(323,148,'Drop - unit of product usage','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'4a0cf22c-19ad-44b2-8ac0-ae94529650d1',NULL,NULL),(324,148,'Gtts','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'6144ae2e-17b2-4c83-b08d-b1658ed66f9c',NULL,NULL),(325,148,'Drop','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'2748dcc2-d060-44d7-b76a-dd2b0f1a81e6',NULL,NULL),(326,148,'Drops','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'94116edf-a0bc-4538-8d78-8cb2f2a384cb',NULL,NULL),(327,148,'Drop - unit of product usage','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'941974c9-2e3c-4e2f-803a-c6795e916877',NULL,NULL),(328,148,'Drop - unit of product usage (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'baae238a-ed97-4658-95c2-e9aa5f63f3ad',NULL,NULL),(329,149,'millilitre','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'67bf4aa1-3dbc-408f-9589-a02426bc030c',NULL,NULL),(330,149,'milliliter','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'18ab893c-d22e-434e-9bbf-66f4c1a0ad0e',NULL,NULL),(331,149,'cm3','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'8015bb02-9a5e-4064-9952-3765d6779247',NULL,NULL),(332,149,'cc','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'f0f2e495-add0-4d91-8633-1a5870889b9e',NULL,NULL),(333,149,'milliliter (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'fada884a-7e72-4140-88bd-7c1c2b22fad8',NULL,NULL),(334,149,'milliliter','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'023c352b-7694-4695-99a5-d2cc138e0207',NULL,NULL),(335,149,'mL','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'ad83c19f-299b-494e-a77b-14dd28616e0d',NULL,NULL),(336,150,'milligram (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'a1e6ee09-1a67-4df3-8bf2-9055fae4ff31',NULL,NULL),(337,150,'milligram','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'36e46801-381f-44f2-ac5e-8448294a3793',NULL,NULL),(338,150,'mg','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'d1b6d8a5-ae41-4098-af08-b2f0648fb241',NULL,NULL),(339,150,'milligram','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'fb3aada2-0cc5-4db2-bd20-2fca5b604b55',NULL,NULL),(340,151,'IU','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'fec90605-a62c-4ab6-9263-b9ac56cb2b02',NULL,NULL),(341,151,'international unit','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'7db57018-0d37-4a94-90a4-36ac1f4702f8',NULL,NULL),(342,151,'international units (qualifier value)','en',1,1,'2017-10-31 11:52:47','FULLY_SPECIFIED',0,NULL,NULL,NULL,'ea5159f1-f358-41b7-9d94-6c085c7f426a',NULL,NULL),(343,151,'international units','en',0,1,'2017-10-31 11:52:47','SHORT',0,NULL,NULL,NULL,'7acdc140-d744-494e-ae23-25234424631d',NULL,NULL),(344,151,'international units','en',0,1,'2017-10-31 11:52:47',NULL,0,NULL,NULL,NULL,'1c71bdf0-087e-4e96-b6ca-ae1342aa6dfb',NULL,NULL),(345,152,'Intradermal use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'c735458a-07ed-4cce-bf0d-27eb7a79a02c',NULL,NULL),(346,152,'Intradermal route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c06851dd-c249-4167-997c-5adb665bc434',NULL,NULL),(347,152,'Intradermal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'c22fd1d1-c846-471e-a860-a21296494338',NULL,NULL),(348,152,'Intracutaneous use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'d50ba089-ad4e-4b7d-936e-c735eecd09ae',NULL,NULL),(349,152,'Intradermal route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'14075fc0-dc07-4f99-9859-a305fbf70e93',NULL,NULL),(350,152,'Intracutaneous route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'d94ae851-f2a0-4dc0-bcce-9b771f8cfafd',NULL,NULL),(351,152,'Intradermal route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'a52a1a31-124b-4b95-a9b8-a5af3a700e67',NULL,NULL),(352,153,'Intraperitoneal (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'83f9d0e4-0528-4d4d-ba39-5b19221a2057',NULL,NULL),(353,153,'Intraperitoneal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'2272b531-1216-4936-b2d7-0b318a7c0349',NULL,NULL),(354,153,'Intraperitoneal','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'883ff6be-0780-471d-bff2-bff15209ef79',NULL,NULL),(355,153,'IP - Intraperitoneal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'405b0b00-e6a4-4e2d-a735-3a6e176df21b',NULL,NULL),(356,154,'Intrathecal route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'414631ed-3db2-439e-8745-8591fa88be8a',NULL,NULL),(357,154,'Intrathecal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'c77a2aa1-c127-48d3-b230-0e2a496c1393',NULL,NULL),(358,154,'Intrathecal use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'f4822b35-9698-4c3e-8fdf-be4badd4dd14',NULL,NULL),(359,154,'Intrathecal route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'8cd498e7-b863-434e-9f7c-bb64bc620eeb',NULL,NULL),(360,154,'Intrathecal route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'fd4ce3a9-9c3c-4676-afa8-a2d626db7162',NULL,NULL),(361,155,'Intraosseous','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'23e1e50c-b469-4ac9-a784-a3efafed6778',NULL,NULL),(362,155,'Intraosseous route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'3bb53632-d9f5-4cd7-828e-9221067ff64c',NULL,NULL),(363,155,'Intraosseous route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'cec93b1f-d1c4-4144-b9f3-bc220b8ac619',NULL,NULL),(364,155,'Intraosseous route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'a3709da2-f6f8-4063-a966-befa845a658e',NULL,NULL),(365,155,'Intra-osseous route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'86b4f01b-937d-40b1-bdd1-5724cabab67e',NULL,NULL),(366,156,'IM - Intramuscular','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'6991ff4d-35b8-43f6-a34e-3fbbee9c4e58',NULL,NULL),(367,156,'Intramuscular','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'1dbedbbb-59ea-4296-b394-06d74a80995b',NULL,NULL),(368,156,'Intramuscular (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'d2e49e66-1fd8-4e19-b270-36e815a0f795',NULL,NULL),(369,156,'Intramuscular','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'581bbd3c-19f8-40c1-8cb9-5cfd7c848917',NULL,NULL),(370,157,'Intravenous (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'aca7f0d5-66a3-40bc-b263-56ac2aaefa51',NULL,NULL),(371,157,'Intravenous','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'f17c718a-eb90-40e1-a5f0-816c5b37a242',NULL,NULL),(372,157,'Intravenous','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'279a1aa4-f9f2-437e-93c4-39af2095465e',NULL,NULL),(373,157,'IV - Intravenous','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'d9f582d6-ddeb-45b8-891b-db43cde3ca62',NULL,NULL),(374,158,'Nasal route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'3d3b0520-209d-4489-b1bd-43a99ffd1505',NULL,NULL),(375,158,'Nasal route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'924b8ccb-1593-4601-8ae5-5cb6324fe527',NULL,NULL),(376,158,'Nasal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'211630da-5de4-46e5-b35b-c5d74e208d85',NULL,NULL),(377,158,'Nasal route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'499362dc-0d29-4da9-822d-26f031512f9e',NULL,NULL),(378,158,'Nasal use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'098577f8-eca5-4dde-99c4-de03c5d90b02',NULL,NULL),(379,159,'Topical route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'05c55a16-b86f-4eed-8106-5979661313ef',NULL,NULL),(380,159,'Topical use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'f6efa507-d544-456b-a094-efd258b4ca92',NULL,NULL),(381,159,'Topical route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'41ed532b-3296-4b18-9f96-90aa02a075b0',NULL,NULL),(382,159,'Cutaneous route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'6c586988-2351-4164-a8c7-4f502dddc673',NULL,NULL),(383,159,'Cutaneous use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'fc253d09-ea29-474f-83fa-b88fc40ec6f3',NULL,NULL),(384,159,'Topical','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'20406f08-717c-45e7-b6e4-32f348ef7f7b',NULL,NULL),(385,159,'Topical route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'ab2c6d37-6dbd-442a-99f8-df561a734756',NULL,NULL),(386,160,'Orally','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'a80cd41b-3f10-4b76-adf9-6d22d292998f',NULL,NULL),(387,160,'Oral use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'f4bf8c09-c263-432a-bb68-ea1ef4835c83',NULL,NULL),(388,160,'Oral route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'1e3b9260-40ef-4ffb-8121-33d0bd62e8db',NULL,NULL),(389,160,'Per os','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'08280619-6913-4738-aa30-6f3bc688f3bf',NULL,NULL),(390,160,'PO - Per os','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'bbb94218-e184-4340-b194-3a49eb487f48',NULL,NULL),(391,160,'Per oral route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'ab903623-d15d-4d47-ad07-a7a2a40f3366',NULL,NULL),(392,160,'Oral','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'0894569c-5883-4b3c-9029-494e22796032',NULL,NULL),(393,160,'Oral route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'796da207-f4d9-4f0e-83eb-1ad3a35967e8',NULL,NULL),(394,160,'Peroral route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'e0f718b2-b9f3-46c4-a164-bf1fcd661e45',NULL,NULL),(395,160,'By mouth','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'02c101b5-90e9-4ba0-9384-1270e3fa4e25',NULL,NULL),(396,160,'Oral route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'74c204e6-6ca5-459f-81ff-ced59c268f48',NULL,NULL),(397,161,'Vaginal route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'3f772fdb-bc36-4f35-85c0-b75589f46707',NULL,NULL),(398,161,'Vaginal route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1fc70245-c938-4c2a-b7f2-31702f9eac6e',NULL,NULL),(399,161,'Per vagina','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'a73d1090-eef9-41fe-9378-1d26d2bb4774',NULL,NULL),(400,161,'Into vagina','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'72f22b5c-b9cd-4f45-9678-887081a0f168',NULL,NULL),(401,161,'Vaginal route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'158ac4a9-74bd-4bb6-8159-e5e5cd3f941c',NULL,NULL),(402,161,'Vaginal use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'f116950f-9582-468b-951c-3458a64af740',NULL,NULL),(403,161,'Vaginal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'7129df56-56bd-4c72-bc74-57500e7a1221',NULL,NULL),(404,161,'Per vagina (route)','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'cfb77cde-1162-41e6-9c6a-bc8166bf73d4',NULL,NULL),(405,162,'Cutaneous route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'8c74fac8-9cd2-44b8-ae7b-d75754280647',NULL,NULL),(406,162,'Cutaneous route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'e9647bc8-af22-4ec6-b4d7-5b5fadb2ebb8',NULL,NULL),(407,162,'Cutaneous route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'554e75ca-5a29-40ae-86dd-b1298b09efad',NULL,NULL),(408,163,'Rectal route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'0ce76a58-2bc0-4341-bc9e-a198587861fc',NULL,NULL),(409,163,'Rectal','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'18b7af30-a63e-4f4a-85b6-4f5dcdb962fd',NULL,NULL),(410,163,'Per rectum','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'f1e62bf9-100f-435d-a21f-874a51099446',NULL,NULL),(411,163,'Rectally','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'dcba2dd5-7e19-409e-be20-2cf7e49b6f86',NULL,NULL),(412,163,'Rectal route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'217e37df-c447-4c3f-9bca-82bdc7a09763',NULL,NULL),(413,163,'Rectal use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'5dfbf5de-a88a-46c8-83b6-37e5c552da70',NULL,NULL),(414,163,'Per rectum (route)','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'609a0674-ec89-4696-b299-0b0464431071',NULL,NULL),(415,163,'Rectal route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'bda80ae4-c97f-46e6-b115-0e2487b29024',NULL,NULL),(416,164,'Sublingual route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'6939adef-2a7d-4e54-a911-5ed7b0361f0d',NULL,NULL),(417,164,'Sublingual route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'34b356f5-18f7-4eb4-a399-ce900404c54b',NULL,NULL),(418,164,'Sublingually','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'b9b60cb0-aa51-4ac6-80ab-63a763daa6cf',NULL,NULL),(419,164,'Sublingual','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'5024119b-32e5-417f-b3fd-f7af35720338',NULL,NULL),(420,164,'Sublingual route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'a4612a4a-68d7-4c19-b9dd-76efe9514863',NULL,NULL),(421,164,'Sublingual use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'3b282a1f-4ff6-4184-8adb-087e7a22dac5',NULL,NULL),(422,165,'Nasogastric route','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'89d81b97-e008-403e-90e6-8b73221e9342',NULL,NULL),(423,165,'NG - Nasogastric use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'61e2cec7-04ac-40c9-8d14-05c023adfa26',NULL,NULL),(424,165,'Nasogastric','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'ff67aa0b-9d9d-4ce1-9699-72ba96c98657',NULL,NULL),(425,165,'Nasogastric route (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'3fe3769d-b8ca-4016-a9b6-782eae9e2592',NULL,NULL),(426,165,'Nasogastric use','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'3c6b1166-8f57-46f5-bc17-985cf95622f3',NULL,NULL),(427,165,'Nasogastric route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'18ed7c49-29e6-4e61-8a68-d5e577250f91',NULL,NULL),(428,165,'NG - Nasogastric route','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'a9536d4c-ab88-4774-9f20-b698552c5781',NULL,NULL),(429,166,'od - Once daily','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'e17b4fdf-12fa-43d9-afb4-760d623ef936',NULL,NULL),(430,166,'Once daily (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'e4c83ec4-9a4a-465c-a4be-ed1a11ddbfb2',NULL,NULL),(431,166,'Once daily','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'649fe24b-c13c-4e56-83eb-81cd005aac73',NULL,NULL),(432,166,'Once daily','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'715bc5d3-f310-4661-a813-6e280873ec72',NULL,NULL),(433,166,'od - omni die','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'ae279939-b6fc-4732-af41-8fc7e7871383',NULL,NULL),(434,167,'Twice daily','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'d5186361-4cbe-49b5-b1ce-b3d3f27a7be9',NULL,NULL),(435,167,'bd - Twice daily','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'11a501ef-ebc8-488d-84d7-fcdd1d1fe796',NULL,NULL),(436,167,'Twice a day','en',0,1,'2017-10-31 11:52:48','SHORT',0,NULL,NULL,NULL,'ee093b79-4546-4ba4-9fe4-0939ee418f1a',NULL,NULL),(437,167,'Twice a day','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'7178f865-582b-429e-80bf-fd80ae28e474',NULL,NULL),(438,167,'Twice a day (qualifier value)','en',1,1,'2017-10-31 11:52:48','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1b8d8d87-ae9b-4cc2-9c8b-e3f24fc798dc',NULL,NULL),(439,167,'bid - Twice a day','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'ac55ddd9-36fb-4fec-af07-0ee5b29da006',NULL,NULL),(440,167,'bd - bis die','en',0,1,'2017-10-31 11:52:48',NULL,0,NULL,NULL,NULL,'682b32a2-0002-435d-afc2-405ac6073b7f',NULL,NULL),(441,168,'Three times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'5ad51d35-3a63-4a3e-89eb-1cba2058f8b4',NULL,NULL),(442,168,'tds - ter die sumendus','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'824ae021-0dd4-4155-aa86-a25a0e474e88',NULL,NULL),(443,168,'tds - Three times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'a9ae36a6-7a0c-43aa-ad08-17b2234e44d9',NULL,NULL),(444,168,'Three times daily (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c6e8277e-3d39-47ac-9db4-e273d1a671e1',NULL,NULL),(445,168,'Three times daily','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'af8ba055-3bc3-4bdb-99e0-9c2467c9d231',NULL,NULL),(446,168,'3x /day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'dc3c1bec-26a1-4d96-896d-88dbddb6584b',NULL,NULL),(447,168,'Three times a day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'1d6f2339-c06c-4763-8b79-02f0618c3074',NULL,NULL),(448,168,'tid - Three times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'f7f871ef-ab3b-4cce-93f6-5854d8fe2e5b',NULL,NULL),(449,169,'Four times a day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'552a535b-bd7b-4efe-9ce5-7a01af1804fd',NULL,NULL),(450,169,'qid - Four times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'de63c3f3-7a6d-4c40-94ec-e89a695eee8c',NULL,NULL),(451,169,'Four times daily','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'70381c1d-7cae-4a60-a8ba-088413418294',NULL,NULL),(452,169,'Four times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'b0b74150-c783-4274-bb60-149e474ef1cc',NULL,NULL),(453,169,'qds - quater die sumendus','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'6334e1a1-c304-49d9-97e2-83fc807e94ef',NULL,NULL),(454,169,'Four times daily (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'5a89ce99-279a-4a1f-8584-de145d1aa849',NULL,NULL),(455,169,'qds - Four times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'d59fed2c-23ef-4346-a79c-2f212d580e1e',NULL,NULL),(456,170,'Five times daily','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'f9f44a2a-df03-452f-a77e-510d68de71d5',NULL,NULL),(457,170,'Five times daily (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'904e3c91-da69-4e7c-a950-192b2ed05784',NULL,NULL),(458,170,'Five times daily','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'e818a6ac-65d7-4ab0-a5a8-c4b110a458de',NULL,NULL),(459,170,'Five times a day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'77874969-865c-4c02-ac77-03f002b2abfc',NULL,NULL),(460,171,'Preprandial','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'0ba02ee5-a265-470d-9512-1fc1cba7b2fc',NULL,NULL),(461,171,'Before meal','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'c3dd24f0-5314-420c-9d32-aaef6f27a93c',NULL,NULL),(462,171,'Before meal (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'ba7d1e82-e729-40ce-aa39-e2b76c760472',NULL,NULL),(463,171,'Before meal','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'b3755d8f-071a-4125-87dc-988722d4ca31',NULL,NULL),(464,171,'ac - ante cibum','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'ca74f39b-1aa0-47c6-92a5-73f110f8ce5b',NULL,NULL),(465,171,'ante cibum','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'66c9b160-ca8d-4384-bdf1-2a9660baf018',NULL,NULL),(466,172,'Take on an empty stomach','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'30055013-e3c1-4002-a4e3-939f280930fe',NULL,NULL),(467,172,'Take on an empty stomach','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'a5540754-99f3-4dc6-98d9-43bb90cd2e5e',NULL,NULL),(468,172,'Take on an empty stomach (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'a0c90c00-8daf-4a21-a099-554b78727d74',NULL,NULL),(469,173,'Postprandial (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'bfe04cc4-415c-487c-9515-42bb2932a927',NULL,NULL),(470,173,'Post-prandial','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'b14d8d3c-97b3-4c6f-a7ae-99e44a15c611',NULL,NULL),(471,173,'post cibum','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'00128234-ff0d-4feb-85c3-e18a7d52ea9c',NULL,NULL),(472,173,'After meal','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'fddb502d-364e-4f0e-84f7-8341ce54c7e8',NULL,NULL),(473,173,'Postprandial','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'653e857f-ef6c-4d29-991b-f54a46fe5b68',NULL,NULL),(474,173,'pc - post cibum','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'b74b0e38-ec0f-4439-8b1e-74d51b66f69d',NULL,NULL),(475,173,'p.p. - Post-prandial','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'0d8c77de-38d5-4ee6-820f-554ca1ec39fc',NULL,NULL),(476,173,'Postprandial','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'8f2df6b3-e6bd-429e-b94c-62c0a21b8373',NULL,NULL),(477,174,'Morning','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'d19dc74f-75a5-4297-b119-b975e3be629e',NULL,NULL),(478,174,'am - ante meridiem','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'3d0929c4-cb9a-4692-89db-0c7387a9dfe8',NULL,NULL),(479,174,'Morning','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'a60e648c-37ae-4425-a0e6-11dc61edd192',NULL,NULL),(480,174,'om - omni mane','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'6de2935b-32bd-4049-9e56-c7e624c645b6',NULL,NULL),(481,174,'ante meridiem','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'e08a44bb-1126-444b-bb3a-7eb9999ec1d2',NULL,NULL),(482,174,'In the morning','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'1adcbe1d-afa7-4dd6-9c6a-2510d44f1b18',NULL,NULL),(483,174,'Morning (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'61d16868-7de9-4f4a-83da-5d1812b39cbe',NULL,NULL),(484,174,'During morning','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'8a0402b9-171c-4f7b-af3d-0db5c7dd9c95',NULL,NULL),(485,174,'mane','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'308b4fa4-0b4e-4cbd-b893-98d0cc50ca41',NULL,NULL),(486,175,'Evening','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'a75aa327-010e-4872-a3c7-41a8407235d4',NULL,NULL),(487,175,'During the evening','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'1db50d89-ccf4-4ff7-a071-7ede9859557a',NULL,NULL),(488,175,'Evening (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1c6619ea-76da-4675-b478-61bba4b57211',NULL,NULL),(489,175,'Evening','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'d7865846-5b3e-4878-98e5-bc74c9bfbdd8',NULL,NULL),(490,176,'At the end of the day','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'0217a394-ce59-4f81-9898-c6b560798ca3',NULL,NULL),(491,176,'At the end of the day (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'bbd02249-a62d-4e62-b6a6-c4a49cc72c99',NULL,NULL),(492,176,'At the end of the day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'4c7e6dcc-4d3e-4774-8ec0-3a27b3550f32',NULL,NULL),(493,177,'As directed for','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'5010ebcc-fff8-485a-88e8-716139678493',NULL,NULL),(494,177,'As directed for (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'ba594c9f-75c3-403b-affc-9b75862ba95e',NULL,NULL),(495,177,'As directed for','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'3271ea06-0ab4-4d7d-be1d-a8df8c8f0c02',NULL,NULL),(496,178,'min (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'8737d662-d41a-4a08-834a-b24601c9b14e',NULL,NULL),(497,178,'minute','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'42ba4df1-509d-4c55-bd2b-48e6921c1399',NULL,NULL),(498,178,'min','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'bffb866f-873d-4add-afce-c360393437fe',NULL,NULL),(499,178,'min','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'e6151e6d-3d87-45ba-84d7-01117595a3d4',NULL,NULL),(500,178,'minutes','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'4bc2a7ae-98fe-4754-aa5e-0c2c75eacdfc',NULL,NULL),(501,179,'hour','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'0d340742-5e01-4390-a857-c2daed2c762a',NULL,NULL),(502,179,'hr','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'abaad20a-ed05-448b-b30f-c63b607552c3',NULL,NULL),(503,179,'hours','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'813bf88b-df0b-40eb-8d46-c555c6fbbf9d',NULL,NULL),(504,179,'hour','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'c6669e74-937a-4d61-a943-f8d9d008b7d1',NULL,NULL),(505,179,'hour (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1d704866-3492-4e66-b9c2-2eb5c35e7bf6',NULL,NULL),(506,179,'h - hour','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'ab56cf7a-68d3-4fd1-a7e5-820fc54996c1',NULL,NULL),(507,180,'day (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'90d15f01-8728-4219-93f9-2ca02fc6d435',NULL,NULL),(508,180,'day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'c00dcc6d-5141-4782-8981-29c090e58d59',NULL,NULL),(509,180,'d - day','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'06338849-256b-4a28-aa64-f32d8037f80d',NULL,NULL),(510,180,'day','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'bef84775-0024-4ada-85ee-9ee74d291562',NULL,NULL),(511,180,'days','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'aab7cfaf-4e18-463e-b563-570c25ebc3c7',NULL,NULL),(512,181,'week','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'cf2e16f6-bb53-4ebf-9c65-f02ce47e8033',NULL,NULL),(513,181,'week','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'c47b9825-bcc2-46ca-b4dc-f0ea21707977',NULL,NULL),(514,181,'wk','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'95fc7838-874f-4719-98ff-96597dc020a8',NULL,NULL),(515,181,'weeks','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'b278050e-989b-4273-bb39-200fece62005',NULL,NULL),(516,181,'week (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'f196d53c-5c8d-4734-8132-923120d08855',NULL,NULL),(517,182,'month','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'45b05e71-876f-4b79-83f4-0f17742d4d5d',NULL,NULL),(518,182,'month','en',0,1,'2017-10-31 11:52:49','SHORT',0,NULL,NULL,NULL,'470e8713-bd04-48c4-8547-d36bf9c0db4a',NULL,NULL),(519,182,'months','en',0,1,'2017-10-31 11:52:49',NULL,0,NULL,NULL,NULL,'2ed28581-42c4-4ef5-8df8-4eacbba62fc8',NULL,NULL),(520,182,'month (qualifier value)','en',1,1,'2017-10-31 11:52:49','FULLY_SPECIFIED',0,NULL,NULL,NULL,'5b8a66e4-d434-4388-b450-6cf9f7388a32',NULL,NULL),(521,183,'Hourly','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'e219aead-e83a-48e2-a049-440e47570141',NULL,NULL),(522,183,'Hourly (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'477ec87f-cedb-4992-b84d-da2425365d1c',NULL,NULL),(523,183,'Every hour','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'bcf18aae-848a-4596-95af-1518dd7415d4',NULL,NULL),(524,183,'Hourly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'91f37713-ffe3-4b5e-be6c-1e312e6ccc19',NULL,NULL),(525,184,'Every two hours','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'24a8d20b-7dfa-411f-9798-d28ad1921935',NULL,NULL),(526,184,'Every two hours (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'0e169573-cf44-4ba2-aabb-cbbba5c6056e',NULL,NULL),(527,184,'2 hourly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'933d0546-d6de-4822-bc97-be62c704cdf3',NULL,NULL),(528,184,'Every two hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'dd61cf11-ab99-40a4-9caf-6394b2cf8fae',NULL,NULL),(529,184,'Two hourly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'d79b8973-ff41-4cfe-b0e9-d877453ceb6f',NULL,NULL),(530,185,'Every three hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'b0705499-986a-4856-abd5-b8f6a456cd0f',NULL,NULL),(531,185,'Three hourly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'b31ed4d4-dea9-43bb-8166-a663242b5ded',NULL,NULL),(532,185,'Every three hours (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'8f06b7b3-9073-4c97-9bb0-9dc88706b2d6',NULL,NULL),(533,185,'Every three hours','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'ec3288d9-0eb0-4836-b9cf-e35a361d8d57',NULL,NULL),(534,185,'Every 3 hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'3283ec12-0f65-492b-adbb-fd5adb94d24f',NULL,NULL),(535,185,'3 hourly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'c01a10e7-43ad-46ee-b8c2-64947d88f5ab',NULL,NULL),(536,186,'q4h - Every four hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'c75d97d8-dcd2-41fa-b90e-d51dd1567f6e',NULL,NULL),(537,186,'Four hourly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'313cc0a6-31cd-4884-9dea-518027171525',NULL,NULL),(538,186,'Every four hours','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'05a474df-62c8-4fc5-9d88-bb12996fddbc',NULL,NULL),(539,186,'Every 4 hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'5d959f2b-7b74-4f5c-aa5e-137530b97904',NULL,NULL),(540,186,'qqh - quarta quaque hora','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'ebeadc6f-6f98-4407-bc05-4f69b7b1dee5',NULL,NULL),(541,186,'Every four hours (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'881256f6-3138-4832-bf4c-655cbaf74f15',NULL,NULL),(542,186,'Every four hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'41f9a9d1-c32c-468b-aa78-05b6adb1da93',NULL,NULL),(543,187,'q6h - Every six hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'0f83468f-9c12-48ea-a523-54d86c02820a',NULL,NULL),(544,187,'Every six hours (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'e088f5cd-ac76-4401-be19-9571d204789f',NULL,NULL),(545,187,'Every six hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'aed9051b-9f0d-463a-8daf-4846d5179df8',NULL,NULL),(546,187,'Every six hours','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'09175648-3e92-4245-a069-ae26af02f844',NULL,NULL),(547,188,'Every eight hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'72c2f86e-f185-411c-b73b-c110674c00d4',NULL,NULL),(548,188,'q8h - Every eight hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'805b036c-8654-44ce-ac57-d3fdd293c68b',NULL,NULL),(549,188,'Every eight hours (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'31f69b95-fea2-4837-8852-e5f6ed622426',NULL,NULL),(550,188,'Every eight hours','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'3ef7d4c1-b605-4145-a757-f7686d8c2a82',NULL,NULL),(551,188,'Every 8 hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'110d01d7-d577-4929-a60d-916bea281919',NULL,NULL),(552,189,'q12h - Every twelve hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'979e66bd-255e-4780-b45f-946cdf4be3bf',NULL,NULL),(553,189,'Every twelve hours (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'0a83ab5a-e973-4979-ae80-e994ac61b17f',NULL,NULL),(554,189,'Every twelve hours','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'d3b448d2-990b-43c6-a168-49bea17c0c03',NULL,NULL),(555,189,'Every twelve hours','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'dab53b0e-aaf8-45df-9b2b-986b5ec04e00',NULL,NULL),(556,190,'Alternate days','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'1cd6a9c5-cf83-4538-88b0-4c67aa2965f1',NULL,NULL),(557,190,'Alternate days','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'f387e38b-a308-4763-a7b7-7159262da73c',NULL,NULL),(558,190,'Alternate days (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'fff98ff0-0c58-4690-ad6e-43bebef491d0',NULL,NULL),(559,190,'Every other day','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'7321c335-8437-4088-a426-9a90c787085e',NULL,NULL),(560,191,'Once a week (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'608413fc-4155-44d0-8ea6-55d4a1650736',NULL,NULL),(561,191,'Once a week','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'9d68b467-5685-42a2-bb84-b124c81d7711',NULL,NULL),(562,191,'Once weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'4ee29299-74b1-4ed6-87e1-349d355d0ef6',NULL,NULL),(563,191,'Once a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'ad582976-c17a-4780-b9b5-43c978e88e61',NULL,NULL),(564,192,'Twice weekly','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'4acad50e-37c9-4d06-af1a-323e0e8eb95c',NULL,NULL),(565,192,'Twice a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'146ac736-e4d6-4b8a-aede-305fc7c521cf',NULL,NULL),(566,192,'2x/wk','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'b99b6391-5cdd-4be6-ba46-c49dfae64388',NULL,NULL),(567,192,'Two times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'f87f0662-df5d-4814-b696-1b3f7eecef12',NULL,NULL),(568,192,'Twice weekly (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c9960f6c-1a87-4f7b-bf9d-a1079d193507',NULL,NULL),(569,192,'Twice weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'c8830755-7ee7-4454-9de2-32dcc74311ac',NULL,NULL),(570,193,'Three times weekly (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'edfa2275-ed3f-4d81-ba8a-c0883c0a5ea6',NULL,NULL),(571,193,'Three times weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'e7d56256-b036-4aa2-bda5-76911e7b7c5f',NULL,NULL),(572,193,'Thrice weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'61e7089f-f0b9-4dfb-bcf5-aea77b8db73f',NULL,NULL),(573,193,'Three times weekly','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'ecba6cc6-d4dd-4b6d-8c74-38fef0bf4e4a',NULL,NULL),(574,194,'Four times weekly (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'3f60fff8-83cd-4e0e-b00e-c3f009f1ff71',NULL,NULL),(575,194,'4x/wk','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'edef367a-e081-4809-9756-1cb63fb9ec4d',NULL,NULL),(576,194,'Four times weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'f786b172-aec8-496e-987a-1d8c8f0bafc5',NULL,NULL),(577,194,'Four times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'6d75bb24-6dd0-4ea0-881d-7430a2ec955a',NULL,NULL),(578,194,'Four times weekly','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'f52d6a71-bf31-41a5-9a4a-51ccc119bbc2',NULL,NULL),(579,194,'4 times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'7f7e9712-bd23-4b09-8b7d-f07c825ae9cd',NULL,NULL),(580,195,'5 times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'9613f33f-a19b-4abe-bbbc-598bfe3efe66',NULL,NULL),(581,195,'Five times weekly (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'f0e4ac30-c733-4dbd-a77f-b2394d58110c',NULL,NULL),(582,195,'Five times weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'f353f6f1-301c-45f8-b89a-5aa7ce55af1a',NULL,NULL),(583,195,'Five times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'badce080-3343-4a8c-b11e-a9963b423574',NULL,NULL),(584,195,'Five times weekly','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'0561c196-d826-4101-9f4c-537c902e7629',NULL,NULL),(585,195,'5x/wk','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'859727a2-9f16-4bb7-b0b4-a9379fafa9ef',NULL,NULL),(586,196,'Six times weekly (qualifier value)','en',1,1,'2017-10-31 11:52:50','FULLY_SPECIFIED',0,NULL,NULL,NULL,'c366d989-2b9e-4ef3-a006-4ac802357ffe',NULL,NULL),(587,196,'Six times weekly','en',0,1,'2017-10-31 11:52:50','SHORT',0,NULL,NULL,NULL,'cdb53732-a1b7-4260-8d08-41f3fca27208',NULL,NULL),(588,196,'Six times weekly','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'a4e38204-1098-4f1d-8114-8ec9bc40f82b',NULL,NULL),(589,196,'6x/wk','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'5518edb1-e243-4141-a475-6dfa49de2145',NULL,NULL),(590,196,'Six times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'fef47fae-f66a-4c42-beca-d4b9b26156cc',NULL,NULL),(591,196,'6 times a week','en',0,1,'2017-10-31 11:52:50',NULL,0,NULL,NULL,NULL,'f441b703-4213-46f6-ac74-c7b8dcbbbd3b',NULL,NULL),(592,197,'Every two weeks','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'3b66a6eb-845f-4671-8259-421abe99c34a',NULL,NULL),(593,197,'Alternate weeks','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'901943d6-d1cc-4ab2-91ba-b364f74407cc',NULL,NULL),(594,197,'Biweekly','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'ea98619a-6076-4f9c-9bbf-f78beb0476ee',NULL,NULL),(595,197,'Fortnightly','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'fc8927ae-c41e-4706-83f6-41631d2f7413',NULL,NULL),(596,197,'Biweekly (qualifier value)','en',1,1,'2017-10-31 11:52:51','FULLY_SPECIFIED',0,NULL,NULL,NULL,'76e073f6-9191-4ce7-92f0-d3fed679adab',NULL,NULL),(597,197,'Biweekly','en',0,1,'2017-10-31 11:52:51','SHORT',0,NULL,NULL,NULL,'a0258c44-0cd8-42a9-9d5f-7614f9a1e5e9',NULL,NULL),(598,198,'Every three weeks','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'1cf8fcef-08c1-4625-b253-88fbc934bbbb',NULL,NULL),(599,198,'Triweekly','en',0,1,'2017-10-31 11:52:51','SHORT',0,NULL,NULL,NULL,'1800dffb-ec4e-4541-866a-9a4c89c8304d',NULL,NULL),(600,198,'Triweekly','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'4d15de7a-474e-41f5-bbeb-c6187296d2b5',NULL,NULL),(601,198,'Triweekly (qualifier value)','en',1,1,'2017-10-31 11:52:51','FULLY_SPECIFIED',0,NULL,NULL,NULL,'1ad8c18b-a7b4-4f4b-a4b5-6320953d5911',NULL,NULL),(602,199,'Monthly','en',0,1,'2017-10-31 11:52:51','SHORT',0,NULL,NULL,NULL,'24070f18-9925-470b-8483-b52a64ef9acf',NULL,NULL),(603,199,'Monthly','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'32431f98-4a3c-4c95-9be9-6c2583923f18',NULL,NULL),(604,199,'Every month','en',0,1,'2017-10-31 11:52:51',NULL,0,NULL,NULL,NULL,'7a3cde9d-6a84-410b-832d-24213df32297',NULL,NULL),(605,199,'Monthly (qualifier value)','en',1,1,'2017-10-31 11:52:51','FULLY_SPECIFIED',0,NULL,NULL,NULL,'7342b14b-8569-4785-b648-35ab2598ec90',NULL,NULL);
/*!40000 ALTER TABLE `concept_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) NOT NULL,
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `concept_name_tag_unique_tags` (`tag`),
  UNIQUE KEY `concept_name_tag_uuid_index` (`uuid`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`),
  KEY `concept_name_tag_changed_by` (`changed_by`),
  CONSTRAINT `concept_name_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag`
--

LOCK TABLES `concept_name_tag` WRITE;
/*!40000 ALTER TABLE `concept_name_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_name` (`concept_name_id`),
  KEY `mapped_concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag_map`
--

LOCK TABLES `concept_name_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_name_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `precise` tinyint(1) NOT NULL DEFAULT '0',
  `display_precision` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_numeric`
--

LOCK TABLES `concept_numeric` WRITE;
/*!40000 ALTER TABLE `concept_numeric` DISABLE KEYS */;
INSERT INTO `concept_numeric` VALUES (39,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(40,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(130,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `concept_numeric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) NOT NULL DEFAULT '',
  `final_text` varchar(255) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'UNMAPPED',
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `concept_proposal_uuid_index` (`uuid`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `user_who_created_proposal` (`creator`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_changed_proposal` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_proposal` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal`
--

LOCK TABLES `concept_proposal` WRITE;
/*!40000 ALTER TABLE `concept_proposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`),
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal_tag_map`
--

LOCK TABLES `concept_proposal_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_proposal_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_map`
--

DROP TABLE IF EXISTS `concept_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_reference_term_id` int(11) NOT NULL,
  `concept_map_type_id` int(11) NOT NULL DEFAULT '1',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_id`),
  UNIQUE KEY `concept_reference_map_uuid_id` (`uuid`),
  KEY `map_for_concept` (`concept_id`),
  KEY `map_creator` (`creator`),
  KEY `mapped_concept_map_type` (`concept_map_type_id`),
  KEY `mapped_user_changed_ref_term` (`changed_by`),
  KEY `mapped_concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `mapped_concept_map_type` FOREIGN KEY (`concept_map_type_id`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `mapped_concept_reference_term` FOREIGN KEY (`concept_reference_term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_user_changed_ref_term` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_map`
--

LOCK TABLES `concept_reference_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_map` DISABLE KEYS */;
INSERT INTO `concept_reference_map` VALUES (1,8,72,1,'2016-03-07 12:10:33',13,NULL,NULL,'7e24f792-e42f-11e5-8c3e-08002715d519'),(2,9,72,1,'2016-03-07 12:10:33',14,NULL,NULL,'7e254306-e42f-11e5-8c3e-08002715d519'),(3,10,72,1,'2016-03-07 12:10:33',15,NULL,NULL,'7e25943a-e42f-11e5-8c3e-08002715d519'),(4,11,72,1,'2016-03-07 12:10:33',16,NULL,NULL,'7e25df2f-e42f-11e5-8c3e-08002715d519'),(5,12,72,1,'2016-03-07 12:10:33',17,NULL,NULL,'7e2665be-e42f-11e5-8c3e-08002715d519'),(6,13,72,1,'2016-03-07 12:10:33',18,NULL,NULL,'7e26af51-e42f-11e5-8c3e-08002715d519'),(7,14,72,1,'2016-03-07 12:10:33',19,NULL,NULL,'7e272745-e42f-11e5-8c3e-08002715d519'),(8,15,72,1,'2016-03-07 12:10:33',20,NULL,NULL,'7e279377-e42f-11e5-8c3e-08002715d519'),(9,16,72,1,'2016-03-07 12:10:33',21,NULL,NULL,'7e27f2a9-e42f-11e5-8c3e-08002715d519'),(10,17,72,1,'2016-03-07 12:10:33',22,NULL,NULL,'7e2a35ef-e42f-11e5-8c3e-08002715d519'),(11,18,72,1,'2016-03-07 12:10:33',23,NULL,NULL,'7e2a7591-e42f-11e5-8c3e-08002715d519'),(12,19,72,1,'2016-03-07 12:10:33',24,NULL,NULL,'7e2ace0d-e42f-11e5-8c3e-08002715d519'),(13,20,72,1,'2016-03-07 12:10:33',25,NULL,NULL,'7e2b1368-e42f-11e5-8c3e-08002715d519'),(14,21,72,1,'2016-03-07 12:10:33',26,NULL,NULL,'7e2b8f8c-e42f-11e5-8c3e-08002715d519'),(15,22,72,1,'2016-03-07 12:10:33',27,NULL,NULL,'7e2c0485-e42f-11e5-8c3e-08002715d519'),(21,31,72,1,'2016-03-07 12:10:35',29,NULL,NULL,'7f64e2f2-e42f-11e5-8c3e-08002715d519'),(22,32,72,1,'2016-03-07 12:10:35',125,NULL,NULL,'7f6723f1-e42f-11e5-8c3e-08002715d519'),(23,33,72,1,'2016-03-07 12:10:35',127,NULL,NULL,'7f6fa6f1-e42f-11e5-8c3e-08002715d519'),(24,7,72,1,'2016-03-07 00:00:00',134,NULL,NULL,'80d19419-e42f-11e5-8c3e-08002715d519'),(25,2,72,1,'2016-03-07 00:00:00',135,NULL,NULL,'80d20f7c-e42f-11e5-8c3e-08002715d519'),(26,5,72,1,'2016-03-07 00:00:00',135,NULL,NULL,'80d23011-e42f-11e5-8c3e-08002715d519'),(27,3,72,1,'2016-03-07 00:00:00',136,NULL,NULL,'80d29e6f-e42f-11e5-8c3e-08002715d519'),(28,6,72,1,'2016-03-07 00:00:00',136,NULL,NULL,'80d2b957-e42f-11e5-8c3e-08002715d519'),(29,1,72,1,'2016-03-07 00:00:00',137,NULL,NULL,'80d33633-e42f-11e5-8c3e-08002715d519'),(30,4,72,1,'2016-03-07 00:00:00',137,NULL,NULL,'80d35c91-e42f-11e5-8c3e-08002715d519'),(31,34,72,1,'2016-03-07 00:00:00',140,NULL,NULL,'80d90ca1-e42f-11e5-8c3e-08002715d519'),(32,35,72,1,'2017-10-30 14:58:51',1,NULL,NULL,'67989aee-0d14-4b16-aadf-8606a62cb8f7'),(33,36,72,1,'2017-10-30 14:59:56',2,NULL,NULL,'2f4c348d-210f-4951-8c5c-cbca16aa84cc'),(34,39,1,1,'2017-10-31 11:52:47',144,NULL,NULL,'54efae6b-8dbb-40cb-8fc5-9a39ceea07a9'),(35,40,1,1,'2017-10-31 11:52:47',145,NULL,NULL,'1120c7e9-17e0-40ce-9aed-5708c1c16476'),(36,41,1,1,'2017-10-31 11:52:47',146,NULL,NULL,'2f69fa90-a05d-476f-bfb7-8fa7d2dd3301'),(37,42,1,1,'2017-10-31 11:52:47',147,NULL,NULL,'e88b6282-c865-414d-bb71-cd8594763bb1'),(38,43,1,1,'2017-10-31 11:52:47',148,NULL,NULL,'c592d0ad-7f14-45a9-826b-bc906e14b840'),(39,44,1,1,'2017-10-31 11:52:47',149,NULL,NULL,'8607a877-17ac-46a1-bd6e-d2bbd360530f'),(40,45,1,1,'2017-10-31 11:52:47',150,NULL,NULL,'659ed4b1-e7cb-40d5-b4ab-5de55e257956'),(41,46,1,1,'2017-10-31 11:52:47',151,NULL,NULL,'dab30cdf-92d0-4bdf-91e0-b8dffc075bfb'),(42,47,1,1,'2017-10-31 11:52:48',152,NULL,NULL,'a1e66f1a-ddf8-4eb3-8208-fd30efc15df6'),(43,48,1,1,'2017-10-31 11:52:48',153,NULL,NULL,'8be1c5ae-6875-4004-ac37-f67305a4815a'),(44,49,1,1,'2017-10-31 11:52:48',154,NULL,NULL,'a0be723d-40a3-4dd9-9c7c-2e9101df90c8'),(45,50,1,1,'2017-10-31 11:52:48',155,NULL,NULL,'60e304b1-e10d-4b5a-a8b1-d4e9822e50e0'),(46,51,1,1,'2017-10-31 11:52:48',156,NULL,NULL,'8d62c9e5-f8f3-449c-ad3a-e84f374ff99f'),(47,52,1,1,'2017-10-31 11:52:48',157,NULL,NULL,'21c62e29-6b57-4f1b-a9d6-24cdb731af43'),(48,53,1,1,'2017-10-31 11:52:48',158,NULL,NULL,'af1b59a4-2fb6-4917-b974-eefb33a744d1'),(49,54,1,1,'2017-10-31 11:52:48',159,NULL,NULL,'2ba82992-8e3a-4cd1-b53f-deb3ceddd4c7'),(50,55,1,1,'2017-10-31 11:52:48',160,NULL,NULL,'572c3bb1-7329-47a1-93af-a95163d07121'),(51,56,1,1,'2017-10-31 11:52:48',161,NULL,NULL,'7a2386ec-cf3b-4ab7-b50e-94bc425887e8'),(52,57,1,1,'2017-10-31 11:52:48',162,NULL,NULL,'8f38a018-999e-4ffa-bdf1-01c2c87db1d2'),(53,58,1,1,'2017-10-31 11:52:48',163,NULL,NULL,'4e083334-ce04-49c8-895c-216c43318958'),(54,59,1,1,'2017-10-31 11:52:48',164,NULL,NULL,'86dc230b-65ed-41f6-a81e-79ed2ee8411d'),(55,60,1,1,'2017-10-31 11:52:48',165,NULL,NULL,'50d57d66-276f-4685-8b7f-0e53c23f20ee'),(56,61,1,1,'2017-10-31 11:52:48',166,NULL,NULL,'620b34c9-21b0-4c91-aed5-458f9d60b92b'),(57,62,1,1,'2017-10-31 11:52:48',167,NULL,NULL,'068bd81a-8169-4b3b-98a4-6367abf83589'),(58,63,1,1,'2017-10-31 11:52:49',168,NULL,NULL,'9f2896cd-e21e-4496-96b1-ca793b4d3981'),(59,64,1,1,'2017-10-31 11:52:49',169,NULL,NULL,'13043875-505c-466c-940a-b29f729c88df'),(60,65,1,1,'2017-10-31 11:52:49',170,NULL,NULL,'aa9c90b3-f940-4d71-a413-f5b53f25f312'),(61,66,1,1,'2017-10-31 11:52:49',171,NULL,NULL,'b3b9624f-b887-4fb0-a934-e2fd59e1f3f2'),(62,67,1,1,'2017-10-31 11:52:49',172,NULL,NULL,'81ac22cf-5187-4ea5-872a-cfb818213157'),(63,68,1,1,'2017-10-31 11:52:49',173,NULL,NULL,'4c50cd1d-bbe0-41ce-bd35-837d2c9d8764'),(64,69,1,1,'2017-10-31 11:52:49',174,NULL,NULL,'c3b36e96-789f-4f7b-bc54-f76e0e0e652c'),(65,70,1,1,'2017-10-31 11:52:49',175,NULL,NULL,'78faf226-364a-4e35-b5bb-d967e6919aa7'),(66,71,1,1,'2017-10-31 11:52:49',176,NULL,NULL,'49591caf-8628-4af2-86ac-7b8732f2843e'),(67,72,1,1,'2017-10-31 11:52:49',177,NULL,NULL,'59e5ec76-52df-4877-a999-661489d906a9'),(68,24,1,1,'2017-10-31 11:52:49',178,NULL,NULL,'33138327-9796-4707-ba39-9ac9477d1ec9'),(69,25,1,1,'2017-10-31 11:52:49',179,NULL,NULL,'217898ea-7db8-4bbf-83d7-c9df65670224'),(70,26,1,1,'2017-10-31 11:52:49',180,NULL,NULL,'29fbe77c-c074-4262-8919-4d50c59b8dca'),(71,27,1,1,'2017-10-31 11:52:49',181,NULL,NULL,'c92eaaea-2ce4-4a4d-8c12-a29ac87b2a39'),(72,28,1,1,'2017-10-31 11:52:49',182,NULL,NULL,'edda995f-5113-479b-8f2b-806265e79931'),(73,73,1,1,'2017-10-31 11:52:50',183,NULL,NULL,'be606550-c53f-4c97-b5ed-ab69e9b5d659'),(74,74,1,1,'2017-10-31 11:52:50',184,NULL,NULL,'11bf7b8a-11b0-4e4e-8f36-44f13939cd79'),(75,75,1,1,'2017-10-31 11:52:50',185,NULL,NULL,'706115d3-96fa-4b2d-86e9-6a64020b2658'),(76,76,1,1,'2017-10-31 11:52:50',186,NULL,NULL,'bab83a55-7c60-42ea-8182-29c69a8aa4e1'),(77,77,1,1,'2017-10-31 11:52:50',187,NULL,NULL,'6744ab4e-647b-41a7-9211-032c3bf2e755'),(78,78,1,1,'2017-10-31 11:52:50',188,NULL,NULL,'582ae2a4-e74f-418e-8cc1-79cc9d475fca'),(79,79,1,1,'2017-10-31 11:52:50',189,NULL,NULL,'f9e37ad6-19eb-4c9e-bb6b-60258ec29b29'),(80,80,1,1,'2017-10-31 11:52:50',190,NULL,NULL,'8177e40a-9ab4-4e99-98c2-d4dac1df18f6'),(81,81,1,1,'2017-10-31 11:52:50',191,NULL,NULL,'a2318206-edfc-4c08-9fc6-a4039fa5891f'),(82,82,1,1,'2017-10-31 11:52:50',192,NULL,NULL,'8776f3fe-9e86-430a-8961-a3c593bcfbc1'),(83,83,1,1,'2017-10-31 11:52:50',193,NULL,NULL,'e910e0bd-6637-4d48-93c5-a8591089155b'),(84,84,1,1,'2017-10-31 11:52:50',194,NULL,NULL,'40d8d25a-ec8c-4bf9-be30-ee5c83faba09'),(85,85,1,1,'2017-10-31 11:52:50',195,NULL,NULL,'7f2b6ffd-228d-43a7-a52c-2e5ef2337939'),(86,86,1,1,'2017-10-31 11:52:50',196,NULL,NULL,'07b7db9a-e184-4670-9e13-e7cb032a351e'),(87,87,1,1,'2017-10-31 11:52:51',197,NULL,NULL,'197ffd99-2265-4433-b3db-38908fcc4ac7'),(88,88,1,1,'2017-10-31 11:52:51',198,NULL,NULL,'a6b70e3b-aaf2-4846-a914-59ab3494483e'),(89,89,1,1,'2017-10-31 11:52:51',199,NULL,NULL,'76734546-5d8c-4799-bda7-5004c8883e5e');
/*!40000 ALTER TABLE `concept_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_source`
--

DROP TABLE IF EXISTS `concept_reference_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `hl7_code` varchar(50) DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `unique_id` varchar(250) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `concept_reference_source_uuid_id` (`uuid`),
  UNIQUE KEY `concept_source_unique_hl7_codes` (`hl7_code`),
  UNIQUE KEY `concept_reference_source_unique_id_unique` (`unique_id`),
  KEY `unique_hl7_code` (`hl7_code`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_retired_concept_source` (`retired_by`),
  KEY `concept_reference_source_changed_by` (`changed_by`),
  CONSTRAINT `concept_reference_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_concept_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_source`
--

LOCK TABLES `concept_reference_source` WRITE;
/*!40000 ALTER TABLE `concept_reference_source` DISABLE KEYS */;
INSERT INTO `concept_reference_source` VALUES (1,'CEIL','CEIL Bacteriology concept source','CEIL',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'ff223060-e42d-11e5-8c3e-08002715d519',NULL,NULL,NULL),(2,'org.openmrs.module.bacteriology','concept source for bacteriology module','BACT',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'ff23b6d8-e42d-11e5-8c3e-08002715d519',NULL,NULL,NULL),(3,'org.openmrs.module.emrapi','Source used to tag concepts used in the EMR API module',NULL,2,'2016-03-07 12:00:10',0,NULL,NULL,NULL,'edd52713-8887-47b7-ba9e-6e1148824ca4',NULL,NULL,NULL),(4,'SNOMED CT','SNOMED Duration Source','SCT',1,'2016-03-07 12:10:34',0,NULL,NULL,NULL,'7eccf70a-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL),(5,'Abbreviation','Custom dictionary for storing abbreviation of concepts',NULL,1,'2016-03-07 12:10:36',0,NULL,NULL,NULL,'802e0e37-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL);
/*!40000 ALTER TABLE `concept_reference_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term`
--

DROP TABLE IF EXISTS `concept_reference_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term` (
  `concept_reference_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_creator` (`creator`),
  KEY `mapped_user_changed` (`changed_by`),
  KEY `mapped_user_retired` (`retired_by`),
  KEY `mapped_concept_source` (`concept_source_id`),
  KEY `idx_code_concept_reference_term` (`code`),
  CONSTRAINT `mapped_concept_source` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`),
  CONSTRAINT `mapped_user_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_retired` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term`
--

LOCK TABLES `concept_reference_term` WRITE;
/*!40000 ALTER TABLE `concept_reference_term` DISABLE KEYS */;
INSERT INTO `concept_reference_term` VALUES (1,1,'SPECIMEN ID','159968',NULL,'Specimen Id',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff25a24e-e42d-11e5-8c3e-08002715d519'),(2,1,'SPECIMEN COLLECTION DATE','159951',NULL,'Specimen Collection Date',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff25bb66-e42d-11e5-8c3e-08002715d519'),(3,1,'SPECIMEN SAMPLE SOURCE','159959',NULL,'Specimen Sample Source',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff25d935-e42d-11e5-8c3e-08002715d519'),(4,2,'SPECIMEN ID','SPECIMEN_ID',NULL,'Specimen Id',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff274c83-e42d-11e5-8c3e-08002715d519'),(5,2,'SPECIMEN COLLECTION DATE','SPECIMEN_COLLECTION_DATE',NULL,'Specimen Collection Date',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff2769e3-e42d-11e5-8c3e-08002715d519'),(6,2,'SPECIMEN SAMPLE SOURCE','SPECIMEN_SAMPLE_SOURCE',NULL,'Specimen Sample Source',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff2785bb-e42d-11e5-8c3e-08002715d519'),(7,2,'BACTERIOLOGY CONCEPT SET','BACTERIOLOGY_CONCEPT_SET',NULL,'Bacteriology Concept Set',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'ff27a1ea-e42d-11e5-8c3e-08002715d519'),(8,3,NULL,'Diagnosis Concept Set',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e24f426-e42f-11e5-8c3e-08002715d519'),(9,3,NULL,'Non-Coded Diagnosis',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e253efa-e42f-11e5-8c3e-08002715d519'),(10,3,NULL,'Coded Diagnosis',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e25911d-e42f-11e5-8c3e-08002715d519'),(11,3,NULL,'Diagnosis Certainty',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e25dc3f-e42f-11e5-8c3e-08002715d519'),(12,3,NULL,'Presumed',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e26626c-e42f-11e5-8c3e-08002715d519'),(13,3,NULL,'Confirmed',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e26ac6f-e42f-11e5-8c3e-08002715d519'),(14,3,NULL,'Diagnosis Order',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e272459-e42f-11e5-8c3e-08002715d519'),(15,3,NULL,'Secondary',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e27906c-e42f-11e5-8c3e-08002715d519'),(16,3,NULL,'Primary',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e27eff2-e42f-11e5-8c3e-08002715d519'),(17,3,NULL,'ADMIT',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e2a32e8-e42f-11e5-8c3e-08002715d519'),(18,3,NULL,'DISCHARGE',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e2a72d0-e42f-11e5-8c3e-08002715d519'),(19,3,NULL,'TRANSFER',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e2acb2a-e42f-11e5-8c3e-08002715d519'),(20,3,NULL,'Disposition',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e2b10ab-e42f-11e5-8c3e-08002715d519'),(21,3,NULL,'Disposition Concept Set',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e2b8c5f-e42f-11e5-8c3e-08002715d519'),(22,3,NULL,'DispositionNote',NULL,NULL,1,'2016-03-07 12:10:33',NULL,NULL,0,NULL,NULL,NULL,'7e2c0000-e42f-11e5-8c3e-08002715d519'),(23,4,'Second(s)','257997001',NULL,'Duration in Second(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7eced38a-e42f-11e5-8c3e-08002715d519'),(24,4,'Minute(s)','258701004',NULL,'Duration in Minute(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed0512a-e42f-11e5-8c3e-08002715d519'),(25,4,'Hour(s)','258702006',NULL,'Duration in Hour(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed1c613-e42f-11e5-8c3e-08002715d519'),(26,4,'Day(s)','258703001',NULL,'Duration in Day(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed3889c-e42f-11e5-8c3e-08002715d519'),(27,4,'Week(s)','258705008',NULL,'Duration in Week(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed53bc4-e42f-11e5-8c3e-08002715d519'),(28,4,'Month(s)','258706009',NULL,'Duration in Week(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed6f96d-e42f-11e5-8c3e-08002715d519'),(29,4,'Year(s)','258707000',NULL,'Duration in Year(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed8550c-e42f-11e5-8c3e-08002715d519'),(30,4,'Time(s)','252109000',NULL,'Duration in Time(s)',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7ed9e916-e42f-11e5-8c3e-08002715d519'),(31,3,'Admission Decision','Admission Decision',NULL,'',1,'2016-03-07 12:10:35',NULL,NULL,0,NULL,NULL,NULL,'7f647235-e42f-11e5-8c3e-08002715d519'),(32,3,'Deny Admission','Deny Admission',NULL,'Deny Admission',1,'2016-03-07 12:10:35',NULL,NULL,0,NULL,NULL,NULL,'7f668a1f-e42f-11e5-8c3e-08002715d519'),(33,3,NULL,'UNDO_DISCHARGE',NULL,NULL,1,'2016-03-07 12:10:35',NULL,NULL,0,NULL,NULL,NULL,'7f6fa379-e42f-11e5-8c3e-08002715d519'),(34,2,'SPECIMEN SAMPLE SOURCE NON CODED','SPECIMEN_SAMPLE_SOURCE_FREE_TEXT',NULL,'Specimen Sample Source',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'80d90ca1-e42f-11e5-8c3e-08002715d519'),(35,4,'True (qualifier value)','31874001',NULL,NULL,1,'2017-10-30 14:56:48',NULL,NULL,0,NULL,NULL,NULL,'12287769-5dab-44da-9137-0a523e43740b'),(36,4,'False (qualifier value)','64100000',NULL,NULL,1,'2017-10-30 14:59:25',NULL,NULL,0,NULL,NULL,NULL,'6238264f-9846-4e7f-a8e9-04e7604bd4d8'),(37,4,'Is a (attribute)','116680003',NULL,NULL,1,'2017-10-31 11:48:26',NULL,NULL,0,NULL,NULL,NULL,'7a128a6b-483a-4a1a-b98d-73d0affd86fe'),(38,4,'SAME AS (attribute)','168666000',NULL,NULL,1,'2017-10-31 11:49:59',NULL,NULL,0,NULL,NULL,NULL,'b37cb608-61dd-427c-8791-35563f2b9c47'),(39,4,'Capsule - unit of product usage (qualifier value)','428641000',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'8a3c5428-7ced-4c4f-a6d3-f8640c5bc531'),(40,4,'Tablet - unit of product usage (qualifier value)','428673006',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'f662d029-cfd9-4fae-8f32-864caa44b07e'),(41,4,'Teaspoonful - unit of product usage (qualifier value)','415703001',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'e60de393-0cca-4328-8244-ba6b321d67e2'),(42,4,'Tablespoonful - unit of product usage (qualifier value)','415702006',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'70e5958b-8243-4032-85ff-19013811f11f'),(43,4,'Drop - unit of product usage (qualifier value)','404218003',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'d9e5ab30-eaaf-455f-adf7-005fd68205ff'),(44,4,'milliliter (qualifier value)','258773002',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'32a08d4c-c227-45ce-b3ba-1d635b854dca'),(45,4,'milligram (qualifier value)','258684004',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'452dfd9c-635a-4500-b19d-f705ea0b6809'),(46,4,'international units (qualifier value)','258997004',NULL,NULL,1,'2017-10-31 11:52:47',NULL,NULL,0,NULL,NULL,NULL,'442e6f2f-8b83-4803-baaa-2178761b70b9'),(47,4,'Intradermal route (qualifier value)','372464004',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'fcea4174-f4fa-41d5-88a5-b6ef818c1657'),(48,4,'Intraperitoneal (qualifier value)','261100002',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'c488f143-58ed-4959-b70d-04d90b406948'),(49,4,'Intrathecal route (qualifier value)','72607000',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'ea506e98-ac13-412a-ab1d-081569918d0e'),(50,4,'Intraosseous route (qualifier value)','417255000',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'17baf827-093b-4f07-9136-1934bfbe394d'),(51,4,'Intramuscular (qualifier value)','255559005',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'f136756c-2c5d-40d4-81c9-33040103ae29'),(52,4,'Intravenous (qualifier value)','255560000',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'02479c70-4c6c-473d-9d80-64d88e870afc'),(53,4,'Nasal route (qualifier value)','46713006',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'789ef895-35a4-48e2-b635-17a4e70c7be5'),(54,4,'Topical route (qualifier value)','6064005',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'25df226f-619c-433d-ab21-e11410774ee4'),(55,4,'Oral route (qualifier value)','26643006',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'b1c654d0-6ebf-45e2-9523-d3424890de7e'),(56,4,'Vaginal route (qualifier value)','16857009',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'86dae4ab-785f-48a6-8b4a-928c0191f076'),(57,4,'Cutaneous route (qualifier value)','448598008',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'0f5dde0c-55da-4cb8-a7e9-26aae335f38b'),(58,4,'Rectal route (qualifier value)','37161004',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'68f05402-c9ea-42da-a40b-a0047efbc91b'),(59,4,'Sublingual route (qualifier value)','37839007',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'88125d3f-d5ca-4270-b0ba-55538f33288d'),(60,4,'Nasogastric route (qualifier value)','127492001',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'3b7f7d10-5a5b-482d-9212-6cbfa17feee2'),(61,4,'Once daily (qualifier value)','229797004',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'d53f06c3-54ff-42d7-8260-9973e36e1490'),(62,4,'Twice a day (qualifier value)','229799001',NULL,NULL,1,'2017-10-31 11:52:48',NULL,NULL,0,NULL,NULL,NULL,'bde49f9c-1317-49f0-8999-006debfc5524'),(63,4,'Three times daily (qualifier value)','229798009',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'2a0a68c2-1d38-41fc-8afe-5babb6282eb5'),(64,4,'Four times daily (qualifier value)','307439001',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'e5e55c6f-28b6-4ffb-9fbf-b00a25573c83'),(65,4,'Five times daily (qualifier value)','307440004',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'c4de4203-6e12-4dbe-ba60-14f82c6785da'),(66,4,'Before meal (qualifier value)','307165006',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'f08edc62-32e8-476b-8efd-ac2f50ff4297'),(67,4,'Take on an empty stomach (qualifier value)','717154004',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'e1ce27b7-988f-4bb3-a2f1-96392ac0f12e'),(68,4,'Postprandial (qualifier value)','24863003',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'657bed10-a8ae-4b39-ba48-e8624712bbfc'),(69,4,'Morning (qualifier value)','73775008',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'8c6de626-6644-46aa-bc52-b14715877b1f'),(70,4,'Evening (qualifier value)','3157002',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'573c1b15-a5ba-4471-b0f6-87426aecd7f0'),(71,4,'At the end of the day (qualifier value)','225762007',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'70c2d0b3-8ca0-445d-a15b-d493520c2901'),(72,4,'As directed for (qualifier value)','422135004',NULL,NULL,1,'2017-10-31 11:52:49',NULL,NULL,0,NULL,NULL,NULL,'febca4db-dca7-4018-90da-bad0e9d82eaa'),(73,4,'Hourly (qualifier value)','225768006',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'6e60da85-e14b-474d-99cf-e3a18d4b90f9'),(74,4,'Every two hours (qualifier value)','225750008',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'d0d6013a-2c43-42ea-8305-2391418a768f'),(75,4,'Every three hours (qualifier value)','225753005',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'b5acf492-0e4f-4d78-868e-39674d4031b1'),(76,4,'Every four hours (qualifier value)','225756002',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'dde8bf33-bc9c-4761-bbe1-b1888e516fda'),(77,4,'Every six hours (qualifier value)','307468000',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'df310781-25f3-48f5-9896-54c6336dca93'),(78,4,'Every eight hours (qualifier value)','307469008',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'a09d9a89-0ffa-49c5-a6bd-3a048a8c65c2'),(79,4,'Every twelve hours (qualifier value)','307470009',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'e22c17df-fcae-4146-b757-1be8ab9d0282'),(80,4,'Alternate days (qualifier value)','225760004',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'bb3deacf-81bb-4154-9041-e42ef5dc3514'),(81,4,'Once a week (qualifier value)','225769003',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'e5c4b346-270d-4558-b887-785bc2c3fa22'),(82,4,'Twice weekly (qualifier value)','229800002',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'d3d1e70c-8466-4c43-bfd3-414b07350705'),(83,4,'Three times weekly (qualifier value)','229804006',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'cbb30b57-5378-4db2-9399-fca086d57534'),(84,4,'Four times weekly (qualifier value)','307445009',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'a0db604f-9dff-4b8f-a105-ca470a34d0ec'),(85,4,'Five times weekly (qualifier value)','307446005',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'7db0d675-8f33-49df-ab0e-aca1c7f36c4c'),(86,4,'Six times weekly (qualifier value)','307447001',NULL,NULL,1,'2017-10-31 11:52:50',NULL,NULL,0,NULL,NULL,NULL,'71e2dd1b-e66b-4334-beef-aa1146de6f68'),(87,4,'Biweekly (qualifier value)','20050000',NULL,NULL,1,'2017-10-31 11:52:51',NULL,NULL,0,NULL,NULL,NULL,'34375998-3f81-4390-94df-a91e5a49f11a'),(88,4,'Triweekly (qualifier value)','51199007',NULL,NULL,1,'2017-10-31 11:52:51',NULL,NULL,0,NULL,NULL,NULL,'7f463301-b4f5-4e7f-8e24-713520d6363b'),(89,4,'Monthly (qualifier value)','89185003',NULL,NULL,1,'2017-10-31 11:52:51',NULL,NULL,0,NULL,NULL,NULL,'820b4812-2499-4317-b313-35b16e1d7f3a');
/*!40000 ALTER TABLE `concept_reference_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term_map`
--

DROP TABLE IF EXISTS `concept_reference_term_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term_map` (
  `concept_reference_term_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_a_id` int(11) NOT NULL,
  `term_b_id` int(11) NOT NULL,
  `a_is_to_b_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_term_a` (`term_a_id`),
  KEY `mapped_term_b` (`term_b_id`),
  KEY `mapped_concept_map_type_ref_term_map` (`a_is_to_b_id`),
  KEY `mapped_user_creator_ref_term_map` (`creator`),
  KEY `mapped_user_changed_ref_term_map` (`changed_by`),
  CONSTRAINT `mapped_concept_map_type_ref_term_map` FOREIGN KEY (`a_is_to_b_id`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `mapped_term_a` FOREIGN KEY (`term_a_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_term_b` FOREIGN KEY (`term_b_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `mapped_user_changed_ref_term_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `mapped_user_creator_ref_term_map` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term_map`
--

LOCK TABLES `concept_reference_term_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_term_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `concept_reference_term_map_view`
--

DROP TABLE IF EXISTS `concept_reference_term_map_view`;
/*!50001 DROP VIEW IF EXISTS `concept_reference_term_map_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `concept_reference_term_map_view` AS SELECT 
 1 AS `concept_id`,
 1 AS `concept_map_type_name`,
 1 AS `code`,
 1 AS `concept_reference_term_name`,
 1 AS `concept_reference_source_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `concept_set` int(11) NOT NULL DEFAULT '0',
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `concept_set_uuid_index` (`uuid`),
  KEY `idx_concept_set_concept` (`concept_id`),
  KEY `has_a` (`concept_set`),
  KEY `user_who_created` (`creator`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_set`
--

LOCK TABLES `concept_set` WRITE;
/*!40000 ALTER TABLE `concept_set` DISABLE KEYS */;
INSERT INTO `concept_set` VALUES (1,14,13,1,1,'2016-03-07 12:10:33','7e255669-e42f-11e5-8c3e-08002715d519'),(2,15,13,1,1,'2016-03-07 12:10:33','7e25a159-e42f-11e5-8c3e-08002715d519'),(3,16,13,1,1,'2016-03-07 12:10:33','7e2613ab-e42f-11e5-8c3e-08002715d519'),(4,19,13,1,1,'2016-03-07 12:10:33','7e273cf6-e42f-11e5-8c3e-08002715d519'),(5,25,26,1,1,'2016-03-07 12:10:33','7e2bb930-e42f-11e5-8c3e-08002715d519'),(6,27,26,1,1,'2016-03-07 12:10:33','7e2c18ff-e42f-11e5-8c3e-08002715d519'),(7,37,36,1,1,'2016-03-07 12:10:33','7e536c6f-e42f-11e5-8c3e-08002715d519'),(8,38,36,1,1,'2016-03-07 12:10:33','7e53b442-e42f-11e5-8c3e-08002715d519'),(9,39,36,1,1,'2016-03-07 12:10:33','7e53fd2e-e42f-11e5-8c3e-08002715d519'),(10,40,36,1,1,'2016-03-07 12:10:33','7e544615-e42f-11e5-8c3e-08002715d519'),(11,41,36,1,1,'2016-03-07 12:10:33','7e548a02-e42f-11e5-8c3e-08002715d519'),(12,42,36,1,1,'2016-03-07 12:10:33','7e60e3ea-e42f-11e5-8c3e-08002715d519'),(13,47,46,1,1,'2016-03-07 12:10:34','7e69b1e1-e42f-11e5-8c3e-08002715d519'),(40,89,36,1,1,'2016-03-07 12:10:34','7ec9f5cc-e42f-11e5-8c3e-08002715d519'),(57,96,63,0,1,'2016-03-07 12:10:35','7f22bcf7-e42f-11e5-8c3e-08002715d519'),(62,128,126,1,1,'2016-03-07 12:10:35','7f74a23b-e42f-11e5-8c3e-08002715d519'),(63,3,129,1,1,'2016-03-07 12:10:35','7f850abe-e42f-11e5-8c3e-08002715d519'),(64,50,13,1,1,'2016-03-07 12:10:36','7fe79eb0-e42f-11e5-8c3e-08002715d519'),(65,51,13,1,1,'2016-03-07 12:10:36','7fe7bb57-e42f-11e5-8c3e-08002715d519'),(66,49,13,1,1,'2016-03-07 12:10:36','7fe7d278-e42f-11e5-8c3e-08002715d519'),(67,135,134,1,1,'2016-03-07 12:10:38','80d1e093-e42f-11e5-8c3e-08002715d519'),(68,136,134,2,1,'2016-03-07 12:10:38','80d2720e-e42f-11e5-8c3e-08002715d519'),(69,137,134,3,1,'2016-03-07 12:10:38','80d305e9-e42f-11e5-8c3e-08002715d519'),(70,138,134,4,1,'2016-03-07 12:10:38','80d3b73c-e42f-11e5-8c3e-08002715d519'),(71,139,134,5,1,'2016-03-07 12:10:38','80d3f8c2-e42f-11e5-8c3e-08002715d519'),(72,140,134,1,1,'2016-03-07 12:10:38','80d8ea1c-e42f-11e5-8c3e-08002715d519');
/*!40000 ALTER TABLE `concept_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT '0',
  `program_workflow_id` int(11) DEFAULT '0',
  `program_workflow_state_id` int(11) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `concept_state_conversion_uuid_index` (`uuid`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  KEY `concept_triggers_conversion` (`concept_id`),
  KEY `conversion_to_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`),
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_state_conversion`
--

LOCK TABLES `concept_state_conversion` WRITE;
/*!40000 ALTER TABLE `concept_state_conversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_state_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_stop_word`
--

DROP TABLE IF EXISTS `concept_stop_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_stop_word` (
  `concept_stop_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) NOT NULL,
  `locale` varchar(50) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_stop_word_id`),
  UNIQUE KEY `Unique_StopWord_Key` (`word`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_stop_word`
--

LOCK TABLES `concept_stop_word` WRITE;
/*!40000 ALTER TABLE `concept_stop_word` DISABLE KEYS */;
INSERT INTO `concept_stop_word` VALUES (1,'A','en','f5f45540-e2a7-11df-87ae-18a905e044dc'),(2,'AND','en','f5f469ae-e2a7-11df-87ae-18a905e044dc'),(3,'AT','en','f5f47070-e2a7-11df-87ae-18a905e044dc'),(4,'BUT','en','f5f476c4-e2a7-11df-87ae-18a905e044dc'),(5,'BY','en','f5f47d04-e2a7-11df-87ae-18a905e044dc'),(6,'FOR','en','f5f4834e-e2a7-11df-87ae-18a905e044dc'),(7,'HAS','en','f5f48a24-e2a7-11df-87ae-18a905e044dc'),(8,'OF','en','f5f49064-e2a7-11df-87ae-18a905e044dc'),(9,'THE','en','f5f496ae-e2a7-11df-87ae-18a905e044dc'),(10,'TO','en','f5f49cda-e2a7-11df-87ae-18a905e044dc');
/*!40000 ALTER TABLE `concept_stop_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `concept_view`
--

DROP TABLE IF EXISTS `concept_view`;
/*!50001 DROP VIEW IF EXISTS `concept_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `concept_view` AS SELECT 
 1 AS `concept_id`,
 1 AS `concept_full_name`,
 1 AS `concept_short_name`,
 1 AS `concept_class_name`,
 1 AS `concept_datatype_name`,
 1 AS `retired`,
 1 AS `description`,
 1 AS `date_created`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `previous_condition_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `condition_non_coded` varchar(1024) DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `additional_detail` varchar(1024) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `end_reason` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`condition_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `condition_uuid_index` (`uuid`),
  KEY `conditions_previous_condition_id_fk` (`previous_condition_id`),
  KEY `conditions_patient_fk` (`patient_id`),
  KEY `conditions_concept_fk` (`concept_id`),
  KEY `conditions_end_reason_fk` (`end_reason`),
  KEY `conditions_created_by_fk` (`creator`),
  KEY `conditions_voided_by_fk` (`voided_by`),
  CONSTRAINT `conditions_concept_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `conditions_created_by_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `conditions_end_reason_fk` FOREIGN KEY (`end_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `conditions_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `conditions_previous_condition_id_fk` FOREIGN KEY (`previous_condition_id`) REFERENCES `conditions` (`condition_id`),
  CONSTRAINT `conditions_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `diagnosis_concept_view`
--

DROP TABLE IF EXISTS `diagnosis_concept_view`;
/*!50001 DROP VIEW IF EXISTS `diagnosis_concept_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `diagnosis_concept_view` AS SELECT 
 1 AS `concept_id`,
 1 AS `concept_full_name`,
 1 AS `concept_short_name`,
 1 AS `concept_class_name`,
 1 AS `concept_datatype_name`,
 1 AS `retired`,
 1 AS `description`,
 1 AS `date_created`,
 1 AS `icd10_code`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `combination` tinyint(1) NOT NULL DEFAULT '0',
  `dosage_form` int(11) DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `strength` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `drug_uuid_index` (`uuid`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `drug_creator` (`creator`),
  KEY `drug_changed_by` (`changed_by`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `route_concept` (`route`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `route_concept` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_ingredient` (
  `drug_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `strength` double DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`,`ingredient_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_ingredient_units_fk` (`units`),
  KEY `drug_ingredient_ingredient_id_fk` (`ingredient_id`),
  CONSTRAINT `drug_ingredient_drug_id_fk` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `drug_ingredient_ingredient_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_ingredient_units_fk` FOREIGN KEY (`units`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_ingredient`
--

LOCK TABLES `drug_ingredient` WRITE;
/*!40000 ALTER TABLE `drug_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `drug_inventory_id` int(11) DEFAULT NULL,
  `dose` double DEFAULT NULL,
  `as_needed` tinyint(1) DEFAULT NULL,
  `dosing_type` varchar(255) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `as_needed_condition` varchar(255) DEFAULT NULL,
  `num_refills` int(11) DEFAULT NULL,
  `dosing_instructions` text,
  `duration` int(11) DEFAULT NULL,
  `duration_units` int(11) DEFAULT NULL,
  `quantity_units` int(11) DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `dose_units` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `dispense_as_written` tinyint(1) NOT NULL DEFAULT '0',
  `drug_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `inventory_item` (`drug_inventory_id`),
  KEY `drug_order_duration_units_fk` (`duration_units`),
  KEY `drug_order_quantity_units` (`quantity_units`),
  KEY `drug_order_route_fk` (`route`),
  KEY `drug_order_dose_units` (`dose_units`),
  KEY `drug_order_frequency_fk` (`frequency`),
  CONSTRAINT `drug_order_dose_units` FOREIGN KEY (`dose_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_order_duration_units_fk` FOREIGN KEY (`duration_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`),
  CONSTRAINT `drug_order_quantity_units` FOREIGN KEY (`quantity_units`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `drug_order_route_fk` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_order`
--

LOCK TABLES `drug_order` WRITE;
/*!40000 ALTER TABLE `drug_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_reference_map`
--

DROP TABLE IF EXISTS `drug_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_reference_map` (
  `drug_reference_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `concept_map_type` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`drug_reference_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_for_drug_reference_map` (`drug_id`),
  KEY `concept_reference_term_for_drug_reference_map` (`term_id`),
  KEY `concept_map_type_for_drug_reference_map` (`concept_map_type`),
  KEY `user_who_changed_drug_reference_map` (`changed_by`),
  KEY `drug_reference_map_creator` (`creator`),
  KEY `user_who_retired_drug_reference_map` (`retired_by`),
  CONSTRAINT `concept_map_type_for_drug_reference_map` FOREIGN KEY (`concept_map_type`) REFERENCES `concept_map_type` (`concept_map_type_id`),
  CONSTRAINT `concept_reference_term_for_drug_reference_map` FOREIGN KEY (`term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`),
  CONSTRAINT `drug_for_drug_reference_map` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `drug_reference_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_drug_reference_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_drug_reference_map` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_reference_map`
--

LOCK TABLES `drug_reference_map` WRITE;
/*!40000 ALTER TABLE `drug_reference_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `encounter_uuid_index` (`uuid`),
  KEY `encounter_datetime_idx` (`encounter_datetime`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_visit_id_fk` (`visit_id`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `encounter_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `user_who_voided_encounter` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_provider`
--

DROP TABLE IF EXISTS `encounter_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_provider` (
  `encounter_provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `encounter_role_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_id_fk` (`encounter_id`),
  KEY `provider_id_fk` (`provider_id`),
  KEY `encounter_role_id_fk` (`encounter_role_id`),
  KEY `encounter_provider_creator` (`creator`),
  KEY `encounter_provider_changed_by` (`changed_by`),
  KEY `encounter_provider_voided_by` (`voided_by`),
  CONSTRAINT `encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `encounter_provider_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_provider_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_provider_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_id_fk` FOREIGN KEY (`encounter_role_id`) REFERENCES `encounter_role` (`encounter_role_id`),
  CONSTRAINT `provider_id_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_provider`
--

LOCK TABLES `encounter_provider` WRITE;
/*!40000 ALTER TABLE `encounter_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_role`
--

DROP TABLE IF EXISTS `encounter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_role` (
  `encounter_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_role_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `encounter_role_unique_name` (`name`),
  KEY `encounter_role_creator_fk` (`creator`),
  KEY `encounter_role_changed_by_fk` (`changed_by`),
  KEY `encounter_role_retired_by_fk` (`retired_by`),
  CONSTRAINT `encounter_role_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `encounter_role_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_role`
--

LOCK TABLES `encounter_role` WRITE;
/*!40000 ALTER TABLE `encounter_role` DISABLE KEYS */;
INSERT INTO `encounter_role` VALUES (1,'Unknown','Unknown encounter role for legacy providers with no encounter role set',1,'2011-08-18 14:00:00',NULL,NULL,0,NULL,NULL,NULL,'a0b03050-c99b-11e0-9572-0800200c9a66');
/*!40000 ALTER TABLE `encounter_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `view_privilege` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `encounter_type_unique_name` (`name`),
  UNIQUE KEY `encounter_type_uuid_index` (`uuid`),
  KEY `encounter_type_retired_status` (`retired`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  KEY `privilege_which_can_view_encounter_type` (`view_privilege`),
  KEY `privilege_which_can_edit_encounter_type` (`edit_privilege`),
  KEY `encounter_type_changed_by` (`changed_by`),
  CONSTRAINT `encounter_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `privilege_which_can_edit_encounter_type` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `privilege_which_can_view_encounter_type` FOREIGN KEY (`view_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `user_who_created_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_encounter_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_type`
--

LOCK TABLES `encounter_type` WRITE;
/*!40000 ALTER TABLE `encounter_type` DISABLE KEYS */;
INSERT INTO `encounter_type` VALUES (1,'Consultation','Consultation encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e10b3cb-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(2,'REG','Registration encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e12169a-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(3,'ADMISSION','ADMISSION encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e30c184-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(4,'DISCHARGE','DISCHARGE encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e3380a4-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(5,'TRANSFER','TRANSFER encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e375624-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(6,'RADIOLOGY','RADIOLOGY encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e4696f2-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(7,'INVESTIGATION','Investigation encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e4c0b07-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(8,'LAB_RESULT','Lab Result encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e515ad0-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(9,'Patient Document','Patient Document Encounter Type',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e71dc7a-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL),(10,'VALIDATION NOTES','Validation Notes encounter',1,'2016-03-07 00:00:00',0,NULL,NULL,NULL,'7e79c35b-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `encounter_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_mapping`
--

DROP TABLE IF EXISTS `entity_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `entity_mapping_type_id` int(11) NOT NULL,
  `entity1_uuid` char(38) NOT NULL,
  `entity2_uuid` char(38) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entity_mapping_entity_mapping_type_fk` (`entity_mapping_type_id`),
  CONSTRAINT `entity_mapping_entity_mapping_type_fk` FOREIGN KEY (`entity_mapping_type_id`) REFERENCES `entity_mapping_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_mapping`
--

LOCK TABLES `entity_mapping` WRITE;
/*!40000 ALTER TABLE `entity_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_mapping_type`
--

DROP TABLE IF EXISTS `entity_mapping_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_mapping_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `uuid` char(38) NOT NULL,
  `entity1_type` text NOT NULL,
  `entity2_type` text NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_entity_mapping_type_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_mapping_type`
--

LOCK TABLES `entity_mapping_type` WRITE;
/*!40000 ALTER TABLE `entity_mapping_type` DISABLE KEYS */;
INSERT INTO `entity_mapping_type` VALUES (1,'program_obstemplate','7fc6f297-e42f-11e5-8c3e-08002715d519','org.openmrs.Program','org.openmrs.Concept','2016-03-07 12:10:36'),(2,'program_encountertype','7fcc3a03-e42f-11e5-8c3e-08002715d519','org.openmrs.Program','org.openmrs.EncounterType','2016-03-07 12:10:36'),(3,'loginlocation_visittype','802a7221-e42f-11e5-8c3e-08002715d519','org.openmrs.Location','org.openmrs.VisitType','2015-11-25 18:54:23'),(4,'location_encountertype','8030f506-e42f-11e5-8c3e-08002715d519','org.openmrs.Location','org.openmrs.EncounterType','2016-03-07 12:10:36');
/*!40000 ALTER TABLE `entity_mapping_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode`
--

DROP TABLE IF EXISTS `episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `episode` (
  `episode_id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode`
--

LOCK TABLES `episode` WRITE;
/*!40000 ALTER TABLE `episode` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode_encounter`
--

DROP TABLE IF EXISTS `episode_encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `episode_encounter` (
  `episode_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  KEY `episode_encounter_encounter_id` (`encounter_id`),
  KEY `episode_encounter_episode_index` (`episode_id`),
  CONSTRAINT `episode_encounter_encounter_id` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `episode_encounter_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `episode` (`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_encounter`
--

LOCK TABLES `episode_encounter` WRITE;
/*!40000 ALTER TABLE `episode_encounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode_encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episode_patient_program`
--

DROP TABLE IF EXISTS `episode_patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `episode_patient_program` (
  `episode_id` int(11) NOT NULL,
  `patient_program_id` int(11) NOT NULL,
  KEY `episode_patient_program_patient_program_id` (`patient_program_id`),
  KEY `episode_patient_program_episode_index` (`episode_id`),
  CONSTRAINT `episode_patient_program_episode_id` FOREIGN KEY (`episode_id`) REFERENCES `episode` (`episode_id`),
  CONSTRAINT `episode_patient_program_patient_program_id` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episode_patient_program`
--

LOCK TABLES `episode_patient_program` WRITE;
/*!40000 ALTER TABLE `episode_patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `episode_patient_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_records`
--

DROP TABLE IF EXISTS `event_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uri` varchar(255) DEFAULT NULL,
  `object` varchar(1000) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tags` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `event_records_category_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_records`
--

LOCK TABLES `event_records` WRITE;
/*!40000 ALTER TABLE `event_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_records_offset_marker`
--

DROP TABLE IF EXISTS `event_records_offset_marker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_records_offset_marker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `event_count` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_records_offset_marker`
--

LOCK TABLES `event_records_offset_marker` WRITE;
/*!40000 ALTER TABLE `event_records_offset_marker` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_records_offset_marker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_records_queue`
--

DROP TABLE IF EXISTS `event_records_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_records_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uri` varchar(255) DEFAULT NULL,
  `object` varchar(1000) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_records_queue`
--

LOCK TABLES `event_records_queue` WRITE;
/*!40000 ALTER TABLE `event_records_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_records_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_event_retry_log`
--

DROP TABLE IF EXISTS `failed_event_retry_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_event_retry_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feed_uri` varchar(255) DEFAULT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `error_message` varchar(4000) DEFAULT NULL,
  `event_id` varchar(255) DEFAULT NULL,
  `event_content` varchar(4000) DEFAULT NULL,
  `error_hash_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_event_retry_log`
--

LOCK TABLES `failed_event_retry_log` WRITE;
/*!40000 ALTER TABLE `failed_event_retry_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_event_retry_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_events`
--

DROP TABLE IF EXISTS `failed_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feed_uri` varchar(255) DEFAULT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `error_message` varchar(4000) DEFAULT NULL,
  `event_id` varchar(255) DEFAULT NULL,
  `event_content` varchar(4000) DEFAULT NULL,
  `error_hash_code` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `retries` int(11) NOT NULL DEFAULT '0',
  `tags` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_events`
--

LOCK TABLES `failed_events` WRITE;
/*!40000 ALTER TABLE `failed_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `default_value` text,
  `select_multiple` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `field_uuid_index` (`uuid`),
  KEY `field_retired_status` (`retired`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `concept_for_field` (`concept_id`),
  KEY `user_who_created_field` (`creator`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `type_of_field` FOREIGN KEY (`field_type`) REFERENCES `field_type` (`field_type_id`),
  CONSTRAINT `user_who_changed_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_field` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT '0',
  `answer_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `field_answer_uuid_index` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_created_field_answer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_answer`
--

LOCK TABLES `field_answer` WRITE;
/*!40000 ALTER TABLE `field_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  `is_set` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `field_type_uuid_index` (`uuid`),
  KEY `user_who_created_field_type` (`creator`),
  CONSTRAINT `user_who_created_field_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_type`
--

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
INSERT INTO `field_type` VALUES (1,'Concept','',0,1,'2005-02-22 00:00:00','8d5e7d7c-c2cc-11de-8d13-0010c6dffd0f'),(2,'Database element','',0,1,'2005-02-22 00:00:00','8d5e8196-c2cc-11de-8d13-0010c6dffd0f'),(3,'Set of Concepts','',1,1,'2005-02-22 00:00:00','8d5e836c-c2cc-11de-8d13-0010c6dffd0f'),(4,'Miscellaneous Set','',1,1,'2005-02-22 00:00:00','8d5e852e-c2cc-11de-8d13-0010c6dffd0f'),(5,'Section','',1,1,'2005-02-22 00:00:00','8d5e86fa-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(50) NOT NULL DEFAULT '',
  `build` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `xslt` text,
  `template` text,
  `description` text,
  `encounter_type` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `form_uuid_index` (`uuid`),
  KEY `form_published_index` (`published`),
  KEY `form_retired_index` (`retired`),
  KEY `form_published_and_retired_index` (`published`,`retired`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_created_form` (`creator`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `user_who_created_form` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL DEFAULT '0',
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `form_field_uuid_index` (`uuid`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`),
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`),
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`),
  CONSTRAINT `user_who_created_form_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_last_changed_form_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_resource`
--

DROP TABLE IF EXISTS `form_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_resource` (
  `form_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value_reference` text NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`form_resource_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_form_and_name` (`form_id`,`name`),
  KEY `form_resource_changed_by` (`changed_by`),
  CONSTRAINT `form_resource_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `form_resource_form_fk` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_resource`
--

LOCK TABLES `form_resource` WRITE;
/*!40000 ALTER TABLE `form_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_property` (
  `property` varchar(255) NOT NULL DEFAULT '',
  `property_value` text,
  `description` text,
  `uuid` char(38) NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`property`),
  UNIQUE KEY `global_property_uuid_index` (`uuid`),
  KEY `global_property_property_index` (`property`),
  KEY `global_property_changed_by` (`changed_by`),
  CONSTRAINT `global_property_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_property`
--

LOCK TABLES `global_property` WRITE;
/*!40000 ALTER TABLE `global_property` DISABLE KEYS */;
INSERT INTO `global_property` VALUES ('addresshierarchy.addressToEntryMapUpdaterLastStartTime',NULL,'The module uses this field to store when the AddressToEntryMapUpdater task was last started; DO NOT MODIFY','a77fe3e5-0124-473c-a564-5735422a8ce0',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.allowFreetext','true','Valid values: true/false. When overriding the address portlet, allow the entry of free text for address fields associated with the address hierarchy by providing an \"Other\" option','1fa784e4-e088-40be-9a9a-880fdb9ab9ec',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.database_version','2.10.0','DO NOT MODIFY.  Current database version number for the addresshierarchy module.','8d8cdb7f-f7a3-4a37-b67b-dabfd9d580e0',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.enableOverrideOfAddressPortlet','true','Valid values: true/false. When enabled, the existing \"edit\" component of the address portlet is overridden by the new functionality provided by the address hierarchy module','552333ad-49bd-41a9-9072-9c3c784803f0',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.initializeAddressHierarchyCacheOnStartup','true','Sets whether to initialize the address hierarchy in-memory cache (which is used to speed up address hierarchy searches.\n            Generally, you want to set this to \"true\", though developers may want to set it to false during development\n            to speed module start-up.','8054f215-3af0-4e65-9742-761ffbc69d28',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.mandatory','false','true/false whether or not the addresshierarchy module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','c999f9dc-3833-4cec-831e-e68816ed7337',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.soundexProcessor',NULL,'If the Name Phonetics module is installed, this defines the name of a soundex algorithm used by the getPossibleFullAddresses service method.','3fe6dd93-7aa4-48b2-8fd7-7a98829cd6c1',NULL,NULL,NULL,NULL,NULL,NULL),('addresshierarchy.started','true','DO NOT MODIFY. true/false whether or not the addresshierarchy module has been started.  This is used to make sure modules that were running  prior to a restart are started again','b4de80fc-0fa4-4c60-80f6-72804bfe0262',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.allergen.ConceptClasses','Drug,MedSet','A comma-separated list of the allowed concept classes for the allergen field of the allergy dialog','f95f22e2-34ce-4837-abf1-485f9877f1cc',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.drug','162552AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the drug allergens concept','acd09681-61c2-4f0e-8677-b031668264e4',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.environment','162554AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the environment allergens concept','0e673da4-babc-441c-9a08-267c0db2bea2',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.food','162553AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the food allergens concept','7aa2e2bd-4176-4cfd-8a7e-47384ca117bc',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.otherNonCoded','5622AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy other non coded concept','aaee02c8-f1f7-438a-954e-f8f7c1c83475',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.reactions','162555AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy reactions concept','702da7ee-cab4-4b67-9ae7-d7c548567630',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.mild','1498AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the MILD severity concept','8c300842-6e12-4248-89bb-e06f07063164',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.moderate','1499AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the MODERATE severity concept','3afe2a8c-eedd-4ced-a0e7-5ed36d77e244',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.severe','1500AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the SEVERE severity concept','1a843161-e817-4062-bcbe-03c4924efa63',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.unknown','1067AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy unknown concept','30be47f1-f510-4ece-8d44-e4ed2069b74e',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.reaction.ConceptClasses','Symptom','A comma-separated list of the allowed concept classes for the reaction field of the allergy dialog','ebf55933-fe13-4ce5-89de-b76ff4fd0aec',NULL,NULL,NULL,NULL,NULL,NULL),('appframework.mandatory','false','true/false whether or not the appframework module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','9ff9fa1a-9608-4bf2-95dc-41e7c3bd6533',NULL,NULL,NULL,NULL,NULL,NULL),('appframework.started','true','DO NOT MODIFY. true/false whether or not the appframework module has been started.  This is used to make sure modules that were running  prior to a restart are started again','79a00a7b-40ef-48a2-a3fa-bcb59e2a4dda',NULL,NULL,NULL,NULL,NULL,NULL),('application.name','OpenMRS','The name of this application, as presented to the user, for example on the login and welcome pages.','cbe43983-e0af-4a3d-a9d2-6399f6fa6824',NULL,NULL,NULL,NULL,NULL,NULL),('appointments.mandatory','false','true/false whether or not the appointments module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','7eb30f21-9c7b-41ee-a06f-0b9a4f71bbb9',NULL,NULL,NULL,NULL,NULL,NULL),('appointments.started','true','DO NOT MODIFY. true/false whether or not the appointments module has been started.  This is used to make sure modules that were running  prior to a restart are started again','0b9f785c-4e0f-421c-88c4-ede15d9fb6d6',NULL,NULL,NULL,NULL,NULL,NULL),('appui.mandatory','false','true/false whether or not the appui module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','127af8a3-9344-483d-9f33-0dab51cdddee',NULL,NULL,NULL,NULL,NULL,NULL),('appui.started','true','DO NOT MODIFY. true/false whether or not the appui module has been started.  This is used to make sure modules that were running  prior to a restart are started again','e7ed2142-6506-4817-b46a-6766c25c192b',NULL,NULL,NULL,NULL,NULL,NULL),('atomfeed.event.urlPatternForPatientRelationshipChange','','URL pattern to use for published relationship events. Default is /openmrs/ws/rest/v1/relationship/%s','d7e2015e-191f-11e7-bbfc-9206fc7c228b',NULL,NULL,NULL,NULL,NULL,NULL),('atomfeed.event.urlPatternForProgramStateChange','','URL pattern to use for published program events. Default is /openmrs/ws/rest/v1/programenrollment/{uuid}?v=full','d7f1675f-191f-11e7-bbfc-9206fc7c228b',NULL,NULL,NULL,NULL,NULL,NULL),('atomfeed.publish.eventsForPatientProgramStateChange','','If set true, events related to program changes are published','d7efd354-191f-11e7-bbfc-9206fc7c228b',NULL,NULL,NULL,NULL,NULL,NULL),('atomfeed.publish.eventsForPatientRelationshipChange','','If set true, events related to relationship changes are published','d7e06014-191f-11e7-bbfc-9206fc7c228b',NULL,NULL,NULL,NULL,NULL,NULL),('auditlog.mandatory','false','true/false whether or not the auditlog module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','f3a91778-cb69-436f-832a-0987fc5293c5',NULL,NULL,NULL,NULL,NULL,NULL),('auditlog.started','true','DO NOT MODIFY. true/false whether or not the auditlog module has been started.  This is used to make sure modules that were running  prior to a restart are started again','22fa925e-0034-4890-933c-518f1969bc6b',NULL,NULL,NULL,NULL,NULL,NULL),('bacteriology.mandatory','false','true/false whether or not the bacteriology module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','27c3e167-ae9f-4563-9edf-4bd7bc95eaff',NULL,NULL,NULL,NULL,NULL,NULL),('bacteriology.started','true','DO NOT MODIFY. true/false whether or not the bacteriology module has been started.  This is used to make sure modules that were running  prior to a restart are started again','0b545d6b-1459-4ca7-b551-9d7deceb1822',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.cacheHeadersFilter.expiresDuration','0','Expires duration in minutes','672dc790-e0b6-11e3-8b68-0800200c9a66',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.enableAuditLog','true','Enable or disable audit log','4ec1dda0-c5a0-4820-9995-1c1ef90bd54d',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.encountersession.duration','60','Encountersession duration in minutes','7e40e716-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.encounterType.default','Consultation','Default Encounter Type','7fa2c0d3-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.extraPatientIdentifierTypes',NULL,'A list of UUIDs indicating extra Patient Identifier Types that should be displayed','d997a017-862c-4b73-962f-1faf06c93410',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.forms.directory','/home/bahmni/clinical_forms/','Filesystem path for saving the bahmni forms','4d5a0707-fd99-44d1-bf83-2145b5e3948c',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.ie.apps.mandatory','false','true/false whether or not the bahmni.ie.apps module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','2dc3dbf6-6195-4276-82a5-e72fc91a6f78',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.ie.apps.started','true','DO NOT MODIFY. true/false whether or not the bahmni.ie.apps module has been started.  This is used to make sure modules that were running  prior to a restart are started again','48350816-275f-4bda-9123-7e5c547559ad',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.primaryIdentifierType','7dfc1a64-e42f-11e5-8c3e-08002715d519','Primary identifier type for looking up patients, generating barcodes, etc','247c96d7-59af-4864-8b7a-4d956d32a0cf',NULL,NULL,NULL,NULL,NULL,NULL),('bahmni.relationshipTypeMap',NULL,'Relationship Type Map format Eg:{ \"patient\": [\"Sibling\", \"Parent\"],\"provider\": [\"Doctor\"]}.If no value is specified default is  patient relationship.','448d2659-ad47-42e3-afa3-7ac49c03b7b8',NULL,NULL,NULL,NULL,NULL,NULL),('bahmnicore.mandatory','false','true/false whether or not the bahmnicore module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','873189b1-972a-4244-8084-85d98207bbcd',NULL,NULL,NULL,NULL,NULL,NULL),('bahmnicore.started','true','DO NOT MODIFY. true/false whether or not the bahmnicore module has been started.  This is used to make sure modules that were running  prior to a restart are started again','2293b5a8-b235-412f-9857-73203eb671a4',NULL,NULL,NULL,NULL,NULL,NULL),('bedmanagement.mandatory','false','true/false whether or not the bedmanagement module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','3bd0ab8a-8713-4ae2-a0dd-b637dbd3e9d2',NULL,NULL,NULL,NULL,NULL,NULL),('bedmanagement.started','true','DO NOT MODIFY. true/false whether or not the bedmanagement module has been started.  This is used to make sure modules that were running  prior to a restart are started again','99871c23-1568-4979-8979-54ed1ab8ba48',NULL,NULL,NULL,NULL,NULL,NULL),('calculation.mandatory','false','true/false whether or not the calculation module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','8028ce6a-3e93-4023-9785-4492b4d2226a',NULL,NULL,NULL,NULL,NULL,NULL),('calculation.started','true','DO NOT MODIFY. true/false whether or not the calculation module has been started.  This is used to make sure modules that were running  prior to a restart are started again','0e541ae2-daaa-40be-b792-78c91b4f6ebf',NULL,NULL,NULL,NULL,NULL,NULL),('concept.causeOfDeath','5002','Concept id of the concept defining the CAUSE OF DEATH concept','446ebec3-3cc6-43c7-8958-7c6137060833',NULL,NULL,NULL,NULL,NULL,NULL),('concept.defaultConceptMapType','NARROWER-THAN','Default concept map type which is used when no other is set','4c362c89-d2e1-4cc2-913f-76d73884dd22',NULL,NULL,NULL,NULL,NULL,NULL),('concept.false','2','Concept id of the concept defining the FALSE boolean concept','bfe79ec7-e55e-4202-88b5-e33e860056e2',NULL,NULL,NULL,NULL,NULL,NULL),('concept.height','5090','Concept id of the concept defining the HEIGHT concept','ed3bd72b-4954-4268-9658-c8954b70c579',NULL,NULL,NULL,NULL,NULL,NULL),('concept.medicalRecordObservations','1238','The concept id of the MEDICAL_RECORD_OBSERVATIONS concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','57da780c-41af-4b32-94b9-e0e92016c075',NULL,NULL,NULL,NULL,NULL,NULL),('concept.none','1107','Concept id of the concept defining the NONE concept','cf76ce46-a457-42f8-a10c-93fe35c88b5f',NULL,NULL,NULL,NULL,NULL,NULL),('concept.otherNonCoded','5622','Concept id of the concept defining the OTHER NON-CODED concept','77f2e970-550e-480e-80ea-e783f08ef7d0',NULL,NULL,NULL,NULL,NULL,NULL),('concept.patientDied','1742','Concept id of the concept defining the PATIENT DIED concept','1f3a3dc4-7ec8-4ff8-b134-86728f4cb84d',NULL,NULL,NULL,NULL,NULL,NULL),('concept.problemList','1284','The concept id of the PROBLEM LIST concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','4bf79ff4-3d99-4771-8fc3-fca08acc5be5',NULL,NULL,NULL,NULL,NULL,NULL),('concept.reasonExitedCare',NULL,'Concept id of the concept defining the REASON EXITED CARE concept','3f2f8b7c-f5ec-412b-9897-1d7b62543f59',NULL,NULL,NULL,NULL,NULL,NULL),('concept.reasonForDeath','','Fully Specified name of the Concept Set created as Reasons for death','7fb96596-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('concept.reasonOrderStopped','1812','Concept id of the concept defining the REASON ORDER STOPPED concept','10a59ed0-085f-48f6-9e41-49359e042ae5',NULL,NULL,NULL,NULL,NULL,NULL),('concept.true','1','Concept id of the concept defining the TRUE boolean concept','c3586f75-5fc8-47e4-beb6-209cf0dd4dff',NULL,NULL,NULL,NULL,NULL,NULL),('concept.weight','5089','Concept id of the concept defining the WEIGHT concept','839e9b1d-c0e6-4bba-a99c-1a93fd8611b3',NULL,NULL,NULL,NULL,NULL,NULL),('conceptDrug.dosageForm.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the dosage form field of the concept drug management form.','c974eb42-416f-4485-be66-e28a50d6391d',NULL,NULL,NULL,NULL,NULL,NULL),('conceptDrug.route.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the route field of the concept drug management form.','91626580-b3d6-43d6-a98b-bfc37e999d20',NULL,NULL,NULL,NULL,NULL,NULL),('conceptmanagementapps.mandatory','false','true/false whether or not the conceptmanagementapps module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','45f442ef-42f5-4aaa-bfd6-6b104a86ac88',NULL,NULL,NULL,NULL,NULL,NULL),('conceptmanagementapps.started','true','DO NOT MODIFY. true/false whether or not the conceptmanagementapps module has been started.  This is used to make sure modules that were running  prior to a restart are started again','fb3130ff-63c1-4a2b-a149-de2caeffaf25',NULL,NULL,NULL,NULL,NULL,NULL),('concepts.locked','false','if true, do not allow editing concepts','3606f833-27ee-4a45-8afc-a4517e672a96','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('concept_map_type_management.enable','false','Enables or disables management of concept map types','68db8334-eff3-45d4-983e-e21c2aec5127','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('conditionList.endReasonConceptSetUuid',NULL,'UUID of end reason concept set','88bb10cc-86c6-4368-a3bf-4b71640236ea',NULL,NULL,NULL,NULL,NULL,NULL),('conditionList.nonCodedUuid','9c8bda0f-bd4f-11e7-8025-08002715d519','UUID of non coded concept','68ad18e6-d988-45c8-b29f-68d9f075a464',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.maximumNumberToShow','3','An integer which, if specified, would determine the maximum number of encounters to display on the encounter tab of the patient dashboard.','9098d25e-7f39-4614-816f-65938c3f8530',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.providerDisplayRoles',NULL,'A comma-separated list of encounter roles (by name or id). Providers with these roles in an encounter will be displayed on the encounter tab of the patient dashboard.','395c9d17-51b1-4ffd-b7a7-7e38422e2017',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showEditLink','true','true/false whether or not to show the \'Edit Encounter\' link on the patient dashboard','34864fef-be8e-4eb5-a6ec-92ab394288bc','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showEmptyFields','true','true/false whether or not to show empty fields on the \'View Encounter\' window','16dbf088-5d76-4986-a55c-ebf29386fd2b','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showViewLink','true','true/false whether or not to show the \'View Encounter\' link on the patient dashboard','cbd3bb53-52ae-4b27-93fc-5f42f419a6de','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.usePages','smart','true/false/smart on how to show the pages on the \'View Encounter\' window.  \'smart\' means that if > 50% of the fields have page numbers defined, show data in pages','530443f6-68c8-4a26-bc84-ed9daf9c58e6',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.programs_to_show',NULL,'List of programs to show Enrollment details of in the patient header. (Should be an ordered comma-separated list of program_ids or names.)','b7d448cd-3c6a-45f0-91c5-89c326fa4688',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.showConcept','5497','Comma delimited list of concepts ids to show on the patient header overview','b1a6513d-4a26-4561-939c-e8d32d28f0f3',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.workflows_to_show',NULL,'List of programs to show Enrollment details of in the patient header. List of workflows to show current status of in the patient header. These will only be displayed if they belong to a program listed above. (Should be a comma-separated list of program_workflow_ids.)','c57f288e-62d6-4806-8406-8f010d415f44',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.metadata.caseConversion',NULL,'Indicates which type automatic case conversion is applied to program/workflow/state in the patient dashboard. Valid values: lowercase, uppercase, capitalize. If empty no conversion is applied.','f4064617-4128-4222-9dd2-2acca7348540',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.overview.showConcepts',NULL,'Comma delimited list of concepts ids to show on the patient dashboard overview tab','885f61e1-1f2b-419e-99a3-fed0e2dc5041',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.regimen.displayDrugSetIds','ANTIRETROVIRAL DRUGS,TUBERCULOSIS TREATMENT DRUGS','Drug sets that appear on the Patient Dashboard Regimen tab. Comma separated list of name of concepts that are defined as drug sets.','48ca2a1e-7d6c-4253-a6e4-2811680ee004',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.regimen.displayFrequencies','7 days/week,6 days/week,5 days/week,4 days/week,3 days/week,2 days/week,1 days/week','Frequency of a drug order that appear on the Patient Dashboard. Comma separated list of name of concepts that are defined as drug frequencies.','4189de4d-7eb2-4346-8bba-70e92472de70',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.relationships.show_types',NULL,'Types of relationships separated by commas.  Doctor/Patient,Parent/Child','7f30af4f-1315-4374-840e-658bc96edfa7',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.showPatientName','false','Whether or not to display the patient name in the patient dashboard title. Note that enabling this could be security risk if multiple users operate on the same computer.','ce803dfe-631a-4824-a489-009cd98b04c3','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('datePicker.weekStart','0','First day of the week in the date picker. Domingo/Dimanche/Sunday:0  Lunes/Lundi/Monday:1','287aac81-a45f-48e2-b609-6ca3f0b15f91',NULL,NULL,NULL,NULL,NULL,NULL),('default_locale','en','Specifies the default locale. You can specify both the language code(ISO-639) and the country code(ISO-3166), e.g. \'en_GB\' or just country: e.g. \'en\'','c743e3c1-7f39-4257-9580-0553ef35dae1',NULL,NULL,NULL,NULL,NULL,NULL),('default_location','Unknown Location','The name of the location to use as a system default','0808d88f-b448-4282-bd37-9ab60733742a',NULL,NULL,NULL,NULL,NULL,NULL),('default_theme',NULL,'Default theme for users.  OpenMRS ships with themes of \'green\', \'orange\', \'purple\', and \'legacy\'','25ff7e3b-4719-496d-865e-8e07d2b73a34',NULL,NULL,NULL,NULL,NULL,NULL),('disableDefaultAppointmentValidations','false','Disable default appointment validations','8c68f743-c89c-484c-baa2-4a9ee4bc0409',NULL,NULL,NULL,NULL,NULL,NULL),('drugOrder.drugOther','80215a4d-e42f-11e5-8c3e-08002715d519','Specifies the uuid of the concept which represents drug other non coded','94601478-690d-4c3f-952c-052ff1af9bd9',NULL,NULL,NULL,NULL,NULL,NULL),('drugOrder.requireDrug','false','Set to value true if you need to specify a formulation(Drug) when creating a drug order.','1301049e-72a9-4731-9c6e-fbfce98696b8',NULL,NULL,NULL,NULL,NULL,NULL),('elisatomfeedclient.mandatory','false','true/false whether or not the elisatomfeedclient module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','8f17b2e4-f018-445b-bf8b-f30cef5e3021',NULL,NULL,NULL,NULL,NULL,NULL),('elisatomfeedclient.started','true','DO NOT MODIFY. true/false whether or not the elisatomfeedclient module has been started.  This is used to make sure modules that were running  prior to a restart are started again','37030c93-d32d-461c-b550-1816fc5c0100',NULL,NULL,NULL,NULL,NULL,NULL),('emr.admissionEncounterType','This global property had been migrated to metadata mapping in source \'org.openmrs.module.emrapi\' with code \'&s\'','UUID of the encounter type for admitting a patient','f99114c8-8215-4be9-8dd3-9ff14d27e3b4',NULL,NULL,NULL,NULL,NULL,NULL),('emr.admissionForm',NULL,'UUID of the Admission Form (not required)','b03348df-d10f-4e6f-9858-edfea74a74b0',NULL,NULL,NULL,NULL,NULL,NULL),('emr.atFacilityVisitType',NULL,'UUID of the VisitType that we use for newly-created visits','624885de-18d0-4447-befe-7319930e80cc',NULL,NULL,NULL,NULL,NULL,NULL),('emr.encounterMatcher','org.bahmni.module.bahmnicore.matcher.EncounterSessionMatcher','custom encounter session matcher','7e420279-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emr.exitFromInpatientEncounterType','This global property had been migrated to metadata mapping in source \'org.openmrs.module.emrapi\' with code \'&s\'','UUID of the encounter type for exiting a patient from inpatient care','7a4f2612-4d16-423b-9723-39fe7c527c8c',NULL,NULL,NULL,NULL,NULL,NULL),('emr.exitFromInpatientForm',NULL,'UUID of the Discharge Form (not required)','e1b7391c-9bf3-47b0-b8a3-9eb48cdcfe0d',NULL,NULL,NULL,NULL,NULL,NULL),('emr.transferWithinHospitalEncounterType',NULL,'UUID of the encounter type for transferring a patient within the hospital','b389cd73-e89f-446e-9c2f-2af3e14be8ae',NULL,NULL,NULL,NULL,NULL,NULL),('emr.transferWithinHospitalForm',NULL,'UUID of the Transfer Form (not required)','f6953135-895d-4888-9009-7b6dd2434234',NULL,NULL,NULL,NULL,NULL,NULL),('emr.unknownLocation',NULL,'UUID of the Location that represents an Unknown Location','a3feb5bb-9207-454f-8d7b-0c0f1e7cac97',NULL,NULL,NULL,NULL,NULL,NULL),('emr.unknownProvider','f9badd80-ab76-11e2-9e96-0800200c9a66','UUID of the Provider that represents an Unknown Provider','ecb5542a-6965-4d4b-878d-53b9a311dc91',NULL,NULL,NULL,NULL,NULL,NULL),('emr.visitNoteEncounterType',NULL,'UUID of the encounter type for a visit note','5da8f597-032f-4c2c-b0db-afb78eb0a883',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.EmrApiVisitAssignmentHandler.encounterTypeToNewVisitTypeMap',NULL,'Specifies the mapping of encounter types to new visit types for more see https://wiki.openmrs.org/x/vgF4Aw','23b80d51-bb6c-41a2-b975-2d67d9b549fb',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.lastViewedPatientSizeLimit','50','Specifies the system wide number of patients to store as last viewed for a single user,\n            defaults to 50 if not specified','b24e653b-b446-485b-b7ad-85cdd075a820',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.mandatory','false','true/false whether or not the emrapi module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','399491f2-9008-4314-ae23-87d9df09b61d',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.nonDiagnosisConceptSets',NULL,'UUIDs or mapping of non diagnosis concept sets','4676872c-aa98-46f5-a3c7-3badae8abe7d',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlGet.wardsListDetails','SELECT\n  b.bed_number AS \'Bed\',\n  concat(pn.given_name, \' \', ifnull(pn.family_name,\'\')) AS \'Name\',\n  pv.uuid AS \'Patient Uuid\',\n  pi.identifier AS \'Id\',\n  pv.gender AS \'Gender\',\n  TIMESTAMPDIFF(YEAR, pv.birthdate, CURDATE()) AS \'Age\',\n  pa.county_district AS \'District\',\n  pa.city_village AS \'Village\',\n  admission_provider_name.given_name AS \'Admission By\',\n  cast(DATE_FORMAT(latestAdmissionEncounter.max_encounter_datetime, \'%d %b %y %h:%i %p\') AS CHAR) AS \'Admission Time\',\n  diagnosis.diagnosisConcept AS \'Diagnosis\',\n  diagnosis.certainty AS \'Diagnosis Certainty\',\n  diagnosis.diagnosisOrder AS \'Diagnosis Order\',\n  diagnosis.status AS \'Diagnosis Status\',\n  diagnosis.diagnosis_provider AS \'Diagnosis Provider\',\n  cast(DATE_FORMAT(diagnosis.diagnosis_datetime, \'%d %b %y %h:%i %p\') AS\n       CHAR) AS \'Diagnosis Datetime\',\n  dispositionInfo.providerName AS \'Disposition By\',\n  cast(DATE_FORMAT(dispositionInfo.providerDate, \'%d %b %y %h:%i %p\') AS CHAR) AS \'Disposition Time\',\n  adtNotes.value_text AS \'ADT Notes\',\n  v.uuid AS \'Visit Uuid\'\nFROM bed_location_map blm\n  INNER JOIN bed b\n    ON blm.bed_id = b.bed_id AND\n       b.status = \'OCCUPIED\' AND\n       blm.location_id IN (SELECT child_location.location_id\n                           FROM location child_location JOIN\n                             location parent_location\n                               ON parent_location.location_id =\n                                  child_location.parent_location\n                           WHERE\n                             parent_location.name = ${location_name})\n  INNER JOIN bed_patient_assignment_map bpam ON b.bed_id = bpam.bed_id AND date_stopped IS NULL\n  INNER JOIN person pv ON pv.person_id = bpam.patient_id\n  INNER JOIN person_name pn ON pn.person_id = pv.person_id\n  INNER JOIN patient_identifier pi ON pv.person_id = pi.patient_id\n  INNER JOIN patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n  INNER JOIN global_property gp on gp.property=\'bahmni.primaryIdentifierType\' and gp.property_value=pit.uuid\n  LEFT JOIN person_address pa ON pa.person_id = pv.person_id\n  INNER JOIN (SELECT\n                patient_id,\n                max(encounter_datetime) AS max_encounter_datetime,\n                max(visit_id) as visit_id,\n                max(encounter_id) AS encounter_id\n              FROM encounter\n                INNER JOIN encounter_type ON encounter_type.encounter_type_id = encounter.encounter_type\n              WHERE encounter_type.name = \'ADMISSION\'\n              GROUP BY patient_id) latestAdmissionEncounter ON pv.person_id = latestAdmissionEncounter.patient_id\n  INNER JOIN visit v ON latestAdmissionEncounter.visit_id = v.visit_id\n  LEFT OUTER JOIN obs adtNotes\n    ON adtNotes.encounter_id = latestAdmissionEncounter.encounter_id AND adtNotes.voided = 0 AND\n       adtNotes.concept_id = (SELECT concept_id\n                              FROM concept_name\n                              WHERE name = \'Adt Notes\' AND concept_name_type = \'FULLY_SPECIFIED\')\n  LEFT OUTER JOIN encounter_provider ep ON ep.encounter_id = latestAdmissionEncounter.encounter_id\n  LEFT OUTER JOIN provider admission_provider ON admission_provider.provider_id = ep.provider_id\n  LEFT OUTER JOIN person_name admission_provider_name\n    ON admission_provider_name.person_id = admission_provider.person_id\n  LEFT OUTER JOIN (\n                    SELECT\n                      bpam.patient_id AS person_id,\n                      concept_name.name AS disposition,\n                      latestDisposition.obs_datetime AS providerDate,\n                      person_name.given_name AS providerName\n                    FROM bed_patient_assignment_map bpam\n                      INNER JOIN (SELECT\n                                    person_id,\n                                    max(obs_id) obs_id\n                                  FROM obs\n                                  WHERE concept_id = (SELECT concept_id\n                                                      FROM concept_name\n                                                      WHERE\n                                                        name = \'Disposition\' AND concept_name_type = \'FULLY_SPECIFIED\')\n                                  GROUP BY person_id) maxObsId ON maxObsId.person_id = bpam.patient_id\n                      INNER JOIN obs latestDisposition\n                        ON maxObsId.obs_id = latestDisposition.obs_id AND latestDisposition.voided = 0\n                      INNER JOIN concept_name ON latestDisposition.value_coded = concept_name.concept_id AND\n                                                 concept_name_type = \'FULLY_SPECIFIED\'\n                      LEFT OUTER JOIN encounter_provider ep ON latestDisposition.encounter_id = ep.encounter_id\n                      LEFT OUTER JOIN provider disp_provider ON disp_provider.provider_id = ep.provider_id\n                      LEFT OUTER JOIN person_name ON person_name.person_id = disp_provider.person_id\n                    WHERE bpam.date_stopped IS NULL\n                  ) dispositionInfo ON pv.person_id = dispositionInfo.person_id\n  LEFT OUTER JOIN (\n                    SELECT\n                      diagnosis.person_id AS person_id,\n                      diagnosis.obs_id AS obs_id,\n                      diagnosis.obs_datetime AS diagnosis_datetime,\n                      if(diagnosisConceptName.name IS NOT NULL, diagnosisConceptName.name,\n                         diagnosis.value_text) AS diagnosisConcept,\n                      certaintyConceptName.name AS certainty,\n                      diagnosisOrderConceptName.name AS diagnosisOrder,\n                      diagnosisStatusConceptName.name AS status,\n                      person_name.given_name AS diagnosis_provider\n                    FROM bed_patient_assignment_map bpam\n                      INNER JOIN visit latestVisit\n                        ON latestVisit.patient_id = bpam.patient_id AND latestVisit.date_stopped IS NULL AND\n                           bpam.date_stopped IS NULL\n                      INNER JOIN encounter ON encounter.visit_id = latestVisit.visit_id\n                      INNER JOIN obs diagnosis ON bpam.patient_id = diagnosis.person_id AND diagnosis.voided = 0 AND\n                                                  diagnosis.encounter_id = encounter.encounter_id AND\n                                                  diagnosis.concept_id IN (SELECT concept_id\n                                                                           FROM concept_name\n                                                                           WHERE name IN\n                                                                                 (\'Coded Diagnosis\', \'Non-Coded Diagnosis\')\n                                                                                 AND\n                                                                                 concept_name_type = \'FULLY_SPECIFIED\')\n                      LEFT OUTER JOIN concept_name diagnosisConceptName\n                        ON diagnosis.value_coded IS NOT NULL AND diagnosis.value_coded = diagnosisConceptName.concept_id\n                           AND diagnosisConceptName.concept_name_type = \'FULLY_SPECIFIED\'\n                      LEFT OUTER JOIN encounter_provider ep ON diagnosis.encounter_id = ep.encounter_id\n                      LEFT OUTER JOIN provider diagnosis_provider ON diagnosis_provider.provider_id = ep.provider_id\n                      LEFT OUTER JOIN person_name ON person_name.person_id = diagnosis_provider.person_id\n                      INNER JOIN obs certainty\n                        ON diagnosis.obs_group_id = certainty.obs_group_id AND certainty.voided = 0 AND\n                           certainty.concept_id = (SELECT concept_id\n                                                   FROM concept_name\n                                                   WHERE name = \'Diagnosis Certainty\' AND\n                                                         concept_name_type = \'FULLY_SPECIFIED\')\n                      LEFT OUTER JOIN concept_name certaintyConceptName\n                        ON certainty.value_coded IS NOT NULL AND certainty.value_coded = certaintyConceptName.concept_id\n                           AND certaintyConceptName.concept_name_type = \'FULLY_SPECIFIED\'\n                      INNER JOIN obs diagnosisOrder\n                        ON diagnosis.obs_group_id = diagnosisOrder.obs_group_id AND diagnosisOrder.voided = 0 AND\n                           diagnosisOrder.concept_id = (SELECT concept_id\n                                                        FROM concept_name\n                                                        WHERE name = \'Diagnosis order\' AND\n                                                              concept_name_type = \'FULLY_SPECIFIED\')\n                      LEFT OUTER JOIN concept_name diagnosisOrderConceptName ON diagnosisOrder.value_coded IS NOT NULL\n                                                                                AND diagnosisOrder.value_coded =\n                                                                                    diagnosisOrderConceptName.concept_id\n                                                                                AND\n                                                                                diagnosisOrderConceptName.concept_name_type\n                                                                                = \'FULLY_SPECIFIED\'\n                      LEFT JOIN obs diagnosisStatus\n                        ON diagnosis.obs_group_id = diagnosisStatus.obs_group_id AND diagnosisStatus.voided = 0 AND\n                           diagnosisStatus.concept_id = (SELECT concept_id\n                                                         FROM concept_name\n                                                         WHERE name = \'Bahmni Diagnosis Status\' AND\n                                                               concept_name_type = \'FULLY_SPECIFIED\')\n                      LEFT OUTER JOIN concept_name diagnosisStatusConceptName ON diagnosisStatus.value_coded IS NOT NULL\n                                                                                 AND diagnosisStatus.value_coded =\n                                                                                     diagnosisStatusConceptName.concept_id\n                                                                                 AND\n                                                                                 diagnosisStatusConceptName.concept_name_type\n                                                                                 = \'FULLY_SPECIFIED\'\n                  ) diagnosis ON diagnosis.person_id = pv.person_id','Sql query to get list of wards','9c869947-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.activePatients','select distinct\n          concat(pn.given_name,\' \', ifnull(pn.family_name,\'\')) as name,\n          pi.identifier as identifier,\n          concat(\"\",p.uuid) as uuid,\n          concat(\"\",v.uuid) as activeVisitUuid,\n          IF(va.value_reference = \"Admitted\", \"true\", \"false\") as hasBeenAdmitted\n        from visit v\n        join person_name pn on v.patient_id = pn.person_id and pn.voided = 0\n        join patient_identifier pi on v.patient_id = pi.patient_id\n        join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n        join global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n        join person p on p.person_id = v.patient_id\n        join location l on l.uuid = ${visit_location_uuid} and v.location_id = l.location_id\n        left outer join visit_attribute va on va.visit_id = v.visit_id and va.attribute_type_id = (\n          select visit_attribute_type_id from visit_attribute_type where name=\"Admission Status\"\n        ) and va.voided = 0\n        where v.date_stopped is null AND v.voided = 0','Sql query to get list of active patients','9c8311f1-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.activePatientsByLocation','select distinct concat(pn.given_name,\" \", ifnull(pn.family_name,\'\')) as name,\n pi.identifier as identifier,\n concat(\"\",p.uuid) as uuid,\n concat(\"\",v.uuid) as activeVisitUuid,\n IF(va.value_reference = \"Admitted\", \"true\", \"false\") as hasBeenAdmitted\n from\n   visit v join person_name pn on v.patient_id = pn.person_id and pn.voided = 0 and v.voided=0\n   join patient_identifier pi on v.patient_id = pi.patient_id and pi.voided=0\n   join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n   join global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n   join person p on p.person_id = v.patient_id  and p.voided=0\n   join encounter en on en.visit_id = v.visit_id and en.voided=0\n   left outer join location loc on en.location_id = loc.location_id\n   join encounter_provider ep on ep.encounter_id = en.encounter_id  and ep.voided=0\n   join provider pr on ep.provider_id=pr.provider_id and pr.retired=0\n   join person per on pr.person_id=per.person_id and per.voided=0\n   left outer join visit_attribute va on va.visit_id = v.visit_id and va.attribute_type_id = (\n                select visit_attribute_type_id from visit_attribute_type where name=\"Admission Status\"\n            )\n where\n   v.date_stopped is null and\n   loc.uuid=${location_uuid}\n   order by en.encounter_datetime desc','SQL query to get list of active patients by location','9c83c1fe-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.activePatientsByProvider','\n  select distinct concat(pn.given_name,\" \", ifnull(pn.family_name,\'\')) as name,\n  pi.identifier as identifier,\n  concat(\"\",p.uuid) as uuid,\n  concat(\"\",v.uuid) as activeVisitUuid,\n  IF(va.value_reference = \"Admitted\", \"true\", \"false\") as hasBeenAdmitted\n  from\n    visit v join person_name pn on v.patient_id = pn.person_id and pn.voided = 0 and v.voided=0\n    join patient_identifier pi on v.patient_id = pi.patient_id and pi.voided=0\n    join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n    join global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n    join person p on p.person_id = v.patient_id  and p.voided=0\n    join encounter en on en.visit_id = v.visit_id and en.voided=0\n    join encounter_provider ep on ep.encounter_id = en.encounter_id  and ep.voided=0\n    join provider pr on ep.provider_id=pr.provider_id and pr.retired=0\n    join person per on pr.person_id=per.person_id and per.voided=0\n    join location l on l.uuid=${visit_location_uuid} and l.location_id = v.location_id\n    left outer join visit_attribute va on va.visit_id = v.visit_id and va.voided = 0 and va.attribute_type_id = (\n				select visit_attribute_type_id from visit_attribute_type where name=\"Admission Status\"\n			)\n  where\n    v.date_stopped is null and\n    pr.uuid=${provider_uuid}\n    order by en.encounter_datetime desc','Sql query to get list of active patients by provider uuid','9c83511d-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.additionalSearchHandler',' cn.name = \'${testName}\'','Sql query to get list of admitted patients','7e397785-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.admittedPatients','select distinct\n          concat(pn.given_name,\" \", ifnull(pn.family_name,\'\')) as name,\n          pi.identifier as identifier,\n          concat(\"\",p.uuid) as uuid,\n          concat(\"\",v.uuid) as activeVisitUuid,\n          IF(va.value_reference = \"Admitted\", \"true\", \"false\") as hasBeenAdmitted\n        from visit v\n        join person_name pn on v.patient_id = pn.person_id and pn.voided = 0\n        join patient_identifier pi on v.patient_id = pi.patient_id\n        join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n        join global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n        join person p on v.patient_id = p.person_id\n        join visit_attribute va on v.visit_id = va.visit_id and va.value_reference = \"Admitted\" and va.voided = 0\n        join visit_attribute_type vat on vat.visit_attribute_type_id = va.attribute_type_id and vat.name = \"Admission Status\"\n        join location l on l.uuid=${visit_location_uuid} and v.location_id = l.location_id\n        where v.date_stopped is null AND v.voided = 0','Sql query to get list of admitted patients','9c837873-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.highRiskPatients','SELECT DISTINCT\n  concat(pn.given_name, \" \", ifnull(pn.family_name,\'\'))           AS name,\n  pi.identifier                                        AS identifier,\n  concat(\"\", p.uuid)                                   AS uuid,\n  concat(\"\", v.uuid)                                   AS activeVisitUuid,\n  IF(va.value_reference = \"Admitted\", \"true\", \"false\") AS hasBeenAdmitted\nFROM person p\n  INNER JOIN person_name pn ON pn.person_id = p.person_id\n  INNER JOIN patient_identifier pi ON pn.person_id = pi.patient_id\n  INNER JOIN patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n  INNER JOIN global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n  INNER JOIN visit v ON v.patient_id = p.person_id AND v.date_stopped IS NULL AND v.voided = 0\n  INNER JOIN (SELECT\n                max(test_obs.obs_group_id) AS max_id,\n                test_obs.concept_id,\n                test_obs.person_id\n              FROM obs test_obs\n                INNER JOIN concept c ON c.concept_id = test_obs.concept_id AND test_obs.voided = 0\n                INNER JOIN concept_name cn\n                  ON c.concept_id = cn.concept_id AND cn.concept_name_type = \"FULLY_SPECIFIED\" AND\n                     cn.name IN (${testName})\n              GROUP BY test_obs.person_id, test_obs.concept_id) AS tests ON tests.person_id = v.patient_id\n  INNER JOIN obs abnormal_obs\n    ON abnormal_obs.obs_group_id = tests.max_id AND abnormal_obs.value_coded = 1 AND abnormal_obs.voided = 0\n  INNER JOIN concept abnormal_concept ON abnormal_concept.concept_id = abnormal_obs.concept_id\n  INNER JOIN concept_name abnormal_concept_name\n    ON abnormal_concept.concept_id = abnormal_concept_name.concept_id AND\n       abnormal_concept_name.concept_name_type = \"FULLY_SPECIFIED\" AND\n       abnormal_concept_name.name IN (\"LAB_ABNORMAL\")\n  LEFT OUTER JOIN visit_attribute va ON va.visit_id = v.visit_id AND va.attribute_type_id =\n                                                                     (SELECT visit_attribute_type_id\n                                                                      FROM visit_attribute_type\n                                                                      WHERE name = \"Admission Status\")','SQL QUERY TO get LIST of patients with high risk','9c83d676-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.patientsHasPendingOrders','select distinct\n          concat(pn.given_name, \" \", ifnull(pn.family_name,\'\')) as name,\n          pi.identifier as identifier,\n          concat(\"\",p.uuid) as uuid,\n          concat(\"\",v.uuid) as activeVisitUuid,\n          IF(va.value_reference = \"Admitted\", \"true\", \"false\") as hasBeenAdmitted\n        from visit v\n        join person_name pn on v.patient_id = pn.person_id and pn.voided = 0\n        join patient_identifier pi on v.patient_id = pi.patient_id\n        join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n        join global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n        join person p on p.person_id = v.patient_id\n        join orders on orders.patient_id = v.patient_id\n        join order_type on orders.order_type_id = order_type.order_type_id and order_type.name != \"Order\" and order_type.name != \"Drug Order\"\n        left outer join visit_attribute va on va.visit_id = v.visit_id and va.voided = 0 and va.attribute_type_id =\n          (select visit_attribute_type_id from visit_attribute_type where name=\"Admission Status\")\n        where v.date_stopped is null AND v.voided = 0 and order_id not in\n          (select obs.order_id\n            from obs\n          where person_id = pn.person_id and order_id = orders.order_id)','Sql query to get list of patients who has pending orders','9c83e325-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.patientsToAdmit','select distinct concat(pn.given_name,\' \', ifnull(pn.family_name,\'\')) as name,\n        pi.identifier as identifier,\n        concat(\"\",p.uuid) as uuid,\n        concat(\"\",v.uuid) as activeVisitUuid\n        from visit v\n        join person_name pn on v.patient_id = pn.person_id and pn.voided = 0 AND v.voided = 0\n        join patient_identifier pi on v.patient_id = pi.patient_id\n        join patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n        join global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n        join person p on v.patient_id = p.person_id\n        join encounter e on v.visit_id = e.visit_id\n        join obs o on e.encounter_id = o.encounter_id and o.voided = 0\n        join concept c on o.value_coded = c.concept_id\n        join concept_name cn on c.concept_id = cn.concept_id\n        join location l on l.uuid=${visit_location_uuid} and v.location_id = l.location_id\n        where v.date_stopped is null and cn.name = \'Admit Patient\' and v.visit_id not in (select visit_id\n        from encounter ie join encounter_type iet\n        on iet.encounter_type_id = ie.encounter_type\n        where iet.name = \'ADMISSION\')','Sql query to get list of patients to be admitted','9c836673-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.sqlSearch.patientsToDischarge','SELECT DISTINCT\n          concat(pn.given_name, \' \', ifnull(pn.family_name,\'\')) AS name,\n          pi.identifier AS identifier,\n          concat(\"\", p.uuid) AS uuid,\n          concat(\"\", v.uuid) AS activeVisitUuid,\n          IF(va.value_reference = \"Admitted\", \"true\", \"false\") as hasBeenAdmitted\n        FROM visit v\n        INNER JOIN person_name pn ON v.patient_id = pn.person_id and pn.voided is FALSE\n        INNER JOIN patient_identifier pi ON v.patient_id = pi.patient_id and pi.voided is FALSE\n        INNER JOIN patient_identifier_type pit on pi.identifier_type = pit.patient_identifier_type_id\n        INNER JOIN global_property gp on gp.property=\"bahmni.primaryIdentifierType\" and gp.property_value=pit.uuid\n        INNER JOIN person p ON v.patient_id = p.person_id\n        Inner Join (SELECT DISTINCT v.visit_id\n          FROM encounter en\n          INNER JOIN visit v ON v.visit_id = en.visit_id AND en.encounter_type =\n            (SELECT encounter_type_id\n              FROM encounter_type\n            WHERE name = \"ADMISSION\")) v1 on v1.visit_id = v.visit_id\n        INNER JOIN encounter e ON v.visit_id = e.visit_id\n        INNER JOIN obs o ON e.encounter_id = o.encounter_id\n        INNER JOIN concept_name cn ON o.value_coded = cn.concept_id AND cn.concept_name_type = \"FULLY_SPECIFIED\" AND cn.voided is FALSE\n        JOIN location l on l.uuid=${visit_location_uuid} and v.location_id = l.location_id\n        left outer join visit_attribute va on va.visit_id = v.visit_id and va.attribute_type_id =\n          (select visit_attribute_type_id from visit_attribute_type where name=\"Admission Status\")\n        LEFT OUTER JOIN encounter e1 ON e1.visit_id = v.visit_id AND e1.encounter_type = (\n          SELECT encounter_type_id\n            FROM encounter_type\n          WHERE name = \"DISCHARGE\") AND e1.voided is FALSE\n        WHERE v.date_stopped IS NULL AND v.voided = 0 AND o.voided = 0 AND cn.name = \"Discharge Patient\" AND e1.encounter_id IS NULL','Sql query to get list of patients to discharge','9c83abac-bd4f-11e7-8025-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.started','true','DO NOT MODIFY. true/false whether or not the emrapi module has been started.  This is used to make sure modules that were running  prior to a restart are started again','59f576f1-da20-4af3-941b-c943621436ca',NULL,NULL,NULL,NULL,NULL,NULL),('emrapi.suppressedDiagnosisConcepts',NULL,'UUIDs or mappings of suppressed diagnosis concepts','6e027931-83ff-4355-be9d-f0154108b890',NULL,NULL,NULL,NULL,NULL,NULL),('encounter.feed.publish.url','/openmrs/ws/rest/v1/bahmnicore/bahmniencounter/%s?includeAll=true','Url to be published on encounter save.','f94d5e37-e42d-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('encounterForm.obsSortOrder','number','The sort order for the obs listed on the encounter edit form.  \'number\' sorts on the associated numbering from the form schema.  \'weight\' sorts on the order displayed in the form schema.','b19607cb-af06-4af0-8427-0471a20efa43',NULL,NULL,NULL,NULL,NULL,NULL),('encounterModifier.groovy.allowCaching','true','Allow Groovy Caching','e16605a1-266a-47cb-8385-d07742646640',NULL,NULL,NULL,NULL,NULL,NULL),('EncounterType.encounterTypes.locked','false','saving, retiring or deleting an Encounter Type is not permitted, if true','98ed3536-c18b-46ba-9498-72a95057aa7b','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('episodes.mandatory','false','true/false whether or not the episodes module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','a83d258d-ec2d-4bd4-a9f0-a17708b2d9b1',NULL,NULL,NULL,NULL,NULL,NULL),('episodes.started','true','DO NOT MODIFY. true/false whether or not the episodes module has been started.  This is used to make sure modules that were running  prior to a restart are started again','a10c13e1-95ca-4855-8585-4fcd2e863aa4',NULL,NULL,NULL,NULL,NULL,NULL),('event.mandatory','false','true/false whether or not the event module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','d9a04eb3-5242-4c5a-91c7-2735c231371e',NULL,NULL,NULL,NULL,NULL,NULL),('event.started','true','DO NOT MODIFY. true/false whether or not the event module has been started.  This is used to make sure modules that were running  prior to a restart are started again','4844f593-058b-4258-a774-c0ccc1290638',NULL,NULL,NULL,NULL,NULL,NULL),('Form.forms.locked','false','Set to a value of true if you do not want any changes to be made on forms, else set to false.','dbc0744c-2e91-43ef-afa3-8dfff58c97de',NULL,NULL,NULL,NULL,NULL,NULL),('FormEntry.enableDashboardTab','true','true/false whether or not to show a Form Entry tab on the patient dashboard','d3a53504-3a21-4c2b-a57c-ef789f55eb1f','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('FormEntry.enableOnEncounterTab','false','true/false whether or not to show a Enter Form button on the encounters tab of the patient dashboard','774a2ccb-bd89-4725-aef5-d6ea7b4b9b3c','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('forms.locked','false','Set to a value of true if you do not want any changes to be made on forms, else set to false.','33bc4bd3-cd2c-47c4-b427-2dfb28091d57',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.absolute','rgb(20,20,20)','Color of the \'invalid\' section of numeric graphs on the patient dashboard.','d36170da-3d84-43dc-bf2f-9fc388d9799e',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.critical','rgb(200,0,0)','Color of the \'critical\' section of numeric graphs on the patient dashboard.','d5d849ab-5e22-478d-bcef-647002313bf7',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.normal','rgb(255,126,0)','Color of the \'normal\' section of numeric graphs on the patient dashboard.','a47ed185-71e5-4468-9b80-09fc84917d3f',NULL,NULL,NULL,NULL,NULL,NULL),('gzip.enabled','false','Set to \'true\' to turn on OpenMRS\'s gzip filter, and have the webapp compress data before sending it to any client that supports it. Generally use this if you are running Tomcat standalone. If you are running Tomcat behind Apache, then you\'d want to use Apache to do gzip compression.','5170b8cc-2c4e-41b3-aab2-33861f19139e','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('hl7_archive.dir','hl7_archives','The default name or absolute path for the folder where to write the hl7_in_archives.','037a9932-cc87-4e23-a3fb-2a7c23da0464',NULL,NULL,NULL,NULL,NULL,NULL),('hl7_processor.ignore_missing_patient_non_local','false','If true, hl7 messages for patients that are not found and are non-local will silently be dropped/ignored','e0f2a07e-6a39-4966-b1ef-adc87dc1d48d','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('htmlwidgets.mandatory','false','true/false whether or not the htmlwidgets module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','dc03918c-fb32-479e-b36a-4142c7ad212a',NULL,NULL,NULL,NULL,NULL,NULL),('htmlwidgets.started','true','DO NOT MODIFY. true/false whether or not the htmlwidgets module has been started.  This is used to make sure modules that were running  prior to a restart are started again','84efe5c9-b2a7-41fc-b859-ae4435fba357',NULL,NULL,NULL,NULL,NULL,NULL),('idgen-webservices.mandatory','false','true/false whether or not the idgen-webservices module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','7053d396-7a02-43bb-9f7c-5b6e0f416475',NULL,NULL,NULL,NULL,NULL,NULL),('idgen-webservices.started','true','DO NOT MODIFY. true/false whether or not the idgen-webservices module has been started.  This is used to make sure modules that were running  prior to a restart are started again','a15dac5d-9eb9-493b-8a5f-0c09e13a8bb9',NULL,NULL,NULL,NULL,NULL,NULL),('idgen.database_version','2.5.1','DO NOT MODIFY.  Current database version number for the idgen module.','421c9143-97f5-486f-be28-4f9bb6f6cef6',NULL,NULL,NULL,NULL,NULL,NULL),('idgen.mandatory','false','true/false whether or not the idgen module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','ae9e7608-8599-46ae-8a02-c70fc2427951',NULL,NULL,NULL,NULL,NULL,NULL),('idgen.started','true','DO NOT MODIFY. true/false whether or not the idgen module has been started.  This is used to make sure modules that were running  prior to a restart are started again','4b359ae6-4fab-4274-a67d-04e401e97878',NULL,NULL,NULL,NULL,NULL,NULL),('layout.address.format','<org.openmrs.layout.address.AddressTemplate>\n                        <nameMappings class=\"properties\">\n                          <property name=\"address1\" value=\"Location.address1\"/>\n                          <property name=\"address2\" value=\"Location.address2\"/>\n                          <property name=\"address3\" value=\"Location.address3\"/>\n                          <property name=\"address4\" value=\"Location.address4\"/>\n                          <property name=\"address5\" value=\"Location.address5\"/>\n                          <property name=\"address6\" value=\"Location.address6\"/>\n                          <property name=\"postalCode\" value=\"Location.postalCode\"/>\n                          <property name=\"longitude\" value=\"Location.longitude\"/>\n                          <property name=\"startDate\" value=\"PersonAddress.startDate\"/>\n                          <property name=\"country\" value=\"Location.country\"/>\n                          <property name=\"countyDistrict\" value=\"Location.district\"/>\n                          <property name=\"endDate\" value=\"personAddress.endDate\"/>\n                          <property name=\"stateProvince\" value=\"Location.stateProvince\"/>\n                          <property name=\"latitude\" value=\"Location.latitude\"/>\n                          <property name=\"cityVillage\" value=\"Location.cityVillage\"/>\n                        </nameMappings>\n                        <sizeMappings class=\"properties\">\n                          <property name=\"postalCode\" value=\"10\"/>\n                          <property name=\"longitude\" value=\"10\"/>\n                          <property name=\"address2\" value=\"40\"/>\n                          <property name=\"address1\" value=\"40\"/>\n                          <property name=\"startDate\" value=\"10\"/>\n                          <property name=\"country\" value=\"10\"/>\n                          <property name=\"endDate\" value=\"10\"/>\n                          <property name=\"stateProvince\" value=\"10\"/>\n                          <property name=\"latitude\" value=\"10\"/>\n                          <property name=\"cityVillage\" value=\"10\"/>\n                        </sizeMappings>\n                        <lineByLineFormat>\n                          <string>address1</string>\n                          <string>address2</string>\n                          <string>cityVillage stateProvince country postalCode</string>\n                          <string>latitude longitude</string>\n                          <string>startDate endDate</string>\n                        </lineByLineFormat>\n                      </org.openmrs.layout.address.AddressTemplate>','XML description of address formats','e442f5e2-6676-453d-a76b-4aa48f2ad0aa',NULL,NULL,NULL,NULL,NULL,NULL),('layout.name.format','short','Format in which to display the person names.  Valid values are short, long','2577cb25-f249-49be-9235-56e4f7186a86',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.mandatory','false','true/false whether or not the legacyui module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','280df63e-d0ff-4587-8261-1ada20594ad4',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.started','true','DO NOT MODIFY. true/false whether or not the legacyui module has been started.  This is used to make sure modules that were running  prior to a restart are started again','caed9074-fd62-4f8a-b9b2-ac42fcffdd8c',NULL,NULL,NULL,NULL,NULL,NULL),('locale.allowed.list','en, es, fr, it, pt_BR','Comma delimited list of locales allowed for use on system','75a95a6d-b495-482a-84b9-d1a0ba348513',NULL,NULL,NULL,NULL,NULL,NULL),('location.field.style','default','Type of widget to use for location fields','b09ba913-0c2b-4731-bb66-67e541661d08',NULL,NULL,NULL,NULL,NULL,NULL),('log.layout','%p - %C{1}.%M(%L) |%d{ISO8601}| %m%n','A log layout pattern which is used by the OpenMRS file appender.','b4dc6dd1-2a5b-4b7a-9d98-eb7b36811fe1',NULL,NULL,NULL,NULL,NULL,NULL),('log.level','org.openmrs.api:warn','Logging levels for log4j.xml. Valid format is class:level,class:level. If class not specified, \'org.openmrs.api\' presumed. Valid levels are trace, debug, info, warn, error or fatal','34475147-7cd9-40d1-80e4-cccef7285778',NULL,NULL,NULL,NULL,NULL,NULL),('log.location',NULL,'A directory where the OpenMRS log file appender is stored. The log file name is \'openmrs.log\'.','a05a8c41-75b5-4153-970c-1a9defe2f379',NULL,NULL,NULL,NULL,NULL,NULL),('mail.debug','false','true/false whether to print debugging information during mailing','d145beea-e046-46f8-8184-3607a6870d6a',NULL,NULL,NULL,NULL,NULL,NULL),('mail.default_content_type','text/plain','Content type to append to the mail messages','05fdea99-9fe4-4e3f-bece-c75a944d1e1c',NULL,NULL,NULL,NULL,NULL,NULL),('mail.from','info@openmrs.org','Email address to use as the default from address','1e5e878b-7ded-4c69-8d70-7490ce1f409c',NULL,NULL,NULL,NULL,NULL,NULL),('mail.password','test','Password for the SMTP user (if smtp_auth is enabled)','efd2e456-c590-4afb-96b4-a710fd13baeb',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp.starttls.enable','false','Set to true to enable TLS encryption, else set to false','38e737d9-a910-49c5-9889-c2e84d5482cb',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_auth','false','true/false whether the smtp host requires authentication','f99172e1-e9b2-4afc-95cc-d9a6ad19dda6',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_host','localhost','SMTP host name','c614e725-1953-4702-8c25-6406c1c6144e',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_port','25','SMTP port','b657dd27-69db-49e8-ade8-0c46a63db5cd',NULL,NULL,NULL,NULL,NULL,NULL),('mail.transport_protocol','smtp','Transport protocol for the messaging engine. Valid values: smtp','9395c4f4-479b-43a4-a7f9-84c5cf517dcb',NULL,NULL,NULL,NULL,NULL,NULL),('mail.user','test','Username of the SMTP user (if smtp_auth is enabled)','c27d023c-e55d-44a9-93be-e05c8fe3e9ad',NULL,NULL,NULL,NULL,NULL,NULL),('metadatamapping.addLocalMappings',NULL,'Specifies whether the concept mappings to the local dictionary should be created when exporting concepts','52c542c6-4e51-42b8-8d9a-23dce2ce36e8',NULL,NULL,NULL,NULL,NULL,NULL),('metadatamapping.mandatory','false','true/false whether or not the metadatamapping module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','77d5f774-42f1-4065-8b0d-dcb62da7ca2f',NULL,NULL,NULL,NULL,NULL,NULL),('metadatamapping.started','true','DO NOT MODIFY. true/false whether or not the metadatamapping module has been started.  This is used to make sure modules that were running  prior to a restart are started again','b5f3257a-3356-4111-8660-d58e44e7201f',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.database_version','1.0','DO NOT MODIFY.  Current database version number for the metadatasharing module.','211e2cca-5daf-4e8a-9087-e67305134aee',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.enableOnTheFlyPackages','false','Specifies whether metadata packages can be exported on the fly','136bf84a-2e0e-466c-a580-39a6c660b5ba',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.mandatory','false','true/false whether or not the metadatasharing module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','fdb824a2-b27e-4aa8-9496-f1ce8f9e8ccd',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.persistIdsForClasses',NULL,'A comma separated list of class package/names that denotes classes to try and persist ids for. Common options: org.openmrs.Concept,org.openmrs.Form,org.openmrs.ConceptDatatype,org.openmrs.ConceptClass,org.openmrs.EncounterType,org.openmrs.IdentifierType,org.openmrs.RelationshipType,org.openmrs.Location','824e9ea2-a7b8-45c1-a146-c87cd387f691',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.preferredConceptSourceIds',NULL,'Comma-separated list of concept source Ids for preferred sources, in case an incoming concept \nhas duplicate mappings to any of these sources, no confirmation will be required unless its \ndatatype or concept class differs from that of the existing concept','eddda93d-2fb7-4f8f-90d3-2d147ffe249a',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.started','true','DO NOT MODIFY. true/false whether or not the metadatasharing module has been started.  This is used to make sure modules that were running  prior to a restart are started again','3e9da890-4188-43c0-be5d-02c836a43e0b',NULL,NULL,NULL,NULL,NULL,NULL),('metadatasharing.webservicesKey',NULL,'Key to grant access to remote systems to consume module webservices RESTfully','996b2496-9289-47b7-b190-e29c657dd0bc',NULL,NULL,NULL,NULL,NULL,NULL),('minSearchCharacters','2','Number of characters user must input before searching is started.','c3e06062-30ce-40b3-a5f9-dade7ee22186',NULL,NULL,NULL,NULL,NULL,NULL),('module_repository_folder','modules','Name of the folder in which to store the modules','026fb0f7-4f4c-45ff-a3da-7d2f72e6daff',NULL,NULL,NULL,NULL,NULL,NULL),('mrs.genders','{\"M\":\"Male\", \"F\":\"Female\",\"O\":\"Other\"}','List of gender and gender codes used across MRS','7f87c393-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('newPatientForm.relationships',NULL,'Comma separated list of the RelationshipTypes to show on the new/short patient form.  The list is defined like \'3a, 4b, 7a\'.  The number is the RelationshipTypeId and the \'a\' vs \'b\' part is which side of the relationship is filled in by the user.','a3ae17a4-1b4a-48a5-89ad-f2881024c856',NULL,NULL,NULL,NULL,NULL,NULL),('new_patient_form.showRelationships','false','true/false whether or not to show the relationship editor on the addPatient.htm screen','3eed941e-c49c-4875-bb1a-f495d7dc5a60','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('obs.complex_obs_dir','complex_obs','Default directory for storing complex obs.','4955dfb6-2ebb-462c-b851-48ae92cc86c8',NULL,NULL,NULL,NULL,NULL,NULL),('openmrs-atomfeed.mandatory','false','true/false whether or not the openmrs-atomfeed module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','ab95bf24-fca8-4b75-8233-cd2e31f7c3d5',NULL,NULL,NULL,NULL,NULL,NULL),('openmrs-atomfeed.started','true','DO NOT MODIFY. true/false whether or not the openmrs-atomfeed module has been started.  This is used to make sure modules that were running  prior to a restart are started again','9306f0e3-1308-4790-884a-97b183134939',NULL,NULL,NULL,NULL,NULL,NULL),('order.dosingInstructionsConceptUuid','7eb425fa-e42f-11e5-8c3e-08002715d519','Global property pointing to duration units concept set','7eb665e1-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugDispensingUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug dispensing units','e955bb8b-aaa4-4f03-8053-49ab20bd7e10',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugDosingUnitsConceptUuid','7ea60429-e42f-11e5-8c3e-08002715d519','Specifies the uuid of the concept set where its members represent the possible drug dosing units','79a3eb93-a6df-4c69-86dd-270fe9c29a35',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugRoutesConceptUuid','7ea9af58-e42f-11e5-8c3e-08002715d519','Specifies the uuid of the concept set where its members represent the possible drug routes','e7dea05f-816e-4198-bcce-511a45d705fd',NULL,NULL,NULL,NULL,NULL,NULL),('order.durationUnitsConceptUuid','7eafb27b-e42f-11e5-8c3e-08002715d519','Specifies the uuid of the concept set where its members represent the possible duration units','a6584cde-4650-4d00-856a-17bcc0514a50',NULL,NULL,NULL,NULL,NULL,NULL),('order.nextOrderNumberSeed','1','The next order number available for assignment','e47a1076-5639-4a80-bcdf-d6dcc1afe599',NULL,NULL,NULL,NULL,NULL,NULL),('order.orderNumberGeneratorBeanId',NULL,'Specifies spring bean id of the order generator to use when assigning order numbers','ef45a842-fd1b-4e89-becc-de43d3d4ca67',NULL,NULL,NULL,NULL,NULL,NULL),('order.testSpecimenSourcesConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible test specimen sources','bc587dd3-80a3-42a2-a5b3-eaeb51783131',NULL,NULL,NULL,NULL,NULL,NULL),('patient.defaultPatientIdentifierValidator','org.openmrs.patient.impl.LuhnIdentifierValidator','This property sets the default patient identifier validator.  The default validator is only used in a handful of (mostly legacy) instances.  For example, it\'s used to generate the isValidCheckDigit calculated column and to append the string \"(default)\" to the name of the default validator on the editPatientIdentifierType form.','5676d361-a035-4bcd-b28a-8900b6b40399',NULL,NULL,NULL,NULL,NULL,NULL),('patient.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the patient dashboard','8e0a9f99-8a2a-4c10-8a05-984ac7fe119a',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierPrefix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','811ffecf-eb6d-4f06-b275-9f81c8ddc914',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierRegex',NULL,'WARNING: Using this search property can cause a drop in mysql performance with large patient sets.  A MySQL regular expression for the patient identifier search strings.  The @SEARCH@ string is replaced at runtime with the user\'s search string.  An empty regex will cause a simply \'like\' sql search to be used. Example: ^0*@SEARCH@([A-Z]+-[0-9])?$','257f140f-ce09-4fba-b8e2-e9bcff644b58',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierSearchPattern',NULL,'If this is empty, the regex or suffix/prefix search is used.  Comma separated list of identifiers to check.  Allows for faster searching of multiple options rather than the slow regex. e.g. @SEARCH@,0@SEARCH@,@SEARCH-1@-@CHECKDIGIT@,0@SEARCH-1@-@CHECKDIGIT@ would turn a request for \"4127\" into a search for \"in (\'4127\',\'04127\',\'412-7\',\'0412-7\')\"','31578d47-42d9-4e92-843c-eac2bdae384e',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierSuffix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','0f274fa8-4656-438c-9840-f7128b04983e',NULL,NULL,NULL,NULL,NULL,NULL),('patient.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients in _lists_','f932cb94-3662-4ab4-b498-6cc775ae71e7',NULL,NULL,NULL,NULL,NULL,NULL),('patient.nameValidationRegex','^[a-zA-Z \\-]+$','Names of the patients must pass this regex. Eg : ^[a-zA-Z \\-]+$ contains only english alphabet letters, spaces, and hyphens. A value of .* or the empty string means no validation is done.','a70868ea-4c8e-465e-9127-0bdbedbae3e3',NULL,NULL,NULL,NULL,NULL,NULL),('patient.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients when _viewing individually_','80f9220b-9bd3-4b9e-954d-d77c6871ee9b',NULL,NULL,NULL,NULL,NULL,NULL),('PatientIdentifierType.locked','false','Set to a value of true if you do not want allow editing patient identifier types, else set to false.','b2e452f9-aad3-4d4a-8f89-6066cc4762a8',NULL,NULL,NULL,NULL,NULL,NULL),('patientIdentifierTypes.locked','false','Set to a value of true if you do not want allow editing patient identifier types, else set to false.','7b8691ff-d295-4116-a945-dab9d7941cf2',NULL,NULL,NULL,NULL,NULL,NULL),('patientSearch.matchMode','START','Specifies how patient names are matched while searching patient. Valid values are \'ANYWHERE\' or \'START\'. Defaults to start if missing or invalid value is present.','bb0431b3-9e47-4767-be04-819d4a96ce9c',NULL,NULL,NULL,NULL,NULL,NULL),('patient_identifier.importantTypes',NULL,'A comma delimited list of PatientIdentifier names : PatientIdentifier locations that will be displayed on the patient dashboard.  E.g.: TRACnet ID:Rwanda,ELDID:Kenya','e9ccc824-c2a1-47a4-97a8-49545972b12d',NULL,NULL,NULL,NULL,NULL,NULL),('person.attributeSearchMatchMode','EXACT','Specifies how person attributes are matched while searching person. Valid values are \'ANYWHERE\' or \'EXACT\'. Defaults to exact if missing or invalid value is present.','1c091e06-3cf4-4908-b88b-91dde5f1529c',NULL,NULL,NULL,NULL,NULL,NULL),('person.searchMaxResults','1000','The maximum number of results returned by patient searches','2500f09a-2ebc-44ad-b37c-d27e9aebd7ac',NULL,NULL,NULL,NULL,NULL,NULL),('PersonAttributeType.locked','false','Set to a value of true if you do not want allow editing person attribute types, else set to false.','e5a5c0f0-3fbf-4c0f-9be7-331cc49ca2ab',NULL,NULL,NULL,NULL,NULL,NULL),('personAttributeTypes.locked','false','Set to a value of true if you do not want allow editing person attribute types, else set to false.','54fa7f0c-687c-403e-b1f2-a735ca426fdc',NULL,NULL,NULL,NULL,NULL,NULL),('provider.unknownProviderUuid','f9badd80-ab76-11e2-9e96-0800200c9a66','Specifies the uuid of the Unknown Provider account','a0d0a29f-8b82-4da5-b7d8-a8148d1abfce',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.addressWidget','personAddress','Address widget to use throughout the module','12f86d11-5877-4f40-8280-1594a72db59d',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.advancedSearchPersonAttributeType',NULL,'Person attribute type, specified by uuid, to use as a search field on the advanced search page','933b1581-dc24-4215-9b22-6de72b149c6f',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.database_version','1.0','DO NOT MODIFY.  Current database version number for the providermanagement module.','abe5d61f-1814-41ed-abf7-728d74368ee1',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.historicalPatientListDisplayFields','Identifier:patient.patientIdentifier.identifier|Given Name:patient.personName.givenName|Family Name:patient.personName.familyName|Age:patient.age|Gender:patient.gender|Start Date:relationship.startDate|End Date:relationship.endDate','Fields to display in the historical patient lists; specified as a pipe-delimited list of label/field pairs','d6995eb9-6a6e-4539-9850-d27f4f8a72ed',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.historicalProviderListDisplayFields','Identifier:provider.identifier|Given Name:provider.person.personName.givenName|Family Name:provider.person.personName.familyName|Role:provider.providerRole|Gender:provider.person.gender|Start Date:relationship.startDate|End Date:relationship.endDate','Fields to display in the historical provider lists; specified as a pipe-delimited list of label/field pairs','b2474196-69f4-4a15-b313-f3240be0ba72',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.mandatory','false','true/false whether or not the providermanagement module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','fcddff9f-6670-4fb8-b01c-91d402f9d50a',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.patientListDisplayFields','Identifier:patient.patientIdentifier.identifier|Given Name:patient.personName.givenName|Family Name:patient.personName.familyName|Age:patient.age|Gender:patient.gender|Start Date:relationship.startDate','Fields to display in the patient lists; specified as a pipe-delimited list of label/field pairs','57aac2eb-0241-4e0b-8e6b-3d5c2050c0f1',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.patientSearchDisplayFields','Identifier:patient.patientIdentifier.identifier|Given Name:patient.personName.givenName|Family Name:patient.personName.familyName|Age:patient.age|Gender:patient.gender','Fields to display in the patient search results; specified as a pipe-delimited list of label/field pairs','06ff0ae0-3b9d-471e-ab8c-e9f961b3907d',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.personAttributeTypes',NULL,'Person attributes to display on the provider dashboard; specified as a pipe-delimited list of person attribute type uuids','d978d613-eb4e-4e16-abf0-fc31963e63cc',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.personSearchDisplayFields','Given Name:person.personName.givenName|Family Name:person.personName.familyName|Age:person.age|Gender:person.gender','Fields to display in the person search results; specified as a pipe-delimited list of label/field pairs','dd6e0235-054e-475e-b777-1cd404e8c653',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.providerListDisplayFields','Identifier:provider.identifier|Given Name:provider.person.personName.givenName|Family Name:provider.person.personName.familyName|Role:provider.providerRole|Gender:provider.person.gender|Start Date:relationship.startDate','Fields to display in the provider lists; specified as a pipe-delimited list of label/field pairs','0c9fa477-9d19-4422-9596-033a47848137',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.providerSearchDisplayFields','Identifier:provider.identifier|Given Name:provider.person.personName.givenName|Family Name:provider.person.personName.familyName|Role:provider.providerRole|Gender:provider.person.gender','Fields to display in the provider search results; specified as a pipe-delimited list of label/field pairs','058f26a5-378e-4d3c-9bda-c0e9fe5d34bc',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.restrictSearchToProvidersWithProviderRoles','false','True/false whether to restrict providers to those with roles','7110b8c1-2248-4ca0-a74f-a202ab80621b',NULL,NULL,NULL,NULL,NULL,NULL),('providermanagement.started','true','DO NOT MODIFY. true/false whether or not the providermanagement module has been started.  This is used to make sure modules that were running  prior to a restart are started again','e1cd8839-6d8d-4e4c-bedb-33295c64709c',NULL,NULL,NULL,NULL,NULL,NULL),('providerSearch.matchMode','EXACT','Specifies how provider identifiers are matched while searching for providers. Valid values are START,EXACT, END or ANYWHERE','19903164-0e63-4c22-bfcb-232002910d23',NULL,NULL,NULL,NULL,NULL,NULL),('reference-data.mandatory','false','true/false whether or not the reference-data module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','99f2218e-7e9e-4f7f-a53f-02f7937c9f5e',NULL,NULL,NULL,NULL,NULL,NULL),('reference-data.started','true','DO NOT MODIFY. true/false whether or not the reference-data module has been started.  This is used to make sure modules that were running  prior to a restart are started again','990f8b88-2e00-4f30-80aa-4bc23ddac2e4',NULL,NULL,NULL,NULL,NULL,NULL),('report.deleteReportsAgeInHours','72','Reports that are not explicitly saved are deleted automatically when they are this many hours old. (Values less than or equal to zero means do not delete automatically)','065f5de4-61ee-4592-846b-5b459f748823',NULL,NULL,NULL,NULL,NULL,NULL),('report.xmlMacros',NULL,'Macros that will be applied to Report Schema XMLs when they are interpreted. This should be java.util.properties format.','ac0a052f-3027-4198-8d9a-696f6ce2045c',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.dataEvaluationBatchSize','-1','This determines whether to run evaluators for Data in batches and what the size of those batches should be.\nA value of less than or equal to 0 indicates that no batching is desired.','b041ab42-64a8-45e1-83e2-e5c3c36dcf18',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.defaultDateFormat','dd/MMM/yyyy','Default date format to use when formatting report data','b57401df-91c3-424e-8547-42d4ea22a06a',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.defaultLocale','en','Default locale to use when formatting report data','c3dcad29-9f4e-4565-bb2b-ff6641163737',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.evaluationLoggerEnabled','false','If false, will disable the built in use of the evaluation logger to log evaluation information for performance diagnostics','10e8a506-4ea0-44d0-84be-bd2b2e853d70',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.includeDataExportsAsDataSetDefinitions','false','If reportingcompatibility is installed, this indicates whether data exports should be exposed as Dataset Definitions','ae5ad6fd-34c1-49a1-aac8-d831040e2691',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.mandatory','false','true/false whether or not the reporting module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','0246e539-ecf2-40fd-b365-f77070ae264a',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.maxCachedReports','10','The maximum number of reports whose underlying data and output should be kept in the cache at any one time','d0e45c9c-dc93-43ee-ba50-affd38a188f1',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.maxReportsToRun','1','The maximum number of reports that should be processed at any one time','bddd7d4f-0b64-42a2-a309-8585a7ce2ba9',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.preferredIdentifierTypes',NULL,'Pipe-separated list of patient identifier type names, which should be displayed on default patient datasets','9015780c-4c67-49f8-a067-76e744e18f09',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.runReportCohortFilterMode','showIfNull','Supports the values hide,showIfNull,show which determine whether the cohort selector should be available in the run report page','bd35714a-1d9a-4462-a406-6034853e7b6a',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.started','true','DO NOT MODIFY. true/false whether or not the reporting module has been started.  This is used to make sure modules that were running  prior to a restart are started again','020f2a48-6c4c-4bff-8503-89f066fceff7',NULL,NULL,NULL,NULL,NULL,NULL),('reporting.testPatientsCohortDefinition',NULL,'Points to a cohort definition representing all test/fake patients that you want to exclude from all queries and reports. You may set this to the UUID of a saved cohort definition, or to \"library:keyInADefinitionLibrary\"','dd5f351d-7eb4-4608-b59d-862f32260227',NULL,NULL,NULL,NULL,NULL,NULL),('reportProblem.url','http://errors.openmrs.org/scrap','The openmrs url where to submit bug reports','ea7a5386-3d35-42fa-b8ee-47199d45fc65',NULL,NULL,NULL,NULL,NULL,NULL),('rulesengine.mandatory','false','true/false whether or not the rulesengine module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','36f22aa9-2113-43cb-9e33-db551516515b',NULL,NULL,NULL,NULL,NULL,NULL),('rulesengine.started','true','DO NOT MODIFY. true/false whether or not the rulesengine module has been started.  This is used to make sure modules that were running  prior to a restart are started again','b804c0cb-2320-418f-8cc8-1a451e356240',NULL,NULL,NULL,NULL,NULL,NULL),('scheduler.password','test','Password for the OpenMRS user that will perform the scheduler activities','a8ff25c4-dddc-4968-989a-a779af352cc1',NULL,NULL,NULL,NULL,NULL,NULL),('scheduler.username','admin','Username for the OpenMRS user that will perform the scheduler activities','224e0d5e-3324-4b36-9ee1-b6376b6317bf',NULL,NULL,NULL,NULL,NULL,NULL),('SchedulerMarksComplete','false','Scheduler marks checked in appointments as complete when it turned on','d8a103c4-9b2a-4d4b-b400-5338321feaf1',NULL,NULL,NULL,NULL,NULL,NULL),('SchedulerMarksMissed','false','Scheduler marks scheduled appointments as missed when it is turned on','28e69f3d-84e6-4afe-8199-9e014505f7cf',NULL,NULL,NULL,NULL,NULL,NULL),('search.caseSensitiveDatabaseStringComparison','true','Indicates whether database string comparison is case sensitive or not. Setting this to false for MySQL with a case insensitive collation improves search performance.','400e0a22-7131-4846-b6ed-91cab3aa9332',NULL,NULL,NULL,NULL,NULL,NULL),('search.indexVersion','7','Indicates the index version. If it is blank, the index needs to be rebuilt.','579f5c77-3aa1-4a01-877d-15464e2e32d8',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.batchSize','200','The maximum number of search results that are returned by an ajax call','380d02f0-57c9-4841-95ad-4fa3ff80fe8f',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.dateDisplayFormat',NULL,'Date display format to be used to display the date somewhere in the UI i.e the search widgets and autocompletes','2c41dd98-3e8b-43c6-8d01-4b78477673e9',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.maximumResults','2000','Specifies the maximum number of results to return from a single search in the search widgets','3708f6c6-5a0f-4f91-9250-85eee0b17820',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.runInSerialMode','false','Specifies whether the search widgets should make ajax requests in serial or parallel order, a value of true is appropriate for implementations running on a slow network connection and vice versa','554141e4-e127-4b83-a941-5246bbc21e0d','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('searchWidget.searchDelayInterval','300','Specifies time interval in milliseconds when searching, between keyboard keyup event and triggering the search off, should be higher if most users are slow when typing so as to minimise the load on the server','a9c42d09-2d2b-476d-bbdf-f43203510cae',NULL,NULL,NULL,NULL,NULL,NULL),('security.allowedFailedLoginsBeforeLockout','7','Maximum number of failed logins allowed after which username is locked out','dbd4c6f2-9081-4f67-bd63-d372256f16da',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordCannotMatchUsername','true','Configure whether passwords must not match user\'s username or system id','c1b63486-d91d-4c27-b13f-cb0e0619cd01','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordCustomRegex',NULL,'Configure a custom regular expression that a password must match','285342a8-848c-46f2-9b53-14aae612773d',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordMinimumLength','8','Configure the minimum length required of all passwords','f80fd4d5-72cb-42cb-a2d9-4ec112cea8b0',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresDigit','true','Configure whether passwords must contain at least one digit','ce270d03-d8e6-4ad2-b43d-03f4af381768','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresNonDigit','true','Configure whether passwords must contain at least one non-digit','723bad36-5201-44a0-9f5f-a1ec8689cebf','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresUpperAndLowerCase','true','Configure whether passwords must contain both upper and lower case characters','b9beaeb0-216d-4754-9150-c94c82acad69','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('serialization.xstream.mandatory','false','true/false whether or not the serialization.xstream module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','894ce005-28c2-4be6-b53e-43afe2b224ea',NULL,NULL,NULL,NULL,NULL,NULL),('serialization.xstream.started','true','DO NOT MODIFY. true/false whether or not the serialization.xstream module has been started.  This is used to make sure modules that were running  prior to a restart are started again','f8fab0ae-c886-4c06-b5f2-cc67963ae430',NULL,NULL,NULL,NULL,NULL,NULL),('uicommons.mandatory','false','true/false whether or not the uicommons module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','6df7d49a-f7d4-4bf0-b0f1-2b97445214c7',NULL,NULL,NULL,NULL,NULL,NULL),('uicommons.started','true','DO NOT MODIFY. true/false whether or not the uicommons module has been started.  This is used to make sure modules that were running  prior to a restart are started again','a3f273c0-d34c-480d-be33-dc42d87a175c',NULL,NULL,NULL,NULL,NULL,NULL),('uiframework.formatter.dateAndTimeFormat','dd.MMM.yyyy, HH:mm:ss','Format used by UiUtils.format for dates that have a time component','bb0f256a-1956-4929-868e-1a94c6d1bd60',NULL,NULL,NULL,NULL,NULL,NULL),('uiframework.formatter.dateFormat','dd.MMM.yyyy','Format used by UiUtils.format for dates that do not have a time component','4013a471-99e1-4881-8bd8-b9f859b2bdcc',NULL,NULL,NULL,NULL,NULL,NULL),('uiframework.mandatory','false','true/false whether or not the uiframework module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','7800dc70-ee9a-4d9b-bfd1-bc66cc814b30',NULL,NULL,NULL,NULL,NULL,NULL),('uiframework.started','true','DO NOT MODIFY. true/false whether or not the uiframework module has been started.  This is used to make sure modules that were running  prior to a restart are started again','8a909486-93df-4509-8d74-c4be1b030ef9',NULL,NULL,NULL,NULL,NULL,NULL),('uilibrary.mandatory','false','true/false whether or not the uilibrary module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','ce0a4dd1-4f1b-4cb0-8a80-8e339d1bf833',NULL,NULL,NULL,NULL,NULL,NULL),('uilibrary.started','true','DO NOT MODIFY. true/false whether or not the uilibrary module has been started.  This is used to make sure modules that were running  prior to a restart are started again','4caada48-b202-4f18-b4aa-77ba11dec966',NULL,NULL,NULL,NULL,NULL,NULL),('uploaded.files.directory','/home/bahmni/uploaded-files/mrs/','Directory where files uploaded to Bahmni are stored','7ebd4aee-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL,NULL,NULL,NULL),('user.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the user dashboard. (not used in v1.5)','48704659-ce2c-4d0f-ab09-331791d86d0b',NULL,NULL,NULL,NULL,NULL,NULL),('user.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users in _lists_','9d37fd38-da29-4a77-89d6-ffa619ab814b',NULL,NULL,NULL,NULL,NULL,NULL),('user.requireEmailAsUsername','false','Indicates whether a username must be a valid e-mail or not.','e743505f-c91e-41a8-a427-0108491436ad','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('user.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users when _viewing individually_','8639a7ac-862a-4ed4-8514-258c6521f4b0',NULL,NULL,NULL,NULL,NULL,NULL),('use_patient_attribute.healthCenter','false','Indicates whether or not the \'health center\' attribute is shown when viewing/searching for patients','5f216b95-b349-4d57-8aa4-c2bb4dab9686','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('use_patient_attribute.mothersName','false','Indicates whether or not mother\'s name is able to be added/viewed for a patient','fc3d6e59-c091-4cfe-a446-5787fb9bc5d0','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('validation.disable','false','Disables validation of OpenMRS Objects. Only takes affect on next restart. Warning: only do this is you know what you are doing!','134cd0e8-5bfa-4cda-9f54-0e788a62938d',NULL,NULL,NULL,NULL,NULL,NULL),('visits.allowOverlappingVisits','true','true/false whether or not to allow visits of a given patient to overlap','e4897348-f74a-46d0-92c2-4267f521d85e','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('visits.assignmentHandler','org.openmrs.module.emrapi.adt.EmrApiVisitAssignmentHandler','Set to the name of the class responsible for assigning encounters to visits.','42cf082e-e629-4506-8b73-ca3c50b01b65',NULL,NULL,NULL,NULL,NULL,NULL),('visits.autoCloseVisitType',NULL,'comma-separated list of the visit type(s) to automatically close','499be503-91ee-482e-bb1e-2d96d5ce0718',NULL,NULL,NULL,NULL,NULL,NULL),('visits.enabled','true','Set to true to enable the Visits feature. This will replace the \'Encounters\' tab with a \'Visits\' tab on the dashboard.','2192e8af-0937-4b62-9c81-5277cc79d7d9','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('visits.encounterTypeToVisitTypeMapping',NULL,'Specifies how encounter types are mapped to visit types when automatically assigning encounters to visits. e.g 1:1, 2:1, 3:2 in the format encounterTypeId:visitTypeId or encounterTypeUuid:visitTypeUuid or a combination of encounter/visit type uuids and ids e.g 1:759799ab-c9a5-435e-b671-77773ada74e4','e2f50681-1f51-44a5-a2d6-e05088baeebd',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.allowedips',NULL,'A comma-separate list of IP addresses that are allowed to access the web services. An empty string allows everyone to access all ws. \n        IPs can be declared with bit masks e.g. 10.0.0.0/30 matches 10.0.0.0 - 10.0.0.3 and 10.0.0.0/24 matches 10.0.0.0 - 10.0.0.255.','7b49c32c-6e2a-49f4-959e-a4eaaf480128',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.mandatory','false','true/false whether or not the webservices.rest module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','0014a56e-4c74-4c4e-8bd7-0670c506ec0f',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.maxResultsAbsolute','1000','The absolute max results limit. If the client requests a larger number of results, then will get an error','76b28d84-aa4a-4495-aed8-3ad131cc1b06',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.maxResultsDefault','50','The default max results limit if the user does not provide a maximum when making the web service call.','6c5a0c3e-7c92-4cbb-be2d-97d89091c82f',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.quietDocs','true','If the value of this setting is \"true\", then nothing is logged while the Swagger specification is being generated.','e80164cb-d60e-45ac-8eda-d650d6c363af',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.started','true','DO NOT MODIFY. true/false whether or not the webservices.rest module has been started.  This is used to make sure modules that were running  prior to a restart are started again','aba6f70f-1cb1-4e7e-83d7-46f985057c75',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.uriPrefix',NULL,'The URI prefix through which clients consuming web services will connect to the web application, should be of the form http://{ipAddress}:{port}/{contextPath}','6a34af04-7689-497e-9ba6-8e6efa1bc56f',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` varchar(255) DEFAULT NULL,
  `hl7_data` text NOT NULL,
  `date_created` datetime NOT NULL,
  `message_state` int(11) DEFAULT '2',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `hl7_in_archive_uuid_index` (`uuid`),
  KEY `hl7_in_archive_message_state_idx` (`message_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_archive`
--

LOCK TABLES `hl7_in_archive` WRITE;
/*!40000 ALTER TABLE `hl7_in_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text NOT NULL,
  `error` varchar(255) NOT NULL DEFAULT '',
  `error_details` mediumtext,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `hl7_in_error_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_error`
--

LOCK TABLES `hl7_in_error` WRITE;
/*!40000 ALTER TABLE `hl7_in_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT '0',
  `hl7_source_key` text,
  `hl7_data` text NOT NULL,
  `message_state` int(11) NOT NULL DEFAULT '0',
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `hl7_in_queue_uuid_index` (`uuid`),
  KEY `hl7_source_with_queue` (`hl7_source`),
  CONSTRAINT `hl7_source_with_queue` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_queue`
--

LOCK TABLES `hl7_in_queue` WRITE;
/*!40000 ALTER TABLE `hl7_in_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `hl7_source_uuid_index` (`uuid`),
  KEY `user_who_created_hl7_source` (`creator`),
  CONSTRAINT `user_who_created_hl7_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_source`
--

LOCK TABLES `hl7_source` WRITE;
/*!40000 ALTER TABLE `hl7_source` DISABLE KEYS */;
INSERT INTO `hl7_source` VALUES (1,'LOCAL','',1,'2006-09-01 00:00:00','8d6b8bb6-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `hl7_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_auto_generation_option`
--

DROP TABLE IF EXISTS `idgen_auto_generation_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_auto_generation_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier_type` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `manual_entry_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `automatic_generation_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `location` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source for idgen_auto_generation_option` (`source`),
  KEY `location_for_auto_generation_option` (`location`),
  KEY `identifier_type for idgen_auto_generation_option` (`identifier_type`),
  CONSTRAINT `identifier_type for idgen_auto_generation_option` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `location_for_auto_generation_option` FOREIGN KEY (`location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `source for idgen_auto_generation_option` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_auto_generation_option`
--

LOCK TABLES `idgen_auto_generation_option` WRITE;
/*!40000 ALTER TABLE `idgen_auto_generation_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_auto_generation_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_id_pool`
--

DROP TABLE IF EXISTS `idgen_id_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_id_pool` (
  `id` int(11) NOT NULL,
  `source` int(11) DEFAULT NULL,
  `batch_size` int(11) DEFAULT NULL,
  `min_pool_size` int(11) DEFAULT NULL,
  `sequential` tinyint(1) NOT NULL DEFAULT '0',
  `refill_with_scheduled_task` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `source for idgen_id_pool` (`source`),
  CONSTRAINT `id for idgen_id_pool` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`),
  CONSTRAINT `source for idgen_id_pool` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_id_pool`
--

LOCK TABLES `idgen_id_pool` WRITE;
/*!40000 ALTER TABLE `idgen_id_pool` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_id_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_identifier_source`
--

DROP TABLE IF EXISTS `idgen_identifier_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_identifier_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_identifier_source` (`id`),
  KEY `identifier_type for idgen_identifier_source` (`identifier_type`),
  KEY `creator for idgen_identifier_source` (`creator`),
  KEY `changed_by for idgen_identifier_source` (`changed_by`),
  KEY `retired_by for idgen_identifier_source` (`retired_by`),
  CONSTRAINT `changed_by for idgen_identifier_source` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator for idgen_identifier_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_type for idgen_identifier_source` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `retired_by for idgen_identifier_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_identifier_source`
--

LOCK TABLES `idgen_identifier_source` WRITE;
/*!40000 ALTER TABLE `idgen_identifier_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_identifier_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_log_entry`
--

DROP TABLE IF EXISTS `idgen_log_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_log_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `date_generated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `generated_by` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_log` (`id`),
  KEY `source for idgen_log` (`source`),
  KEY `generated_by for idgen_log` (`generated_by`),
  CONSTRAINT `generated_by for idgen_log` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `source for idgen_log` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_log_entry`
--

LOCK TABLES `idgen_log_entry` WRITE;
/*!40000 ALTER TABLE `idgen_log_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_log_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_pooled_identifier`
--

DROP TABLE IF EXISTS `idgen_pooled_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_pooled_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `pool_id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `date_used` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pool_id for idgen_pooled_identifier` (`pool_id`),
  CONSTRAINT `pool_id for idgen_pooled_identifier` FOREIGN KEY (`pool_id`) REFERENCES `idgen_id_pool` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_pooled_identifier`
--

LOCK TABLES `idgen_pooled_identifier` WRITE;
/*!40000 ALTER TABLE `idgen_pooled_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_pooled_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_remote_source`
--

DROP TABLE IF EXISTS `idgen_remote_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_remote_source` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `user` varchar(50) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id for idgen_remote_source` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_remote_source`
--

LOCK TABLES `idgen_remote_source` WRITE;
/*!40000 ALTER TABLE `idgen_remote_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_remote_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_reserved_identifier`
--

DROP TABLE IF EXISTS `idgen_reserved_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_reserved_identifier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id for idgen_reserved_identifier` (`id`),
  KEY `source for idgen_reserved_identifier` (`source`),
  CONSTRAINT `source for idgen_reserved_identifier` FOREIGN KEY (`source`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_reserved_identifier`
--

LOCK TABLES `idgen_reserved_identifier` WRITE;
/*!40000 ALTER TABLE `idgen_reserved_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_reserved_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `idgen_seq_id_gen`
--

DROP TABLE IF EXISTS `idgen_seq_id_gen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `idgen_seq_id_gen` (
  `id` int(11) NOT NULL,
  `next_sequence_value` int(11) NOT NULL DEFAULT '-1',
  `base_character_set` varchar(255) NOT NULL,
  `first_identifier_base` varchar(50) NOT NULL,
  `prefix` varchar(20) DEFAULT NULL,
  `suffix` varchar(20) DEFAULT NULL,
  `min_length` int(11) DEFAULT NULL,
  `max_length` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id for idgen_seq_id_gen` FOREIGN KEY (`id`) REFERENCES `idgen_identifier_source` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `idgen_seq_id_gen`
--

LOCK TABLES `idgen_seq_id_gen` WRITE;
/*!40000 ALTER TABLE `idgen_seq_id_gen` DISABLE KEYS */;
/*!40000 ALTER TABLE `idgen_seq_id_gen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_status`
--

DROP TABLE IF EXISTS `import_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `original_file_name` varchar(500) NOT NULL,
  `saved_file_name` varchar(500) NOT NULL,
  `error_file_name` varchar(500) DEFAULT NULL,
  `type` varchar(25) NOT NULL,
  `status` varchar(25) NOT NULL,
  `successful_records` decimal(6,0) DEFAULT NULL,
  `failed_records` decimal(6,0) DEFAULT NULL,
  `stage_name` varchar(30) DEFAULT NULL,
  `stack_trace` text,
  `uploaded_by` varchar(20) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_status`
--

LOCK TABLES `import_status` WRITE;
/*!40000 ALTER TABLE `import_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(63) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangelog`
--

LOCK TABLES `liquibasechangelog` WRITE;
/*!40000 ALTER TABLE `liquibasechangelog` DISABLE KEYS */;
INSERT INTO `liquibasechangelog` VALUES ('0','bwolfe','liquibase-update-to-latest.xml','2011-09-20 00:00:00',10016,'MARK_RAN','3:ccc4741ff492cb385f44e714053920af',NULL,NULL,NULL,NULL),('02232009-1141','nribeka','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10061,'EXECUTED','3:b5921fb42deb90fe52e042838d0638a0','Modify Column','Modify the password column to fit the output of SHA-512 function',NULL,'2.0.5'),('08102013_1','arathy','liquibase.xml','2016-03-07 11:59:42',10635,'EXECUTED','3:f408b259edf18c9ef5c76d8783cc9c0e','Create Table','Create bed table',NULL,'2.0.5'),('08102013_2','arathy','liquibase.xml','2016-03-07 11:59:42',10636,'EXECUTED','3:7e57afdf5ad9fd77cbe6701c5d5d3f0e','Create Table','Create bed_patient_assignment_map table',NULL,'2.0.5'),('08102013_3','arathy','liquibase.xml','2016-03-07 11:59:43',10637,'EXECUTED','3:01e806e25044b76540eebbf69cc794bc','Add Foreign Key Constraint','Added foreign key reference on bed_id in bed_patient_assignment_map table',NULL,'2.0.5'),('08102013_4','arathy','liquibase.xml','2016-03-07 11:59:43',10638,'EXECUTED','3:6971a96f0aa2566a2f65016ad1d8b4bb','Add Foreign Key Constraint','Added foreign key reference on patient_id in bed_patient_assignment_map table',NULL,'2.0.5'),('08102013_5','arathy','liquibase.xml','2016-03-07 11:59:44',10639,'EXECUTED','3:f646b539893f3579c97d3f0d51ecd716','Create Table','Create bed_location_map table',NULL,'2.0.5'),('08102013_6','arathy','liquibase.xml','2016-03-07 11:59:44',10640,'EXECUTED','3:26de39ba0e58e5790a27a73b350057c9','Add Foreign Key Constraint','Added foreign key reference on location_id in bed_location_map table',NULL,'2.0.5'),('08102013_7','arathy','liquibase.xml','2016-03-07 11:59:44',10641,'EXECUTED','3:759d512aea5b655dbc87c0663cb7e306','Add Column','',NULL,'2.0.5'),('08102013_8','arathy','liquibase.xml','2016-03-07 11:59:44',10642,'EXECUTED','3:94a3788122cc19dedd1b3d9eb11f78b5','Add Default Value','',NULL,'2.0.5'),('1','upul','liquibase-update-to-latest.xml','2016-03-07 11:44:11',10042,'MARK_RAN','3:7fbc03c45bb69cd497b096629d32c3f5','Add Column','Add the column to person_attribute type to connect each type to a privilege',NULL,'2.0.5'),('1-grant-new-dashboard-overview-tab-app-privileges','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10483,'EXECUTED','3:6af3c30685c99d96ad1cd577719b1600','Custom SQL','Granting the new patient overview tab application privileges',NULL,'2.0.5'),('1-increase-privilege-col-size-privilege','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10485,'EXECUTED','3:6ecff8787eca17532e310087cfd65a06','Drop Foreign Key Constraint (x2), Modify Column, Add Foreign Key Constraint (x2)','Increasing the size of the privilege column in the privilege table',NULL,'2.0.5'),('10-insert-new-app-privileges','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10481,'EXECUTED','3:6ca60c3d5202a79f2e43367215cb447b','Custom SQL','Inserting the new application privileges',NULL,'2.0.5'),('100','ict4h','sql/db_migrations.xml','2016-03-07 12:20:51',11031,'EXECUTED','3:8ee36a0313cda559247cbb2729fe6e76','Create Table (x2)','',NULL,'2.0.5'),('101','ict4h','sql/db_migrations.xml','2016-03-07 12:20:51',11032,'EXECUTED','3:29f59eb61eb39a9dee52d81f4026d642','Add Column','',NULL,'2.0.5'),('102','Sudhakar, Abishek','sql/db_migrations.xml','2016-03-07 12:20:51',11033,'EXECUTED','3:b5cc640e5bdcf23514b3fc1a6c73d25f','Add Column, Create Table','',NULL,'2.0.5'),('102-1','Jaswanth','sql/db_migrations.xml','2017-04-04 15:53:41',11160,'MARK_RAN','3:9611355e45aad29bb4c7fe78503a073b','Add Column','',NULL,'2.0.5'),('102-2','Jaswanth','sql/db_migrations.xml','2017-04-04 15:53:41',11161,'MARK_RAN','3:080998dd9f7f79d54b17e847ab66178c','Create Table','',NULL,'2.0.5'),('103','angshu, dubey','sql/db_migrations.xml','2017-04-04 15:53:41',11162,'EXECUTED','3:c54ec0eee3b5e3203d25731c64d9025f','Add Column','Creating column tags for failed_events table. This is same as atom spec feed.entry.categories.',NULL,'2.0.5'),('11-insert-new-api-privileges','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10482,'EXECUTED','3:fe15eb2a97dd397b15fb5c4174fabe05','Custom SQL','Inserting the new API privileges',NULL,'2.0.5'),('1226348923233-12','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10022,'EXECUTED','3:7efb7ed5267126e1e44c9f344e35dd7d','Insert Row (x12)','',NULL,'2.0.5'),('1226348923233-13','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10023,'EXECUTED','3:8b9e14aa00a4382aa2623b39400c9110','Insert Row (x2)','',NULL,'2.0.5'),('1226348923233-14','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10027,'EXECUTED','3:8910082a3b369438f86025e4006b7538','Insert Row (x4)','',NULL,'2.0.5'),('1226348923233-15','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10028,'EXECUTED','3:8485e0ebef4dc368ab6b87de939f8e82','Insert Row (x15)','',NULL,'2.0.5'),('1226348923233-16','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10019,'EXECUTED','3:5778f109b607f882cc274750590d5004','Insert Row','',NULL,'2.0.5'),('1226348923233-17','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10030,'EXECUTED','3:3c324233bf1f386dcc4a9be55401c260','Insert Row (x2)','',NULL,'2.0.5'),('1226348923233-18','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10031,'EXECUTED','3:40ad1a506929811955f4d7d4753d576e','Insert Row (x2)','',NULL,'2.0.5'),('1226348923233-2','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10020,'EXECUTED','3:35613fc962f41ed143c46e578fd64a70','Insert Row (x5)','',NULL,'2.0.5'),('1226348923233-20','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10032,'EXECUTED','3:0ce5c5b83b4754b44f4bcda8eb866f3a','Insert Row','',NULL,'2.0.5'),('1226348923233-21','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10033,'EXECUTED','3:51c90534135f429c1bcde82be0f6157d','Insert Row','',NULL,'2.0.5'),('1226348923233-22','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10018,'EXECUTED','3:2d4897a84ce4408d8fcec69767a5c563','Insert Row','',NULL,'2.0.5'),('1226348923233-23','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10034,'EXECUTED','3:19f78a07a33a5efc28b4712a07b02a29','Insert Row','',NULL,'2.0.5'),('1226348923233-6','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10026,'EXECUTED','3:a947f43a1881ac56186039709a4a0ac8','Insert Row (x13)','',NULL,'2.0.5'),('1226348923233-8','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10021,'EXECUTED','3:dceb0cc19be3545af8639db55785d66e','Insert Row (x7)','',NULL,'2.0.5'),('1226412230538-24','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10024,'EXECUTED','3:0b77e92c0d1482c1bef7ca1add6b233b','Insert Row (x2)','',NULL,'2.0.5'),('1226412230538-7','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:08',10025,'EXECUTED','3:c189f41d824649ef72dc3cef74d3580b','Insert Row (x106)','',NULL,'2.0.5'),('1226412230538-9a','ben (generated)','liquibase-core-data.xml','2016-03-07 11:44:09',10035,'EXECUTED','3:73c2b426be208fb50f088ad4ee76c8d6','Insert Row (x4)','',NULL,'2.0.5'),('1227123456789-100','dkayiwa','liquibase-schema-only.xml','2016-03-07 11:44:00',178,'EXECUTED','3:24751e1218f5fff3d2abf8e281e557c5','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-1','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',1,'EXECUTED','3:a851046bb3eb5b0daccb6e69ef8a9a00','Create Table','',NULL,'2.0.5'),('1227303685425-10','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',8,'EXECUTED','3:3fb7e78555ddf8d8014ba336bb8b5402','Create Table','',NULL,'2.0.5'),('1227303685425-100','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',114,'EXECUTED','3:8d20fc37ce4266cba349eeef66951688','Create Index','',NULL,'2.0.5'),('1227303685425-101','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',115,'EXECUTED','3:cc9b2ad0c2ff9ad6fcfd2f56b52d795f','Create Index','',NULL,'2.0.5'),('1227303685425-102','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',116,'EXECUTED','3:97d1301e8ab7f35e109c733fdedde10f','Create Index','',NULL,'2.0.5'),('1227303685425-103','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',117,'EXECUTED','3:2447e4abc7501a18f401594e4c836fff','Create Index','',NULL,'2.0.5'),('1227303685425-104','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',118,'EXECUTED','3:8d6c644eaf9f696e3fee1362863c26ec','Create Index','',NULL,'2.0.5'),('1227303685425-105','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',119,'EXECUTED','3:fb3838f818387718d9b4cbf410d653cd','Create Index','',NULL,'2.0.5'),('1227303685425-106','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',120,'EXECUTED','3:a644de1082a85ab7a0fc520bb8fc23d7','Create Index','',NULL,'2.0.5'),('1227303685425-107','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',121,'EXECUTED','3:f11eb4e4bc4a5192b7e52622965aacb2','Create Index','',NULL,'2.0.5'),('1227303685425-108','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',135,'EXECUTED','3:07fc6fd2c0086f941aed0b2c95c89dc8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-109','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',136,'EXECUTED','3:c2911be31587bbc868a55f13fcc3ba5e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-11','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',9,'EXECUTED','3:1cef06ece4f56bfbe205ec03b75a129f','Create Table','',NULL,'2.0.5'),('1227303685425-110','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',137,'EXECUTED','3:32c42fa39fe81932aa02974bb19567ed','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-111','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',138,'EXECUTED','3:f35c8159ca7f84ae551bdb988b833760','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-112','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',139,'EXECUTED','3:df0a45bc276e7484f183e3190cff8394','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-115','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',140,'EXECUTED','3:d3b13502ef9794718d68bd0697fd7c2b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-116','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',141,'EXECUTED','3:6014d91cadbbfc05bd364619d94a4f18','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-117','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',142,'EXECUTED','3:0841471be0ebff9aba768017b9a9717b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-118','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',143,'EXECUTED','3:c73351f905761c3cee7235b526eff1a0','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-119','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',144,'EXECUTED','3:cd72c79bfd3c807ba5451d8ca5cb2612','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-12','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',10,'EXECUTED','3:b9726f1c78d0cba40d5ee61e721350f7','Create Table','',NULL,'2.0.5'),('1227303685425-120','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',145,'EXECUTED','3:b07d718d9d2b64060584d4c460ffc277','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-121','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',146,'EXECUTED','3:be141d71df248fba87a322b35f13b4db','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-122','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',147,'EXECUTED','3:7bcc45dda3aeea4ab3916701483443d3','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-123','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',148,'EXECUTED','3:031e4dcf20174b92bbbb07323b86d569','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-124','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',149,'EXECUTED','3:7d277181a4e9d5e14f9cb1220c6c4c57','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-125','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',150,'EXECUTED','3:7172ef61a904cd7ae765f0205d9e66dd','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-126','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',151,'EXECUTED','3:0d9a3ffc816c3e4e8649df3de01a8ff6','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-128','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',152,'EXECUTED','3:3a9357d6283b2bb97c1423825d6d57eb','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-129','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',153,'EXECUTED','3:e3923913d6f34e0e8bc7333834884419','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-13','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',11,'EXECUTED','3:982544aff0ae869f5ac9691d5c93a7e4','Create Table','',NULL,'2.0.5'),('1227303685425-130','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',154,'EXECUTED','3:dae7a98f3643acfe9db5c3b4b9e8f4ea','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-131','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',155,'EXECUTED','3:44a4e4791a0f727fffc96b9dab0a3fa8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-132','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',156,'EXECUTED','3:16dcc5a95708dbdaff07ed27507d8e29','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-134','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',157,'EXECUTED','3:c37757ed38ace0bb94d8455a49e3049a','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-135','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',158,'EXECUTED','3:ab40ab94ab2f86a0013ecbf9dd034de4','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-136','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',159,'EXECUTED','3:3878ab735b369d778a7feb2b92746352','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-137','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',160,'EXECUTED','3:a7bf99f775c2f07b534a4df4e5c5c20b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-139','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',161,'EXECUTED','3:f0a1690648292d939876bdeefa74792a','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-14','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',12,'EXECUTED','3:8122a19068fb1fd7b2c4d54e398ba507','Create Table','',NULL,'2.0.5'),('1227303685425-140','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',162,'EXECUTED','3:7ba4860a1e0a00ff49a93d4e86929691','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-141','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',163,'EXECUTED','3:5b176976d808cf8b1b8fae7d2b19e059','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-142','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',164,'EXECUTED','3:5538db250e63d70a79dce2c5a74ee528','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-143','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',165,'EXECUTED','3:a981ac9be845bf6c6098aa98cd4d8456','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-144','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',166,'EXECUTED','3:84428d9dce773758f73616129935d888','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-145','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',167,'EXECUTED','3:6b8af6c242f1d598591478897feed2d8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-146','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',168,'EXECUTED','3:a8cddf3b63050686248e82a3b6de781f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-147','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',169,'EXECUTED','3:e8b5350ad40fa006c088f08fae4d3141','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-149','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',170,'EXECUTED','3:b6c44ee5824ae261a9a87b8ac60fe23d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-15','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',13,'EXECUTED','3:18dd3e507ecbe5212bcdf0a0a8012d88','Create Table','',NULL,'2.0.5'),('1227303685425-150','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',171,'EXECUTED','3:f8c495d78d68c9fc701271a8e5d1f102','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-151','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',172,'EXECUTED','3:94dc5b8d27f275fb06cc230eb313e430','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-153','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',173,'EXECUTED','3:2a04930665fe64516765263d1a9b0775','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-154','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',174,'EXECUTED','3:adfef8b8dd7b774b268b0968b7400f42','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-155','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',175,'EXECUTED','3:540b0422c733b464a33ca937348d8b4c','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-158','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',176,'EXECUTED','3:d1d73e19bab5821f256c01a83e2d945f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-159','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:00',177,'EXECUTED','3:c23d0cd0eec5f20385b4182af18fc835','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-16','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',14,'EXECUTED','3:4c19b5c980b58e54af005e1fa50359ae','Create Table','',NULL,'2.0.5'),('1227303685425-160','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',179,'EXECUTED','3:cc64f6e676cb6a448f73599d8149490c','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-161','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',180,'EXECUTED','3:f48e300a3439d90fa2d518b3d6e145a5','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-162','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',181,'EXECUTED','3:467e31995c41be55426a5256d99312c4','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-163','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',182,'EXECUTED','3:45a4519c252f7e42d649292b022ec158','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-164','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',183,'EXECUTED','3:dfd51e701b716c07841c2e4ea6f59f3e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-165','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',184,'EXECUTED','3:0d69b82ce833ea585e95a6887f800108','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-166','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',185,'EXECUTED','3:2070f44c444e1e6efdbe7dfb9f7b846d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-167','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',186,'EXECUTED','3:9196c0f9792007c72233649cc7c2ac58','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-168','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',187,'EXECUTED','3:33d644a49e92a4bbd4cb653d6554c8d0','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-169','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',188,'EXECUTED','3:e75c37cbd9aa22cf95b2dc89fdb2c831','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-17','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',15,'EXECUTED','3:250e3f0d4bb139fa751d0875fd1d5b89','Create Table','',NULL,'2.0.5'),('1227303685425-170','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',189,'EXECUTED','3:ac31515d8822caa0c87705cb0706e52f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-171','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',190,'EXECUTED','3:b40823e1322acea52497f43033e72e5e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-173','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',191,'EXECUTED','3:b37c0b43a23ad3b072e34055875f7dcc','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-174','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',192,'EXECUTED','3:f8c5737a51f0f040e9fac3060c246e46','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-175','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',193,'EXECUTED','3:87cc15f9622b014d01d4df512a3f835e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-176','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',194,'EXECUTED','3:f57273dfbaba02ea785a0e165994f74b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-177','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',195,'EXECUTED','3:1555790e99827ded259d5ec7860eb1b1','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-178','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',196,'EXECUTED','3:757206752885a07d1eea5585ad9e2dce','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-179','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',197,'EXECUTED','3:018efd7d7a5e84f7c2c9cec7299d596e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-18','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',16,'EXECUTED','3:2eb2063d3e1233e7ebc23f313da5bff6','Create Table','',NULL,'2.0.5'),('1227303685425-180','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',198,'EXECUTED','3:9ba52b3b7059674e881b7611a3428bde','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-181','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',199,'EXECUTED','3:ffee79a7426d7e41cf65889c2a5064f2','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-182','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',200,'EXECUTED','3:380743d4f027534180d818f5c507fae9','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-183','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',201,'EXECUTED','3:6882a4cf798e257af34753a8b5e7a157','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-184','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',202,'EXECUTED','3:93473623db4b6e7ca7813658da5b6771','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-185','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',203,'EXECUTED','3:f19a46800a4695266f3372aa709650b2','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-186','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',204,'EXECUTED','3:adfd7433de8d3b196d1166f62e497f8d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-187','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',205,'EXECUTED','3:88b09239d29fbddd8bf4640df9f3e235','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-188','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',206,'EXECUTED','3:777e5970e09a3a1608bf7c40ef1ea1db','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-189','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',207,'EXECUTED','3:40dab4e434aa06340ba046fbd1382c6d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-19','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',17,'EXECUTED','3:b5acf27abca6fec3533e081a6c57c415','Create Table','',NULL,'2.0.5'),('1227303685425-190','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',208,'EXECUTED','3:8766098ff9779a913d5642862955eaff','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-191','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',209,'EXECUTED','3:2a52afd1df6dcf64ec21f3c6ffe1d022','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-192','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',210,'EXECUTED','3:fa5de48b1490faa157e1977529034169','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-193','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:01',211,'EXECUTED','3:1213cb90fa9bd1561a371cc53c262d0f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-194','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',212,'EXECUTED','3:2eb07e7388ff8d68d36cf2f3552c1a7c','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-195','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',213,'EXECUTED','3:d6ec9bb7b3bab333dcea4a3c18083616','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-196','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',214,'EXECUTED','3:df03afd5ef34e472fd6d43ef74a859e1','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-197','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',215,'EXECUTED','3:a0811395501a4423ca66de08fcf53895','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-198','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',216,'EXECUTED','3:e46a78b95280d9082557ed991af8dbe7','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-199','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',217,'EXECUTED','3:e57afffae0d6a439927e45cde4393363','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-2','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',2,'EXECUTED','3:d90246bb4d8342608e818a872d3335f1','Create Table','',NULL,'2.0.5'),('1227303685425-20','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',18,'EXECUTED','3:e0a8a4978c536423320f1ff44520169a','Create Table','',NULL,'2.0.5'),('1227303685425-200','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',218,'EXECUTED','3:667c2308fcf366f47fab8d9df3a3b2ae','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-201','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',219,'EXECUTED','3:104750a2b7779fa43e8457071e0bc33e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-202','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',220,'EXECUTED','3:4b813b03362a54d89a28ed1b10bc9069','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-203','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',221,'EXECUTED','3:526893ceedd67d8a26747e314a15f501','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-204','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',222,'EXECUTED','3:d0dbb7cc972e73f6a429b273ef63132e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-205','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',223,'EXECUTED','3:44244a3065d9a5531a081d176aa4e93d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-207','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',224,'EXECUTED','3:77ade071c48615dbb39cbf9f01610c0e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-208','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',225,'EXECUTED','3:04495bf48c23d0fe56133da87c4e9a66','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-209','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',226,'EXECUTED','3:ff99d75d98ce0428a57100aeb558a529','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-21','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',19,'EXECUTED','3:f2353036e6382f45f91af5d8024fb04c','Create Table','',NULL,'2.0.5'),('1227303685425-210','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',227,'EXECUTED','3:537b2e8f88277a6276bcdac5d1493e4e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-211','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',228,'EXECUTED','3:3da39190692480b0a610b5c66fd056b8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-212','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',229,'EXECUTED','3:347f20b32a463b73f0a93de13731a3a3','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-213','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',230,'EXECUTED','3:b89ee7f6dd678737268566b7e7d0d5d3','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-214','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',231,'EXECUTED','3:5f4b3400ecb50d46e04a18b6b57821c8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-215','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',232,'EXECUTED','3:3dfa6664ca6b77eee492af73908f7312','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-216','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',233,'EXECUTED','3:7f7dbdcdaf3914e33458c0d67bc326db','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-217','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',234,'EXECUTED','3:1f03c97bd9b3ee1c2726656c6a0db795','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-218','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',235,'EXECUTED','3:e0a67bb4f3ea4b44de76fd73ca02ddb3','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-219','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',236,'EXECUTED','3:9a347c93be3356b84358ada2264ed201','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-22','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',20,'EXECUTED','3:5ff0caa8c8497fd681f111bf2842baca','Create Table','',NULL,'2.0.5'),('1227303685425-220','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',237,'EXECUTED','3:8a744c0020e6c6ae519ed0a04d79f82d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-221','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',238,'EXECUTED','3:cc3f5b38ea88221efe32bc99be062edf','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-222','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',239,'EXECUTED','3:a90ffe3cbe9ddd1704e702e71ba5a216','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-223','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',240,'EXECUTED','3:ee4b79223897197c46c79d6ed2e68538','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-224','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',241,'EXECUTED','3:56d7625e53d13008ae7a31d09ba7dab8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-225','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:02',242,'EXECUTED','3:b94477e4e6ecf22bc973408d2d01a868','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-226','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',243,'EXECUTED','3:d7a0cde832f1f557f0f42710645c1b50','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-227','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',244,'EXECUTED','3:6873a8454254a783dbcbe608828c0bd0','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-228','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',245,'EXECUTED','3:6ffcdbbe70b8f8e096785a3c2fe83318','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-229','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',246,'EXECUTED','3:ef5d7095407e0df6a1fcaf7c3c55872b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-23','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',21,'EXECUTED','3:c3aa4ad35ead35e805a99083a95a1c86','Create Table','',NULL,'2.0.5'),('1227303685425-230','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',247,'EXECUTED','3:306710c2acba2e689bf1121d577f449b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-231','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',248,'EXECUTED','3:71f320edc9221ce73876d80077b7b94d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-232','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',249,'EXECUTED','3:8dfba47fb6719dc743b231cc645a8378','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-234','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',250,'EXECUTED','3:9b12808a0fe62d6951bcd61f9cbff3f8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-235','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',251,'EXECUTED','3:a3e9822b106a9bb42f5b9d28dc70335c','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-236','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',252,'EXECUTED','3:388be0f658f8bf6df800fe3efd4dadb3','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-237','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',253,'EXECUTED','3:eee4cb65598835838fd6deb8e4043693','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-239','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',254,'EXECUTED','3:3b38e45410dd1d02530d012a12b6b03c','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-24','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',22,'EXECUTED','3:f4f4e3a5fa3d93bb50d2004c6976cc12','Create Table','',NULL,'2.0.5'),('1227303685425-240','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',255,'EXECUTED','3:095316f05dac21b4a33a141e5781d99d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-241','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',256,'EXECUTED','3:2cffae7a53d76f19e5194778cff75a4f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-242','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',257,'EXECUTED','3:828732619d67fa932631e18827d74463','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-243','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',258,'EXECUTED','3:730166a1b0c3162e8ce882e0c8f308c5','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-244','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',259,'EXECUTED','3:77c03c05576961f7efebdfa10ae68119','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-245','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',260,'EXECUTED','3:d7d8dcaceb9793b0801c87eb2c94cd11','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-246','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',261,'EXECUTED','3:d395ea3ef18817dc23e750a1048cb4e1','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-247','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',262,'EXECUTED','3:4546bff7866082946f19e5d82ffc4d2e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-248','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',263,'EXECUTED','3:4e1071a7c1047f2d3b49778ce2f8bc40','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-249','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',264,'EXECUTED','3:fd6b7823929af9fded1f213d319eae13','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-25','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',23,'EXECUTED','3:2a720a7c4302c435c06c045abcce3b4d','Create Table','',NULL,'2.0.5'),('1227303685425-250','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',265,'EXECUTED','3:955129e5e6adf3723583c047eb33583d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-251','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',266,'EXECUTED','3:7a12c926e69a3d1a7e31da2b8d7123e5','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-252','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',267,'EXECUTED','3:eb8c61b5b792346af3d3f8732278260b','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-253','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',268,'EXECUTED','3:761e6c7fb13a82c6ab671039e5dc5646','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-254','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',269,'EXECUTED','3:9a2401574c95120e1f90d18fde428d10','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-255','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',270,'EXECUTED','3:cda3d0c5c91b85d9f4610554eabb331e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-256','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:03',271,'EXECUTED','3:ebf6243c66261bf0168e72ceccd0fdb8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-257','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',272,'EXECUTED','3:8dc087b963a10a52a22312c3c995cec2','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-258','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',273,'EXECUTED','3:489d5e366070f6b2424b8e5a20d0118f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-259','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',274,'EXECUTED','3:d8d2a1cfddf07123a8e6f52b1e71705d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-26','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',24,'EXECUTED','3:7f6992f21c5541316bce526edb78a949','Create Table','',NULL,'2.0.5'),('1227303685425-260','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',275,'EXECUTED','3:741f0c9e309b8515b713decb56ed6cb2','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-261','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',276,'EXECUTED','3:7034f7db7864956b7ca13ceb70cc8a92','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-262','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',277,'EXECUTED','3:e3a5995253a29723231b0912b971fb5a','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-263','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',278,'EXECUTED','3:b1d3718c15765d4a3bf89cb61376d3af','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-264','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',279,'EXECUTED','3:973683323e2ce886f07ef53a6836ad1e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-265','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',280,'EXECUTED','3:eff44c0cd530b852864042134ebccb47','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-266','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',281,'EXECUTED','3:2493248589e21293811c01cdb6c2fb87','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-267','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',282,'EXECUTED','3:ee636bdbc5839d7de0914648e1f07431','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-268','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',283,'EXECUTED','3:96710f10538b24f39e74ebc13eb6a3fc','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-269','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',284,'EXECUTED','3:5be60bacdaf2ab2d8a3103e36b32f6b9','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-27','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',25,'EXECUTED','3:6d359a7595e5b9a61ac1101aa7df59e7','Create Table','',NULL,'2.0.5'),('1227303685425-270','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',285,'EXECUTED','3:35a1f2d06c31af2f02df3e7aea4d05a5','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-271','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',286,'EXECUTED','3:64d94dfba329b70a842a09b01b952850','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-272','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',287,'EXECUTED','3:0e3787e31b95815106e7e051b9c4a79a','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-273','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',288,'EXECUTED','3:00949a7bd184ed4ee994eabf4b98a41f','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-274','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',289,'EXECUTED','3:b63e3786d661815d2b7c63b277796fc9','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-275','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',290,'EXECUTED','3:7e0ac267990b953ff9efe8fece53b4dd','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-276','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',291,'EXECUTED','3:d66f7691a19406c215b3b4b4c5330775','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-277','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',292,'EXECUTED','3:9b7c8b6ab0b9f8ffde5e7853efa40db5','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-278','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',293,'EXECUTED','3:e5f95724ac551e5905c604e59af444f9','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-279','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',294,'EXECUTED','3:6b4a4c9072a92897562aa595c27aaae4','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-28','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',26,'EXECUTED','3:7264098c8ccfa42b12ffb13056f77383','Create Table','',NULL,'2.0.5'),('1227303685425-280','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',295,'EXECUTED','3:8fb315815532eb73c13fac2dac763f69','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-281','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',296,'EXECUTED','3:1bed6131408c745505800d96130d3b30','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-282','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',297,'EXECUTED','3:ecf4138f4fd2d1e8be720381ac401623','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-283','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',298,'EXECUTED','3:00b414c29dcc3be9683f28ff3f2d9b20','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-284','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',299,'EXECUTED','3:b71dcc206a323ffa6ac4cd658de7b435','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-285','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',300,'EXECUTED','3:17423acbed3db4325d48d91e9f0e7147','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-286','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',301,'EXECUTED','3:2d8576bdbc9dd67137ba462b563022d8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-287','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',302,'EXECUTED','3:6798c27ddf8ca72952030d6005422c1e','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-288','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',303,'EXECUTED','3:b28ec2579454fa7a13fd3896420ad1ff','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-289','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',304,'EXECUTED','3:cbfff99e22305c5570cdc8fdb33f3542','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-29','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',27,'EXECUTED','3:750f7e9a5f0898408626a11ce7f34ee4','Create Table','',NULL,'2.0.5'),('1227303685425-290','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:04',305,'EXECUTED','3:66957ec2b3211869a1ad777de33e7983','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-291','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',306,'EXECUTED','3:18b7da760f632dc6baf910fe5001212d','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-292','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',307,'EXECUTED','3:a1a914015e07b1637a9c655a9be3cfcd','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-293','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',308,'EXECUTED','3:5fedacb04729210c4a27bbfa2a3704f1','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-294','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',309,'EXECUTED','3:cf53101d520adb79fd1827819bcf0401','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-295','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',310,'EXECUTED','3:22b93c390cd6054f3dc8b62814d143cf','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-296','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',311,'EXECUTED','3:8b71fc2ae6be26a1ddc499cfc6e2cdba','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-297','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',312,'EXECUTED','3:d10fb06a37b1433a248b549ebae31e63','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-298','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',313,'EXECUTED','3:a3008458deed3c8c95f475395df6d788','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-299','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',314,'EXECUTED','3:b380ee7cce1b82a2f983d242b45c63b3','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-30','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',28,'EXECUTED','3:0951dbc13f8f4c6fd4ccc8a7ddb9d77c','Create Table','',NULL,'2.0.5'),('1227303685425-300','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',315,'EXECUTED','3:01f02c28d4f52e712aad87873aaa40f8','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-301','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:44:05',316,'EXECUTED','3:adf03ccc09e8f37f827b8ffbf3afff83','Add Foreign Key Constraint','',NULL,'2.0.5'),('1227303685425-31','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',29,'EXECUTED','3:5669760a2908489a63a69c3d34dd5c54','Create Table','',NULL,'2.0.5'),('1227303685425-32','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',30,'EXECUTED','3:c8b2b1bb1eb7b3885c89f436210cc2d5','Create Table','',NULL,'2.0.5'),('1227303685425-33','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',31,'EXECUTED','3:7b55b4b34bca59cf0d0b7271a2906568','Create Table','',NULL,'2.0.5'),('1227303685425-34','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',32,'EXECUTED','3:05a6b514927868471d71b334502d0e85','Create Table','',NULL,'2.0.5'),('1227303685425-35','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',33,'EXECUTED','3:528a3f364b7acce00fcc4d49153a5626','Create Table','',NULL,'2.0.5'),('1227303685425-36','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',34,'EXECUTED','3:2f8eb6548a5d935d7df6f68b329b7685','Create Table','',NULL,'2.0.5'),('1227303685425-37','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',35,'EXECUTED','3:fb11397b44997fe8fef33f8ae86d4044','Create Table','',NULL,'2.0.5'),('1227303685425-39','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',36,'EXECUTED','3:3efa037ecd0227f935b601f0bda28692','Create Table','',NULL,'2.0.5'),('1227303685425-4','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',3,'EXECUTED','3:27c254248b84b163e54161c6f14c2104','Create Table','',NULL,'2.0.5'),('1227303685425-40','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',37,'EXECUTED','3:934d8b580b8b3572b3795a92496783a2','Create Table','',NULL,'2.0.5'),('1227303685425-41','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',38,'EXECUTED','3:a65a25558c348c19863a0088ae031ad7','Create Table','',NULL,'2.0.5'),('1227303685425-42','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',39,'EXECUTED','3:1264d39b6cb1fa81263df8f7a0819a5e','Create Table','',NULL,'2.0.5'),('1227303685425-43','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',40,'EXECUTED','3:bbdbc4ae1631b83db687f4a92453ba3e','Create Table','',NULL,'2.0.5'),('1227303685425-44','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',41,'EXECUTED','3:98d047deb448c37f252eca7c035bf158','Create Table','',NULL,'2.0.5'),('1227303685425-45','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',42,'EXECUTED','3:a8a1d8af033a6e76c1e2060727bf4ebe','Create Table','',NULL,'2.0.5'),('1227303685425-46','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',43,'EXECUTED','3:b18b944837dd60d5d82996b8b1b57833','Create Table','',NULL,'2.0.5'),('1227303685425-47','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',44,'EXECUTED','3:7ae5af2d7f0b3e0bfaf9f243f56851eb','Create Table','',NULL,'2.0.5'),('1227303685425-48','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',45,'EXECUTED','3:fdbf71c7035399d628225af885c63114','Create Table','',NULL,'2.0.5'),('1227303685425-49','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',46,'EXECUTED','3:0c00abd4429f2072f360915eb2eec3de','Create Table','',NULL,'2.0.5'),('1227303685425-5','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',4,'EXECUTED','3:63b45eb5e407f1aa4e6569392ca957ca','Create Table','',NULL,'2.0.5'),('1227303685425-50','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',47,'EXECUTED','3:0e2c0cecd82166846a869f8ecce32bc2','Create Table','',NULL,'2.0.5'),('1227303685425-51','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',48,'EXECUTED','3:308c259886e442254ca616d365db78a2','Create Table','',NULL,'2.0.5'),('1227303685425-52','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',49,'EXECUTED','3:c11b85565b591de38d518fe60411507d','Create Table','',NULL,'2.0.5'),('1227303685425-53','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',50,'EXECUTED','3:2860fbf54a18e959646882325eb4dd87','Create Table','',NULL,'2.0.5'),('1227303685425-54','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',51,'EXECUTED','3:f09d17e1a43189fc59b1c5d7c6c7d692','Create Table','',NULL,'2.0.5'),('1227303685425-55','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',52,'EXECUTED','3:2318a41398b0583575e358aa79813cc6','Create Table','',NULL,'2.0.5'),('1227303685425-56','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',53,'EXECUTED','3:9d78f818f482903055f79b2fb7081e0f','Create Table','',NULL,'2.0.5'),('1227303685425-57','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',54,'EXECUTED','3:401395592f65e4216b0b0e8a756ae9b8','Create Table','',NULL,'2.0.5'),('1227303685425-58','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',55,'EXECUTED','3:fcb459a88d234d6556ab5f5aff73a926','Create Table','',NULL,'2.0.5'),('1227303685425-59','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',56,'EXECUTED','3:ab774554467ea7818601acb495c57e5a','Create Table','',NULL,'2.0.5'),('1227303685425-6','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',5,'EXECUTED','3:570a29d5b7f6b945d80de91fce59c0f6','Create Table','',NULL,'2.0.5'),('1227303685425-60','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',57,'EXECUTED','3:54282635bb2bf4218be532ed940ac4b0','Create Table','',NULL,'2.0.5'),('1227303685425-61','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',58,'EXECUTED','3:920daa80f4f9db2cacee8dca6ca4f971','Create Table','',NULL,'2.0.5'),('1227303685425-62','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',59,'EXECUTED','3:55daf6d077eac0ef7e30e6395bc4bc68','Create Table','',NULL,'2.0.5'),('1227303685425-63','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',60,'EXECUTED','3:cdc470c39dadd7cb1a1527a82ff737d3','Create Table','',NULL,'2.0.5'),('1227303685425-64','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',61,'EXECUTED','3:e3eb66044ea03e417837e9c1668f28e3','Create Table','',NULL,'2.0.5'),('1227303685425-65','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',62,'EXECUTED','3:5b25f91c273cc6b58b25385d24bc4f12','Create Table','',NULL,'2.0.5'),('1227303685425-66','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',63,'EXECUTED','3:93e2d359d5f6c38b95dfd47dce687c9c','Create Table','',NULL,'2.0.5'),('1227303685425-67','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',64,'EXECUTED','3:7c991af945580bbcb08e8d288c327525','Create Table','',NULL,'2.0.5'),('1227303685425-68','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',65,'EXECUTED','3:40096bd3e62db8377ce4f0a1fcea444e','Create Table','',NULL,'2.0.5'),('1227303685425-7','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',6,'EXECUTED','3:13a412a8d9125f657594bc96f742dd1b','Create Table','',NULL,'2.0.5'),('1227303685425-70','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',66,'EXECUTED','3:0df5ce250df07062c43119d18fc2a85b','Create Table','',NULL,'2.0.5'),('1227303685425-71','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',67,'EXECUTED','3:06e7ba94af07838a3d2ebb98816412a3','Create Table','',NULL,'2.0.5'),('1227303685425-72','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:58',68,'EXECUTED','3:01610d6974df470c653bc34953a31335','Create Table','',NULL,'2.0.5'),('1227303685425-73','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',89,'EXECUTED','3:33d08000805c4b9d7db06556961553b1','Add Primary Key','',NULL,'2.0.5'),('1227303685425-75','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',90,'EXECUTED','3:f2b0a95b4015b54d38c721906abc1fdb','Add Primary Key','',NULL,'2.0.5'),('1227303685425-77','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',91,'EXECUTED','3:bdde9c0d7374a3468a94426199b0d930','Add Primary Key','',NULL,'2.0.5'),('1227303685425-78','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',92,'EXECUTED','3:6fb4014a9a3ecc6ed09a896936b8342d','Add Primary Key','',NULL,'2.0.5'),('1227303685425-79','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',93,'EXECUTED','3:77e1d7c49e104435d10d90cc70e006e3','Add Primary Key','',NULL,'2.0.5'),('1227303685425-81','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',94,'EXECUTED','3:a5871abe4cdc3d8d9390a9b4ab0d0776','Add Primary Key','',NULL,'2.0.5'),('1227303685425-82','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',95,'EXECUTED','3:2f7eab1e485fd5a653af8799a84383b4','Add Primary Key','',NULL,'2.0.5'),('1227303685425-83','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',96,'EXECUTED','3:60ca763d5ac940b3bc189e2f28270bd8','Add Primary Key','',NULL,'2.0.5'),('1227303685425-84','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',97,'EXECUTED','3:901f48ab4c9e3a702fc0b38c5e724a5e','Add Primary Key','',NULL,'2.0.5'),('1227303685425-85','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',99,'EXECUTED','3:5544801862c8f21461acf9a22283ccab','Create Index','',NULL,'2.0.5'),('1227303685425-86','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',100,'EXECUTED','3:70591fc2cd8ce2e7bda36b407bbcaa86','Create Index','',NULL,'2.0.5'),('1227303685425-87','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',101,'EXECUTED','3:35c206a147d28660ffee5f87208f1f6b','Create Index','',NULL,'2.0.5'),('1227303685425-88','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',102,'EXECUTED','3:d399797580e14e7d67c1c40637314476','Create Index','',NULL,'2.0.5'),('1227303685425-89','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',103,'EXECUTED','3:138fa4373fe05e63fe5f923cf3c17e69','Create Index','',NULL,'2.0.5'),('1227303685425-9','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:57',7,'EXECUTED','3:ac6886dbc0c811bda6909908fb2d30a2','Create Table','',NULL,'2.0.5'),('1227303685425-90','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',104,'EXECUTED','3:4b60e13b8e209c2b5b1f981f4c28fc1b','Create Index','',NULL,'2.0.5'),('1227303685425-91','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',105,'EXECUTED','3:f9c13df6f50d1e7c1fad36faa020d7a6','Create Index','',NULL,'2.0.5'),('1227303685425-92','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',106,'EXECUTED','3:c24d9e0d28b3a208dbe2fc1cfaf23720','Create Index','',NULL,'2.0.5'),('1227303685425-93','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',107,'EXECUTED','3:ae9beae273f9502bc01580754e0f2bdf','Create Index','',NULL,'2.0.5'),('1227303685425-94','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',108,'EXECUTED','3:39d98e23d1480b677bc8f2341711756b','Create Index','',NULL,'2.0.5'),('1227303685425-95','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',109,'EXECUTED','3:16ece63cd24c4c5048356cc2854235e1','Create Index','',NULL,'2.0.5'),('1227303685425-96','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',110,'EXECUTED','3:de9943f6a1500bd3f94cb7e0c1d3bde7','Create Index','',NULL,'2.0.5'),('1227303685425-97','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',111,'EXECUTED','3:c0fac38fa4928378abe6f47bd78926b1','Create Index','',NULL,'2.0.5'),('1227303685425-98','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',112,'EXECUTED','3:4c8938f3ea457f5f4f4936e9cbaf898b','Create Index','',NULL,'2.0.5'),('1227303685425-99','ben (generated)','liquibase-schema-only.xml','2016-03-07 11:43:59',113,'EXECUTED','3:d331ce5f04aca9071c5b897396d81098','Create Index','',NULL,'2.0.5'),('17092015053645','Hemanth','liquibase.xml','2016-03-07 11:59:41',10631,'EXECUTED','3:3a5649b540435525e947a2b595e20282','Create Table','',NULL,'2.0.5'),('2','upul','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10043,'MARK_RAN','3:b1811e5e43321192b275d6e2fe2fa564','Add Foreign Key Constraint','Create the foreign key from the privilege required for to edit\n			a person attribute type and the privilege.privilege column',NULL,'2.0.5'),('2-increase-privilege-col-size-rol-privilege','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10486,'EXECUTED','3:6fc0247ae054fedeb32a4af3775046f4','Drop Foreign Key Constraint, Modify Column, Add Foreign Key Constraint','Increasing the size of the privilege column in the role_privilege table',NULL,'2.0.5'),('2-role-assign-new-api-privileges-to-renamed-ones','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10484,'EXECUTED','3:4eadbd161bf0f7e15eafb4a52b01b625','Custom SQL','Assigning the new API-level privileges to roles that used to have the renamed privileges',NULL,'2.0.5'),('200805281223','bmckown','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10045,'MARK_RAN','3:b1fc37f9ec96eac9203f0808c2f4ac26','Create Table, Add Foreign Key Constraint','Create the concept_complex table',NULL,'2.0.5'),('200805281224','bmckown','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10046,'MARK_RAN','3:ea32453830c2215bdb209770396002e7','Add Column','Adding the value_complex column to obs.  This may take a long time if you have a large number of observations.',NULL,'2.0.5'),('200805281225','bmckown','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10047,'MARK_RAN','3:5281031bcc075df3b959e94da4adcaa9','Insert Row','Adding a \'complex\' Concept Datatype',NULL,'2.0.5'),('200805281226','bmckown','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10048,'MARK_RAN','3:9a49a3d002485f3a77134d98fb7c8cd8','Drop Table (x2)','Dropping the mimetype and complex_obs tables as they aren\'t needed in the new complex obs setup',NULL,'2.0.5'),('200809191226','smbugua','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10049,'MARK_RAN','3:eed0aa27b44ecf668c81e457d99fa7de','Add Column','Adding the hl7 archive message_state column so that archives can be tracked\n			(preCondition database_version check in place because this change was in the old format in trunk for a while)',NULL,'2.0.5'),('200809191927','smbugua','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10050,'MARK_RAN','3:f0e4fab64749e42770e62e9330c2d288','Rename Column, Modify Column','Adding the hl7 archive message_state column so that archives can be tracked',NULL,'2.0.5'),('200811261102','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10044,'EXECUTED','3:158dd028359ebfd4f1c9bf2e76a5e143','Update Data','Fix field property for new Tribe person attribute',NULL,'2.0.5'),('200901101524','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10051,'EXECUTED','3:feb4a087d13657164e5c3bc787b7f83f','Modify Column','Changing datatype of drug.retire_reason from DATETIME to varchar(255)',NULL,'2.0.5'),('200901130950','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10052,'EXECUTED','3:f1e5e7124bdb4f7378866fdb691e2780','Delete Data (x2)','Remove Manage Tribes and View Tribes privileges from all roles',NULL,'2.0.5'),('200901130951','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10053,'EXECUTED','3:54ac8683819837cc04f1a16b6311d668','Delete Data (x2)','Remove Manage Mime Types, View Mime Types, and Purge Mime Types privilege',NULL,'2.0.5'),('200901161126','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10054,'EXECUTED','3:871b9364dd87b6bfcc0005f40b6eb399','Delete Data','Removed the database_version global property',NULL,'2.0.5'),('20090121-0949','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10055,'EXECUTED','3:8639e35e0238019af2f9e326dd5cbc22','Custom SQL','Switched the default xslt to use PV1-19 instead of PV1-1',NULL,'2.0.5'),('20090122-0853','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10056,'EXECUTED','3:4903c6f81f0309313013851f09a26b85','Custom SQL, Add Lookup Table, Drop Foreign Key Constraint, Delete Data (x2), Drop Table','Remove duplicate concept name tags',NULL,'2.0.5'),('20090123-0305','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10057,'MARK_RAN','3:48cdf2b28fcad687072ac8133e46cba6','Add Unique Constraint','Add unique constraint to the tags table',NULL,'2.0.5'),('20090214-2246','isherman','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10063,'EXECUTED','3:d16c607266238df425db61908e7c8745','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (mysql specific)',NULL,'2.0.5'),('20090214-2247','isherman','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10064,'MARK_RAN','3:e4eeb4a09c2ab695bbde832cd7b6047d','Custom SQL','Add weight and cd4 to patientGraphConcepts user property (using standard sql)',NULL,'2.0.5'),('200902142212','ewolodzko','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10242,'MARK_RAN','3:df93fa2841295b29a0fcd4225c46d1a3','Add Column','Add a sortWeight field to PersonAttributeType',NULL,'2.0.5'),('200902142213','ewolodzko','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10243,'EXECUTED','3:288804e42d575fe62c852ed9daa9d59d','Custom SQL','Add default sortWeights to all current PersonAttributeTypes',NULL,'2.0.5'),('20090224-1002-create-visit_type','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10384,'MARK_RAN','3:ea3c0b323da2d51cf43e982177eace96','Create Table, Add Foreign Key Constraint (x3)','Create visit type table',NULL,'2.0.5'),('20090224-1229','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10058,'MARK_RAN','3:f8433194bcb29073c17c7765ce61aab2','Create Table, Add Foreign Key Constraint (x2)','Add location tags table',NULL,'2.0.5'),('20090224-1250','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10059,'MARK_RAN','3:8935a56fac2ad91275248d4675c2c090','Create Table, Add Foreign Key Constraint (x2), Add Primary Key','Add location tag map table',NULL,'2.0.5'),('20090224-1256','Keelhaul+bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10060,'MARK_RAN','3:9c0e7238dd1daad9edff381ba22a3ada','Add Column, Add Foreign Key Constraint','Add parent_location column to location table',NULL,'2.0.5'),('20090225-1551','dthomas','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10001,'MARK_RAN','3:a3aed1685bd1051a8c4fae0eab925954',NULL,NULL,NULL,NULL),('20090301-1259','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10062,'EXECUTED','3:21f2ac06dee26613b73003cd1f247ea8','Update Data (x2)','Fixes the description for name layout global property',NULL,'2.0.5'),('20090316-1008','vanand','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10000,'MARK_RAN','3:baa49982f1106c65ba33c845bba149b3',NULL,NULL,NULL,NULL),('20090316-1008-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10432,'EXECUTED','3:aeeb6c14cd22ffa121a2582e04025f5a','Modify Column (x36)','(Fixed)Changing from smallint to BOOLEAN type on BOOLEAN properties',NULL,'2.0.5'),('200903210905','mseaton','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10065,'MARK_RAN','3:720bb7a3f71f0c0a911d3364e55dd72f','Create Table, Add Foreign Key Constraint (x3)','Add a table to enable generic storage of serialized objects',NULL,'2.0.5'),('200903210905-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10066,'EXECUTED','3:a11519f50deeece1f9760d3fc1ac3f05','Modify Column','(Fixed)Add a table to enable generic storage of serialized objects',NULL,'2.0.5'),('20090402-1515-38-cohort','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10071,'MARK_RAN','3:5c65821ef168d9e8296466be5990ae08','Add Column','Adding \"uuid\" column to cohort table',NULL,'2.0.5'),('20090402-1515-38-concept','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10072,'MARK_RAN','3:8004d09d6e2a34623b8d0a13d6c38dc4','Add Column','Adding \"uuid\" column to concept table',NULL,'2.0.5'),('20090402-1515-38-concept_answer','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10073,'MARK_RAN','3:adf3f4ebf7e0eb55eb6927dea7ce2a49','Add Column','Adding \"uuid\" column to concept_answer table',NULL,'2.0.5'),('20090402-1515-38-concept_class','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10074,'MARK_RAN','3:f39e190a2e12c7a6163a0d8a82544228','Add Column','Adding \"uuid\" column to concept_class table',NULL,'2.0.5'),('20090402-1515-38-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10075,'MARK_RAN','3:d68b3f2323626fee7b433f873a019412','Add Column','Adding \"uuid\" column to concept_datatype table',NULL,'2.0.5'),('20090402-1515-38-concept_description','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10076,'MARK_RAN','3:7d043672ede851c5dcd717171f953c75','Add Column','Adding \"uuid\" column to concept_description table',NULL,'2.0.5'),('20090402-1515-38-concept_map','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10002,'MARK_RAN','3:c1884f56bd70a205b86e7c4038e6c6f9',NULL,NULL,NULL,NULL),('20090402-1515-38-concept_name','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10077,'MARK_RAN','3:822888c5ba1132f6783fbd032c21f238','Add Column','Adding \"uuid\" column to concept_name table',NULL,'2.0.5'),('20090402-1515-38-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10078,'MARK_RAN','3:dcb584d414ffd8133c97e42585bd34cd','Add Column','Adding \"uuid\" column to concept_name_tag table',NULL,'2.0.5'),('20090402-1515-38-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10079,'MARK_RAN','3:fe19ecccb704331741c227aa72597789','Add Column','Adding \"uuid\" column to concept_proposal table',NULL,'2.0.5'),('20090402-1515-38-concept_set','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10080,'MARK_RAN','3:cdc72e16eaec2244c09e9e2fedf5806b','Add Column','Adding \"uuid\" column to concept_set table',NULL,'2.0.5'),('20090402-1515-38-concept_source','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10003,'MARK_RAN','3:ad101415b93eaf653871eddd4fe4fc17',NULL,NULL,NULL,NULL),('20090402-1515-38-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10081,'MARK_RAN','3:5ce8a6cdbfa8742b033b0b1c12e4cd42','Add Column','Adding \"uuid\" column to concept_state_conversion table',NULL,'2.0.5'),('20090402-1515-38-drug','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10082,'MARK_RAN','3:6869bd44f51cb7f63f758fbd8a7fe156','Add Column','Adding \"uuid\" column to drug table',NULL,'2.0.5'),('20090402-1515-38-encounter','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10083,'MARK_RAN','3:0808491f7ec59827a0415f2949b9d90e','Add Column','Adding \"uuid\" column to encounter table',NULL,'2.0.5'),('20090402-1515-38-encounter_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10084,'MARK_RAN','3:9aaac835f4d9579386990d4990ffb9d6','Add Column','Adding \"uuid\" column to encounter_type table',NULL,'2.0.5'),('20090402-1515-38-field','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10085,'MARK_RAN','3:dfee5fe509457ef12b14254bab9e6df5','Add Column','Adding \"uuid\" column to field table',NULL,'2.0.5'),('20090402-1515-38-field_answer','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10086,'MARK_RAN','3:c378494d6e9ae45b278c726256619cd7','Add Column','Adding \"uuid\" column to field_answer table',NULL,'2.0.5'),('20090402-1515-38-field_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10087,'MARK_RAN','3:dfb47f0b85d5bdad77f3a15cc4d180ec','Add Column','Adding \"uuid\" column to field_type table',NULL,'2.0.5'),('20090402-1515-38-form','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10088,'MARK_RAN','3:eb707ff99ed8ca2945a43175b904dea4','Add Column','Adding \"uuid\" column to form table',NULL,'2.0.5'),('20090402-1515-38-form_field','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10089,'MARK_RAN','3:635701ccda0484966f45f0e617119100','Add Column','Adding \"uuid\" column to form_field table',NULL,'2.0.5'),('20090402-1515-38-global_property','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10090,'MARK_RAN','3:1c62ba666b60eaa88ee3a90853f3bf59','Add Column','Adding \"uuid\" column to global_property table',NULL,'2.0.5'),('20090402-1515-38-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10091,'MARK_RAN','3:9c5015280eff821924416112922fd94d','Add Column','Adding \"uuid\" column to hl7_in_archive table',NULL,'2.0.5'),('20090402-1515-38-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10092,'MARK_RAN','3:35b94fc079e6de9ada4329a7bbc55645','Add Column','Adding \"uuid\" column to hl7_in_error table',NULL,'2.0.5'),('20090402-1515-38-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10093,'MARK_RAN','3:494d9eaaed055d0c5af4b4d85db2095d','Add Column','Adding \"uuid\" column to hl7_in_queue table',NULL,'2.0.5'),('20090402-1515-38-hl7_source','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10094,'MARK_RAN','3:8bc9839788ef5ab415ccf020eb04a1f7','Add Column','Adding \"uuid\" column to hl7_source table',NULL,'2.0.5'),('20090402-1515-38-location','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10095,'MARK_RAN','3:7e6b762f813310c72026677d540dee57','Add Column','Adding \"uuid\" column to location table',NULL,'2.0.5'),('20090402-1515-38-location_tag','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10096,'MARK_RAN','3:6a94a67e776662268d42f09cf7c66ac0','Add Column','Adding \"uuid\" column to location_tag table',NULL,'2.0.5'),('20090402-1515-38-note','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10097,'MARK_RAN','3:f0fd7b6750d07c973aad667b170cdfa8','Add Column','Adding \"uuid\" column to note table',NULL,'2.0.5'),('20090402-1515-38-notification_alert','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10098,'MARK_RAN','3:f2865558fb76c7584f6e86786b0ffdea','Add Column','Adding \"uuid\" column to notification_alert table',NULL,'2.0.5'),('20090402-1515-38-notification_template','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10099,'MARK_RAN','3:c05536d99eb2479211cb10010d48a2e9','Add Column','Adding \"uuid\" column to notification_template table',NULL,'2.0.5'),('20090402-1515-38-obs','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10100,'MARK_RAN','3:ba99d7eccba2185e9d5ebab98007e577','Add Column','Adding \"uuid\" column to obs table',NULL,'2.0.5'),('20090402-1515-38-orders','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10102,'MARK_RAN','3:732a2d4fd91690d544f0c63bdb65819f','Add Column','Adding \"uuid\" column to orders table',NULL,'2.0.5'),('20090402-1515-38-order_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10101,'MARK_RAN','3:137552884c5eb5af4c3f77c90df514cb','Add Column','Adding \"uuid\" column to order_type table',NULL,'2.0.5'),('20090402-1515-38-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10103,'MARK_RAN','3:1a9ddcd8997bcf1a9668051d397e41c1','Add Column','Adding \"uuid\" column to patient_identifier table',NULL,'2.0.5'),('20090402-1515-38-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10104,'MARK_RAN','3:6170d6caa73320fd2433fba0a16e8029','Add Column','Adding \"uuid\" column to patient_identifier_type table',NULL,'2.0.5'),('20090402-1515-38-patient_program','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10105,'MARK_RAN','3:8fb284b435669717f4b5aaa66e61fc10','Add Column','Adding \"uuid\" column to patient_program table',NULL,'2.0.5'),('20090402-1515-38-patient_state','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10106,'MARK_RAN','3:b67eb1bbd3e2912a646f56425c38631f','Add Column','Adding \"uuid\" column to patient_state table',NULL,'2.0.5'),('20090402-1515-38-person','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10107,'MARK_RAN','3:2b89eb77976b9159717e9d7b83c34cf1','Add Column','Adding \"uuid\" column to person table',NULL,'2.0.5'),('20090402-1515-38-person_address','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10108,'MARK_RAN','3:cfdb17b16b6d15477bc72d4d19ac3f29','Add Column','Adding \"uuid\" column to person_address table',NULL,'2.0.5'),('20090402-1515-38-person_attribute','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10109,'MARK_RAN','3:2f6b7fa688987b32d99cda348c6f6c46','Add Column','Adding \"uuid\" column to person_attribute table',NULL,'2.0.5'),('20090402-1515-38-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10110,'MARK_RAN','3:38d4dce320f2fc35db9dfcc2eafc093e','Add Column','Adding \"uuid\" column to person_attribute_type table',NULL,'2.0.5'),('20090402-1515-38-person_name','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10111,'MARK_RAN','3:339f02d6797870f9e7dd704f093b088c','Add Column','Adding \"uuid\" column to person_name table',NULL,'2.0.5'),('20090402-1515-38-privilege','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10112,'MARK_RAN','3:41f52c4340fdc9f0825ea9660edea8ec','Add Column','Adding \"uuid\" column to privilege table',NULL,'2.0.5'),('20090402-1515-38-program','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10113,'MARK_RAN','3:a72f80159cdbd576906cd3b9069d425b','Add Column','Adding \"uuid\" column to program table',NULL,'2.0.5'),('20090402-1515-38-program_workflow','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10114,'MARK_RAN','3:c69183f7e1614d5a338c0d0944f1e754','Add Column','Adding \"uuid\" column to program_workflow table',NULL,'2.0.5'),('20090402-1515-38-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10115,'MARK_RAN','3:e25b0fa351bb667af3ff562855f66bb6','Add Column','Adding \"uuid\" column to program_workflow_state table',NULL,'2.0.5'),('20090402-1515-38-relationship','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10116,'MARK_RAN','3:95407167e9f4984de1d710a83371ebd1','Add Column','Adding \"uuid\" column to relationship table',NULL,'2.0.5'),('20090402-1515-38-relationship_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10117,'MARK_RAN','3:f8755b127c004d11a43bfd6558be01b7','Add Column','Adding \"uuid\" column to relationship_type table',NULL,'2.0.5'),('20090402-1515-38-report_object','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10118,'MARK_RAN','3:b7ce0784e817be464370a3154fd4aa9c','Add Column','Adding \"uuid\" column to report_object table',NULL,'2.0.5'),('20090402-1515-38-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10119,'MARK_RAN','3:ce7ae79a3e3ce429a56fa658c48889b5','Add Column','Adding \"uuid\" column to report_schema_xml table',NULL,'2.0.5'),('20090402-1515-38-role','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10120,'MARK_RAN','3:f33887a0b51ab366d414e16202cf55db','Add Column','Adding \"uuid\" column to role table',NULL,'2.0.5'),('20090402-1515-38-serialized_object','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10121,'MARK_RAN','3:341cfbdff8ebf188d526bf3348619dcc','Add Column','Adding \"uuid\" column to serialized_object table',NULL,'2.0.5'),('20090402-1516-cohort','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10122,'EXECUTED','3:110084035197514c8d640b915230cf72','Update Data','Generating UUIDs for all rows in cohort table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10123,'EXECUTED','3:a44bc743cb837d88f7371282f3a5871e','Update Data','Generating UUIDs for all rows in concept table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_answer','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10124,'EXECUTED','3:f01d7278b153fa10a7d741607501ae1e','Update Data','Generating UUIDs for all rows in concept_answer table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_class','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10125,'EXECUTED','3:786f0ec8beec453ea9487f2e77f9fb4d','Update Data','Generating UUIDs for all rows in concept_class table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10126,'EXECUTED','3:b828e9851365ec70531dabd250374989','Update Data','Generating UUIDs for all rows in concept_datatype table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_description','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10127,'EXECUTED','3:37dbfc43c73553c9c9ecf11206714cc4','Update Data','Generating UUIDs for all rows in concept_description table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_map','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10004,'MARK_RAN','3:e843f99c0371aabee21ca94fcef01f39',NULL,NULL,NULL,NULL),('20090402-1516-concept_name','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10128,'EXECUTED','3:dd414ae9367287c9c03342a79abd1d62','Update Data','Generating UUIDs for all rows in concept_name table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10129,'EXECUTED','3:cd7b5d0ceeb90b2254708b44c10d03e8','Update Data','Generating UUIDs for all rows in concept_name_tag table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10130,'EXECUTED','3:fb1cfa9c5decbafc3293f3dd1d87ff2b','Update Data','Generating UUIDs for all rows in concept_proposal table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_set','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10131,'EXECUTED','3:3b7f3851624014e740f89bc9a431feaa','Update Data','Generating UUIDs for all rows in concept_set table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-concept_source','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10005,'MARK_RAN','3:53da91ae3e39d7fb7ebca91df3bfd9a6',NULL,NULL,NULL,NULL),('20090402-1516-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10132,'EXECUTED','3:23197d24e498ad86d4e001b183cc0c6b','Update Data','Generating UUIDs for all rows in concept_state_conversion table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-drug','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10133,'EXECUTED','3:40b47df80bd425337b7bdd8b41497967','Update Data','Generating UUIDs for all rows in drug table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-encounter','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10134,'EXECUTED','3:40146708b71d86d4c8c5340767a98f5e','Update Data','Generating UUIDs for all rows in encounter table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-encounter_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10135,'EXECUTED','3:738c6b6244a84fc8e6d582bcd472ffe6','Update Data','Generating UUIDs for all rows in encounter_type table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-field','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10136,'EXECUTED','3:98d2a1550e867e4ef303a4cc47ed904d','Update Data','Generating UUIDs for all rows in field table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-field_answer','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10137,'EXECUTED','3:82bdfe361286d261724eef97dd89e358','Update Data','Generating UUIDs for all rows in field_answer table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-field_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10138,'EXECUTED','3:19a8d007f6147651240ebb9539d3303a','Update Data','Generating UUIDs for all rows in field_type table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-form','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10139,'EXECUTED','3:026ddf1c9050c7367d4eb57dd4105322','Update Data','Generating UUIDs for all rows in form table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-form_field','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10140,'EXECUTED','3:a8b0bcdb35830c2badfdcb9b1cfdd3b5','Update Data','Generating UUIDs for all rows in form_field table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-global_property','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10141,'EXECUTED','3:75a5b4a9473bc9c6bfbabf8e77b0cda7','Update Data','Generating UUIDs for all rows in global_property table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10142,'EXECUTED','3:09891436d8ea0ad14f7b52fd05daa237','Update Data','Generating UUIDs for all rows in hl7_in_archive table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10143,'EXECUTED','3:8d276bbd8bf9d9d1c64756f37ef91ed3','Update Data','Generating UUIDs for all rows in hl7_in_error table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10144,'EXECUTED','3:25e8f998171accd46860717f93690ccc','Update Data','Generating UUIDs for all rows in hl7_in_queue table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-hl7_source','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10145,'EXECUTED','3:45c06e034d7158a0d09afae60c4c83d6','Update Data','Generating UUIDs for all rows in hl7_source table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-location','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10146,'EXECUTED','3:fce0f7eaab989f2ff9664fc66d6b8419','Update Data','Generating UUIDs for all rows in location table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-location_tag','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10147,'EXECUTED','3:50f26d1376ea108bbb65fd4d0633e741','Update Data','Generating UUIDs for all rows in location_tag table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-note','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10148,'EXECUTED','3:f5a0eea2a7c59fffafa674de4356e621','Update Data','Generating UUIDs for all rows in note table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-notification_alert','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10149,'EXECUTED','3:481fbab9bd53449903ac193894adbc28','Update Data','Generating UUIDs for all rows in notification_alert table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-notification_template','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10150,'EXECUTED','3:a4a2990465c4c99747f83ea880cac46a','Update Data','Generating UUIDs for all rows in notification_template table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-obs','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10151,'EXECUTED','3:26d80fdd889922821244f84e3f8039e7','Update Data','Generating UUIDs for all rows in obs table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-orders','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10153,'EXECUTED','3:ec3bc80540d78f416e1d4eef62e8e15a','Update Data','Generating UUIDs for all rows in orders table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-order_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10152,'EXECUTED','3:cae66b98b889c7ee1c8d6ab270a8d0d5','Update Data','Generating UUIDs for all rows in order_type table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10154,'EXECUTED','3:647906cc7cf1fde9b7644b8f2541664f','Update Data','Generating UUIDs for all rows in patient_identifier table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10155,'EXECUTED','3:85f8db0310c15a74b17e968c7730ae12','Update Data','Generating UUIDs for all rows in patient_identifier_type table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-patient_program','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10156,'EXECUTED','3:576b7db39f0212f8e92b6f4e1844ea30','Update Data','Generating UUIDs for all rows in patient_program table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-patient_state','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10157,'EXECUTED','3:250eab0f97fc4eeb4f1a930fbccfcf08','Update Data','Generating UUIDs for all rows in patient_state table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-person','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10158,'EXECUTED','3:cedc8bcd77ade51558fb2d12916e31a4','Update Data','Generating UUIDs for all rows in person table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-person_address','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10159,'EXECUTED','3:0f817424ca41e5c5b459591d6e18b3c6','Update Data','Generating UUIDs for all rows in person_address table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-person_attribute','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10160,'EXECUTED','3:7f9e09b1267c4a787a9d3e37acfd5746','Update Data','Generating UUIDs for all rows in person_attribute table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10161,'EXECUTED','3:1e5f84054b7b7fdf59673e2260f48d9d','Update Data','Generating UUIDs for all rows in person_attribute_type table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-person_name','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10162,'EXECUTED','3:f827da2c097b01ca9073c258b19e9540','Update Data','Generating UUIDs for all rows in person_name table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-privilege','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10163,'EXECUTED','3:2ab150a53c91ded0c5b53fa99fde4ba2','Update Data','Generating UUIDs for all rows in privilege table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-program','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10164,'EXECUTED','3:132b63f2efcf781187602e043122e7ff','Update Data','Generating UUIDs for all rows in program table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-program_workflow','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10165,'EXECUTED','3:d945359ed4bb6cc6a21f4554a0c50a33','Update Data','Generating UUIDs for all rows in program_workflow table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10166,'EXECUTED','3:4bc093882ac096562d63562ac76a1ffa','Update Data','Generating UUIDs for all rows in program_workflow_state table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-relationship','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10167,'EXECUTED','3:25e22c04ada4808cc31fd48f23703333','Update Data','Generating UUIDs for all rows in relationship table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-relationship_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10168,'EXECUTED','3:562ad77e9453595c9cd22a2cdde3cc41','Update Data','Generating UUIDs for all rows in relationship_type table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-report_object','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10169,'EXECUTED','3:8531f740c64a0d1605225536c1be0860','Update Data','Generating UUIDs for all rows in report_object table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10170,'EXECUTED','3:cd9efe4d62f2754b057d2d409d6e826a','Update Data','Generating UUIDs for all rows in report_schema_xml table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-role','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10171,'EXECUTED','3:f75bfc36ad13cb9324b9520804a60141','Update Data','Generating UUIDs for all rows in role table via built in uuid function.',NULL,'2.0.5'),('20090402-1516-serialized_object','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10172,'EXECUTED','3:c809b71d2444a8a8e2c5e5574d344c82','Update Data','Generating UUIDs for all rows in serialized_object table via built in uuid function.',NULL,'2.0.5'),('20090402-1517','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10181,'MARK_RAN','3:4edd135921eb263d4811cf1c22ef4846','Custom Change','Adding UUIDs to all rows in all columns via a java class. (This will take a long time on large databases)',NULL,'2.0.5'),('20090402-1518','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10182,'MARK_RAN','3:a9564fc8de85d37f4748a3fa1e69281c','Add Not-Null Constraint (x52)','Now that UUID generation is done, set the uuid columns to not \"NOT NULL\"',NULL,'2.0.5'),('20090402-1519-cohort','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10183,'EXECUTED','3:260c435f1cf3e3f01d953d630c7a578b','Create Index','Creating unique index on cohort.uuid column',NULL,'2.0.5'),('20090402-1519-concept','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:16',10184,'EXECUTED','3:9e363ee4b39e7fdfb547e3a51ad187c7','Create Index','Creating unique index on concept.uuid column',NULL,'2.0.5'),('20090402-1519-concept_answer','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:16',10185,'EXECUTED','3:34b049a3fd545928760968beb1e98e00','Create Index','Creating unique index on concept_answer.uuid column',NULL,'2.0.5'),('20090402-1519-concept_class','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:16',10186,'EXECUTED','3:0fc95dccef2343850adb1fe49d60f3c3','Create Index','Creating unique index on concept_class.uuid column',NULL,'2.0.5'),('20090402-1519-concept_datatype','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:16',10187,'EXECUTED','3:0cf065b0f780dc2eeca994628af49a34','Create Index','Creating unique index on concept_datatype.uuid column',NULL,'2.0.5'),('20090402-1519-concept_description','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:17',10188,'EXECUTED','3:16ce0ad6c3e37071bbfcaad744693d0f','Create Index','Creating unique index on concept_description.uuid column',NULL,'2.0.5'),('20090402-1519-concept_map','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10006,'MARK_RAN','3:b8a320c1d44ab94e785c9ae6c41378f3',NULL,NULL,NULL,NULL),('20090402-1519-concept_name','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:17',10189,'EXECUTED','3:0d5866c0d3eadc8df09b1a7c160508ca','Create Index','Creating unique index on concept_name.uuid column',NULL,'2.0.5'),('20090402-1519-concept_name_tag','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:17',10190,'EXECUTED','3:7ba597ec0fb5fbfba615ac97df642072','Create Index','Creating unique index on concept_name_tag.uuid column',NULL,'2.0.5'),('20090402-1519-concept_proposal','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:18',10191,'EXECUTED','3:79f9f4af9669c2b03511832a23db55e0','Create Index','Creating unique index on concept_proposal.uuid column',NULL,'2.0.5'),('20090402-1519-concept_set','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:18',10192,'EXECUTED','3:f5ba4e2d5ddd4ec66f43501b9749cf70','Create Index','Creating unique index on concept_set.uuid column',NULL,'2.0.5'),('20090402-1519-concept_source','bwolfe','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10007,'MARK_RAN','3:c7c47d9c2876bfa53542885e304b21e7',NULL,NULL,NULL,NULL),('20090402-1519-concept_state_conversion','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:18',10193,'EXECUTED','3:cc9d9bb0d5eb9f6583cd538919b42b9a','Create Index','Creating unique index on concept_state_conversion.uuid column',NULL,'2.0.5'),('20090402-1519-drug','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:18',10194,'EXECUTED','3:8cac800e9f857e29698e1c80ab7e6a52','Create Index','Creating unique index on drug.uuid column',NULL,'2.0.5'),('20090402-1519-encounter','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:19',10195,'EXECUTED','3:8fd623411a44ffb0d4e3a4139e916585','Create Index','Creating unique index on encounter.uuid column',NULL,'2.0.5'),('20090402-1519-encounter_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:19',10196,'EXECUTED','3:71e0e1df8c290d8b6e81e281154661e0','Create Index','Creating unique index on encounter_type.uuid column',NULL,'2.0.5'),('20090402-1519-field','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:19',10197,'EXECUTED','3:36d9eba3e0a90061c6bf1c8aa483110e','Create Index','Creating unique index on field.uuid column',NULL,'2.0.5'),('20090402-1519-field_answer','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:19',10198,'EXECUTED','3:81572b572f758cac173b5d14516f600e','Create Index','Creating unique index on field_answer.uuid column',NULL,'2.0.5'),('20090402-1519-field_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:20',10199,'EXECUTED','3:a0c3927dfde900959131aeb1490a5f51','Create Index','Creating unique index on field_type.uuid column',NULL,'2.0.5'),('20090402-1519-form','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:20',10200,'EXECUTED','3:61147c780ce563776a1caed795661aca','Create Index','Creating unique index on form.uuid column',NULL,'2.0.5'),('20090402-1519-form_field','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:20',10201,'EXECUTED','3:bd9def4522865d181e42809f9dd5c116','Create Index','Creating unique index on form_field.uuid column',NULL,'2.0.5'),('20090402-1519-global_property','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:20',10202,'EXECUTED','3:0e6b84ad5fffa3fd49242b5475e8eb66','Create Index','Creating unique index on global_property.uuid column',NULL,'2.0.5'),('20090402-1519-hl7_in_archive','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:21',10203,'EXECUTED','3:d2f8921c170e416560c234aa74964346','Create Index','Creating unique index on hl7_in_archive.uuid column',NULL,'2.0.5'),('20090402-1519-hl7_in_error','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:21',10204,'EXECUTED','3:9ccec0729ea1b4eaa5068726f9045c25','Create Index','Creating unique index on hl7_in_error.uuid column',NULL,'2.0.5'),('20090402-1519-hl7_in_queue','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:21',10205,'EXECUTED','3:af537cb4134c3f2ed0357f3280ceb6fe','Create Index','Creating unique index on hl7_in_queue.uuid column',NULL,'2.0.5'),('20090402-1519-hl7_source','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:22',10206,'EXECUTED','3:a6d1847b6a590319206f65be9d1d3c9e','Create Index','Creating unique index on hl7_source.uuid column',NULL,'2.0.5'),('20090402-1519-location','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:22',10207,'EXECUTED','3:c435bd4b405d4f11d919777718aa055c','Create Index','Creating unique index on location.uuid column',NULL,'2.0.5'),('20090402-1519-location_tag','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:22',10208,'EXECUTED','3:33a8a54cde59b23a9cdb7740a9995e1a','Create Index','Creating unique index on location_tag.uuid column',NULL,'2.0.5'),('20090402-1519-note','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:22',10209,'EXECUTED','3:97279b2ce285e56613a10a77c5af32b2','Create Index','Creating unique index on note.uuid column',NULL,'2.0.5'),('20090402-1519-notification_alert','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:23',10210,'EXECUTED','3:a763255eddf8607f7d86afbb3099d4b5','Create Index','Creating unique index on notification_alert.uuid column',NULL,'2.0.5'),('20090402-1519-notification_template','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:23',10211,'EXECUTED','3:9a69bbb343077bc62acdf6a66498029a','Create Index','Creating unique index on notification_template.uuid column',NULL,'2.0.5'),('20090402-1519-obs','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:23',10212,'EXECUTED','3:de9a7a24e527542e6b4a73e2cd31a7f9','Create Index','Creating unique index on obs.uuid column',NULL,'2.0.5'),('20090402-1519-orders','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:24',10214,'EXECUTED','3:848c0a00a32c5eb25041ad058fd38263','Create Index','Creating unique index on orders.uuid column',NULL,'2.0.5'),('20090402-1519-order_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:23',10213,'EXECUTED','3:d938d263e0acf974d43ad81d2fbe05b0','Create Index','Creating unique index on order_type.uuid column',NULL,'2.0.5'),('20090402-1519-patient_identifier','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:24',10215,'EXECUTED','3:43389efa06408c8312d130654309d140','Create Index','Creating unique index on patient_identifier.uuid column',NULL,'2.0.5'),('20090402-1519-patient_identifier_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:24',10216,'EXECUTED','3:3ffe4f31a1c48d2545e8eed4127cc490','Create Index','Creating unique index on patient_identifier_type.uuid column',NULL,'2.0.5'),('20090402-1519-patient_program','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:24',10217,'EXECUTED','3:ce69defda5ba254914f2319f3a7aac02','Create Index','Creating unique index on patient_program.uuid column',NULL,'2.0.5'),('20090402-1519-patient_state','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:25',10218,'EXECUTED','3:a4ca15f62b3c8c43f7f47ef8b9e39cd3','Create Index','Creating unique index on patient_state.uuid column',NULL,'2.0.5'),('20090402-1519-person','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:25',10219,'EXECUTED','3:345a5d4e8dea4d56c1a0784e7b35a801','Create Index','Creating unique index on person.uuid column',NULL,'2.0.5'),('20090402-1519-person_address','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:25',10220,'EXECUTED','3:105ece744a45b624ea8990f152bb8300','Create Index','Creating unique index on person_address.uuid column',NULL,'2.0.5'),('20090402-1519-person_attribute','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:25',10221,'EXECUTED','3:67a8cdda8605c28f76314873d2606457','Create Index','Creating unique index on person_attribute.uuid column',NULL,'2.0.5'),('20090402-1519-person_attribute_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:26',10222,'EXECUTED','3:a234ad0ea13f32fc4529cf556151d611','Create Index','Creating unique index on person_attribute_type.uuid column',NULL,'2.0.5'),('20090402-1519-person_name','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:26',10223,'EXECUTED','3:d18e326ce221b4b1232ce2e355731338','Create Index','Creating unique index on person_name.uuid column',NULL,'2.0.5'),('20090402-1519-privilege','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:26',10224,'EXECUTED','3:47e7f70f34a213d870e2aeed795d5e3d','Create Index','Creating unique index on privilege.uuid column',NULL,'2.0.5'),('20090402-1519-program','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:26',10225,'EXECUTED','3:62f9d9ecd2325d5908237a769e9a8bc7','Create Index','Creating unique index on program.uuid column',NULL,'2.0.5'),('20090402-1519-program_workflow','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:27',10226,'EXECUTED','3:fabb3152f6055dc0071a2e5d6f573d2f','Create Index','Creating unique index on program_workflow.uuid column',NULL,'2.0.5'),('20090402-1519-program_workflow_state','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:27',10227,'EXECUTED','3:4fdf0c20aedcdc87b2c6058a1cc8fce7','Create Index','Creating unique index on program_workflow_state.uuid column',NULL,'2.0.5'),('20090402-1519-relationship','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:27',10228,'EXECUTED','3:c90617ca900b1aef3f29e71f693e8a25','Create Index','Creating unique index on relationship.uuid column',NULL,'2.0.5'),('20090402-1519-relationship_type','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:27',10229,'EXECUTED','3:c9f05aca70b6dad54af121b593587a29','Create Index','Creating unique index on relationship_type.uuid column',NULL,'2.0.5'),('20090402-1519-report_object','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:28',10230,'EXECUTED','3:6069b78580fd0d276f5dae9f3bdf21be','Create Index','Creating unique index on report_object.uuid column',NULL,'2.0.5'),('20090402-1519-report_schema_xml','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:28',10231,'EXECUTED','3:91499d332dda0577fd02b6a6b7b35e99','Create Index','Creating unique index on report_schema_xml.uuid column',NULL,'2.0.5'),('20090402-1519-role','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:28',10232,'EXECUTED','3:c535a800ceb006311bbb7a27e8bab6ea','Create Index','Creating unique index on role.uuid column',NULL,'2.0.5'),('20090402-1519-serialized_object','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10233,'EXECUTED','3:e8f2b1c3a7a67aadc8499ebcb522c91a','Create Index','Creating unique index on serialized_object.uuid column',NULL,'2.0.5'),('20090408-1298','Cory McCarthy','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10068,'EXECUTED','3:defbd13a058ba3563e232c2093cd2b37','Modify Column','Changed the datatype for encounter_type to \'text\' instead of just 50 chars',NULL,'2.0.5'),('200904091023','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10067,'EXECUTED','3:48adc23e9c5d820a87f6c8d61dfb6b55','Delete Data (x4)','Remove Manage Tribes and View Tribes privileges from the privilege table and role_privilege table.\n			The privileges will be recreated by the Tribe module if it is installed.',NULL,'2.0.5'),('20090414-0804','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10173,'EXECUTED','3:479b4df8e3c746b5b96eeea422799774','Drop Foreign Key Constraint','Dropping foreign key on concept_set.concept_id table',NULL,'2.0.5'),('20090414-0805','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10174,'MARK_RAN','3:5017417439ff841eb036ceb94f3c5800','Drop Primary Key','Dropping primary key on concept set table',NULL,'2.0.5'),('20090414-0806','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10175,'MARK_RAN','3:6b9cec59fd607569228bf87d4dffa1a5','Add Column','Adding new integer primary key to concept set table',NULL,'2.0.5'),('20090414-0807','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:14',10176,'MARK_RAN','3:57834f6c953f34035237e06a2dbed9c7','Create Index, Add Foreign Key Constraint','Adding index and foreign key to concept_set.concept_id column',NULL,'2.0.5'),('20090414-0808a','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10177,'EXECUTED','3:6c9d9e6b85c1bf04fdbf9fdec316f2ea','Drop Foreign Key Constraint','Dropping foreign key on patient_identifier.patient_id column',NULL,'2.0.5'),('20090414-0808b','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10178,'MARK_RAN','3:12e01363841135ed0dae46d71e7694cf','Drop Primary Key','Dropping non-integer primary key on patient identifier table before adding a new integer primary key',NULL,'2.0.5'),('20090414-0809','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10179,'MARK_RAN','3:864765efa4cae1c8ffb1138d63f77017','Add Column','Adding new integer primary key to patient identifier table',NULL,'2.0.5'),('20090414-0810','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:15',10180,'MARK_RAN','3:4ca46ee358567e35c897a73c065e3367','Create Index, Add Foreign Key Constraint','Adding index and foreign key on patient_identifier.patient_id column',NULL,'2.0.5'),('20090414-0811a','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10234,'EXECUTED','3:f027a0ad38c0f6302def391da78aaaee','Drop Foreign Key Constraint','Dropping foreign key on concept_word.concept_id column',NULL,'2.0.5'),('20090414-0811b','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10236,'MARK_RAN','3:982d502e56854922542286cead4c09ce','Drop Primary Key','Dropping non-integer primary key on concept word table before adding new integer one',NULL,'2.0.5'),('20090414-0812','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10237,'MARK_RAN','3:948e635fe3f63122856ca9b8a174352b','Add Column','Adding integer primary key to concept word table',NULL,'2.0.5'),('20090414-0812b','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10238,'MARK_RAN','3:bd7731e58f3db9b944905597a08eb6cb','Add Foreign Key Constraint','Re-adding foreign key for concept_word.concept_name_id',NULL,'2.0.5'),('200904271042','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10241,'MARK_RAN','3:db63ce704aff4741c52181d1c825ab62','Drop Column','Remove the now unused synonym column',NULL,'2.0.5'),('20090428-0811aa','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10235,'MARK_RAN','3:58d8f3df1fe704714a7b4957a6c0e7f7','Drop Foreign Key Constraint','Removing concept_word.concept_name_id foreign key so that primary key can be changed to concept_word_id',NULL,'2.0.5'),('20090428-0854','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10239,'EXECUTED','3:11086a37155507c0238c9532f66b172b','Add Foreign Key Constraint','Adding foreign key for concept_word.concept_id column',NULL,'2.0.5'),('200905071626','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:13',10070,'MARK_RAN','3:d29884c3ef8fd867c3c2ffbd557c14c2','Create Index','Add an index to the concept_word.concept_id column (This update may fail if it already exists)',NULL,'2.0.5'),('200905150814','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:12',10069,'EXECUTED','3:44c729b393232d702553e0768cf94994','Delete Data','Deleting invalid concept words',NULL,'2.0.5'),('200905150821','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10240,'EXECUTED','3:c0b7abc7eb00f243325b4a3fb2afc614','Custom SQL','Deleting duplicate concept word keys',NULL,'2.0.5'),('200906301606','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10244,'EXECUTED','3:de40c56c128997509d1d943ed047c5d2','Modify Column','Change person_attribute_type.sort_weight from an integer to a float',NULL,'2.0.5'),('200907161638-1','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10245,'EXECUTED','3:dfd352bdc4c5e6c88cd040d03c782e31','Modify Column','Change obs.value_numeric from a double(22,0) to a double',NULL,'2.0.5'),('200907161638-2','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10246,'EXECUTED','3:a8dc0bd1593e6c99a02db443bc4cb001','Modify Column','Change concept_numeric columns from a double(22,0) type to a double',NULL,'2.0.5'),('200907161638-3','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10247,'EXECUTED','3:47b8adbcd480660765dd117020a1e085','Modify Column','Change concept_set.sort_weight from a double(22,0) to a double',NULL,'2.0.5'),('200907161638-4','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10248,'EXECUTED','3:3ffccaa291298fea317eb7025c058492','Modify Column','Change concept_set_derived.sort_weight from a double(22,0) to a double',NULL,'2.0.5'),('200907161638-5','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10249,'EXECUTED','3:3b31cf625830c7e37fa638dbf9625000','Modify Column','Change drug table columns from a double(22,0) to a double',NULL,'2.0.5'),('200907161638-6','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10250,'EXECUTED','3:dc733faec1539038854c0b559b45da0e','Modify Column','Change drug_order.dose from a double(22,0) to a double',NULL,'2.0.5'),('200908291938-1','dthomas','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10008,'MARK_RAN','3:b99a6d7349d367c30e8b404979e07b89',NULL,NULL,NULL,NULL),('200908291938-2a','dthomas','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10009,'MARK_RAN','3:7e9e8d9bffcb6e602b155827f72a3856',NULL,NULL,NULL,NULL),('20090831-1039-38-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10254,'MARK_RAN','3:54e254379235d5c8b569a00ac7dc9c3f','Add Column','Adding \"uuid\" column to scheduler_task_config table',NULL,'2.0.5'),('20090831-1040-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10255,'EXECUTED','3:a9b26bdab35405050c052a9a3f763db0','Update Data','Generating UUIDs for all rows in scheduler_task_config table via built in uuid function.',NULL,'2.0.5'),('20090831-1041-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10256,'MARK_RAN','3:25127273b2d501664ce325922b0c7db2','Custom Change','Adding UUIDs to all rows in scheduler_task_config table via a java class for non mysql/oracle/mssql databases.',NULL,'2.0.5'),('20090831-1042-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10257,'EXECUTED','3:76d8a8b5d342fc4111034861537315cf','Add Not-Null Constraint','Now that UUID generation is done for scheduler_task_config, set the uuid column to not \"NOT NULL\"',NULL,'2.0.5'),('20090831-1043-scheduler_task_config','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10258,'EXECUTED','3:5408ed04284c4f5d57f5160ca5393733','Create Index','Creating unique index on scheduler_task_config.uuid column',NULL,'2.0.5'),('20090907-1','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10259,'MARK_RAN','3:d6f3ed289cdbce6229b1414ec626a33c','Rename Column','Rename the concept_source.date_voided column to date_retired',NULL,'2.0.5'),('20090907-2a','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10260,'MARK_RAN','3:b71e307e4e782cc5a851f764aa7fc0d0','Drop Foreign Key Constraint','Remove the concept_source.voided_by foreign key constraint',NULL,'2.0.5'),('20090907-2b','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10261,'MARK_RAN','3:14e07ebc0a1138ee973bbb26b568d16e','Rename Column, Add Foreign Key Constraint','Rename the concept_source.voided_by column to retired_by',NULL,'2.0.5'),('20090907-3','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10262,'MARK_RAN','3:adee9ced82158f9a9f3d64245ad591c6','Rename Column','Rename the concept_source.voided column to retired',NULL,'2.0.5'),('20090907-4','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10263,'MARK_RAN','3:ad9b6ed4ef3ae43556d3e8c9e2ec0f5c','Rename Column','Rename the concept_source.void_reason column to retire_reason',NULL,'2.0.5'),('20091001-1023','rcrichton','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10291,'MARK_RAN','3:2bf99392005da4e95178bd1e2c28a87b','Add Column','add retired column to relationship_type table',NULL,'2.0.5'),('20091001-1024','rcrichton','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10292,'MARK_RAN','3:31b7b10f75047606406cea156bcc255f','Add Column','add retired_by column to relationship_type table',NULL,'2.0.5'),('20091001-1025','rcrichton','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10293,'MARK_RAN','3:c6dd75893e5573baa0c7426ecccaa92d','Add Foreign Key Constraint','Create the foreign key from the relationship.retired_by to users.user_id.',NULL,'2.0.5'),('20091001-1026','rcrichton','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10294,'MARK_RAN','3:47cfbab54a8049948784a165ffe830af','Add Column','add date_retired column to relationship_type table',NULL,'2.0.5'),('20091001-1027','rcrichton','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10295,'MARK_RAN','3:2db32da70ac1e319909d692110b8654b','Add Column','add retire_reason column to relationship_type table',NULL,'2.0.5'),('200910271049-1','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10264,'EXECUTED','3:2e54d97b9f1b9f35b77cee691c23b7a9','Update Data (x5)','Setting core field types to have standard UUIDs',NULL,'2.0.5'),('200910271049-10','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10273,'EXECUTED','3:827070940f217296c11ce332dc8858ff','Update Data (x4)','Setting core roles to have standard UUIDs',NULL,'2.0.5'),('200910271049-2','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10265,'EXECUTED','3:3132d4cbfaab0c0b612c3fe1c55bd0f1','Update Data (x7)','Setting core person attribute types to have standard UUIDs',NULL,'2.0.5'),('200910271049-3','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10266,'EXECUTED','3:f4d1a9004f91b6885a86419bc02f9d0b','Update Data (x4)','Setting core encounter types to have standard UUIDs',NULL,'2.0.5'),('200910271049-4','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10267,'EXECUTED','3:0d4f7503bf8f00cb73338bb34305333a','Update Data (x12)','Setting core concept datatypes to have standard UUIDs',NULL,'2.0.5'),('200910271049-5','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10268,'EXECUTED','3:98d8ac75977e1b099a4e45d96c6b1d1a','Update Data (x4)','Setting core relationship types to have standard UUIDs',NULL,'2.0.5'),('200910271049-6','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10269,'EXECUTED','3:19355a03794869edad3889ac0adbdedf','Update Data (x15)','Setting core concept classes to have standard UUIDs',NULL,'2.0.5'),('200910271049-7','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10270,'EXECUTED','3:fe4c89654d02d74de6d8e4b265a33288','Update Data (x2)','Setting core patient identifier types to have standard UUIDs',NULL,'2.0.5'),('200910271049-8','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10271,'EXECUTED','3:dc4462b5b4b13c2bc306506848127556','Update Data','Setting core location to have standard UUIDs',NULL,'2.0.5'),('200910271049-9','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10272,'EXECUTED','3:de2a0ed2adafb53f025039e9e8c6719e','Update Data','Setting core hl7 source to have standard UUIDs',NULL,'2.0.5'),('200912031842','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10277,'EXECUTED','3:b966745213bedaeeabab8a874084bb95','Drop Foreign Key Constraint, Add Foreign Key Constraint','Changing encounter.provider_id to reference person instead of users',NULL,'2.0.5'),('200912031846-1','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10279,'MARK_RAN','3:23e728a7f214127cb91efd40ebbcc2d1','Add Column, Update Data','Adding person_id column to users table (if needed)',NULL,'2.0.5'),('200912031846-2','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10280,'MARK_RAN','3:8d57907defa7e92e018038d57cfa78b4','Update Data, Add Not-Null Constraint','Populating users.person_id',NULL,'2.0.5'),('200912031846-3','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10281,'EXECUTED','3:48a50742f2904682caa1bc469f5b87e3','Add Foreign Key Constraint, Set Column as Auto-Increment','Restoring foreign key constraint on users.person_id',NULL,'2.0.5'),('200912071501-1','arthurs','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10274,'EXECUTED','3:d1158b8a42127d7b8a4d5ad64cc7c225','Update Data','Change name for patient.searchMaxResults global property to person.searchMaxResults',NULL,'2.0.5'),('200912091819','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10282,'MARK_RAN','3:8c0b2b02a94b9c6c9529e1b29207464b','Add Column, Add Foreign Key Constraint','Adding retired metadata columns to users table',NULL,'2.0.5'),('200912091819-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10283,'EXECUTED','3:fd5fd1d2e6884662824bb78c8348fadf','Modify Column','(Fixed)users.retired to BOOLEAN',NULL,'2.0.5'),('200912091820','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10284,'MARK_RAN','3:cba73499d1c4d09b0e4ae3b55ecc7d84','Update Data','Migrating voided metadata to retired metadata for users table',NULL,'2.0.5'),('200912091821','djazayeri','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10012,'MARK_RAN','3:9b38d31ebfe427d1f8d6e8530687f29c',NULL,NULL,NULL,NULL),('200912140038','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10285,'MARK_RAN','3:be3aaa8da16b8a8841509faaeff070b4','Add Column','Adding \"uuid\" column to users table',NULL,'2.0.5'),('200912140039','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10286,'EXECUTED','3:5b2a81ac1efba5495962bfb86e51546d','Update Data','Generating UUIDs for all rows in users table via built in uuid function.',NULL,'2.0.5'),('200912140040','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10287,'MARK_RAN','3:c422b96e5b88eeae4f343d4f988cc4b2','Custom Change','Adding UUIDs to users table via a java class. (This will take a long time on large databases)',NULL,'2.0.5'),('200912141000-drug-add-date-changed','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10479,'MARK_RAN','3:9c9a75e3a78104e72de078ac217b0972','Add Column','Add date_changed column to drug table',NULL,'2.0.5'),('200912141001-drug-add-changed-by','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10480,'MARK_RAN','3:196629c722f52df68b5040e5266ac20f','Add Column, Add Foreign Key Constraint','Add changed_by column to drug table',NULL,'2.0.5'),('200912141552','madanmohan','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10275,'MARK_RAN','3:835b6b98a7a437d959255ac666c12759','Add Column, Add Foreign Key Constraint','Add changed_by column to encounter table',NULL,'2.0.5'),('200912141553','madanmohan','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10276,'MARK_RAN','3:7f768aa879beac091501ac9bb47ece4d','Add Column','Add date_changed column to encounter table',NULL,'2.0.5'),('20091215-0208','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10296,'EXECUTED','3:1c818a60d8ebc36f4b7911051c1f6764','Custom SQL','Prune concepts rows orphaned in concept_numeric tables',NULL,'2.0.5'),('20091215-0209','jmiranda','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10297,'EXECUTED','3:adeadc55e4dd484b1d63cf123e299371','Custom SQL','Prune concepts rows orphaned in concept_complex tables',NULL,'2.0.5'),('20091215-0210','jmiranda','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10011,'MARK_RAN','3:08e8550629e4d5938494500f61d10961',NULL,NULL,NULL,NULL),('200912151032','n.nehete','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10289,'EXECUTED','3:d7d8fededde8a27384ca1eb3f87f7914','Add Not-Null Constraint','Encounter Type should not be null when saving an Encounter',NULL,'2.0.5'),('200912211118','nribeka','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10010,'MARK_RAN','3:1f976b4eedf537d887451246d49db043',NULL,NULL,NULL,NULL),('201001072007','upul','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10290,'MARK_RAN','3:d5d60060fae8e9c30843b16b23bed9db','Add Column','Add last execution time column to scheduler_task_config table',NULL,'2.0.5'),('20100111-0111-associating-daemon-user-with-person','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10462,'MARK_RAN','3:bebb5c508bb53e7d5be6fb3aa259bd2f','Custom SQL','Associating daemon user with a person',NULL,'2.0.5'),('20100128-1','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10251,'MARK_RAN','3:eaa1b8e62aa32654480e7a476dc14a4a','Insert Row','Adding \'System Developer\' role again (see ticket #1499)',NULL,'2.0.5'),('20100128-2','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10252,'MARK_RAN','3:3c486c2ea731dfad7905518cac8d6e70','Update Data','Switching users back from \'Administrator\' to \'System Developer\' (see ticket #1499)',NULL,'2.0.5'),('20100128-3','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:29',10253,'MARK_RAN','3:9acf8cae5d210f88006191e79b76532c','Delete Data','Deleting \'Administrator\' role (see ticket #1499)',NULL,'2.0.5'),('20100306-095513a','thilini.hg','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10298,'MARK_RAN','3:b7a60c3c33a05a71dde5a26f35d85851','Drop Foreign Key Constraint','Dropping unused foreign key from notification alert table',NULL,'2.0.5'),('20100306-095513b','thilini.hg','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10299,'MARK_RAN','3:8a6ebb6aefe04b470d5b3878485f9cc3','Drop Column','Dropping unused user_id column from notification alert table',NULL,'2.0.5'),('20100322-0908','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10300,'MARK_RAN','3:94a8aae1d463754d7125cd546b4c590c','Add Column, Update Data','Adding sort_weight column to concept_answers table and initially sets the sort_weight to the concept_answer_id',NULL,'2.0.5'),('20100323-192043','ricardosbarbosa','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10317,'EXECUTED','3:c294c84ac7ff884d1e618f4eb74b0c52','Update Data, Delete Data (x2)','Removing the duplicate privilege \'Add Concept Proposal\' in favor of \'Add Concept Proposals\'',NULL,'2.0.5'),('20100330-190413','ricardosbarbosa','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10318,'EXECUTED','3:d706294defdfb73af9b44db7d37069d0','Update Data, Delete Data (x2)','Removing the duplicate privilege \'Edit Concept Proposal\' in favor of \'Edit Concept Proposals\'',NULL,'2.0.5'),('20100412-2217','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10301,'MARK_RAN','3:0c3a3ea15adefa620ab62145f412d0b6','Add Column','Adding \"uuid\" column to notification_alert_recipient table',NULL,'2.0.5'),('20100412-2218','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10302,'EXECUTED','3:6fae383b5548c214d2ad2c76346e32e3','Update Data','Generating UUIDs for all rows in notification_alert_recipient table via built in uuid function.',NULL,'2.0.5'),('20100412-2219','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10303,'MARK_RAN','3:1401fe5f2d0c6bc23afa70b162e15346','Custom Change','Adding UUIDs to notification_alert_recipient table via a java class (if needed).',NULL,'2.0.5'),('20100412-2220','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10304,'EXECUTED','3:bf4474dd5700b570e158ddc8250c470b','Add Not-Null Constraint','Now that UUID generation is done, set the notification_alert_recipient.uuid column to not \"NOT NULL\"',NULL,'2.0.5'),('20100413-1509','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10305,'MARK_RAN','3:7a3ee61077e4dee1ceb4fe127afc835f','Rename Column','Change location_tag.tag to location_tag.name',NULL,'2.0.5'),('20100415-forgotten-from-before','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10288,'EXECUTED','3:d17699fbec80bd035ecb348ae5382754','Add Not-Null Constraint','Adding not null constraint to users.uuid',NULL,'2.0.5'),('20100419-1209','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10385,'MARK_RAN','3:f87b773f9a8e05892fdbe8740042abb5','Create Table, Add Foreign Key Constraint (x7), Create Index','Create the visit table and add the foreign key for visit_type',NULL,'2.0.5'),('20100419-1209-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10386,'EXECUTED','3:cb5970216f918522df3a059e29506c27','Modify Column','(Fixed)Changed visit.voided to BOOLEAN',NULL,'2.0.5'),('20100423-1402','slorenz','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10307,'MARK_RAN','3:3534020f1c68f70b0e9851d47a4874d6','Create Index','Add an index to the encounter.encounter_datetime column to speed up statistical\n			analysis.',NULL,'2.0.5'),('20100423-1406','slorenz','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10308,'MARK_RAN','3:f058162398862f0bdebc12d7eb54551b','Create Index','Add an index to the obs.obs_datetime column to speed up statistical analysis.',NULL,'2.0.5'),('20100426-1111-add-not-null-personid-contraint','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10463,'EXECUTED','3:a0b90b98be85aabbdebd957744ab805a','Add Not-Null Constraint','Add the not null person id contraint',NULL,'2.0.5'),('20100426-1111-remove-not-null-personid-contraint','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10309,'EXECUTED','3:5bc2abe108ab2765e36294ff465c63a0','Drop Not-Null Constraint','Drop the not null person id contraint',NULL,'2.0.5'),('20100426-1947','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10310,'MARK_RAN','3:09adbdc9cb72dee82e67080b01d6578e','Insert Row','Adding daemon user to users table',NULL,'2.0.5'),('20100512-1400','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10312,'MARK_RAN','3:0fbfb53e2e194543d7b3eaa59834e1e6','Insert Row','Create core order_type for drug orders',NULL,'2.0.5'),('20100513-1947','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10311,'EXECUTED','3:068c2bd55d9c731941fe9ef66f0011fb','Delete Data (x2)','Removing scheduler.username and scheduler.password global properties',NULL,'2.0.5'),('20100517-1545','wyclif and djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10313,'EXECUTED','3:39a68e6b1954a0954d0f8d0c660a7aff','Custom Change','Switch boolean concepts/observations to be stored as coded',NULL,'2.0.5'),('20100525-818-1','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10319,'MARK_RAN','3:ed9dcb5bd0d7312db3123825f9bb4347','Create Table, Add Foreign Key Constraint (x2)','Create active list type table.',NULL,'2.0.5'),('20100525-818-1-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10320,'EXECUTED','3:4a648a54797fef2222764a7ee0b5e05a','Modify Column','(Fixed)Change active_list_type.retired to BOOLEAN',NULL,'2.0.5'),('20100525-818-2','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10321,'MARK_RAN','3:bc5a86f0245f6f822a0d343b2fcf8dc6','Create Table, Add Foreign Key Constraint (x7)','Create active list table',NULL,'2.0.5'),('20100525-818-2-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10322,'EXECUTED','3:0a2879b368319f6d1e16d0d4417f4492','Modify Column','(Fixed)Change active_list_type.retired to BOOLEAN',NULL,'2.0.5'),('20100525-818-3','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10323,'MARK_RAN','3:d382e7b9e23cdcc33ccde2d3f0473c41','Create Table, Add Foreign Key Constraint','Create allergen table',NULL,'2.0.5'),('20100525-818-4','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10324,'MARK_RAN','3:1d6f1abd297c8da5a49d4885d0d34dfb','Create Table','Create problem table',NULL,'2.0.5'),('20100525-818-5','syhaas','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10325,'MARK_RAN','3:2ac51b2e8813d61428367bad9fadaa33','Insert Row (x2)','Inserting default active list types',NULL,'2.0.5'),('20100526-1025','Harsha.cse','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10314,'EXECUTED','3:66ec6553564d30fd63df7c2de41c674f','Drop Not-Null Constraint (x2)','Drop Not-Null constraint from location column in Encounter and Obs table',NULL,'2.0.5'),('20100603-1625-1-person_address','sapna','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10366,'MARK_RAN','3:6048aa2c393c1349de55a5003199fb81','Add Column','Adding \"date_changed\" column to person_address table',NULL,'2.0.5'),('20100603-1625-2-person_address','sapna','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10367,'MARK_RAN','3:5194e3b45b70b003e33d7ab0495f3015','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to person_address table',NULL,'2.0.5'),('20100604-0933a','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10315,'EXECUTED','3:9b51b236846a8940de581e199cd76cb2','Add Default Value','Changing the default value to 2 for \'message_state\' column in \'hl7_in_archive\' table',NULL,'2.0.5'),('20100604-0933b','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10316,'EXECUTED','3:67fc4c12418b500aaf3723e8845429e3','Update Data','Converting 0 and 1 to 2 for \'message_state\' column in \'hl7_in_archive\' table',NULL,'2.0.5'),('20100607-1550a','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10326,'MARK_RAN','3:bfb6250277efd8c81326fe8c3dbdfe35','Add Column','Adding \'concept_name_type\' column to concept_name table',NULL,'2.0.5'),('20100607-1550b','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10327,'MARK_RAN','3:3d43124d8265fbf05f1ef4839f14bece','Add Column','Adding \'locale_preferred\' column to concept_name table',NULL,'2.0.5'),('20100607-1550b-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10328,'EXECUTED','3:d0dc8dfe3ac629aecee81ccc11dec9c2','Modify Column','(Fixed)Change concept_name.locale_preferred to BOOLEAN',NULL,'2.0.5'),('20100607-1550c','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10329,'EXECUTED','3:b6573617d37609ae7195fd7a495e2776','Drop Foreign Key Constraint','Dropping foreign key constraint on concept_name_tag_map.concept_name_tag_id',NULL,'2.0.5'),('20100607-1550d','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10330,'EXECUTED','3:f30fd17874ac8294389ee2a44ca7d6ab','Update Data, Delete Data (x2)','Setting the concept name type for short names',NULL,'2.0.5'),('20100607-1550f','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10331,'EXECUTED','3:74026cd4543ebbf561999a81c276224d','Update Data, Delete Data (x2)','Converting concept names with \'preferred\' and \'preferred_XX\' concept name tags to preferred names',NULL,'2.0.5'),('20100607-1550g','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10334,'EXECUTED','3:c3c0a17e0a21d36f38bb2af8f0939da7','Delete Data (x2)','Deleting \'default\' and \'synonym\' concept name tags',NULL,'2.0.5'),('20100607-1550h','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10335,'EXECUTED','3:be7b967ed0e7006373bb616b63726144','Custom Change','Validating and attempting to fix invalid concepts and ConceptNames',NULL,'2.0.5'),('20100607-1550i','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10336,'EXECUTED','3:b6260c13bf055f7917c155596502a24b','Add Foreign Key Constraint','Restoring foreign key constraint on concept_name_tag_map.concept_name_tag_id',NULL,'2.0.5'),('20100621-1443','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10337,'EXECUTED','3:16b4bc3512029cf8d3b3c6bee86ed712','Modify Column','Modify the error_details column of hl7_in_error to hold\n			stacktraces',NULL,'2.0.5'),('201008021047','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10338,'MARK_RAN','3:8612ede2553aab53950fa43d2f8def32','Create Index','Add an index to the person_name.family_name2 to speed up patient and person searches',NULL,'2.0.5'),('201008201345','mseaton','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10339,'EXECUTED','3:5fbbb6215e66847c86483ee7177c3682','Custom Change','Validates Program Workflow States for possible configuration problems and reports warnings',NULL,'2.0.5'),('201008242121','misha680','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10340,'EXECUTED','3:2319aed08c4f6dcd43d4ace5cdf94650','Modify Column','Make person_name.person_id not NULLable',NULL,'2.0.5'),('20100924-1110','mseaton','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10341,'MARK_RAN','3:05ea5f3b806ba47f4a749d3a348c59f7','Add Column, Add Foreign Key Constraint','Add location_id column to patient_program table',NULL,'2.0.5'),('201009281047','misha680','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10342,'MARK_RAN','3:02b5b9a183729968cd4189798ca034bd','Drop Column','Remove the now unused default_charge column',NULL,'2.0.5'),('201010051745','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10343,'EXECUTED','3:04ba6f526a71fc0a2b016fd77eaf9ff5','Update Data','Setting the global property \'patient.identifierRegex\' to an empty string',NULL,'2.0.5'),('201010051746','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10344,'EXECUTED','3:cb12dfc563d82529de170ffedf948f90','Update Data','Setting the global property \'patient.identifierSuffix\' to an empty string',NULL,'2.0.5'),('201010151054','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:33',10345,'MARK_RAN','3:26c8ae0c53225f82d4c2a85c09ad9785','Create Index','Adding index to form.published column',NULL,'2.0.5'),('201010151055','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10346,'MARK_RAN','3:1efabdfd082ff2b0a34f570831f74ce5','Create Index','Adding index to form.retired column',NULL,'2.0.5'),('201010151056','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10347,'MARK_RAN','3:00273104184bb4d2bb7155befc77efc3','Create Index','Adding multi column index on form.published and form.retired columns',NULL,'2.0.5'),('201010261143','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10348,'MARK_RAN','3:c02de7e2726893f80ecd1f3ae778cba5','Rename Column','Rename neighborhood_cell column to address3 and increase the size to 255 characters',NULL,'2.0.5'),('201010261145','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10349,'MARK_RAN','3:2d053c2e9b604403df8a408a6bb4f3f8','Rename Column','Rename township_division column to address4 and increase the size to 255 characters',NULL,'2.0.5'),('201010261147','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10350,'MARK_RAN','3:592eee2241fdb1039ba08be07b54a422','Rename Column','Rename subregion column to address5 and increase the size to 255 characters',NULL,'2.0.5'),('201010261149','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10351,'MARK_RAN','3:059e5bf4092d930304f9f0fc305939d9','Rename Column','Rename region column to address6 and increase the size to 255 characters',NULL,'2.0.5'),('201010261151','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10352,'MARK_RAN','3:8756b20f505f8981a43ece7233ce3e2f','Rename Column','Rename neighborhood_cell column to address3 and increase the size to 255 characters',NULL,'2.0.5'),('201010261153','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10353,'MARK_RAN','3:9805b9a214fca5a3509a82864274678e','Rename Column','Rename township_division column to address4 and increase the size to 255 characters',NULL,'2.0.5'),('201010261156','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10354,'MARK_RAN','3:894f4e47fbdc74be94e6ebc9d6fce91e','Rename Column','Rename subregion column to address5 and increase the size to 255 characters',NULL,'2.0.5'),('201010261159','crecabarren','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10355,'MARK_RAN','3:b1827790c63813e6a73d83e2b2d36504','Rename Column','Rename region column to address6 and increase the size to 255 characters',NULL,'2.0.5'),('20101029-1016','gobi/prasann','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10368,'MARK_RAN','3:714ad65f5d84bdcd4d944a4d5583e4d3','Create Table, Add Unique Constraint','Create table to store concept stop words to avoid in search key indexing',NULL,'2.0.5'),('20101029-1026','gobi/prasann','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10369,'MARK_RAN','3:83534d43a9a9cc1ea3a80f1d5f5570af','Insert Row (x10)','Inserting the initial concept stop words',NULL,'2.0.5'),('201011011600','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10357,'MARK_RAN','3:29b35d66dc4168e03e1844296e309327','Create Index','Adding index to message_state column in HL7 archive table',NULL,'2.0.5'),('201011011605','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10358,'EXECUTED','3:c604bc0967765f50145f76e80a4bbc99','Custom Change','Moving \"deleted\" HL7s from HL7 archive table to queue table',NULL,'2.0.5'),('201011051300','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10365,'MARK_RAN','3:fea4ad8ce44911eeaab8ac8c1cc9122d','Create Index','Adding index on notification_alert.date_to_expire column',NULL,'2.0.5'),('201012081716','nribeka','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10363,'MARK_RAN','3:4a97a93f2632fc0c3b088b24535ee481','Delete Data','Removing concept that are concept derived and the datatype',NULL,'2.0.5'),('201012081717','nribeka','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10364,'MARK_RAN','3:ad3d0a18bda7e4869d264c70b8cd8d1d','Drop Table','Removing concept derived tables',NULL,'2.0.5'),('20101209-10000-encounter-add-visit-id-column','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10387,'MARK_RAN','3:7045a94731ef25e04724c77fc97494b4','Add Column, Add Foreign Key Constraint','Adding visit_id column to encounter table',NULL,'2.0.5'),('20101209-1353','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10491,'MARK_RAN','3:9d30d1435a6c10a4b135609dc8e925ca','Add Not-Null Constraint','Adding not-null constraint to orders.as_needed',NULL,'2.0.5'),('20101209-1721','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10359,'MARK_RAN','3:351460e0f822555b77acff1a89bec267','Add Column','Add \'weight\' column to concept_word table',NULL,'2.0.5'),('20101209-1722','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10360,'MARK_RAN','3:d63107017bdcef0e28d7ad5e4df21ae5','Create Index','Adding index to concept_word.weight column',NULL,'2.0.5'),('20101209-1723','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10361,'MARK_RAN','3:25d45d7d5bbff4b24bcc8ff8d34d70d2','Insert Row','Insert a row into the schedule_task_config table for the ConceptIndexUpdateTask',NULL,'2.0.5'),('20101209-1731','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10362,'MARK_RAN','3:6de3e859f77856fe939d3ae6a73b4752','Update Data','Setting the value of \'start_on_startup\' to trigger off conceptIndexUpdateTask on startup',NULL,'2.0.5'),('201012092009','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:34',10356,'EXECUTED','3:15a029c4ffe65710a56d402e608d319a','Modify Column (x10)','Increasing length of address fields in person_address and location to 255',NULL,'2.0.5'),('2011-07-12-1947-add-outcomesConcept-to-program','grwarren','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10398,'MARK_RAN','3:ea2bb0a2ddeade662f956ef113d020ab','Add Column, Add Foreign Key Constraint','Adding the outcomesConcept property to Program',NULL,'2.0.5'),('2011-07-12-2005-add-outcome-to-patientprogram','grwarren','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10399,'MARK_RAN','3:57baf47f9b09b3df649742d69be32015','Add Column, Add Foreign Key Constraint','Adding the outcome property to PatientProgram',NULL,'2.0.5'),('201101121434','gbalaji,gobi','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10378,'MARK_RAN','3:96320c51e6e296e9dc65866a61268e45','Drop Column','Dropping unused date_started column from obs table',NULL,'2.0.5'),('201101221453','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10377,'EXECUTED','3:4088d4906026cc1430fa98e04d294b13','Modify Column','Increasing the serialized_data column of serialized_object to hold mediumtext',NULL,'2.0.5'),('20110124-1030','surangak','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10380,'MARK_RAN','3:e17eee5b8c4bb236a0ea6e6ade5abed7','Add Foreign Key Constraint','Adding correct foreign key for concept_answer.answer_drug',NULL,'2.0.5'),('20110125-1435','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10371,'MARK_RAN','3:dadd9da1dad5f2863f8f6bb24b29d598','Add Column','Adding \'start_date\' column to person_address table',NULL,'2.0.5'),('20110125-1436','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10372,'MARK_RAN','3:68cec89409d2419fe9439f4753a23036','Add Column','Adding \'end_date\' column to person_address table',NULL,'2.0.5'),('201101271456-add-enddate-to-relationship','misha680','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10389,'MARK_RAN','3:b593b864d4a870e3b7ba6b61fda57c8d','Add Column','Adding the end_date column to relationship.',NULL,'2.0.5'),('201101271456-add-startdate-to-relationship','misha680','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10388,'MARK_RAN','3:82020a9f33747f58274196619439781e','Add Column','Adding the start_date column to relationship.',NULL,'2.0.5'),('20110201-1625-1','arahulkmit','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10373,'MARK_RAN','3:4f1b23efba67de1917e312942fe7e744','Add Column','Adding \"date_changed\" column to patient_identifier table',NULL,'2.0.5'),('20110201-1625-2','arahulkmit','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10374,'MARK_RAN','3:01467a1db56ef3db87dc537d40ab22eb','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to patient_identifier table',NULL,'2.0.5'),('20110201-1626-1','arahulkmit','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10375,'MARK_RAN','3:63397ce933d1c78309648425fba66a17','Add Column','Adding \"date_changed\" column to relationship table',NULL,'2.0.5'),('20110201-1626-2','arahulkmit','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10376,'MARK_RAN','3:21dae026e42d05b2ebc8fe51408c147f','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to relationship table',NULL,'2.0.5'),('201102081800','gbalaji,gobi','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10379,'MARK_RAN','3:779ca58f39b4e3a14a313f8fc416c242','Drop Column','Dropping unused date_stopped column from obs table',NULL,'2.0.5'),('20110218-1206','rubailly','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10013,'MARK_RAN','3:8be61726cd3fed87215557efd284434f',NULL,NULL,NULL,NULL),('20110218-1210','rubailly','liquibase-update-to-latest.xml','2011-09-15 00:00:00',10013,'MARK_RAN','3:4f8818ba08f3a9ce2e2ededfdf5b6fcd',NULL,NULL,NULL,NULL),('201102280948','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:30',10278,'EXECUTED','3:98e1075808582c97377651d02faf8f46','Drop Foreign Key Constraint','Removing the foreign key from users.user_id to person.person_id if it still exists',NULL,'2.0.5'),('20110301-1030a','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10413,'MARK_RAN','3:5256e8010fb4c375e2a1ef502176cc2f','Rename Table','Renaming the concept_source table to concept_reference_source',NULL,'2.0.5'),('20110301-1030b','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10414,'MARK_RAN','3:6fc5f514cd9c2ee14481a7f0b10a0c7c','Create Table, Add Foreign Key Constraint (x4)','Adding concept_reference_term table',NULL,'2.0.5'),('20110301-1030b-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10415,'EXECUTED','3:3cf3ba141e6571b900e695b49b6c48a9','Modify Column','(Fixed)Change concept_reference_term.retired to BOOLEAN',NULL,'2.0.5'),('20110301-1030c','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10416,'MARK_RAN','3:d8407baf728a1db5ad5db7c138cb59cb','Create Table, Add Foreign Key Constraint (x3)','Adding concept_map_type table',NULL,'2.0.5'),('20110301-1030c-fix','sunbiz','liquibase-update-to-latest.xml','2011-09-19 00:00:00',10014,'MARK_RAN','3:c02f2825633f1a43fc9303ac21ba2c02',NULL,NULL,NULL,NULL),('20110301-1030d','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10417,'MARK_RAN','3:222ef47c65625a17c268a8f68edaa16e','Rename Table','Renaming the concept_map table to concept_reference_map',NULL,'2.0.5'),('20110301-1030e','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10418,'MARK_RAN','3:50be921cf53ce4a357afc0bac8928495','Add Column','Adding concept_reference_term_id column to concept_reference_map table',NULL,'2.0.5'),('20110301-1030f','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10419,'MARK_RAN','3:5faead5506cbcde69490fef985711d66','Custom Change','Inserting core concept map types',NULL,'2.0.5'),('20110301-1030g','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10420,'MARK_RAN','3:affc4d2a4e3143046cfb75b583c7399a','Add Column, Add Foreign Key Constraint','Adding concept_map_type_id column and a foreign key constraint to concept_reference_map table',NULL,'2.0.5'),('20110301-1030h','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10421,'MARK_RAN','3:4bf584dc7b25a180cc82edb56e1b0e5b','Add Column, Add Foreign Key Constraint','Adding changed_by column and a foreign key constraint to concept_reference_map table',NULL,'2.0.5'),('20110301-1030i','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10422,'MARK_RAN','3:f4d0468db79007d0355f6f461603b2f7','Add Column','Adding date_changed column and a foreign key constraint to concept_reference_map table',NULL,'2.0.5'),('20110301-1030j','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10423,'MARK_RAN','3:a7dc8b89e37fe36263072b43670d7f11','Create Table, Add Foreign Key Constraint (x5)','Adding concept_reference_term_map table',NULL,'2.0.5'),('20110301-1030m','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10424,'MARK_RAN','3:b286407bfcdf3853512cb15009c816f1','Custom Change','Creating concept reference terms from existing rows in the concept_reference_map table',NULL,'2.0.5'),('20110301-1030n','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10425,'MARK_RAN','3:01868c1383e5c9c409282b50e67e878c','Add Foreign Key Constraint','Adding foreign key constraint to concept_reference_map.concept_reference_term_id column',NULL,'2.0.5'),('20110301-1030o','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10426,'MARK_RAN','3:eea9343959864edea569d5a2a2358469','Drop Foreign Key Constraint','Dropping foreign key constraint on concept_reference_map.source column',NULL,'2.0.5'),('20110301-1030p','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10427,'MARK_RAN','3:01bf8c07a05f22df2286a4ee27a7acb4','Drop Column','Dropping concept_reference_map.source column',NULL,'2.0.5'),('20110301-1030q','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10428,'MARK_RAN','3:f45caaf1c7daa7f2cb036f46a20aa4b1','Drop Column','Dropping concept_reference_map.source_code column',NULL,'2.0.5'),('20110301-1030r','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10429,'MARK_RAN','3:23fd6bc96ee0a497cf330ed24ec0075b','Drop Column','Dropping concept_reference_map.comment column',NULL,'2.0.5'),('201103011751','abbas','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10381,'EXECUTED','3:4857dcbefa75784da912bca5caba21b5','Create Table, Add Foreign Key Constraint (x3)','Create the person_merge_log table',NULL,'2.0.5'),('20110326-1','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10456,'EXECUTED','3:3376a34edf88bf2868fd75ba2fb0f6c3','Add Column, Add Foreign Key Constraint','Add obs.previous_version column (TRUNK-420)',NULL,'2.0.5'),('20110326-2','Knoll_Frank','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10459,'EXECUTED','3:7c068bfe918b9d87fefa9f8508e92f58','Custom SQL','Fix all the old void_reason content and add in the new previous_version to the matching obs row (POTENTIALLY VERY SLOW FOR LARGE OBS TABLES)',NULL,'2.0.5'),('20110329-2317','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10382,'EXECUTED','3:371be45e2a3616ce17b6f50862ca196d','Delete Data','Removing \'View Encounters\' privilege from Anonymous user',NULL,'2.0.5'),('20110329-2318','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10383,'EXECUTED','3:eb2ece117d8508e843d11eeed7676b21','Delete Data','Removing \'View Observations\' privilege from Anonymous user',NULL,'2.0.5'),('20110425-1600-create-visit-attribute-type-table','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10390,'MARK_RAN','3:3cf419ea9657f9a072881cafb2543d77','Create Table, Add Foreign Key Constraint (x3)','Creating visit_attribute_type table',NULL,'2.0.5'),('20110425-1600-create-visit-attribute-type-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10391,'EXECUTED','3:e4b62b99750c9ee4c213a7bc3101f8a6','Modify Column','(Fixed)Change visit_attribute_type.retired to BOOLEAN',NULL,'2.0.5'),('20110425-1700-create-visit-attribute-table','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10393,'MARK_RAN','3:24e1e30a41f9f5d92f337444fb45402a','Create Table, Add Foreign Key Constraint (x5)','Creating visit_attribute table',NULL,'2.0.5'),('20110425-1700-create-visit-attribute-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10394,'EXECUTED','3:8ab9102da66058c326c0a5089de053e8','Modify Column','(Fixed)Change visit_attribute.voided to BOOLEAN',NULL,'2.0.5'),('20110426-11701','zabil','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10435,'MARK_RAN','3:56caae006a3af14242e2ea57627004c7','Create Table, Add Foreign Key Constraint (x4)','Create provider table',NULL,'2.0.5'),('20110426-11701-create-provider-table','dkayiwa','liquibase-schema-only.xml','2016-03-07 11:43:58',87,'EXECUTED','3:56caae006a3af14242e2ea57627004c7','Create Table, Add Foreign Key Constraint (x4)','Create provider table',NULL,'2.0.5'),('20110426-11701-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10436,'EXECUTED','3:f222ec7d41ce0255c667fd79b70bffd2','Modify Column','(Fixed)Change provider.retired to BOOLEAN',NULL,'2.0.5'),('20110510-11702-create-provider-attribute-type-table','zabil','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10437,'EXECUTED','3:7478ac84804d46a4f2b3daa63efe99be','Create Table, Add Foreign Key Constraint (x3)','Creating provider_attribute_type table',NULL,'2.0.5'),('20110510-11702-create-provider-attribute-type-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10438,'EXECUTED','3:479636c7572a649889527f670eaff533','Modify Column','(Fixed)Change provider_attribute_type.retired to BOOLEAN',NULL,'2.0.5'),('20110628-1400-create-provider-attribute-table','kishoreyekkanti','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10440,'EXECUTED','3:298aaacafd48547be294f4c9b7c40d35','Create Table, Add Foreign Key Constraint (x5)','Creating provider_attribute table',NULL,'2.0.5'),('20110628-1400-create-provider-attribute-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10441,'EXECUTED','3:14d85967e968d0bcd7a49ddeb6f3e540','Modify Column','(Fixed)Change provider_attribute.voided to BOOLEAN',NULL,'2.0.5'),('20110705-2300-create-encounter-role-table','kishoreyekkanti','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10442,'MARK_RAN','3:a381ef81f10e4f7443b4d4c8d6231de8','Create Table, Add Foreign Key Constraint (x3)','Creating encounter_role table',NULL,'2.0.5'),('20110705-2300-create-encounter-role-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10443,'EXECUTED','3:bed2af9d6c3d49eacbdaf2174e682671','Modify Column','(Fixed)Change encounter_role.retired to BOOLEAN',NULL,'2.0.5'),('20110705-2311-create-encounter-role-table','dkayiwa','liquibase-schema-only.xml','2016-03-07 11:43:59',88,'EXECUTED','3:a381ef81f10e4f7443b4d4c8d6231de8','Create Table, Add Foreign Key Constraint (x3)','Creating encounter_role table',NULL,'2.0.5'),('20110708-2105','cta','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10397,'MARK_RAN','3:a20e9bb27a1aca73a646ad81ef2b9deb','Add Unique Constraint','Add unique constraint to the concept_source table',NULL,'2.0.5'),('201107192313-change-length-of-regex-column','jtellez','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10395,'EXECUTED','3:db001544cc0f5a1ff42524a9292b028b','Modify Column','Increasing maximum length of patient identifier type regex format',NULL,'2.0.5'),('20110811-1205-create-encounter-provider-table','sree/vishnu','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10444,'EXECUTED','3:e20ca5412e37df98c58a39552aafb5ad','Create Table, Add Foreign Key Constraint (x3)','Creating encounter_provider table',NULL,'2.0.5'),('20110811-1205-create-encounter-provider-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10445,'EXECUTED','3:8decefa15168e68297f5f2782991c552','Modify Column','(Fixed)Change encounter_provider.voided to BOOLEAN',NULL,'2.0.5'),('20110817-1544-create-location-attribute-type-table','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10400,'MARK_RAN','3:41fa30c01ec2d1107beccb8126146464','Create Table, Add Foreign Key Constraint (x3)','Creating location_attribute_type table',NULL,'2.0.5'),('20110817-1544-create-location-attribute-type-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10401,'EXECUTED','3:53aff6217c6a9a8f1ca414703b1a8720','Modify Column','(Fixed)Change visit_attribute.retired to BOOLEAN',NULL,'2.0.5'),('20110817-1601-create-location-attribute-table','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10403,'MARK_RAN','3:c7cb1b35d68451d10badeb445df599b9','Create Table, Add Foreign Key Constraint (x5)','Creating location_attribute table',NULL,'2.0.5'),('20110817-1601-create-location-attribute-table-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10404,'EXECUTED','3:2450e230f3eda291203485bca6904377','Modify Column','(Fixed)Change visit_attribute.retired to BOOLEAN',NULL,'2.0.5'),('20110819-1455-insert-unknown-encounter-role','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10446,'EXECUTED','3:bfe0b994a3c0a62d0d4c8f7d941991c7','Insert Row','Inserting the unknown encounter role into the encounter_role table',NULL,'2.0.5'),('20110825-1000-creating-providers-for-persons-from-encounter','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10447,'EXECUTED','3:04bc8aa9859f6f8dda065e272ba12e0d','Custom SQL','Creating providers for persons from the encounter table',NULL,'2.0.5'),('20110825-1000-drop-provider-id-column-from-encounter-table','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10449,'EXECUTED','3:2137e4b5198aa5f12059ee0e8837fb04','Drop Foreign Key Constraint, Drop Column','Dropping the provider_id column from the encounter table',NULL,'2.0.5'),('20110825-1000-migrating-providers-to-encounter-provider','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10448,'EXECUTED','3:e7c39080453e862d5a4013c48c9225fc','Custom SQL','Migrating providers from the encounter table to the encounter_provider table',NULL,'2.0.5'),('2011091-0749','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',125,'EXECUTED','3:3534020f1c68f70b0e9851d47a4874d6','Create Index','',NULL,'2.0.5'),('2011091-0750','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',126,'EXECUTED','3:f058162398862f0bdebc12d7eb54551b','Create Index','',NULL,'2.0.5'),('20110913-0300','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10430,'MARK_RAN','3:7ad8f362e4cc6df6e37135cc37546d0d','Drop Foreign Key Constraint, Add Foreign Key Constraint','Remove ON DELETE CASCADE from relationship table for person_a',NULL,'2.0.5'),('20110913-0300b','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10431,'MARK_RAN','3:2486028ce670bdea2a5ced509a335170','Drop Foreign Key Constraint, Add Foreign Key Constraint','Remove ON DELETE CASCADE from relationship table for person_b',NULL,'2.0.5'),('20110914-0104','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',317,'EXECUTED','3:b1811e5e43321192b275d6e2fe2fa564','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0114','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',69,'EXECUTED','3:dac2ff60a4f99315d68948e9582af011','Create Table','',NULL,'2.0.5'),('20110914-0117','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',318,'EXECUTED','3:5b7f746286a955da60c9fec8d663a0e3','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0245','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',319,'EXECUTED','3:48cdf2b28fcad687072ac8133e46cba6','Add Unique Constraint','',NULL,'2.0.5'),('20110914-0306','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',70,'EXECUTED','3:037f98fda886cde764171990d168e97d','Create Table','',NULL,'2.0.5'),('20110914-0308','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',320,'EXECUTED','3:6309ad633777b0faf1d9fa394699a789','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0310','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',321,'EXECUTED','3:8c53c44af44d75aadf6cedfc9d13ded1','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0312','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',71,'EXECUTED','3:2a39901427c9e7b84c8578ff7b3099bb','Create Table','',NULL,'2.0.5'),('20110914-0314','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',322,'EXECUTED','3:9cbe2e14482f88864f94d5e630a88b62','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0315','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',323,'EXECUTED','3:18cd917d56887ad924dad367470a8461','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0317','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',98,'EXECUTED','3:cffbf258ca090d095401957df4168175','Add Primary Key','',NULL,'2.0.5'),('20110914-0321','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',324,'EXECUTED','3:67723ac8a4583366b78c9edc413f89eb','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0434','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',326,'EXECUTED','3:081831e316a82683102f298a91116e92','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0435','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',327,'EXECUTED','3:03fa6c6a37a61480c95d5b75e30d4846','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0448','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',72,'EXECUTED','3:ffa1ef2b17d77f87dccbdea0c51249de','Create Table','',NULL,'2.0.5'),('20110914-0453','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',325,'EXECUTED','3:ea43c7690888a7fd47aa7ba39f8006e2','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0509','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',122,'EXECUTED','3:d29884c3ef8fd867c3c2ffbd557c14c2','Create Index','',NULL,'2.0.5'),('20110914-0943','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',123,'EXECUTED','3:c48f2441d83f121db30399d9cd5f7f8b','Create Index','',NULL,'2.0.5'),('20110914-0945','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',328,'EXECUTED','3:ea1fbb819a84a853b4a97f93bd5b8600','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110914-0956','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',124,'EXECUTED','3:719aa7e4120c11889d91214196acfd4c','Create Index','',NULL,'2.0.5'),('20110914-0958','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',329,'EXECUTED','3:ad98b3c7ae60001d0e0a7b927177fb72','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0258','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',330,'EXECUTED','3:bd7731e58f3db9b944905597a08eb6cb','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0259','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',331,'EXECUTED','3:11086a37155507c0238c9532f66b172b','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0357','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',332,'EXECUTED','3:05d531e66cbc42e1eb2d42c8bcf20bc8','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0547','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',333,'EXECUTED','3:f3b0fc223476060082626b3849ee20ad','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0552','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',334,'EXECUTED','3:46e5067fb13cefd224451b25abbd03ae','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0603','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',335,'EXECUTED','3:ca4f567e4d75ede0553e8b32012e4141','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0610','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',336,'EXECUTED','3:d6c6a22571e304640b2ff1be52c76977','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0634','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',337,'EXECUTED','3:c6dd75893e5573baa0c7426ecccaa92d','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0751','sunbiz','liquibase-core-data.xml','2016-03-07 11:44:09',10029,'EXECUTED','3:010949e257976520a6e8c87e419c9435','Insert Row','',NULL,'2.0.5'),('20110915-0803','sunbiz','liquibase-core-data.xml','2016-03-07 11:44:09',10036,'EXECUTED','3:4a09e1959df71d38fa77b249bf032edc','Insert Row','',NULL,'2.0.5'),('20110915-0823','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',338,'EXECUTED','3:beb831615b748a06a8b21dcaeba8c40d','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0824','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:05',339,'EXECUTED','3:90f1a69f5cae1d2b3b3a2fa8cb1bace2','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0825','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',74,'EXECUTED','3:17eab4b1c4c36b54d8cf8ca26083105c','Create Table','',NULL,'2.0.5'),('20110915-0836','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',340,'EXECUTED','3:53f76b5f2c20d5940518a1b14ebab33e','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0837','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',341,'EXECUTED','3:936ecde7ac26efdd1a4c29260183609c','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0838','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',342,'EXECUTED','3:fc1e68e753194b2f83e014daa0f7cb3e','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0839','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',343,'EXECUTED','3:90bfb3d0edfcfc8091a2ffd943a54e88','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0840','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',344,'EXECUTED','3:9af8eca0bc6b58c3816f871d9f6d5af8','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0841','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',345,'EXECUTED','3:2ca812616a13bac6b0463bf26b9a0fe3','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0842','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',346,'EXECUTED','3:4fd619ffdedac0cf141a7dd1b6e92f9b','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0845','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',75,'EXECUTED','3:4e799d7e5a15e823116caa01ab7ed808','Create Table','',NULL,'2.0.5'),('20110915-0846','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',347,'EXECUTED','3:a41f6272aa79f3259ba24f0a31c51e72','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-0847','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',76,'EXECUTED','3:8c1e49cd3d6402648ee7732ba9948785','Create Table','',NULL,'2.0.5'),('20110915-0848','sunbiz','liquibase-core-data.xml','2016-03-07 11:44:09',10037,'EXECUTED','3:cf7989886ae2624508fdf64b7b656727','Insert Row (x2)','',NULL,'2.0.5'),('20110915-0848','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',77,'EXECUTED','3:071de39e44036bd8adb2b24b011b7369','Create Table','',NULL,'2.0.5'),('20110915-0903','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',348,'EXECUTED','3:b6260c13bf055f7917c155596502a24b','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1045','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',127,'EXECUTED','3:8612ede2553aab53950fa43d2f8def32','Create Index','',NULL,'2.0.5'),('20110915-1049','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',349,'EXECUTED','3:b71f1caa3d14aa6282ef58e2a002f999','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1051','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',128,'EXECUTED','3:26c8ae0c53225f82d4c2a85c09ad9785','Create Index','',NULL,'2.0.5'),('20110915-1052','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',129,'EXECUTED','3:1efabdfd082ff2b0a34f570831f74ce5','Create Index','',NULL,'2.0.5'),('20110915-1053','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',130,'EXECUTED','3:00273104184bb4d2bb7155befc77efc3','Create Index','',NULL,'2.0.5'),('20110915-1103','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',131,'EXECUTED','3:29b35d66dc4168e03e1844296e309327','Create Index','',NULL,'2.0.5'),('20110915-1104','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',132,'EXECUTED','3:d63107017bdcef0e28d7ad5e4df21ae5','Create Index','',NULL,'2.0.5'),('20110915-1107','sunbiz','liquibase-core-data.xml','2016-03-07 11:44:09',10038,'EXECUTED','3:18eb4edef88534b45b384e6bc3ccce75','Insert Row','',NULL,'2.0.5'),('20110915-1133','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',133,'EXECUTED','3:fea4ad8ce44911eeaab8ac8c1cc9122d','Create Index','',NULL,'2.0.5'),('20110915-1135','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',350,'EXECUTED','3:f0bc11508a871044f5a572b7f8103d52','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1148','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',351,'EXECUTED','3:a5ef601dc184a85e988eded2f1f82dcb','Add Unique Constraint','',NULL,'2.0.5'),('20110915-1149','sunbiz','liquibase-core-data.xml','2016-03-07 11:44:09',10039,'EXECUTED','3:83534d43a9a9cc1ea3a80f1d5f5570af','Insert Row (x10)','',NULL,'2.0.5'),('20110915-1202','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',352,'EXECUTED','3:2c58f7f1e2450c60898bffe6933c9b34','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1203','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',353,'EXECUTED','3:5bce62082a32d3624854a198d3fa35b7','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1210','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',354,'EXECUTED','3:e17eee5b8c4bb236a0ea6e6ade5abed7','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1215','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',73,'EXECUTED','3:d772a6a8adedbb1c012dac58ffb221c3','Create Table','',NULL,'2.0.5'),('20110915-1222','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',78,'EXECUTED','3:25ce4e3219f2b8c85e06d47dfc097382','Create Table','',NULL,'2.0.5'),('20110915-1225','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',355,'EXECUTED','3:2d4f77176fd59955ff719c46ae8b0cfc','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1226','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',356,'EXECUTED','3:66155de3997745548dbca510649cd09d','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1227','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',357,'EXECUTED','3:6700b07595d6060269b86903d08bb2a5','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1231','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',79,'EXECUTED','3:e9f6104a25d8b37146b27e568b6e3d3f','Create Table','',NULL,'2.0.5'),('20110915-1240','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',358,'EXECUTED','3:5a30b62738cf57a4804310add8f71b6a','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1241','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',359,'EXECUTED','3:a48aa09c19549e43fc538a70380ae61f','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1242','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',360,'EXECUTED','3:e0e23621fabe23f3f04c4d13105d528c','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1243','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',361,'EXECUTED','3:1d15d848cefc39090e90f3ea78f3cedc','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1244','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',362,'EXECUTED','3:6c5b2018afd741a3c7e39c563212df57','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1245','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',363,'EXECUTED','3:9b5b112797deb6eddc9f0fc01254e378','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1246','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',364,'EXECUTED','3:290a8c07c70dd6a5fe85be2d747ff0d8','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1247','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:59',134,'EXECUTED','3:0644f13c7f4bb764d3b17ad160bd8d41','Create Index','',NULL,'2.0.5'),('20110915-1248','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',365,'EXECUTED','3:5b42d27a7c7edfeb021e1dcfed0f33b3','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1258','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',80,'EXECUTED','3:07687ca4ba9b942a862a41dd9026bc9d','Create Table','',NULL,'2.0.5'),('20110915-1301','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',366,'EXECUTED','3:ef3a47a3fdd809ef4269e9643add2abd','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1302','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',367,'EXECUTED','3:e36c12350ebfbd624bdc6a6599410c85','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1303','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',368,'EXECUTED','3:5917c5e09a3f6077b728a576cd9bacb3','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1307','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',81,'EXECUTED','3:957d888738541ed76dda53e222079fa3','Create Table','',NULL,'2.0.5'),('20110915-1311','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',392,'EXECUTED','3:e88c86892fafb2f897f72a85c66954c0','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1312','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',369,'EXECUTED','3:fe2641c56b27b429c1c4a150e1b9af18','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1313','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:06',370,'EXECUTED','3:5c7ab96d3967d1ce4e00ebe23f4c4f6e','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1314','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',371,'EXECUTED','3:22902323fcd541f18ca0cb4f38299cb4','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1315','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',372,'EXECUTED','3:dd0d198da3d5d01f93d9acc23e89d51c','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1316','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',373,'EXECUTED','3:f22027f3fc0b1a3a826dc5d810fcd936','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1317','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',374,'EXECUTED','3:68aa00c9f2faa61031d0b4544f4cb31b','Add Unique Constraint','',NULL,'2.0.5'),('20110915-1320','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',375,'EXECUTED','3:5d6a55ee33c33414cccc8b46776a36a4','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1323','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',376,'EXECUTED','3:4c3b84570d45b23d363f6ee76acd966f','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1325','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',82,'EXECUTED','3:0813953451c461376a6ab5a13e4654dd','Create Table','',NULL,'2.0.5'),('20110915-1327','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',377,'EXECUTED','3:3c8aaca28033c8a01e4bceb7421f8e8e','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1328','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',378,'EXECUTED','3:05b6e994f2a09b23826264d31f275b5e','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1329','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',379,'EXECUTED','3:40729ae012b9ed8bd55439b233ec10cc','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1337','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',83,'EXECUTED','3:06fd47a34713fad9678463bba9675496','Create Table','',NULL,'2.0.5'),('20110915-1342','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',380,'EXECUTED','3:bb52caf0ec6e80e24d6fc0c7f2c95631','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1343','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',381,'EXECUTED','3:b36c3436facfe7c9371f7780ebb8701d','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1344','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',382,'EXECUTED','3:010fa7bc125bcb8caa320d38a38a7e3f','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1345','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',383,'EXECUTED','3:e3cdd84f2e6632a4dd8c526cf9ff476e','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1346','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',384,'EXECUTED','3:7f6420b23addd5b33320e04adbc134a3','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1435','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',84,'EXECUTED','3:511f99d7cb13e5fc1112ccb4633e0e45','Create Table','',NULL,'2.0.5'),('20110915-1440','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',385,'EXECUTED','3:2cb254be6daeeebb74fc0e1d64728a62','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1441','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',386,'EXECUTED','3:8bd11d5102eff3b52b1d925e44627a48','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1442','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',387,'EXECUTED','3:4cf7afc33839c19f830e996e8546ea72','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1443','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',388,'EXECUTED','3:cf41f73f64c11150062b2e2254a56908','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1450','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',85,'EXECUTED','3:f9348bf7337d32ebbf98545857b5c8cc','Create Table','',NULL,'2.0.5'),('20110915-1451','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',389,'EXECUTED','3:d98c8bdaacf99764ab3319db03b48542','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1452','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',390,'EXECUTED','3:3a2e67fd1f0215b49711e7e8dccd370d','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1453','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',391,'EXECUTED','3:6b1b7fb75fedc196cf833f04e216b9b2','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1459','sunbiz','liquibase-core-data.xml','2016-03-07 11:44:09',10040,'EXECUTED','3:5faead5506cbcde69490fef985711d66','Custom Change','Inserting core concept map types',NULL,'2.0.5'),('20110915-1524','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',393,'EXECUTED','3:8d609018e78b744ce30e8907ead0bec0','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1528','sunbiz','liquibase-schema-only.xml','2016-03-07 11:43:58',86,'EXECUTED','3:e8a5555a214d7bb6f17eb2466f59d12b','Create Table','',NULL,'2.0.5'),('20110915-1530','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',394,'EXECUTED','3:ddc26a0bb350b6c744ed6ff813b5c108','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1531','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',395,'EXECUTED','3:e9fa5722ba00d9b55d813f0fc8e5f9f9','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1532','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',396,'EXECUTED','3:72f0f61a12a3eead113be1fdcabadb6f','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1533','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',397,'EXECUTED','3:0430d8eecce280786a66713abd0b3439','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1534','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',398,'EXECUTED','3:21b6cde828dbe885059ea714cda4f470','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1536','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',399,'EXECUTED','3:01868c1383e5c9c409282b50e67e878c','Add Foreign Key Constraint','',NULL,'2.0.5'),('20110915-1700','sunbiz','liquibase-schema-only.xml','2016-03-07 11:44:07',402,'EXECUTED','3:ba5b74aeacacec55a49d31074b7e5023','Insert Row (x18)','',NULL,'2.0.5'),('201109152336','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10433,'MARK_RAN','3:a84f855a1db7201e08900f8c7a3d7c5f','Update Data','Updating logging level global property',NULL,'2.0.5'),('20110919-0638','sunbiz','liquibase-update-to-latest.xml','2011-09-19 00:00:00',10015,'MARK_RAN','3:5e540b763c3a16e9d37aa6423b7f798f',NULL,NULL,NULL,NULL),('20110919-0639-void_empty_attributes','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10434,'EXECUTED','3:ccdbab987b09073fc146f3a4a5a9aee4','Custom SQL','Void all attributes that have empty string values.',NULL,'2.0.5'),('20110922-0551','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:31',10306,'MARK_RAN','3:ab9b55e5104645690a4e1c5e35124258','Modify Column','Changing global_property.property from varbinary to varchar',NULL,'2.0.5'),('20110926-1200','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10396,'MARK_RAN','3:bf884233110a210b6ffcef826093cf9d','Custom SQL','Change all empty concept_source.hl7_code to NULL',NULL,'2.0.5'),('201109301703','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10405,'MARK_RAN','3:11456d3e6867f3b521fb35e6f51ebe5a','Update Data','Converting general address format (if applicable)',NULL,'2.0.5'),('201109301704','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10406,'MARK_RAN','3:d64afe121c9355f6bbe46258876ce759','Update Data','Converting Spain address format (if applicable)',NULL,'2.0.5'),('201109301705','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10407,'MARK_RAN','3:d3b0c8265ee27456dc0491ff5fe8ca01','Update Data','Converting Rwanda address format (if applicable)',NULL,'2.0.5'),('201109301706','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10408,'MARK_RAN','3:17d3a0900ca751d8ce775a12444c75bf','Update Data','Converting USA address format (if applicable)',NULL,'2.0.5'),('201109301707','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10409,'MARK_RAN','3:afbd6428d0007325426f3c4446de2e38','Update Data','Converting Kenya address format (if applicable)',NULL,'2.0.5'),('201109301708','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10410,'MARK_RAN','3:570c9234597b477e4feffbaac0469495','Update Data','Converting Lesotho address format (if applicable)',NULL,'2.0.5'),('201109301709','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10411,'MARK_RAN','3:20c95ae336f437b4e0c91be5919b7a2b','Update Data','Converting Malawi address format (if applicable)',NULL,'2.0.5'),('201109301710','suho','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10412,'MARK_RAN','3:b06d71b4c220c7feed9c5a6459bea98a','Update Data','Converting Tanzania address format (if applicable)',NULL,'2.0.5'),('201110051353-fix-visit-attribute-type-columns','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10392,'MARK_RAN','3:d779b41ab27dca879d593aa606016bf6','Add Column (x2)','Refactoring visit_attribute_type table (devs only)',NULL,'2.0.5'),('201110072042-fix-location-attribute-type-columns','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:36',10402,'MARK_RAN','3:2e32ce0f25391341c8855604f4f40654','Add Column (x2)','Refactoring location_attribute_type table (devs only)',NULL,'2.0.5'),('201110072043-fix-provider-attribute-type-columns','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10439,'MARK_RAN','3:31aa196adfe1689c1098c5f36d490902','Add Column (x2)','Refactoring provider_attribute_type table (devs only)',NULL,'2.0.5'),('20111008-0938-1','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10450,'EXECUTED','3:fe6d462ba1a7bd81f4865e472cc223ce','Add Column','Allow Global Properties to be typed',NULL,'2.0.5'),('20111008-0938-2','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:37',10451,'EXECUTED','3:f831d92c11eb6cd6b334d86160db0b95','Add Column','Allow Global Properties to be typed',NULL,'2.0.5'),('20111008-0938-3','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10452,'EXECUTED','3:f7bd79dfed90d56053dc376b6b8ee7e3','Add Column','Allow Global Properties to be typed',NULL,'2.0.5'),('20111008-0938-4','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10453,'EXECUTED','3:65003bd1bf99ff0aa8e2947978c58053','Add Column','Allow Global Properties to be typed',NULL,'2.0.5'),('201110091820-a','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10454,'MARK_RAN','3:364a0c70d2adbff31babab6f60ed72e7','Add Column','Add xslt column back to the form table',NULL,'2.0.5'),('201110091820-b','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10455,'MARK_RAN','3:0b792bf39452f2e81e502a7a98f9f3df','Add Column','Add template column back to the form table',NULL,'2.0.5'),('201110091820-c','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10457,'MARK_RAN','3:f71680d95ecf870619671fb7f416e457','Rename Table','Rename form_resource table to preserve data; 20111010-1515 reference is for bleeding-edge developers and can be generally ignored',NULL,'2.0.5'),('20111010-1515','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10458,'EXECUTED','3:3ccdc9a3ecf811382a0c12825c0aeeb3','Create Table, Add Foreign Key Constraint, Add Unique Constraint','Creating form_resource table',NULL,'2.0.5'),('20111128-1601','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10460,'EXECUTED','3:12fa4687d149a2f17251e546d47369d6','Insert Row','Inserting Auto Close Visits Task into \'schedule_task_config\' table',NULL,'2.0.5'),('20111209-1400-deleting-non-existing-roles-from-role-role-table','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10461,'EXECUTED','3:3d74c1dd987a12d916218d68032d726d','Custom SQL','Deleting non-existing roles from the role_role table',NULL,'2.0.5'),('20111214-1500-setting-super-user-gender','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10464,'EXECUTED','3:2c281abfe7beb51983db13c187c072f3','Custom SQL','Setting super user gender',NULL,'2.0.5'),('20111218-1830','abbas','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10465,'EXECUTED','3:5f096b88988f19d9d3e596c03fba2b90','Add Unique Constraint, Add Column (x6), Add Foreign Key Constraint (x2)','Add unique uuid constraint and attributes inherited from BaseOpenmrsData to the person_merge_log table',NULL,'2.0.5'),('20111218-1830-fix','sunbiz','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10466,'EXECUTED','3:a95b16d8762fef1076564611fb2115ac','Modify Column','(Fixed)Change person_merge_log.voided to BOOLEAN',NULL,'2.0.5'),('20111218-2274','gsluthra','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10467,'MARK_RAN','3:6339df469a35f517ac6e86452aad0155','Update Data','Fix the description for RBC concept',NULL,'2.0.5'),('20111219-1404','bwolfe','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10468,'EXECUTED','3:3f8cfa9c088a103788bcf70de3ffaa8b','Update Data','Fix empty descriptions on relationship types',NULL,'2.0.5'),('20111222-1659','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10469,'EXECUTED','3:990b494647720b680efeefbab2c502de','Create Table, Create Index','Create clob_datatype_storage table',NULL,'2.0.5'),('201118012301','lkellett','liquibase-update-to-latest.xml','2016-03-07 11:44:35',10370,'MARK_RAN','3:0d96c10c52335339b1003e6dd933ccc2','Add Column','Adding the discontinued_reason_non_coded column to orders.',NULL,'2.0.5'),('201202020847','abbas','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10470,'EXECUTED','3:35bf2f2481ee34975e57f08d933583be','Modify data type, Add Not-Null Constraint','Change merged_data column type to CLOB in person_merge_log table',NULL,'2.0.5'),('20120316-1300','mseaton','liquibase.xml','2016-03-07 11:59:41',10634,'EXECUTED','3:0cbaf0a89ef629563c90deccbd82429f','Create Table','Adding calculation_registration table',NULL,'2.0.5'),('20120322-1510','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10471,'EXECUTED','3:7c5913c7091c2b20babb9e825774993c','Add Column','Adding uniqueness_behavior column to patient_identifier_type table',NULL,'2.0.5'),('20120330-0954','jkeiper','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10472,'EXECUTED','3:9c6084b4407395205fa39b34630d3522','Modify data type','Increase size of drug name column to 255 characters',NULL,'2.0.5'),('20120503-djmod','dkayiwa and djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10492,'EXECUTED','3:d31ac18d3a40e45c0ebb399c5d116951','Create Table, Add Foreign Key Constraint (x2)','Create test_order table',NULL,'2.0.5'),('20120504-1000','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10473,'EXECUTED','3:eb6f5e2a2ef5ea111ff238ca1df013f4','Drop Table','Dropping the drug_ingredient table',NULL,'2.0.5'),('20120504-1010','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:38',10474,'EXECUTED','3:4d9ece759a248fa385c3eae6b83995a1','Create Table','Creating the drug_ingredient table',NULL,'2.0.5'),('20120504-1020','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:39',10475,'EXECUTED','3:fcbc8182e908b595ae338ba8402a589c','Add Primary Key','Adding a primary key to the drug_ingredient table',NULL,'2.0.5'),('20120504-1030','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:39',10476,'EXECUTED','3:d802926fcf3eaf3649aca49a26a5f67d','Add Foreign Key Constraint','Adding a new foreign key from drug_ingredient.units to concept.concept_id',NULL,'2.0.5'),('20120504-1040','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:39',10477,'EXECUTED','3:9786bfbb8133493b54ce9026424d5b99','Add Foreign Key Constraint','Adding a new foreign key from drug_ingredient.drug_id to drug.drug_id',NULL,'2.0.5'),('20120504-1050','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10478,'EXECUTED','3:7d43f25c9a3bde54112ddd65627b2c05','Add Foreign Key Constraint','Adding a new foreign key from drug_ingredient.ingredient_id to concept.concept_id',NULL,'2.0.5'),('201205241728-1','mvorobey','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10487,'MARK_RAN','3:70160c0af8222542fa668ac5f5cb99ed','Add Column, Add Foreign Key Constraint','Add optional property view_privilege to encounter_type table',NULL,'2.0.5'),('201205241728-2','mvorobey','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10488,'MARK_RAN','3:dd8de770c99e046ba05bc8348748c33c','Add Column, Add Foreign Key Constraint','Add optional property edit_privilege to encounter_type table',NULL,'2.0.5'),('20120529-2230','mvorobey','liquibase-schema-only.xml','2016-03-07 11:44:07',400,'EXECUTED','3:f3e2c3891054eed4aadc45ad071afd8c','Add Foreign Key Constraint','',NULL,'2.0.5'),('20120529-2231','mvorobey','liquibase-schema-only.xml','2016-03-07 11:44:07',401,'EXECUTED','3:9bc5f03ef0ab12767509be1cb4cc3213','Add Foreign Key Constraint','',NULL,'2.0.5'),('20120613-0930','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10490,'EXECUTED','3:fe6387773a70b574b106b37686a8e8d3','Drop Not-Null Constraint','Dropping not null constraint from provider.identifier column',NULL,'2.0.5'),('20121007-orders_urgency','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10493,'EXECUTED','3:f8eb2228ea34f43ae21bedf4abc8736b','Add Column','Adding urgency column to orders table',NULL,'2.0.5'),('20121007-test_order_laterality','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10494,'EXECUTED','3:1121924c349201e400e03feda110acc3','Modify data type','Changing test_order.laterality to be a varchar',NULL,'2.0.5'),('20121008-order_specimen_source_fk','djazayeri','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10495,'MARK_RAN','3:99464e51d64e056a1e23b30c7aaaf47e','Add Foreign Key Constraint','Adding FK constraint for test_order.specimen_source if necessary',NULL,'2.0.5'),('20121016-1504','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10496,'EXECUTED','3:88db1819c0e9da738ed9332b5de73609','Drop Foreign Key Constraint, Modify Column, Add Foreign Key Constraint','Removing auto increment from test_order.order_id column',NULL,'2.0.5'),('20121020-TRUNK-3610','lluismf','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10497,'EXECUTED','3:a3159e65647f0ff1b667104012b5f4f0','Update Data (x2)','Rename global property autoCloseVisits.visitType to visits.autoCloseVisitType',NULL,'2.0.5'),('20121021-TRUNK-333','lluismf','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10499,'EXECUTED','3:f885cb0eed2a8e2a5786675eeb0ccbc5','Drop Table','Removing concept set derived table',NULL,'2.0.5'),('20121025-TRUNK-213','lluismf','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10498,'EXECUTED','3:65536ae335b0a6cb23619d6ef7ea3274','Modify Column (x2)','Normalize varchar length of locale columns',NULL,'2.0.5'),('20121109-TRUNK-3474','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10500,'EXECUTED','3:02af0e39e210aeda861f92698ae974f6','Drop Not-Null Constraint','Dropping not null constraint from concept_class.description column',NULL,'2.0.5'),('20121112-TRUNK-3474','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10501,'EXECUTED','3:30e023e5e3e98190470d951fbbbd9e87','Drop Not-Null Constraint','Dropping not null constraint from concept_datatype.description column',NULL,'2.0.5'),('20121113-TRUNK-3474','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10502,'EXECUTED','3:76211ab053e8685a4d0b1345f166e965','Drop Not-Null Constraint','Dropping not null constraint from patient_identifier_type.description column',NULL,'2.0.5'),('20121113-TRUNK-3474-person-attribute-type','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10503,'EXECUTED','3:7ad821b6167ff22a812a6c550d6deb53','Drop Not-Null Constraint','Dropping not null constraint from person_attribute_type.description column',NULL,'2.0.5'),('20121113-TRUNK-3474-privilege','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10504,'EXECUTED','3:ecf38bb6fb29d96b0e2c75330a637245','Drop Not-Null Constraint','Dropping not null constraint from privilege.description column',NULL,'2.0.5'),('20121114-TRUNK-3474-encounter_type','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10507,'EXECUTED','3:1cad8ad2c06b02915138dfb36c013770','Drop Not-Null Constraint','Dropping not null constraint from encounter_type.description column',NULL,'2.0.5'),('20121114-TRUNK-3474-relationship_type','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10506,'EXECUTED','3:232499aa77be5583f87d6528c0c44768','Drop Not-Null Constraint','Dropping not null constraint from relationship_type.description column',NULL,'2.0.5'),('20121114-TRUNK-3474-role','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10505,'EXECUTED','3:69a164a13e3520d5cdccbf977d07ce89','Drop Not-Null Constraint','Dropping not null constraint from role.description column',NULL,'2.0.5'),('20121212-TRUNK-2768','patandre','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10508,'EXECUTED','3:351f7dba6eea4f007fa5d006219ede9e','Add Column','Adding deathdate_estimated column to person.',NULL,'2.0.5'),('201301031440-TRUNK-4135','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10573,'EXECUTED','3:47e5686e3cb80484b2830afca679ec70','Custom Change','Creating coded order frequencies for drug order frequencies',NULL,'2.0.5'),('201301031448-TRUNK-4135','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10574,'EXECUTED','3:00adfb72966810dd0c048f93b8edd523','Custom Change','Migrating drug order frequencies to coded order frequencies',NULL,'2.0.5'),('201301031455-TRUNK-4135','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10575,'EXECUTED','3:04b95a27ccba87e597395670db081498','Drop Column','Dropping temporary column drug_order.frequency_text',NULL,'2.0.5'),('201306141103-TRUNK-3884','susantan','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10510,'EXECUTED','3:9581f8d869e69d911f04e48591a297d0','Add Foreign Key Constraint (x3)','Adding 3 foreign key relationships (creator,created_by,voided_by) to encounter_provider table',NULL,'2.0.5'),('20130626-TRUNK-439','jthoenes','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10509,'EXECUTED','3:6c0799599f35b4546dafa73968e3a229','Update Data','Adding configurability to Patient Header on Dashboard. Therefore the cd4_count property is dropped and\n            replaced with a header.showConcept property.',NULL,'2.0.5'),('20130809-TRUNK-4044-duplicateEncounterRoleChangeSet','surangak','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10513,'EXECUTED','3:35b07ae88667be5a78002beacd3aa0ed','Custom Change','Custom changesets to identify and resolve duplicate EncounterRole names',NULL,'2.0.5'),('20130809-TRUNK-4044-duplicateEncounterTypeChangeSet','surangak','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10514,'MARK_RAN','3:01a7d7ae88b0280139178f1840d417bd','Custom Change','Custom changesets to identify and resolve duplicate EncounterType names',NULL,'2.0.5'),('20130809-TRUNK-4044-encounter_role_unique_name_constraint','surangak','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10516,'EXECUTED','3:1a5a8ad5971977e0645a6fbc3744f8e2','Add Unique Constraint','Adding the unique constraint to the encounter_role.name column',NULL,'2.0.5'),('20130809-TRUNK-4044-encounter_type_unique_name_constraint','surangak','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10515,'EXECUTED','3:823098007f6e299c0c6555dde6f12255','Add Unique Constraint','Adding the unique constraint to the encounter_type.name column',NULL,'2.0.5'),('20130925-TRUNK-4105','hannes','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10511,'EXECUTED','3:e81f96e97c307c2d265bce32a046d0ca','Create Index','Adding index on concept_reference_term.code column',NULL,'2.0.5'),('20131023-TRUNK-3903','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:41',10512,'MARK_RAN','3:88f8ec2c297875a03fd88ddd2b9f14b9','Add Column','Adding \"display_precision\" column to concept_numeric table',NULL,'2.0.5'),('201310281153-TRUNK-4123','mujir,sushmitharaos','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10543,'EXECUTED','3:b2bffad4e841b61c6397465633cd1064','Add Column, Add Foreign Key Constraint','Adding previous_order_id to orders',NULL,'2.0.5'),('201310281153-TRUNK-4124','mujir,sushmitharaos','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10544,'EXECUTED','3:eb9dec50fead4430dc07b8309e5840ac','Add Column, Update Data, Add Not-Null Constraint','Adding order_action to orders and setting order_actions as NEW for existing orders',NULL,'2.0.5'),('201311041510','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10538,'EXECUTED','3:dfdc279ddc60b9751dc5d655b4c7fc9c','Rename Column','Renaming drug_order.prn column to drug_order.as_needed',NULL,'2.0.5'),('201311041511','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10539,'EXECUTED','3:4a2ee902d6090959a49539d5bc907354','Add Column','Adding as_needed_condition column to drug_order table',NULL,'2.0.5'),('201311041512','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10540,'EXECUTED','3:76a5c7a0b95e971bd540865917efed9c','Add Column','Adding order_number column to orders table',NULL,'2.0.5'),('201311041513','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10541,'MARK_RAN','3:b41217397a18dbe18e07266a9be4a523','Update Data','Setting order numbers for existing orders',NULL,'2.0.5'),('201311041515-TRUNK-4122','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10542,'EXECUTED','3:948975149e69b6862aab0012304d9a80','Add Not-Null Constraint','Making orders.order_number not nullable',NULL,'2.0.5'),('20131210-TRUNK-4130','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10548,'EXECUTED','3:5a2bde236731862f2c6e3e4066705cdf','Add Column','Adding num_refills column to drug_order table',NULL,'2.0.5'),('201312141400-TRUNK-4126','arathy','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10545,'EXECUTED','3:45d8c6ce32076c0fe11f75d1fea1c215','Modify data type, Rename Column','Renaming drug_order.complex to dosing_type',NULL,'2.0.5'),('201312141400-TRUNK-4127','arathy','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10547,'MARK_RAN','3:26f381a2b8f112d98f36c1d0b6cceebd','Update Data (x2)','Converting values in drug_order.dosing_type column',NULL,'2.0.5'),('201312141401-TRUNK-4126','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10546,'EXECUTED','3:cc77a94d57b78ac02e99ed4ca25f6272','Drop Not-Null Constraint','Making drug_order.dosing_type nullable',NULL,'2.0.5'),('20131216-1637','gitahi','liquibase-update-to-latest.xml','2016-03-07 11:44:45',10583,'EXECUTED','3:4b2a0abaf146a7d938b94009d9600eaf','Create Table, Add Foreign Key Constraint (x6)','Add drug_reference_map table',NULL,'2.0.5'),('201312161618-TRUNK-4129','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10554,'EXECUTED','3:a7c821bc60c7410b387aa276540291a9','Add Column, Add Foreign Key Constraint','Adding quantity_units column to drug_order table',NULL,'2.0.5'),('201312161713-TRUNK-4129','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10555,'EXECUTED','3:2e13513e97a1c372818bd9ad1f31c219','Modify data type','Changing quantity column of drug_order to double',NULL,'2.0.5'),('201312162044-TRUNK-4126','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10552,'EXECUTED','3:31378c39bfdf55ec4ec6faff20c9dcf8','Add Column','Adding duration column to drug_order table',NULL,'2.0.5'),('201312162059-TRUNK-4126','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10553,'EXECUTED','3:f6f21104c2e85bacbbe9af09fee348fd','Add Column, Add Foreign Key Constraint','Adding duration_units column to drug_order table',NULL,'2.0.5'),('20131217-TRUNK-4142','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10551,'EXECUTED','3:5c29916ae374ae0cb36ecbf4a9c80e8c','Add Column','Adding comment_to_fulfiller column to orders table',NULL,'2.0.5'),('20131217-TRUNK-4157','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10550,'EXECUTED','3:8553abd1173bf56dad911a11ec0924ce','Add Column','Adding dosing_instructions column to drug_order table',NULL,'2.0.5'),('201312171559-TRUNK-4159','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10549,'EXECUTED','3:0735c719adcee97fbe967460d05bb474','Create Table, Add Foreign Key Constraint (x4)','Create the order_frequency table',NULL,'2.0.5'),('201312181649-TRUNK-4137','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10562,'EXECUTED','3:278cff9c9abc7864dd71bf4cba04c885','Add Column, Add Foreign Key Constraint','Adding frequency column to test_order table',NULL,'2.0.5'),('201312181650-TRUNK-4137','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10563,'EXECUTED','3:c28fa1a77bec305b4d8d23fda254f320','Add Column','Adding number_of_repeats column to test_order table',NULL,'2.0.5'),('201312182214-TRUNK-4136','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10556,'EXECUTED','3:5091764b71670065672afcb69d18efae','Add Column, Add Foreign Key Constraint','Adding route column to drug_order table',NULL,'2.0.5'),('201312182223-TRUNK-4136','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10557,'EXECUTED','3:aea033991dfc56954d1661fdf15c35f7','Drop Column','Dropping equivalent_daily_dose column from drug_order table',NULL,'2.0.5'),('201312191200-TRUNK-4167','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10558,'EXECUTED','3:b6a84072096cf71ca37dc160d0422a2d','Add Column','Adding dose_units column to drug_order table',NULL,'2.0.5'),('201312191300-TRUNK-4167','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10559,'EXECUTED','3:c1bb6f3394f9c391288f2d51384edd3e','Add Foreign Key Constraint','Adding foreignKey constraint on dose_units',NULL,'2.0.5'),('201312201200-TRUNK-4167','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10560,'MARK_RAN','3:c72cd1725e670ea735fc45e6f0f31001','Custom Change','Migrating old text units to coded dose_units in drug_order',NULL,'2.0.5'),('201312201425-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10566,'MARK_RAN','3:e6e37b7b995e2da28448f815211648fd','Update Data','Setting order.discontinued_reason to null for stopped orders',NULL,'2.0.5'),('201312201523-TRUNK-4138','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10565,'EXECUTED','3:8d48725ba6d40d8a19acec61c948a52f','Custom Change','Creating Discontinue Order for discontinued orders',NULL,'2.0.5'),('201312201525-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10567,'MARK_RAN','3:c751cbf452be8b2c05af6d6502ff5dc9','Update Data','Setting orders.discontinued_reason_non_coded to null for stopped orders',NULL,'2.0.5'),('201312201601-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10569,'EXECUTED','3:43505eb22756ea5ec6bee4f8ad750034','Drop Foreign Key Constraint','Dropping fk constraint on orders.discontinued_by column to users.user_id column',NULL,'2.0.5'),('201312201640-TRUNK-4138','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10564,'EXECUTED','3:174ed15d1066200fe48c3ed2b7a262ae','Rename Column','Rename orders.discontinued_date to date_stopped',NULL,'2.0.5'),('201312201651-TRUNK-4138','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10568,'EXECUTED','3:2ccbe6dad392099d9b6dc49e40736879','Drop Column','Removing discontinued from orders',NULL,'2.0.5'),('201312201700-TRUNK-4138','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10570,'EXECUTED','3:1c570e49534bf886108654c28a99bede','Drop Column','Removing discontinued_by from orders',NULL,'2.0.5'),('201312201800-TRUNK-4167','banka','liquibase-update-to-latest.xml','2016-03-07 11:44:43',10561,'EXECUTED','3:8ff2338c8a1df329476e9e60c8ddc7f6','Drop Column','Deleting units column',NULL,'2.0.5'),('201312271822-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10576,'EXECUTED','3:9e6ef6a4a036e5ff027a6c49557b2939','Create Table, Add Foreign Key Constraint (x3)','Adding care_setting table',NULL,'2.0.5'),('201312271823-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10577,'EXECUTED','3:036031e437f2baae976f103900455644','Insert Row','Adding OUTPATIENT care setting',NULL,'2.0.5'),('201312271824-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10578,'EXECUTED','3:b78e4eb1e63a9ca78a51c42f1e2edb00','Insert Row','Adding INPATIENT care setting',NULL,'2.0.5'),('201312271826-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10579,'EXECUTED','3:142266f644d20a834b2c687abf45f019','Add Column','Add care_setting column to orders table',NULL,'2.0.5'),('201312271827-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10580,'MARK_RAN','3:ba1d0716249a5f1bde5eec83c190400f','Custom SQL','Set default value for orders.care_setting column for existing rows',NULL,'2.0.5'),('201312271828-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10581,'EXECUTED','3:7c6fcd23f2fdbcc69ad06bcdd34cb56f','Add Not-Null Constraint','Make care_setting column non-nullable',NULL,'2.0.5'),('201312271829-TRUNK-4156','vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:45',10582,'EXECUTED','3:dc55b130e1d56c8df00b06a5dedd2689','Add Foreign Key Constraint','Add foreign key constraint',NULL,'2.0.5'),('201401031433-TRUNK-4135','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10571,'EXECUTED','3:1e90a9f5f6ffab47ac360dec7497d2f9','Rename Column','Temporarily renaming drug_order.frequency column to frequency_text',NULL,'2.0.5'),('201401031434-TRUNK-4135','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:44',10572,'EXECUTED','3:59eef75e78e64cdc999a6d25863c921d','Add Column, Add Foreign Key Constraint','Adding the frequency column to the drug_order table',NULL,'2.0.5'),('201401040436-TRUNK-3919','dkithmal','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10517,'EXECUTED','3:2fde2a2c0d2a917cd7ec0dfc990b96ac','Add Column, Add Foreign Key Constraint','Add changed_by column to location_tag table',NULL,'2.0.5'),('201401040438-TRUNK-3919','dkithmal','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10518,'EXECUTED','3:134b00185f7b61d7d6cccb66717dc4ae','Add Column','Add date_changed column to location_tag table',NULL,'2.0.5'),('201401040440-TRUNK-3919','dkithmal','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10519,'EXECUTED','3:2f3b927e3554c31abebb064835da2efc','Add Column, Add Foreign Key Constraint','Add changed_by column to location table',NULL,'2.0.5'),('201401040442-TRUNK-3919','dkithmal','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10520,'EXECUTED','3:6cf087a28acd99c02c00fd719a26e73b','Add Column','Add date_changed column to location table',NULL,'2.0.5'),('201401101647-TRUNK-4187','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10521,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checks that all existing free text drug order dose units and frequencies have been mapped to\n            concepts, this will fail the upgrade process if any unmapped text is found',NULL,'2.0.5'),('201402041600-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:45',10584,'EXECUTED','3:a09f49aa170ede88187564ce4834956e','Drop Foreign Key Constraint','Temporary dropping foreign key on orders.discontinued_reason column',NULL,'2.0.5'),('201402041601-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:45',10585,'EXECUTED','3:09293693ccab9bd63f0bacbf1229e6b5','Rename Column','Renaming orders.discontinued_reason column to order_reason',NULL,'2.0.5'),('201402041602-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:45',10586,'EXECUTED','3:b93897a56c7e2407d694bd47b9f3ff56','Add Foreign Key Constraint','Adding back foreign key on orders.discontinued_reason column',NULL,'2.0.5'),('201402041604-TRUNK-4138','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:45',10587,'EXECUTED','3:bf80640132c97067d42dabbebd10b7df','Rename Column','Renaming orders.discontinued_reason_non_coded column to order_reason_non_coded',NULL,'2.0.5'),('201402042238-TRUNK-4202','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10589,'MARK_RAN','3:e74c6d63ac01908cc6fb6f3e9b15e2e0','Custom Change','Converting orders.orderer to reference provider.provider_id',NULL,'2.0.5'),('201402051638-TRUNK-4202','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10588,'EXECUTED','3:ddff1dba0827858324336de9baeb93aa','Drop Foreign Key Constraint','Temporarily removing foreign key constraint from orders.orderer column',NULL,'2.0.5'),('201402051639-TRUNK-4202','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10590,'EXECUTED','3:32f643ae7a3cafe84fc11208e116cbf0','Add Foreign Key Constraint','Adding foreign key constraint to orders.orderer column',NULL,'2.0.5'),('201402120720-TRUNK-3902','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10600,'MARK_RAN','3:7ce90e7459b6b840b7d3f246b6ca697b','Rename Column','Rename concept_numeric.precise to concept_numeric.allow_decimal',NULL,'2.0.5'),('201402241055','Akshika','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10536,'EXECUTED','3:10f872c80393f2cb4d1126ec59b54676','Modify Column','Making orders.start_date not nullable',NULL,'2.0.5'),('201402281648-TRUNK-4274','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10537,'EXECUTED','3:1efc6af34de0b0e83ce217febe1c9fa7','Modify Column','Making order.encounter required',NULL,'2.0.5'),('201403011348','alexisduque','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10591,'EXECUTED','3:117c4ea0b0cd79e21a59b5769d020c93','Modify Column','Make orders.orderer not NULLable',NULL,'2.0.5'),('20140304-TRUNK-4170-duplicateLocationAttributeTypeNameChangeSet','harsz89','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10601,'MARK_RAN','3:b74878260cae25b9c209d1b6ea5ddb98','Custom Change','Custom changeset to identify and resolve duplicate Location Attribute Type names',NULL,'2.0.5'),('20140304-TRUNK-4170-location_attribute_type_unique_name','harsz89','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10602,'EXECUTED','3:e11205616b3ee4ad727a2c5031dee884','Add Unique Constraint','Adding the unique constraint to the location_attribute_type.name column',NULL,'2.0.5'),('20140304816-TRUNK-4139','Akshika','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10593,'EXECUTED','3:0d0ffd19df0598f644c863d931abccd2','Add Column','Adding scheduled_date column to orders table',NULL,'2.0.5'),('201403061758-TRUNK-4284','Banka, Vinay','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10592,'EXECUTED','3:008c6f185b3c571b57031314beda2b8f','Insert Row','Inserting Frequency concept class',NULL,'2.0.5'),('201403070132-TRUNK-4286','andras-szell','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10535,'EXECUTED','3:292b7549e0ae96619a6e4fcc30383592','Insert Row','Insert order type for test orders',NULL,'2.0.5'),('20140313-TRUNK-4288','dszafranek','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10594,'EXECUTED','3:3f2f0f3c1bcfe74253de58d32f811e11','Create Table, Add Foreign Key Constraint (x2), Add Primary Key','Add order_type_class_map table',NULL,'2.0.5'),('20140314-TRUNK-4283','dszafranek, wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10522,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking that all orders have start_date column set',NULL,'2.0.5'),('20140316-TRUNK-4283','dszafranek, wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10524,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking that all orders have encounter_id column set',NULL,'2.0.5'),('20140318-TRUNK-4265','jkondrat','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10595,'EXECUTED','3:01f3e7e45562865ed7855cea0b7ccd30','Merge Column, Update Data','Concatenate dose_strength and units to form the value for the new strength field',NULL,'2.0.5'),('201403262140-TRUNK-4265','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10525,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking if there are any drugs with the dose_strength specified but no units',NULL,'2.0.5'),('201404091110','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10526,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking if order_type table is already up to date or can be updated automatically',NULL,'2.0.5'),('201404091112','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10530,'EXECUTED','3:2bf52dfa949ba06b05016ce4eb08034b','Add Unique Constraint','Adding unique key constraint to order_type.name column',NULL,'2.0.5'),('201404091128','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10531,'EXECUTED','3:f96fd12ecf53fb18143450f7a0b9c1d9','Add Column','Adding java_class_name column to order_type table',NULL,'2.0.5'),('201404091129','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10532,'EXECUTED','3:d018fdec6bcd0775032bd8df67f57a77','Add Column','Adding parent column to order_type table',NULL,'2.0.5'),('201404091131','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10534,'EXECUTED','3:accf143fbe21963d2ea7fb211424ed4f','Add Not-Null Constraint','Add not-null constraint on order_type.java_class_name column',NULL,'2.0.5'),('201404091516','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10596,'EXECUTED','3:8c5d2f8c49bf08514911c24f60c065e0','Add Column, Add Foreign Key Constraint','Add changed_by column to order_type table',NULL,'2.0.5'),('201404091517','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10597,'EXECUTED','3:24b9f5757f0dec2a910daab2dd138ce1','Add Column','Add date_changed column to order_type table',NULL,'2.0.5'),('201404101130','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10533,'EXECUTED','3:0b986790bfacfc61e7ec851a4e4fbded','Update Data','Setting java_class_name column for drug order type row',NULL,'2.0.5'),('201406201443','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10598,'EXECUTED','3:c1cf2edbf71074e2740d975d89ca202d','Add Column','Add brand_name column to drug_order table',NULL,'2.0.5'),('201406201444','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:46',10599,'EXECUTED','3:da7c9042e009a4cbe61746bd8bf13d12','Add Column','Add dispense_as_written column to drug_order table',NULL,'2.0.5'),('201406211643-TRUNK-4401','harsz89','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10528,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking that all discontinued orders have the discontinued_date column set',NULL,'2.0.5'),('201406211703-TRUNK-4401','harsz89','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10529,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking that all discontinued orders have the discontinued_by column set',NULL,'2.0.5'),('201406262016','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10527,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking that all users that created orders have provider accounts',NULL,'2.0.5'),('20140635-TRUNK-4283','dszafranek, wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:42',10523,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Checking that all orders have orderer column set',NULL,'2.0.5'),('20140715-TRUNK-2999-remove_concept_word','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10603,'EXECUTED','3:4ff8bd1176165ac45c42809673d7d12d','Drop Table','Removing the concept_word table (replaced by Lucene)',NULL,'2.0.5'),('20140718-TRUNK-2999-remove_update_concept_index_task','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10604,'EXECUTED','3:a0ca6ff43de07e00f6a494c5b2964de5','Delete Data','Deleting the update concept index task',NULL,'2.0.5'),('20140719-TRUNK-4445-update_dosing_type_to_varchar_255','mihir','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10607,'EXECUTED','3:2948bf1441141d7f36e34cea1cdfb72a','Modify data type','Increase size of dosing type column to 255 characters',NULL,'2.0.5'),('20140724-1528','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10605,'EXECUTED','3:ad5fee02995c649c4b87d5991f5f3723','Drop Default Value','Dropping default value for drug_order.drug_inventory_id',NULL,'2.0.5'),('20140801-TRUNK-4443-rename_order_start_date_to_date_activated','bharti','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10606,'EXECUTED','3:fde9246d6d3b98ac8e64361818ece22c','Rename Column','Renaming the start_date in order table to date_activated',NULL,'2.0.5'),('201408200733-TRUNK-4446','Deepak','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10608,'EXECUTED','3:95a533365792e76a4cd95f8f32c887db','Modify data type','Changing duration column of drug_order to int',NULL,'2.0.5'),('201409230113-TRUNK-3484','k-joseph','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10611,'MARK_RAN','3:7a9c7aad5b657556b1103510f8bfc1d9','Update Data','Updating description for visits.encounterTypeToVisitTypeMapping GP to the value set in OpenmrsContants',NULL,'2.0.5'),('20141010-trunk-4492','alec','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10613,'MARK_RAN','3:fbe1f44dafa30068cd7c99a6713f8ee4','Drop Column','Dropping the tribe field from patient table because it has been moved to person_attribute.',NULL,'2.0.5'),('201410291606-TRUNK-3474','jbuczynski','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10614,'EXECUTED','3:03757abe17abedb9ac1cf0b933a35139','Drop Not-Null Constraint','Dropping not null constraint from program.description column',NULL,'2.0.5'),('201410291613-TRUNK-3474','jbuczynski','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10615,'EXECUTED','3:32fa9bee757a0ca295e1545662051b96','Drop Not-Null Constraint','Dropping not null constraint from order_type.description column',NULL,'2.0.5'),('201410291614-TRUNK-3474','jbuczynski','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10616,'EXECUTED','3:8623cbc44ba289fa096e0b5ee4eeaf11','Drop Not-Null Constraint','Dropping not null constraint from concept_name_tag.description column',NULL,'2.0.5'),('201410291616-TRUNK-3474','jbuczynski','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10617,'EXECUTED','3:4393a565e9dad85e69c1cfcd9836d957','Drop Not-Null Constraint','Dropping not null constraint from active_list_type.description column',NULL,'2.0.5'),('20141103-1030','wyclif','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10618,'EXECUTED','3:2b1a52ce2e496ec391e63ce4d9758226','Add Column','Adding form_namespace_and_path column to obs table',NULL,'2.0.5'),('201411101055-TRUNK-3386','pmuchowski','liquibase-update-to-latest.xml','2017-04-04 15:46:18',11052,'EXECUTED','3:5466877cc0a9f1650946e60ac1dd8f95','Drop Foreign Key Constraint','Temporarily removing foreign key constraint from person_attribute_type.edit_privilege column',NULL,'2.0.5'),('201411101056-TRUNK-3386','pmuchowski','liquibase-update-to-latest.xml','2017-04-04 15:46:19',11053,'EXECUTED','3:d18bc8c26a77e093bc9d0514b646a6b4','Drop Foreign Key Constraint','Temporarily removing foreign key constraint from role_privilege.privilege column',NULL,'2.0.5'),('201411101057-TRUNK-3386','pmuchowski','liquibase-update-to-latest.xml','2017-04-04 15:46:19',11054,'EXECUTED','3:b5f33650ea723f2304f40fd60fde36df','Modify Column','Increasing the size of the privilege column in the privilege table',NULL,'2.0.5'),('201411101058-TRUNK-3386','pmuchowski','liquibase-update-to-latest.xml','2017-04-04 15:46:20',11055,'EXECUTED','3:b1811e5e43321192b275d6e2fe2fa564','Add Foreign Key Constraint','Adding foreign key constraint to person_attribute_type.edit_privilege column',NULL,'2.0.5'),('201411101106-TRUNK-3386','pmuchowski','liquibase-update-to-latest.xml','2017-04-04 15:46:20',11056,'EXECUTED','3:96a937a1719f8e7a98ad682a5608f54b','Modify Column','Increasing the size of the privilege column in the role_privilege table',NULL,'2.0.5'),('201411101107-TRUNK-3386','pmuchowski','liquibase-update-to-latest.xml','2017-04-04 15:46:21',11057,'EXECUTED','3:f45e009851c4fe5205f8af48e9c50932','Add Foreign Key Constraint','Adding foreign key constraint to role_privilege.privilege column',NULL,'2.0.5'),('20141121-TRUNK-2193','raff','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10619,'EXECUTED','3:5c3daa4f68e3e650f53b63496a831295','Rename Column','Renaming drug_ingredient.quantity to strength',NULL,'2.0.5'),('20150108-TRUNK-14','rpuzdrowski','liquibase-update-to-latest.xml','2017-04-04 15:46:17',11050,'EXECUTED','3:4e2fc96ab67a318ad72af666c87338f6','Delete Data','Removing dashboard.regimen.standardRegimens global property',NULL,'2.0.5'),('20150108-TRUNK-3849','rpuzdrowski','liquibase-update-to-latest.xml','2017-04-04 15:46:17',11049,'EXECUTED','3:ed544a52366a48b1658b1eb4536cdc57','Custom Change','Updating layout.address.format global property',NULL,'2.0.5'),('20150109-0505','Shruthi, Sravanthi','liquibase.xml','2016-03-07 11:59:49',10692,'EXECUTED','3:dac719171dae4edcff51cef778e34756','Create Table','',NULL,'2.0.5'),('20150109-0521','Shruthi, Sravanthi','liquibase.xml','2016-03-07 11:59:50',10694,'EXECUTED','3:7c55ee9f0149c0c645c0d8f566c42011','Create Index','Creating unique index on condition.uuid column',NULL,'2.0.5'),('20150109-0627','Shruthi, Sravanthi','liquibase.xml','2016-03-07 11:59:49',10693,'EXECUTED','3:643c49c1108fd96b387efa2b8b832252','Add Foreign Key Constraint (x6)','',NULL,'2.0.5'),('20150122-1414','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10332,'EXECUTED','3:b662cac19085b837d902916f20a27da9','Update Data','Reverting concept name type to NULL for concepts having names tagged as default',NULL,'2.0.5'),('20150122-1420','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:32',10333,'EXECUTED','3:c75793ade72db0648a912f22f79cf461','Update Data, Delete Data (x2)','Setting concept name type to fully specified for names tagged as default',NULL,'2.0.5'),('20150211-TRUNK-3709','jkondrat','liquibase-update-to-latest.xml','2017-04-04 15:46:17',11051,'EXECUTED','3:7bd643a06ee8be02d6ac6525cb46ba4d','Custom Change','Encrypting the users.secret_answer column',NULL,'2.0.5'),('20150221-1644','sandeepraparthi','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11058,'EXECUTED','3:cb0a34ee94fec9d095c7d6819c077236','Add Foreign Key Constraint','Adding foreign key on patient_identifier.patient_id column',NULL,'2.0.5'),('20150428-TRUNK-4693-1','mseaton','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10609,'MARK_RAN','3:599624d822c5f7a0d9bc796c4e90a526','Drop Foreign Key Constraint','Removing invalid foreign key constraint from order_type.parent column to order.order_id column',NULL,'2.0.5'),('20150428-TRUNK-4693-2','mseaton','liquibase-update-to-latest.xml','2016-03-07 11:44:47',10610,'EXECUTED','3:706418216753f16ce1b5eb0c45c21e24','Add Foreign Key Constraint','Adding foreign key constraint from order_type.parent column to order_type.order_type_id column',NULL,'2.0.5'),('201506051103-TRUNK-4727','Chethan, Preethi','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10620,'EXECUTED','3:91fd51bed950b30f1b0532b5bdc041cc','Add Column','Adding birthtime column to person',NULL,'2.0.5'),('201506192000-TRUNK-4729','thomasvandoren','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11059,'EXECUTED','3:ea29af89837304bac680fc2e5340ae11','Add Column, Add Foreign Key Constraint','Add changed_by column to encounter_type table',NULL,'2.0.5'),('201506192001-TRUNK-4729','thomasvandoren','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11060,'EXECUTED','3:1491cbc4adf0c9c8f680af62c29e1db1','Add Column','Add date_changed column to encounter_type table',NULL,'2.0.5'),('201508111304','sns.recommind','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10621,'EXECUTED','3:75a849aa0d9c54bb2e052e6a8875d443','Create Index','Add an index to the global_property.property column',NULL,'2.0.5'),('201508111412','sns.recommind','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10622,'EXECUTED','3:226edcaabe81261347e3da63e5321b3f','Create Index','Add an index to the concept_class.name column',NULL,'2.0.5'),('201508111415','sns.recommind','liquibase-update-to-latest.xml','2016-03-07 11:44:49',10623,'EXECUTED','3:ee7859e5c5d801c0125fe02449c1c53b','Create Index','Add an index to the concept_datatype.name column',NULL,'2.0.5'),('201509281653','Sravanthi','liquibase-update-to-latest.xml','2016-03-07 11:44:49',10624,'EXECUTED','3:9ed44be93c38d7ae04232ac31350e4a9','Add Column','Add drug_non_coded column to drug_order table',NULL,'2.0.5'),('20151006-1530','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:23',11071,'EXECUTED','3:06963e7ad04d1badb8b7acbc22320e25','Create Table, Add Foreign Key Constraint (x3)','Create order_set table',NULL,'2.0.5'),('20151006-1537','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11072,'EXECUTED','3:66978ee657bf1c50dd651a65a7d33c81','Create Table, Add Foreign Key Constraint (x6)','Create order_set_member table',NULL,'2.0.5'),('20151007-TRUNK-4747-remove_active_list','jdegraft','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11067,'EXECUTED','3:ddeb98bc454cd172cf23a143c3f07af7','Drop Table','Removing the active_list table (active_list feature removed)',NULL,'2.0.5'),('20151007-TRUNK-4747-remove_active_list_allergy','jdegraft','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11066,'EXECUTED','3:e4eecfa5a1478c860e4e462379ead3d5','Drop Table','Removing the active_list_allergy table (active_list feature removed)',NULL,'2.0.5'),('20151007-TRUNK-4747-remove_active_list_problem','jdegraft','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11065,'EXECUTED','3:d4eec429e83ff5421dee72e3ee1fd1f7','Drop Table','Removing the active_list_problem table (active_list feature removed)',NULL,'2.0.5'),('20151007-TRUNK-4747-remove_active_list_type','jdegraft','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11068,'EXECUTED','3:9453cbf61659aaf9eb563a8fbda6c131','Drop Table','Removing the active_list_type table (active_list feature removed)',NULL,'2.0.5'),('20151022-TRUNK-4750','gwasilwa','liquibase-update-to-latest.xml','2017-04-04 15:46:23',11069,'EXECUTED','3:fe04f767fed4fe3a2fd2461fbe15b5b6','Add Column (x2)','Adding address columns (7-15) to person_address and location',NULL,'2.0.5'),('20151118-1630','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11073,'EXECUTED','3:de7d1ad9f5f6f8423e81390026ff7b84','Create Table, Add Foreign Key Constraint (x6)','Create order_group table',NULL,'2.0.5'),('20151118-1640','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11074,'EXECUTED','3:1c0cf8c1d759b2bccaca0a609067f907','Add Column, Add Foreign Key Constraint','Adding \'order_group_id\' column to orders table',NULL,'2.0.5'),('20151218-1530','Rahul,Swathi','liquibase.xml','2016-03-07 12:10:37',11012,'EXECUTED','3:90e2618c9aababca7c9d57d15fe83c00','Create Table, Add Foreign Key Constraint (x4)','',NULL,'2.0.5'),('20151218-1530-create-program_attribute_type-table','Rahul,Swathi','liquibase.xml','2016-03-07 12:10:37',11011,'EXECUTED','3:a5bbca42dd2b1b9ea988769126a8e9ce','Create Table, Add Foreign Key Constraint (x3)','Creating program_attribute_type table',NULL,'2.0.5'),('20160119-1146','Shashi, Hanisha','liquibase.xml','2016-03-07 11:59:41',10633,'EXECUTED','3:595d1d745d280e654049fe71e62be8ac','Add Column','Creating column date_created for queue table. This indicates the time event was raised or created.',NULL,'2.0.5'),('20160201-TRUNK-1505','mnagasowmya','liquibase-update-to-latest.xml','2017-04-04 15:46:23',11070,'EXECUTED','3:9c97e75128a28381cff1da7c8cae7bb1','Drop Column','Removing a column value_boolean from obs table',NULL,'2.0.5'),('20160202-1743','rkorytkowski','liquibase-update-to-latest.xml','2016-03-07 11:44:50',10626,'EXECUTED','3:0b6ba212979a943d1ce2e07e09dd40c0','Add Not-Null Constraint (x53)','Set uuid columns to \"NOT NULL\", if not set already for 1.9.x tables',NULL,'2.0.5'),('20160208-1819','rnjn/vinay','liquibase.xml','2016-03-07 12:10:37',11013,'EXECUTED','3:fd50711cc391240e47ff04989759d524','Create Table','',NULL,'2.0.5'),('20160208-1820','rnjn/vinay','liquibase.xml','2016-03-07 12:10:37',11014,'EXECUTED','3:4fdfccd0d5536ba72b88fe42bde31f73','Create Table, Add Foreign Key Constraint (x2)','',NULL,'2.0.5'),('20160208-1821','rnjn/vinay','liquibase.xml','2016-03-07 12:10:37',11015,'EXECUTED','3:d2ec6109d60fc9d1bb5b6c523f5f2347','Create Table, Add Foreign Key Constraint (x2)','',NULL,'2.0.5'),('20160208-1822','rnjn/vinay','liquibase.xml','2016-03-07 12:10:37',11016,'EXECUTED','3:1dfb56b876d377131a1db9088511e100','Create Index (x2)','',NULL,'2.0.5'),('20160212-1020','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11075,'EXECUTED','3:0fbe96fc908fbcbda8a69ec0daee17c8','Add Column','Adding \'sort_weight\' column to orders table',NULL,'2.0.5'),('20160216-1700','bahmni','liquibase-update-to-latest.xml','2016-03-07 11:44:49',10625,'EXECUTED','3:31fcb8b252da71f39ea960904ca28936','Custom Change','Set uuid for columns in all tables which has uuid as null. This is required for successful run of next changeSet.',NULL,'2.0.5'),('20160226-0222','Shan,Hanisha','liquibase.xml','2016-03-07 12:10:37',11018,'EXECUTED','3:1b94dd7a60d2d3a1ae764b58fab5e571','Custom SQL','Add role for Enrolling patient to program',NULL,'2.0.5'),('20160302-1225','Shan,Hanisha','liquibase.xml','2016-03-07 12:10:37',11019,'EXECUTED','3:9e397729560bb2ae143e646dcc455284','Insert Row','',NULL,'2.0.5'),('20160302-1226','Shan,Hanisha','liquibase.xml','2016-03-07 12:10:37',11020,'EXECUTED','3:7ddb68724f39323415c308ef1586c46f','Insert Row','',NULL,'2.0.5'),('20160302-1230','Shan,Hanisha','liquibase.xml','2016-03-07 12:10:37',11021,'EXECUTED','3:86ddbb9d1c3d2f9a6bc396ca0f6b1799','Insert Row','',NULL,'2.0.5'),('20160302-1231','Shan,Hanisha','liquibase.xml','2016-03-07 12:10:37',11022,'EXECUTED','3:558086dc0d4ba2eec693058348361453','Insert Row (x8)','Add (Get People) privilege to Clinical:FullAccess role',NULL,'2.0.5'),('20160302-1822','vinay','liquibase.xml','2016-03-07 12:10:37',11017,'EXECUTED','3:1fbb14bc13f004184356e6ff3b183aba','Custom SQL','Update custom encounter session matcher',NULL,'2.0.5'),('20160322153797','Jaswanth, Hemanth','liquibase.xml','2017-04-04 15:47:14',11122,'EXECUTED','3:58e5395e44a614d1d70abf254584bcbb','Create Index','Add index on date_stopped column for bed_patient_assignment_map table',NULL,'2.0.5'),('201603221630968','Jaswanth, Hemanth','liquibase.xml','2017-04-04 15:47:14',11123,'EXECUTED','3:e479176a83aa68511c1eda6be8a48d1e','Create Index','Add index on date_stopped column for visit table',NULL,'2.0.5'),('20160329-176','Pankaj, Achinta','liquibase.xml','2017-04-04 15:47:14',11124,'EXECUTED','3:fe40d17d061919cbbf69d2fe95a0b9c3','Custom SQL','Make allow decimal checkbox checked for all numeric concept',NULL,'2.0.5'),('201604261630','Gautam','liquibase.xml','2017-04-04 15:47:14',11125,'EXECUTED','3:edf189ea73fb69f049f23575531740a2','SQL From File','SQL query to get list of active patients by location',NULL,'2.0.5'),('20160427-0950-create-concept-attribute-type-table','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11078,'EXECUTED','3:0774f375dca107b8b9e9598e5e8b678d','Create Table, Add Foreign Key Constraint (x3)','Creating concept_attribute_type table',NULL,'2.0.5'),('20160427-0954-create-concept-attribute-table','bahmni','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11079,'EXECUTED','3:884497a0ea7aa5bfdb54e9b88dbd69ad','Create Table, Add Foreign Key Constraint (x5)','Creating concept_attribute table',NULL,'2.0.5'),('201604281645','vishnuraom','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11076,'MARK_RAN','3:e7c592ad2ce7daac65ef41b156965b6f','Update Data','Converting values in drug_order.dosing_type column from SIMPLE to org.openmrs.SimpleDosingInstructions (TRUNK-4845)',NULL,'2.0.5'),('201604281646','vishnuraom','liquibase-update-to-latest.xml','2017-04-04 15:46:24',11077,'MARK_RAN','3:1d1ab904f45990de4459c25c170947d9','Update Data','Converting values in drug_order.dosing_type column from FREE_TEXT to org.openmrs.FreeTextDosingInstructions(TRUNK-4845)',NULL,'2.0.5'),('20160510-999','Pankaj, Achinta','liquibase.xml','2017-04-04 15:47:14',11126,'EXECUTED','3:9b4e6163fd0be15426da69f418f27971','Custom SQL','Creating Location Picker Privilege',NULL,'2.0.5'),('201605101601-999','Pankaj, Achinta','liquibase.xml','2017-04-04 15:47:14',11127,'EXECUTED','3:e2d31a52cac687f0472fdee0b1770717','Custom SQL','Creating On Behalf Of Privilege',NULL,'2.0.5'),('20160603-1739','angshu','liquibase.xml','2017-04-04 15:47:01',11087,'MARK_RAN','3:5db4ef15d594ec4dae9011474ae63e5d','Insert Row','Default chunking history entry if doesn\'t exist.',NULL,'2.0.5'),('20160705-1120','angshu','liquibase.xml','2017-04-04 15:47:01',11090,'EXECUTED','3:f0f21137ae90d294e6a077950af06d6f','Add Column','Creating column tags for queue table. Each event can be tagged with multiple tags; as comma separated strings',NULL,'2.0.5'),('20160705-1130','angshu','liquibase.xml','2017-04-04 15:47:01',11091,'EXECUTED','3:41b8a5c617806a66ae95d26ba2f0d4ea','Add Column','Creating column tags for event_records table. Each event can be tagged with multiple tags; as comma separated strings',NULL,'2.0.5'),('20160712-1977-1','Jaswanth/Sanjit','liquibase.xml','2017-04-04 15:47:01',11088,'EXECUTED','3:30554c65ac2f9189b3ab4f801a0f8420','Insert Row','Adding global property to act as switch for raising relationship events',NULL,'2.0.5'),('20160712-1977-2','Jaswanth/Sanjit','liquibase.xml','2017-04-04 15:47:01',11089,'EXECUTED','3:9696c4e0226db3ccfd2a54df589cd608','Insert Row','Adding global property to specify the URL pattern for published relationship events',NULL,'2.0.5'),('20160713-1978-1','Pankaj/Koushik','liquibase.xml','2017-04-04 15:47:01',11092,'EXECUTED','3:a66c8e110fc0d98b3c88c0d8064919cb','Insert Row','Adding global property to act as switch for raising program events',NULL,'2.0.5'),('20160713-1978-2','Pankaj/Koushik','liquibase.xml','2017-04-04 15:47:01',11093,'EXECUTED','3:d70070159e28d4fc60f9ce0259970336','Insert Row','Adding global property to specify the URL pattern for published program events',NULL,'2.0.5'),('201607281228','Preethi, Gaurav','liquibase.xml','2017-04-04 15:47:14',11131,'EXECUTED','3:290370593fac9235c541f8c24517fa38','Custom SQL','Drop unique constraint on identifier column in patient_identifier table',NULL,'2.0.5'),('201607291555','Preethi','liquibase.xml','2017-04-04 15:47:14',11132,'EXECUTED','3:ca10c75643f10d04256e630987ce8fc5','Custom SQL','Renaming Bahmni Id to Patient Identifer in patient_identifier_type table',NULL,'2.0.5'),('201609171146-1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:50',11166,'EXECUTED','3:4ae0233d1dc8353f1e7953e9b94e1d6c','Drop Foreign Key Constraint','Dropping foreign key constraint member_patient',NULL,'2.0.5'),('201609171146-1.1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:51',11167,'EXECUTED','3:b41e7c25b56556e171f0f2f1014aa77b','Drop Foreign Key Constraint','Dropping foreign key constraint parent_cohort',NULL,'2.0.5'),('201609171146-1.2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11168,'EXECUTED','3:001715ac3bf0251098a3e8e3acd91088','Drop Primary Key','Dropping primary key for cohort_member',NULL,'2.0.5'),('201609171146-2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11169,'EXECUTED','3:39c9ebe7a0725c60a9130ffaa89d052d','Add Column','Adding column cohort_member.cohort_member_id',NULL,'2.0.5'),('201609171146-2.1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11170,'MARK_RAN','3:64887895d69c4514681fdecfd041cccd','Custom Change','Updating cohort member ids',NULL,'2.0.5'),('201609171146-2.2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11171,'EXECUTED','3:21e13e1fb0cd4fc5f7deb3b3a8e5ce83','Add Primary Key','Adding primary key to cohort_member.cohort_member_id',NULL,'2.0.5'),('201609171146-2.3','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11172,'EXECUTED','3:26255259d5c2c15995d2348357209816','Set Column as Auto-Increment','Adding auto increment property to cohort_member.cohort_member_id',NULL,'2.0.5'),('201609171146-3','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11173,'EXECUTED','3:098004bb7849949c9080d477dd85dc2e','Add Column','Adding column cohort_member.start_date',NULL,'2.0.5'),('201609171146-4','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11175,'EXECUTED','3:69bc7198ca53f18736b19aaa771122cc','Add Column','Adding column cohort_member.end_date',NULL,'2.0.5'),('201609171146-5','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11176,'EXECUTED','3:ad6785a4c755084c8d69c22f652f0d04','Add Column','Adding column cohort_member.creator',NULL,'2.0.5'),('201609171146-5.1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11177,'MARK_RAN','3:28badb6004196919906fe8b95ef234b4','Update Data','Updating cohort_member.creator value',NULL,'2.0.5'),('201609171146-5.2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11178,'EXECUTED','3:a57dccd15ab8d4460b690c38633067bd','Add Foreign Key Constraint','Adding foreign key constraint to cohort_member.creator',NULL,'2.0.5'),('201610042145-1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11179,'EXECUTED','3:1d57722d5170e0aac7a01e25b7143342','Add Column','Adding column cohort_member.date_created',NULL,'2.0.5'),('201610042145-1.1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11180,'MARK_RAN','3:0b655a5bd27feb9c2612bfab99b43401','Update Data','Updating cohort_member.date_created with value cohort.date_created',NULL,'2.0.5'),('201610042145-2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11186,'EXECUTED','3:1f2c273b5119e083bac3428cced24cee','Add Column','Adding column cohort_member.uuid',NULL,'2.0.5'),('201610042145-2.1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11187,'EXECUTED','3:98f12e2601f17e285c3e0af187d41e88','Update Data','Generating UUIDs for all rows in cohort_member table via built in uuid function.',NULL,'2.0.5'),('201610042145-2.2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11188,'EXECUTED','3:f32469e8348bd87a0684142d2006e835','Add Unique Constraint','Adding unique constraint to cohort_member.uuid',NULL,'2.0.5'),('201610131530-1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11181,'EXECUTED','3:c9cdf7d006a5a6a7c7ccaf827fd7cec9','Add Column','Adding column cohort_member.voided',NULL,'2.0.5'),('201610131530-1.1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11182,'EXECUTED','3:352ad5c535c28235d75cd9617731db3e','Add Default Value','Adding defaultValue for cohort_member.voided',NULL,'2.0.5'),('201610131530-2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11183,'EXECUTED','3:a6bdaa65ce2a7ecda2383e543a10224f','Add Column','Adding column cohort_member.voided_by',NULL,'2.0.5'),('201610131530-3','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11184,'EXECUTED','3:0d6fa05f59b1153b70a2c055856042c0','Add Column','Adding column cohort_member.date_voided',NULL,'2.0.5'),('201610131530-4','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11185,'EXECUTED','3:7b66202d02acc9056fca82c62df0ea14','Add Column','Adding column cohort_member.void_reason',NULL,'2.0.5'),('201610242135-1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11189,'EXECUTED','3:d1f786fa12f2a8230eb579b657009edf','Add Foreign Key Constraint','Adding foreign key constraint to cohort_member.cohort_id',NULL,'2.0.5'),('201610242135-2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11190,'EXECUTED','3:f7fce679894e49fad34cad1f91ef2eac','Add Foreign Key Constraint','Adding foreign key constraint to cohort_member.patient_id',NULL,'2.0.5'),('201610242135-3','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11174,'MARK_RAN','3:a61042ee90a77f77fd9456dbe1afdfa9','Update Data','Updating cohort_start_date with value cohort.date_created',NULL,'2.0.5'),('201611121945-1','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11191,'EXECUTED','3:a722f0cd71934cc9c8577eac1572d736','Drop Default Value','Dropping defaultValue for cohort_member.cohort_id',NULL,'2.0.5'),('201611121945-2','vshankar','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11192,'EXECUTED','3:520865118b72339a432f57ff2b292672','Drop Default Value','Dropping defaultValue for cohort_member.patient_id',NULL,'2.0.5'),('201625111155','Sourav, Chethan','liquibase.xml','2017-10-30 14:22:03',11216,'EXECUTED','3:62ead9cec525e93a52f671ffb0f62c6e','Create Table, Add Foreign Key Constraint (x5)','Creating bed_tag_map table',NULL,'2.0.5'),('20170302-1225','sidtharthanan, Darius','liquibase.xml','2017-10-30 14:22:08',11259,'EXECUTED','3:1ca8c16cb88abe9b2e539c0074b0923c','Custom SQL','Add new concept for Follow-up Condition',NULL,'2.0.5'),('20170308-1000','Sidtharthan, Gaurav','liquibase.xml','2017-10-30 14:22:08',11252,'EXECUTED','3:9c9f141db8cbc0d822e97eee4c04fdba','Custom SQL','Add new concept for Non-Coded Condition',NULL,'2.0.5'),('20170707-TRUNK-5185-1','mogoodrich','liquibase-update-to-latest.xml','2017-10-30 14:21:49',11163,'EXECUTED','3:7cb50dd122227a05eff1b3c84b62b4a9','Create Index','Adding unique index on concept_reference_source uuid column',NULL,'2.0.5'),('20170707-TRUNK-5185-2','mogoodrich','liquibase-update-to-latest.xml','2017-10-30 14:21:50',11164,'EXECUTED','3:64612c379ed6debbb5966e4d0b2e6bc5','Create Index','Adding unique index on concept_reference_map uuid column',NULL,'2.0.5'),('20170829-1138','Suman M','liquibase.xml','2017-10-30 14:22:08',11260,'EXECUTED','3:52db618d13029371e152f9f47c082f04','Custom SQL','Update global property to handle null for family name',NULL,'2.0.5'),('201709201822','Santhosh, Pramida','liquibase.xml','2017-10-31 11:40:21',11282,'EXECUTED','3:10f6154266c92e192544e79ce69a1fb7','Custom SQL','Adding all the privileges to Appointments:FullAccess',NULL,'2.0.5'),('201709201833','Santhosh, Pramida','liquibase.xml','2017-10-31 11:40:21',11283,'EXECUTED','3:131e5f782dfb6d74e03e7752050089f4','Custom SQL','Adding all the privileges to Appointments: ReadOnly',NULL,'2.0.5'),('201709201839','Santhosh, Pramida','liquibase.xml','2017-10-31 11:40:21',11284,'EXECUTED','3:e880925dd17ee9ec0ff2391388a43e5c','Custom SQL','Adding all the privileges to Appointments: Manage',NULL,'2.0.5'),('27112013_1','tw','liquibase.xml','2016-03-07 11:59:45',10646,'EXECUTED','3:f748a92a8a51d282a218b24c0256b1c9','Add Column, Add Foreign Key Constraint','',NULL,'2.0.5'),('28112013_1','tw','liquibase.xml','2016-03-07 11:59:45',10647,'EXECUTED','3:fc6db60b0aec6e6499e681670e83294e','Add Column','',NULL,'2.0.5'),('28112013_10','tw','liquibase.xml','2016-03-07 11:59:45',10656,'EXECUTED','3:f0236cce1aee98a39a1ccad8d3c80fb8','Add Unique Constraint, Add Foreign Key Constraint (x3)','',NULL,'2.0.5'),('28112013_11','tw','liquibase.xml','2016-03-07 11:59:45',10657,'EXECUTED','3:a5a636212dc5badbbc2739440efb6579','Add Column','',NULL,'2.0.5'),('28112013_12','tw','liquibase.xml','2016-03-07 11:59:45',10658,'EXECUTED','3:1dadaa75f944e1b96d809e207a88b9d5','Add Column','',NULL,'2.0.5'),('28112013_13','tw','liquibase.xml','2016-03-07 11:59:45',10659,'EXECUTED','3:355af2bd4a801e1b74fdf8972df5d9f5','Add Column','',NULL,'2.0.5'),('28112013_14','tw','liquibase.xml','2016-03-07 11:59:45',10660,'EXECUTED','3:59a504947b790dccfc94c91867061bef','Add Column','',NULL,'2.0.5'),('28112013_15','tw','liquibase.xml','2016-03-07 11:59:45',10661,'EXECUTED','3:8503e2e68243a29ead81a4fa75085599','Add Column','',NULL,'2.0.5'),('28112013_16','tw','liquibase.xml','2016-03-07 11:59:45',10662,'EXECUTED','3:963de62ef5c72d0e26a1e83172e5a8c6','Add Column','',NULL,'2.0.5'),('28112013_17','tw','liquibase.xml','2016-03-07 11:59:45',10663,'EXECUTED','3:a43d20de3e4793fd696b0a4b42ba71c1','Add Column','',NULL,'2.0.5'),('28112013_18','tw','liquibase.xml','2016-03-07 11:59:45',10664,'EXECUTED','3:797d6dc5e563e8889991afec46013359','Add Column','',NULL,'2.0.5'),('28112013_19','tw','liquibase.xml','2016-03-07 11:59:45',10665,'EXECUTED','3:72b4a16431f23d84a38452899e006844','Add Column','',NULL,'2.0.5'),('28112013_2','tw','liquibase.xml','2016-03-07 11:59:45',10648,'EXECUTED','3:9667afd8ba177d1a0c8b7095db67bee0','Add Column','',NULL,'2.0.5'),('28112013_20','tw','liquibase.xml','2016-03-07 11:59:45',10666,'EXECUTED','3:b62edd5aad0e98106e2db03687bf28e3','Add Unique Constraint, Add Foreign Key Constraint (x3)','',NULL,'2.0.5'),('28112013_3','tw','liquibase.xml','2016-03-07 11:59:45',10649,'EXECUTED','3:3c7da130eff93427a563e2c87464e82a','Add Column','',NULL,'2.0.5'),('28112013_4','tw','liquibase.xml','2016-03-07 11:59:45',10650,'EXECUTED','3:801c3b23f47dd073edb009e0e1938877','Add Column','',NULL,'2.0.5'),('28112013_5','tw','liquibase.xml','2016-03-07 11:59:45',10651,'EXECUTED','3:98b6351c16b8ccd4493070d845f5b492','Add Column','',NULL,'2.0.5'),('28112013_6','tw','liquibase.xml','2016-03-07 11:59:45',10652,'EXECUTED','3:bac8dd40a71719501a27998d73b5d15c','Add Column','',NULL,'2.0.5'),('28112013_7','tw','liquibase.xml','2016-03-07 11:59:45',10653,'EXECUTED','3:df894febe79ae93215ba7fed49690912','Add Column','',NULL,'2.0.5'),('28112013_8','tw','liquibase.xml','2016-03-07 11:59:45',10654,'EXECUTED','3:f6a6cc311e0a08672fd7fe4cc940c244','Add Column','',NULL,'2.0.5'),('28112013_9','tw','liquibase.xml','2016-03-07 11:59:45',10655,'EXECUTED','3:12e78d20ae7b0ce95cfab7dac8444da7','Add Column','',NULL,'2.0.5'),('3-increase-privilege-col-size-person_attribute_type','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:40',10489,'EXECUTED','3:c2465b2417463d93f1101c6683f41250','Drop Foreign Key Constraint, Modify Column, Add Foreign Key Constraint','Increasing the size of the edit_privilege column in the person_attribute_type table',NULL,'2.0.5'),('add-clincal-app-role-for-program-app-201610261552','Kaustav, Hanisha','liquibase.xml','2017-04-04 15:47:14',11143,'EXECUTED','3:ee8d21a555eacfd3901cc5f365d91960','Custom SQL','Add Clinical-app role as sub role to Programs-app role',NULL,'2.0.5'),('add-correct-description-for-internal-roles','Jaswanth','liquibase.xml','2017-04-04 15:47:14',11142,'EXECUTED','3:930ddf40090df286796f189b5164e6fe','Custom SQL','Add correct description for internal roles',NULL,'2.0.5'),('add-module-column-to-auditlogtable-201706160509','Shruthi P,Pushpa','liquibase.xml','2017-10-30 14:22:01',11214,'EXECUTED','3:44ec56dfcfcc1d14ea66c5ee19897391','Custom SQL','',NULL,'2.0.5'),('add-privileges-to-roles-20161111','Ravindra','liquibase.xml','2017-04-04 15:47:14',11145,'EXECUTED','3:f322ee6780aa7f308b3630774415b186','Custom SQL','Add privileges to roles Clinical-App-Common(Get Order Sets), Registration-App(Delete Visits)',NULL,'2.0.5'),('add_changed_by_for_reporting_report_design','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11234,'MARK_RAN','3:6b4f816069cda1e48f3d9c5a329ae0d4','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_changed_by_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11238,'MARK_RAN','3:26bcc628ac6c8c2ddb7bf297eadfd6a6','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_changed_by_for_reporting_report_processor','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11242,'MARK_RAN','3:93e3e242966c6e4097eb43f42c6575f0','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_color_column_to_appointment_service_table-201707251432','Santhosh, Maharjun','liquibase.xml','2017-10-30 14:22:09',11274,'EXECUTED','3:49cc59a5bb9842b0e9c16bfb230f1536','Custom SQL','',NULL,'2.0.5'),('add_creator_for_reporting_report_design','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11233,'MARK_RAN','3:eee0f564c3ffe9546cff2e4d53b565cc','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_creator_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11237,'MARK_RAN','3:3d89b6d62ae28f8cbd23db415a335867','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_creator_for_reporting_report_processor','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11241,'MARK_RAN','3:b2a2210386c6e92b0e5a01d4715f7d48','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_report_definition_uuid_index','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11232,'MARK_RAN','3:3e82195b1dc87158b4a35557e2efdac6','Create Index','',NULL,'2.0.5'),('add_report_design_id_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11236,'MARK_RAN','3:e92ae5e78a4fe4e4bcff15db82fbed60','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_requested_by_for_reporting_report_request','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11240,'MARK_RAN','3:5ad8a98124cb9926fd19e01b60ada19e','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_retired_by_for_reporting_report_design','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11235,'MARK_RAN','3:d24d24b7c5355e065e106c5d6cd56f4a','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_retired_by_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11239,'MARK_RAN','3:d83ce3b2d54294365d6460e63c8c1e64','Add Foreign Key Constraint','',NULL,'2.0.5'),('add_retired_by_for_reporting_report_processor','mgoodrich','liquibase.xml','2017-10-30 14:22:06',11243,'MARK_RAN','3:aa21b7a845db22fcfedd5962aff5a02c','Add Foreign Key Constraint','',NULL,'2.0.5'),('appframework-1','djazayeri','liquibase.xml','2016-03-07 11:59:51',10701,'EXECUTED','3:1fff60c3e3407f96174f63eb875e3dd3','Create Table, Add Foreign Key Constraint (x2)','Create table for AppEnabled',NULL,'2.0.5'),('appframework-2','djazayeri','liquibase.xml','2016-03-07 11:59:51',10702,'EXECUTED','3:964d11f2c8a482d315341c315b705101','Drop Table','Drop table for AppEnabled, since we\'ll be using privileges instead',NULL,'2.0.5'),('appframework-3','nutsiepully','liquibase.xml','2016-03-07 11:59:51',10703,'EXECUTED','3:fdc791492c3f51ed1d97890bc099d284','Create Table','Create table to track which AppFramework components are enabled',NULL,'2.0.5'),('appframework-4','Wyclif','liquibase.xml','2016-03-07 11:59:51',10704,'EXECUTED','3:9a5638b21b279ff5fb44a268876bc1d3','Create Table','Create table to store user defined apps',NULL,'2.0.5'),('appointments_-201707031031','Shruthi P','liquibase.xml','2017-10-30 14:22:09',11269,'EXECUTED','3:71086ad8d10df350f0255856e2d36531','Custom SQL','Add Appointment Location Tag if not already added.',NULL,'2.0.5'),('assign-role-to-automation-user','Jaswanth','liquibase.xml','2017-04-04 15:47:14',11140,'MARK_RAN','3:89901c85885345eb69c8e3a504d23df8','Custom SQL','Assign role to automation user',NULL,'2.0.5'),('BACT-07012016103500','Bharat','liquibase.xml','2016-03-07 12:10:38',11024,'EXECUTED','3:3e8618e81fe87671efe5b451953f27b7','Custom SQL','',NULL,'2.0.5'),('BACT-08102015044642','Hemanth','liquibase.xml','2016-03-07 11:59:50',10695,'EXECUTED','3:825219957e04d360b2917d217d421228','Custom SQL','Creating a Bacteriology attributes concept class',NULL,'2.0.5'),('BACT-08102015045449','Hemanth','liquibase.xml','2016-03-07 11:59:50',10696,'EXECUTED','3:5f0a951a825091d185ce19d433e52d14','Custom SQL','Creating a Bacteriology Results concept class',NULL,'2.0.5'),('BACT-08102015054945','Hemanth','liquibase.xml','2016-03-07 11:59:50',10697,'EXECUTED','3:308ead97e53bd92f969cd2918c633b1c','Custom SQL','Insert concept reference source for CEIL concepts',NULL,'2.0.5'),('BACT-08102015054956','Hemanth','liquibase.xml','2016-03-07 11:59:50',10698,'EXECUTED','3:b18b17d6ceef9b53aa5eb22a8c9509bc','Custom SQL','Insert concept reference source for org.openmrs.module.bacteriology concepts',NULL,'2.0.5'),('BACT-08102015055156','Hemanth','liquibase.xml','2016-03-07 11:59:51',10699,'EXECUTED','3:a4adce4810a6e2a73a60e9b1ec5a2ea0','Custom SQL','Adding reference term for ceil concept source',NULL,'2.0.5'),('BACT-08102015063652','Hemanth','liquibase.xml','2016-03-07 11:59:51',10700,'EXECUTED','3:10a4b3102cfd3e1021a4a58b6c08f974','Custom SQL','Adding reference term for org.openmrs.module.bacteriology concept source',NULL,'2.0.5'),('BACT-08102015071559','Hemanth','liquibase.xml','2016-03-07 12:10:38',11023,'EXECUTED','3:186d4e2387774cdfc6e5b3e313e50489','Custom SQL','creating specimen sample source',NULL,'2.0.5'),('bahmni-1','tw','liquibase.xml','2016-03-07 12:10:33',10706,'EXECUTED','3:1fa8ea475c7e35cd9bcb5040bd294622','SQL From File','rel2',NULL,'2.0.5'),('bahmni-10','tw','liquibase.xml','2016-03-07 12:10:33',10713,'EXECUTED','3:73863097e856ba046dab35b909890730','SQL From File','rel2',NULL,'2.0.5'),('bahmni-11','tw','liquibase.xml','2016-03-07 12:10:33',10714,'EXECUTED','3:4eb9fcc5ce17fbf0a38995357e206adf','SQL From File','rel2',NULL,'2.0.5'),('bahmni-12','tw','liquibase.xml','2016-03-07 12:10:33',10715,'EXECUTED','3:ccbf2af31c91354755b145585f1adf43','SQL From File','rel2',NULL,'2.0.5'),('bahmni-16','tw','liquibase.xml','2016-03-07 12:10:33',10717,'EXECUTED','3:9596557aceeccee17eb9a9af5df316af','SQL From File','rel3',NULL,'2.0.5'),('bahmni-17','tw','liquibase.xml','2016-03-07 12:10:33',10718,'EXECUTED','3:2dced694dd0f4778a33490ab099ef756','SQL From File','rel3',NULL,'2.0.5'),('bahmni-19','tw','liquibase.xml','2016-03-07 12:10:33',10720,'EXECUTED','3:52d9923b31a58b0e2c1fb9c3d1d5aa25','SQL From File','rel3',NULL,'2.0.5'),('bahmni-2','tw','liquibase.xml','2016-03-07 12:10:33',10707,'EXECUTED','3:5b9223967ffc4864988813db4dc88be6','SQL From File','rel2',NULL,'2.0.5'),('bahmni-20','tw','liquibase.xml','2016-03-07 12:10:33',10721,'EXECUTED','3:51dff674d6df91159ea92847a3a9e970','SQL From File','rel3',NULL,'2.0.5'),('bahmni-201703061748','Shruthi P, Pushpa','liquibase.xml','2017-10-30 14:22:08',11249,'EXECUTED','3:772d4ea0231decd0c248d4d03e553d64','Custom SQL','update global property key \'emr.primaryIdentifierType\' to \'bahmni.primaryIdentifierType\'',NULL,'2.0.5'),('bahmni-201703061756','Shruthi P, Pushpa','liquibase.xml','2017-10-30 14:22:08',11250,'EXECUTED','3:2452abdc7344bde4fd2deb8c64af588a','Custom SQL','update global property key \'emr.extraPatientIdentifierTypes\' to \'bahmni.extraPatientIdentifierTypes\'',NULL,'2.0.5'),('bahmni-25','tw','liquibase.xml','2016-03-07 12:10:33',10725,'EXECUTED','3:89336c228d0063f50b24e7cc288793e5','SQL From File','rel3',NULL,'2.0.5'),('bahmni-26','tw','liquibase.xml','2016-03-07 12:10:33',10726,'EXECUTED','3:a2862e0129adc45ea27bcf46ba4a1698','SQL From File','rel3',NULL,'2.0.5'),('bahmni-27','tw','liquibase.xml','2016-03-07 12:10:33',10727,'EXECUTED','3:321fb0b2fbc8c0add1dac2fac4824068','SQL From File','rel3',NULL,'2.0.5'),('bahmni-28','tw','liquibase.xml','2016-03-07 12:10:33',10728,'EXECUTED','3:23f221251e83aecc4dd7a7111e7bb726','SQL From File','rel3',NULL,'2.0.5'),('bahmni-29','tw','liquibase.xml','2016-03-07 12:10:33',10729,'EXECUTED','3:0998fdf1cb16d20ac72d500b4a4abcf0','SQL From File','rel3',NULL,'2.0.5'),('bahmni-3','tw','liquibase.xml','2016-03-07 12:10:33',10708,'EXECUTED','3:3d717ca9342fb21a14ec999b6773e78f','SQL From File','rel2',NULL,'2.0.5'),('bahmni-30','tw','liquibase.xml','2016-03-07 12:10:33',10730,'EXECUTED','3:6404f5bea3bc91a0168a723ce0a945f7','Update Data','rel3',NULL,'2.0.5'),('bahmni-31','tw','liquibase.xml','2016-03-07 12:10:33',10716,'EXECUTED','3:845a3fea37de2528ca3a25dd9e181490','SQL From File','rel2',NULL,'2.0.5'),('bahmni-32','tw','liquibase.xml','2016-03-07 12:10:33',10731,'EXECUTED','3:57fb9812295f1692f9b83a0bcdaf4c06','SQL From File','rel3',NULL,'2.0.5'),('bahmni-33','tw','liquibase.xml','2016-03-07 12:10:33',10732,'EXECUTED','3:104cdb183cea698b8be017762c81efaf','SQL From File','rel3',NULL,'2.0.5'),('bahmni-35','tw','liquibase.xml','2016-03-07 12:10:33',10733,'EXECUTED','3:33d81235022388bf9b5a3e4d251c49ec','SQL From File','rel3',NULL,'2.0.5'),('bahmni-36','tw','liquibase.xml','2016-03-07 12:10:33',10734,'EXECUTED','3:7e9c42924c89c509275adda048d3f6a0','Custom SQL','Add investigations meta data',NULL,'2.0.5'),('bahmni-37','tw','liquibase.xml','2016-03-07 12:10:33',10746,'EXECUTED','3:f12d0201c6ad6833de572087e2d02b03','Custom SQL','Add job for processing reference data',NULL,'2.0.5'),('bahmni-38','tw','liquibase.xml','2016-03-07 12:10:33',10747,'EXECUTED','3:84c16b09199f9bf019ebac8755f6b778','Custom SQL','Add job for processing failed reference data',NULL,'2.0.5'),('bahmni-39','tw','liquibase.xml','2016-03-07 12:10:33',10748,'EXECUTED','3:390298a50c1fe5e8281e3763cde39f8a','Custom SQL','Update class name of reference data feed task and failed event task.',NULL,'2.0.5'),('bahmni-4','tw','liquibase.xml','2016-03-07 12:10:33',10709,'EXECUTED','3:86dabf0c08030df866a7bceaf0a5758e','SQL From File','rel2',NULL,'2.0.5'),('bahmni-5','tw','liquibase.xml','2016-03-07 12:10:33',10710,'EXECUTED','3:906a8aec030d1961ee3391a354cb6b68','SQL From File','rel2',NULL,'2.0.5'),('bahmni-7','tw','liquibase.xml','2016-03-07 12:10:33',10711,'EXECUTED','3:971ebef189662030a66c0763c0515aef','SQL From File','rel2',NULL,'2.0.5'),('bahmni-add-previliges-toinpatient-move-201514101850','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10984,'EXECUTED','3:954576ea2d823bfd7935c61c11a531f3','Custom SQL','Adding privileges to Inpatient-patient-movement',NULL,'2.0.5'),('bahmni-add-privilege-reports-role-201528101218','Jaswanth, Padma','liquibase.xml','2016-03-07 12:10:36',10988,'EXECUTED','3:a619b2df26ce50815febfcf59b6563d5','Custom SQL','Adding privileges to emr-reports role',NULL,'2.0.5'),('bahmni-add-privileges-to-inpatient-read-201514101540','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10982,'EXECUTED','3:59ef1582c31a7e52c7ea2a40755c7f3a','Custom SQL','Relating roles and adding privileges',NULL,'2.0.5'),('bahmni-add-privileges-to-orders-role-201515101441','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10986,'EXECUTED','3:aa39d1f55dbeb81fcf4cf720119c6c8f','Custom SQL','Adding privileges to orders role',NULL,'2.0.5'),('bahmni-add-privileges-to-patient-document-upload-201515101234','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10985,'EXECUTED','3:0bf1f73955956e033314456e06c2cc79','Custom SQL','Adding privileges to patient document upload role',NULL,'2.0.5'),('bahmni-addprevileges-admin-role-201516101234','Jaswanth,Padma','liquibase.xml','2016-03-07 12:10:36',10987,'EXECUTED','3:1474552ca7e78cb1bdc776c95b7cbca8','Custom SQL','Adding privileges to admin role',NULL,'2.0.5'),('bahmni-addpreviliges-201514101844','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10983,'EXECUTED','3:bc98ac01b7b931e353214a661f330f56','Custom SQL','Relating roles and adding privileges for bed management',NULL,'2.0.5'),('bahmni-admin-role-201513101528','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10978,'EXECUTED','3:42d2bc95cd1ac3045c5a01a36f22892f','Custom SQL','',NULL,'2.0.5'),('bahmni-atomfeed-add-event-records-category-index','Achinta, Sudhakar','liquibase.xml','2016-03-07 12:10:36',10962,'EXECUTED','3:9e2b5cdf52eb8caa784986d0772e6cc8','Create Index','Add index to the category column in event_records table for performance (if it is not already present)',NULL,'2.0.5'),('bahmni-atomfeed-offset-marker','tw','liquibase.xml','2017-04-04 15:49:08',11156,'EXECUTED','3:359e8a27b83591cc2ac20630eb8313e5','Custom SQL','rel3',NULL,'2.0.5'),('bahmni-clinical-1','tw','liquibase.xml','2016-03-07 12:10:33',10712,'EXECUTED','3:34e384e76217b318152ac490e737311d','SQL From File','rel2',NULL,'2.0.5'),('bahmni-clinical-11','Arathy','liquibase.xml','2016-03-07 12:10:33',10739,'EXECUTED','3:96097718e2a28e38b1e9dec1493d16d6','Custom SQL','Add concept Document',NULL,'2.0.5'),('bahmni-clinical-12','Arathy','liquibase.xml','2016-03-07 12:10:33',10740,'EXECUTED','3:b295a4ca56c415a6768aa5f696b51a86','Custom SQL','Add concept-name Document',NULL,'2.0.5'),('bahmni-clinical-13','Arathy','liquibase.xml','2016-03-07 12:10:33',10741,'EXECUTED','3:8a417d9214f1ff5607ebcb99447bed6e','Custom SQL','Add Encounter Type Radiology',NULL,'2.0.5'),('bahmni-clinical-14','Praveen','liquibase.xml','2016-03-07 12:10:33',10745,'EXECUTED','3:38e8445cf5bc784f372cf5c8a8ce471d','Custom SQL','Add new encounter type for investigation',NULL,'2.0.5'),('bahmni-clinical-2','tw','liquibase.xml','2016-03-07 12:10:33',10719,'EXECUTED','3:248b34d9ff8955c24cfceffb8396e01c','SQL From File','rel3',NULL,'2.0.5'),('bahmni-clinical-201401171353','banka-tw','liquibase.xml','2016-03-07 12:10:33',10742,'EXECUTED','3:aff3053304cfb5176c57269c71739c7f','Insert Row','',NULL,'2.0.5'),('bahmni-clinical-201401171415','banka-tw','liquibase.xml','2016-03-07 12:10:33',10743,'EXECUTED','3:12b0753a2a241925fcc9ac763ad69f19','Insert Row','',NULL,'2.0.5'),('bahmni-clinical-201401171420','banka-tw','liquibase.xml','2016-03-07 12:10:33',10744,'EXECUTED','3:b2794090dfbbf4946f77e036915f64d2','Insert Row','',NULL,'2.0.5'),('bahmni-clinical-201401281730','Banka,RT','liquibase.xml','2016-03-07 12:10:33',10749,'EXECUTED','3:d97e8d388d129a0fa418f1c172f8fc7a','Custom SQL','Add new encounter type for Lab Result',NULL,'2.0.5'),('bahmni-clinical-201401311600','TW','liquibase.xml','2016-03-07 12:10:33',10750,'EXECUTED','3:190851ded03e41d8b33b47c3cf720866','Custom SQL','Add concept set for Lab results',NULL,'2.0.5'),('bahmni-clinical-201402061215','Angshu,RT','liquibase.xml','2016-03-07 12:10:33',10751,'EXECUTED','3:8f210ada3640cea55eba55a4e9eef202','Custom SQL','Add new visit type LAB_RESULTS_IN_ABSENTEE',NULL,'2.0.5'),('bahmni-clinical-201402101443','sush','liquibase.xml','2016-03-07 12:10:33',10752,'EXECUTED','3:4bf141e0bfa4a5876a3c372d6b18b47d','Insert Row','',NULL,'2.0.5'),('bahmni-clinical-201402111716','indraneel,neha','liquibase.xml','2016-03-07 12:10:33',10753,'MARK_RAN','3:69ec0c78de56b715740f0df83f58bb07','Insert Row','',NULL,'2.0.5'),('bahmni-clinical-201402161951','Mujir,Vinay','liquibase.xml','2016-03-07 12:10:33',10754,'EXECUTED','3:ff1175a61a50b57bb0ec08bde9868699','Custom SQL','Creating new visit type DRUG_ORDER',NULL,'2.0.5'),('bahmni-clinical-201402201226','Neha,Indraneel','liquibase.xml','2016-03-07 12:10:33',10755,'EXECUTED','3:3f33243a98921ae1eb6ab592975fcb83','Custom SQL','deleting visit types DRUG_ORDER and LAB_RESULTS_IN_ABSENTEE',NULL,'2.0.5'),('bahmni-clinical-201402201520','Angshu','liquibase.xml','2016-03-07 12:10:33',10756,'MARK_RAN','3:3d3b3a36eb78c97c58b86a081891a3a6','Custom SQL','Add global property for emr primary identifier type',NULL,'2.0.5'),('bahmni-clinical-201402201530','Angshu','liquibase.xml','2016-03-07 12:10:33',10757,'EXECUTED','3:7732759315b8a6f9a80b2d9511e65df3','Custom SQL','set global property value for emr primary identifier type',NULL,'2.0.5'),('bahmni-clinical-201402201700','D3','liquibase.xml','2016-03-07 12:10:33',10758,'EXECUTED','3:f40a6708845094ce8ce63ae5f380d06a','Custom SQL','Remove unused app:documents privilege',NULL,'2.0.5'),('bahmni-clinical-201402251700','Mihir,Vinay','liquibase.xml','2016-03-07 12:10:33',10759,'EXECUTED','3:da4167ac93f082b79d4c3af1807fc7f7','Custom SQL','Add new concept to mark referred out tests',NULL,'2.0.5'),('bahmni-clinical-201402281633','Indraneel,Neha','liquibase.xml','2016-03-07 12:10:33',10760,'EXECUTED','3:dcaba2c3fdfec0163dc655ad0afb1082','Custom SQL','Add concept Lab Order Notes',NULL,'2.0.5'),('bahmni-clinical-201402281635','Indraneel,Neha','liquibase.xml','2016-03-07 12:10:33',10761,'EXECUTED','3:2e73b0f164e55c909b6e691876865e84','Custom SQL','Add concept-name Lab Order Notes',NULL,'2.0.5'),('bahmni-clinical-201403051245','Neha','liquibase.xml','2016-03-07 12:10:33',10762,'EXECUTED','3:3939c112bbe0258754c497ab69af6e12','Custom SQL','Delete concept Lab Order Notes',NULL,'2.0.5'),('bahmni-clinical-201403051246','Neha','liquibase.xml','2016-03-07 12:10:33',10763,'EXECUTED','3:176087fd78dcbd1639ceded0a350687b','Custom SQL','Add new concept to lab order notes',NULL,'2.0.5'),('bahmni-clinical-201408251220','D3','liquibase.xml','2016-03-07 12:10:34',10817,'EXECUTED','3:2a9c6f8331661177cb6790e285489b8c','Insert Row','',NULL,'2.0.5'),('bahmni-clinical-201502091501','Charles, Banka','liquibase.xml','2016-03-07 12:10:35',10903,'EXECUTED','3:83d50d47fd5091b289483c66a54e3ac9','Custom SQL','Adding Undo Discharge disposition',NULL,'2.0.5'),('bahmni-clinical-201511091150','Vikash, Achinta','liquibase.xml','2016-03-07 12:10:36',10994,'EXECUTED','3:8c632f19286fc5b9a85c69f8b481528f','Custom SQL','Adding Programs privilege to clinical-read only role',NULL,'2.0.5'),('bahmni-clinical-201511251240','Shireesha','liquibase.xml','2016-03-07 12:10:36',11007,'EXECUTED','3:a15220aebc448875f812b8c91b693c4c','Custom SQL','Adding Stopped Order Reason and answers',NULL,'2.0.5'),('bahmni-clinical-201521091403','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10945,'EXECUTED','3:f80b42404035832f37d3e49969040ad8','Custom SQL','Add Patient-Listing role',NULL,'2.0.5'),('bahmni-clinical-201521091410','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10947,'EXECUTED','3:f59bf18aa0180b197d66809f8d044045','Custom SQL','Add clinical read only role',NULL,'2.0.5'),('bahmni-clinical-201522091112','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10949,'EXECUTED','3:c545deeb45605141fe0541d9d34d86af','Custom SQL','Add consultation save',NULL,'2.0.5'),('bahmni-clinical-201522091116','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10951,'EXECUTED','3:967ec329a7e61ba5b8cbe38506e168b0','Custom SQL','Add consultation observation role',NULL,'2.0.5'),('bahmni-clinical-201522091120','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10953,'EXECUTED','3:0c9e9e7903837d6926b32a972c5faf8e','Custom SQL','Add consultation diagnosis role',NULL,'2.0.5'),('bahmni-clinical-201522091124','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10955,'EXECUTED','3:d302c1e82e1f31aea89338314fa13a47','Custom SQL','Add consultation disposition role',NULL,'2.0.5'),('bahmni-clinical-201522091128','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10957,'EXECUTED','3:5b2f666ec5a56a0758016bd976c4ad04','Custom SQL','Add consultation treatment role',NULL,'2.0.5'),('bahmni-clinical-201522091132','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10959,'EXECUTED','3:193c893d18677a71d5c3f4d05af00004','Custom SQL','Add consultation orders role',NULL,'2.0.5'),('bahmni-clinical-201601111633','Sourav,Preethi','liquibase.xml','2016-03-07 12:10:37',11010,'EXECUTED','3:2031750829e82318189ad343a6108000','Custom SQL','Add entity mapping type for location_encountertype',NULL,'2.0.5'),('bahmni-clinical-201703071203','Shruthi P, Pushpa','liquibase.xml','2017-10-30 14:22:08',11246,'MARK_RAN','3:00ad6e297d40fa1fed947404df7c67ef','Custom SQL','set global property value for bahmni primary identifier type',NULL,'2.0.5'),('bahmni-clinical-3','tw','liquibase.xml','2016-03-07 12:10:33',10722,'EXECUTED','3:a15a57cb8324e3e099775d7838880b71','SQL From File','rel3',NULL,'2.0.5'),('bahmni-clinical-4','tw','liquibase.xml','2016-03-07 12:10:33',10723,'EXECUTED','3:03c23be81ba7cebf6fec9df46bec239c','SQL From File','rel3',NULL,'2.0.5'),('bahmni-clinical-5','tw','liquibase.xml','2016-03-07 12:10:33',10724,'EXECUTED','3:14d62b7a1d949387b19aeeb385c17408','SQL From File','rel3',NULL,'2.0.5'),('bahmni-clinical-6','Hemanth','liquibase.xml','2016-03-07 12:10:33',10735,'EXECUTED','3:c75b673e4419804e8aca3be5790f4053','Custom SQL','Add concept Adt Notes',NULL,'2.0.5'),('bahmni-clinical-7','Hemanth','liquibase.xml','2016-03-07 12:10:33',10736,'EXECUTED','3:28f7f98a4a673080c65343436365b87b','Custom SQL','Add concept-name Adt Notes',NULL,'2.0.5'),('bahmni-clinical-8','Praveen','liquibase.xml','2016-03-07 12:10:33',10737,'EXECUTED','3:3c50596a2f2c5bebd3c31fd35d1d5d0c','Custom SQL','Add encounter session duration',NULL,'2.0.5'),('bahmni-clinical-9','Praveen','liquibase.xml','2016-03-07 12:10:33',10738,'EXECUTED','3:6eac241cb62addb4c395842f456321ee','Custom SQL','Add custom encounter session matcher',NULL,'2.0.5'),('bahmni-clinical-retrospective-201501221417','Vikash, Sravanthi','liquibase.xml','2016-03-07 12:10:35',10902,'EXECUTED','3:0fd170a3d78b9b44204644a55cb58954','Insert Row','',NULL,'2.0.5'),('bahmni-core-201403110603','Hemanth','liquibase.xml','2016-03-07 12:10:34',10764,'EXECUTED','3:a7cf75e89024bba1b6d31d494ca8ece3','Custom SQL','Add new concept for test and panel',NULL,'2.0.5'),('bahmni-core-201403181515','Hemanth,Vinay','liquibase.xml','2016-03-07 12:10:34',10765,'EXECUTED','3:8f918521411f7968ab79f5baed8c18ce','Custom SQL','Add new concept for observation group (XCompoundObservation)',NULL,'2.0.5'),('bahmni-core-201403191725','Hemanth,Vinay','liquibase.xml','2016-03-07 12:10:34',10766,'EXECUTED','3:b354caabf0905f5a23a2b0cebfacb267','Custom SQL','Add new concept for observation group (XCompoundObservation)',NULL,'2.0.5'),('bahmni-core-201403251424','Mujir','liquibase.xml','2016-03-07 12:10:34',10767,'EXECUTED','3:a56d649cadef2d0f667a04e1c1bf0db2','Custom SQL','Add new concept for Ruled Out Diagnosis',NULL,'2.0.5'),('bahmni-core-201404021353','Hemanth, Mihir','liquibase.xml','2016-03-07 12:10:34',10768,'EXECUTED','3:db0b6d363a7afd98272a64f7ebfc31d5','Custom SQL','adding givenNameLocal person attribute type',NULL,'2.0.5'),('bahmni-core-201404021359','Hemanth, Mihir','liquibase.xml','2016-03-07 12:10:34',10769,'EXECUTED','3:0b72981ca7294dc56cb2e2ecf387b183','Custom SQL','adding familyNameLocal person attribute type',NULL,'2.0.5'),('bahmni-core-201404021400','Hemanth, Mihir','liquibase.xml','2016-03-07 12:10:34',10770,'EXECUTED','3:565049e112d458b650b2612891d99225','Custom SQL','adding middleNameLocal person attribute type',NULL,'2.0.5'),('bahmni-core-201404081612','Indraneel, Mihir','liquibase.xml','2016-03-07 12:10:34',10773,'EXECUTED','3:bfc6b2f1fa801727c5496ff02c3cf9f3','Custom SQL','Adding Lab Manager Notes Concept',NULL,'2.0.5'),('bahmni-core-201404081624','Vivek, Shruthi','liquibase.xml','2016-03-07 12:10:34',10772,'EXECUTED','3:3d0122b224fea11193b83de519fe6bf1','Custom SQL','Adding diagnosis meta data concepts',NULL,'2.0.5'),('bahmni-core-201404081625','Indraneel, Mihir','liquibase.xml','2016-03-07 12:10:34',10774,'EXECUTED','3:358898ceba2ae7ab1809cbc287880fc4','Custom SQL','Adding Lab Manager Notes Provider',NULL,'2.0.5'),('bahmni-core-201404091217','sushmitharaos, arathyjan','liquibase.xml','2016-03-07 12:10:34',10771,'EXECUTED','3:a62e2c394c0a0078c09a9f0bd57840e7','Insert Row','add encounter type for patient document upload',NULL,'2.0.5'),('bahmni-core-201404101558','Indraneel, Neha','liquibase.xml','2016-03-07 12:10:34',10775,'EXECUTED','3:78af611c62a4dad7866a56f48d08d84e','Custom SQL','Adding Accession Uuid Concept',NULL,'2.0.5'),('bahmni-core-201404101600','Neha,Indraneel','liquibase.xml','2016-03-07 12:10:34',10776,'EXECUTED','3:014366343276fba18ee961dc2bb7d4dc','Custom SQL','Add Encounter Type Validation Notes',NULL,'2.0.5'),('bahmni-core-201404211500','RT, Shruthi','liquibase.xml','2016-03-07 12:10:34',10777,'EXECUTED','3:64b838a26669076ebcb6024a9f379803','Insert Row','add concept class Concept Attribute',NULL,'2.0.5'),('bahmni-core-201404281212','RT, Neha','liquibase.xml','2016-03-07 12:10:34',10778,'EXECUTED','3:00fc3bb8433b82881f19e12948b2f167','Custom SQL','add concept numeric feild to all numeric concepts',NULL,'2.0.5'),('bahmni-core-201404281819','RT, Mujir','liquibase.xml','2016-03-07 12:10:34',10779,'EXECUTED','3:1aff18cfedb228e447bf32a4b2a1da09','Insert Row','add concept class Abnormal',NULL,'2.0.5'),('bahmni-core-201404281820','RT, Mujir','liquibase.xml','2016-03-07 12:10:34',10780,'EXECUTED','3:4387bcba34e892eef9cb011d9e173125','Insert Row','add concept class Duration',NULL,'2.0.5'),('bahmni-core-201404281823','RT, Mujir','liquibase.xml','2016-03-07 12:10:34',10781,'EXECUTED','3:7cae6e5965378823cfcd5c756e20b984','SQL From File','add concept numeric proc',NULL,'2.0.5'),('bahmni-core-201404281825','RT, Mujir','liquibase.xml','2016-03-07 12:10:34',10782,'EXECUTED','3:3b70950b84cfb887e120ba3703f03d8b','Insert Row','add concept class Concept Details',NULL,'2.0.5'),('bahmni-core-201404301204','RT, Mujir','liquibase.xml','2016-03-07 12:10:34',10783,'EXECUTED','3:0cc74f1871cb1efa7199f4f4ea562a07','SQL From File','delete Concept Proc',NULL,'2.0.5'),('bahmni-core-201404301520','D3','liquibase.xml','2016-03-07 12:10:34',10784,'EXECUTED','3:95dbc7a307cda404901615be33a3c95d','Custom SQL','Configure EMR API admit and discharge encounter type',NULL,'2.0.5'),('bahmni-core-201405041511','Mujir','liquibase.xml','2016-03-07 12:10:34',10785,'MARK_RAN','3:4387bcba34e892eef9cb011d9e173125','Insert Row','add concept class Duration',NULL,'2.0.5'),('bahmni-core-201405061428','vinay','liquibase.xml','2016-03-07 12:10:34',10786,'EXECUTED','3:61f1718716d2347542975e019859c062','Custom SQL (x2)','Fix delete_concept',NULL,'2.0.5'),('bahmni-core-201405061543','mujir','liquibase.xml','2016-03-07 12:10:34',10789,'EXECUTED','3:23ca21a6b0be660b4b3fad3505f1b161','Custom SQL (x2)','Fix delete_concept. deleting concept set membership for the concept to be deleted.',NULL,'2.0.5'),('bahmni-core-201405071329','mujir','liquibase.xml','2016-03-07 12:10:34',10787,'EXECUTED','3:d0b49ca7745107877d6019920536f0de','Custom SQL','add adt notes data concept set',NULL,'2.0.5'),('bahmni-core-201405081436','mujir','liquibase.xml','2016-03-07 12:10:34',10788,'EXECUTED','3:bddad684724dec5a676c650bb36ec6d9','Custom SQL','remove adt notes data concept set',NULL,'2.0.5'),('bahmni-core-201405091936','rohan','liquibase.xml','2016-03-07 12:10:34',10790,'EXECUTED','3:934b844aa6789e274c71a45a1d3a3435','Custom SQL','Change sort weight for Admit Patients.',NULL,'2.0.5'),('bahmni-core-201405110939','rohan','liquibase.xml','2016-03-07 12:10:34',10791,'EXECUTED','3:7b9cc2d4c1ae2effbad88539be46f414','Custom SQL','Change sort weight for Discharge Patients.',NULL,'2.0.5'),('bahmni-core-201405110940','rohan','liquibase.xml','2016-03-07 12:10:34',10792,'EXECUTED','3:a7a3f5ff1d8092f32fbe32494c20b0e8','Custom SQL','Change sort weight for Transfer Patients.',NULL,'2.0.5'),('bahmni-core-201405161709','d3','liquibase.xml','2016-03-07 12:10:34',10793,'EXECUTED','3:752289f5803016fad52abe864a8278c5','Custom SQL','Update webservices.rest.maxResultsAbsolute to 1000',NULL,'2.0.5'),('bahmni-core-201405211239','d3','liquibase.xml','2016-03-07 12:10:34',10794,'EXECUTED','3:7f794f2e97397f6e73645e03b39b96f3','Custom SQL','Add global property bahmni.cacheHeadersFilter.expiresDuration',NULL,'2.0.5'),('bahmni-core-201407011716','Crude Oil with our names','liquibase.xml','2016-03-07 12:10:34',10795,'EXECUTED','3:50f3e10d1298194444378351763b2cad','Custom SQL','Add person name for lab and billing system users',NULL,'2.0.5'),('bahmni-core-201407141716','vinay','liquibase.xml','2016-03-07 12:10:34',10796,'MARK_RAN','3:1b7bdedea1809fa49e2357d93d77667e','Custom SQL','New privileges added',NULL,'2.0.5'),('bahmni-core-201407141717','vinay','liquibase.xml','2016-03-07 12:10:34',10797,'MARK_RAN','3:cdc8c96250bdd912a4ddb651455b1626','Custom SQL','New privileges added',NULL,'2.0.5'),('bahmni-core-201407141718','vinay','liquibase.xml','2016-03-07 12:10:34',10798,'MARK_RAN','3:35fb7afbad0ecf4121535a78d37d434d','Custom SQL','New privileges added',NULL,'2.0.5'),('bahmni-core-201407161230','Rohan,Indraneel','liquibase.xml','2016-03-07 12:10:34',10799,'EXECUTED','3:7bf3cd7d49ce7dafffe72f374be18ef7','Custom SQL','Global property pointing to the new encounter provider only session matcher',NULL,'2.0.5'),('bahmni-core-201407161630','Vinay','liquibase.xml','2016-03-07 12:10:34',10800,'EXECUTED','3:896c71a461a51901e495846d9568e544','Custom SQL','Set dosing type and dosing instructions',NULL,'2.0.5'),('bahmni-core-201407171215','Vinay,Indraneel','liquibase.xml','2016-03-07 12:10:34',10807,'EXECUTED','3:67ea9e924f423254cfd3658b87c38eed','Custom SQL','Adding concepts and concept set related to dosing units',NULL,'2.0.5'),('bahmni-core-201407171300','Vinay, Indraneel','liquibase.xml','2016-03-07 12:10:34',10808,'EXECUTED','3:e9299d5f6a6555c2d7ab498f5a515f80','Custom SQL','Add drug routes and set global property',NULL,'2.0.5'),('bahmni-core-201407171606','Rohan, D3','liquibase.xml','2016-03-07 12:10:34',10801,'EXECUTED','3:b556c13ad3d26a0f3c9eed4f1382a7ae','Insert Row','add concept class Image',NULL,'2.0.5'),('bahmni-core-201407171700','Vinay, Indraneel','liquibase.xml','2016-03-07 12:10:34',10809,'EXECUTED','3:2b64c9751b31b8fcc7a25f7545326632','Custom SQL','Adding duration unit concepts and setting up associated global property',NULL,'2.0.5'),('bahmni-core-201407171715','Vinay, Indraneel','liquibase.xml','2016-03-07 12:10:34',10810,'EXECUTED','3:0eca0d167cd6e8ae3738ef2dadb1f2b6','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201407180800','Shruthi','liquibase.xml','2016-03-07 12:10:34',10802,'EXECUTED','3:e0046ba1e9356e7aa14ccf0528d1ef29','Insert Row','add concept class Computed',NULL,'2.0.5'),('bahmni-core-201407221627','Rohan, Shruthi','liquibase.xml','2016-03-07 12:10:34',10803,'EXECUTED','3:ae9d9db98dd6afb973e032c3823a32c0','Custom SQL','Update custom encounter session matcher',NULL,'2.0.5'),('bahmni-core-201407221628','Rohan, Shruthi','liquibase.xml','2016-03-07 12:10:34',10804,'EXECUTED','3:fa1b0ddecdad7fb9ddf999b5d1400c73','Custom SQL','Update custom encounter session matcher',NULL,'2.0.5'),('bahmni-core-201407251510','D3','liquibase.xml','2016-03-07 12:10:34',10805,'EXECUTED','3:1c02bbb4699963a7c83ea542f2ea9236','Custom SQL','Set quantity for drug orders without this data',NULL,'2.0.5'),('bahmni-core-201407251511','D3','liquibase.xml','2016-03-07 12:10:34',10806,'EXECUTED','3:605537996398b795b128d19a73a6861f','Custom SQL','Set num_refills for drug orders without this data',NULL,'2.0.5'),('bahmni-core-201407291254','Vinay, Deepak','liquibase.xml','2016-03-07 12:10:34',10811,'EXECUTED','3:b281314578771f23d480ae45d66e38ea','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201408111300','Indraneel','liquibase.xml','2016-03-07 12:10:34',10812,'EXECUTED','3:106fe9b9c492f9d9c0f93d65dd1aa516','Custom SQL','Adding all templates concept set of sets',NULL,'2.0.5'),('bahmni-core-201408130010','Mujir','liquibase.xml','2016-03-07 12:10:34',10814,'EXECUTED','3:4634c70a8714f77cc4f09f75a46c35cf','Create Table','',NULL,'2.0.5'),('bahmni-core-20140814132600','Rohan, Vinay','liquibase.xml','2016-03-07 12:10:34',10813,'EXECUTED','3:4b2d7c60345d83f405fc7d568782d974','Custom SQL','Update Dosing type from ENUM to Class Name',NULL,'2.0.5'),('bahmni-core-201408180936','Mujir, Mihir','liquibase.xml','2016-03-07 12:10:34',10815,'EXECUTED','3:8345ac4cbbbe7691f7d51bb463e05e33','Custom SQL','Add directory for imported files',NULL,'2.0.5'),('bahmni-core-201408251140','Sravanthi,Indraneel','liquibase.xml','2016-03-07 12:10:34',10816,'EXECUTED','3:a01a6c591d40a29a8d2e551529d9ea24','Custom SQL','Introducing Obs relationship type and obs relationship tables',NULL,'2.0.5'),('bahmni-core-201408251455','Rohan','liquibase.xml','2016-03-07 12:10:34',10818,'EXECUTED','3:bfb4ec1cd7176b82015430375f808ff7','Insert Row','add concept class URL',NULL,'2.0.5'),('bahmni-core-201408251456','Rohan','liquibase.xml','2016-03-07 12:10:34',10819,'EXECUTED','3:ed9c04ea91806b2e8c789fad21d92302','Custom SQL','Add new concept LAB REPORT for uploaded file',NULL,'2.0.5'),('bahmni-core-201409041224','Banka','liquibase.xml','2016-03-07 12:10:34',10820,'EXECUTED','3:5314334d0e48280727b45a8f22b34656','Insert Row','Add View Location privilege to Anonymous',NULL,'2.0.5'),('bahmni-core-201409041530','Rohan, Sravanthi','liquibase.xml','2016-03-07 12:10:34',10830,'EXECUTED','3:30a534a584da0e66d93a6dc1093fd2a1','Custom SQL','Adding hours, weeks and months concepts for drug order duration units',NULL,'2.0.5'),('bahmni-core-201409081432','Rohan, Vinay','liquibase.xml','2016-03-07 12:10:34',10832,'EXECUTED','3:917f62fb045c3d4202989f959bfdf442','Custom SQL, SQL From File','rel2',NULL,'2.0.5'),('bahmni-core-20140908172845','Indraneel, Hemanth','liquibase.xml','2016-03-07 12:10:34',10835,'EXECUTED','3:443fc5590784d91c87f4551ca782b7f1','Custom SQL','Add Impression concept',NULL,'2.0.5'),('bahmni-core-201409091224','Mihir, Shruthi','liquibase.xml','2016-03-07 12:10:34',10831,'EXECUTED','3:70f412df64a299dbe9095f23e2210337','Custom SQL','Removing global property for encounter provider matcher',NULL,'2.0.5'),('bahmni-core-201409111200','Rohan, Vinay','liquibase.xml','2016-03-07 12:10:34',10833,'EXECUTED','3:f660b79706d6f01b191fb373ad9435b5','Custom SQL','Adding tablet and capsule concepts to dosing units',NULL,'2.0.5'),('bahmni-core-201409161415','Indraneel','liquibase.xml','2016-03-07 12:10:34',10836,'EXECUTED','3:282e2d5bec259d3eee586166f59dd687','Custom SQL','Adding obs relationship type : qualified-by',NULL,'2.0.5'),('bahmni-core-201409171047','Rohan, Hemanth','liquibase.xml','2016-03-07 12:10:34',10837,'EXECUTED','3:2e9fffc9eb0bec612e04cb7803c233a9','Custom SQL, SQL From File','Fix the new add_concept procedure',NULL,'2.0.5'),('bahmni-core-201409171530','D3','liquibase.xml','2016-03-07 12:10:34',10838,'EXECUTED','3:0c23ec6c66daaf133bd9ce23bcf7a7e8','Update Data','Rename OPD encounter type to Consultation',NULL,'2.0.5'),('bahmni-core-201409241028','Hemanth','liquibase.xml','2016-03-07 12:10:34',10821,'EXECUTED','3:48db15b4c8ef5eb006f8bb9a82854735','Custom SQL','Insert concept reference source for Duration units',NULL,'2.0.5'),('bahmni-core-201409241048','Hemanth','liquibase.xml','2016-03-07 12:10:34',10822,'EXECUTED','3:d755817db3f8a70bee6a7104446c82ea','Custom SQL','Insert concept reference term for Second(s)',NULL,'2.0.5'),('bahmni-core-201409241115','Hemanth','liquibase.xml','2016-03-07 12:10:34',10823,'EXECUTED','3:017e0e35c9599f0ad837e4fa5c4b944f','Custom SQL','Insert concept reference term for Minute(s)',NULL,'2.0.5'),('bahmni-core-201409241116','Hemanth','liquibase.xml','2016-03-07 12:10:34',10824,'EXECUTED','3:634ea355d327fac9b885f077f43e0a10','Custom SQL','Insert concept reference term for Hour(s)',NULL,'2.0.5'),('bahmni-core-201409241117','Hemanth','liquibase.xml','2016-03-07 12:10:34',10825,'EXECUTED','3:492b1d5c124c0eebf66b0f1d202ce6a7','Custom SQL','Insert concept reference term for Day(s)',NULL,'2.0.5'),('bahmni-core-201409241119','Hemanth','liquibase.xml','2016-03-07 12:10:34',10826,'EXECUTED','3:3bd0859c6ee97249a0b480340dd94157','Custom SQL','Insert concept reference term for Week(s)',NULL,'2.0.5'),('bahmni-core-201409241120','Hemanth','liquibase.xml','2016-03-07 12:10:34',10827,'EXECUTED','3:504e20ad4760ce186fe3c3bbc0ce72cf','Custom SQL','Insert concept reference term for Month(s)',NULL,'2.0.5'),('bahmni-core-201409241122','Hemanth','liquibase.xml','2016-03-07 12:10:34',10828,'EXECUTED','3:b3dd815d38fd788346eb1698e059e65b','Custom SQL','Insert concept reference term for Year(s)',NULL,'2.0.5'),('bahmni-core-201409241123','Hemanth','liquibase.xml','2016-03-07 12:10:34',10829,'EXECUTED','3:2200e99bc72d84b0d8943d6f5ed3f6c4','Custom SQL','Insert concept reference term for Time(s)',NULL,'2.0.5'),('bahmni-core-201409241126','Hemanth','liquibase.xml','2016-03-07 12:10:34',10839,'EXECUTED','3:3217972efe467098854e3c9aef041997','Custom SQL','Update hl7_code for concept reference source \'ISO 8601 Duration\'',NULL,'2.0.5'),('bahmni-core-201409241137','Hemanth','liquibase.xml','2016-03-07 12:10:35',10840,'EXECUTED','3:37817503da1a1c1ae344a405f4bac33a','Custom SQL','Update code for concept reference term \'Second(s)\'',NULL,'2.0.5'),('bahmni-core-201409241138','Hemanth','liquibase.xml','2016-03-07 12:10:35',10841,'EXECUTED','3:062aa018bb9de732d8a2931e7d318c65','Custom SQL','Update code for concept reference term \'Minute(s)\'',NULL,'2.0.5'),('bahmni-core-201409241139','Hemanth','liquibase.xml','2016-03-07 12:10:35',10842,'EXECUTED','3:43cc47425272c2a5c556822f09f71664','Custom SQL','Update code for concept reference term \'Hour(s)\'',NULL,'2.0.5'),('bahmni-core-201409241140','Hemanth','liquibase.xml','2016-03-07 12:10:35',10843,'EXECUTED','3:33a385e72bbc4c7fc51ca97c262c0ac6','Custom SQL','Update code for concept reference term \'Day(s)\'',NULL,'2.0.5'),('bahmni-core-201409241141','Hemanth','liquibase.xml','2016-03-07 12:10:35',10844,'EXECUTED','3:2285903234ce86b7ff5b0e85b8362ee3','Custom SQL','Update code for concept reference term \'Week(s)\'',NULL,'2.0.5'),('bahmni-core-201409241142','Hemanth','liquibase.xml','2016-03-07 12:10:35',10845,'EXECUTED','3:7318ad8dd850b67974c10ca515e9eee3','Custom SQL','Update code for concept reference term \'Month(s)\'',NULL,'2.0.5'),('bahmni-core-201409241143','Hemanth','liquibase.xml','2016-03-07 12:10:35',10846,'EXECUTED','3:4b36f0c93fa37c26f070f515bcf90f4f','Custom SQL','Update code for concept reference term \'Year(s)\'',NULL,'2.0.5'),('bahmni-core-201409241144','Hemanth','liquibase.xml','2016-03-07 12:10:35',10847,'EXECUTED','3:a31b734f90d0bdceb02eb121d545b12d','Custom SQL','Update code for concept reference term \'Time(s)\'',NULL,'2.0.5'),('bahmni-core-201409241241','Hemanth','liquibase.xml','2016-03-07 12:10:35',10848,'EXECUTED','3:a2fdf0b98ce6e647a67fcf72d1602c2a','Custom SQL','Update name for concept reference source \'ISO 8601 Duration\'',NULL,'2.0.5'),('bahmni-core-201409242241','Mihir','liquibase.xml','2016-03-07 12:10:35',10849,'EXECUTED','3:85f1c39ec6e637168365072e127ae614','Custom SQL','Add concept class for lab samples',NULL,'2.0.5'),('bahmni-core-201409242242','Mihir','liquibase.xml','2016-03-07 12:10:35',10850,'EXECUTED','3:92951fdf76763a1f103aab84039c954b','Custom SQL','Add concept class for lab samples',NULL,'2.0.5'),('bahmni-core-201409242248','Mihir','liquibase.xml','2016-03-07 12:10:35',10851,'EXECUTED','3:d47ca3bee89798ca0536a1f10ea4ef26','Custom SQL','Migrate sample concepts to concept class sample',NULL,'2.0.5'),('bahmni-core-201409242256','Mihir','liquibase.xml','2016-03-07 12:10:35',10852,'EXECUTED','3:32ad984ea5e58c269236f0749cf4e48b','Custom SQL','Migrate department concepts to concept class department',NULL,'2.0.5'),('bahmni-core-201409242259','Mihir','liquibase.xml','2016-03-07 12:10:35',10853,'EXECUTED','3:c0673760d0e658fe57e5f3ef6b33e4ee','Custom SQL','Rename Laboratory concept to Lab Samples',NULL,'2.0.5'),('bahmni-core-201409291027','Chethan,Banka','liquibase.xml','2016-03-07 12:10:35',10855,'EXECUTED','3:4d2eac86ae2e3719506593f3446ce962','Custom SQL','Adding concepts and concept set related to dosing units',NULL,'2.0.5'),('bahmni-core-201409291037','Chethan, Banka','liquibase.xml','2016-03-07 12:10:35',10856,'EXECUTED','3:8b1b389e659dd0b96682abd8769b64c5','Custom SQL','Adding order frequencies',NULL,'2.0.5'),('bahmni-core-201409291106','Chethan,Banka','liquibase.xml','2016-03-07 12:10:35',10857,'EXECUTED','3:e16e8fe4446e38963a84a7a9681b9c54','Custom SQL','Add drug routes and delete Percutaneous Endoscopic Gastrostomy',NULL,'2.0.5'),('bahmni-core-201409291458','Chethan,Banka','liquibase.xml','2016-03-07 12:10:35',10858,'EXECUTED','3:79f42ff307a4f1e360b2bb662d857503','Custom SQL','Adding concepts and concept set related to quantity units',NULL,'2.0.5'),('bahmni-core-201409291704','Chethan,Banka','liquibase.xml','2016-03-07 12:10:35',10859,'EXECUTED','3:d2cf22581d5d4e27461e29922e989ad6','Custom SQL','Changing names for Duration Units, Dose Units',NULL,'2.0.5'),('bahmni-core-201409291720','Chethan,Banka','liquibase.xml','2016-03-07 12:10:35',10860,'EXECUTED','3:02b03571686d026827b06aeac801f33f','Custom SQL','Changing sort order for dose units',NULL,'2.0.5'),('bahmni-core-201409291830','Indraneel','liquibase.xml','2016-03-07 12:10:35',10854,'EXECUTED','3:59227f59b0dc69aedb429642ea0c528a','Custom SQL','Adding All Disease Templates Concept Set',NULL,'2.0.5'),('bahmni-core-201409301255','Chethan,Banka','liquibase.xml','2016-03-07 12:10:35',10861,'EXECUTED','3:5ece24df97ddfc91a7e0dac70970420a','Custom SQL','Changing sort order for dose quantity units',NULL,'2.0.5'),('bahmni-core-201410061440','Chethan, Banka','liquibase.xml','2016-03-07 12:10:35',10863,'EXECUTED','3:46d150e6535dce6a39468ede129b5971','Update Data','Updating GP encounter feed publish url to publish BahmniEncounterTransaction',NULL,'2.0.5'),('bahmni-core-201410071237','D3,Arun','liquibase.xml','2016-03-07 12:10:35',10862,'EXECUTED','3:f66d3924fa8cedc2bf684f3b63661df2','Custom SQL','Add index for orders date_activated',NULL,'2.0.5'),('bahmni-core-201410101048','Rohan, Chethan','liquibase.xml','2016-03-07 12:10:35',10864,'EXECUTED','3:e2ec1e578015fb9f9e57bf1a9d4c9f6c','Custom SQL','Remove class name of reference data feed task and failed event task.',NULL,'2.0.5'),('bahmni-core-201410101436','banka','liquibase.xml','2016-03-07 12:10:35',10865,'EXECUTED','3:28348ce478fb4680742c031590de5548','Custom SQL','Add role for clinical read only access',NULL,'2.0.5'),('bahmni-core-201410101440','banka','liquibase.xml','2016-03-07 12:10:35',10866,'EXECUTED','3:b0491f30ba36025f2ed8212b775b8722','Custom SQL','Add role for clinical full access',NULL,'2.0.5'),('bahmni-core-201410101446','banka','liquibase.xml','2016-03-07 12:10:35',10876,'EXECUTED','3:08eb29e78b128ef927ef0b0bdc7ebdb3','Custom SQL','Add privileges for clinical read only',NULL,'2.0.5'),('bahmni-core-201410101530','banka','liquibase.xml','2016-03-07 12:10:35',10877,'EXECUTED','3:ec590bd2a83b0e5d853456ad298d9b51','Custom SQL','Add privileges for clinical full access',NULL,'2.0.5'),('bahmni-core-201410151040','Mihir, Bharti','liquibase.xml','2016-03-07 12:10:35',10878,'EXECUTED','3:9fb176d07517057d53d58fa041632507','Custom SQL','Rename Laboratory concept to Lab Samples',NULL,'2.0.5'),('bahmni-core-201410151525','Rohan, Hemanth','liquibase.xml','2016-03-07 12:10:35',10867,'EXECUTED','3:eaa11859b70513eb63c8d92bcf5ec93e','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201410151526','Rohan, Hemanth','liquibase.xml','2016-03-07 12:10:35',10868,'EXECUTED','3:bf69c8d3b45b9b5afa53eb61b05dd9c9','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201410151527','Rohan, Hemanth','liquibase.xml','2016-03-07 12:10:35',10869,'EXECUTED','3:c62611f7fde198bf9f8f313c8f45a152','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201410151528','Rohan, Hemanth','liquibase.xml','2016-03-07 12:10:35',10870,'EXECUTED','3:e9f0181382af2500fca26a23a101b72c','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201410151529','Rohan, Hemanth','liquibase.xml','2016-03-07 12:10:35',10871,'EXECUTED','3:5732866304d64c3c09b0f7d33bd4c597','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201410211423','d3, rohan','liquibase.xml','2016-03-07 12:10:35',10879,'EXECUTED','3:8ae3539c536db5b1764383bf375b1b9e','Custom SQL','Set global property default_locale to en',NULL,'2.0.5'),('bahmni-core-201410301713','Vinay','liquibase.xml','2016-03-07 12:10:35',10880,'EXECUTED','3:6188bf0917228defa2c058eb141f90df','Custom SQL, SQL From File','Fix the new add_concept procedure',NULL,'2.0.5'),('bahmni-core-201411031108','Vinay, sravanthi','liquibase.xml','2016-03-07 12:10:35',10881,'EXECUTED','3:9d7ca5167308aeea04c82a867098154e','Custom SQL','Adding new concept for Tablet as drug form',NULL,'2.0.5'),('bahmni-core-201411031129','Vinay, sravanthi','liquibase.xml','2016-03-07 12:10:35',10882,'EXECUTED','3:5db567592d0dfe203c5a3a6a159c7c61','Custom SQL','Adding new concept for Capsule as drug form',NULL,'2.0.5'),('bahmni-core-201411031131','Vinay, sravanthi','liquibase.xml','2016-03-07 12:10:35',10883,'EXECUTED','3:1cf139ef7639540526e88d252ce0af87','Custom SQL','Update drug table to use the new drug forms created',NULL,'2.0.5'),('bahmni-core-201411041237','Vinay','liquibase.xml','2016-03-07 12:10:35',10884,'EXECUTED','3:2c9da09899bc00752594c4e392c6c63c','Custom SQL','Ensure drug orders are always in units',NULL,'2.0.5'),('bahmni-core-201411041711','Vinay','liquibase.xml','2016-03-07 12:10:35',10885,'EXECUTED','3:0b73f2814a7c5ad62289161c95b219aa','Custom SQL','Make sure doseUnits and dosingInstructions for reverse synced drug orders are sane',NULL,'2.0.5'),('bahmni-core-201411051148','Rohan','liquibase.xml','2016-03-07 12:10:35',10886,'EXECUTED','3:4ee59ead112dd07062881f76eefa80cc','Custom SQL','Add concept class LabTest',NULL,'2.0.5'),('bahmni-core-201411051149','Rohan','liquibase.xml','2016-03-07 12:10:35',10887,'EXECUTED','3:2c9d283f4944a421b69b9f0525c56213','Custom SQL','Add concept class Radiology',NULL,'2.0.5'),('bahmni-core-201411061606','Vinay, Mihir','liquibase.xml','2016-03-07 12:10:35',10888,'EXECUTED','3:5db4ef15d594ec4dae9011474ae63e5d','Insert Row','Default chunking history entry if doesn\'t exist.',NULL,'2.0.5'),('bahmni-core-201411131512','D3','liquibase.xml','2016-03-07 12:10:35',10889,'EXECUTED','3:809bb2af1d4d95755dcf48f62c3a1840','Custom SQL','Add drug routes Topical, Nasal, Inhalation',NULL,'2.0.5'),('bahmni-core-201411141310','D3','liquibase.xml','2016-03-07 12:10:35',10890,'EXECUTED','3:6188bf0917228defa2c058eb141f90df','Custom SQL, SQL From File','Fix the new add_concept procedure',NULL,'2.0.5'),('bahmni-core-201411141315','D3','liquibase.xml','2016-03-07 12:10:35',10891,'EXECUTED','3:809f03e798fc7bb172ed69ed2860d093','Custom SQL','Fix concepts created in liquibase without uuid',NULL,'2.0.5'),('bahmni-core-201412031050','Swathi','liquibase.xml','2016-03-07 12:10:35',10892,'EXECUTED','3:d1ca4fa7639c189ed9602242e4f2bd0e','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201412051745','Rohan','liquibase.xml','2016-03-07 12:10:35',10894,'EXECUTED','3:8cdef3e773c916485e3e2971b3a94ac5','Custom SQL','Add concept class Computed/Editable',NULL,'2.0.5'),('bahmni-core-201412132014','Mihir','liquibase.xml','2016-03-07 12:10:35',10893,'EXECUTED','3:526c9878b1f0e2f406aec4938926498f','Custom SQL','Adding Immediately as Order Frequency',NULL,'2.0.5'),('bahmni-core-201412160932','Rohan, Shruthi','liquibase.xml','2016-03-07 12:10:35',10895,'EXECUTED','3:e106e85dee90f3b8f62789aa3a3306ed','Custom SQL','Adding minutes concept for drug order duration units',NULL,'2.0.5'),('bahmni-core-201412171832','Mujir, Mihir','liquibase.xml','2016-03-07 12:10:35',10896,'EXECUTED','3:ff3f26723a22f34131d082f64923f708','Custom SQL','Adding Admission Decision concept reference term and mapping for close visit task',NULL,'2.0.5'),('bahmni-core-201412171835','Mujir, Mihir','liquibase.xml','2016-03-07 12:10:35',10897,'EXECUTED','3:8dab05861bd023ac8ce19d56224d6576','Custom SQL','Adding Deny Admission concept reference term and mapping for close visit task',NULL,'2.0.5'),('bahmni-core-201412181423','Rohan','liquibase.xml','2016-03-07 12:10:35',10898,'EXECUTED','3:f3566ac13b2a0913110b3d0da179e99f','Custom SQL','Set global property allow_groovy_caching to true',NULL,'2.0.5'),('bahmni-core-201412281000','Santhosh','liquibase.xml','2016-03-07 12:10:36',11008,'EXECUTED','3:ae738ef263119ac7a34bffe44d1cd6bd','Custom SQL','Insert concept reference source for Abbreviation',NULL,'2.0.5'),('bahmni-core-201412311031','Mihir','liquibase.xml','2016-03-07 12:10:35',10899,'MARK_RAN','3:4c2ab825426999b4037151677e9b7f77','Custom SQL','Add Login Location Tag if not already added.',NULL,'2.0.5'),('bahmni-core-201501071717','Vikash,Indraneel','liquibase.xml','2016-03-07 12:10:35',10900,'EXECUTED','3:f9ed5a94595e1affa2778dce8f39f6a8','Custom SQL','Adding Order Attributes concept set',NULL,'2.0.5'),('bahmni-core-201501192149','Sravanthi','liquibase.xml','2016-03-07 12:10:35',10901,'EXECUTED','3:503c09053a2a3e1db2ebf5d58e5d7c6e','Insert Row','add concept class Case Intake',NULL,'2.0.5'),('bahmni-core-201503101702','Sravanthi, Charles','liquibase.xml','2017-04-04 15:47:14',10904,'RERAN','3:b0bda33f6c16f1e42fc10821af04f461','SQL From File','Sql file for getting all wards, beds and related patients info',NULL,'2.0.5'),('bahmni-core-201503270552','Sandeep, Hemanth','liquibase.xml','2016-03-07 12:10:35',10905,'EXECUTED','3:36ad0e08bb219e07e218a3ea8947606a','Insert Row','Adding privilege for dispensing drug orders.',NULL,'2.0.5'),('bahmni-core-201503270603','Sandeep, Hemanth','liquibase.xml','2016-03-07 12:10:35',10906,'EXECUTED','3:9dc0f97f859e8d26392fb7dbb48e980d','Custom SQL','Adding dispensed drug order attribute',NULL,'2.0.5'),('bahmni-core-201504031424','Banka, Preethi','liquibase.xml','2016-03-07 12:10:35',10907,'EXECUTED','3:0a41bb59bdbb834e36d86358e00fb605','Custom SQL','Chaning colume type of property_value in user_property to text',NULL,'2.0.5'),('bahmni-core-201504061124','Charles, Swathi','liquibase.xml','2016-03-07 12:10:35',10908,'EXECUTED','3:84d6a273c419907fd2f3c535505986d6','Insert Row','Adding privilege for bi-directional navigation between registration and consultation.',NULL,'2.0.5'),('bahmni-core-201504070220','Preethi, Hemanth','liquibase.xml','2016-03-07 12:10:35',10909,'EXECUTED','3:8a9b560ebf4e1ca0880ea48fa84139dd','Custom SQL','Creating Visit Status as visit attribute',NULL,'2.0.5'),('bahmni-core-201504131627','Soumya, Charles','liquibase.xml','2016-03-07 12:10:35',10910,'EXECUTED','3:6e5d87b1d718758aafcb26342c797e8d','Insert Row','Adding Close Visit Privilege',NULL,'2.0.5'),('bahmni-core-201504231857','Charles, JP','liquibase.xml','2016-03-07 12:10:35',10911,'EXECUTED','3:a0c246e51ee870f42ae871bbd02bf74d','Insert Row','',NULL,'2.0.5'),('bahmni-core-201505080200','Hemanth','liquibase.xml','2016-03-07 12:10:35',10913,'EXECUTED','3:454f2cf8f62168eb31935c8e6a40d30b','Custom SQL','Creating Admission Status as visit attribute',NULL,'2.0.5'),('bahmni-core-201505081250','JP','liquibase.xml','2016-03-07 12:10:35',10912,'EXECUTED','3:58927eb18fddf0c3eb0ee82cb8a7ef67','Insert Row','',NULL,'2.0.5'),('bahmni-core-201505121055','Vikash, Achinta','liquibase.xml','2016-03-07 12:10:35',10914,'EXECUTED','3:41a059203d80ce0edf170042ee1ca7a8','Insert Row','Adding privilege for provider.',NULL,'2.0.5'),('bahmni-core-201505171743','Bharat','liquibase.xml','2016-03-07 12:10:35',10915,'EXECUTED','3:6e83dcdbf780e43f18743669b7707e0c','Custom SQL','Associating LabSet and LabTest concept classes to Lab Order order type',NULL,'2.0.5'),('bahmni-core-201505171755','Bharat','liquibase.xml','2016-03-07 12:10:35',10916,'EXECUTED','3:24754f616857125b862150154fb85150','Custom SQL','Adding \'All Orderables\' concept set and associating Lab Samples to it.',NULL,'2.0.5'),('bahmni-core-201505171808','Bharat','liquibase.xml','2016-03-07 12:10:35',10917,'EXECUTED','3:ecb11a6c09e44e528e35b8ab0800d9cd','Custom SQL','Adding a display name for Lab Samples concept on UI',NULL,'2.0.5'),('bahmni-core-201505251642','Ranganathan','liquibase.xml','2016-03-07 12:10:35',10918,'EXECUTED','3:b92570973c3eb23083225d3dd889d0f9','Custom SQL','Adding gender values and codes used across MRS',NULL,'2.0.5'),('bahmni-core-201506011729','Preethi, Gautam','liquibase.xml','2016-03-07 12:10:36',10921,'EXECUTED','3:3274243cd9e1b0e4bcec701cb1c1d2c4','Custom SQL','Changing short name for Lab Samples concept on UI',NULL,'2.0.5'),('bahmni-core-201506011804','Preethi, Gautam','liquibase.xml','2016-03-07 12:10:36',10922,'EXECUTED','3:ed61279e765ce09ce44f4cd5662da89c','Custom SQL','Changing description for LabSet concept class to Panels',NULL,'2.0.5'),('bahmni-core-201506180200','Chethan, Preethi','liquibase.xml','2016-03-07 12:10:36',10923,'EXECUTED','3:00f351b770b22396b03c7ee07634fbd6','Custom SQL','Global property for default encounter type.',NULL,'2.0.5'),('bahmni-core-201506221230','Hemanth, Preethi','liquibase.xml','2016-03-07 12:10:36',10924,'EXECUTED','3:718ce3df908ca849e243aad4facd45df','Custom SQL','Getting rid of the revese sync schedulers for Drug.',NULL,'2.0.5'),('bahmni-core-201506251230','Ranganathan, Charles','liquibase.xml','2016-03-07 12:10:36',10925,'EXECUTED','3:9a5d4e344ebd851e8b30992a1ecd031b','Custom SQL','Cleaning up relationships types for the relationships.',NULL,'2.0.5'),('bahmni-core-201507161455','Abishek','liquibase.xml','2016-03-07 12:10:36',10930,'EXECUTED','3:ed677e838d8e5f7d5e88cbad1a229b66','Custom SQL','Associating LabSet and LabTest concept classes to Order order type',NULL,'2.0.5'),('bahmni-core-201507161455','Abishek, Vikash','liquibase.xml','2016-03-07 12:10:36',10928,'EXECUTED','3:3d9af265aaa57522db48ae75c1ab9157','Custom SQL','Moving to order from test_order',NULL,'2.0.5'),('bahmni-core-201507271600','Swathi, Charles','liquibase.xml','2016-03-07 12:10:36',10931,'EXECUTED','3:de22b0233b080ebf960e63e64f260e00','Custom SQL','Adding Telephone Number person attribute type',NULL,'2.0.5'),('bahmni-core-201507271605','Swathi, Charles','liquibase.xml','2016-03-07 12:10:36',10932,'EXECUTED','3:61e9309e9bf001527e3a99a1adda56ef','Custom SQL','Adding Unknown patient person attribute type',NULL,'2.0.5'),('bahmni-core-201507311820','Hemanth','liquibase.xml','2016-03-07 12:10:36',10934,'EXECUTED','3:fa8e55f7de2fbf50f8412b7c210935ea','SQL From File','Optimised the high risk patient sql to consider latest test value',NULL,'2.0.5'),('bahmni-core-201508180000','Banka, Swathi','liquibase.xml','2016-03-07 12:10:36',10935,'EXECUTED','3:8b2a8442b05f979c678ff0dfe15ccb5f','Custom SQL','Changing the OrderType name for lab order from Order to Lab Order',NULL,'2.0.5'),('bahmni-core-201508181421','Padma, Shireesha','liquibase.xml','2016-03-07 12:10:36',10936,'EXECUTED','3:95360f885d7148080651c9a6877da677','Custom SQL','Adding global property for Reason for death',NULL,'2.0.5'),('bahmni-core-201508211600','Vikash, Abishek','liquibase.xml','2016-03-07 12:10:36',10937,'EXECUTED','3:5ed53ac922e9fc936397275aec6e60f6','Custom SQL','Updating column stage_name of import_status table',NULL,'2.0.5'),('bahmni-core-201508310334','Padma','liquibase.xml','2016-03-07 12:10:36',10938,'EXECUTED','3:20549d7d7804d2d89634ea9704ac5c04','Custom SQL','Deleting bahmnicore.relationshipTypeMap from global property',NULL,'2.0.5'),('bahmni-core-201509231746','Swathi, Jaswanth','liquibase.xml','2016-03-07 12:10:36',10943,'EXECUTED','3:6508854072b041e561e9f77cfc7d7597','Custom SQL','Deleting Telephone Number person attribute type',NULL,'2.0.5'),('bahmni-core-201509231749','Swathi, Jaswanth','liquibase.xml','2016-03-07 12:10:36',10944,'EXECUTED','3:569ad5cc3dd69532b314d4ded22b52fe','Custom SQL','Deleting Unknown patient person attribute type',NULL,'2.0.5'),('bahmni-core-201509301203','Chethan, Sourav','liquibase.xml','2016-03-07 12:10:36',10961,'EXECUTED','3:dcec039ea0c79d77e6664f3c4f866dd1','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201510161510','Vikash, Shashi','liquibase.xml','2016-03-07 12:10:36',10989,'EXECUTED','3:582f1eeecb2bd7f63b1e4d0ec970db71','Custom SQL','Add relationship between orderType and conceptClass',NULL,'2.0.5'),('bahmni-core-201510271500','Shan, Sourav','liquibase.xml','2016-03-07 12:10:36',10990,'EXECUTED','3:edf189ea73fb69f049f23575531740a2','SQL From File','SQL query to get list of active patients by location',NULL,'2.0.5'),('bahmni-core-201510291400','Shan','liquibase.xml','2016-03-07 12:10:36',10991,'EXECUTED','3:cffec54ed5b2e8f2ee567e2be0d47e84','Custom SQL','Remove the SQL query to get list of active patients by location',NULL,'2.0.5'),('bahmni-core-201510292222','Shan','liquibase.xml','2016-03-07 12:10:36',10992,'EXECUTED','3:e706d735997c7c6148fc9d4fca76679d','Custom SQL','Adding privileges to Registration-Additional role',NULL,'2.0.5'),('bahmni-core-201511121200','goodrich','liquibase.xml','2016-03-07 12:10:35',10873,'EXECUTED','3:07b98290c37381900241dee532e39941','Custom SQL','Workaround for adding missing View Providers privlege',NULL,'2.0.5'),('bahmni-core-201511121201','goodrich','liquibase.xml','2016-03-07 12:10:35',10874,'EXECUTED','3:26dc6a3c9a0b9d2ad23c625cd19e7ca5','Custom SQL','Workaround for adding missing View Providers privlege',NULL,'2.0.5'),('bahmni-core-201511121245','goodrich','liquibase.xml','2016-03-07 12:10:35',10875,'EXECUTED','3:dd0414a5533ab03967880f0bee3d6063','Custom SQL','Workaround for adding missing View Visit Attribute Types privlege',NULL,'2.0.5'),('bahmni-core-201511121343','goodrich','liquibase.xml','2016-03-07 12:10:35',10872,'EXECUTED','3:ec628973fae698d339a1b38784007f6b','Custom SQL','Workaround for adding missing View Providers privlege',NULL,'2.0.5'),('bahmni-core-201511180200','Swathi','liquibase.xml','2016-03-07 12:10:36',10999,'EXECUTED','3:5b0ec0a63dba621e1deb2f29adeb7245','Custom SQL','Adding \'DrugOther\' concept.',NULL,'2.0.5'),('bahmni-core-201511180201','Swathi','liquibase.xml','2016-03-07 12:10:36',11001,'EXECUTED','3:7a5b97a6a9a09c617522233bf39ba71a','Custom SQL','Setting \'DrugOther\' concept uuid as value for \'drugOrder.drugOther\' globalProperty.',NULL,'2.0.5'),('bahmni-core-201511180931','Vinay','liquibase.xml','2016-03-07 12:10:36',11005,'EXECUTED','3:9d026c323f8f6b1bb4d126ba7ded869e','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201511181738','Padma','liquibase.xml','2016-03-07 12:10:36',11004,'EXECUTED','3:7e386370855bb98d60573330230aa7af','Custom SQL','Changing description for reason for death global property',NULL,'2.0.5'),('bahmni-core-201511250237','Hanisha','liquibase.xml','2016-03-07 12:10:36',11006,'EXECUTED','3:dd3d8fade763e3ccb9770dc62a1fb986','Custom SQL','Adding new loginLocationToVisitTypeMapping in entityMappingType table',NULL,'2.0.5'),('bahmni-core-201511251218','Jaya, Sravanthi','liquibase.xml','2016-03-07 12:10:36',11000,'MARK_RAN','3:f0b7bce998bb19f9c2dfee0fc6e8db55','Custom SQL','Add drug other global property',NULL,'2.0.5'),('bahmni-core-201512291400','Shashi, Hanisha','liquibase.xml','2016-03-07 12:10:36',11009,'EXECUTED','3:af4ff1761a0e28f724b789cc9fdc5a44','Insert Row','add concept class Unknown',NULL,'2.0.5'),('bahmni-core-201518111152','JP,Sravanthi','liquibase.xml','2016-03-07 12:10:36',11002,'EXECUTED','3:64d89e89d5f248daa9c489a02904deed','Custom SQL','Add bahmni user role',NULL,'2.0.5'),('bahmni-core-201518111156','JP,Sravanthi','liquibase.xml','2016-03-07 12:10:36',11003,'EXECUTED','3:42a968fad3c1ce3d7191e439821b17e8','Custom SQL','Add privileges bahmni user',NULL,'2.0.5'),('bahmni-core-201521091408','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10946,'EXECUTED','3:b9381f69cdc3cfe9b8733f423811f96a','Custom SQL','Add privileges for patient listing',NULL,'2.0.5'),('bahmni-core-201521091414','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10948,'EXECUTED','3:bb18a788e846f3e1e79619a1bca94c4c','Custom SQL','Add privileges for clinical read only',NULL,'2.0.5'),('bahmni-core-201522091114','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10950,'EXECUTED','3:73afdba961d6be7a0231f50a7b83071d','Custom SQL','Add privileges consultation save',NULL,'2.0.5'),('bahmni-core-201522091118','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10952,'EXECUTED','3:cc7ecabfa61461b10acab4efcbc3793c','Custom SQL','Add privileges consultation observation',NULL,'2.0.5'),('bahmni-core-201522091122','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10954,'EXECUTED','3:6bc51163744a97a1849bcab1e7969663','Custom SQL','Add privileges consultation diagnosis',NULL,'2.0.5'),('bahmni-core-201522091126','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10956,'EXECUTED','3:4220c81f14d749b39464487fe038ddf3','Custom SQL','Add privileges consultation disposition',NULL,'2.0.5'),('bahmni-core-201522091130','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10958,'EXECUTED','3:9592304d8b871d914851a5e57f0b3ba6','Custom SQL','Add privileges consultation treatment',NULL,'2.0.5'),('bahmni-core-201522091134','Banka,Sravanthi','liquibase.xml','2016-03-07 12:10:36',10960,'EXECUTED','3:d3f40e0d71d0a797079951edf3cfc65b','Custom SQL','Add privileges consultation orders',NULL,'2.0.5'),('bahmni-core-201606291787','Pankaj, Hanisha','liquibase.xml','2017-04-04 15:47:14',11128,'EXECUTED','3:6b17bf77b8f5156df0db161f7a0b4765','Custom SQL','Add Visit Location Tag if not already added.',NULL,'2.0.5'),('bahmni-core-201608011234','Hanisha, Vinay','liquibase.xml','2017-04-04 15:47:14',11129,'EXECUTED','3:d41d8cd98f00b204e9800998ecf8427e','Empty','Visits should not have location null. Please refer to release notes 0.83',NULL,'2.0.5'),('bahmni-core-201608081535','Chethan, Yugesh','liquibase.xml','2017-04-04 15:47:14',11133,'EXECUTED','3:f165dbbbbd8cf4ddbf70b0ef0465270d','Insert Row','Add Concept Class Video',NULL,'2.0.5'),('bahmni-core-2016092714-possible-75','Panakaj, Hanisha','liquibase.xml','2017-04-04 15:47:14',11136,'EXECUTED','3:05822a9d4c165985b06dfe8a4c51c839','Custom SQL','Add new concept for Cured Diagnosis',NULL,'2.0.5'),('bahmni-core-201610101525','Bharat','liquibase.xml','2017-04-04 15:47:14',11137,'EXECUTED','3:fdbbfeae42eb3ee2bae51535b488a637','Custom SQL','add concept numeric row to all numeric concepts',NULL,'2.0.5'),('bahmni-core-201610211440','Gaurav','liquibase.xml','2017-04-04 15:47:14',11141,'EXECUTED','3:aa957c0a5abc7b6f034e77a6b48c8818','Custom SQL','Change data type of REFERRED_OUT concept to boolean',NULL,'2.0.5'),('bahmni-core-201611101133','Gaurav','liquibase.xml','2017-04-04 15:47:14',11144,'EXECUTED','3:1a4647d1436258f8af571d5c7cb6fbe8','Custom SQL','Updating Referred out obs to have value coded as true',NULL,'2.0.5'),('bahmni-core-201612051010','Gaurav','liquibase.xml','2017-04-04 15:47:14',11146,'EXECUTED','3:7b3e9d979446792040dcc509174a5296','Custom SQL','Add \'Get Concept Sources\' privilege to all roles containing \'Get Concepts\'\n            privilege',NULL,'2.0.5'),('bahmni-core-201612051015','Gaurav','liquibase.xml','2017-04-04 15:47:14',11147,'EXECUTED','3:3fa04876f04218c75ef42b857fe9dfe3','Custom SQL','Add \'Add Encounters\' privilege to all roles containing \'Add Visits\' or \'Edit Visits\'\n            privilege',NULL,'2.0.5'),('bahmni-core-201612051020','Gaurav','liquibase.xml','2017-04-04 15:47:14',11148,'EXECUTED','3:75a60957e4dc506938238cdf24936d0e','Custom SQL','Add \'Edit Encounters\' privilege to all roles containing \'Add Visits\'or \'Edit Visits\'\n            privilege',NULL,'2.0.5'),('bahmni-core-201612051350','Preethi,Gaurav','liquibase.xml','2017-04-04 15:47:14',11150,'EXECUTED','3:ddee1e73d70873e073bbfef3c569a5c3','Custom SQL','Add \'Add Observations\' privilege to all roles containing \'Add Encounters\' and \'Edit Encounters\'\n            privilege',NULL,'2.0.5'),('bahmni-core-201612051355','Preethi,Gaurav','liquibase.xml','2017-04-04 15:47:14',11151,'EXECUTED','3:2d1859df62d20f5fe0f8f83b7e314223','Custom SQL','Add \'Edit Observations\' privilege to all roles containing \'Add Encounters\' and \'Edit Encounters\'\n            privilege',NULL,'2.0.5'),('bahmni-core-201612051725','Gaurav','liquibase.xml','2017-04-04 15:47:14',11149,'EXECUTED','3:57f1467f0d0dd54d8078d892cc18b642','Custom SQL','Add \'Get Observations\' privilege to all roles containing \'Add Encounters\' and \'Edit Encounters\'\n            privilege',NULL,'2.0.5'),('bahmni-core-201612071518','Preethi, Gaurav','liquibase.xml','2017-04-04 15:47:14',11152,'EXECUTED','3:e9bcff6b29b908304a57627e99951ffa','Custom SQL','Delete empty diagnosis status obs',NULL,'2.0.5'),('bahmni-core-201612081800','Jaswanth','liquibase.xml','2017-04-04 15:47:14',11153,'EXECUTED','3:d651e61b08ad875ba8a5778e9266eaf9','Custom SQL','Add delete diagnosis privilege to Clinical App role',NULL,'2.0.5'),('bahmni-core-201612091038','Preethi','liquibase.xml','2017-04-04 15:47:14',11154,'EXECUTED','3:cc6a017d8194bf4ab3524fe9e0589002','Custom SQL','Update log level of org.openmrs.api to WARN',NULL,'2.0.5'),('bahmni-core-201701241540','Padma','liquibase.xml','2017-04-04 15:47:14',11155,'EXECUTED','3:82852bfa2d893d1504ad6002c1b7172d','Custom SQL','Set value coded for referred out concepts',NULL,'2.0.5'),('bahmni-core-201702061413','Preethi','liquibase.xml','2017-10-30 14:22:07',11244,'EXECUTED','3:c92468d8a0c601765c079ace61defd48','Custom SQL','Create HubConnect Role with location and provider privileges',NULL,'2.0.5'),('bahmni-core-201704191128','Shashi, Gautam','liquibase.xml','2017-10-30 14:22:08',11254,'EXECUTED','3:e067fc31b0b2c8d50cfa47a45867e21d','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201704191135','Shashi, Gautam','liquibase.xml','2017-10-30 14:22:08',11255,'EXECUTED','3:45d283d2305977829d433c8c53d478a1','Custom SQL','',NULL,'2.0.5'),('bahmni-core-201704191140','Shashi, Gautam','liquibase.xml','2017-10-30 14:22:08',11256,'EXECUTED','3:5adb40b01075e33298e503a7b8ef40b6','Custom SQL','Add privileges to roles Clinical-App-Save(Edit Conditions)',NULL,'2.0.5'),('bahmni-core-201704191145','Shashi, Gautam','liquibase.xml','2017-10-30 14:22:08',11257,'EXECUTED','3:844728c8a8dc3fa6ac38a6e83594239f','Custom SQL','Add privileges to roles Clinical-App-Read-Only(Get conditions)',NULL,'2.0.5'),('bahmni-core-201704211500','Shashi, Sicong','liquibase.xml','2017-10-30 14:22:08',11258,'EXECUTED','3:920d1b139a71923374a8a5fff163d766','Custom SQL','Add privileges to roles Clinical-App-Read-Only(Get Forms)',NULL,'2.0.5'),('bahmni-core-201705041200','Bindu','liquibase.xml','2017-10-30 14:22:08',11253,'EXECUTED','3:43d976702f27468c0ec585abfd924749','Custom SQL','Renaming \'pt\' to \'pt_BR\' for locale.allowed.list property in global_property table',NULL,'2.0.5'),('bahmni-emr-reports-201513101535','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10980,'EXECUTED','3:657717602f3b21d62ffbdf2090349027','Custom SQL','',NULL,'2.0.5'),('bahmni-inpatient-patient-movement-201513101455','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10976,'EXECUTED','3:81c62a25ae700462be75dff46f86bc4d','Custom SQL','',NULL,'2.0.5'),('bahmni-inpatient-patient-movement-201513101524','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10977,'EXECUTED','3:3c282da97bb8e0b9adab7d3f4fba68fb','Custom SQL','',NULL,'2.0.5'),('bahmni-inpatient-read-201513101438','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10975,'EXECUTED','3:2f8220ed4381a71f1fff9ad046c56877','Custom SQL','',NULL,'2.0.5'),('bahmni-mapping-201508200613','Gautham, Sudhakar','liquibase.xml','2016-03-07 12:10:36',10939,'EXECUTED','3:3a9d87b0efe0b06c05c9caeb2f616599','Create Table (x2), Add Foreign Key Constraint','Entity mapping table',NULL,'2.0.5'),('bahmni-mapping-201508271719','Gautam, Shan','liquibase.xml','2016-03-07 12:10:36',10940,'EXECUTED','3:f38b607def006e48591497b8d427f7cc','Insert Row','Inserting Program Obstemplate Mapping type',NULL,'2.0.5'),('bahmni-mapping-201508271736','Shan, Gautam','liquibase.xml','2016-03-07 12:10:36',10941,'EXECUTED','3:65427f1edf5546ebc2284c98e17b31e7','Add Unique Constraint','Introducing constraint unique key to name column in the entity_mapping_type table',NULL,'2.0.5'),('bahmni-mapping-201509021719','Shruthi, Padma','liquibase.xml','2016-03-07 12:10:36',10942,'EXECUTED','3:b514a8c7b083b0c8fc3974bbc4fa10cb','Insert Row','Inserting Program EncounterType Mapping',NULL,'2.0.5'),('bahmni-new-roles-and-privileges','Jaswanth, Ravindra','liquibase.xml','2017-04-04 15:47:14',11138,'EXECUTED','3:14239025d1eeb1a927e6ab5e0bb85e08','SQL From File','New roles and privileges for bahmni',NULL,'2.0.5'),('bahmni-orders-role-201513101532','Banka,Padma','liquibase.xml','2016-03-07 12:10:36',10979,'EXECUTED','3:fb813933154056d8a4f895238e2150cb','Custom SQL','',NULL,'2.0.5'),('bahmni-orders-role-201523111314','Chethan,Shashi','liquibase.xml','2016-03-07 12:10:36',10981,'MARK_RAN','3:41981a3f2794678c672a10fd47a4d683','Custom SQL','',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201507031840','Vikash, Achinta','liquibase.xml','2016-03-07 12:10:36',10926,'EXECUTED','3:ddebe9600eef3a6f92e3ee4fb6fb6cad','SQL From File','rel3',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201507071330','Vikash, Chethan','liquibase.xml','2016-03-07 12:10:36',10927,'EXECUTED','3:50e6998a7b95a8d302ba5daccb597ade','SQL From File','rel3',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201507161455','Abishek','liquibase.xml','2016-03-07 12:10:36',10929,'EXECUTED','3:59c6870c2a2f8944cfe14b23f6e419a8','SQL From File','Updating sql to use order instead of lab order as order type name',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201507271745','JP, Sravanthi','liquibase.xml','2016-03-07 12:10:36',10933,'EXECUTED','3:6543a9af9e42feee2b196e6b6412ef07','SQL From File','Updating high risk patient sql to consider latest test value',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201607151835','Lavanya, Shashi','liquibase.xml','2017-04-04 15:47:14',11130,'EXECUTED','3:fe49d35e6a36dad0f82e7091ef150531','SQL From File','update the search query to consider visit location',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201608121039','Preethi, Hanisha','liquibase.xml','2017-04-04 15:47:14',11134,'EXECUTED','3:2058f172071b418cc636c1fb1560fbf8','SQL From File','update the search query to consider multiple identifiers',NULL,'2.0.5'),('bahmni-PatientSearch-Update-201703071203','Shruthi P, Pushpa','liquibase.xml','2017-10-30 14:22:08',11247,'EXECUTED','3:f61352c770ed9ff257a398b3260de0d1','SQL From File','update the search query to use bahmni.primaryIdentifierType global property instead of emr.primaryIdentifierType',NULL,'2.0.5'),('bahmni-reg-1','tw','liquibase.xml','2016-03-07 12:10:36',10995,'EXECUTED','3:c0b629cdfcca83a11a418544618f5e64','SQL From File','rel2',NULL,'2.0.5'),('bahmni-reg-201401171330','banka-tw','liquibase.xml','2016-03-07 12:10:36',10971,'EXECUTED','3:6fb4b3254235534a73f1286df1ccc85d','Insert Row','',NULL,'2.0.5'),('bahmni-reg-201402141455','neha','liquibase.xml','2016-03-07 12:10:36',10972,'EXECUTED','3:eb2a5670f3bf96f9638999447a9301a3','Custom SQL','Add emrgency app role',NULL,'2.0.5'),('bahmni-reg-3','tw','liquibase.xml','2016-03-07 12:10:36',10996,'EXECUTED','3:36a3c338cb6058407f036ef86ed67e0d','SQL From File','rel2',NULL,'2.0.5'),('bahmni-reg-4','tw','liquibase.xml','2016-03-07 12:10:36',10997,'EXECUTED','3:b5c470f1a44536c95da453df84770d9c','SQL From File','rel3',NULL,'2.0.5'),('bahmni-reg-5','vivek-tw','liquibase.xml','2016-03-07 12:10:36',10998,'EXECUTED','3:35c7ab7814c60020e0c161af7bf49a30','Custom SQL','rel3',NULL,'2.0.5'),('bahmni-registration-201507101741','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10963,'EXECUTED','3:f8aec9024ab069f3dc3a79bf4aa6592c','Custom SQL','Add Registration Role',NULL,'2.0.5'),('bahmni-registration-201507101742','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10964,'EXECUTED','3:5c336c2dec0e96eb935aa83ca6a651c5','Custom SQL','Add Registration Read Role',NULL,'2.0.5'),('bahmni-registration-201507101744','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10965,'EXECUTED','3:2328f269b12ba37cc2a5e12296dcc0ac','Custom SQL','Add privileges registration read',NULL,'2.0.5'),('bahmni-registration-201507101747','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10966,'EXECUTED','3:114b8a6393c1e0dd45fb76587ac9d0b4','Custom SQL','Add Registration Write Role',NULL,'2.0.5'),('bahmni-registration-201507101748','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10967,'EXECUTED','3:c4b84e874cd50d1025dfa4554b3ba532','Custom SQL','Add privileges registration write',NULL,'2.0.5'),('bahmni-registration-201507101749','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10968,'EXECUTED','3:871f7655c54461883fc852ebb7fb4ac2','Custom SQL','Add Registration Visit Action Role',NULL,'2.0.5'),('bahmni-registration-201507101753','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10969,'EXECUTED','3:03d6448d20ae9fe9782e7cca5fc90a43','Custom SQL','Add privileges registration visit action',NULL,'2.0.5'),('bahmni-registration-201507101755','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10970,'EXECUTED','3:7f34dabe1072f0b87cde58f693b02a28','Custom SQL','Add role for additional actions for registration app.',NULL,'2.0.5'),('bahmni-registration-201507101757','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10973,'EXECUTED','3:9bca88b8b6fc70765cd71455844f1616','Custom SQL','Add privileges for additional action required for registration app like encounter etc.',NULL,'2.0.5'),('bahmni-registration-201507101808','Shan,Sourav','liquibase.xml','2016-03-07 12:10:36',10974,'EXECUTED','3:1cd6d482bcc8707ddc3446d4d6e6f47b','Custom SQL','Add patient listing role to registration',NULL,'2.0.5'),('bahmni-registration-201511041808','Vikash','liquibase.xml','2016-03-07 12:10:36',10993,'EXECUTED','3:a559c810e9c35fa18938886f2c7c7ee6','Custom SQL','Modifying patient listing role, Registration additional role and giving relationship role to registration',NULL,'2.0.5'),('bahmni-setup-6','tw','liquibase.xml','2016-03-07 12:10:33',10705,'MARK_RAN','3:0c7cf008e177b5631a8f9554a729f52c','Insert Row','rel3',NULL,'2.0.5'),('bahmni-WardsList-Update-201609011124','Jaswanth','liquibase.xml','2017-04-04 15:47:14',11135,'EXECUTED','3:9b6d90bbe9dac29c19250fc5ba6377e1','SQL From File','Update the wards list sql to use left join for patient address',NULL,'2.0.5'),('bahmni-WardsList-Update-201703071203','Shruthi P, Pushpa','liquibase.xml','2017-10-30 14:22:08',11248,'EXECUTED','3:78ee2d15dcf50b412357a482fc5b1c13','SQL From File','Update the wards list sql to use bahmni.primaryIdentifierType global property instead of emr.primaryIdentifierType',NULL,'2.0.5'),('bahmniconfig-201505252028','Mihir','liquibase.xml','2016-03-07 12:10:35',10919,'EXECUTED','3:f7b02e7c80d6e0f6fe2375f91b9005b1','Create Table, Add Foreign Key Constraint (x2), Add Unique Constraint (x2)','',NULL,'2.0.5'),('bahmniconfig-201505252128','Mihir','liquibase.xml','2016-03-07 12:10:36',10920,'EXECUTED','3:1688c33b1d8a9bff81f123cfabc88377','Create Table, Add Foreign Key Constraint, Add Unique Constraint (x2)','',NULL,'2.0.5'),('bahmnimapping-201409121125','Chethan, D3','liquibase.xml','2016-03-07 12:10:34',10834,'EXECUTED','3:7c85f09623317af6653cb48c89e27e00','Create Table, Add Foreign Key Constraint (x5)','',NULL,'2.0.5'),('bedmanagement-201401171410','banka-tw','liquibase.xml','2016-03-07 11:59:45',10667,'EXECUTED','3:d5c049fddf766160573e47432866a7af','Insert Row','',NULL,'2.0.5'),('bedmanagement-201514101449','padma','liquibase.xml','2016-03-07 11:59:45',10668,'EXECUTED','3:ccb5b80fe5702396261645675bfe7668','Insert Row','',NULL,'2.0.5'),('bedmanagement-201514101455','padma','liquibase.xml','2016-03-07 11:59:45',10669,'EXECUTED','3:be88d1eab414a74e416a74fbaa804bc4','Insert Row','',NULL,'2.0.5'),('bedmanagement-20151410183','padma','liquibase.xml','2016-03-07 11:59:45',10671,'EXECUTED','3:2fd5f40c4d91726f0c431026d7fad17f','Insert Row','',NULL,'2.0.5'),('bedmanagement-201514101836','padma','liquibase.xml','2016-03-07 11:59:45',10670,'EXECUTED','3:7fa2b9c000288cb4afa7ac67a0e14bea','Insert Row','',NULL,'2.0.5'),('bedmanagement-201625111153','Sourav, Chethan','liquibase.xml','2017-10-30 14:22:03',11215,'EXECUTED','3:ed10755aab017df8253c137998c9ab6d','Create Table, Add Foreign Key Constraint (x3)','Creating bed_tag table',NULL,'2.0.5'),('bedmanagement-201703221515','Santhosh, Maharjun','liquibase.xml','2017-10-30 14:22:04',11217,'EXECUTED','3:4ca99b67c0073ce23444d99fb41a1f10','Insert Row','',NULL,'2.0.5'),('bedmanagement-201703221516','Santhosh, Maharjun','liquibase.xml','2017-10-30 14:22:04',11218,'EXECUTED','3:7d4fdb9a0d381562a615595b65b573e1','Insert Row','',NULL,'2.0.5'),('bed_management_module_18112013_1','Arathy,Banka','liquibase.xml','2016-03-07 11:59:44',10643,'EXECUTED','3:7f5aa1439a4889c6cf630b99e1887070','Create Table','Create bed_type table',NULL,'2.0.5'),('bed_management_module_18112013_2','Arathy,Banka','liquibase.xml','2016-03-07 11:59:44',10644,'EXECUTED','3:e9c545756efadfcd357658c59ba8ccbf','Add Column','',NULL,'2.0.5'),('bed_management_module_18112013_3','Arathy,Banka','liquibase.xml','2016-03-07 11:59:45',10645,'EXECUTED','3:7dc3e366326ab822d273659e86712932','Add Foreign Key Constraint','Added foreign key reference on bed_type_id in bed table',NULL,'2.0.5'),('constraint_name_cleanup','bgeVam','liquibase.xml','2017-04-04 15:47:12',11121,'EXECUTED','3:8fc91e4dfa5185db65d7c00eb87e0196','Drop Foreign Key Constraint (x3), Drop Index, Drop Foreign Key Constraint (x8), Add Foreign Key Constraint (x3), Create Index, Add Foreign Key Constraint (x8)','Rename constraints',NULL,'2.0.5'),('create-appointment-status-change-task-20170912101533','Kaustav','liquibase.xml','2017-10-30 14:22:10',11277,'EXECUTED','3:2e9cb62b83082eef01b69f87cdfb2877','Custom SQL','',NULL,'2.0.5'),('create-appointment_service_table-201707031130','Shruthi,Pushpa','liquibase.xml','2017-10-30 14:22:09',11268,'EXECUTED','3:4a9e06b0afdb9bc0d841e0a74062da54','Custom SQL','',NULL,'2.0.5'),('create-appointment_service_type_table-201707191650','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:09',11271,'EXECUTED','3:6e7ed955db1127a2e41f1f88ce9bb6cc','Custom SQL','',NULL,'2.0.5'),('create-appointment_speciality_table-201707031130','Shruthi,Pushpa','liquibase.xml','2017-10-30 14:22:09',11267,'EXECUTED','3:23b21e88e18866e7103d9a2404bf66ec','Custom SQL','',NULL,'2.0.5'),('create-auditlogtable-201703211430','Shruthi,Salauddin','liquibase.xml','2017-10-30 14:22:08',11251,'MARK_RAN','3:ee83973104fb3ffdf7267ca458862f0c','Custom SQL','',NULL,'2.0.5'),('create-auditlogtable-201705231130','Shruthi,Pushpa','liquibase.xml','2017-10-30 14:22:01',11212,'EXECUTED','3:ee83973104fb3ffdf7267ca458862f0c','Custom SQL','',NULL,'2.0.5'),('create-fullaccess-role-appointments-201709201815','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:08',11264,'EXECUTED','3:7e28920cbe41186657256ec480e2006c','Custom SQL','Creating new role for Full Access to Appointments module',NULL,'2.0.5'),('create-manage-role-appointments-201709201838','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:08',11266,'EXECUTED','3:9059ff35b8142bef085bec579d4f3007','Custom SQL','Creating new role Appointments: Manage for Appointments module',NULL,'2.0.5'),('create-patient_appointment_audit_table-201708311030','Shruthi','liquibase.xml','2017-10-30 14:22:10',11276,'EXECUTED','3:88a96744eb9657dad2072f5570867db8','Custom SQL','',NULL,'2.0.5'),('create-patient_appointment_table-201707211030','Deepak','liquibase.xml','2017-10-30 14:22:09',11272,'EXECUTED','3:46f1fa6a50ac167020817d4dc0b8cfea','Custom SQL','',NULL,'2.0.5'),('Create-privilege-appointments-admin-201709201813','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:08',11263,'EXECUTED','3:d189ce5b9b80a357ea43bd4a40f25286','Custom SQL','Adding privilege for managing services in appointments Module',NULL,'2.0.5'),('Create-privilege-appointments-app-201709201731','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:08',11261,'EXECUTED','3:1c465468839d4725daf3f7384c0a58e0','Custom SQL','Adding privilege for Appointments Module',NULL,'2.0.5'),('Create-privilege-appointments-manage-201709201740','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:08',11262,'EXECUTED','3:fdcab22dd57ebfa48e534dfcd6927dc5','Custom SQL','Adding privilege for managing appointments in appointments Module',NULL,'2.0.5'),('Create-privilege-manage-appointment-services-201709201607','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:10',11281,'EXECUTED','3:e1569a6699d8ad2362bc39e51ae4f413','Custom SQL','Adding privilege to manage Services in Appointments module',NULL,'2.0.5'),('Create-privilege-manage-appointments-201709201605','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:10',11279,'EXECUTED','3:82836ef1e2bcd2b7dfdd9ea0ed8da0d3','Custom SQL','Adding privilege for managing Appointments',NULL,'2.0.5'),('Create-privilege-view-appointment-services-201709201606','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:10',11280,'EXECUTED','3:e5ecd10a19ea3d99ccf6dab3780d520a','Custom SQL','Adding privilege to view Services in Appointments module',NULL,'2.0.5'),('Create-privilege-view-appointments-201709201603','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:10',11278,'EXECUTED','3:4912362ec59f2d20386c92a0e05369b2','Custom SQL','Adding privilege for viewing Appointments',NULL,'2.0.5'),('create-readonly-role-appointments-201709201830','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:08',11265,'EXECUTED','3:446188e889e395cbc963d2f12c8c3e48','Custom SQL','Creating new role Appointments: ReadOnly for Appointments module',NULL,'2.0.5'),('create-weekly_service_availability_table-201707071130','Shruthi,Pushpa','liquibase.xml','2017-10-30 14:22:09',11270,'EXECUTED','3:2e66b40714b1ecd10ada6a2ad09b8e05','Custom SQL','',NULL,'2.0.5'),('default-201604211822','Gautam, Angshuman','liquibase.xml','2017-04-04 15:49:08',11157,'EXECUTED','3:b103a4032519a1111e3662e7b576e45c','Custom SQL','update Height concept uuid to standard CEIL concept uuid',NULL,'2.0.5'),('default-201604211823','Gautam, Angshuman','liquibase.xml','2017-04-04 15:49:08',11158,'EXECUTED','3:adca6eaa07119e268cf8125515a05d58','Custom SQL','update Weight concept uuid to standard CEIL concept uuid',NULL,'2.0.5'),('disable-foreign-key-checks','ben','liquibase-core-data.xml','2017-04-04 15:46:08',10017,'RERAN','3:cc124077cda1cfb0c70c1ec823551223','Custom SQL','',NULL,'2.0.5'),('drop-tribe-foreign-key-TRUNK-4492','dkayiwa','liquibase-update-to-latest.xml','2016-03-07 11:44:48',10612,'MARK_RAN','3:6f02e3203c3fe5414a44106b8f16e3cd','Drop Foreign Key Constraint','Dropping foreign key on patient.tribe',NULL,'2.0.5'),('drop_changed_by_for_reporting_report_design','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11222,'MARK_RAN','3:c3d7c5613017f0dd2114629a0872e162','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_changed_by_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11226,'MARK_RAN','3:4ec604377282a11507a14f61a7863498','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_changed_by_for_reporting_report_processor','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11230,'MARK_RAN','3:d6ce70620019149c9d6980a308a708e2','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_creator_for_reporting_report_design','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11221,'MARK_RAN','3:4fca8d664649067bb63d590ab3e26dfa','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_creator_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11225,'MARK_RAN','3:577af27e0bff419cc0aae9a34fe082b0','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_creator_for_reporting_report_processor','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11229,'MARK_RAN','3:162a4ce97acf5f2cf9b5cd998174573c','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_index_on_appointment_service_table-201707251710','Santhosh, Maharjun','liquibase.xml','2017-10-30 14:22:09',11273,'EXECUTED','3:c72adf08d3c49dc8e5944eb248c8027c','Drop Index','',NULL,'2.0.5'),('drop_index_on_appointment_service_type_table-201708031638','Santhosh, Pramida','liquibase.xml','2017-10-30 14:22:10',11275,'EXECUTED','3:05ab7148b7de34b0448531e4243528b1','Drop Index','',NULL,'2.0.5'),('drop_report_definition_uuid_constraint','mgoodrich','liquibase.xml','2017-10-30 14:22:04',11219,'MARK_RAN','3:227005c318df24fca09a6853f492a755','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_report_definition_uuid_index','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11220,'MARK_RAN','3:65331456086e4518661938ca8feff19f','Drop Index','',NULL,'2.0.5'),('drop_report_design_id_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11224,'MARK_RAN','3:c3e640b5f5bc15fb2a2aa93136fdeefc','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_requested_by_for_reporting_report_request','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11228,'MARK_RAN','3:caaf7b8d6b2b53cbc4a9c296df3b4cbb','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_retired_by_for_reporting_report_design','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11223,'MARK_RAN','3:0387cf16e3f0be8b021a84da769f0e91','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_retired_by_for_reporting_report_design_resource','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11227,'MARK_RAN','3:bfc6bcc6b786458067255bd5012fe9f9','Drop Foreign Key Constraint','',NULL,'2.0.5'),('drop_retired_by_reporting_report_processor','mgoodrich','liquibase.xml','2017-10-30 14:22:05',11231,'MARK_RAN','3:6f39b5de50c73531e2e853071669e8c7','Drop Foreign Key Constraint','',NULL,'2.0.5'),('elis-atomfeed-1','tw','liquibase.xml','2016-03-07 12:20:56',11034,'EXECUTED','3:17d9c6c5ea8bbf64b2b4644346192e90','SQL From File','rel2',NULL,'2.0.5'),('elis-atomfeed-10','tw','liquibase.xml','2016-03-07 12:20:56',11042,'EXECUTED','3:feb206bf6784b0ce4dfc1e16a800226c','Custom SQL','',NULL,'2.0.5'),('elis-atomfeed-11','tw','liquibase.xml','2016-03-07 12:20:56',11043,'MARK_RAN','3:12105009de6f0575c46df9d670d68081','Custom SQL','',NULL,'2.0.5'),('elis-atomfeed-12','tw','liquibase.xml','2016-03-07 12:20:56',11044,'MARK_RAN','3:ae7a643b1262305c113ff297318e92aa','Custom SQL','',NULL,'2.0.5'),('elis-atomfeed-13','tw','liquibase.xml','2016-03-07 12:20:56',11045,'EXECUTED','3:b33b5942425ad6e69480e0919108b20c','Custom SQL','',NULL,'2.0.5'),('elis-atomfeed-14-201402041600','tw','liquibase.xml','2016-03-07 12:20:56',11046,'EXECUTED','3:b02e2f66d54d988351f184701ae6d619','Custom SQL','Remove scheduled job to process failed Openelis lab results',NULL,'2.0.5'),('elis-atomfeed-15-201402041605','tw','liquibase.xml','2016-03-07 12:20:56',11047,'EXECUTED','3:a61c1329e67b2732fa6c83d884926b65','Custom SQL','Remove scheduled job to process Openelis lab results, as this is now part of accession worker',NULL,'2.0.5'),('elis-atomfeed-16-201409101232','Chethan,D3','liquibase.xml','2016-03-07 12:20:56',11048,'EXECUTED','3:20732865c685712f4c1fe1e9cb489a9f','Custom SQL','Creating new visit type LAB VISIT',NULL,'2.0.5'),('elis-atomfeed-2','tw','liquibase.xml','2016-03-07 12:20:56',11035,'EXECUTED','3:cfd8f65af45913454ea557b1585bbb40','SQL From File','rel2',NULL,'2.0.5'),('elis-atomfeed-3','tw','liquibase.xml','2016-03-07 12:20:56',11036,'EXECUTED','3:279a6a1670eac12891f3a0437fadf730','SQL From File','rel2',NULL,'2.0.5'),('elis-atomfeed-4','tw','liquibase.xml','2016-03-07 12:20:56',11037,'EXECUTED','3:0eb646e57196970f3f4b1bcf875e091e','SQL From File','rel2',NULL,'2.0.5'),('elis-atomfeed-5','tw','liquibase.xml','2016-03-07 12:20:56',11038,'EXECUTED','3:4d3531ede6ef820436ac0ef886aab55b','SQL From File','rel3',NULL,'2.0.5'),('elis-atomfeed-6','tw','liquibase.xml','2016-03-07 12:20:56',11039,'EXECUTED','3:78a6e08fc15728ddd71c873931d0f512','Custom SQL','Add failed events job for Openelis lab result processing',NULL,'2.0.5'),('elis-atomfeed-7','tw','liquibase.xml','2016-03-07 12:20:56',11040,'EXECUTED','3:8877ce3b407b0d49bab09aa39239ee90','Custom SQL','Add failed events job for Openelis patient processing',NULL,'2.0.5'),('elis-atomfeed-8','tw','liquibase.xml','2016-03-07 12:20:56',11041,'EXECUTED','3:ca9db9bef47dedf3ad8a3a8914a58759','Custom SQL','Don\'t start the patient feed on startup',NULL,'2.0.5'),('enable-foreign-key-checks','ben','liquibase-core-data.xml','2017-04-04 15:46:08',10041,'RERAN','3:fcfe4902a8f3eda10332567a1a51cb49','Custom SQL','',NULL,'2.0.5'),('map-users-to-new-roles','Jaswanth, Ravindra','liquibase.xml','2017-04-04 15:47:14',11139,'EXECUTED','3:de3b5ba4d6e53d71fec58ec6f12dab8d','Custom SQL','Map users to new roles',NULL,'2.0.5'),('metadatamapping-2011-10-04-a','bwolfe','liquibase.xml','2016-03-07 11:59:47',10672,'EXECUTED','3:35034abcb1ed993cde7f33847ce0ce4c','Update Data','Move MDS property addLocalMappings to metadatamapping',NULL,'2.0.5'),('metadatamapping-2011-10-04-b','bwolfe','liquibase.xml','2016-03-07 11:59:47',10673,'EXECUTED','3:991431e585885ebeeaef03c760b5f6f8','Update Data','Move MDS property localConceptSourceUuid to metadatamapping',NULL,'2.0.5'),('metadatamapping-2015-10-11-1834','kosmik','liquibase.xml','2017-04-04 15:47:04',11103,'EXECUTED','3:608414b793fe6e137fcc5dfb1e88a839','Create Table, Add Foreign Key Constraint (x3)','Create metadata source table',NULL,'2.0.5'),('metadatamapping-2015-10-11-1835','kosmik','liquibase.xml','2017-04-04 15:47:04',11104,'EXECUTED','3:980d70c89ea1cd8b1dfe0a60ea03291c','Create Table, Add Foreign Key Constraint (x4)','Create metadata term mapping table',NULL,'2.0.5'),('metadatamapping-2015-10-25-1124','kosmik','liquibase.xml','2017-04-04 15:47:05',11105,'EXECUTED','3:7185903dea86a90939b784d841bf8f4b','Add Unique Constraint','Add unique constraint on a code withing a source',NULL,'2.0.5'),('metadatamapping-2015-11-16-1932','kosmik','liquibase.xml','2017-04-04 15:47:06',11106,'EXECUTED','3:9bd157b8cb5878b610da6d579140793f','Add Unique Constraint','Add unique constraint on metadata source name',NULL,'2.0.5'),('metadatamapping-2016-01-06-0800','jasonvena','liquibase.xml','2017-04-04 15:47:06',11107,'EXECUTED','3:78cf33a699307f10e5efb3729999e2fb','Drop Not-Null Constraint','Make MetadataTermMapping.metadataClass optional. We follow the openmrs convention of checking if the column\n			exists.',NULL,'2.0.5'),('metadatamapping-2016-01-06-0801','jasonvena','liquibase.xml','2017-04-04 15:47:06',11108,'EXECUTED','3:082c1bf3e3277c5af9960fa3a44f25da','Drop Not-Null Constraint','Make MetadataTermMapping.metadataUuid optional. We follow the openmrs convention of checking if the column\n			exists.',NULL,'2.0.5'),('metadatamapping-2016-02-07-1310-a','kosmik','liquibase.xml','2017-04-04 15:47:07',11109,'EXECUTED','3:4156adb3e07cd916a876469b52089448','Create Index','Add index on metadata term mapping retired',NULL,'2.0.5'),('metadatamapping-2016-02-07-1310-b-mysql','kosmik','liquibase.xml','2017-04-04 15:47:07',11110,'EXECUTED','3:60c4c5da05bd89d8b7f97acf57052c1e','Custom SQL','For mysql, add a prefix index on metadata term mapping metadata class, since there is a hard length limit\n			on varchar indexes starting from mysql 5.6.',NULL,'2.0.5'),('metadatamapping-2016-02-07-1310-b-non-mysql','kosmik','liquibase.xml','2017-04-04 15:47:07',11111,'MARK_RAN','3:c5baf2f0397c7f7148ae5b730f41cf76','Create Index','Add index on metadata term mapping metadata class for any other dbms than mysql.',NULL,'2.0.5'),('metadatamapping-2016-02-07-1310-c','kosmik','liquibase.xml','2017-04-04 15:47:07',11112,'EXECUTED','3:11b02dfccccbfb2a4b7b216d4dba20f3','Create Index','Add index on metadata term mapping source',NULL,'2.0.5'),('metadatamapping-2016-02-07-1310-d','kosmik','liquibase.xml','2017-04-04 15:47:08',11113,'EXECUTED','3:30ffab427eb7275901b02477a9bc266d','Create Index','Add index on metadata term mapping code',NULL,'2.0.5'),('metadatamapping-2016-08-03-1044','adamgrzybkowski','liquibase.xml','2017-04-04 15:47:08',11114,'EXECUTED','3:0950934ed1210a9d72f32a6c8fda1818','Drop Not-Null Constraint (x2)','Make date_changed optional',NULL,'2.0.5'),('metadatamapping-2016-08-04-1511','pgutkowski','liquibase.xml','2017-04-04 15:47:08',11115,'EXECUTED','3:c1b2ddc265e77e5aa2e8b451c6cff0d6','Create Table, Add Foreign Key Constraint (x3)','Create metadata set table',NULL,'2.0.5'),('metadatamapping-2016-08-04-1513','pgutkowski','liquibase.xml','2017-04-04 15:47:08',11116,'EXECUTED','3:9829aa464b001eb83b643458212a6830','Create Table, Add Unique Constraint, Add Foreign Key Constraint (x4)','Create metadata set member table',NULL,'2.0.5'),('metadatamapping-2016-08-05-8000','adamgrzybkowski','liquibase.xml','2017-04-04 15:47:08',11117,'EXECUTED','3:14072571a00d5701199916b43d6e1568','Drop Not-Null Constraint','Make name optional',NULL,'2.0.5'),('metadatasharing_create_table_exported_package','Dmytro Trifonov','liquibase.xml','2017-04-04 15:47:09',11118,'MARK_RAN','3:cd6f473e1eef04494f47fbaaff70a52f','Create Table, Create Index','Create table metadatasharing_exported_package',NULL,'2.0.5'),('metadatasharing_create_table_imported_item','Dmytro Trifonov','liquibase.xml','2017-04-04 15:47:09',11120,'MARK_RAN','3:412a3292ac3cc3f3d27fd8334df634c3','Create Table, Create Index','Create table metadatasharing_imported_item',NULL,'2.0.5'),('metadatasharing_create_table_imported_package','Dmytro Trifonov','liquibase.xml','2017-04-04 15:47:09',11119,'MARK_RAN','3:582520a49887eb6fd3e36592693e0730','Create Table, Create Index','Create table metadatasharing_imported_package',NULL,'2.0.5'),('modify-auditlogtable-201705231230','Shashi','liquibase.xml','2017-10-30 14:22:01',11213,'EXECUTED','3:48c64858d1d344114d1cb3c99c905aa2','Custom SQL','',NULL,'2.0.5'),('obsRelationship-ForeignKey-Update-201611151430','Santhosh, Chethan','liquibase.xml','2017-10-30 14:22:08',11245,'EXECUTED','3:22ee0dcc491084e5c20ebdeeeabc4881','Custom SQL','Update the foreign key constrain on obs_relationship, Consider user_id(users) for foreign key reference instead of person_id(person)',NULL,'2.0.5'),('openmrs-atomfeed-offset-marker-20150909122334','tw','liquibase.xml','2016-03-07 11:59:41',10632,'EXECUTED','3:4c78c5cce276151886c80a0c39001a2a','Insert Row','',NULL,'2.0.5'),('org.ict4h.openmrs-atomfeed-2013-03-01-18:30','ict4h','liquibase.xml','2016-03-07 11:59:41',10628,'EXECUTED','3:1a7eeaf0e4a024076bfee8d326904ece','Create Table (x2), Modify data type, Set Column as Auto-Increment, Modify data type, Set Column as Auto-Increment','',NULL,'2.0.5'),('org.ict4h.openmrs-atomfeed-2014-01-02-00:00','ict4h','liquibase.xml','2016-03-07 11:59:41',10629,'EXECUTED','3:e8c753c38cfb25c50c4249ec84429e4c','Create Table','',NULL,'2.0.5'),('org.ict4h.openmrs-atomfeed-2014-06-10-14:22','Chethan, Banka','liquibase.xml','2016-03-07 11:59:41',10630,'EXECUTED','3:7cc0b59c613e76b2975cfc814419c85f','Insert Row','Adding global property for encounter feed publish url',NULL,'2.0.5'),('providermanagement-1','bgeVam','liquibase.xml','2017-04-04 15:47:02',11094,'MARK_RAN','3:e34c72cdc1f5a95e3f3c002fe43cd6c2','Create Table','create table provider role',NULL,'2.0.5'),('providermanagement-2a','pgutkowski','liquibase.xml','2017-04-04 15:47:02',11095,'MARK_RAN','3:4fb0e1e96548f943e10f077f8775025b','Add Column','add provider role id to table provider',NULL,'2.0.5'),('providermanagement-2b','pgutkowski','liquibase.xml','2017-04-04 15:47:03',11096,'MARK_RAN','3:b7c86a9c3a4006cbfbe21a0db6bb39fb','Add Foreign Key Constraint','use provider role id from table provider as foreign key',NULL,'2.0.5'),('providermanagement-3','bgeVam','liquibase.xml','2017-04-04 15:47:03',11097,'MARK_RAN','3:932a4a80377ed4f20e68dd642a2ec10a','Create Table, Add Foreign Key Constraint (x2)','create table providermanagement_provider_role_relationship_type',NULL,'2.0.5'),('providermanagement-4','bgeVam','liquibase.xml','2017-04-04 15:47:03',11098,'MARK_RAN','3:6f45d0195a24eabaae536b77db610c95','Create Table, Add Foreign Key Constraint (x2)','create table providermanagement_provider_role_supervisee_provider_role',NULL,'2.0.5'),('providermanagement-5','bgeVam','liquibase.xml','2017-04-04 15:47:03',11099,'MARK_RAN','3:1bd712ee9fe9cfe4072401a2b4480205','Create Table, Add Foreign Key Constraint (x2)','create table providermanagement_provider_role_provider_attribute_type',NULL,'2.0.5'),('providermanagement-6','bgeVam','liquibase.xml','2017-04-04 15:47:03',11100,'MARK_RAN','3:bbc82803f522fd1127493417fe0f3000','Create Table, Add Foreign Key Constraint','create table providermanagement_provider_suggestion',NULL,'2.0.5'),('providermanagement-7','bgeVam','liquibase.xml','2017-04-04 15:47:03',11101,'MARK_RAN','3:923169cf831e2488ab2f13f2192e66f9','Create Table, Add Foreign Key Constraint','create table providermanagement_supervision_suggestion',NULL,'2.0.5'),('providermanagement-8','bgeVam','liquibase.xml','2017-04-04 15:47:03',11102,'EXECUTED','3:a61d6b3d3ae4c772bbb58bee782b2bb1','Insert Row','insert in relationship_type',NULL,'2.0.5'),('RA-354-create-allergy-table-rev1','fbiedrzycki','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11061,'EXECUTED','3:5a23c0e356b4fc9ec6614f7457b60ecf','Create Table, Add Foreign Key Constraint (x6)','Create allergy table',NULL,'2.0.5'),('RA-355-create-allergy-reaction-table','fbiedrzycki','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11062,'EXECUTED','3:3d7654bdf6720157c7e2b091d81b380c','Create Table, Add Foreign Key Constraint (x2)','Create allergy_reaction table',NULL,'2.0.5'),('RA-360-Add-allergy-status-to-patient-2','rpuzdrowski','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11063,'EXECUTED','3:4145b719c9b9400f5557e081bdcd75d8','Add Column','Add allergy_status field to the patient table',NULL,'2.0.5'),('reporting_id_set_cleanup','mseaton','liquibase.xml','2016-03-07 11:59:49',10691,'MARK_RAN','3:01cd3b88ed5e29b64b55d614d419cd2b','Drop Table','Removing reporting_idset table that is no longer used',NULL,'2.0.5'),('reporting_migration_1','mseaton','liquibase.xml','2016-03-07 11:59:48',10689,'EXECUTED','3:f6ea0df533cc324ea0d6275d72980c78','Custom SQL (x2)','Remove OpenMRS scheduled tasks produced by the reporting module',NULL,'2.0.5'),('reporting_migration_2','mseaton','liquibase.xml','2016-03-07 11:59:49',10690,'EXECUTED','3:4fb91f1875cf874314393aa47c71ca83','Custom SQL','Rename the default web renderer',NULL,'2.0.5'),('reporting_report_design_1','mseaton','liquibase.xml','2016-03-07 11:59:47',10674,'EXECUTED','3:482e8981e0dce9476eaf481167719579','Create Table, Add Foreign Key Constraint (x4)','Create table to persist report design specifications',NULL,'2.0.5'),('reporting_report_design_2','mseaton','liquibase.xml','2016-03-07 11:59:48',10675,'EXECUTED','3:027dbe5aeecbd08ecb7b5986a25307de','Add Column, Custom SQL','',NULL,'2.0.5'),('reporting_report_design_3','mseaton','liquibase.xml','2016-03-07 11:59:48',10676,'EXECUTED','3:8cac36c2cf24b842b8add2a5cfbb0df1','Custom SQL','',NULL,'2.0.5'),('reporting_report_design_4','mseaton','liquibase.xml','2016-03-07 11:59:48',10677,'EXECUTED','3:bddba97d81d6daa7fd6fbb478897fd84','Drop Foreign Key Constraint','',NULL,'2.0.5'),('reporting_report_design_5','mseaton','liquibase.xml','2016-03-07 11:59:48',10678,'EXECUTED','3:e7dbeb93443f14c60ed2e7cd6aa1e94f','Create Index','',NULL,'2.0.5'),('reporting_report_design_6','mseaton','liquibase.xml','2016-03-07 11:59:48',10679,'EXECUTED','3:e37eef4a9c8063b4abdb8481dd8fe5f8','Drop Column','Step 4 in changing reporting_report_design to reference report definition\n			by uuid rather than id, in order to not tie it directly to the serialized object table\n			Drop report_definition_id column',NULL,'2.0.5'),('reporting_report_design_resource_1','mseaton','liquibase.xml','2016-03-07 11:59:48',10680,'EXECUTED','3:9b1f111c165c213fa2cecc37d87ed843','Create Table, Add Foreign Key Constraint (x4)','Create table to persist report design resources',NULL,'2.0.5'),('reporting_report_processor_1','mseaton','liquibase.xml','2016-03-07 11:59:48',10685,'EXECUTED','3:bc9b147af791381ff5a98a7786f7d638','Create Table, Add Foreign Key Constraint (x3)','Create tables to persist report processors',NULL,'2.0.5'),('reporting_report_processor_2','mseaton','liquibase.xml','2016-03-07 11:59:48',10686,'MARK_RAN','3:9060cd2b9fc7c9a24155302d97123fc8','Drop Table','Drop the reporting_report_request_processor table (creation of this table was done\n			in the old sqldiff and not ported over to liquibase, as it is not needed.  this\n			changeset serves only to clean it up and delete it if is still exists',NULL,'2.0.5'),('reporting_report_processor_3','mseaton','liquibase.xml','2016-03-07 11:59:48',10687,'EXECUTED','3:2a2278e80933adb538d8c308eb812337','Add Column, Add Foreign Key Constraint','Update reporting_report_processor table to have report_design_id column',NULL,'2.0.5'),('reporting_report_processor_4','mseaton','liquibase.xml','2016-03-07 11:59:48',10688,'EXECUTED','3:3073b9e397f194eb5f16906f36e9c474','Add Column, Custom SQL','Update reporting_report_processor table to have processor_mode column\n			and set the value to automatic for all processors that were previously created',NULL,'2.0.5'),('reporting_report_request_1','mseaton','liquibase.xml','2016-03-07 11:59:48',10681,'EXECUTED','3:4d336ce27e1366ee39ea2b0c069e4491','Create Table, Add Foreign Key Constraint','Create tables to persist a report request and save reports',NULL,'2.0.5'),('reporting_report_request_2','mseaton','liquibase.xml','2016-03-07 11:59:48',10682,'EXECUTED','3:90834d1a3dc8b3c1f4109579c9a5b954','Add Column','Add a schedule property to ReportRequest',NULL,'2.0.5'),('reporting_report_request_3','mseaton','liquibase.xml','2016-03-07 11:59:48',10683,'EXECUTED','3:8e88f53150534221e9c32cd0e2c94706','Add Column','Add processAutomatically boolean to ReportRequest',NULL,'2.0.5'),('reporting_report_request_4','mseaton','liquibase.xml','2016-03-07 11:59:48',10684,'EXECUTED','3:e93012ef325cc3aff1c92f0ba78424a8','Add Column','Add minimum_days_to_preserve property to ReportRequest',NULL,'2.0.5'),('Reports-022420151643','Chethan, Shruthi','liquibase.xml','2016-03-07 12:17:31',11025,'EXECUTED','3:2018ee5e6f302d5ced1959cd9b8d9864','Create View','Creating view concept',NULL,'2.0.5'),('Reports-022620151602','Chethan, Sravanthi','liquibase.xml','2016-03-07 12:17:31',11026,'EXECUTED','3:a51daaeaebdb02a9dbb3259c33058f0c','Create Table','Creating table for reporting age group',NULL,'2.0.5'),('Reports-030320150913','Hemanth, Shruthi','liquibase.xml','2016-03-07 12:17:31',11027,'EXECUTED','3:c2efbb6b9e9b6bc9388f4388748da9e0','Create View','concept_reference_term_map_view',NULL,'2.0.5'),('Reports-030320150914','Hemanth, Shruthi','liquibase.xml','2016-03-07 12:17:31',11028,'EXECUTED','3:ee7e0a8c06e993ff02e6d8dd8ac4e4a3','Create View','diagnosis_concept_view',NULL,'2.0.5'),('Reports-170220160438','Hemanth','liquibase.xml','2016-03-07 12:17:31',11029,'EXECUTED','3:c2e836c31b0cb6d8e122432e04742929','Custom SQL','Creating a openmrs user for reports',NULL,'2.0.5'),('Reports-170220160455','Hemanth','liquibase.xml','2016-03-07 12:17:31',11030,'EXECUTED','3:316a4df8affa916fc9a2865268f7a7c0','Custom SQL','Add roles to Reports user',NULL,'2.0.5'),('Reports-2211201660456','Ravindra, Salauddin','liquibase.xml','2017-04-04 15:50:18',11159,'EXECUTED','3:296f9039ad6622654606f98b3828fa42','Custom SQL (x2)','',NULL,'2.0.5'),('TRUNK-3422-20160216-1700','Wyclif','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11080,'MARK_RAN','3:a517d5e30d3814f5b186cbc93aa359de','Insert Row','Add \"Get Visits\" privilege',NULL,'2.0.5'),('TRUNK-3422-20160216-1701','Wyclif','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11081,'MARK_RAN','3:e5e5b2b92bbceeb4041166cd3b86803e','Insert Row','Add \"Get Providers\" privilege',NULL,'2.0.5'),('TRUNK-3422-20160216-1702','Wyclif','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11082,'MARK_RAN','3:694bfb4f761bc423576faf8bb32354ab','Insert Row','Add \"Add Visits\" privilege',NULL,'2.0.5'),('TRUNK-3422-20160216-1703','PralayRamteke','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11083,'MARK_RAN','3:2188e5d96b696afc752217843a7fa697','Custom SQL','Add \"Get Visits\" privilege to the roles having \"Get Encounter\"',NULL,'2.0.5'),('TRUNK-3422-20160216-1704','PralayRamteke','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11084,'MARK_RAN','3:13b334dbd8fba2fea886d1c9aab40e16','Custom SQL','Add \"Get Providers\" privilege to the roles having \"Get Encounter\"',NULL,'2.0.5'),('TRUNK-3422-20160216-1705','Wyclif','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11085,'MARK_RAN','3:3a0b65a0166f9f5e205078dd7606dd8d','Custom SQL','Add \"Add Visits\" privilege to the roles having \"Add Encounters\"',NULL,'2.0.5'),('TRUNK-3422-20160216-1706','Wyclif','liquibase-update-to-latest.xml','2017-04-04 15:46:25',11086,'MARK_RAN','3:104cd0df5fa332f59097b421cf67795f','Custom SQL','Add \"Add Visits\" privilege to the roles having \"Edit Encounters\"',NULL,'2.0.5'),('TRUNK-4548-MigrateAllergiesChangeSet1','dkayiwa','liquibase-update-to-latest.xml','2017-04-04 15:46:22',11064,'MARK_RAN','3:aa4d81dae6a9f0ee7e6f032634cc266d','Custom Change','Custom changeset to migrate allergies from old to new tables',NULL,'2.0.5'),('TRUNK-4730-20161114-1000','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:52',11193,'EXECUTED','3:62b146aa86146bb14bc3bc7b1c705aa9','Add Column','Adding \"date_changed\" column to concept_class table',NULL,'2.0.5'),('TRUNK-4730-20161114-1001','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11194,'EXECUTED','3:7c0a2b9028c8cec6754137b57eea7679','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to concept_class table',NULL,'2.0.5'),('TRUNK-4730-20161114-1002','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11195,'EXECUTED','3:3e65004b18d936106d5bde6b0ea55bb1','Add Column','Adding \"date_changed\" column to concept_reference_source table',NULL,'2.0.5'),('TRUNK-4730-20161114-1003','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11196,'EXECUTED','3:fb69c3c8d05211bef1e0d75ae0a47b4a','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to concept_reference_source table',NULL,'2.0.5'),('TRUNK-4730-20161114-1004','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11197,'EXECUTED','3:a07427f74905fa577c4601221930d725','Add Column','Adding \"date_changed\" column to concept_name table',NULL,'2.0.5'),('TRUNK-4730-20161114-1005','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11198,'EXECUTED','3:99c37b211b61a9efba269e58eb60bed6','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to concept_name table',NULL,'2.0.5'),('TRUNK-4730-20161114-1006','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11199,'EXECUTED','3:a85f556338aa3e6e03322bd63f8db81f','Add Column','Adding \"date_changed\" column to concept_name_tag table',NULL,'2.0.5'),('TRUNK-4730-20161114-1007','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11200,'EXECUTED','3:bacd34ef4db389f4da020914b0dbde6f','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to concept_name_tag table',NULL,'2.0.5'),('TRUNK-4730-20161114-1008','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11201,'EXECUTED','3:d7d662407f5718e827b2636e8416424c','Add Column','Adding \"date_changed\" column to form_resource table',NULL,'2.0.5'),('TRUNK-4730-20161114-1009','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11202,'EXECUTED','3:603a102bfb608bfacfeb710d63979c48','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to form_resource table',NULL,'2.0.5'),('TRUNK-4730-20161114-1010','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:53',11203,'EXECUTED','3:7b799528f45de29dff19faf4d8bfa946','Add Column','Adding \"date_changed\" column to global_property table',NULL,'2.0.5'),('TRUNK-4730-20161114-1011','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11204,'EXECUTED','3:c4fffce5ad9022ba2dd6c3d8152e93e2','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to global_property table',NULL,'2.0.5'),('TRUNK-4730-20161114-1012','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11205,'EXECUTED','3:7edc9ff6ca71d10f9056532c4430ff1e','Add Column','Adding \"date_changed\" column to patient_identifier_type table',NULL,'2.0.5'),('TRUNK-4730-20161114-1013','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11206,'EXECUTED','3:8447b5cafb407b33d3ebfe86d351b283','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to patient_identifier_type table',NULL,'2.0.5'),('TRUNK-4730-20161114-1014','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11207,'EXECUTED','3:5a08fbafcd35bb78d0660135d4bc09b3','Add Column','Adding \"date_changed\" column to relationship_type table',NULL,'2.0.5'),('TRUNK-4730-20161114-1015','manuelagrindei','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11208,'EXECUTED','3:bf16d180e5f0f2e5ccb08bed8a614e52','Add Column, Add Foreign Key Constraint','Adding \"changed_by\" column to relationship_type table',NULL,'2.0.5'),('TRUNK-4936-20160930-1000','teleivo','liquibase-update-to-latest.xml','2017-10-30 14:21:50',11165,'EXECUTED','3:f6d113831fa983aa3b91df534c8b4194','Add Column, Add Unique Constraint','Add unique_id column to concept_reference_source',NULL,'2.0.5'),('TRUNK-4976-20170403-1','darius','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11209,'EXECUTED','3:bc865b90609f6ac5e9cbfee7fc974ed1','Add Column','Adding \"status\" column to obs table',NULL,'2.0.5'),('TRUNK-4976-20170403-2','darius','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11210,'EXECUTED','3:b4f92f9e87648f18756c99ead810c931','Add Column','Adding \"interpretation\" column to obs table',NULL,'2.0.5'),('TRUNK-5140-20170404-1000','Shruthi,Salauddin','liquibase-update-to-latest.xml','2017-10-30 14:21:54',11211,'EXECUTED','3:1981ba100fac3806c9e8116164bae361','Modify data type','Modify column length to 1000 from 255',NULL,'2.0.5'),('uiframework-20120913-2055','wyclif','liquibase.xml','2016-03-07 11:59:40',10627,'EXECUTED','3:af5797791243753415f969b558c9a917','Create Table','Adding uiframework_page_view table',NULL,'2.0.5');
/*!40000 ALTER TABLE `liquibasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangeloglock`
--

LOCK TABLES `liquibasechangeloglock` WRITE;
/*!40000 ALTER TABLE `liquibasechangeloglock` DISABLE KEYS */;
INSERT INTO `liquibasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_uuid_index` (`uuid`),
  KEY `name_of_location` (`name`),
  KEY `location_retired_status` (`retired`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  KEY `parent_location` (`parent_location`),
  KEY `location_changed_by` (`changed_by`),
  CONSTRAINT `location_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`),
  CONSTRAINT `user_who_created_location` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_location` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Unknown Location',NULL,'','','','','','',NULL,NULL,1,'2005-09-22 00:00:00',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'8d6c993e-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Hospital',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2017-04-04 16:10:15',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'16b8884b-1923-11e7-bbfc-9206fc7c228b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute`
--

DROP TABLE IF EXISTS `location_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute` (
  `location_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_location_fk` (`location_id`),
  KEY `location_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `location_attribute_creator_fk` (`creator`),
  KEY `location_attribute_changed_by_fk` (`changed_by`),
  KEY `location_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `location_attribute_type` (`location_attribute_type_id`),
  CONSTRAINT `location_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute`
--

LOCK TABLES `location_attribute` WRITE;
/*!40000 ALTER TABLE `location_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute_type`
--

DROP TABLE IF EXISTS `location_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`location_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `location_attribute_type_unique_name` (`name`),
  KEY `location_attribute_type_creator_fk` (`creator`),
  KEY `location_attribute_type_changed_by_fk` (`changed_by`),
  KEY `location_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `location_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute_type`
--

LOCK TABLES `location_attribute_type` WRITE;
/*!40000 ALTER TABLE `location_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_encounter_type_map`
--

DROP TABLE IF EXISTS `location_encounter_type_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_encounter_type_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `encounter_type_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_encounter_type_map_location_id_fk` (`location_id`),
  KEY `location_encounter_type_map_encounter_type_id_fk` (`encounter_type_id`),
  KEY `location_encounter_type_map_creator_fk` (`creator`),
  KEY `location_encounter_type_map_changed_by_fk` (`changed_by`),
  KEY `location_encounter_type_map_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_encounter_type_map_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_encounter_type_map_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_encounter_type_map_encounter_type_id_fk` FOREIGN KEY (`encounter_type_id`) REFERENCES `encounter_type` (`encounter_type_id`),
  CONSTRAINT `location_encounter_type_map_location_id_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_encounter_type_map_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_encounter_type_map`
--

LOCK TABLES `location_encounter_type_map` WRITE;
/*!40000 ALTER TABLE `location_encounter_type_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_encounter_type_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `location_tag_uuid_index` (`uuid`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  KEY `location_tag_changed_by` (`changed_by`),
  CONSTRAINT `location_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag`
--

LOCK TABLES `location_tag` WRITE;
/*!40000 ALTER TABLE `location_tag` DISABLE KEYS */;
INSERT INTO `location_tag` VALUES (1,'Login Location','When a user logs in and chooses a session location, they may only choose one with this tag',2,'2016-03-07 12:00:10',0,NULL,NULL,NULL,'b8bbf83e-645f-451f-8efe-a0db56f09676',NULL,NULL),(2,'Visit Location','Visit Location',1,'2017-04-04 15:47:14',0,NULL,NULL,NULL,'df82107b-191f-11e7-bbfc-9206fc7c228b',NULL,NULL),(3,'Appointment Location','When a user user creates a appointment service and chooses a location, they may only choose one with this tag',1,'2017-10-30 14:22:09',0,NULL,NULL,NULL,'9cf11c7a-bd4f-11e7-8025-08002715d519',NULL,NULL);
/*!40000 ALTER TABLE `location_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag_map`
--

LOCK TABLES `location_tag_map` WRITE;
/*!40000 ALTER TABLE `location_tag_map` DISABLE KEYS */;
INSERT INTO `location_tag_map` VALUES (2,1),(2,2);
/*!40000 ALTER TABLE `location_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `markers`
--

DROP TABLE IF EXISTS `markers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `markers` (
  `feed_uri` varchar(255) NOT NULL,
  `last_read_entry_id` varchar(255) DEFAULT NULL,
  `feed_uri_for_last_read_entry` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feed_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `markers`
--

LOCK TABLES `markers` WRITE;
/*!40000 ALTER TABLE `markers` DISABLE KEYS */;
/*!40000 ALTER TABLE `markers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_set`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_set` (
  `metadata_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`metadata_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `metadatamapping_metadata_set_creator` (`creator`),
  KEY `metadatamapping_metadata_set_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_set_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_set_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_set`
--

LOCK TABLES `metadatamapping_metadata_set` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_set` DISABLE KEYS */;
INSERT INTO `metadatamapping_metadata_set` VALUES (1,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'9cdbafdf-e2c9-43ec-a6ae-ce6d3c1f6add');
/*!40000 ALTER TABLE `metadatamapping_metadata_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_set_member`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_set_member` (
  `metadata_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `metadata_set_id` int(11) NOT NULL,
  `metadata_class` varchar(1024) NOT NULL,
  `metadata_uuid` varchar(38) NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`metadata_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_set_member_term_unique_within_set` (`metadata_set_id`,`metadata_uuid`),
  KEY `metadatamapping_metadata_set_member_creator` (`creator`),
  KEY `metadatamapping_metadata_set_member_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_set_member_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_set_member_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_metadata_set_id` FOREIGN KEY (`metadata_set_id`) REFERENCES `metadatamapping_metadata_set` (`metadata_set_id`),
  CONSTRAINT `metadatamapping_metadata_set_member_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_set_member`
--

LOCK TABLES `metadatamapping_metadata_set_member` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_set_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatamapping_metadata_set_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_source`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_source` (
  `metadata_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`metadata_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_source_name_unique` (`name`),
  KEY `metadatamapping_metadata_source_creator` (`creator`),
  KEY `metadatamapping_metadata_source_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_source_retired_by` (`retired_by`),
  CONSTRAINT `metadatamapping_metadata_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_source_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_source`
--

LOCK TABLES `metadatamapping_metadata_source` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_source` DISABLE KEYS */;
INSERT INTO `metadatamapping_metadata_source` VALUES (1,'org.openmrs.module.emrapi','Source used to tag metadata used in the EMR API module',2,NULL,'2017-10-30 14:22:46',NULL,0,NULL,NULL,NULL,'2d7e61e2-c3ae-4bf2-a590-3eead0b89d0f');
/*!40000 ALTER TABLE `metadatamapping_metadata_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatamapping_metadata_term_mapping`
--

DROP TABLE IF EXISTS `metadatamapping_metadata_term_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatamapping_metadata_term_mapping` (
  `metadata_term_mapping_id` int(11) NOT NULL AUTO_INCREMENT,
  `metadata_source_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `metadata_class` varchar(1024) DEFAULT NULL,
  `metadata_uuid` varchar(38) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`metadata_term_mapping_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `metadatamapping_metadata_term_code_unique_within_source` (`metadata_source_id`,`code`),
  KEY `metadatamapping_metadata_term_mapping_creator` (`creator`),
  KEY `metadatamapping_metadata_term_mapping_changed_by` (`changed_by`),
  KEY `metadatamapping_metadata_term_mapping_retired_by` (`retired_by`),
  KEY `metadatamapping_idx_mdtm_retired` (`retired`),
  KEY `metadatamapping_idx_mdtm_mdclass` (`metadata_class`(255)),
  KEY `metadatamapping_idx_mdtm_mdsource` (`metadata_source_id`),
  KEY `metadatamapping_idx_mdtm_code` (`code`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_metadata_source_id` FOREIGN KEY (`metadata_source_id`) REFERENCES `metadatamapping_metadata_source` (`metadata_source_id`),
  CONSTRAINT `metadatamapping_metadata_term_mapping_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatamapping_metadata_term_mapping`
--

LOCK TABLES `metadatamapping_metadata_term_mapping` WRITE;
/*!40000 ALTER TABLE `metadatamapping_metadata_term_mapping` DISABLE KEYS */;
INSERT INTO `metadatamapping_metadata_term_mapping` VALUES (1,1,'emr.extraPatientIdentifierTypes','org.openmrs.module.metadatamapping.MetadataSet','9cdbafdf-e2c9-43ec-a6ae-ce6d3c1f6add','emr.extraPatientIdentifierTypes',NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'aad9bc26-1886-4ea7-9992-03cd4c04fba1'),(2,1,'emr.unknownLocation','org.openmrs.Location',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'e426727a-efc8-4233-a919-08a4b7aeeddb'),(3,1,'emr.primaryIdentifierType','org.openmrs.PatientIdentifierType',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'781973cc-f993-4357-a1de-66bdd90a62af'),(4,1,'emr.atFacilityVisitType','org.openmrs.VisitType',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'5ff4c254-7e77-49dd-ada9-5780d8d2d011'),(5,1,'emr.orderingProviderEncounterRole','org.openmrs.EncounterRole',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'b50cce91-a64e-4cde-9774-578db0f93c4f'),(6,1,'emr.checkInClerkEncounterRole','org.openmrs.EncounterRole',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'6c991115-cf55-40ae-857b-d04bbd4ce746'),(7,1,'emr.clinicianEncounterRole','org.openmrs.EncounterRole',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'0421ebcc-d3a6-40a1-bd14-a075c21494df'),(8,1,'emr.checkInEncounterType','org.openmrs.EncounterType',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'be72b624-4a46-43f7-9a95-4c3a621723f3'),(9,1,'emr.consultEncounterType','org.openmrs.EncounterType',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'1749709d-ec0e-4a58-844c-8c6bc09c523a'),(10,1,'emr.visitNoteEncounterType','org.openmrs.EncounterType',NULL,NULL,NULL,2,'2017-10-30 14:22:46',NULL,NULL,0,NULL,NULL,NULL,'b6adc9b3-7128-4cf4-a257-a6f61d45d04a'),(11,1,'emr.admissionEncounterType','org.openmrs.EncounterType','7e30c184-e42f-11e5-8c3e-08002715d519',NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'26909ab9-ca56-45f6-9a17-d82923b197cd'),(12,1,'emr.exitFromInpatientEncounterType','org.openmrs.EncounterType','7e3380a4-e42f-11e5-8c3e-08002715d519',NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'4d94f971-e5d5-470e-93c8-796295c7ccf2'),(13,1,'emr.transferWithinHospitalEncounterType','org.openmrs.EncounterType',NULL,NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'e7cc2e11-441b-4937-9561-58440d459e58'),(14,1,'emr.admissionForm','org.openmrs.Form',NULL,NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'d9dba927-e093-4355-9110-85e358126ba0'),(15,1,'emr.exitFromInpatientForm','org.openmrs.Form',NULL,NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'40ac4a7b-5a7e-49b2-8651-33d6d8f65d52'),(16,1,'emr.transferWithinHospitalForm','org.openmrs.Form',NULL,NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'ad560fd2-7533-42ed-aea5-f1ea31d1376c'),(17,1,'emr.unknownProvider','org.openmrs.module.providermanagement.Provider','f9badd80-ab76-11e2-9e96-0800200c9a66',NULL,NULL,2,'2017-10-30 14:22:47',NULL,NULL,0,NULL,NULL,NULL,'6f46cd39-cb96-4241-af2a-6af85311e1ca');
/*!40000 ALTER TABLE `metadatamapping_metadata_term_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatasharing_exported_package`
--

DROP TABLE IF EXISTS `metadatasharing_exported_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatasharing_exported_package` (
  `exported_package_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `group_uuid` char(38) NOT NULL,
  `version` int(11) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `date_created` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) NOT NULL,
  `content` longblob,
  PRIMARY KEY (`exported_package_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `group_uuid` (`group_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatasharing_exported_package`
--

LOCK TABLES `metadatasharing_exported_package` WRITE;
/*!40000 ALTER TABLE `metadatasharing_exported_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatasharing_exported_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatasharing_imported_item`
--

DROP TABLE IF EXISTS `metadatasharing_imported_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatasharing_imported_item` (
  `imported_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `classname` varchar(256) NOT NULL,
  `existing_uuid` char(38) DEFAULT NULL,
  `date_imported` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `import_type` tinyint(4) DEFAULT '0',
  `assessed` tinyint(1) NOT NULL,
  PRIMARY KEY (`imported_item_id`),
  KEY `uuid` (`uuid`),
  KEY `existing_uuid` (`existing_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatasharing_imported_item`
--

LOCK TABLES `metadatasharing_imported_item` WRITE;
/*!40000 ALTER TABLE `metadatasharing_imported_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatasharing_imported_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadatasharing_imported_package`
--

DROP TABLE IF EXISTS `metadatasharing_imported_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadatasharing_imported_package` (
  `imported_package_id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `group_uuid` char(38) NOT NULL,
  `subscription_url` varchar(512) DEFAULT NULL,
  `subscription_status` tinyint(4) DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_imported` datetime DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `import_config` varchar(1024) DEFAULT NULL,
  `remote_version` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`imported_package_id`),
  KEY `uuid` (`uuid`),
  KEY `group_uuid` (`group_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadatasharing_imported_package`
--

LOCK TABLES `metadatasharing_imported_package` WRITE;
/*!40000 ALTER TABLE `metadatasharing_imported_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadatasharing_imported_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT '0',
  `note_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `note_uuid_index` (`uuid`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  KEY `encounter_note` (`encounter_id`),
  KEY `obs_note` (`obs_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `patient_note` (`patient_id`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`),
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_note` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_note` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(512) NOT NULL,
  `satisfied_by_any` tinyint(1) NOT NULL DEFAULT '0',
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `notification_alert_uuid_index` (`uuid`),
  KEY `alert_date_to_expire_idx` (`date_to_expire`),
  KEY `user_who_changed_alert` (`changed_by`),
  KEY `alert_creator` (`creator`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_alert` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert`
--

LOCK TABLES `notification_alert` WRITE;
/*!40000 ALTER TABLE `notification_alert` DISABLE KEYS */;
INSERT INTO `notification_alert` VALUES (1,'There was an error starting the module: Bacteriology Module',1,1,NULL,1,'2016-03-07 11:59:51',1,'2016-03-07 12:03:03','e78a61db-9e73-4219-a728-ada4497e3746'),(2,'There was an error starting the module: BahmniEMR Core OMOD',1,1,NULL,1,'2016-03-07 11:59:51',1,'2016-03-07 12:03:03','52dd3ff9-87d7-4609-8909-c836a28a5fe2'),(3,'There was an error starting the module: BahmniEMR Core OMOD',1,1,NULL,1,'2016-03-07 12:02:25',1,'2016-03-07 12:03:03','ff0ea6fd-74ee-4e56-85cb-bdf0d6dd6bb0'),(4,'There was an error starting the module: Bacteriology Module',1,1,NULL,1,'2016-03-07 12:02:47',1,'2016-03-07 12:03:03','eaf28f72-aad3-4419-8920-263aec6d5165');
/*!40000 ALTER TABLE `notification_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` tinyint(1) NOT NULL DEFAULT '0',
  `date_changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert_recipient`
--

LOCK TABLES `notification_alert_recipient` WRITE;
/*!40000 ALTER TABLE `notification_alert_recipient` DISABLE KEYS */;
INSERT INTO `notification_alert_recipient` VALUES (1,1,1,'2016-03-07 06:33:03','d63513e0-4806-47d7-a271-beaf03fd96e6'),(2,1,1,'2016-03-07 06:33:03','39555fc4-fab3-4e9b-9013-7f9ec189131c'),(3,1,1,'2016-03-07 06:33:03','8f99452d-423e-455a-b55e-05b9de071144'),(4,1,1,'2016-03-07 06:33:03','fc135592-0b73-40a6-b878-e170f766f0d0');
/*!40000 ALTER TABLE `notification_alert_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `template` text,
  `subject` varchar(100) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `recipients` varchar(512) DEFAULT NULL,
  `ordinal` int(11) DEFAULT '0',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `notification_template_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template`
--

LOCK TABLES `notification_template` WRITE;
/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs`
--

DROP TABLE IF EXISTS `obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) DEFAULT NULL,
  `value_text` text,
  `value_complex` varchar(1000) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) DEFAULT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'FINAL',
  `interpretation` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `obs_uuid_index` (`uuid`),
  KEY `obs_datetime_idx` (`obs_datetime`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_enterer` (`creator`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `answer_concept` (`value_coded`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `user_who_voided_obs` (`voided_by`),
  KEY `previous_version` (`previous_version`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`),
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`),
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `previous_version` FOREIGN KEY (`previous_version`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `user_who_voided_obs` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs`
--

LOCK TABLES `obs` WRITE;
/*!40000 ALTER TABLE `obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs_relationship`
--

DROP TABLE IF EXISTS `obs_relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs_relationship` (
  `obs_relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `obs_relationship_type_id` int(11) NOT NULL,
  `source_obs_id` int(11) NOT NULL,
  `target_obs_id` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` int(11) NOT NULL,
  PRIMARY KEY (`obs_relationship_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `obs_relationship_type_id` (`obs_relationship_type_id`),
  KEY `source_obs_id` (`source_obs_id`),
  KEY `target_obs_id` (`target_obs_id`),
  KEY `creator` (`creator`),
  CONSTRAINT `obs_relationship_ibfk_1` FOREIGN KEY (`obs_relationship_type_id`) REFERENCES `obs_relationship_type` (`obs_relationship_type_id`),
  CONSTRAINT `obs_relationship_ibfk_2` FOREIGN KEY (`source_obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `obs_relationship_ibfk_3` FOREIGN KEY (`target_obs_id`) REFERENCES `obs` (`obs_id`),
  CONSTRAINT `obs_relationship_ibfk_4` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs_relationship`
--

LOCK TABLES `obs_relationship` WRITE;
/*!40000 ALTER TABLE `obs_relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs_relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs_relationship_type`
--

DROP TABLE IF EXISTS `obs_relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs_relationship_type` (
  `obs_relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `retired` tinyint(4) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`obs_relationship_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `creator` (`creator`),
  KEY `changed_by` (`changed_by`),
  KEY `retired_by` (`retired_by`),
  CONSTRAINT `obs_relationship_type_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `obs_relationship_type_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `obs_relationship_type_ibfk_3` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs_relationship_type`
--

LOCK TABLES `obs_relationship_type` WRITE;
/*!40000 ALTER TABLE `obs_relationship_type` DISABLE KEYS */;
INSERT INTO `obs_relationship_type` VALUES (1,'qualified-by','target is qualified by source','dbde17aa-3d7e-11e4-8782-164230d1df67',1,'2016-03-07 12:10:34',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `obs_relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_frequency`
--

DROP TABLE IF EXISTS `order_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_frequency` (
  `order_frequency_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `frequency_per_day` double DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_frequency_id`),
  UNIQUE KEY `concept_id` (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_frequency_creator_fk` (`creator`),
  KEY `order_frequency_retired_by_fk` (`retired_by`),
  KEY `order_frequency_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_frequency_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_frequency_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_frequency_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_frequency_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_frequency`
--

LOCK TABLES `order_frequency` WRITE;
/*!40000 ALTER TABLE `order_frequency` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group`
--

DROP TABLE IF EXISTS `order_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group` (
  `order_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_group_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_patient_id_fk` (`patient_id`),
  KEY `order_group_encounter_id_fk` (`encounter_id`),
  KEY `order_group_creator_fk` (`creator`),
  KEY `order_group_set_id_fk` (`order_set_id`),
  KEY `order_group_voided_by_fk` (`voided_by`),
  KEY `order_group_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_group_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `order_group_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `order_group_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`),
  CONSTRAINT `order_group_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group`
--

LOCK TABLES `order_group` WRITE;
/*!40000 ALTER TABLE `order_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set`
--

DROP TABLE IF EXISTS `order_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set` (
  `order_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_creator_fk` (`creator`),
  KEY `order_set_retired_by_fk` (`retired_by`),
  KEY `order_set_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_set_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set`
--

LOCK TABLES `order_set` WRITE;
/*!40000 ALTER TABLE `order_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_member`
--

DROP TABLE IF EXISTS `order_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_member` (
  `order_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` int(11) NOT NULL,
  `order_template` text,
  `order_template_type` varchar(1024) DEFAULT NULL,
  `order_set_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_member_creator_fk` (`creator`),
  KEY `order_set_member_order_set_id_fk` (`order_set_id`),
  KEY `order_set_member_concept_id_fk` (`concept_id`),
  KEY `order_set_member_order_type_fk` (`order_type`),
  KEY `order_set_member_retired_by_fk` (`retired_by`),
  KEY `order_set_member_changed_by_fk` (`changed_by`),
  CONSTRAINT `order_set_member_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_member_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_set_member_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_member_order_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`),
  CONSTRAINT `order_set_member_order_type_fk` FOREIGN KEY (`order_type`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `order_set_member_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_member`
--

LOCK TABLES `order_set_member` WRITE;
/*!40000 ALTER TABLE `order_set_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `java_class_name` varchar(255) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `order_type_uuid_index` (`uuid`),
  KEY `order_type_retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  KEY `order_type_changed_by` (`changed_by`),
  KEY `order_type_parent_order_type` (`parent`),
  CONSTRAINT `order_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_type_parent_order_type` FOREIGN KEY (`parent`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `type_created_by` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_order_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type`
--

LOCK TABLES `order_type` WRITE;
/*!40000 ALTER TABLE `order_type` DISABLE KEYS */;
INSERT INTO `order_type` VALUES (2,'Drug Order','An order for a medication to be given to the patient',1,'2010-05-12 00:00:00',0,NULL,NULL,NULL,'131168f4-15f5-102d-96e4-000c29c2a5d7','org.openmrs.DrugOrder',NULL,NULL,NULL),(3,'Test Order','Order type for test orders',1,'2014-03-09 00:00:00',0,NULL,NULL,NULL,'52a447d3-a64a-11e3-9aeb-50e549534c5e','org.openmrs.TestOrder',NULL,NULL,NULL),(4,'Lab Order','An order for laboratory tests',1,'2016-03-07 12:10:33',0,NULL,NULL,NULL,'7e13af67-e42f-11e5-8c3e-08002715d519','org.openmrs.Order',NULL,NULL,NULL),(5,'Radiology Order','An order for radiology tests',1,'2016-03-07 12:10:33',0,NULL,NULL,NULL,'7e13c62d-e42f-11e5-8c3e-08002715d519','org.openmrs.Order',NULL,NULL,NULL);
/*!40000 ALTER TABLE `order_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type_class_map`
--

DROP TABLE IF EXISTS `order_type_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type_class_map` (
  `order_type_id` int(11) NOT NULL,
  `concept_class_id` int(11) NOT NULL,
  PRIMARY KEY (`order_type_id`,`concept_class_id`),
  UNIQUE KEY `concept_class_id` (`concept_class_id`),
  CONSTRAINT `fk_order_type_class_map_concept_class_concept_class_id` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `fk_order_type_order_type_id` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type_class_map`
--

LOCK TABLES `order_type_class_map` WRITE;
/*!40000 ALTER TABLE `order_type_class_map` DISABLE KEYS */;
INSERT INTO `order_type_class_map` VALUES (2,3),(4,8),(4,28);
/*!40000 ALTER TABLE `order_type_class_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) DEFAULT NULL,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `orderer` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `instructions` text,
  `date_activated` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `order_reason` int(11) DEFAULT NULL,
  `order_reason_non_coded` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `urgency` varchar(50) NOT NULL DEFAULT 'ROUTINE',
  `order_number` varchar(50) NOT NULL,
  `previous_order_id` int(11) DEFAULT NULL,
  `order_action` varchar(50) NOT NULL,
  `comment_to_fulfiller` varchar(1024) DEFAULT NULL,
  `care_setting` int(11) NOT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `order_group_id` int(11) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `orders_uuid_index` (`uuid`),
  KEY `order_creator` (`creator`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `order_for_patient` (`patient_id`),
  KEY `user_who_voided_order` (`voided_by`),
  KEY `previous_order_id_order_id` (`previous_order_id`),
  KEY `orders_care_setting` (`care_setting`),
  KEY `discontinued_because` (`order_reason`),
  KEY `fk_orderer_provider` (`orderer`),
  KEY `bahmni_orders_date_activated` (`date_activated`),
  KEY `orders_order_group_id_fk` (`order_group_id`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`order_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `fk_orderer_provider` FOREIGN KEY (`orderer`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `orders_care_setting` FOREIGN KEY (`care_setting`) REFERENCES `care_setting` (`care_setting_id`),
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `orders_order_group_id_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `previous_order_id_order_id` FOREIGN KEY (`previous_order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `type_of_order` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`),
  CONSTRAINT `user_who_voided_order` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `allergy_status` varchar(50) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_pat` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_patient` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_appointment`
--

DROP TABLE IF EXISTS `patient_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_appointment` (
  `patient_appointment_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) DEFAULT NULL,
  `appointment_number` varchar(50) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `start_date_time` datetime NOT NULL,
  `end_date_time` datetime NOT NULL,
  `appointment_service_id` int(11) DEFAULT NULL,
  `appointment_service_type_id` int(11) DEFAULT NULL,
  `status` varchar(45) NOT NULL COMMENT 'scheduled, checked in, started, completed, cancelled, missed',
  `location_id` int(11) DEFAULT NULL,
  `appointment_kind` varchar(45) NOT NULL COMMENT 'scheduled, walk in',
  `comments` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(4) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_appointment_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_patient_appointment_patient` (`patient_id`),
  KEY `fk_patient_appointment_location` (`location_id`),
  KEY `fk_patient_appointment_provider` (`provider_id`),
  KEY `fk_patient_appointment_appointment_service` (`appointment_service_id`),
  KEY `fk_patient_appointment_appointment_service_type` (`appointment_service_type_id`),
  CONSTRAINT `fk_patient_appointment_appointment_service` FOREIGN KEY (`appointment_service_id`) REFERENCES `appointment_service` (`appointment_service_id`),
  CONSTRAINT `fk_patient_appointment_appointment_service_type` FOREIGN KEY (`appointment_service_type_id`) REFERENCES `appointment_service_type` (`appointment_service_type_id`),
  CONSTRAINT `fk_patient_appointment_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `fk_patient_appointment_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_patient_appointment_provider` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_appointment`
--

LOCK TABLES `patient_appointment` WRITE;
/*!40000 ALTER TABLE `patient_appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_appointment_audit`
--

DROP TABLE IF EXISTS `patient_appointment_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_appointment_audit` (
  `patient_appointment_audit_id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_id` int(11) NOT NULL,
  `uuid` varchar(38) NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(4) DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`patient_appointment_audit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fk_patient_appointment_audit_patient_appointment_idx` (`appointment_id`),
  CONSTRAINT `fk_patient_appointment_audit_patient_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `patient_appointment` (`patient_appointment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_appointment_audit`
--

LOCK TABLES `patient_appointment_audit` WRITE;
/*!40000 ALTER TABLE `patient_appointment_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_appointment_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `identifier_type` int(11) NOT NULL DEFAULT '0',
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `location_id` int(11) DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `patient_identifier_uuid_index` (`uuid`),
  KEY `identifier_name` (`identifier`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  KEY `identifier_creator` (`creator`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  KEY `identifier_voider` (`voided_by`),
  KEY `patient_identifier_changed_by` (`changed_by`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`),
  CONSTRAINT `fk_patient_id_patient_identifier` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier`
--

LOCK TABLES `patient_identifier` WRITE;
/*!40000 ALTER TABLE `patient_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `format` varchar(255) DEFAULT NULL,
  `check_digit` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `format_description` varchar(255) DEFAULT NULL,
  `validator` varchar(200) DEFAULT NULL,
  `location_behavior` varchar(50) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `uniqueness_behavior` varchar(50) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `patient_identifier_type_uuid_index` (`uuid`),
  KEY `patient_identifier_type_retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  KEY `patient_identifier_type_changed_by` (`changed_by`),
  CONSTRAINT `patient_identifier_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_patient_identifier_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier_type`
--

LOCK TABLES `patient_identifier_type` WRITE;
/*!40000 ALTER TABLE `patient_identifier_type` DISABLE KEYS */;
INSERT INTO `patient_identifier_type` VALUES (1,'OpenMRS Identification Number','Unique number used in OpenMRS','',1,1,'2005-09-22 00:00:00',0,NULL,'org.openmrs.patient.impl.LuhnIdentifierValidator',NULL,0,NULL,NULL,NULL,'8d793bee-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL),(2,'Old Identification Number','Number given out prior to the OpenMRS system (No check digit)','',0,1,'2005-09-22 00:00:00',0,NULL,NULL,NULL,0,NULL,NULL,NULL,'8d79403a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL),(3,'Patient Identifier','New patient identifier type created for use by the Bahmni Registration System',NULL,0,1,'2016-03-07 00:00:00',1,NULL,NULL,'NOT_USED',0,NULL,NULL,NULL,'7dfc1a64-e42f-11e5-8c3e-08002715d519',NULL,NULL,NULL);
/*!40000 ALTER TABLE `patient_identifier_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT '0',
  `program_id` int(11) NOT NULL DEFAULT '0',
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `outcome_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `patient_program_uuid_index` (`uuid`),
  KEY `user_who_changed` (`changed_by`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_in_program` (`patient_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  KEY `patient_program_location_id` (`location_id`),
  KEY `patient_program_outcome_concept_id_fk` (`outcome_concept_id`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `patient_program_outcome_concept_id_fk` FOREIGN KEY (`outcome_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `user_who_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_patient_program` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program`
--

LOCK TABLES `patient_program` WRITE;
/*!40000 ALTER TABLE `patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program_attribute`
--

DROP TABLE IF EXISTS `patient_program_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program_attribute` (
  `patient_program_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_program_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_attribute_programid_fk` (`patient_program_id`),
  KEY `patient_program_attribute_attributetype_fk` (`attribute_type_id`),
  KEY `patient_program_attribute_creator_fk` (`creator`),
  KEY `patient_program_attribute_changed_by_fk` (`changed_by`),
  CONSTRAINT `patient_program_attribute_attributetype_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `program_attribute_type` (`program_attribute_type_id`),
  CONSTRAINT `patient_program_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_program_attribute_programid_fk` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_attribute`
--

LOCK TABLES `patient_program_attribute` WRITE;
/*!40000 ALTER TABLE `patient_program_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `patient_state_uuid_index` (`uuid`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `state_for_patient` (`state`),
  KEY `patient_state_voider` (`voided_by`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`),
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_for_patient` FOREIGN KEY (`state`) REFERENCES `program_workflow_state` (`program_workflow_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_state`
--

LOCK TABLES `patient_state` WRITE;
/*!40000 ALTER TABLE `patient_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `deathdate_estimated` tinyint(1) NOT NULL DEFAULT '0',
  `birthtime` time DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `person_uuid_index` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_person` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_person` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_person` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'M',NULL,0,0,NULL,NULL,NULL,'2005-01-01 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'d0985259-e42b-11e5-8c3e-08002715d519',0,NULL),(2,'F',NULL,0,0,NULL,NULL,2,'2016-03-07 12:00:09',NULL,NULL,0,NULL,NULL,NULL,'dad23b01-9a5c-469d-a29e-785d1ab46fac',0,NULL),(3,'',NULL,0,0,NULL,NULL,1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7e764952-e42f-11e5-8c3e-08002715d519',0,NULL),(4,'',NULL,0,0,NULL,NULL,1,'2016-03-07 12:17:31',NULL,NULL,0,NULL,NULL,NULL,'77210274-e430-11e5-8c3e-08002715d519',0,NULL),(5,'',NULL,0,0,NULL,NULL,1,'2016-03-07 12:20:56',NULL,NULL,0,NULL,NULL,NULL,'f164583c-e430-11e5-8c3e-08002715d519',0,NULL),(6,'M',NULL,0,0,NULL,NULL,1,'2017-04-04 16:10:15',NULL,NULL,0,NULL,NULL,NULL,'16b6c72d-1923-11e7-bbfc-9206fc7c228b',0,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `person_address_uuid_index` (`uuid`),
  KEY `patient_address_creator` (`creator`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_void` (`voided_by`),
  KEY `person_address_changed_by` (`changed_by`),
  KEY `person_address_city_village` (`city_village`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_address_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `person_attribute_uuid_index` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  KEY `attribute_voider` (`voided_by`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`),
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute`
--

LOCK TABLES `person_attribute` WRITE;
/*!40000 ALTER TABLE `person_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text,
  `format` varchar(50) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `person_attribute_type_uuid_index` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `user_who_retired_person_attribute_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute_type`
--

LOCK TABLES `person_attribute_type` WRITE;
/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
INSERT INTO `person_attribute_type` VALUES (8,'givenNameLocal','givenNameLocal','java.lang.String',NULL,0,1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'7e6db4ea-e42f-11e5-8c3e-08002715d519'),(9,'familyNameLocal','familyNameLocal','java.lang.String',NULL,0,1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'7e6f78a4-e42f-11e5-8c3e-08002715d519'),(10,'middleNameLocal','middleNameLocal','java.lang.String',NULL,0,1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'7e709f5b-e42f-11e5-8c3e-08002715d519');
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_merge_log`
--

DROP TABLE IF EXISTS `person_merge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_merge_log` (
  `person_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_person_id` int(11) NOT NULL,
  `loser_person_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `merged_data` longtext NOT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_merge_log_id`),
  UNIQUE KEY `person_merge_log_unique_uuid` (`uuid`),
  KEY `person_merge_log_winner` (`winner_person_id`),
  KEY `person_merge_log_loser` (`loser_person_id`),
  KEY `person_merge_log_creator` (`creator`),
  KEY `person_merge_log_changed_by_fk` (`changed_by`),
  KEY `person_merge_log_voided_by_fk` (`voided_by`),
  CONSTRAINT `person_merge_log_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_loser` FOREIGN KEY (`loser_person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_merge_log_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `person_merge_log_winner` FOREIGN KEY (`winner_person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_merge_log`
--

LOCK TABLES `person_merge_log` WRITE;
/*!40000 ALTER TABLE `person_merge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_merge_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name_prefix` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `family_name2` varchar(50) DEFAULT NULL,
  `family_name_suffix` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `person_name_uuid_index` (`uuid`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `family_name2` (`family_name2`),
  KEY `user_who_made_name` (`creator`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_voided_name` (`voided_by`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON UPDATE CASCADE,
  CONSTRAINT `user_who_made_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_name`
--

LOCK TABLES `person_name` WRITE;
/*!40000 ALTER TABLE `person_name` DISABLE KEYS */;
INSERT INTO `person_name` VALUES (1,1,1,NULL,'Super','',NULL,'User',NULL,NULL,NULL,1,'2005-01-01 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'d09e6289-e42b-11e5-8c3e-08002715d519'),(2,1,2,NULL,'Unknown',NULL,NULL,'Provider',NULL,NULL,NULL,2,'2016-03-07 12:00:09',0,NULL,NULL,NULL,NULL,NULL,'12b12c77-f5b4-464e-b94c-fff592379d31'),(3,1,4,NULL,'Reports',NULL,NULL,'User',NULL,NULL,NULL,1,'2016-03-07 12:17:31',0,NULL,NULL,NULL,NULL,NULL,'77210274-e430-11e5-8c3e-08002715d519'),(4,1,6,NULL,'Super',NULL,NULL,'Man',NULL,NULL,NULL,1,'2017-04-04 16:10:15',0,NULL,NULL,NULL,6,'2017-04-04 16:10:58','16b7511c-1923-11e7-bbfc-9206fc7c228b');
/*!40000 ALTER TABLE `person_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege` (
  `privilege` varchar(255) NOT NULL,
  `description` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `privilege_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES ('Add Allergies','Add allergies','02ba7695-c487-4c07-8979-07b64fc9b49e'),('Add Cohorts','Able to add a cohort to the system','d0a1a77e-e42b-11e5-8c3e-08002715d519'),('Add Concept Proposals','Able to add concept proposals to the system','d0a1a9dc-e42b-11e5-8c3e-08002715d519'),('Add Drug Groups','Ability to create Drug Groups','4df00833-d586-4bce-bdd4-b34037d693c8'),('Add Drug Info','Ability to create Drug Info','8e655648-cc42-4558-9a0e-88824daf613e'),('Add Encounters','Able to add patient encounters','d0a1aa6a-e42b-11e5-8c3e-08002715d519'),('Add HL7 Inbound Archive','Able to add an HL7 archive item','adf2d025-4afa-443a-a4bd-ef04590d3dc7'),('Add HL7 Inbound Exception','Able to add an HL7 error item','263959ab-8c0e-4c99-8487-7bbda29f5c11'),('Add HL7 Inbound Queue','Able to add an HL7 Queue item','4134c776-e68d-48b0-836f-120d1e2f339e'),('Add HL7 Source','Able to add an HL7 Source','186cde00-e4ac-4895-892b-74e856648af8'),('Add Observations','Able to add patient observations','d0a1aadc-e42b-11e5-8c3e-08002715d519'),('Add Orders','Able to add orders','d0a1ab47-e42b-11e5-8c3e-08002715d519'),('Add Patient Identifiers','Able to add patient identifiers','d0a1abb7-e42b-11e5-8c3e-08002715d519'),('Add Patient Lists','Ability to create patient lists','52f93c4b-d86b-41a8-8bae-17baf46e7a8a'),('Add Patient Programs','Able to add patients to programs','d0a1ac26-e42b-11e5-8c3e-08002715d519'),('Add Patients','Able to add patients','d0a1ac94-e42b-11e5-8c3e-08002715d519'),('Add People','Able to add person objects','d0a1acfe-e42b-11e5-8c3e-08002715d519'),('Add Problems','Add problems','f7df4421-5d51-4d86-8023-413f48b491c9'),('Add Relationships','Able to add relationships','d0a1ad59-e42b-11e5-8c3e-08002715d519'),('Add Report Objects','Able to add report objects','d0a1adb7-e42b-11e5-8c3e-08002715d519'),('Add Reports','Able to add reports','d0a1ae11-e42b-11e5-8c3e-08002715d519'),('Add Users','Able to add users to OpenMRS','d0a1ae69-e42b-11e5-8c3e-08002715d519'),('Add Visits','Able to add visits','f101d6f9-8ac4-4341-8638-4918148732d8'),('app:admin','Bahmni admin app access privilege','7ec6e50e-e42f-11e5-8c3e-08002715d519'),('app:adt','Admission Discharge Transfer app access privilege','fbf76184-e42d-11e5-8c3e-08002715d519'),('app:appointments','Able to view Appointments module','9c9c4d67-bd4f-11e7-8025-08002715d519'),('app:appointments:adminTab','Able to manage services in appointments module','9c9db37b-bd4f-11e7-8025-08002715d519'),('app:appointments:manageAppointmentsTab','Able to manage appointments in appointments module','9c9d1b9e-bd4f-11e7-8025-08002715d519'),('app:clinical','Bahmni clinical app access privilege','7e47c302-e42f-11e5-8c3e-08002715d519'),('app:clinical:bacteriologyTab','View Bacteriology tab','df974b66-191f-11e7-bbfc-9206fc7c228b'),('app:clinical:consultationTab','View Consultation tab','7f395561-e42f-11e5-8c3e-08002715d519'),('app:clinical:deleteDiagnosis','Bahmni delete diagnosis privilege','7f7f0673-e42f-11e5-8c3e-08002715d519'),('app:clinical:diagnosisTab','View and Edit Diagnosis tab','7f350f68-e42f-11e5-8c3e-08002715d519'),('app:clinical:dispositionTab','View Disposition tab','7f36545e-e42f-11e5-8c3e-08002715d519'),('app:clinical:grantProviderAccess','Bahmni clinical app grant access for other Provider','7f81b20a-e42f-11e5-8c3e-08002715d519'),('app:clinical:history','Bahmni observation history view and edit','7f33b038-e42f-11e5-8c3e-08002715d519'),('app:clinical:locationpicker','View Location Picker option','df7f4f4a-191f-11e7-bbfc-9206fc7c228b'),('app:clinical:observationTab','View Observation tab','7f378d9e-e42f-11e5-8c3e-08002715d519'),('app:clinical:onbehalf','View On behalf of option','df8088c8-191f-11e7-bbfc-9206fc7c228b'),('app:clinical:ordersTab','View Orders tab','df96e939-191f-11e7-bbfc-9206fc7c228b'),('app:clinical:retrospective','Bahmni clinical app retrospective access privilege','7f6dc1ef-e42f-11e5-8c3e-08002715d519'),('app:clinical:treatmentTab','View Treatment tab','df96ac37-191f-11e7-bbfc-9206fc7c228b'),('app:common:closeVisit','Adding close visit privilege','7f7ce029-e42f-11e5-8c3e-08002715d519'),('app:common:registration_consultation_link','Adding Registration to/from Consultation Link','7f7a9bba-e42f-11e5-8c3e-08002715d519'),('app:document-upload','bahmni document upload access privilege','7e57f1a1-e42f-11e5-8c3e-08002715d519'),('app:emergency','bahmni emergency app access privilege','7ff950fc-e42f-11e5-8c3e-08002715d519'),('app:implementer-interface','Will give access to implementer interface app','df9797f2-191f-11e7-bbfc-9206fc7c228b'),('app:orders','Bahmni Orders App Access Privilege','7f7de037-e42f-11e5-8c3e-08002715d519'),('app:patient-documents','Will give access to patient documents app','df97fed8-191f-11e7-bbfc-9206fc7c228b'),('app:radiology-upload','Will give access to radiology app','df97ee53-191f-11e7-bbfc-9206fc7c228b'),('app:radiologyOrders','Bahmni radiology orders access privilege','7e4948f9-e42f-11e5-8c3e-08002715d519'),('app:registration','Bahmni registration app access privilege','7ff80bd0-e42f-11e5-8c3e-08002715d519'),('app:reports','View Reports','80293327-e42f-11e5-8c3e-08002715d519'),('Assign Beds','Able to assign bed to patient','fbf9a034-e42d-11e5-8c3e-08002715d519'),('Assign System Developer Role','Able to assign System Developer role','6438ce19-392f-453f-8a2f-37aac41afc8d'),('bahmni:clinical:dispense','Bahmni drug order dispensing privilege','7f72e5fd-e42f-11e5-8c3e-08002715d519'),('Configure Visits','Able to choose encounter visit handler and enable/disable encounter visits','b41fe5e2-f557-470b-9de0-f9e2b0e9bc06'),('Delete Cohorts','Able to add a cohort to the system','d0a1aec4-e42b-11e5-8c3e-08002715d519'),('Delete Concept Proposals','Able to delete concept proposals from the system','d0a1af1d-e42b-11e5-8c3e-08002715d519'),('Delete Drug Groups','Ability to delete Drug Groups','bae42978-fd7f-4fec-8d9b-ec68d69c9384'),('Delete Drug Info','Ability to delete Drug Info','a6e0103d-6b77-4987-a1ec-00a1454f7f66'),('Delete Encounters','Able to delete patient encounters','d0a1af7a-e42b-11e5-8c3e-08002715d519'),('Delete HL7 Inbound Archive','Able to delete/retire an HL7 archive item','3e06c14a-c781-441c-b0a6-075c79c056d5'),('Delete HL7 Inbound Exception','Able to delete an HL7 archive item','7e0b935a-99fe-4234-8d8a-9e12078940cd'),('Delete HL7 Inbound Queue','Able to delete an HL7 Queue item','603ea38c-63fe-4924-8893-894e342a7a45'),('Delete Notes','Able to delete patient notes','ff3427b8-6856-4eab-a166-de5188b40c31'),('Delete Observations','Able to delete patient observations','d0a1afd4-e42b-11e5-8c3e-08002715d519'),('Delete Orders','Able to delete orders','d0a1b02d-e42b-11e5-8c3e-08002715d519'),('Delete Patient Identifiers','Able to delete patient identifiers','d0a1b086-e42b-11e5-8c3e-08002715d519'),('Delete Patient Lists','Ability to delete patient lists','81f50af9-eec0-45e6-9ef2-bf128f15e3fe'),('Delete Patient Programs','Able to delete patients from programs','d0a1b0e0-e42b-11e5-8c3e-08002715d519'),('Delete Patients','Able to delete patients','d0a1b13b-e42b-11e5-8c3e-08002715d519'),('Delete People','Able to delete objects','d0a1b194-e42b-11e5-8c3e-08002715d519'),('Delete Relationships','Able to delete relationships','d0a1b1ed-e42b-11e5-8c3e-08002715d519'),('Delete Report Objects','Able to delete report objects','d0a1b247-e42b-11e5-8c3e-08002715d519'),('Delete Reports','Able to delete reports','d0a1b2a0-e42b-11e5-8c3e-08002715d519'),('Delete Users','Able to delete users in OpenMRS','d0a1b2fa-e42b-11e5-8c3e-08002715d519'),('Delete Visits','Able to delete visits','2ae1b80b-107c-4f2b-a52d-2656a1e3c653'),('Edit Admission Locations','Able to Edit admission locations','fbfc1b21-e42d-11e5-8c3e-08002715d519'),('Edit Allergies','Able to edit allergies','712eef3b-0fc4-4651-a3b6-e218a42e06be'),('Edit Cohorts','Able to add a cohort to the system','d0a1b353-e42b-11e5-8c3e-08002715d519'),('Edit Concept Proposals','Able to edit concept proposals in the system','d0a1b3ab-e42b-11e5-8c3e-08002715d519'),('Edit conditions','Privilege to add or edit conditions','9c907809-bd4f-11e7-8025-08002715d519'),('Edit Drug Groups','Ability to edit Drug Groups','62fe3838-3d6a-45a9-9fa8-ed728bcd2827'),('Edit Drug Info','Ability to edit Drug Info','a5680d09-4651-47a0-81f4-2cc315ea6c12'),('Edit Encounters','Able to edit patient encounters','d0a1b404-e42b-11e5-8c3e-08002715d519'),('Edit Notes','Able to edit patient notes','82eb4366-8ea7-465a-b869-f5e1405a7410'),('Edit Observations','Able to edit patient observations','d0a1b45a-e42b-11e5-8c3e-08002715d519'),('Edit Orders','Able to edit orders','d0a1b4b3-e42b-11e5-8c3e-08002715d519'),('Edit Patient Identifiers','Able to edit patient identifiers','d0a1b50b-e42b-11e5-8c3e-08002715d519'),('Edit Patient Lists','Ability to edit patient lists','94b4ff6a-cbd5-467d-bcbb-256a3bdd0f5d'),('Edit Patient Programs','Able to edit patients in programs','d0a1b565-e42b-11e5-8c3e-08002715d519'),('Edit Patients','Able to edit patients','d0a1b5bd-e42b-11e5-8c3e-08002715d519'),('Edit People','Able to edit person objects','d0a1b615-e42b-11e5-8c3e-08002715d519'),('Edit Problems','Able to edit problems','a9952e7a-8d5a-4bd1-8b9e-937dcf70fba5'),('Edit Relationships','Able to edit relationships','d0a1b66c-e42b-11e5-8c3e-08002715d519'),('Edit Report Objects','Able to edit report objects','d0a1b6c3-e42b-11e5-8c3e-08002715d519'),('Edit Reports','Able to edit reports','d0a1b71c-e42b-11e5-8c3e-08002715d519'),('Edit Tags','Able to associate tags to the bed','99e7d75f-bd4f-11e7-8025-08002715d519'),('Edit User Passwords','Able to change the passwords of users in OpenMRS','d0a1b773-e42b-11e5-8c3e-08002715d519'),('Edit Users','Able to edit users in OpenMRS','d0a1b7cb-e42b-11e5-8c3e-08002715d519'),('Edit Visits','Able to edit visits','accea205-b863-4a42-a6db-24d7e45773bc'),('Form Entry','Allows user to access Form Entry pages/functions','d0a1b823-e42b-11e5-8c3e-08002715d519'),('Generate Batch of Identifiers','Allows user to generate a batch of identifiers to a file for offline use','3addc24a-a35a-49cd-910e-167af499fb44'),('Get Admission Locations','Able to view admission locations','fbfadd89-e42d-11e5-8c3e-08002715d519'),('Get Allergies','Able to get allergies','d05118c6-2490-4d78-a41a-390e3596a220'),('Get Beds','Able to view available beds','fbf88423-e42d-11e5-8c3e-08002715d519'),('Get Care Settings','Able to get Care Settings','97d169a8-cee8-44f0-8e5b-8071a0ed148c'),('Get Concept Attribute Types','Able to get concept attribute types','4db3a25f-0331-42aa-b54b-d809cbf22a87'),('Get Concept Classes','Able to get concept classes','d05118c6-2490-4d78-a41a-390e3596a238'),('Get Concept Datatypes','Able to get concept datatypes','d05118c6-2490-4d78-a41a-390e3596a237'),('Get Concept Map Types','Able to get concept map types','d05118c6-2490-4d78-a41a-390e3596a230'),('Get Concept Proposals','Able to get concept proposals to the system','d05118c6-2490-4d78-a41a-390e3596a250'),('Get Concept Reference Terms','Able to get concept reference terms','d05118c6-2490-4d78-a41a-390e3596a229'),('Get Concept Sources','Able to get concept sources','d05118c6-2490-4d78-a41a-390e3596a231'),('Get Concepts','Able to get concept entries','d05118c6-2490-4d78-a41a-390e3596a251'),('Get conditions','Privilege to view conditions','9c91536f-bd4f-11e7-8025-08002715d519'),('Get Database Changes','Able to get database changes from the admin screen','d05118c6-2490-4d78-a41a-390e3596a222'),('Get Encounter Roles','Able to get encounter roles','d05118c6-2490-4d78-a41a-390e3596a210'),('Get Encounter Types','Able to get encounter types','d05118c6-2490-4d78-a41a-390e3596a247'),('Get Encounters','Able to get patient encounters','d05118c6-2490-4d78-a41a-390e3596a248'),('Get Field Types','Able to get field types','d05118c6-2490-4d78-a41a-390e3596a234'),('Get Forms','Able to get forms','d05118c6-2490-4d78-a41a-390e3596a240'),('Get Global Properties','Able to get global properties on the administration screen','d05118c6-2490-4d78-a41a-390e3596a226'),('Get HL7 Inbound Archive','Able to get an HL7 archive item','d05118c6-2490-4d78-a41a-390e3596a217'),('Get HL7 Inbound Exception','Able to get an HL7 error item','d05118c6-2490-4d78-a41a-390e3596a216'),('Get HL7 Inbound Queue','Able to get an HL7 Queue item','d05118c6-2490-4d78-a41a-390e3596a218'),('Get HL7 Source','Able to get an HL7 Source','d05118c6-2490-4d78-a41a-390e3596a219'),('Get Identifier Types','Able to get patient identifier types','d05118c6-2490-4d78-a41a-390e3596a239'),('Get Location Attribute Types','Able to get location attribute types','d05118c6-2490-4d78-a41a-390e3596a212'),('Get Locations','Able to get locations','d05118c6-2490-4d78-a41a-390e3596a246'),('Get Notes','Able to get patient notes','cbf9c51d-5a5a-4341-9a2f-9f5371582627'),('Get Observations','Able to get patient observations','d05118c6-2490-4d78-a41a-390e3596a245'),('Get Order Frequencies','Able to get Order Frequencies','502cbb08-78df-4357-8c1a-dd68f9a5eac5'),('Get Order Sets','Able to get order sets','a6810945-b1d2-46ab-9547-dd61632b0dd9'),('Get Order Types','Able to get order types','d05118c6-2490-4d78-a41a-390e3596a233'),('Get Orders','Able to get orders','d05118c6-2490-4d78-a41a-390e3596a241'),('Get Patient Cohorts','Able to get patient cohorts','d05118c6-2490-4d78-a41a-390e3596a242'),('Get Patient Identifiers','Able to get patient identifiers','d05118c6-2490-4d78-a41a-390e3596a243'),('Get Patient Programs','Able to get which programs that patients are in','d05118c6-2490-4d78-a41a-390e3596a227'),('Get Patients','Able to get patients','d05118c6-2490-4d78-a41a-390e3596a244'),('Get People','Able to get person objects','d05118c6-2490-4d78-a41a-390e3596a224'),('Get Person Attribute Types','Able to get person attribute types','d05118c6-2490-4d78-a41a-390e3596a225'),('Get Privileges','Able to get user privileges','d05118c6-2490-4d78-a41a-390e3596a236'),('Get Problems','Able to get problems','d05118c6-2490-4d78-a41a-390e3596a221'),('Get Programs','Able to get patient programs','d05118c6-2490-4d78-a41a-390e3596a228'),('Get Providers','Able to get Providers','d05118c6-2490-4d78-a41a-390e3596a211'),('Get Relationship Types','Able to get relationship types','d05118c6-2490-4d78-a41a-390e3596a232'),('Get Relationships','Able to get relationships','d05118c6-2490-4d78-a41a-390e3596a223'),('Get Roles','Able to get user roles','d05118c6-2490-4d78-a41a-390e3596a235'),('Get Tags','Able to get the tags','99e374b8-bd4f-11e7-8025-08002715d519'),('Get Users','Able to get users in OpenMRS','d05118c6-2490-4d78-a41a-390e3596a249'),('Get Visit Attribute Types','Able to get visit attribute types','d05118c6-2490-4d78-a41a-390e3596a213'),('Get Visit Types','Able to get visit types','d05118c6-2490-4d78-a41a-390e3596a215'),('Get Visits','Able to get visits','d05118c6-2490-4d78-a41a-390e3596a214'),('Manage Address Hierarchy','Allows user to access/modify the defined address hierarchy','3ee9e2ce-50e3-4800-bb1b-fb06a175b817'),('Manage Address Templates','Able to add/edit/delete address templates','3304ed66-ac99-4625-b251-83736d98f235'),('Manage Alerts','Able to add/edit/delete user alerts','d0a1b87b-e42b-11e5-8c3e-08002715d519'),('Manage Appointment Services','Able to manage Services in Appointments module','9dd70466-bd4f-11e7-8025-08002715d519'),('Manage Appointments','Able to manage Appointments in Appointments module','9dd59df5-bd4f-11e7-8025-08002715d519'),('Manage Auto Generation Options','Allows user add, edit, and remove auto-generation options','49ef64ef-0063-4ba1-8eda-20e6da214b3b'),('Manage Cohort Definitions','Add/Edit/Remove Cohort Definitions','144b6fab-9809-431f-94a7-6ab4627b17f8'),('Manage Concept Attribute Types','Able to add/edit/retire concept attribute types','8b06efd5-1be4-4389-8e19-d185775d2258'),('Manage Concept Classes','Able to add/edit/retire concept classes','d0a1b8d2-e42b-11e5-8c3e-08002715d519'),('Manage Concept Datatypes','Able to add/edit/retire concept datatypes','d0a1b92a-e42b-11e5-8c3e-08002715d519'),('Manage Concept Map Types','Able to add/edit/retire concept map types','c4fbbaf3-7002-4b59-b327-b5a396c6e4a1'),('Manage Concept Name tags','Able to add/edit/delete concept name tags','198abd28-cd35-47a4-8975-9ba7dd36b93c'),('Manage Concept Reference Terms','Able to add/edit/retire reference terms','636b155d-ce3f-41f3-8d97-7617a56d7f52'),('Manage Concept Sources','Able to add/edit/delete concept sources','d0a1b982-e42b-11e5-8c3e-08002715d519'),('Manage Concept Stop Words','Able to view/add/remove the concept stop words','742e791b-d93e-4d6c-afb5-82f6b17c6a35'),('Manage Concepts','Able to add/edit/delete concept entries','d0a1b9dc-e42b-11e5-8c3e-08002715d519'),('Manage Data Set Definitions','Add/Edit/Remove Data Set Definitions','61983f5b-f9b3-4349-9f60-c12a8a56a516'),('Manage Dimension Definitions','Add/Edit/Remove Dimension Definitions','7e675b40-07f0-403e-9126-2a8a39683106'),('Manage Encounter Roles','Able to add/edit/retire encounter roles','17f047bf-832d-4ab0-8a06-908eb900a0be'),('Manage Encounter Types','Able to add/edit/delete encounter types','d0a1bab2-e42b-11e5-8c3e-08002715d519'),('Manage Field Types','Able to add/edit/retire field types','d0a1bb2c-e42b-11e5-8c3e-08002715d519'),('Manage FormEntry XSN','Allows user to upload and edit the xsns stored on the server','d0a1bb85-e42b-11e5-8c3e-08002715d519'),('Manage Forms','Able to add/edit/delete forms','d0a1bbdd-e42b-11e5-8c3e-08002715d519'),('Manage Global Properties','Able to add/edit global properties','d0a1bc35-e42b-11e5-8c3e-08002715d519'),('Manage HL7 Messages','Able to add/edit/delete HL7 messages','a253c485-851b-4ed1-9c93-882a0318af30'),('Manage Identifier Sequence','Allows user to update Identifier sequence','1dbb68ef-5f4f-4c5e-a5c7-587d39800e25'),('Manage Identifier Sources','Allows user add, edit, and remove identifier sources','f3a1ebba-e599-4185-91b6-7b6db5159ced'),('Manage Identifier Types','Able to add/edit/delete patient identifier types','d0a1bc8d-e42b-11e5-8c3e-08002715d519'),('Manage Implementation Id','Able to view/add/edit the implementation id for the system','0416f1a9-dc84-4b47-92f7-b4ded57c8034'),('Manage Indicator Definitions','Add/Edit/Remove Indicator Definitions','5c9f3eab-3718-4bd4-96ce-40457ab1003d'),('Manage Location Attribute Types','Able to add/edit/retire location attribute types','49c2087a-c358-447b-a4cf-33186f378242'),('Manage Location Tags','Able to add/edit/delete location tags','3cad7a3f-c07a-42be-9873-6af124c11258'),('Manage Locations','Able to add/edit/delete locations','d0a1bce5-e42b-11e5-8c3e-08002715d519'),('Manage Metadata Mapping','Able to manage metadata mappings','6c34d28e-c26b-42c8-8dee-34f8e871618e'),('Manage Modules','Able to add/remove modules to the system','d0a1bd3c-e42b-11e5-8c3e-08002715d519'),('Manage Order Frequencies','Able to add/edit/retire Order Frequencies','5a22e85e-3b80-4c7f-b3f4-e5c2176fa266'),('Manage Order Sets','Able to manage order sets','8ac94cc0-2d40-4385-8263-1d3ce8fbde0b'),('Manage Order Types','Able to add/edit/retire order types','d0a1bd94-e42b-11e5-8c3e-08002715d519'),('Manage Person Attribute Types','Able to add/edit/delete person attribute types','d0a1bdeb-e42b-11e5-8c3e-08002715d519'),('Manage Privileges','Able to add/edit/delete privileges','d0a1be45-e42b-11e5-8c3e-08002715d519'),('Manage Program Attribute Types','Access to enter,edit and view program attributes','806c7eac-e42f-11e5-8c3e-08002715d519'),('Manage Programs','Able to add/view/delete patient programs','d0a1be9e-e42b-11e5-8c3e-08002715d519'),('Manage Providers','Able to edit Provider','1f8ea5b5-16fa-49b6-a9c2-edd22db84910'),('Manage Relationship Types','Able to add/edit/retire relationship types','d0a1bef8-e42b-11e5-8c3e-08002715d519'),('Manage Relationships','Able to add/edit/delete relationships','d0a1bf51-e42b-11e5-8c3e-08002715d519'),('Manage Report Definitions','Add/Edit/Remove Report Definitions','c8aa9388-fe4a-4377-baba-fe5902649948'),('Manage Report Designs','Add/Edit/Remove Report Designs','e1333693-c408-4a6c-85f2-316b035d7d44'),('Manage Reports','Base privilege for add/edit/delete reporting definitions. This gives access to the administrative menus, but you need to grant additional privileges to manage each specific type of reporting definition','164eb1b0-5218-410f-8482-da0bdbb18ace'),('Manage RESTWS','Allows to configure RESTWS module','ac98e2f7-6953-47da-869f-160e64fecd6e'),('Manage Roles','Able to add/edit/delete user roles','d0a1bfa7-e42b-11e5-8c3e-08002715d519'),('Manage Scheduled Report Tasks','Manage Task Scheduling in Reporting Module','e4967693-5652-4127-b064-a82a4ba5ce02'),('Manage Scheduler','Able to add/edit/remove scheduled tasks','d0a1bfff-e42b-11e5-8c3e-08002715d519'),('Manage Search Index','Able to manage the search index','b3b58745-5c3f-4f7e-a620-db7a066f2962'),('Manage Token Registrations','Allows to create/update/delete token registrations','db9d8f46-2a68-4eaf-b9c6-7c72e3bda205'),('Manage Visit Attribute Types','Able to add/edit/retire visit attribute types','264b7306-475c-4639-a2be-b30914d3f184'),('Manage Visit Types','Able to add/edit/delete visit types','90c99a8b-8023-4ec5-b6a0-eff31e1c7ce4'),('Patient Dashboard - View Demographics Section','Able to view the \'Demographics\' tab on the patient dashboard','d0a1c057-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Encounters Section','Able to view the \'Encounters\' tab on the patient dashboard','d0a1c0b3-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Forms Section','Allows user to view the Forms tab on the patient dashboard','d0a1c10e-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Graphs Section','Able to view the \'Graphs\' tab on the patient dashboard','d0a1c16b-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Overview Section','Able to view the \'Overview\' tab on the patient dashboard','d0a1c21f-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Patient Summary','Able to view the \'Summary\' tab on the patient dashboard','d0a1c27a-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Regimen Section','Able to view the \'Regimen\' tab on the patient dashboard','d0a1c2d6-e42b-11e5-8c3e-08002715d519'),('Patient Dashboard - View Visits Section','Able to view the \'Visits\' tab on the patient dashboard','18a39135-e8e6-4a5d-8110-6e18b8981908'),('Patient Overview - View Allergies','Able to view the Allergies portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a261'),('Patient Overview - View Patient Actions','Able to view the Patient Actions portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a264'),('Patient Overview - View Patient Flags','Able to view the \'Patient Flags\' portlet on the patient dashboard\'s overview tab','1d6d0530-20d7-4291-9793-3e6f5f54fed3'),('Patient Overview - View Problem List','Able to view the Problem List portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a260'),('Patient Overview - View Programs','Able to view the Programs portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a263'),('Patient Overview - View Relationships','Able to view the Relationships portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a262'),('Provider Management - Admin','Allows access to admin pages of the provider management module','104970fa-4a75-4c38-a7d0-ce8f162cf23a'),('Provider Management API','Allows access to all provider management service and provider suggestion service API method','79208798-279e-43cb-b152-323580e9f331'),('Provider Management API - Read-only','Allows access to all provider management service and provider suggestion service API methods that are read-only','65e9f3d1-30c8-45d5-9748-3291ad092111'),('Provider Management Dashboard - Edit Patients','Allows access to editing patient information on the provider management dashboard','eb4aae87-b169-4bfd-9075-f975c187fe8d'),('Provider Management Dashboard - Edit Providers','Allows access to editing provider information on the provider management dashboard','6ab37dac-e134-4523-aa63-d3a8e6628f84'),('Provider Management Dashboard - View Historical','Allows access to viewing historical patient (if user has view patients right) and supervisee information on the provider management dashboard','5ef5e46c-cd73-4913-97de-f1ca91c53a3f'),('Provider Management Dashboard - View Patients','Allows access to viewing patient information on the provider management dashboard','ae35845a-f261-4be5-8983-a61344fa3fe7'),('Provider Management Dashboard - View Providers','Allows access to viewing provider information on the provider management dashboard','945dd424-c8a2-4188-82f1-207ac9df5c33'),('Purge Field Types','Able to purge field types','d0a1c335-e42b-11e5-8c3e-08002715d519'),('Purge Program Attribute Types','Access to purge program attribute types','806ff3b3-e42f-11e5-8c3e-08002715d519'),('Remove Allergies','Remove allergies','0bcfd0ac-3e22-45c1-bf29-dff721a59606'),('Remove Problems','Remove problems','8d8e52c8-b88d-4300-a5d5-3e82d734e6c5'),('Run Reports','Schedule the running of a report','8bc172fe-f53c-4371-a58a-e87522ae7f71'),('Share Metadata','Allows user to export and import metadata','ee53ac2c-2c3e-4e1a-ab55-26da99e9b392'),('Task: Modify Allergies','Able to add, edit, delete allergies','271054b6-1c14-49a3-9b40-785cdfef5c90'),('Update HL7 Inbound Archive','Able to update an HL7 archive item','8d3108bb-f793-459b-8137-d2bc5a371698'),('Update HL7 Inbound Exception','Able to update an HL7 archive item','6f5fe196-2a88-4af0-82ee-163ff9961250'),('Update HL7 Inbound Queue','Able to update an HL7 Queue item','7fbdf3fd-9db0-4630-b5df-d542dd7a4a34'),('Update HL7 Source','Able to update an HL7 Source','98a1bdad-9e96-41e0-a207-fd7764f698e5'),('Upload Batch of Identifiers','Allows user to upload a batch of identifiers','d9318c50-0193-4428-9e7d-5178c270bac1'),('Upload XSN','Allows user to upload/overwrite the XSNs defined for forms','d0a1c38b-e42b-11e5-8c3e-08002715d519'),('View Administration Functions','Able to view the \'Administration\' link in the navigation bar','d0a1c48b-e42b-11e5-8c3e-08002715d519'),('View Allergies','Able to view allergies in OpenMRS','d0a1c509-e42b-11e5-8c3e-08002715d519'),('View Appointment Services','Able to view Services in Appointments module','9dd65702-bd4f-11e7-8025-08002715d519'),('View Appointments','Able to view Appointments in Appointments module','9dd42c87-bd4f-11e7-8025-08002715d519'),('View Calculations','Allows to view Calculations','a9679b55-7030-40c0-979f-067d03712637'),('View Concept Classes','Able to view concept classes','d0a1c632-e42b-11e5-8c3e-08002715d519'),('View Concept Datatypes','Able to view concept datatypes','d0a1c68e-e42b-11e5-8c3e-08002715d519'),('View Concept Proposals','Able to view concept proposals to the system','d0a1c6e8-e42b-11e5-8c3e-08002715d519'),('View Concept Sources','Able to view concept sources','d0a1c73f-e42b-11e5-8c3e-08002715d519'),('View Concepts','Able to view concept entries','d0a1c794-e42b-11e5-8c3e-08002715d519'),('View Data Entry Statistics','Able to view data entry statistics from the admin screen','d0a1c7eb-e42b-11e5-8c3e-08002715d519'),('View Drug Groups','Ability to view Drug Groups','bb83199d-e974-4160-bcd7-7e1566a4c5a1'),('View Drug Info','Ability to view Drug Info','bd3d64b6-1c16-46aa-9b51-95c8fb867091'),('View Encounter Types','Able to view encounter types','d0a1c843-e42b-11e5-8c3e-08002715d519'),('View Encounters','Able to view patient encounters','d0a1c899-e42b-11e5-8c3e-08002715d519'),('View Field Types','Able to view field types','d0a1c8ee-e42b-11e5-8c3e-08002715d519'),('View Forms','Able to view forms','d0a1c944-e42b-11e5-8c3e-08002715d519'),('View Global Properties','Able to view global properties on the administration screen','d0a1c99b-e42b-11e5-8c3e-08002715d519'),('View Identifier Types','Able to view patient identifier types','d0a1c9f2-e42b-11e5-8c3e-08002715d519'),('View Locations','Able to view locations','d0a1ca49-e42b-11e5-8c3e-08002715d519'),('View Metadata Via Mapping','Able to view metadata via a mapping','95516cca-ef96-4f17-9a35-dd03c90936aa'),('View Navigation Menu','Ability to see the navigation menu','d0a1ca9e-e42b-11e5-8c3e-08002715d519'),('View Observations','Able to view patient observations','d0a1caf4-e42b-11e5-8c3e-08002715d519'),('View Order Types','Able to view order types','d0a1cb4a-e42b-11e5-8c3e-08002715d519'),('View Orders','Able to view orders','d0a1cba0-e42b-11e5-8c3e-08002715d519'),('View Patient Cohorts','Able to view patient cohorts','d0a1cbf6-e42b-11e5-8c3e-08002715d519'),('View Patient Identifiers','Able to view patient identifiers','d0a1cc4d-e42b-11e5-8c3e-08002715d519'),('View Patient Lists','Ability to view patient lists','0f8939a7-2a1c-49fb-83fb-d9462d9a87ed'),('View Patient Programs','Able to see which programs that patients are in','d0a1cca5-e42b-11e5-8c3e-08002715d519'),('View Patients','Able to view patients','d0a1ccfc-e42b-11e5-8c3e-08002715d519'),('View People','Able to view person objects','d0a1cd52-e42b-11e5-8c3e-08002715d519'),('View Person Attribute Types','Able to view person attribute types','d0a1cda7-e42b-11e5-8c3e-08002715d519'),('View Privileges','Able to view user privileges','d0a1cdfe-e42b-11e5-8c3e-08002715d519'),('View Problems','Able to view problems in OpenMRS','d0a1ce53-e42b-11e5-8c3e-08002715d519'),('View Program Attribute Types','Access to only view program attributes','806d8e99-e42f-11e5-8c3e-08002715d519'),('View Programs','Able to view patient programs','d0a1cead-e42b-11e5-8c3e-08002715d519'),('View Providers','Able to view Provider','7f3ad1d0-e42f-11e5-8c3e-08002715d519'),('View Relationship Types','Able to view relationship types','d0a1cf04-e42b-11e5-8c3e-08002715d519'),('View Relationships','Able to view relationships','d0a1cf5a-e42b-11e5-8c3e-08002715d519'),('View Report Objects','Able to view report objects','d0a1cfb0-e42b-11e5-8c3e-08002715d519'),('View Reports','Able to view reports','d0a1d005-e42b-11e5-8c3e-08002715d519'),('View RESTWS','Gives access to RESTWS in administration','c8200b3b-fde5-4651-b8f4-dda8bca6376e'),('View Roles','Able to view user roles','d0a1d05b-e42b-11e5-8c3e-08002715d519'),('View Token Registrations','Allows to view token registrations','2d3f9a9d-3a32-4f6e-b8ac-bf2b8382ccf0'),('View Unpublished Forms','Able to view and fill out unpublished forms','d0a1d0b1-e42b-11e5-8c3e-08002715d519'),('View Users','Able to view users in OpenMRS','d0a1d10b-e42b-11e5-8c3e-08002715d519'),('View Visit Attribute Types','Able to view Visit Attribute Types','7f3ef0ff-e42f-11e5-8c3e-08002715d519'),('View Visit Types','Able to view Visit Types','7f3c5c43-e42f-11e5-8c3e-08002715d519'),('View Visits','Able to view Visits','7f3d9ad4-e42f-11e5-8c3e-08002715d519');
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `outcomes_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `description` text,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `program_uuid_index` (`uuid`),
  KEY `user_who_changed_program` (`changed_by`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  KEY `program_outcomes_concept_id_fk` (`outcomes_concept_id`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_outcomes_concept_id_fk` FOREIGN KEY (`outcomes_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `user_who_changed_program` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_attribute_type`
--

DROP TABLE IF EXISTS `program_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_attribute_type` (
  `program_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` smallint(6) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `name` (`name`),
  KEY `program_attribute_type_creator_fk` (`creator`),
  KEY `program_attribute_type_changed_by_fk` (`changed_by`),
  KEY `program_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `program_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `program_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_attribute_type`
--

LOCK TABLES `program_attribute_type` WRITE;
/*!40000 ALTER TABLE `program_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `program_workflow_uuid_index` (`uuid`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  KEY `program_for_workflow` (`program_id`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  CONSTRAINT `workflow_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `workflow_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow`
--

LOCK TABLES `program_workflow` WRITE;
/*!40000 ALTER TABLE `program_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT '0',
  `concept_id` int(11) NOT NULL DEFAULT '0',
  `initial` tinyint(1) NOT NULL DEFAULT '0',
  `terminal` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `program_workflow_state_uuid_index` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`),
  CONSTRAINT `state_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `state_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `workflow_for_state` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow_state`
--

LOCK TABLES `program_workflow_state` WRITE;
/*!40000 ALTER TABLE `program_workflow_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `provider_role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_changed_by_fk` (`changed_by`),
  KEY `provider_person_id_fk` (`person_id`),
  KEY `provider_retired_by_fk` (`retired_by`),
  KEY `provider_creator_fk` (`creator`),
  KEY `provider_role_id` (`provider_role_id`),
  CONSTRAINT `provider_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_ibfk_1` FOREIGN KEY (`provider_role_id`) REFERENCES `providermanagement_provider_role` (`provider_role_id`),
  CONSTRAINT `provider_person_id_fk` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `provider_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES (1,2,NULL,'UNKNOWN',2,'2016-03-07 12:00:09',NULL,NULL,0,NULL,NULL,NULL,'f9badd80-ab76-11e2-9e96-0800200c9a66',NULL),(2,3,'Lab Manager','LABMANAGER',1,'2016-03-07 12:10:34',NULL,NULL,0,NULL,NULL,NULL,'7e76ef9d-e42f-11e5-8c3e-08002715d519',NULL),(3,5,'Lab System','LABSYSTEM',1,'2016-03-07 12:20:56',NULL,NULL,0,NULL,NULL,NULL,'f16512f2-e430-11e5-8c3e-08002715d519',NULL),(4,6,NULL,'SUPERMAN',1,'2017-04-04 16:10:15',NULL,NULL,0,NULL,NULL,NULL,'16b79349-1923-11e7-bbfc-9206fc7c228b',NULL);
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute`
--

DROP TABLE IF EXISTS `provider_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute` (
  `provider_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_provider_fk` (`provider_id`),
  KEY `provider_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `provider_attribute_creator_fk` (`creator`),
  KEY `provider_attribute_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `provider_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`),
  CONSTRAINT `provider_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_provider_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  CONSTRAINT `provider_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute`
--

LOCK TABLES `provider_attribute` WRITE;
/*!40000 ALTER TABLE `provider_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute_type`
--

DROP TABLE IF EXISTS `provider_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute_type` (
  `provider_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_type_creator_fk` (`creator`),
  KEY `provider_attribute_type_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `provider_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `provider_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute_type`
--

LOCK TABLES `provider_attribute_type` WRITE;
/*!40000 ALTER TABLE `provider_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providermanagement_provider_role`
--

DROP TABLE IF EXISTS `providermanagement_provider_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providermanagement_provider_role` (
  `provider_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providermanagement_provider_role`
--

LOCK TABLES `providermanagement_provider_role` WRITE;
/*!40000 ALTER TABLE `providermanagement_provider_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `providermanagement_provider_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providermanagement_provider_role_provider_attribute_type`
--

DROP TABLE IF EXISTS `providermanagement_provider_role_provider_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providermanagement_provider_role_provider_attribute_type` (
  `provider_role_id` int(11) NOT NULL,
  `provider_attribute_type_id` int(11) NOT NULL,
  KEY `provider_role_id` (`provider_role_id`),
  KEY `provider_attribute_type_id` (`provider_attribute_type_id`),
  CONSTRAINT `providermanagement_prpat_provider_attribute_type_fk` FOREIGN KEY (`provider_attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`),
  CONSTRAINT `providermanagement_prpat_provider_role_fk` FOREIGN KEY (`provider_role_id`) REFERENCES `providermanagement_provider_role` (`provider_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providermanagement_provider_role_provider_attribute_type`
--

LOCK TABLES `providermanagement_provider_role_provider_attribute_type` WRITE;
/*!40000 ALTER TABLE `providermanagement_provider_role_provider_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `providermanagement_provider_role_provider_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providermanagement_provider_role_relationship_type`
--

DROP TABLE IF EXISTS `providermanagement_provider_role_relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providermanagement_provider_role_relationship_type` (
  `provider_role_id` int(11) NOT NULL,
  `relationship_type_id` int(11) NOT NULL,
  KEY `provider_role_id` (`provider_role_id`),
  KEY `relationship_type_id` (`relationship_type_id`),
  CONSTRAINT `providermanagement_provider_role_relationship_type_ibfk_1` FOREIGN KEY (`provider_role_id`) REFERENCES `providermanagement_provider_role` (`provider_role_id`),
  CONSTRAINT `providermanagement_provider_role_relationship_type_ibfk_2` FOREIGN KEY (`relationship_type_id`) REFERENCES `relationship_type` (`relationship_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providermanagement_provider_role_relationship_type`
--

LOCK TABLES `providermanagement_provider_role_relationship_type` WRITE;
/*!40000 ALTER TABLE `providermanagement_provider_role_relationship_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `providermanagement_provider_role_relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providermanagement_provider_role_supervisee_provider_role`
--

DROP TABLE IF EXISTS `providermanagement_provider_role_supervisee_provider_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providermanagement_provider_role_supervisee_provider_role` (
  `provider_role_id` int(11) NOT NULL,
  `supervisee_provider_role_id` int(11) NOT NULL,
  KEY `provider_role_id` (`provider_role_id`),
  KEY `supervisee_provider_role_id` (`supervisee_provider_role_id`),
  CONSTRAINT `providermanagement_prspr_provider_role_fk` FOREIGN KEY (`provider_role_id`) REFERENCES `providermanagement_provider_role` (`provider_role_id`),
  CONSTRAINT `providermanagement_prspr_supervisee_role_fk` FOREIGN KEY (`supervisee_provider_role_id`) REFERENCES `providermanagement_provider_role` (`provider_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providermanagement_provider_role_supervisee_provider_role`
--

LOCK TABLES `providermanagement_provider_role_supervisee_provider_role` WRITE;
/*!40000 ALTER TABLE `providermanagement_provider_role_supervisee_provider_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `providermanagement_provider_role_supervisee_provider_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providermanagement_provider_suggestion`
--

DROP TABLE IF EXISTS `providermanagement_provider_suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providermanagement_provider_suggestion` (
  `provider_suggestion_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria` varchar(5000) NOT NULL,
  `evaluator` varchar(255) NOT NULL,
  `relationship_type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_suggestion_id`),
  KEY `relationship_type_id` (`relationship_type_id`),
  CONSTRAINT `providermanagement_provider_suggestion_ibfk_1` FOREIGN KEY (`relationship_type_id`) REFERENCES `relationship_type` (`relationship_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providermanagement_provider_suggestion`
--

LOCK TABLES `providermanagement_provider_suggestion` WRITE;
/*!40000 ALTER TABLE `providermanagement_provider_suggestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `providermanagement_provider_suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providermanagement_supervision_suggestion`
--

DROP TABLE IF EXISTS `providermanagement_supervision_suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providermanagement_supervision_suggestion` (
  `supervision_suggestion_id` int(11) NOT NULL AUTO_INCREMENT,
  `criteria` varchar(5000) NOT NULL,
  `evaluator` varchar(255) NOT NULL,
  `provider_role_id` int(11) NOT NULL,
  `suggestion_type` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`supervision_suggestion_id`),
  KEY `provider_role_id` (`provider_role_id`),
  CONSTRAINT `providermanagement_supervision_suggestion_ibfk_1` FOREIGN KEY (`provider_role_id`) REFERENCES `providermanagement_provider_role` (`provider_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providermanagement_supervision_suggestion`
--

LOCK TABLES `providermanagement_supervision_suggestion` WRITE;
/*!40000 ALTER TABLE `providermanagement_supervision_suggestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `providermanagement_supervision_suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT '0',
  `person_b` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `relationship_uuid_index` (`uuid`),
  KEY `relation_creator` (`creator`),
  KEY `person_a_is_person` (`person_a`),
  KEY `person_b_is_person` (`person_b`),
  KEY `relationship_type_id` (`relationship`),
  KEY `relation_voider` (`voided_by`),
  KEY `relationship_changed_by` (`changed_by`),
  CONSTRAINT `person_a_is_person` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`),
  CONSTRAINT `person_b_is_person` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`),
  CONSTRAINT `relation_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relation_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relationship_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `relationship_type_id` FOREIGN KEY (`relationship`) REFERENCES `relationship_type` (`relationship_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) NOT NULL,
  `b_is_to_a` varchar(50) NOT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `relationship_type_uuid_index` (`uuid`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`),
  KEY `relationship_type_changed_by` (`changed_by`),
  CONSTRAINT `relationship_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_created_rel` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_relationship_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` VALUES (1,'Supervisor','Supervisee',0,0,'Provider supervisor to provider supervisee relationship',1,'2017-04-04 15:47:03',0,NULL,NULL,NULL,'2a5f4ff4-a179-4b8a-aa4c-40f71956ebbc',NULL,NULL);
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_object_type` varchar(255) NOT NULL,
  `report_object_sub_type` varchar(255) NOT NULL,
  `xml_data` text,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `report_object_uuid_index` (`uuid`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_object`
--

LOCK TABLES `report_object` WRITE;
/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `xml_data` text NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `report_schema_xml_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_schema_xml`
--

LOCK TABLES `report_schema_xml` WRITE;
/*!40000 ALTER TABLE `report_schema_xml` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_schema_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporting_age_group`
--

DROP TABLE IF EXISTS `reporting_age_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporting_age_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `report_group_name` varchar(255) NOT NULL,
  `min_years` int(11) NOT NULL DEFAULT '0',
  `min_days` int(11) NOT NULL DEFAULT '0',
  `max_years` int(11) NOT NULL DEFAULT '0',
  `max_days` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting_age_group`
--

LOCK TABLES `reporting_age_group` WRITE;
/*!40000 ALTER TABLE `reporting_age_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_age_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporting_report_design`
--

DROP TABLE IF EXISTS `reporting_report_design`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporting_report_design` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `renderer_type` varchar(255) NOT NULL,
  `properties` text,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `report_definition_uuid` char(38) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `creator for reporting_report_design` (`creator`),
  KEY `changed_by for reporting_report_design` (`changed_by`),
  KEY `retired_by for reporting_report_design` (`retired_by`),
  KEY `report_definition_uuid_for_reporting_report_design` (`report_definition_uuid`),
  CONSTRAINT `changed_by_for_reporting_report_design` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_reporting_report_design` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `retired_by_for_reporting_report_design` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting_report_design`
--

LOCK TABLES `reporting_report_design` WRITE;
/*!40000 ALTER TABLE `reporting_report_design` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_design` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporting_report_design_resource`
--

DROP TABLE IF EXISTS `reporting_report_design_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporting_report_design_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_design_id` int(11) NOT NULL DEFAULT '0',
  `content_type` varchar(50) DEFAULT NULL,
  `extension` varchar(20) DEFAULT NULL,
  `contents` longblob,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `report_design_id for reporting_report_design_resource` (`report_design_id`),
  KEY `creator for reporting_report_design_resource` (`creator`),
  KEY `changed_by for reporting_report_design_resource` (`changed_by`),
  KEY `retired_by for reporting_report_design_resource` (`retired_by`),
  CONSTRAINT `changed_by_for_reporting_report_design_resource` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_reporting_report_design_resource` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `report_design_id_for_reporting_report_design_resource` FOREIGN KEY (`report_design_id`) REFERENCES `reporting_report_design` (`id`),
  CONSTRAINT `retired_by_for_reporting_report_design_resource` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting_report_design_resource`
--

LOCK TABLES `reporting_report_design_resource` WRITE;
/*!40000 ALTER TABLE `reporting_report_design_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_design_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporting_report_processor`
--

DROP TABLE IF EXISTS `reporting_report_processor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporting_report_processor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `processor_type` varchar(255) NOT NULL,
  `configuration` mediumtext,
  `run_on_success` tinyint(1) NOT NULL DEFAULT '1',
  `run_on_error` tinyint(1) NOT NULL DEFAULT '0',
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `report_design_id` int(11) DEFAULT NULL,
  `processor_mode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `creator for reporting_report_processor` (`creator`),
  KEY `changed_by for reporting_report_processor` (`changed_by`),
  KEY `retired_by for reporting_report_processor` (`retired_by`),
  KEY `reporting_report_processor_report_design` (`report_design_id`),
  CONSTRAINT `changed_by_for_reporting_report_processor` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `creator_for_reporting_report_processor` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `reporting_report_processor_report_design` FOREIGN KEY (`report_design_id`) REFERENCES `reporting_report_design` (`id`),
  CONSTRAINT `retired_by_for_reporting_report_processor` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting_report_processor`
--

LOCK TABLES `reporting_report_processor` WRITE;
/*!40000 ALTER TABLE `reporting_report_processor` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_processor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporting_report_request`
--

DROP TABLE IF EXISTS `reporting_report_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporting_report_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `base_cohort_uuid` char(38) DEFAULT NULL,
  `base_cohort_parameters` text,
  `report_definition_uuid` char(38) NOT NULL,
  `report_definition_parameters` text,
  `renderer_type` varchar(255) NOT NULL,
  `renderer_argument` varchar(255) DEFAULT NULL,
  `requested_by` int(11) NOT NULL DEFAULT '0',
  `request_datetime` datetime NOT NULL,
  `priority` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `evaluation_start_datetime` datetime DEFAULT NULL,
  `evaluation_complete_datetime` datetime DEFAULT NULL,
  `render_complete_datetime` datetime DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `schedule` varchar(100) DEFAULT NULL,
  `process_automatically` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_days_to_preserve` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `requested_by for reporting_report_request` (`requested_by`),
  CONSTRAINT `requested_by_for_reporting_report_request` FOREIGN KEY (`requested_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporting_report_request`
--

LOCK TABLES `reporting_report_request` WRITE;
/*!40000 ALTER TABLE `reporting_report_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporting_report_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `role_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('Admin-App','Will have full access for Admin app','dfa01436-191f-11e7-bbfc-9206fc7c228b'),('Anonymous','Privileges for non-authenticated users.','774b2af3-6437-4e5a-a310-547554c7c65c'),('Appointments:FullAccess','Ability to manage appointments and services in appointments module','9c9e4dc8-bd4f-11e7-8025-08002715d519'),('Appointments:ManageAppointments','Ability to manage appointments in appointments module','9ca0d1b8-bd4f-11e7-8025-08002715d519'),('Appointments:ReadOnly','Ability to view appointments in appointments module','9c9fb532-bd4f-11e7-8025-08002715d519'),('Authenticated','Privileges gained once authentication has been established.','f7fd42ef-880e-40c5-972d-e4ae7c990de2'),('Bahmni-App','Will have full access to Bahmni','dfa75fa8-191f-11e7-bbfc-9206fc7c228b'),('Bahmni-App-User-Login','Will give ability to login to the application and used internally, should not be assigned to user directly.','df980dd5-191f-11e7-bbfc-9206fc7c228b'),('bahmni-document-uploader','bahmni-document-uploader','16b9ff7c-1923-11e7-bbfc-9206fc7c228b'),('bypass2FA','Role if assigned disables two factor authentication for that user and used internally, should not be assigned to user directly.','8001c171-e42f-e1ec-8d3e-08002715d521'),('Clinical-App','Will have full access to Clinical app','dfa7071a-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Bacteriology','Will have full access for Bacteriology tab in Clinical app','dfa6cb38-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Common','Will have common privileges used by other Clinical roles and used internally, should not be assigned to user directly.','dfa2a01a-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Diagnosis','Will have full access for Diagnosis tab in Clinical app','dfa59b8d-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Disposition','Will have full access for Disposition tab in Clinical app','dfa5dacc-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Observations','Will have full access for Observations tab in Clinical app','dfa6181c-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Orders','Will have full access for Orders tab in Clinical app','dfa69004-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Read-Only','Will have read only access to Clinical app','dfa48cbe-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Save','Will have save privileges used by other Clinical roles and used internally, should not be assigned to user directly.','dfa51deb-191f-11e7-bbfc-9206fc7c228b'),('Clinical-App-Treatment','Will have full access for Treatment tab in Clinical app','dfa65466-191f-11e7-bbfc-9206fc7c228b'),('Doctor','Role for the doctor','16ba265d-1923-11e7-bbfc-9206fc7c228b'),('HubConnect','Will have privileges required to sync resources from parent Bahmni server to child Bahmni server','9c078f6e-bd4f-11e7-8025-08002715d519'),('Implementer-Interface-App','Will have full access to Implementer Interface app','dfa734cf-191f-11e7-bbfc-9206fc7c228b'),('InPatient-App','Will have full access for InPatient app','dfa1cc37-191f-11e7-bbfc-9206fc7c228b'),('InPatient-App-Read-Only','Will have read only access for InPatient app','df9f7512-191f-11e7-bbfc-9206fc7c228b'),('Nurse','Role for the nurse','16ba4da2-1923-11e7-bbfc-9206fc7c228b'),('OrderFulfillment-App','Will have full access for OrdersFulfillment app','df9d4477-191f-11e7-bbfc-9206fc7c228b'),('PatientDocuments-App','Will have full access for Patient Documents app','df9e1e9a-191f-11e7-bbfc-9206fc7c228b'),('Privilege Level: Full','A role that has all API privileges','ab2160f6-0941-430c-9752-6714353fbd3c'),('Programs-App','Will have full access for Programs app','df9ac0a3-191f-11e7-bbfc-9206fc7c228b'),('Provider','All users with the \'Provider\' role will appear as options in the default Infopath','8d94f280-c2cc-11de-8d13-0010c6dffd0f'),('Radiology-App','Will have full access for Radiology app','df9ec8fd-191f-11e7-bbfc-9206fc7c228b'),('Registration-App','Will have full access for Registration app','df99ee7e-191f-11e7-bbfc-9206fc7c228b'),('Registration-App-Read-Only','Will have read only access for Registration app','df984364-191f-11e7-bbfc-9206fc7c228b'),('RegistrationClerk','RegistrationClerk','16ba73c3-1923-11e7-bbfc-9206fc7c228b'),('Reports-App','Will have full access for Reports app','df9cfa3a-191f-11e7-bbfc-9206fc7c228b'),('SuperAdmin','Will give full acess to Bahmni and OpenMRS','dfa81448-191f-11e7-bbfc-9206fc7c228b'),('System Developer','Developers of the OpenMRS .. have additional access to change fundamental structure of the database model.','8d94f852-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_privilege` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `privilege` varchar(255) NOT NULL,
  PRIMARY KEY (`privilege`,`role`),
  KEY `role_privilege_to_role` (`role`),
  CONSTRAINT `privilege_definitions` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`),
  CONSTRAINT `role_privilege_to_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES ('Admin-App','Add Encounters'),('Admin-App','Add Observations'),('Admin-App','Add Orders'),('Admin-App','Add Patient Programs'),('Admin-App','Add Patients'),('Admin-App','Add Relationships'),('Admin-App','Add Visits'),('Admin-App','app:admin'),('Admin-App','Edit Encounters'),('Admin-App','Edit Observations'),('Admin-App','Edit Orders'),('Admin-App','Edit Patient Programs'),('Admin-App','Edit Patients'),('Admin-App','Edit Relationships'),('Admin-App','Edit Visits'),('Admin-App','Get Care Settings'),('Admin-App','Get Concept Reference Terms'),('Admin-App','Get Concept Sources'),('Admin-App','Get Concepts'),('Admin-App','Get Encounter Roles'),('Admin-App','Get Encounters'),('Admin-App','Get Observations'),('Admin-App','Get Order Frequencies'),('Admin-App','Get Order Sets'),('Admin-App','Get Patient Programs'),('Admin-App','Get Patients'),('Admin-App','Get Programs'),('Admin-App','Get Visit Attribute Types'),('Admin-App','Get Visit Types'),('Admin-App','Get Visits'),('Admin-App','Manage Concept Reference Terms'),('Admin-App','Manage Concepts'),('Admin-App','Manage Order Sets'),('Anonymous','Get Locations'),('Anonymous','View Locations'),('Appointments:FullAccess','app:appointments'),('Appointments:FullAccess','app:appointments:adminTab'),('Appointments:FullAccess','app:appointments:manageAppointmentsTab'),('Appointments:FullAccess','Manage Appointment Services'),('Appointments:FullAccess','Manage Appointments'),('Appointments:FullAccess','View Appointment Services'),('Appointments:FullAccess','View Appointments'),('Appointments:ManageAppointments','app:appointments'),('Appointments:ManageAppointments','app:appointments:manageAppointmentsTab'),('Appointments:ManageAppointments','Manage Appointments'),('Appointments:ManageAppointments','View Appointment Services'),('Appointments:ManageAppointments','View Appointments'),('Appointments:ReadOnly','app:appointments'),('Appointments:ReadOnly','View Appointment Services'),('Appointments:ReadOnly','View Appointments'),('Authenticated','Get Concept Classes'),('Authenticated','Get Concept Datatypes'),('Authenticated','Get Encounter Types'),('Authenticated','Get Field Types'),('Authenticated','Get Global Properties'),('Authenticated','Get Identifier Types'),('Authenticated','Get Locations'),('Authenticated','Get Order Types'),('Authenticated','Get Person Attribute Types'),('Authenticated','Get Privileges'),('Authenticated','Get Relationship Types'),('Authenticated','Get Relationships'),('Authenticated','Get Roles'),('Authenticated','Patient Overview - View Relationships'),('Authenticated','View Concept Classes'),('Authenticated','View Concept Datatypes'),('Authenticated','View Encounter Types'),('Authenticated','View Field Types'),('Authenticated','View Global Properties'),('Authenticated','View Identifier Types'),('Authenticated','View Locations'),('Authenticated','View Order Types'),('Authenticated','View Person Attribute Types'),('Authenticated','View Privileges'),('Authenticated','View Relationship Types'),('Authenticated','View Relationships'),('Authenticated','View Roles'),('Bahmni-App-User-Login','Edit Users'),('Bahmni-App-User-Login','Get Providers'),('Bahmni-App-User-Login','Get Users'),('Clinical-App','app:clinical:deleteDiagnosis'),('Clinical-App-Bacteriology','app:clinical:bacteriologyTab'),('Clinical-App-Common','app:clinical'),('Clinical-App-Common','app:clinical:history'),('Clinical-App-Common','app:clinical:locationpicker'),('Clinical-App-Common','app:clinical:onbehalf'),('Clinical-App-Common','app:clinical:retrospective'),('Clinical-App-Common','Get Admission Locations'),('Clinical-App-Common','Get Beds'),('Clinical-App-Common','Get Care Settings'),('Clinical-App-Common','Get Concept Sources'),('Clinical-App-Common','Get Concepts'),('Clinical-App-Common','Get Encounters'),('Clinical-App-Common','Get Observations'),('Clinical-App-Common','Get Order Frequencies'),('Clinical-App-Common','Get Order Sets'),('Clinical-App-Common','Get Order Types'),('Clinical-App-Common','Get Orders'),('Clinical-App-Common','Get Patient Programs'),('Clinical-App-Common','Get Patients'),('Clinical-App-Common','Get People'),('Clinical-App-Common','Get Privileges'),('Clinical-App-Common','Get Visit Types'),('Clinical-App-Common','Get Visits'),('Clinical-App-Common','View Concepts'),('Clinical-App-Common','View Encounters'),('Clinical-App-Common','View Observations'),('Clinical-App-Common','View Order Types'),('Clinical-App-Common','View Orders'),('Clinical-App-Common','View Patient Programs'),('Clinical-App-Common','View Patients'),('Clinical-App-Common','View Program Attribute Types'),('Clinical-App-Common','View Providers'),('Clinical-App-Common','View Users'),('Clinical-App-Common','View Visit Types'),('Clinical-App-Common','View Visits'),('Clinical-App-Diagnosis','app:clinical:diagnosisTab'),('Clinical-App-Disposition','app:clinical:dispositionTab'),('Clinical-App-Observations','app:clinical:observationTab'),('Clinical-App-Orders','app:clinical:ordersTab'),('Clinical-App-Read-Only','app:clinical:bacteriologyTab'),('Clinical-App-Read-Only','app:clinical:consultationTab'),('Clinical-App-Read-Only','app:clinical:diagnosisTab'),('Clinical-App-Read-Only','app:clinical:dispositionTab'),('Clinical-App-Read-Only','app:clinical:history'),('Clinical-App-Read-Only','app:clinical:observationTab'),('Clinical-App-Read-Only','app:clinical:ordersTab'),('Clinical-App-Read-Only','app:clinical:treatmentTab'),('Clinical-App-Read-Only','Get conditions'),('Clinical-App-Read-Only','Get Forms'),('Clinical-App-Save','Add Encounters'),('Clinical-App-Save','Add Observations'),('Clinical-App-Save','Add Orders'),('Clinical-App-Save','Add Visits'),('Clinical-App-Save','Edit conditions'),('Clinical-App-Save','Edit Encounters'),('Clinical-App-Save','Edit Observations'),('Clinical-App-Save','Edit Orders'),('Clinical-App-Save','Edit Visits'),('Clinical-App-Save','Get Encounter Roles'),('Clinical-App-Save','Get Observations'),('Clinical-App-Save','Get Visit Attribute Types'),('Clinical-App-Treatment','app:clinical:treatmentTab'),('HubConnect','Get Location Attribute Types'),('HubConnect','Get Locations'),('Implementer-Interface-App','app:implementer-interface'),('InPatient-App','Add Encounters'),('InPatient-App','Add Observations'),('InPatient-App','Add Visits'),('InPatient-App','Assign Beds'),('InPatient-App','Edit Admission Locations'),('InPatient-App','Edit Encounters'),('InPatient-App','Edit Observations'),('InPatient-App','Edit Visits'),('InPatient-App','Get Encounter Roles'),('InPatient-App','Get Encounters'),('InPatient-App','Get Observations'),('InPatient-App','Get Patients'),('InPatient-App','Get People'),('InPatient-App','Get Visit Attribute Types'),('InPatient-App','Get Visits'),('InPatient-App-Read-Only','app:adt'),('InPatient-App-Read-Only','Get Admission Locations'),('InPatient-App-Read-Only','Get Beds'),('InPatient-App-Read-Only','Get Concept Sources'),('InPatient-App-Read-Only','Get Concepts'),('InPatient-App-Read-Only','Get Observations'),('InPatient-App-Read-Only','Get Patients'),('InPatient-App-Read-Only','Get People'),('InPatient-App-Read-Only','Get Visit Types'),('InPatient-App-Read-Only','Get Visits'),('OrderFulfillment-App','Add Encounters'),('OrderFulfillment-App','Add Observations'),('OrderFulfillment-App','Add Visits'),('OrderFulfillment-App','app:orders'),('OrderFulfillment-App','Edit Encounters'),('OrderFulfillment-App','Edit Observations'),('OrderFulfillment-App','Edit Visits'),('OrderFulfillment-App','Get Concept Sources'),('OrderFulfillment-App','Get Concepts'),('OrderFulfillment-App','Get Encounter Roles'),('OrderFulfillment-App','Get Encounters'),('OrderFulfillment-App','Get Observations'),('OrderFulfillment-App','Get Orders'),('OrderFulfillment-App','Get Patients'),('OrderFulfillment-App','Get Visit Attribute Types'),('OrderFulfillment-App','Get Visit Types'),('OrderFulfillment-App','Get Visits'),('PatientDocuments-App','Add Encounters'),('PatientDocuments-App','Add Observations'),('PatientDocuments-App','Add Visits'),('PatientDocuments-App','app:patient-documents'),('PatientDocuments-App','Edit Encounters'),('PatientDocuments-App','Edit Observations'),('PatientDocuments-App','Edit Visits'),('PatientDocuments-App','Get Concept Sources'),('PatientDocuments-App','Get Concepts'),('PatientDocuments-App','Get Encounter Roles'),('PatientDocuments-App','Get Encounters'),('PatientDocuments-App','Get Observations'),('PatientDocuments-App','Get Patients'),('PatientDocuments-App','Get Visit Attribute Types'),('PatientDocuments-App','Get Visit Types'),('PatientDocuments-App','Get Visits'),('Privilege Level: Full','Add Allergies'),('Privilege Level: Full','Add Cohorts'),('Privilege Level: Full','Add Concept Proposals'),('Privilege Level: Full','Add Drug Groups'),('Privilege Level: Full','Add Drug Info'),('Privilege Level: Full','Add Encounters'),('Privilege Level: Full','Add HL7 Inbound Archive'),('Privilege Level: Full','Add HL7 Inbound Exception'),('Privilege Level: Full','Add HL7 Inbound Queue'),('Privilege Level: Full','Add HL7 Source'),('Privilege Level: Full','Add Observations'),('Privilege Level: Full','Add Orders'),('Privilege Level: Full','Add Patient Identifiers'),('Privilege Level: Full','Add Patient Lists'),('Privilege Level: Full','Add Patient Programs'),('Privilege Level: Full','Add Patients'),('Privilege Level: Full','Add People'),('Privilege Level: Full','Add Problems'),('Privilege Level: Full','Add Relationships'),('Privilege Level: Full','Add Report Objects'),('Privilege Level: Full','Add Reports'),('Privilege Level: Full','Add Users'),('Privilege Level: Full','Add Visits'),('Privilege Level: Full','app:admin'),('Privilege Level: Full','app:adt'),('Privilege Level: Full','app:appointments'),('Privilege Level: Full','app:appointments:adminTab'),('Privilege Level: Full','app:appointments:manageAppointmentsTab'),('Privilege Level: Full','app:clinical'),('Privilege Level: Full','app:clinical:bacteriologyTab'),('Privilege Level: Full','app:clinical:consultationTab'),('Privilege Level: Full','app:clinical:deleteDiagnosis'),('Privilege Level: Full','app:clinical:diagnosisTab'),('Privilege Level: Full','app:clinical:dispositionTab'),('Privilege Level: Full','app:clinical:grantProviderAccess'),('Privilege Level: Full','app:clinical:history'),('Privilege Level: Full','app:clinical:locationpicker'),('Privilege Level: Full','app:clinical:observationTab'),('Privilege Level: Full','app:clinical:onbehalf'),('Privilege Level: Full','app:clinical:ordersTab'),('Privilege Level: Full','app:clinical:retrospective'),('Privilege Level: Full','app:clinical:treatmentTab'),('Privilege Level: Full','app:common:closeVisit'),('Privilege Level: Full','app:common:registration_consultation_link'),('Privilege Level: Full','app:document-upload'),('Privilege Level: Full','app:emergency'),('Privilege Level: Full','app:implementer-interface'),('Privilege Level: Full','app:orders'),('Privilege Level: Full','app:patient-documents'),('Privilege Level: Full','app:radiology-upload'),('Privilege Level: Full','app:radiologyOrders'),('Privilege Level: Full','app:registration'),('Privilege Level: Full','app:reports'),('Privilege Level: Full','Assign Beds'),('Privilege Level: Full','Assign System Developer Role'),('Privilege Level: Full','bahmni:clinical:dispense'),('Privilege Level: Full','Configure Visits'),('Privilege Level: Full','Delete Cohorts'),('Privilege Level: Full','Delete Concept Proposals'),('Privilege Level: Full','Delete Drug Groups'),('Privilege Level: Full','Delete Drug Info'),('Privilege Level: Full','Delete Encounters'),('Privilege Level: Full','Delete HL7 Inbound Archive'),('Privilege Level: Full','Delete HL7 Inbound Exception'),('Privilege Level: Full','Delete HL7 Inbound Queue'),('Privilege Level: Full','Delete Notes'),('Privilege Level: Full','Delete Observations'),('Privilege Level: Full','Delete Orders'),('Privilege Level: Full','Delete Patient Identifiers'),('Privilege Level: Full','Delete Patient Lists'),('Privilege Level: Full','Delete Patient Programs'),('Privilege Level: Full','Delete Patients'),('Privilege Level: Full','Delete People'),('Privilege Level: Full','Delete Relationships'),('Privilege Level: Full','Delete Report Objects'),('Privilege Level: Full','Delete Reports'),('Privilege Level: Full','Delete Users'),('Privilege Level: Full','Delete Visits'),('Privilege Level: Full','Edit Admission Locations'),('Privilege Level: Full','Edit Allergies'),('Privilege Level: Full','Edit Cohorts'),('Privilege Level: Full','Edit Concept Proposals'),('Privilege Level: Full','Edit conditions'),('Privilege Level: Full','Edit Drug Groups'),('Privilege Level: Full','Edit Drug Info'),('Privilege Level: Full','Edit Encounters'),('Privilege Level: Full','Edit Notes'),('Privilege Level: Full','Edit Observations'),('Privilege Level: Full','Edit Orders'),('Privilege Level: Full','Edit Patient Identifiers'),('Privilege Level: Full','Edit Patient Lists'),('Privilege Level: Full','Edit Patient Programs'),('Privilege Level: Full','Edit Patients'),('Privilege Level: Full','Edit People'),('Privilege Level: Full','Edit Problems'),('Privilege Level: Full','Edit Relationships'),('Privilege Level: Full','Edit Report Objects'),('Privilege Level: Full','Edit Reports'),('Privilege Level: Full','Edit Tags'),('Privilege Level: Full','Edit User Passwords'),('Privilege Level: Full','Edit Users'),('Privilege Level: Full','Edit Visits'),('Privilege Level: Full','Form Entry'),('Privilege Level: Full','Generate Batch of Identifiers'),('Privilege Level: Full','Get Admission Locations'),('Privilege Level: Full','Get Allergies'),('Privilege Level: Full','Get Beds'),('Privilege Level: Full','Get Care Settings'),('Privilege Level: Full','Get Concept Attribute Types'),('Privilege Level: Full','Get Concept Classes'),('Privilege Level: Full','Get Concept Datatypes'),('Privilege Level: Full','Get Concept Map Types'),('Privilege Level: Full','Get Concept Proposals'),('Privilege Level: Full','Get Concept Reference Terms'),('Privilege Level: Full','Get Concept Sources'),('Privilege Level: Full','Get Concepts'),('Privilege Level: Full','Get conditions'),('Privilege Level: Full','Get Database Changes'),('Privilege Level: Full','Get Encounter Roles'),('Privilege Level: Full','Get Encounter Types'),('Privilege Level: Full','Get Encounters'),('Privilege Level: Full','Get Field Types'),('Privilege Level: Full','Get Forms'),('Privilege Level: Full','Get Global Properties'),('Privilege Level: Full','Get HL7 Inbound Archive'),('Privilege Level: Full','Get HL7 Inbound Exception'),('Privilege Level: Full','Get HL7 Inbound Queue'),('Privilege Level: Full','Get HL7 Source'),('Privilege Level: Full','Get Identifier Types'),('Privilege Level: Full','Get Location Attribute Types'),('Privilege Level: Full','Get Locations'),('Privilege Level: Full','Get Notes'),('Privilege Level: Full','Get Observations'),('Privilege Level: Full','Get Order Frequencies'),('Privilege Level: Full','Get Order Sets'),('Privilege Level: Full','Get Order Types'),('Privilege Level: Full','Get Orders'),('Privilege Level: Full','Get Patient Cohorts'),('Privilege Level: Full','Get Patient Identifiers'),('Privilege Level: Full','Get Patient Programs'),('Privilege Level: Full','Get Patients'),('Privilege Level: Full','Get People'),('Privilege Level: Full','Get Person Attribute Types'),('Privilege Level: Full','Get Privileges'),('Privilege Level: Full','Get Problems'),('Privilege Level: Full','Get Programs'),('Privilege Level: Full','Get Providers'),('Privilege Level: Full','Get Relationship Types'),('Privilege Level: Full','Get Relationships'),('Privilege Level: Full','Get Roles'),('Privilege Level: Full','Get Tags'),('Privilege Level: Full','Get Users'),('Privilege Level: Full','Get Visit Attribute Types'),('Privilege Level: Full','Get Visit Types'),('Privilege Level: Full','Get Visits'),('Privilege Level: Full','Manage Address Hierarchy'),('Privilege Level: Full','Manage Address Templates'),('Privilege Level: Full','Manage Alerts'),('Privilege Level: Full','Manage Appointment Services'),('Privilege Level: Full','Manage Appointments'),('Privilege Level: Full','Manage Auto Generation Options'),('Privilege Level: Full','Manage Cohort Definitions'),('Privilege Level: Full','Manage Concept Attribute Types'),('Privilege Level: Full','Manage Concept Classes'),('Privilege Level: Full','Manage Concept Datatypes'),('Privilege Level: Full','Manage Concept Map Types'),('Privilege Level: Full','Manage Concept Name tags'),('Privilege Level: Full','Manage Concept Reference Terms'),('Privilege Level: Full','Manage Concept Sources'),('Privilege Level: Full','Manage Concept Stop Words'),('Privilege Level: Full','Manage Concepts'),('Privilege Level: Full','Manage Data Set Definitions'),('Privilege Level: Full','Manage Dimension Definitions'),('Privilege Level: Full','Manage Encounter Roles'),('Privilege Level: Full','Manage Encounter Types'),('Privilege Level: Full','Manage Field Types'),('Privilege Level: Full','Manage FormEntry XSN'),('Privilege Level: Full','Manage Forms'),('Privilege Level: Full','Manage Global Properties'),('Privilege Level: Full','Manage HL7 Messages'),('Privilege Level: Full','Manage Identifier Sequence'),('Privilege Level: Full','Manage Identifier Sources'),('Privilege Level: Full','Manage Identifier Types'),('Privilege Level: Full','Manage Implementation Id'),('Privilege Level: Full','Manage Indicator Definitions'),('Privilege Level: Full','Manage Location Attribute Types'),('Privilege Level: Full','Manage Location Tags'),('Privilege Level: Full','Manage Locations'),('Privilege Level: Full','Manage Metadata Mapping'),('Privilege Level: Full','Manage Modules'),('Privilege Level: Full','Manage Order Frequencies'),('Privilege Level: Full','Manage Order Sets'),('Privilege Level: Full','Manage Order Types'),('Privilege Level: Full','Manage Person Attribute Types'),('Privilege Level: Full','Manage Privileges'),('Privilege Level: Full','Manage Program Attribute Types'),('Privilege Level: Full','Manage Programs'),('Privilege Level: Full','Manage Providers'),('Privilege Level: Full','Manage Relationship Types'),('Privilege Level: Full','Manage Relationships'),('Privilege Level: Full','Manage Report Definitions'),('Privilege Level: Full','Manage Report Designs'),('Privilege Level: Full','Manage Reports'),('Privilege Level: Full','Manage RESTWS'),('Privilege Level: Full','Manage Roles'),('Privilege Level: Full','Manage Scheduled Report Tasks'),('Privilege Level: Full','Manage Scheduler'),('Privilege Level: Full','Manage Search Index'),('Privilege Level: Full','Manage Token Registrations'),('Privilege Level: Full','Manage Visit Attribute Types'),('Privilege Level: Full','Manage Visit Types'),('Privilege Level: Full','Patient Dashboard - View Demographics Section'),('Privilege Level: Full','Patient Dashboard - View Encounters Section'),('Privilege Level: Full','Patient Dashboard - View Forms Section'),('Privilege Level: Full','Patient Dashboard - View Graphs Section'),('Privilege Level: Full','Patient Dashboard - View Overview Section'),('Privilege Level: Full','Patient Dashboard - View Patient Summary'),('Privilege Level: Full','Patient Dashboard - View Regimen Section'),('Privilege Level: Full','Patient Dashboard - View Visits Section'),('Privilege Level: Full','Patient Overview - View Allergies'),('Privilege Level: Full','Patient Overview - View Patient Actions'),('Privilege Level: Full','Patient Overview - View Patient Flags'),('Privilege Level: Full','Patient Overview - View Problem List'),('Privilege Level: Full','Patient Overview - View Programs'),('Privilege Level: Full','Patient Overview - View Relationships'),('Privilege Level: Full','Provider Management - Admin'),('Privilege Level: Full','Provider Management API'),('Privilege Level: Full','Provider Management API - Read-only'),('Privilege Level: Full','Provider Management Dashboard - Edit Patients'),('Privilege Level: Full','Provider Management Dashboard - Edit Providers'),('Privilege Level: Full','Provider Management Dashboard - View Historical'),('Privilege Level: Full','Provider Management Dashboard - View Patients'),('Privilege Level: Full','Provider Management Dashboard - View Providers'),('Privilege Level: Full','Purge Field Types'),('Privilege Level: Full','Purge Program Attribute Types'),('Privilege Level: Full','Remove Allergies'),('Privilege Level: Full','Remove Problems'),('Privilege Level: Full','Run Reports'),('Privilege Level: Full','Share Metadata'),('Privilege Level: Full','Update HL7 Inbound Archive'),('Privilege Level: Full','Update HL7 Inbound Exception'),('Privilege Level: Full','Update HL7 Inbound Queue'),('Privilege Level: Full','Update HL7 Source'),('Privilege Level: Full','Upload Batch of Identifiers'),('Privilege Level: Full','Upload XSN'),('Privilege Level: Full','View Administration Functions'),('Privilege Level: Full','View Allergies'),('Privilege Level: Full','View Appointment Services'),('Privilege Level: Full','View Appointments'),('Privilege Level: Full','View Calculations'),('Privilege Level: Full','View Concept Classes'),('Privilege Level: Full','View Concept Datatypes'),('Privilege Level: Full','View Concept Proposals'),('Privilege Level: Full','View Concept Sources'),('Privilege Level: Full','View Concepts'),('Privilege Level: Full','View Data Entry Statistics'),('Privilege Level: Full','View Drug Groups'),('Privilege Level: Full','View Drug Info'),('Privilege Level: Full','View Encounter Types'),('Privilege Level: Full','View Encounters'),('Privilege Level: Full','View Field Types'),('Privilege Level: Full','View Forms'),('Privilege Level: Full','View Global Properties'),('Privilege Level: Full','View Identifier Types'),('Privilege Level: Full','View Locations'),('Privilege Level: Full','View Metadata Via Mapping'),('Privilege Level: Full','View Navigation Menu'),('Privilege Level: Full','View Observations'),('Privilege Level: Full','View Order Types'),('Privilege Level: Full','View Orders'),('Privilege Level: Full','View Patient Cohorts'),('Privilege Level: Full','View Patient Identifiers'),('Privilege Level: Full','View Patient Lists'),('Privilege Level: Full','View Patient Programs'),('Privilege Level: Full','View Patients'),('Privilege Level: Full','View People'),('Privilege Level: Full','View Person Attribute Types'),('Privilege Level: Full','View Privileges'),('Privilege Level: Full','View Problems'),('Privilege Level: Full','View Program Attribute Types'),('Privilege Level: Full','View Programs'),('Privilege Level: Full','View Providers'),('Privilege Level: Full','View Relationship Types'),('Privilege Level: Full','View Relationships'),('Privilege Level: Full','View Report Objects'),('Privilege Level: Full','View Reports'),('Privilege Level: Full','View RESTWS'),('Privilege Level: Full','View Roles'),('Privilege Level: Full','View Token Registrations'),('Privilege Level: Full','View Unpublished Forms'),('Privilege Level: Full','View Users'),('Privilege Level: Full','View Visit Attribute Types'),('Privilege Level: Full','View Visit Types'),('Privilege Level: Full','View Visits'),('Programs-App','Add Patient Programs'),('Programs-App','app:clinical'),('Programs-App','app:clinical:locationpicker'),('Programs-App','app:clinical:onbehalf'),('Programs-App','app:clinical:retrospective'),('Programs-App','Edit Patient Programs'),('Programs-App','Get Concept Sources'),('Programs-App','Get Concepts'),('Programs-App','Get Patient Programs'),('Programs-App','Get Patients'),('Programs-App','Get People'),('Programs-App','Get Programs'),('Programs-App','Get Visit Types'),('Programs-App','Get Visits'),('Programs-App','Manage Program Attribute Types'),('Programs-App','Purge Program Attribute Types'),('Programs-App','View Patient Programs'),('Programs-App','View Program Attribute Types'),('Radiology-App','Add Encounters'),('Radiology-App','Add Observations'),('Radiology-App','Add Visits'),('Radiology-App','app:radiology-upload'),('Radiology-App','Edit Encounters'),('Radiology-App','Edit Observations'),('Radiology-App','Edit Visits'),('Radiology-App','Get Concept Sources'),('Radiology-App','Get Concepts'),('Radiology-App','Get Encounter Roles'),('Radiology-App','Get Encounters'),('Radiology-App','Get Observations'),('Radiology-App','Get Patients'),('Radiology-App','Get Visit Attribute Types'),('Radiology-App','Get Visit Types'),('Radiology-App','Get Visits'),('Registration-App','Add Encounters'),('Registration-App','Add Observations'),('Registration-App','Add Patients'),('Registration-App','Add Relationships'),('Registration-App','Add Visits'),('Registration-App','Delete Visits'),('Registration-App','Edit Encounters'),('Registration-App','Edit Observations'),('Registration-App','Edit Patient Identifiers'),('Registration-App','Edit Patients'),('Registration-App','Edit Relationships'),('Registration-App','Edit Visits'),('Registration-App','Get Encounter Roles'),('Registration-App','Get Observations'),('Registration-App','Get Patient Identifiers'),('Registration-App','Get Visit Attribute Types'),('Registration-App-Read-Only','app:registration'),('Registration-App-Read-Only','Get Concept Sources'),('Registration-App-Read-Only','Get Concepts'),('Registration-App-Read-Only','Get Encounters'),('Registration-App-Read-Only','Get Observations'),('Registration-App-Read-Only','Get Patients'),('Registration-App-Read-Only','Get People'),('Registration-App-Read-Only','Get Person Attribute Types'),('Registration-App-Read-Only','Get Visit Types'),('Registration-App-Read-Only','Get Visits'),('Registration-App-Read-Only','View Patients'),('Reports-App','app:reports'),('Reports-App','Get Concept Sources'),('Reports-App','Get Concepts'),('Reports-App','Get Visit Types'),('SuperAdmin','Add Allergies'),('SuperAdmin','Add Cohorts'),('SuperAdmin','Add Concept Proposals'),('SuperAdmin','Add Drug Groups'),('SuperAdmin','Add Drug Info'),('SuperAdmin','Add Encounters'),('SuperAdmin','Add HL7 Inbound Archive'),('SuperAdmin','Add HL7 Inbound Exception'),('SuperAdmin','Add HL7 Inbound Queue'),('SuperAdmin','Add HL7 Source'),('SuperAdmin','Add Observations'),('SuperAdmin','Add Orders'),('SuperAdmin','Add Patient Identifiers'),('SuperAdmin','Add Patient Lists'),('SuperAdmin','Add Patient Programs'),('SuperAdmin','Add Patients'),('SuperAdmin','Add People'),('SuperAdmin','Add Problems'),('SuperAdmin','Add Relationships'),('SuperAdmin','Add Report Objects'),('SuperAdmin','Add Reports'),('SuperAdmin','Add Users'),('SuperAdmin','Add Visits'),('SuperAdmin','app:admin'),('SuperAdmin','app:adt'),('SuperAdmin','app:clinical'),('SuperAdmin','app:clinical:bacteriologyTab'),('SuperAdmin','app:clinical:consultationTab'),('SuperAdmin','app:clinical:deleteDiagnosis'),('SuperAdmin','app:clinical:diagnosisTab'),('SuperAdmin','app:clinical:dispositionTab'),('SuperAdmin','app:clinical:grantProviderAccess'),('SuperAdmin','app:clinical:history'),('SuperAdmin','app:clinical:locationpicker'),('SuperAdmin','app:clinical:observationTab'),('SuperAdmin','app:clinical:onbehalf'),('SuperAdmin','app:clinical:ordersTab'),('SuperAdmin','app:clinical:retrospective'),('SuperAdmin','app:clinical:treatmentTab'),('SuperAdmin','app:common:closeVisit'),('SuperAdmin','app:common:registration_consultation_link'),('SuperAdmin','app:document-upload'),('SuperAdmin','app:emergency'),('SuperAdmin','app:implementer-interface'),('SuperAdmin','app:orders'),('SuperAdmin','app:patient-documents'),('SuperAdmin','app:radiology-upload'),('SuperAdmin','app:radiologyOrders'),('SuperAdmin','app:registration'),('SuperAdmin','app:reports'),('SuperAdmin','Assign Beds'),('SuperAdmin','Assign System Developer Role'),('SuperAdmin','bahmni:clinical:dispense'),('SuperAdmin','Configure Visits'),('SuperAdmin','Delete Cohorts'),('SuperAdmin','Delete Concept Proposals'),('SuperAdmin','Delete Drug Groups'),('SuperAdmin','Delete Drug Info'),('SuperAdmin','Delete Encounters'),('SuperAdmin','Delete HL7 Inbound Archive'),('SuperAdmin','Delete HL7 Inbound Exception'),('SuperAdmin','Delete HL7 Inbound Queue'),('SuperAdmin','Delete Notes'),('SuperAdmin','Delete Observations'),('SuperAdmin','Delete Orders'),('SuperAdmin','Delete Patient Identifiers'),('SuperAdmin','Delete Patient Lists'),('SuperAdmin','Delete Patient Programs'),('SuperAdmin','Delete Patients'),('SuperAdmin','Delete People'),('SuperAdmin','Delete Relationships'),('SuperAdmin','Delete Report Objects'),('SuperAdmin','Delete Reports'),('SuperAdmin','Delete Users'),('SuperAdmin','Delete Visits'),('SuperAdmin','Edit Admission Locations'),('SuperAdmin','Edit Allergies'),('SuperAdmin','Edit Cohorts'),('SuperAdmin','Edit Concept Proposals'),('SuperAdmin','Edit Drug Groups'),('SuperAdmin','Edit Drug Info'),('SuperAdmin','Edit Encounters'),('SuperAdmin','Edit Notes'),('SuperAdmin','Edit Observations'),('SuperAdmin','Edit Orders'),('SuperAdmin','Edit Patient Identifiers'),('SuperAdmin','Edit Patient Lists'),('SuperAdmin','Edit Patient Programs'),('SuperAdmin','Edit Patients'),('SuperAdmin','Edit People'),('SuperAdmin','Edit Problems'),('SuperAdmin','Edit Relationships'),('SuperAdmin','Edit Report Objects'),('SuperAdmin','Edit Reports'),('SuperAdmin','Edit User Passwords'),('SuperAdmin','Edit Users'),('SuperAdmin','Edit Visits'),('SuperAdmin','Form Entry'),('SuperAdmin','Generate Batch of Identifiers'),('SuperAdmin','Get Admission Locations'),('SuperAdmin','Get Allergies'),('SuperAdmin','Get Beds'),('SuperAdmin','Get Care Settings'),('SuperAdmin','Get Concept Attribute Types'),('SuperAdmin','Get Concept Classes'),('SuperAdmin','Get Concept Datatypes'),('SuperAdmin','Get Concept Map Types'),('SuperAdmin','Get Concept Proposals'),('SuperAdmin','Get Concept Reference Terms'),('SuperAdmin','Get Concept Sources'),('SuperAdmin','Get Concepts'),('SuperAdmin','Get Database Changes'),('SuperAdmin','Get Encounter Roles'),('SuperAdmin','Get Encounter Types'),('SuperAdmin','Get Encounters'),('SuperAdmin','Get Field Types'),('SuperAdmin','Get Forms'),('SuperAdmin','Get Global Properties'),('SuperAdmin','Get HL7 Inbound Archive'),('SuperAdmin','Get HL7 Inbound Exception'),('SuperAdmin','Get HL7 Inbound Queue'),('SuperAdmin','Get HL7 Source'),('SuperAdmin','Get Identifier Types'),('SuperAdmin','Get Location Attribute Types'),('SuperAdmin','Get Locations'),('SuperAdmin','Get Notes'),('SuperAdmin','Get Observations'),('SuperAdmin','Get Order Frequencies'),('SuperAdmin','Get Order Sets'),('SuperAdmin','Get Order Types'),('SuperAdmin','Get Orders'),('SuperAdmin','Get Patient Cohorts'),('SuperAdmin','Get Patient Identifiers'),('SuperAdmin','Get Patient Programs'),('SuperAdmin','Get Patients'),('SuperAdmin','Get People'),('SuperAdmin','Get Person Attribute Types'),('SuperAdmin','Get Privileges'),('SuperAdmin','Get Problems'),('SuperAdmin','Get Programs'),('SuperAdmin','Get Providers'),('SuperAdmin','Get Relationship Types'),('SuperAdmin','Get Relationships'),('SuperAdmin','Get Roles'),('SuperAdmin','Get Users'),('SuperAdmin','Get Visit Attribute Types'),('SuperAdmin','Get Visit Types'),('SuperAdmin','Get Visits'),('SuperAdmin','Manage Address Hierarchy'),('SuperAdmin','Manage Address Templates'),('SuperAdmin','Manage Alerts'),('SuperAdmin','Manage Auto Generation Options'),('SuperAdmin','Manage Cohort Definitions'),('SuperAdmin','Manage Concept Attribute Types'),('SuperAdmin','Manage Concept Classes'),('SuperAdmin','Manage Concept Datatypes'),('SuperAdmin','Manage Concept Map Types'),('SuperAdmin','Manage Concept Name tags'),('SuperAdmin','Manage Concept Reference Terms'),('SuperAdmin','Manage Concept Sources'),('SuperAdmin','Manage Concept Stop Words'),('SuperAdmin','Manage Concepts'),('SuperAdmin','Manage Data Set Definitions'),('SuperAdmin','Manage Dimension Definitions'),('SuperAdmin','Manage Encounter Roles'),('SuperAdmin','Manage Encounter Types'),('SuperAdmin','Manage Field Types'),('SuperAdmin','Manage FormEntry XSN'),('SuperAdmin','Manage Forms'),('SuperAdmin','Manage Global Properties'),('SuperAdmin','Manage HL7 Messages'),('SuperAdmin','Manage Identifier Sequence'),('SuperAdmin','Manage Identifier Sources'),('SuperAdmin','Manage Identifier Types'),('SuperAdmin','Manage Implementation Id'),('SuperAdmin','Manage Indicator Definitions'),('SuperAdmin','Manage Location Attribute Types'),('SuperAdmin','Manage Location Tags'),('SuperAdmin','Manage Locations'),('SuperAdmin','Manage Metadata Mapping'),('SuperAdmin','Manage Modules'),('SuperAdmin','Manage Order Frequencies'),('SuperAdmin','Manage Order Sets'),('SuperAdmin','Manage Order Types'),('SuperAdmin','Manage Person Attribute Types'),('SuperAdmin','Manage Privileges'),('SuperAdmin','Manage Program Attribute Types'),('SuperAdmin','Manage Programs'),('SuperAdmin','Manage Providers'),('SuperAdmin','Manage Relationship Types'),('SuperAdmin','Manage Relationships'),('SuperAdmin','Manage Report Definitions'),('SuperAdmin','Manage Report Designs'),('SuperAdmin','Manage Reports'),('SuperAdmin','Manage RESTWS'),('SuperAdmin','Manage Roles'),('SuperAdmin','Manage Scheduled Report Tasks'),('SuperAdmin','Manage Scheduler'),('SuperAdmin','Manage Search Index'),('SuperAdmin','Manage Token Registrations'),('SuperAdmin','Manage Visit Attribute Types'),('SuperAdmin','Manage Visit Types'),('SuperAdmin','Patient Dashboard - View Demographics Section'),('SuperAdmin','Patient Dashboard - View Encounters Section'),('SuperAdmin','Patient Dashboard - View Forms Section'),('SuperAdmin','Patient Dashboard - View Graphs Section'),('SuperAdmin','Patient Dashboard - View Overview Section'),('SuperAdmin','Patient Dashboard - View Patient Summary'),('SuperAdmin','Patient Dashboard - View Regimen Section'),('SuperAdmin','Patient Dashboard - View Visits Section'),('SuperAdmin','Patient Overview - View Allergies'),('SuperAdmin','Patient Overview - View Patient Actions'),('SuperAdmin','Patient Overview - View Patient Flags'),('SuperAdmin','Patient Overview - View Problem List'),('SuperAdmin','Patient Overview - View Programs'),('SuperAdmin','Patient Overview - View Relationships'),('SuperAdmin','Provider Management - Admin'),('SuperAdmin','Provider Management API'),('SuperAdmin','Provider Management API - Read-only'),('SuperAdmin','Provider Management Dashboard - Edit Patients'),('SuperAdmin','Provider Management Dashboard - Edit Providers'),('SuperAdmin','Provider Management Dashboard - View Historical'),('SuperAdmin','Provider Management Dashboard - View Patients'),('SuperAdmin','Provider Management Dashboard - View Providers'),('SuperAdmin','Purge Field Types'),('SuperAdmin','Purge Program Attribute Types'),('SuperAdmin','Remove Allergies'),('SuperAdmin','Remove Problems'),('SuperAdmin','Run Reports'),('SuperAdmin','Share Metadata'),('SuperAdmin','Task: Modify Allergies'),('SuperAdmin','Update HL7 Inbound Archive'),('SuperAdmin','Update HL7 Inbound Exception'),('SuperAdmin','Update HL7 Inbound Queue'),('SuperAdmin','Update HL7 Source'),('SuperAdmin','Upload Batch of Identifiers'),('SuperAdmin','Upload XSN'),('SuperAdmin','View Administration Functions'),('SuperAdmin','View Allergies'),('SuperAdmin','View Calculations'),('SuperAdmin','View Concept Classes'),('SuperAdmin','View Concept Datatypes'),('SuperAdmin','View Concept Proposals'),('SuperAdmin','View Concept Sources'),('SuperAdmin','View Concepts'),('SuperAdmin','View Data Entry Statistics'),('SuperAdmin','View Drug Groups'),('SuperAdmin','View Drug Info'),('SuperAdmin','View Encounter Types'),('SuperAdmin','View Encounters'),('SuperAdmin','View Field Types'),('SuperAdmin','View Forms'),('SuperAdmin','View Global Properties'),('SuperAdmin','View Identifier Types'),('SuperAdmin','View Locations'),('SuperAdmin','View Metadata Via Mapping'),('SuperAdmin','View Navigation Menu'),('SuperAdmin','View Observations'),('SuperAdmin','View Order Types'),('SuperAdmin','View Orders'),('SuperAdmin','View Patient Cohorts'),('SuperAdmin','View Patient Identifiers'),('SuperAdmin','View Patient Lists'),('SuperAdmin','View Patient Programs'),('SuperAdmin','View Patients'),('SuperAdmin','View People'),('SuperAdmin','View Person Attribute Types'),('SuperAdmin','View Privileges'),('SuperAdmin','View Problems'),('SuperAdmin','View Program Attribute Types'),('SuperAdmin','View Programs'),('SuperAdmin','View Providers'),('SuperAdmin','View Relationship Types'),('SuperAdmin','View Relationships'),('SuperAdmin','View Report Objects'),('SuperAdmin','View Reports'),('SuperAdmin','View RESTWS'),('SuperAdmin','View Roles'),('SuperAdmin','View Token Registrations'),('SuperAdmin','View Unpublished Forms'),('SuperAdmin','View Users'),('SuperAdmin','View Visit Attribute Types'),('SuperAdmin','View Visit Types'),('SuperAdmin','View Visits');
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) NOT NULL DEFAULT '',
  `child_role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`),
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_role`
--

LOCK TABLES `role_role` WRITE;
/*!40000 ALTER TABLE `role_role` DISABLE KEYS */;
INSERT INTO `role_role` VALUES ('Bahmni-App-User-Login','Admin-App'),('Admin-App','Bahmni-App'),('Clinical-App','Bahmni-App'),('Implementer-Interface-App','Bahmni-App'),('InPatient-App','Bahmni-App'),('OrderFulfillment-App','Bahmni-App'),('PatientDocuments-App','Bahmni-App'),('Programs-App','Bahmni-App'),('Radiology-App','Bahmni-App'),('Registration-App','Bahmni-App'),('Reports-App','Bahmni-App'),('Clinical-App-Read-Only','Clinical-App'),('Clinical-App-Save','Clinical-App'),('Clinical-App-Common','Clinical-App-Bacteriology'),('Clinical-App-Save','Clinical-App-Bacteriology'),('Bahmni-App-User-Login','Clinical-App-Common'),('Clinical-App-Common','Clinical-App-Diagnosis'),('Clinical-App-Save','Clinical-App-Diagnosis'),('Clinical-App-Common','Clinical-App-Disposition'),('Clinical-App-Save','Clinical-App-Disposition'),('Clinical-App-Common','Clinical-App-Observations'),('Clinical-App-Save','Clinical-App-Observations'),('Clinical-App-Common','Clinical-App-Orders'),('Clinical-App-Save','Clinical-App-Orders'),('Clinical-App-Common','Clinical-App-Read-Only'),('Clinical-App-Common','Clinical-App-Treatment'),('Clinical-App-Save','Clinical-App-Treatment'),('Bahmni-App-User-Login','Implementer-Interface-App'),('InPatient-App-Read-Only','InPatient-App'),('Bahmni-App-User-Login','InPatient-App-Read-Only'),('Bahmni-App-User-Login','OrderFulfillment-App'),('Bahmni-App-User-Login','PatientDocuments-App'),('Bahmni-App-User-Login','Programs-App'),('Clinical-App','Programs-App'),('Bahmni-App-User-Login','Radiology-App'),('Registration-App-Read-Only','Registration-App'),('Bahmni-App-User-Login','Registration-App-Read-Only'),('Bahmni-App-User-Login','Reports-App');
/*!40000 ALTER TABLE `role_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `schedulable_class` text,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT '0',
  `start_on_startup` tinyint(1) NOT NULL DEFAULT '0',
  `started` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `scheduler_task_config_uuid_index` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`),
  CONSTRAINT `scheduler_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `scheduler_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config`
--

LOCK TABLES `scheduler_task_config` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config` DISABLE KEYS */;
INSERT INTO `scheduler_task_config` VALUES (2,'Auto Close Visits Task','Stops all active visits that match the visit type(s) specified by the value of the global property \'visits.autoCloseVisitType\'','org.openmrs.scheduler.tasks.AutoCloseVisitsTask','2011-11-28 23:59:59','MM/dd/yyyy HH:mm:ss',86400,0,0,1,'2016-03-07 11:44:38',NULL,NULL,NULL,'8c17b376-1a2b-11e1-a51a-00248140a5eb'),(3,'OpenMRS event publisher task',NULL,'org.openmrs.module.atomfeed.scheduler.tasks.EventPublisherTask','2016-03-07 11:59:41','MM/dd/yyyy HH:mm:ss',2,1,1,1,'2016-03-07 11:59:41',2,'2017-10-31 11:55:53','2017-10-31 11:55:53','f9514c4d-e42d-11e5-8c3e-08002715d519'),(6,'OpenElis Patient Atom Feed Task',NULL,'org.bahmni.module.elisatomfeedclient.api.task.OpenElisPatientFeedTask','2016-03-07 12:20:56','MM/dd/yyyy HH:mm:ss',15,1,1,1,'2016-03-07 00:00:00',2,'2017-10-31 11:55:41','2017-10-31 11:55:41','f14f900a-e430-11e5-8c3e-08002715d519'),(9,'OpenElis Patient  Atom Feed Failed Event Task',NULL,'org.bahmni.module.elisatomfeedclient.api.task.OpenElisPatientFeedFailedEventsTask','2016-03-07 12:20:56','MM/dd/yyyy HH:mm:ss',15,1,1,1,'2016-03-07 00:00:00',2,'2017-10-31 11:55:41','2017-10-31 11:55:41','f15e7ee1-e430-11e5-8c3e-08002715d519'),(10,'OpenMRS event offset marker task',NULL,'org.openmrs.module.atomfeed.scheduler.tasks.EventRecordsNumberOffsetMarkerTask','2014-01-14 00:00:00','MM/dd/yyyy HH:mm:ss',86400,1,1,1,'2017-04-04 15:49:08',NULL,NULL,NULL,'236aa82c-1920-11e7-bbfc-9206fc7c228b'),(11,'Mark Appointment As Missed Task','Mark appointments as missed task','org.openmrs.module.appointments.scheduler.tasks.MarkAppointmentAsMissedTask','2017-10-30 00:00:00','MM/dd/yyyy HH:mm:ss',86400,1,1,1,'2017-10-30 14:22:10',2,'2017-10-30 14:22:39',NULL,'9dcf0a05-bd4f-11e7-8025-08002715d519'),(12,'Mark Appointment As Complete Task','Mark appointments as complete task','org.openmrs.module.appointments.scheduler.tasks.MarkAppointmentAsCompleteTask','2017-10-30 00:00:00','MM/dd/yyyy HH:mm:ss',86400,1,1,1,'2017-10-30 14:22:10',2,'2017-10-30 14:22:39',NULL,'9dcf163b-bd4f-11e7-8025-08002715d519');
/*!40000 ALTER TABLE `scheduler_task_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`),
  CONSTRAINT `task_config_for_property` FOREIGN KEY (`task_config_id`) REFERENCES `scheduler_task_config` (`task_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config_property`
--

LOCK TABLES `scheduler_task_config_property` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `subtype` varchar(255) NOT NULL,
  `serialization_class` varchar(255) NOT NULL,
  `serialized_data` mediumtext NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `serialized_object_uuid_index` (`uuid`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_retired_by` (`retired_by`),
  CONSTRAINT `serialized_object_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `serialized_object_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialized_object`
--

LOCK TABLES `serialized_object` WRITE;
/*!40000 ALTER TABLE `serialized_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialized_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_order`
--

DROP TABLE IF EXISTS `test_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL DEFAULT '0',
  `specimen_source` int(11) DEFAULT NULL,
  `laterality` varchar(20) DEFAULT NULL,
  `clinical_history` text,
  `frequency` int(11) DEFAULT NULL,
  `number_of_repeats` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `test_order_specimen_source_fk` (`specimen_source`),
  KEY `test_order_frequency_fk` (`frequency`),
  CONSTRAINT `test_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`),
  CONSTRAINT `test_order_order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `test_order_specimen_source_fk` FOREIGN KEY (`specimen_source`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_order`
--

LOCK TABLES `test_order` WRITE;
/*!40000 ALTER TABLE `test_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uiframework_user_defined_page_view`
--

DROP TABLE IF EXISTS `uiframework_user_defined_page_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uiframework_user_defined_page_view` (
  `page_view_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `template_type` varchar(50) NOT NULL,
  `template_text` mediumtext NOT NULL,
  `uuid` varchar(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`page_view_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uiframework_user_defined_page_view`
--

LOCK TABLES `uiframework_user_defined_page_view` WRITE;
/*!40000 ALTER TABLE `uiframework_user_defined_page_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `uiframework_user_defined_page_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(100) NOT NULL DEFAULT '',
  `property_value` text,
  PRIMARY KEY (`user_id`,`property`),
  CONSTRAINT `user_property_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_property`
--

LOCK TABLES `user_property` WRITE;
/*!40000 ALTER TABLE `user_property` DISABLE KEYS */;
INSERT INTO `user_property` VALUES (1,'lockoutTimestamp',''),(1,'loginAttempts','0'),(6,'defaultLocale','en'),(6,'favouriteObsTemplates',''),(6,'favouriteWards',''),(6,'recentlyViewedPatients','[]');
/*!40000 ALTER TABLE `user_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`role`,`user_id`),
  KEY `user_role_to_users` (`user_id`),
  CONSTRAINT `role_definitions` FOREIGN KEY (`role`) REFERENCES `role` (`role`),
  CONSTRAINT `user_role_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'bypass2FA'),(1,'Provider'),(1,'System Developer'),(4,'Provider'),(4,'Reports-App'),(4,'SuperAdmin'),(4,'System Developer'),(6,'bahmni-document-uploader'),(6,'Doctor'),(6,'Nurse'),(6,'Privilege Level: Full'),(6,'Provider'),(6,'RegistrationClerk'),(6,'System Developer');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_creator` (`creator`),
  KEY `user_who_retired_this_user` (`retired_by`),
  KEY `person_id_for_user` (`person_id`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_changed_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `user_who_retired_this_user` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','f1feccee0f5b7fa1ff89628d020618677606906ee67c398d285b7b4fcf913989d71ccdeb4e542c70d1474bfb45a2440f2dba543a70dcade5123098b3b94142c5','c788c6ad82a157b712392ca695dfcf2eed193d7f',NULL,NULL,1,'2005-01-01 00:00:00',1,'2016-03-07 11:45:04',1,0,NULL,NULL,NULL,'daf1fe22-e42b-11e5-8c3e-08002715d519'),(2,'daemon','daemon',NULL,NULL,NULL,NULL,1,'2010-04-26 13:25:00',NULL,NULL,1,0,NULL,NULL,NULL,'A4F30A1B-5EB9-11DF-A648-37A07F9C90FB'),(3,'Lab Manager','Lab Manager',NULL,NULL,NULL,NULL,1,'2016-03-07 12:10:34',NULL,NULL,3,0,NULL,NULL,NULL,'7e767659-e42f-11e5-8c3e-08002715d519'),(4,'Reports User','reports-user','29171af2d2cc6b48ab011c6387daa8516960edd0a7fa4e8bc6eaf1aab1d3d15443a82213fb0d11b3071ca73d45f719d885b2fdabcfef03b54b3102af450cd771','6bc56cf15a664f951134af3451ac806e746215fa3e482b72f08a911e848962bee8b124e672f3cbe8dc7040dc6d8e35960e24a1ffa6150af63d12ba1ce8c07fad',NULL,NULL,1,'2016-03-07 12:17:31',NULL,NULL,4,0,NULL,NULL,NULL,'7721c88d-e430-11e5-8c3e-08002715d519'),(5,'Lab System','Lab System',NULL,NULL,NULL,NULL,1,'2016-03-07 12:20:56',NULL,NULL,5,0,NULL,NULL,NULL,'f164da25-e430-11e5-8c3e-08002715d519'),(6,'SUPERMAN','superman','fe0f4ff3ef8f1c08e773f44049cb3fc5d7245d05a2def777f6393aad89a1285f67f3664f4df7cf7d04c373960fa4ebb89239be6820b788fe741c83a0c24db644','b084dc52f7de4003c536d0c2a6ed3fd0bc10256d0ac5ef69cdd223be5d39d30ea810bb24dfa11ef6b85f778fe4f5e535e1e7bad83c8e8ca0ec09dc0d1c48f9d9','',NULL,1,'2017-04-04 16:10:15',1,'2017-04-04 16:10:15',6,0,NULL,NULL,NULL,'16b7d2b9-1923-11e7-bbfc-9206fc7c228b');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit` (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `visit_type_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `indication_concept_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_patient_index` (`patient_id`),
  KEY `visit_type_fk` (`visit_type_id`),
  KEY `visit_location_fk` (`location_id`),
  KEY `visit_creator_fk` (`creator`),
  KEY `visit_voided_by_fk` (`voided_by`),
  KEY `visit_changed_by_fk` (`changed_by`),
  KEY `visit_indication_concept_fk` (`indication_concept_id`),
  KEY `visit_date_stopped` (`date_stopped`),
  CONSTRAINT `visit_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_indication_concept_fk` FOREIGN KEY (`indication_concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `visit_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `visit_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `visit_type_fk` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_type` (`visit_type_id`),
  CONSTRAINT `visit_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute`
--

DROP TABLE IF EXISTS `visit_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute` (
  `visit_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT '0',
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_visit_fk` (`visit_id`),
  KEY `visit_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `visit_attribute_creator_fk` (`creator`),
  KEY `visit_attribute_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `visit_attribute_type` (`visit_attribute_type_id`),
  CONSTRAINT `visit_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_visit_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`),
  CONSTRAINT `visit_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute`
--

LOCK TABLES `visit_attribute` WRITE;
/*!40000 ALTER TABLE `visit_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute_type`
--

DROP TABLE IF EXISTS `visit_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute_type` (
  `visit_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_type_creator_fk` (`creator`),
  KEY `visit_attribute_type_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `visit_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute_type`
--

LOCK TABLES `visit_attribute_type` WRITE;
/*!40000 ALTER TABLE `visit_attribute_type` DISABLE KEYS */;
INSERT INTO `visit_attribute_type` VALUES (1,'Visit Status',NULL,'org.openmrs.customdatatype.datatype.FreeTextDatatype',NULL,NULL,NULL,0,NULL,1,'2016-03-07 12:10:35',NULL,NULL,0,NULL,NULL,NULL,'7f7bd8d8-e42f-11e5-8c3e-08002715d519'),(2,'Admission Status',NULL,'org.openmrs.customdatatype.datatype.FreeTextDatatype',NULL,NULL,NULL,0,NULL,1,'2016-03-07 12:10:35',NULL,NULL,0,NULL,NULL,NULL,'7f8057c4-e42f-11e5-8c3e-08002715d519');
/*!40000 ALTER TABLE `visit_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_type`
--

DROP TABLE IF EXISTS `visit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_type` (
  `visit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT '0',
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_type_creator` (`creator`),
  KEY `visit_type_changed_by` (`changed_by`),
  KEY `visit_type_retired_by` (`retired_by`),
  CONSTRAINT `visit_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `visit_type_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_type`
--

LOCK TABLES `visit_type` WRITE;
/*!40000 ALTER TABLE `visit_type` DISABLE KEYS */;
INSERT INTO `visit_type` VALUES (3,'LAB VISIT','Visits for lab visit by patient when the tests are not ordered through OpenMRS',1,'2016-03-07 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'f1721f98-e430-11e5-8c3e-08002715d519'),(4,'OPD','Visit for patients coming for OPD',1,'2017-04-04 16:10:15',NULL,NULL,0,NULL,NULL,NULL,'16b815df-1923-11e7-bbfc-9206fc7c228b'),(5,'IPD','Visit for patients coming for IPD',1,'2017-04-04 16:10:15',NULL,NULL,0,NULL,NULL,NULL,'16b84d59-1923-11e7-bbfc-9206fc7c228b');
/*!40000 ALTER TABLE `visit_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'openmrs'
--
/*!50003 DROP FUNCTION IF EXISTS `obsParent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` FUNCTION `obsParent`(obsid int) RETURNS int(11)
    DETERMINISTIC
BEGIN
                DECLARE parent_id int;
                DECLARE conceptid int;
                sloop:LOOP
                    SET parent_id = NULL;
                    select obs_group_id into parent_id from obs where obs_id = obsid;
                    IF parent_id IS NULL THEN
                        LEAVE sloop;
                    END IF;
                    SET obsid = parent_id;
                    ITERATE sloop;
                END LOOP;
                select concept_id into conceptid from obs where obs_id = obsid;
                RETURN conceptid;
              END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_concept` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `add_concept`(INOUT new_concept_id INT,
                              INOUT concept_name_short_id INT,
                              INOUT concept_name_full_id INT,
                              name_of_concept VARCHAR(255),
                              concept_short_name VARCHAR(255),
                              data_type_name VARCHAR(255),
                              class_name VARCHAR(255),
                              is_set BOOLEAN)
BEGIN
  DECLARE data_type_id INT;
  DECLARE class_id INT;
  DECLARE is_set_val TINYINT(1);

  CASE
    WHEN is_set = TRUE THEN
       SET is_set_val = '1';
    WHEN is_set = FALSE THEN
       SET is_set_val = '0';
  END CASE;

  SELECT count(distinct concept_id) into @concept_count from concept_name where name = name_of_concept and concept_name_type='FULLY_SPECIFIED';
  IF @concept_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Concept Already Exists';
  ELSE
    SELECT concept_datatype_id INTO data_type_id FROM concept_datatype WHERE name = data_type_name;
    SELECT concept_class_id INTO class_id FROM concept_class WHERE name = class_name;

    SELECT uuid() into @uuid;
    INSERT INTO concept (datatype_id, class_id, is_set, creator, date_created, changed_by, date_changed, uuid)
      values (data_type_id, class_id, is_set_val, 1, now(), 1, now(), @uuid);
    SELECT MAX(concept_id) INTO new_concept_id FROM concept;

    SELECT uuid() into @uuid;
    INSERT INTO concept_name (concept_id, name, locale, locale_preferred, creator, date_created, concept_name_type, uuid)
      values (new_concept_id, concept_short_name, 'en', 0, 1, now(), 'SHORT', @uuid);
    SELECT MAX(concept_name_id) INTO concept_name_short_id FROM concept_name;

    SELECT uuid() into @uuid;
    INSERT INTO concept_name (concept_id, name, locale, locale_preferred, creator, date_created, concept_name_type, uuid)
      values (new_concept_id, name_of_concept, 'en', 1, 1, now(), 'FULLY_SPECIFIED', @uuid);
    SELECT MAX(concept_name_id) INTO concept_name_full_id FROM concept_name;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_concept_answer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `add_concept_answer`(concept_id INT,
                              answer_concept_id INT,
                              sort_weight DOUBLE)
BEGIN
	INSERT INTO concept_answer (concept_id, answer_concept, answer_drug, date_created, creator, uuid, sort_weight) values (concept_id, answer_concept_id, null, now(), 1, uuid(), sort_weight);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_concept_description` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `add_concept_description`(concept_id INT,
                              description VARCHAR(250))
BEGIN
	INSERT INTO concept_description(uuid, concept_id, description, locale, creator, date_created) values(uuid(), concept_id, description, 'en', 1, now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_concept_numeric` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `add_concept_numeric`(concept_id INT,
							  low_normal DOUBLE,
							  hi_normal DOUBLE,
							  units VARCHAR(50))
BEGIN
  INSERT INTO concept_numeric (concept_id, low_normal, hi_normal, units) values (concept_id, low_normal, hi_normal, units);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_concept_reference_map` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `add_concept_reference_map`(concept_id INT,
							  concept_source_id INT,
							  reference_term VARCHAR(255),
                              reference_type_id INT)
BEGIN
  DECLARE reference_term_id INT;

    INSERT INTO concept_reference_term (concept_source_id,code,creator,date_created,uuid)
    VALUES (concept_source_id,reference_term,1,now(),uuid());
    SELECT MAX(concept_reference_term_id) INTO reference_term_id FROM concept_reference_term;

  INSERT INTO concept_reference_map(concept_reference_term_id,concept_map_type_id,creator,date_created,concept_id,uuid)
  VALUES(reference_term_id, reference_type_id, 1, now(), concept_id, uuid());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_concept_set_members` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `add_concept_set_members`(set_concept_id INT,
                              member_concept_id INT,weight INT)
BEGIN
	INSERT INTO concept_set (concept_id, concept_set,sort_weight,creator,date_created,uuid)
	values (member_concept_id, set_concept_id,weight,1, now(),uuid());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_concept` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `delete_concept`(name_concept VARCHAR(255))
BEGIN
            DECLARE conceptId INT default 0;
                select concept_id INTO conceptId from concept_name where name = name_concept and locale_preferred = 1;
                delete from concept_set where concept_set = conceptId;
                delete from concept_set where concept_id = conceptId;
                delete from concept_name where concept_id = conceptId;
                delete from concept_numeric where concept_id = conceptId;
                delete from concept_answer where concept_id = conceptId;
                delete from concept_answer where answer_concept = conceptId;
                delete from concept_reference_map where concept_id = conceptId;
                delete from concept where concept_id = conceptId;
            END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `introduce_new_address_level` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `introduce_new_address_level`(parent_field_name VARCHAR(160), new_field_name VARCHAR(160), new_field_address_field_name VARCHAR(160))
introduce_new_address_level_proc: BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE parent_field_level_id INT;
  DECLARE parent_field_entry_id INT;
  DECLARE new_field_level_id INT;
  DECLARE new_field_entry_id INT;
  DECLARE number_children_fields_for_parent_field INT;
  DECLARE parent_field_entries_cursor CURSOR FOR SELECT id from parent_field_ids;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  SELECT address_hierarchy_level_id INTO parent_field_level_id from address_hierarchy_level where name = parent_field_name;
  INSERT INTO address_hierarchy_level(name, address_field, uuid, required) values(new_field_name, new_field_address_field_name, UUID(), false);

  select COUNT(*) INTO number_children_fields_for_parent_field from address_hierarchy_level where parent_level_id = parent_field_level_id;

  SELECT address_hierarchy_level_id INTO new_field_level_id from address_hierarchy_level where name = new_field_name;
  UPDATE address_hierarchy_level set parent_level_id = new_field_level_id where parent_level_id = parent_field_level_id;
  UPDATE address_hierarchy_level set parent_level_id = parent_field_level_id where name = new_field_name;

  
  IF (number_children_fields_for_parent_field = 0)THEN
	LEAVE introduce_new_address_level_proc;
  END IF;

  
  CREATE TEMPORARY TABLE parent_field_ids(id INT); 
  INSERT INTO parent_field_ids SELECT address_hierarchy_entry_id from address_hierarchy_entry where level_id = parent_field_level_id;
  
  OPEN parent_field_entries_cursor;
  read_loop: LOOP
    FETCH parent_field_entries_cursor INTO parent_field_entry_id;
	IF done THEN
      LEAVE read_loop;
    END IF;
    INSERT INTO address_hierarchy_entry (name, level_id, parent_id, uuid) VALUES (NULL, new_field_level_id, parent_field_entry_id, UUID());
	SET new_field_entry_id = LAST_INSERT_ID();
	UPDATE address_hierarchy_entry SET parent_id = new_field_entry_id where parent_id = parent_field_entry_id and level_id != new_field_level_id;
  END LOOP;
  CLOSE parent_field_entries_cursor;
  DROP TABLE parent_field_ids;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `set_value_as_concept_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`openmrs-user`@`localhost` PROCEDURE `set_value_as_concept_id`(person_attribute_type_name VARCHAR(255))
BEGIN
  DECLARE c_id INT;
  DECLARE pa_id INT;
  DECLARE c_name VARCHAR(255);
  DECLARE val VARCHAR(255);
  DECLARE done INT DEFAULT FALSE;
  DECLARE cur1 CURSOR FOR SELECT person_attribute_id, value FROM person_attribute WHERE person_attribute_type_id IN
    (SELECT person_attribute_type_id from person_attribute_type where name = person_attribute_type_name) and value != '';

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  CREATE TEMPORARY TABLE answer_concept_ids (id INT); 

  INSERT INTO answer_concept_ids SELECT answer_concept FROM concept_answer
     WHERE concept_id IN (SELECT BINARY foreign_key FROM person_attribute_type WHERE name = person_attribute_type_name);
  
  OPEN cur1;
  REPEAT
    FETCH cur1 INTO pa_id, val;
      SELECT concept_id INTO c_id FROM concept_name 
           WHERE lower(name) = lower(val) AND concept_name_type = 'FULLY_SPECIFIED' 
           AND concept_id IN (SELECT id FROM answer_concept_ids);
      UPDATE person_attribute set value = c_id where person_attribute_id = pa_id;
  UNTIL done END REPEAT;
 CLOSE cur1;
 DROP TABLE answer_concept_ids;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `concept_reference_term_map_view`
--

/*!50001 DROP VIEW IF EXISTS `concept_reference_term_map_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `concept_reference_term_map_view` AS select `concept_reference_map`.`concept_id` AS `concept_id`,`concept_map_type`.`name` AS `concept_map_type_name`,`concept_reference_term`.`code` AS `code`,`concept_reference_term`.`name` AS `concept_reference_term_name`,`concept_reference_source`.`name` AS `concept_reference_source_name` from (((`concept_reference_term` join `concept_reference_map` on((`concept_reference_map`.`concept_reference_term_id` = `concept_reference_term`.`concept_reference_term_id`))) join `concept_map_type` on((`concept_reference_map`.`concept_map_type_id` = `concept_map_type`.`concept_map_type_id`))) join `concept_reference_source` on((`concept_reference_source`.`concept_source_id` = `concept_reference_term`.`concept_source_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `concept_view`
--

/*!50001 DROP VIEW IF EXISTS `concept_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `concept_view` AS select `concept`.`concept_id` AS `concept_id`,`concept_full_name`.`name` AS `concept_full_name`,`concept_short_name`.`name` AS `concept_short_name`,`concept_class`.`name` AS `concept_class_name`,`concept_datatype`.`name` AS `concept_datatype_name`,`concept`.`retired` AS `retired`,`concept_description`.`description` AS `description`,`concept`.`date_created` AS `date_created` from (((((`concept` left join `concept_name` `concept_full_name` on(((`concept_full_name`.`concept_id` = `concept`.`concept_id`) and (`concept_full_name`.`concept_name_type` = 'FULLY_SPECIFIED') and (`concept_full_name`.`locale` = 'en') and (`concept_full_name`.`voided` = 0)))) left join `concept_name` `concept_short_name` on(((`concept_short_name`.`concept_id` = `concept`.`concept_id`) and (`concept_short_name`.`concept_name_type` = 'SHORT') and (`concept_short_name`.`locale` = 'en') and (`concept_short_name`.`voided` = 0)))) left join `concept_class` on((`concept_class`.`concept_class_id` = `concept`.`class_id`))) left join `concept_datatype` on((`concept_datatype`.`concept_datatype_id` = `concept`.`datatype_id`))) left join `concept_description` on((`concept_description`.`concept_id` = `concept`.`concept_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `diagnosis_concept_view`
--

/*!50001 DROP VIEW IF EXISTS `diagnosis_concept_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `diagnosis_concept_view` AS select `concept_view`.`concept_id` AS `concept_id`,`concept_view`.`concept_full_name` AS `concept_full_name`,`concept_view`.`concept_short_name` AS `concept_short_name`,`concept_view`.`concept_class_name` AS `concept_class_name`,`concept_view`.`concept_datatype_name` AS `concept_datatype_name`,`concept_view`.`retired` AS `retired`,`concept_view`.`description` AS `description`,`concept_view`.`date_created` AS `date_created`,`concept_reference_term_map_view`.`code` AS `icd10_code` from (`concept_view` left join `concept_reference_term_map_view` on(((`concept_reference_term_map_view`.`concept_id` = `concept_view`.`concept_id`) and (`concept_reference_term_map_view`.`concept_reference_source_name` = 'ICD-10-WHO') and (`concept_reference_term_map_view`.`concept_map_type_name` = 'SAME-AS')))) where (`concept_view`.`concept_class_name` = 'Diagnosis') */;
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

-- Dump completed on 2017-10-31 11:55:55
