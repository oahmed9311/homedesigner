-- MySQL dump 10.13  Distrib 5.7.29, for Linux (x86_64)
--
-- Host: localhost    Database: homedesigner
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Current Database: `homedesigner`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `homedesigner` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `homedesigner`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add snapshot',7,'add_snapshot'),(26,'Can change snapshot',7,'change_snapshot'),(27,'Can delete snapshot',7,'delete_snapshot'),(28,'Can view snapshot',7,'view_snapshot'),(29,'Can add project',8,'add_project'),(30,'Can change project',8,'change_project'),(31,'Can delete project',8,'delete_project'),(32,'Can view project',8,'view_project');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$mACRQ9C9R3ia$oE060PEoYIwMOU1BjAReWezSjXz+r+SjX8MD8yR5euk=','2019-05-11 00:45:57.313155',1,'root','','','omar@venudio.com',1,1,'2019-04-12 11:28:07.967891'),(2,'pbkdf2_sha256$150000$aFFAAuBAzN9m$czvBeVVROJJzqDiMw72zGEVB8zWHnsiJtgelJcDIYnk=','2019-09-14 14:32:41.487584',0,'omar','Omar','Ahmed','omar.ahmed.cmp@gmail.com',0,1,'2019-04-12 11:41:04.434440'),(3,'pbkdf2_sha256$150000$bsEbx1nqkunI$0ekNpgJH8IMwInRdicceNG3GKVXgIVIuH/yKf71sBgQ=','2019-04-13 11:20:26.969106',0,'omarahmed','omar','ahmed','omar@venudio.com',0,1,'2019-04-13 11:20:26.418563'),(4,'pbkdf2_sha256$150000$WagOQQdPhR7h$tizSVtAC8s1utIW0qPK5MC908LBJGdk9UbkPLkdhGVo=','2020-02-22 17:19:31.288303',1,'OmarElRawy','Omar','Elrawy','omarelrawy@aucegypt.edu',1,1,'2019-04-16 11:22:57.858791'),(5,'pbkdf2_sha256$150000$AAOVQQqUwGyU$6PiBxLQgitPPQpfFI/FbLWByYFEIq651LFczQUMCIcs=','2019-09-28 20:12:25.202839',1,'superomar','omar','ahmed','whatever@gmail.com',0,1,'2019-04-24 18:47:41.291465'),(6,'pbkdf2_sha256$150000$CyJJpIDXTp8k$J/itMKEmaYK5I6uTFLfjhvRRg65tWWWOf/q8d8aHHQA=','2019-09-14 15:54:54.341384',0,'hangozada','hango','zada','hungozada@hotmail.com',0,1,'2019-04-26 18:07:26.745823'),(7,'pbkdf2_sha256$150000$sd4VLCxJBNFb$rSH+CEqV1YS1cM53n/Ic3T6TRHufGi2ePoi1quWvXPc=','2019-09-14 14:50:36.494056',0,'Hango','Mohamed','Abdallah','hango@msn.com',0,1,'2019-09-14 14:45:31.258302');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-05-11 00:47:10.452380','1','Project object (1)',3,'',8,1),(2,'2019-05-11 00:47:17.647985','2','Project object (2)',3,'',8,1),(3,'2019-05-11 00:47:32.820094','3','Project object (3)',3,'',8,1),(4,'2019-05-11 00:47:42.059121','4','Project object (4)',3,'',8,1),(5,'2019-07-03 13:11:15.318916','7','Project object (7)',3,'',8,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'floorplanner','project'),(7,'floorplanner','snapshot'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-04-12 11:23:56.901290'),(2,'auth','0001_initial','2019-04-12 11:23:57.071432'),(3,'admin','0001_initial','2019-04-12 11:23:57.619596'),(4,'admin','0002_logentry_remove_auto_add','2019-04-12 11:23:57.723066'),(5,'admin','0003_logentry_add_action_flag_choices','2019-04-12 11:23:57.740664'),(6,'contenttypes','0002_remove_content_type_name','2019-04-12 11:23:57.867333'),(7,'auth','0002_alter_permission_name_max_length','2019-04-12 11:23:57.884353'),(8,'auth','0003_alter_user_email_max_length','2019-04-12 11:23:57.909511'),(9,'auth','0004_alter_user_username_opts','2019-04-12 11:23:57.926976'),(10,'auth','0005_alter_user_last_login_null','2019-04-12 11:23:57.975954'),(11,'auth','0006_require_contenttypes_0002','2019-04-12 11:23:57.980432'),(12,'auth','0007_alter_validators_add_error_messages','2019-04-12 11:23:57.996422'),(13,'auth','0008_alter_user_username_max_length','2019-04-12 11:23:58.019807'),(14,'auth','0009_alter_user_last_name_max_length','2019-04-12 11:23:58.044468'),(15,'auth','0010_alter_group_name_max_length','2019-04-12 11:23:58.066285'),(16,'auth','0011_update_proxy_permissions','2019-04-12 11:23:58.085971'),(17,'sessions','0001_initial','2019-04-12 11:23:58.113145'),(18,'floorplanner','0001_initial','2019-04-24 18:34:03.974670');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('00ova4aagqvk04vbampcsnw7iokq886f','YWM3ZjRmNmNkMDc5NzlmNjQwNzAzZmQ0ZGFkNWFhZjg5NWU3ZTJjMjp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4ZWE5YzAwN2RiNWUzZDdiMmUwMzE4ZGM3MTZkMjQwYTliODhiZjNiIn0=','2019-04-27 11:20:26.983648'),('0c0y6hujo502nxwtafpihqw7p0uts77i','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-12 09:06:19.868514'),('0cjyp76fj6keedje3t6c0uflvoe0jqco','ZmNlNWMxMzlhZTNjNTE2NWU3ZTkyN2MzZDZlMDQ0MDFlNzExYjZkYzp7Il9hdXRoX3VzZXJfaWQiOiI0OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWQ1ODliOWIyN2E5MmY5MzkzMjlhODM0YmZhYzA1NWQ2OGRkYjgzZiJ9','2019-10-12 19:51:05.018954'),('0dq01k9pyv4uxrffdjn8txnt4ycsqmjs','MjY5OGMyOTQzNGU0MDI0OTBjYTNlOGQyZTBiMjAzZTcxODdkOTZlMzp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNGJiNTY3ODY5Mjg0ZmQ5ZTY1ZWFlMjExMDYxNTQ1YjZmMWVlYzY4ZSJ9','2019-10-12 19:51:05.002520'),('0hlsvm9kw28ggmdq2azj2ob0r1d74dkm','OWQ5MDNkZDIzMDU3YWUwZjIzOGRhM2E3NjlmZTBkYTcwYWYxOGMxMzp7Il9hdXRoX3VzZXJfaWQiOiI2NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTM4NGRlYzM4N2QxMjc2NzViMDA5NTlhZGM0YWMxODU1ZGZiYTJjYSJ9','2019-10-12 20:01:25.632380'),('0p3p9j3h9o9fg5uv80tb1hbjrzj77o0n','Nzc5MzM3MjYwMDJhZTU4ZjI5MWE1ZTA4NTMwMzA0Y2JmMTkyMzlmYzp7Il9hdXRoX3VzZXJfaWQiOiI2MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMzliNmQxOWUxZTJlNDRjNTlmY2JlOTRkMTI2ZGRkMGQ4NTk3ODAwOSJ9','2019-10-12 20:01:20.476108'),('138yqe1tm5og4lgooxyzyca0781i9dk6','OTFhMzIxNDEzZmRkMTNkZTIxMTdhZDViM2FmNjQ1MmI5OWI4NTNmZjp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNjEzNjNmZjcxNzIzZjBjODJmNjJkMTNkZmU1NDAwMTQwNzM2ZmFmIn0=','2019-09-28 15:54:54.344938'),('1guzkt7m03nlxwhu0snizv81gwzoy4cl','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-07-08 13:38:16.479918'),('2bqj5twnv9s4u85oq4a5ioofqxlmbtem','ZDRjNjEyYzVlZTlkOGU5NWUxZjllOTUyZGRmYmYyMTM5ZWM5ZmJhNTp7Il9hdXRoX3VzZXJfaWQiOiI3NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTUxN2E3NDA1MzZmMGYwMjYxNzFiMDAyMjI0YmZiZGMyNzg1Nzk2OCJ9','2019-10-12 20:05:50.084802'),('2eh12km0jlnqdyrf90rp97j9fgo054cv','ODBhNTlkZjUyZjg3M2U1YjA5ZjMwM2JiNTBmODlkM2U0ZDdmNTUwYjp7Il9hdXRoX3VzZXJfaWQiOiIzNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZmE2M2E1MDgxMjhiN2U2MDIwMDY4ZDM3Mzc3YWI0ZWViYjZmMzhhYyJ9','2019-09-28 16:53:53.998910'),('2ov7ql9elnz1ak3867l34n4pqa2755uk','MTY3YmE5NTg0N2Y2ZDg2MGE1NTQwMDQ5NGJmOTQyZDdkOGY2OWI0ZTp7Il9hdXRoX3VzZXJfaWQiOiI2MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTFmNWQzZmRhYWYwZmZiYjZiODYyMDMwYzA2ZDNkMDgwYmNjNjIwNyJ9','2019-10-12 20:01:18.717421'),('2zkqh1lzeo3tg7dgulm58tajpnrs36vy','NWFkZDRiYWI1ZDQ4ODQyYTIyNTBiOTQwODhmNmM0NjE0MTI4Y2JlZDp7Il9hdXRoX3VzZXJfaWQiOiI2NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTQwNDA2NGQ5MmJmM2Y3MzQ2M2IxYmZiMWY3Nzk3ZDlkNTA5NmJkYyJ9','2019-10-12 20:05:47.737804'),('4ctsji4mktuzj864obdakwajjovcvd7m','NzUxYzNiYmQ0YTQ1ZDRiNmZlNjFjYTRmNjI0ZmI1ZWI3ZDNjM2U0ODp7Il9hdXRoX3VzZXJfaWQiOiI1NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOThhMjQwMTczNTYyOWU4MzhiZDVjZTgxNmM3ZWExYWM2ZDE2NjQyYSJ9','2019-10-12 19:58:17.000045'),('4k76zol2kd3ro4oixfy2kq41zpgg5z4n','NzdjMTQyMWRkYmY1ZmMzNjE3MDEyMDAxYTU0MjA0NDg0NGM3MTdkZjp7Il9hdXRoX3VzZXJfaWQiOiIyMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmU3ODdkZTdkODcwOTMwMzY0Y2Y4ZmQxMjQwNWY0Y2FhZDlhZDJlNSJ9','2019-09-28 16:25:15.894069'),('57328wjig1taomzmr9tbq48fae804z0g','NTQyYmUyOWNjZTAwYzE2Mjg0ZTVlZDcyODI5NmZiMTRhMmFmMzVmODp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhOGI2MTIyOTNmZmQ3Y2EzMGJmYmRmY2JkOTRhMjlmZTNhMDk3ODNlIn0=','2019-09-28 15:52:53.357144'),('5pd1w2bgfauz5x1pn5qfte0k0qx0bat0','YTFkYzFmY2Y0Y2EyODc4ZWY4ZTY0MDhmMWRlMmE2ZmJkOTgwMzlmYTp7Il9hdXRoX3VzZXJfaWQiOiIyMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWEwMjcwZWI3NGFhZTk3YTc3NWMxZGVjY2M3ZmIzYzE2MWU3ZGE2MyJ9','2019-09-28 16:28:51.661535'),('5qjfj1g5xs6v6sfkr7lxm0cgfvsamgtk','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-11 13:45:41.438877'),('5xapf54j1323v9rjne2tfqacp32zwk2e','NjY0YTg0MDY1ZjZiOGU1NTAyYzNlZWNmNjY2OTZjYTJkZGVhODQ3Njp7Il9hdXRoX3VzZXJfaWQiOiI3MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDQ1MmRlZWMxZGY0YmJhYmYxMDlkNzU1MzQ3NjU4NDA5MGQ2NjJkYyJ9','2019-10-12 20:05:49.923788'),('6fyxyizml4vpqb1cmd9pttxlxsurw5cj','MjI3OGIxNjM5OTVlMjU3ODY5MjZjZWEyMmU2MGYzZmQ0YjVmMmE5NTp7Il9hdXRoX3VzZXJfaWQiOiI1NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZjM5NDkxNjQ2OTg3MDc1NDg1ZmYwMjM4ZmU5NGU2ZDRkOGY4MjI5MiJ9','2019-10-12 19:53:28.443007'),('6tfabkgpeignzkphptnraxqs69hcv31u','ODJhNGZmZjIwZWRiMjM1Y2RhMWQxODk4OTcwZmY1ZDcyNGI0ZGFjYzp7Il9hdXRoX3VzZXJfaWQiOiI3NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmNmZDQzZDFmODViZjAzOTgyMjNhNTRhZWQ0NjNhYzU5ZTk3Y2U4YyJ9','2019-10-12 20:05:50.219126'),('6tm7h7kyuv11qi833xam7ytxkxzhi90e','YTU1Mjk2MWE4ZmFhY2QzYzZmNTFlOTlhNTcyZDllOWM0ODI2NTljMDp7Il9hdXRoX3VzZXJfaWQiOiI0MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMGFiZWQ4MmMyMDdjMmNlZWM1YWMzMTE0ZTFjOTkwZjQ3ODE4MzgwMSJ9','2019-10-12 19:19:31.220636'),('77intf95jwoizpnfxrokucwxx6k2kdb5','ZmYzNDI4YmM3N2RiN2Q1NTUwNjY4OGJiZmVhOTdjM2E0NzQ1NDhlMjp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTc4ZmE1ZDk4MTVjOWQxNDY2YjBhZmM3NTgwZGRjYWMwZTE0NTEzOCJ9','2019-10-12 19:19:26.719488'),('79r8a0fvxwveyl06agiufsei21ckmd0b','NTYxYWY1ZWM3NDdhMmVmMWRmZDNjMGVlMjMxYzg5MGNhM2RhZDk1ZDp7Il9hdXRoX3VzZXJfaWQiOiIxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGExNDM5NjRhNDRhNTE3ZTE2MjUwZmFjNzY3MDZmMmE4OWRlZTdjOSJ9','2019-09-28 16:16:50.733016'),('7uc9mijejcby2hxug1bdkredtpq8serc','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2020-03-07 17:19:31.317039'),('7vi3b39o99apt3x6c6g0e04hvrwlrn6e','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2020-01-28 22:46:24.258864'),('7z7tkxepqxxesjrlofdwnxvx7ug1mvw3','OWVjOTk1NmMwZjAzM2VlMjQyZTBkYjA4MjQ5MDczYjFlYzkwZjI3Mzp7Il9hdXRoX3VzZXJfaWQiOiI1OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNjM0YWM1ZDJlOTBmMDZhMDU4NzgzZjU1YzBhNjY0ODlkOTQ1MDc2MSJ9','2019-10-12 19:58:20.546805'),('88yj9pb2mzqwgxtzdtxskxann8aogtbg','NTI0NjllM2ZkYzg5NDg1ODY2ZDU4NGMzZTFkZjg3NjUxMzljZDQ1Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmZjViNDY2YzdjNDZjN2M1YWI2ZTFmZDZlMWRkOGI1ZGYwOGE4MjliIn0=','2019-04-26 11:41:04.818600'),('8ak0k35oixeemk4q3wha1o5pyj78so1v','NGEwYjE0Yzg2MDhkYjZiNDdlY2YzYjA4NmM0NTExNmQyMzk0MDQxNTp7Il9hdXRoX3VzZXJfaWQiOiIyMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzcxNjNiY2Y4Mzk1NTM3NGU1ZTkyNTg5NzE1Nzg5ZDJkOTliYWY3ZiJ9','2019-09-28 16:24:23.069800'),('8gr4qsvzhqr4uaecu8ohicraqspj8vvy','NDg0NDFkZmQxY2ZiNzMyMTFkMGJhMzNhZGU3NTNjNzcyM2JjOGFkODp7Il9hdXRoX3VzZXJfaWQiOiIyNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDhlODE4OWM2MzMyMWJkMjEwNTM2NzBiYjAwOWRlMDk3YmJiMjg3NSJ9','2019-09-28 16:33:02.022971'),('8ilka85wl3upa7kmz1oscb90r9hi7b54','NjllZGY4NDE2NjJjOTE2OGNkYzk4N2Q4ZTYzNTIxZGNjZDZjZmVmOTp7Il9hdXRoX3VzZXJfaWQiOiI0NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTIzOTM4ZThiOTFhNzc3YjYwMzI5MDlmMzczZDgzNTVkN2UzOGM2NCJ9','2019-10-12 19:19:31.641799'),('8q5f0rg1ca9e2r5qlplrmiaqjiah0dma','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-12 19:38:37.272223'),('8riehmjd3qbgb0r062y2d9hwyo1lteb3','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2019-11-09 18:06:17.139417'),('8zc6mp24nz4wdfplxuwduwk4zb3pnqhp','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-12 19:40:58.716681'),('9pa20go5etot8ulq7n79ek6ktn00fmj1','MWI4ODVjZTkwY2IxYzFmYTk1ODBiYWEwZDA5MjQ4ZWMyYTdkNTUzMDp7Il9hdXRoX3VzZXJfaWQiOiIyNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTAwNjE2M2MzNjQ1MzQzMDQyZjkyMzc0ZjgzMTcwNTI5YjkwMTc2ZCJ9','2019-09-28 16:29:31.030999'),('a4he1bcwjnb3kipymp8scdxdxzq6b21x','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-05-29 18:54:25.739381'),('ajdhap7bihz38d812er45ixai2xer6o7','ZjI0ZTJhYWE0OGM2NjU0YWE2YzhiNDI2ZjZhZmYxMzJkZWUzNTE4ZDp7Il9hdXRoX3VzZXJfaWQiOiIxOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjI1ZDc1ZTVmZWNlN2M3YTRhNWY3MTA1NDVjOTVlOGRjMDY1MTJjNSJ9','2019-09-28 16:21:25.157556'),('btzyq00ufeluq0i0611ry9d31biad35u','NTI0NjllM2ZkYzg5NDg1ODY2ZDU4NGMzZTFkZjg3NjUxMzljZDQ1Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmZjViNDY2YzdjNDZjN2M1YWI2ZTFmZDZlMWRkOGI1ZGYwOGE4MjliIn0=','2019-04-26 14:53:34.400278'),('cb8rjt1mf4lv1vv00ag80n2lkex9rprv','ZDIxZDY3MDgyNzNmN2UxNjNkMDBkZTMwZWI3NzUyZWE4NDMxODBlYjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGQxMmJiNTMzMzQ0MjgwZjFjYTdkNTZiYTVjZTY1YzViZjk5ZDBkMCJ9','2019-09-28 16:05:13.921323'),('cbav32af7tegeea99w775i4q9a24107f','Mzc3MWVmNDRhZjk1OWM0ZGQ2YTVlNzQ0MjAyYTc1Nzk0YmM0NjRhMjp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTA0OTBmYzg3OTNiNmQwNTEwYWRhMDA0MjU2ZDI4OWY1YjNjNTM2NCJ9','2019-09-28 15:59:11.085525'),('cnm6yb0rk4didm5aoppjeq0vjnil6tk4','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-06-24 11:59:32.091164'),('d3sx7vcyjehy6b56caqexw68z5b4ag1n','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-11 12:20:15.719840'),('d6sawq7kca61fuzwtbfe2jqllvfkf7mi','NWM3ZjY5MWNhMTk5N2FlNzBjN2IyOTljY2EwZjIwMmFmMDMwOGU1Mzp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMWEyNmNlZWFhMTc5MjFlZjEwYjRmZmRhNzMyNGJjNzcwOTU3MmY5YSJ9','2019-09-28 16:04:00.661122'),('ddznnr01514um58v59eskz7zvvs4dw6s','NzdhNDBiZDVmYzQzNGY5NDJlMTkwZTJkNDY2YTA1MjNlMzIxODI2YTp7Il9hdXRoX3VzZXJfaWQiOiI3MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjIwMDc1MzI1ZTY4ZDBhY2NmMzU3MThlMDY0N2JlMWIzYWQwOWYwYyJ9','2019-10-12 20:05:50.084128'),('dg4bk5im06xkvl0f5dfii5utn6q5qbr7','ZmM2Y2FiOTk5MTE3OTFhMDY2MjViMDcwY2I1OWFkNmViNTBmM2FkZjp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMTBmZDVjNTk2YTczZjk1YTVhMjYxNTc5MWE0ZDU4MmNjNzgxMjEzNCJ9','2019-09-28 16:11:30.333023'),('dl1rkohx6h75swtpbsz4uf77qe20cqln','NGI5OGYzOGZiZDEyZjQxYmU1Mjk3NTk0NmM5YjQ5NGYwMWUwYjJjNjp7Il9hdXRoX3VzZXJfaWQiOiI1NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZjY1NmQ4YzIxZGQxNzY1NWNkM2E2MWVjYmYxNmMzZjI0OTdmZDBlZSJ9','2019-10-12 19:58:16.871183'),('e4i1y4gsaerxs66ipj9l018b8hs89yek','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-06-26 15:04:25.722798'),('e6jijvmwi5f38cfn82jht8ev71qwo2mx','MGNiNTFjZmNhNTg1MjA3OGE3N2FmMzBhNmM2YTQ5ZDY0OWEwMjVhYjp7Il9hdXRoX3VzZXJfaWQiOiIyOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzdkM2Y2YjBmMzYxOGE5M2Q0MjgzMmRiZmM5NTY1NjMyN2M1YzIxMiJ9','2019-09-28 16:42:16.880096'),('eix4o2h2aiz00nup4iwa17t88kkaxhrk','ZWYwMmY1NjZlYjI3NTUxZTEzNDBlY2E1MjYzZDBiOWE5MmE5ODdiOTp7Il9hdXRoX3VzZXJfaWQiOiIzNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMGQ4OGIyZjE4NGE2ZGY4NDZmOWViMWRlNzRkOGNjY2ZkMjIxZDg2YSJ9','2019-09-28 16:52:48.269528'),('f8pyf77itpg1aj6d9buidf9j0lw4j8qg','MzNiNmQ4OTA5NzZmY2EzNGUxZTlhZGNhZjc1Mjg1NzFmZjdlZGM3NTp7Il9hdXRoX3VzZXJfaWQiOiI0NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZjVjMzc3MzZjODY2MzU5ZDAxZTg3NDUxYjIxYjdkNWEzYTg2MmVkNSJ9','2019-10-12 19:51:05.011842'),('fa9tupbyezpyw2rlhp714s98mc332xfr','NGU4NmEwYjM5ZmY2MGNjNzZlM2JkMmZhZDEwYzEyZmJhY2FlOTJlMzp7Il9hdXRoX3VzZXJfaWQiOiIyOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2NhM2E5ZTAyZjg0YWJmZDcwMDA3N2E3OTg2NDljMDM5MmQwYmQ4NiJ9','2019-09-28 16:42:58.470129'),('fkq3ijc08uv5774vq0wqqij8dwutbnee','M2JiMDQwOTg5NWQzMjAxOTRkNzE0YmMyM2JkNWY0NDdhNjBkZmE4ZDp7Il9hdXRoX3VzZXJfaWQiOiI3NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjMxNTU4ODhiMjIzMDM3YWUxNTVlYjUyZjE3MmZlYTY4YTMzZWQ1MSJ9','2019-10-12 20:05:50.096120'),('g09hjgwxm5vdjhyvhkeobzl0x0pz6lbn','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-11 12:06:23.585332'),('hcwmhd6n1pogwo9578byhebxnaik2igc','ZThkY2E2YzcyZDA3NzU1YTY0NGYyZWU4NmM5YTcyOGNjNDQ0NGQ5NDp7Il9hdXRoX3VzZXJfaWQiOiIzOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTNiMTRiOTM0YTBjZDQwNjA4YzU1MTUwYThkZDVhYzI2NWI2NjRkMCJ9','2019-09-28 16:56:33.723500'),('hdodhzw828a6l4rnh0he42ay4ij7fg0m','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2019-05-19 17:20:35.330989'),('hdr65ibvm8d1nqpf1qubrop811c128j0','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-11 12:23:06.385475'),('hl7irmkp677lmtfmxux9abt5s04hep39','NDM2MDIwZjRiMzRkZjRiZjk1N2QyMzYzNjhmZGQzZmRkYTVhZTlmODp7Il9hdXRoX3VzZXJfaWQiOiI3OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGM3Y2NiZWRiZWI3YmRlZDNhMWJlYjQxYWIwMTAyNTE4NDM0N2ZiNyJ9','2019-10-12 20:05:57.085464'),('ib8zh9vo4b11lui2ogs2ypvvaamo3ngh','NDYyZWVmZDlkM2Y5YjU1NzA1OWNiOWM2YTRiMzJmY2U4YTY2NzEwZjp7Il9hdXRoX3VzZXJfaWQiOiI3MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzczNzZiNWMwZTNkYzk3MGY1MjkyNWI2NDMwOWVkYmJhMzkxMTk0ZiJ9','2019-10-12 20:05:50.015771'),('il57wfchxqzlto4nf647ltwxzcz54fr4','YmRjNDQ4MmFiYzM5YWMzZmI2NTI4YmY3ZDA0MzUzYWM4N2NkNDJiMTp7Il9hdXRoX3VzZXJfaWQiOiI2NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMWMzODE3NTg1NWExMzUyZTY2MGVkNjBmZTgxMjFkNmIwZDUzY2UyMiJ9','2019-10-12 20:05:47.384403'),('ivhimzkm7r63nbccbpza2gy04sngv98v','MGI3ZTVhNjI0ZDBjZmVmNzZkMTgxNDk3NmY4MmI2YTQ2MjQ3NjE0Mjp7Il9hdXRoX3VzZXJfaWQiOiI2NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTg5ZWJmMmM4MGIyNDFjNjczMjRhN2I0YTFkMWYwYzE5MDM2NjhkZiJ9','2019-10-12 20:01:24.096249'),('jfu2evf4qzyzl3qdmud2hjl3h6jbl8tw','OGY0Mjc5MmI0YjBlMDgzMDBlYTRhYWEyNDllZTczYjQzYzU1ZDA0ODp7Il9hdXRoX3VzZXJfaWQiOiIzMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjZjNzI4NGU5MDU5YjY3ZWUzZjdhYjEyZjRmMDI1ODJkYTNlMjc4YyJ9','2019-09-28 16:48:27.913419'),('jh9y3eojdk2mj5bokjosda67huj8260n','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2020-01-10 13:20:12.115301'),('jlbg5tsu71t0depx8516ioficsxh3mvn','N2YxZjFmY2Y2NzY5MzE3NWVhNGI0Y2EwMzk4NjViMGQyYTRlOGM1ODp7Il9hdXRoX3VzZXJfaWQiOiIzNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZmQ1NmNiZTNjYmEzZGVmN2FkZmY3NzJmNjM4NTMzNmM4MTYyYmU3YyJ9','2019-09-28 16:53:27.408337'),('jldktezrrguv2qlfbjxuxuvd6yy3elcw','ZWJhODk3MjdjMTBiOWEwODI5N2Q0MWIwNjBjYjU2ZDU1OGNjMDA2ZDp7Il9hdXRoX3VzZXJfaWQiOiIyNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWVkMzZhMGQ3ZmU1MGYwOWNiMmMzZjUwZDMxNGRkOWRkNjU1OTFhZCJ9','2019-09-28 16:31:33.110244'),('jox73tvvp0x3yk63nh5rxo4rt33ygycc','YjgyMjdhNTczN2Q5Mzc1M2IyMTBiMTEzNzcyYTc2ZWMwZTZjMDQ2ZTp7Il9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0MTJjOWVmNWEwNTM5NDMxMjM2ZWFhMTE4MTdlOWYzMTQ3MGVlYjgyIn0=','2019-09-28 15:57:45.985297'),('khq4255ut59e145sf8dmg8r54i01u3b7','M2NhNWMxMGVhMzJjZjQ1YmYwNTRmMDg3Njg2MjI3Y2Y4MGU4MGQ1ZTp7Il9hdXRoX3VzZXJfaWQiOiIzMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGZmNTViZTNkYTNkYjhhZWRkMTQ5NmNlZTdmMDFhNjFjZGZlNjU5YiJ9','2019-09-28 16:50:46.351553'),('kif6w6r17pw3o1eam6snfnhd3c82jvpc','ZWI0MGNiOTUyNzdiNDE0OWIyMjJlOGIzZmRjNmE2ZDNkNzkyZDQ4OTp7Il9hdXRoX3VzZXJfaWQiOiI1MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzNlNzhmMTEwYTBiYzQ2ZDFhZmEwZmI1ZDQzMWJlMzFlODBlZWI4OCJ9','2019-10-12 19:53:25.475182'),('kwd5l298veizh2w2d8tl2o721q4ivbsy','OTFhMzIxNDEzZmRkMTNkZTIxMTdhZDViM2FmNjQ1MmI5OWI4NTNmZjp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNjEzNjNmZjcxNzIzZjBjODJmNjJkMTNkZmU1NDAwMTQwNzM2ZmFmIn0=','2019-05-10 18:07:27.342415'),('l3rsjzqka83360fyjay3q1lutzsl5yic','Yjg2MzJmNjNjM2RkZDE0NmYxMmU0YTYxMmYwNWJjOTY4ZThjMDgwMDp7Il9hdXRoX3VzZXJfaWQiOiI1MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTM2YTMwZGU0YTUzYWI4MTIzOTQyYjBmODQ0ZmY1MDlkMjE5ZjY2NyJ9','2019-10-12 19:53:26.642696'),('lc6p7azmb3r0s0d44z0y6zht2zxfb8q4','NjQ5MjMzZDlkZTUzZDg5NmNhYTM4YzZkNWU2ZDc4ZmQ0OTA3YjE2MDp7Il9hdXRoX3VzZXJfaWQiOiI1MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNDllMTE5YzhiYjEzOWU1ZTQzNTM4YjhiOGQ2OWEwOTMxMTE2YzI4ZCJ9','2019-10-12 19:52:06.226273'),('m7knwa3p5b2gja0d2a8gsybndg58i8mq','ZTNiNzM4NTU0MjIwMjJiZWJhYWMwZGU5MDkzNmNmYzA5MWIxNmM1ZTp7Il9hdXRoX3VzZXJfaWQiOiI2OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjM3ZDI0MzAzNjU3NzU0YmE0ZDE0ZWJjNmZkNzk5NDg0ZWY3Y2I3NCJ9','2019-10-12 20:05:49.876757'),('mfke6i8s66bpo4c1yd7b0brvaq9aherw','OTg4NGNjYjBhOWE3NTYzZDA0ZWJhYWE1ZTdhM2MxZGQyNjVlMjM2Nzp7Il9hdXRoX3VzZXJfaWQiOiI1OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTczMWViMTE4NmQ5MWRlZGQwNzRlNTVhYjk1ODkyODllYWY1ZGM4MyJ9','2019-10-12 19:58:19.195025'),('naepruub2ijvguhdn5idi1bn85cczls2','NTAxM2JkZDdjZTllNmY3NWI1NGJkMmNhMDI4MTliM2VmY2I4ZGE5ODp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZjA1MzI3MzQ3ZDRlYzgyNGZlODJmNDFjYjMwY2FiODJhZjQ0MWM3NyJ9','2019-09-28 16:16:20.818300'),('o4ewu0l9nsu5ppxxe3d3bp230w4388i2','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-11 12:21:59.909442'),('o682rfxqja5qmwo9zrwqjoyltyjzm728','YzFjMjMzNGQxY2M0NDg2MDkwMmNmODcxZWZjMDg5NWVjZWU0NDBiMTp7Il9hdXRoX3VzZXJfaWQiOiI3MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMGM2YjZhOWY1MGRmOWFmZTM4NDg0NmZhYjZiNGRjMjM0ZDMwYmZhMSJ9','2019-10-12 20:05:49.919399'),('ou03vrmthujt69r2ks6w02bdfb467zx2','OTIzNWFhZjBkOGIzNjY1ZDk0M2JjMzdiZTViN2NmNDNmYzkyOGRiOTp7Il9hdXRoX3VzZXJfaWQiOiIxOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2RmMmZjMjk3Y2E2ZjEzOTQ2MTdiN2VjMWM4OWRkNWI5MTlhMGJhYSJ9','2019-09-28 16:22:34.253569'),('poepkql5oh0uldli3gnhx0167tq44dcr','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2019-07-17 13:09:08.894259'),('pp4t2geh3jy2lpab279vc09s94dbjv70','OTcxODdmYjBhZTM3MGU3M2I3ODY4ODkyN2U3ZDYzNWVmZjdhZWMxYjp7Il9hdXRoX3VzZXJfaWQiOiIyNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzE5ODkzNzM4NGY5ODEzZjE4OGExYmE3OWU1NmJjYzk0YTFkMTk2MiJ9','2019-09-28 16:30:31.501473'),('ruc08q3dyzx4rwtpgvvmezkgwq8nu1wo','ZDM1OWIzNzk1MjhlYjEwMjQ4OTdhNTRjOTEyMzFjMzEwMDM0MzE3Yzp7Il9hdXRoX3VzZXJfaWQiOiI2OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYThiMTJkNTA0ZGNhNzU5YWM5ODFmMTdlOTE3ZTAwOTgxM2E2MDg5MyJ9','2019-10-12 20:05:49.823674'),('s0pxra0vbh72jmoyd1ota4bmy8akqw71','N2M0OWU5YThmZmNhNTVhNTE3YzJmYzhhZDk5N2RmODk3OGI0ZWNiNjp7Il9hdXRoX3VzZXJfaWQiOiI1MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjRhZTcwYTA2ZDk2NTJiZGE2MmM2YmJlZjk2ZDQxMzI5ZjExODdiMiJ9','2019-10-12 19:53:25.061400'),('sejofjwsz0k68f9v8qwe2hten7tqjc2v','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2019-06-11 15:02:32.032223'),('shvzxum2xfr9iye5k9pj1iobft69mr0l','YmZkNDcwOTcwMjVkYWVlNTk2ZTNmZTc2M2Q3YjkxNjY4MTQ1Yzc1Mzp7Il9hdXRoX3VzZXJfaWQiOiIzMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOGY2MzM1NGM1ZTk5MzE1ZTg5NGJiOTYzN2JiNjdmZTUwOWE3ZjNiOSJ9','2019-09-28 16:43:56.855372'),('t2jbu6che25nc3fq75t9km594e6xzdfq','OTcwYzk0NTI1NTE3MzJlN2I3N2RlYTJhNTc1MGY2NGZlMDFmYTZjZDp7Il9hdXRoX3VzZXJfaWQiOiI2MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNjkwM2FlNDdiOTcxNGExNmQ2YjRjY2JlYmExOWYwYzgwODY3NzUwZiJ9','2019-10-12 20:01:23.176509'),('t6zn6l3fmdp24941wvhu9krvd4cs0ywd','YmIyYTk1N2U5MzY0YmU0OTMyMDgyODQ1NDI3YTk2MTBhYWVhNmQ5Nzp7Il9hdXRoX3VzZXJfaWQiOiI3NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNjkyMjBiMGNmNzUwNDE5YjI4MDVhNjBjNGRmOGFmMDlhMWRlMGRjZSJ9','2019-10-12 20:05:50.091128'),('tqgm98hjtyz36mso84c84lg36xmyardq','NTQ0YTMwODZmZDE4ZmQ0ZWE0MWU4YTA0YmU4NGY4NjU5YTcxOTNmYzp7Il9hdXRoX3VzZXJfaWQiOiI1NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMzVlNDAxMTI5MWE4YzhhYjYyYjBmOTk3MjM0ODBmZjJlZTljNGM2ZCJ9','2019-10-12 19:53:28.324140'),('tuqpv9zuvsts2f5y8sg4euorieu7j7hh','NWQwNDI1YjAxNjg4NjY4YzQ5MzhhYTRjZWJjOGY3YmNjNTQwZTRiNjp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMzdlMjNhODQyY2Q5OThkZmU4YTk0NzA3NWYyOWY2MmJhNWI4YWMxZCJ9','2019-10-12 19:19:30.743117'),('uwaqupj2gwy8hkrmpyzu0cxpvlke7wlv','NWU3Y2YzZTdiMDEzYmM2OTQwMTcwNjIxYzA0MmY0ZDI1NTg4M2YyNDp7Il9hdXRoX3VzZXJfaWQiOiI0MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMmMxNmM1ZDkyYThjZTU5NzgxODg3NzE0NGYzZGFjMDA1NmUzNmZlMCJ9','2019-10-12 19:19:26.607136'),('w1owgysdax1j2gkd9zs51mwqqlzrsjl4','Yzc1YzBjMWRiYzc4YWUxY2JmY2JhMzAzZTIxNTRiNTZlYTIxZGZjYTp7Il9hdXRoX3VzZXJfaWQiOiI0OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiN2I0NzIzNTI4NDdjYjE1MjM1ZjhhMDgxMTBiM2NiZTAyMTBiNDgyOCJ9','2019-10-12 19:51:05.026806'),('wdv6m4ewzw0r6bmf210xenha7z18j8zt','YzVlNjhhYTQ0ODJkYzRjZDMwYThkZmM3OWMyMGQxYjExZDM4ZmQxNzp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZmJlN2M5YWYwNGNhZGYzYzczOTQ3MDdkZTc3NzA3YjUyMmE1NWQ1ZCJ9','2019-09-28 16:03:25.887428'),('winp002v0cc8lxjwxt0g4zny7xu0ys4v','MTM2MWY3MTE5NjFmOTZhMjJlYWEwMTVjMGYxOGIyYzU0NGRhMjNlNjp7Il9hdXRoX3VzZXJfaWQiOiIzNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYmM1ODQ2ZmM5MGU5NjE4MDdhMzUwNWZkYjY4MWNmYzdkMDU1NzRlYiJ9','2019-09-28 16:51:56.444385'),('witdunmegcdwswmwujlrzqny1m8wp6ih','Y2NhZTYzMWUwYzMyYWNhOTY4YjEwNWY0Nzg0NTcyODE3YzY2MzA5NDp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTBiMTY2ZjkxOGVjN2QzZWY5NTNmYzhjMjUxNjk2MWQ4NTZiOWY5MyJ9','2019-09-28 16:20:20.721832'),('xf2l5scd0dx7jgpv6ue94hhofzjgtqro','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2019-09-28 15:15:59.402544'),('xgcb35bfskg94su9pnjwlnb7tndm37nb','ODc5ZTA3Y2Y2Y2U4MGFhMjgzZDZhODQwZTRkMDBkYjNhNGU1YTJkOTp7Il9hdXRoX3VzZXJfaWQiOiIyMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDhlNjE2ZjBmYjU1YjAwMWJjNjg0MTgyMjVhMTdmYWRmMDIyYzlhMSJ9','2019-09-28 16:24:44.732327'),('xh687tmma7ss1ksjg2crg395ul8ecli7','ZDk0YTU0ZGJhMjE2NTUyMWY0OGQxMDI1MTZhYTcyZDIwN2I5ZmQ3ZDp7Il9hdXRoX3VzZXJfaWQiOiI0NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiN2ViMWUwMTIxNWJlNWU0NTU0YjY4ZDJmOTBlNGRlZjIxOWQyMDMzZCJ9','2019-10-12 19:51:05.018189'),('xttu86e27zuw7uf0hwz4j4rb937tgd9h','MDYwMmM3MDEyYjNjMzFiZTk2NDQyYTdlMzI3NTU5MjI0MWYyZmE3ZDp7Il9hdXRoX3VzZXJfaWQiOiI3OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmI4MmQ2ZDVmYTNjMGU4MTI2Y2UzMjZkN2MzMjNjOTJhYzc2NDRlYyJ9','2019-10-12 20:05:52.280343'),('xxvzy418hl4klf02hjtljk7gfw4llw2j','ODBhNjViMTJlZjVkOWJmMzQ3YTRkYThlMzkyNjE5M2I5NTYyZDM1Yjp7Il9hdXRoX3VzZXJfaWQiOiIzMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDMxYTdmMDczMTI0ZGFiOTY0ODAwNGM2NTUxZjZiOTEzYTJjYjYzMCJ9','2019-09-28 16:47:00.971455'),('y97g8x66lquvutjcyh43u2nwxr21us9c','ODFkMmZlMjJiNzQ0ZDNiNmQwZGFmZDg1ZTEzOWQ2ZjU2MGRiNDU1ODp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYjkxZTU1NmJjOGM1MDI4YjYwZDliYjZkNTIzNzZjMjc1MmExZjc2In0=','2019-10-11 13:47:52.450716'),('yidey86bxffpd0c7eg3st8c0pgkbimy9','YTM2OTkyNDdlNThkMzhiNDZlNmZiNzJkM2VkZDU2NzQ0NzVjZGIwZDp7Il9hdXRoX3VzZXJfaWQiOiI2MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGUzM2Q5NTgwYWJlZjlmMzg5YjIzYTVhZmFiZjAwZTY1YjY5OWFhMyJ9','2019-10-12 19:58:21.036745'),('zlvuodgey2t2afi6o3uikc1kj2aug5tg','MGUxOTEzNGQxZWRmMzBlODZiM2E1MmIxMTAyMGMzMWE0YmQwMTk5NDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjMyMTE2ZDY4MzFiNjMwNmMxNDZkNmJhYWQwNjZmOTY2OTc2ZjA4In0=','2019-04-30 11:22:58.479219'),('zpwzan5cl4o5uasci9s6j7f3f9emhbeb','Mzg3ZWNkZTY3ODYyZGQ2ODRmYTI4NjRlOTQyZGY3MGQ3ZmQ4YmZjNzp7Il9hdXRoX3VzZXJfaWQiOiIzOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZTk1Zjg5MDZhNmEyNjEzYzBhOGYwODdhMTcyOTE4YWYxODQyZmFmNSJ9','2019-10-12 19:11:19.920780'),('zualxjurvbtl476mz1g93wury2y4v9aq','NTI0NjllM2ZkYzg5NDg1ODY2ZDU4NGMzZTFkZjg3NjUxMzljZDQ1Nzp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmZjViNDY2YzdjNDZjN2M1YWI2ZTFmZDZlMWRkOGI1ZGYwOGE4MjliIn0=','2019-09-28 14:25:54.018976');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floorplanner_project`
--

DROP TABLE IF EXISTS `floorplanner_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floorplanner_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `overall_grade` varchar(2) NOT NULL,
  `orientation_grade` varchar(2) NOT NULL,
  `zoning_grade` varchar(2) NOT NULL,
  `waster_grade` varchar(2) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `floorplanner_project_user_id_2e566d36_fk_auth_user_id` (`user_id`),
  CONSTRAINT `floorplanner_project_user_id_2e566d36_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floorplanner_project`
--

LOCK TABLES `floorplanner_project` WRITE;
/*!40000 ALTER TABLE `floorplanner_project` DISABLE KEYS */;
INSERT INTO `floorplanner_project` VALUES (5,'OE1','A','A','A','A-','2019-05-03 19:25:43.222360',4),(6,'OE2','B','B','B','A-','2019-05-05 13:28:53.998286',4),(8,'OE3','B-','C','B-','A-','2019-05-08 23:17:11.448991',4),(9,'OE4','F','F','B-','C','2019-05-08 23:23:51.769238',4),(10,'OE5','D-','D','B','C-','2019-05-08 23:31:35.425476',4),(11,'Tst_1','B','C','A','A-','2019-05-11 15:41:45.489087',4),(12,'OE6','A','A-','A','A-','2019-05-11 15:47:47.929401',4),(13,'OE7','A-','A-','B','A-','2019-05-11 15:53:03.852962',4),(14,'OE8','C','C-','C','A-','2019-05-11 16:00:17.514926',4),(15,'OE9','D','D-','D','A-','2019-05-11 16:18:44.021533',4),(16,'OE10','F','D-','F','A-','2019-05-11 16:24:25.017649',4),(17,'Tst_2','B','C','A','A-','2019-05-11 16:29:07.063971',4),(18,'OE11','A','A','A','A','2019-05-11 22:27:44.097655',4),(19,'OE12','B','A','B','B','2019-05-11 22:37:02.968457',4),(20,'OE13','B','A-','A','C','2019-05-11 22:43:04.370321',4),(21,'OE14','B','A-','A','D-','2019-05-11 22:54:20.031471',4),(22,'OE15','F','F','D-','F','2019-05-11 23:07:49.231471',4),(23,'Tst_3','B-','C-','A','A','2019-05-11 23:15:11.746330',4),(24,'Tst_4','','','','','2019-05-16 11:20:19.194599',4),(25,'OE_Tst_1','C-','A','A','D','2019-05-28 15:06:38.716132',4),(26,'OE_Tst_2','B','B','B-','C','2019-05-28 15:35:52.913318',4),(27,'OE_Tst_3','C','C','C','A','2019-05-28 15:46:21.665351',4),(28,'OE_Tst_4','F','D','F','B','2019-05-28 15:52:16.424471',4),(29,'OE_Tst_5','F','F','D','F','2019-05-28 15:58:22.665208',4),(30,'Tamer','','','','','2019-06-12 14:28:56.709805',5),(31,'omar','','','','','2019-06-12 15:08:27.065428',5),(32,'My Home Plan','','','','','2019-09-14 14:48:18.690603',7),(33,'p2','C','B','C','C','2019-09-14 15:00:03.232233',7),(34,'1','','','','','2019-09-14 15:57:05.147385',6),(35,'2','F','B','D','A','2019-09-14 15:57:10.611138',6),(37,'2','','','','','2019-09-14 16:09:16.476257',6),(100,'Trial','','','','','2019-10-19 15:40:34.425365',4),(101,'Testcase','','','','','2019-10-26 17:42:15.352151',4),(102,'pasted','','','','','2019-12-27 13:55:13.829275',4),(103,'OE16','A','A','A','A','2020-01-04 08:35:45.225902',4),(104,'OE17','C','C','B-','B-','2020-01-14 22:47:11.481485',4),(105,'OE18','C-','F','B','D','2020-01-14 22:53:02.721813',4),(106,'OE19','C-','D-','B-','A-','2020-01-14 23:06:57.345837',4),(107,'OE20','C-','D-','B','A-','2020-01-14 23:10:15.689894',4),(108,'OE21','D-','D-','A-','F','2020-01-17 21:23:13.881491',4),(109,'OE22','D','D','B','D-','2020-01-17 22:00:19.582415',4),(110,'OE23','C-','C-','A-','D-','2020-01-17 22:05:47.058408',4),(111,'OE24','F','D','C','F','2020-01-17 22:12:09.455425',4),(112,'OE25','D','C','F','C','2020-01-17 22:17:50.751125',4),(113,'OE26','B-','B-','A','A','2020-01-19 22:33:49.809290',4),(114,'OE27','D-','F','C','B','2020-01-19 22:49:41.225227',4),(115,'OE28','F','F','F','D-','2020-01-19 22:53:49.409295',4),(116,'OE29','F','F','A','D-','2020-01-19 22:55:52.610438',4),(117,'OE30','A-','A','A','A-','2020-01-19 22:56:53.385557',4);
/*!40000 ALTER TABLE `floorplanner_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floorplanner_snapshot`
--

DROP TABLE IF EXISTS `floorplanner_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floorplanner_snapshot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `content` longblob NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `floorplanner_snapsho_parent_id_4cdf4287_fk_floorplan` (`parent_id`),
  KEY `floorplanner_snapsho_project_id_436c5a6e_fk_floorplan` (`project_id`),
  CONSTRAINT `floorplanner_snapsho_parent_id_4cdf4287_fk_floorplan` FOREIGN KEY (`parent_id`) REFERENCES `floorplanner_snapshot` (`id`),
  CONSTRAINT `floorplanner_snapsho_project_id_436c5a6e_fk_floorplan` FOREIGN KEY (`project_id`) REFERENCES `floorplanner_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floorplanner_snapshot`
--

LOCK TABLES `floorplanner_snapshot` WRITE;
/*!40000 ALTER TABLE `floorplanner_snapshot` DISABLE KEYS */;
INSERT INTO `floorplanner_snapshot` VALUES (9,'2019-05-03 19:25:43.228907','2019-05-08 22:37:43.316950',_binary 'x^�SAn�0�˞�D�V/\�ʩ���CQj	Xd��(\�﵍�H\�e\�\�\�xo\�բ\�!��A+�\nr8\�)�:�����\�_n\��8�������d@2�x\n\�@�Bl\�&�\�Zk\�]U�}v��0J\�2��̥\�i�#�\�\��\'J-���7R\�fa\�-g>\'�0���\�J)Q�Hh\���:\�d	G�3�\�\�\'R�.8�x,gI�\�3\�\�L}��d!\0?\�β\�R��\�峅�z���fՈ�Ӳ��h�Q��\�\����j:Y{\'쥖\�BB?����Z-�\��>�^q�f\\/+\�\�&龩GI)��n\\9{�\��H�\�^�^%S�+m�T�\��&\�\\',NULL,5),(10,'2019-05-05 13:28:54.004605','2019-05-11 00:38:22.535042',_binary 'x^���n�0�\�\�g&\����\'\�i\�i��C\�P��t�x�%!&��Ԟ��\�\��\�ղ\�!��B+�28\Z\�)�:��3�\�N\�ow\���8������/\�A\�W��	\�B�Bl\�\'zs�u\�]T�}	��\�@I�!�p�)\\\�p%���\\a�d���J,�S߈⻰�\�f2º/�TJ�%�y\�b\�I���G.�Xך\�kT�\�ɯ��\�J\"�)\�\�\�Yck<�x��q�\0)\�\�0gn>�\�]VYs�i�� W�z̕\� �e��u�0yF�BT\�\�\��8b_\�\n[\�\�>&\�9TU\�j9�\�\����)�K\�\�\�n-�]�\�c�D�\\\�&�x��|<����O,g�\�x�G�\�\��1�\�r��',NULL,6),(12,'2019-05-08 23:17:11.455572','2019-05-14 20:27:34.602473',_binary 'x^��An�0E\�2k*\�D\'\�ʪ���CQj	d�6(\�\���)Rۥ��\�y�=hJY���=��U)���C\r�\��f#\�\�p\�\�)�����\�r�KHH\�x�+k�]gh\�\�e��Bk�\�J/�T�D�}<2� \�5�bM!�\�˥c\�\�\r/$��ŕ��E�Z\�J���n�\�\r��\�\�^b�2W�\�	![\�F}*\�{�\\w1q�O�+3�\\\\q�����\'\��v�2eF��+.�\�\Z\��\�c��\�!�+�9�8\�V\�VG\�㴹\�}\�V�5�\�\�j\�`\r�P��6r܇\�)��\�\�\��\�떉���i�\��!Y3\�i�z\����X\'7e}\��\�k\�',NULL,8),(13,'2019-05-08 23:23:51.775263','2019-05-28 15:04:35.418816',_binary 'x^��\�n�0E�e\�T\"\�D_\�U�U6��\�`d��(\�\�kc�yL�\��\�w\�\�\'�o:\�ޟ\��.�\�A+��.�a\��\�x\��\�9���\�\��OR�\"2 �@IY����Q\�.��\�PCJ�c��\���\��+t\n�N[$a�^E�������[O}\�2�\�	.i\�\�PBU�,}\�G�E�P�\�h\���e\�̐\�X6��2%��)���)�B�/�iw�؋`��d9azAE����֥R����%�\�@\�n{C�\�\�\n	�{m5\��)�{���\\d\'��\rd\�]\�&&� �(\�\�9\\\�֭D\�|\�W�\�-�3_\�n�[b�7=t\ZWh�S�N��\�8��N\�L�|ȇ_\0��]',NULL,9),(14,'2019-05-08 23:31:35.429234','2020-01-14 23:15:53.030528',_binary 'x^���n�0�\�\�g&MQ\�\�4��\�\�!e�C�B�\rU���C�AjwB����v\�\\��d\�A�q�F\��p4\�%�\0Z��3���\�_c\�/�\"\�!�\�pF\�[d��\�\�I�P�?����\�ɧ.��y\�;�\�\�#\�6k�\\_*]�\�b�\"��V�#\�\�\�Eer�,K���N�f\�\�\�.&\'�̍ \'�ج��\�u�]\�i*\�K\'nfi\"7B.��HG��\�S�\�B�\�s�U�\�\�^\�_h\�f{�\'\"\�_�\�	#�\r:�{�\�X�Qɳ@�?մ\�v�ؕ�\�\�q9w\�kP�E�\��^}qwI4�J\��f�S�\� \�)m&\�o߅g\�\�Q�E4\ryܞ���w�\�ˆl�-\\��',NULL,10),(15,'2019-05-11 15:41:45.495815','2019-05-11 15:47:16.526682',_binary 'x^�S\�n�0��=S�\0�*���*�^*E�%`�qڢ��\r�-� %\'���3��;t�h{\�?\�Њ��\�x�!�\�\�\�\�N\�\�\�\�\�,�`0\�8�\0I�,o8\�Y)\"P�\��\�\�[yK\�$G&\�βH(\�kT\�Z1e�r���:\�g@�JO\\|�R([\�\�20Q\�Ȩ�\�4�2 I־8bH�hs��\�n�Þ&)_\�!.Nv�\�$�M�٨lR�E�\�Լ5\�dO��\�|�G,+�֕R�䍡����\�p\�\�P�8�Ⱦ\�\�{�1���\�\�\�{�%��Og�,C��\n�d\�j1��7�qk\�r�&+#}\�h\��\r+�]���g�(\�ԺG3�E���=\Z[��=7\�m�b,\�\�ݏ\�',NULL,11),(16,'2019-05-11 15:47:47.932608','2019-05-11 15:52:32.589729',_binary 'x^���n�0�\�\�g&QHQ\�\�4��\�\�!e���t�x�%��U���~���\�8w\�j\���ܡ�M9���C\�\��\�N��)\��#\�7�\�hR\�䑒dC.��<E\Z�y�\�\�\�j����1B<��\�O\�#W8^�F}+304e�M��+O�\�\n\�\���+\�\�u\�k�\\xɉ/p\�I�X\n�1\\\�.���?%\�3��\'\�ʂ\��󬡽A-��r\�\�&E\�8e\�,k�����\�Z�Qϫ\��{e��\�KF�>Y.�VUk\��\���1%~�qoL��L\�\��ɓR�\�=���\�=^\Z^�&j\�4��&\��^\�1|������C��',NULL,12),(17,'2019-05-11 15:53:03.863473','2019-05-11 15:59:59.855897',_binary 'x^�T\�n�0��=S�W��/\�ʩ�*��\�`d��(\�\�\�^�YP��\r;;;;�\�\�լ\�x�C˚\n\n8i\�)�:QW\�~vL}�U?P$q�\0\�1�� \�I���\"���sR�\�\�\�\�jŻ�\�D_�Q�\�e\�\�!Y�\�ynk(2��,���\\�K{��*�x�H\"��,Te�\�_\\Qaܤ\�AW�2�;\"<\�S���\�g\�*\�G��UU%%+W\�%;M��t�Md\�Yt\�\�%�c{Lb;~\�\'�\�+!\�U\�\���\�\�7s�O�犋\n{��t����j��\�\�� \�\�\�\�8ƿ �l����\�K�\��0�le�=�mZ\�{�\�\�nG\�zH\�\�;Y!iCg����O',NULL,13),(18,'2019-05-11 16:00:17.518996','2019-05-11 16:06:16.903056',_binary 'x^��Mn�0�\�2k*�ĭ*N\�U�U6��\�0\�8mQ\�\�k�`�Hl?��<ofx@\��n�\�\�ok(\��S�،7t�=W_��_(\�<���|\��9�ΟPBD\Z�H\��}~���\�U\r\�\�6_\�ypD��|)�/�*CR\��\�(\�\�e�\�?��\�x�ρ��=%TeHj\�+%��\ZI\�>M�=�9JHMj\�\��J]��\�˥�˲��$�\�U�U\��S�R�E(�ٛ-��\�\�A�\�7\�\�i\�&-ſ%�x;��g���\"\�y\�̌�qJ`�]���5\�^@)\�N��\�Bfk�J��\�%b\�\�\�\�\�v\���\�8�?�J��<?�v\�v���J�WN\��	+m\�',NULL,14),(19,'2019-05-11 16:18:44.024944','2019-05-11 16:24:08.210384',_binary 'x^��Mn�0�\�2k*pP\�	���\�b\�P�Z�-��{1\��\�=�\�\��<�)y\�B��W�p��h�\�\�8�l��\ZO�B\Z�0�\�s����M�\�3\�E�� ��\�<W\�[�t�������\�@\�E�nJ~/��\Z%\nM���1Tqd?gY�ON�&\�\�\�dBP%J\�5��];;mk!!��\�kU�U�kP�\�o7:\�\�eδ	F�%S\�5�\�Yr�G�D�\r�t\�g�wC��3��6o�^\��\n)y>��QN˧�[�֐Nkf��WP��V|�\����L̿�\���e��\�%&\�A%\�j���qܻI��\�5��\�Hf%c�dh��>\��\0Ԩ��',NULL,15),(20,'2019-05-11 16:24:25.025829','2019-05-11 16:28:51.397936',_binary 'x^���n�0�\�\�g&1\n\�\�\�4��\�\�!e���t�x��I��Ԟ�~l�\�]-\����� ���b��\�z���\�	�5G�B�\�\�{�\�(P	)\�\�\��5)E\n�y[zh���\�Uu\�W01|\��ĄOS\�״W\'\�\�x>�K5�H\\qC���\\�N\���\�Rstv\�n�\��`dמ_\'D��lބl^��\�\�l\\[~��+�D���lX�\��\�\�������&\�\�=�1�\�^P�C�uBt�Q��\�ȟ�jyz\�y���Zb��\�:�\�*Y�Z,�\�}�j����m�^w�\�<B��m\�}�=KJ!ev�v\�\�\���T�\��8�n3',NULL,16),(21,'2019-05-11 16:29:07.066822','2019-05-11 16:34:15.756753',_binary 'x^�S�n�0���iVU|�NSO�LR��H�QH�����\��\�\�g�<ߡ\�UYC�~�R\�p�0o�\�+e?���Oa\0\rđ۠�M\�0\���.I\0�x�N��]Qd\�g6G\�s\�ڢQ׌\�\�^SS�sD��q���J��Ҷa\�BBSB�p)\�\�r\�\\:\�\�e[�D\"�1đJh2�t��hq˭�n�\�MRSB\��\�\�\���y\�n�t?\�3-�>\��\�\n��>si��\�n\��@4\�͹���\�Vc	qL\�G��U@��Ҫ\�^Ɯ,I>.¥pAz\�\"�>��tp.\�U�\�^%��\�?j�\��(B�H�$֍Hڤ����',NULL,17),(22,'2019-05-11 22:27:44.102049','2019-05-16 14:39:20.282773',_binary 'x^��An�0E\�2k*�`P\�	���ʦb\�P�Z�-��{��M`@\n�H���\�\�\�<�)y\�B����W�p\�\�[4Xv7���M\���c@�Y\�3%�J�5T�]�� ������J4w\�`[�\��l\�FO��d	\�\�!���!\nE�\nE\�?Bu\���Κ\�\�l	\�ڥ�y:���\�4��܋�\�\�:���S0Na�׹SeGx���i�WN>NWC�<g^�P�\r/\"\�G{\�\�+ԙ*\�\�~s�+\�4i���\��W��:�/D9>�\�1��J`\r�y�D�j\0JQԊ�\�\�ⱗM62C�hz\�j\�\�\�\�\���\�\�\�f\�krK�\�L\��\�\�:�k:�8m�׺ޔ�Y�N��',NULL,18),(23,'2019-05-11 22:37:02.976669','2019-05-11 22:41:35.487241',_binary 'x^�TAn�0�˞�D�D/\�ʩ���CQj	Xd�6(\�\��\�![$r{wƳ��CS����\���\nH\�4\0o!\�`\�]\�6B���n�\�\0:HwQ\�s 	�\���\"d(\�\�cP]K-��j�-�0�\�\�[1񑸓\�rs\�飢Xr�x>w�Եt\r\�%DG\��8�\�o7jε\�&r-�\���\�35!\�R\�\0��y�%�.�9���pܳh\��\�\���\�� �hj$�#[�\�͹�\�\Z��p�Ȏ\�w%ī\�/Xg�\����QMn�脭\�kH\�\�M\�\�T����\�\�\�\��sM\�D}s��ƐxV��\�D��\�{�ip��2\r\�?�\���L�B\�b\�\'\���\0>\"�T',NULL,19),(24,'2019-05-11 22:43:04.375109','2019-05-11 22:54:09.056347',_binary 'x^�S\�n�@���Dx)\�z�rʥⰡ(E\"-��(\�\�\�>̆�H\�:\��\�t�h{\�?oЊK9&\�-�\0:l�3�\�N�oS��.\n ߇c�\0���8�%a�	(���k\�rmT\�]e�}Z\�^�\Z\�m\�\����\�$��#\�G�?Q���V�\�t\�˼�to\�2�{���\\���%\�I�ئ�GƜ{e\�\�\�T~:2I�7�\�xe�)�~Bxg�,\�5x:�\�\�\\L}B�h\�)�C8�\��\n�8��Y\�i.s2^��C,�h\�r\�\�4�(\��\�9`_�\Z[\�\�UN,�ib(\�U¾\��\�R\�w����t|�D�̸�ڛ�\�L�H����J�Hsh\�Q�\��[1��',NULL,20),(25,'2019-05-11 22:54:20.037052','2019-05-11 23:07:20.307084',_binary 'x^��An�0E\�2k*CP\�tUe\�M\�¡(�2Nq�@l�aBE�}�ϟ�s��U�\��(s\�p\��K\�X�g�k�����a\0-���\�\�\0K\�J�h\0i\0\n�|3\r�d0\��]�I�e#�]�;C\�ژȴ���%\�QkG\�D��闀\�؜_e��ΕYN|��\ra�����&g��d\�e\�\�hT\��\�\�\�WÒ8q�GvdJ�j s\���m٩#9B�)�\�\�в��\Z:�s\��i�\�Ӗ\���\�\�x:�K\�\�ODe\��Z�\�H-�\�\��\Z�\0Pɼ\�\�|��q�\Zf�\�1\�B��&���7��_\�VQ�\'����\��\��䞤�\�K�;\�q�\�',NULL,21),(26,'2019-05-11 23:07:49.236197','2019-05-11 23:14:51.199964',_binary 'x^��\�n�0E�e\�T\��]UYeSe\�P�Z��\�E��\�\�6�\�J�bt�\�ܹ�Ƀ��u��\�X[SI\'\r�b��\�x\�c\�Ի=�Ee�\����;Z�,�D�\�3H0ʐKDR��e\��Y�ɼ,\�\�\�\�q+#�\�\�\�w\nC�\�%$�ՠ�p��G_ٓ<�\�\�\� �(C֖�J��F(�\�S��I6 �m𙑘\�ky��^Q[\�	F\�\\vRr$��e���`\�\�\�\�\\(�P(D!�i\�\��]�b���8�\�\�|�~D�\���C���vG\�R�J�\��M9-�Y���⢣\�.�߮\�,0	\�\�N�\�;�\�\�m�rߑ��M\��_Awݶ�\�A�Rf�qv\���m\�[)�OPX�_z\�\�]��&��N',NULL,22),(27,'2019-05-11 23:15:11.749513','2019-05-11 23:30:05.514864',_binary 'x^��\�n�0E�e\�T\�A_\�U�U7��\�`d��(\�\�[c�yHl�ם;<��D\�A��F\�%dp�/1DЪ��+��\�k|�cq=d	��hAXwo6H�o�\�\�9�<�\��PB�[�G���\�\�,��2�}\�Vu%\�^\�c$>�\�\"�\�e=%4ʒeySj-\nZ�J\�\�\�\�KJ\�i� \�\�YV\�\�\�N+\�\�f��%p�^%Ӣ�7�f�dٝ(����\'+���\�H\�\�5t\r%4ʒ��1\�X����z�بe\�J\�ntd�\�T�@\�/к?\�N>�\�\�\�\�\\U\'�T\rd\�q�\���,#\�wxk\�	\Z�?\Z�:s\�\�A�<FIVA�{�|#hw��~;ܞWoK���\�:ے\�C>�WT�^',NULL,23),(28,'2019-05-16 11:20:19.200606','2019-05-16 11:20:19.200672','',NULL,24),(29,'2019-05-28 15:06:38.720543','2019-05-28 15:24:08.929747',_binary 'x^�T\�n�0��=S���\"���*�\\*E�%�\�8mQĿ� t@*\���3;�˃ڊ5e\�jX]RF\�x	)�VT�M��-S�\�\�e�0��,N\�!0H��$G�Ƴ\�u����P\�+\�ۻlEW�\�X�\�B\�$6�4A�F��\��b�$<2Kx\"\�\�R�SB��볝k]ڈ\�\'� \�n%�\�;�3�\n�9\�\�ƌH4\�F\�\� �\�v�\n+�\�j\��=Y3OB	�X<XBUJ\�\n�oh��BT��I�D0D�\�V0#�!��G�\�,:��h(�\�\�z6\�BB�Q\�~�\�i\�I~\�\"$]6I\�$L2�U\Zmٿ\�\�t�\�\�\�y���d��|ȇ_YC�`',NULL,25),(30,'2019-05-28 15:35:52.920097','2019-05-28 15:45:50.384141',_binary 'x^��Mn�0�\�2k*�q������X8���A\�i�\"\�^\�`cѲC��\�\�\�~BW����\�	-k*\�ᢄ�\�n8�\��2��GY�\0y��c`���$\�uQE\�)�\�۔\�]هRDn�VY\�E\ne�\�\�\\M�S�SB;\�\n\�\�\�����\�S\�	Q�t˥�v�\��o\�K�\�<��rޒ��=k���`eEFMLg\�ҲU�e6U\�Xle/�7\�u�\�^K\�\�E�=�H\�\�[e�HC�u\��^�`7EV�\'�����\�\�\�Bn�]\�\�P�l��n�S�z�<l�g��c�1�\�l<���$;�8��]��kz\�G\�7�<Z\�m8\Z\�4?:;�b,\�_u4�$',NULL,26),(31,'2019-05-28 15:46:21.669066','2019-05-28 15:52:00.149732',_binary 'x^��An�0E\�2k*��(\�]UYeS�p(J-��\�Eܽ6\�0E�ۇ��?�Oh+\�t�}>�\�u	�4x!�����c\�\��x\�\�\0z\�\�,\0c�ć\�%D�A�D�?�\0�P\�G�L��/-�G�p�ni}/6M_rj\�H��$�TYZ�RJ^�ė��&\�;u\�ߩ@[\�J~����xrt\�\�&�\�O��β\�\n/�?���[���s\�l�0�ĩY�ַJ��&[\�h\�s\�4\�)	\�>k9%\��5\�:\����\��	;�6��\�\�^\�\�\0JQ6�O�\�\�\�dC��h�\�-Tdnx��\�l\��q�W���x~\Z�\�\��\���{����QQ>\�\�/�\�m�',NULL,27),(32,'2019-05-28 15:52:16.427627','2019-05-28 15:57:58.817101',_binary 'x^���n�0�\�\�g&eU\�\�4�\�\�\�!e�C�B�\rU����A\���\�_~\�\�m%�ҏ4�. ��^B�Ū��;l��\Z���4\n\�\0zH�\�X!\�\�\�\�<\\\�U�\0$b�n/�\n)E^�)>\�.)�q�%\�	\�<\\a\�N��\�\�͓�\��+<�Q\�E�\�\�R�,1��bb�+\�㚣+�^9�(S�\�d�\\���+Ƶ32/��\�SYR����	�\�?9\�2�;Q�_\�\�0\�\�Ǚ��~M�\�\��v\��J�\�]�\�\�\�g��\�n�ـ3v�*��t\\�\�=\�8��,\Z%\�9��x\���L��z�3k�\��1�^�v�R\�&ɯ\�J�m\��8\�^\�&B��֮�\r\��\���\�',NULL,28),(33,'2019-05-28 15:58:22.675299','2019-05-28 16:17:35.541016',_binary 'x^��\�n�0E�e\�T���\�_\�U�U7��\�0\�8mQĿ\�6��%�=\���΃��l:hd]���O1D\�b\�\�p:l���_��x\�\�zi\Z�\'�4D\�\��\r�8q�\�h\��m|C}��j\�Ů�_\�s�s��\'����n/���\�u8C�PN�\�\'wd��\�\���Y��L��r�\�V웽\\�IF5 \�m\�Π�7\�er���||\�\���6\�{\ZY�\�d}�D�jkjJ�ea�Z���ǽs�}�N�\r�q�^VEԪl�\�\�u~�N�Nk\�\�qT4O�+\�N�r:�\0G�NS&_�â�f\�[\�\Z\�3\�C>�p�m�',NULL,29),(34,'2019-06-12 14:28:56.717566','2019-06-12 15:07:34.226494',_binary 'x^}��\n\� D�e\�l\�B�z*���J+W�������\�\�\�\�\�̸3�����ϰ�Sh\"8p082ӓ6\�\��\�S#Du\�ı\�\�\�\��\�\�\�[%I>-�\'\�nk�n0A��;\�RƷ�Ҩ��\�JRn%�/>j\"�)i�\�A��ȟ��sdg�\�\��\�bi\�{F:i\r',NULL,30),(35,'2019-06-12 15:06:27.291419','2019-06-12 15:07:35.004447',_binary 'x^��M\n�0�\�2\�\�js����\�\"Pi�	\Z�\"޽1&Y4�B\�\�\�̛yoP�#�\���-0�\r8Q ���\�>\�O[�V\����+�\�\\|I\�K|OL�JC`@\���\�i��A\�\�\�6\�hv���Y~��\�]�c|���\�=Ȩ�����\�A�t	��\�#\�#�#B\�\�8\�W\�¬qZ�f\�W�{\�t\0\�J\����ژ�2\�A',34,30),(36,'2019-06-12 15:08:27.069368','2019-06-12 15:08:27.069419','',NULL,31),(37,'2019-09-14 14:48:18.693839','2019-09-14 14:53:50.243237',_binary 'x^�V*\�I\�+V���V\�K\�MU�R�M\�\�S\0�*\�(\�\�T�\�C\�K2�\n+���t�*��,ju�\�&8��`J`z0E��\�\�(\�\�\��Aܐ[�S�YPZT�_����ݘ昘�\�25�8S�\\�:��$�(1\�6�pJ~~(ckck/�_N',NULL,32),(38,'2019-09-14 14:52:37.126584','2019-09-14 14:52:57.028825',_binary 'x^��\�\n�0�_�\�\�C	�wh\�xT��n�\n�\�kLןn-���;3�u\0S\�u�\�U\nκ�O׉B\0\�>\��w�\�\�<�&\"�T,\�\�$GD\n��-N�N\Z�E�.>FՕma:k�\��yl\�e\�͢�����B!?-(��$�3peG���Ώ\�1Q���B\�E\�\�\�Pū2?\�j㵿撘\�\�u�2\�#Z�{�c:�\0�t��',37,32),(39,'2019-09-14 14:53:25.021148','2019-09-14 14:53:46.042851',_binary 'x^�RAn�0�J�g�P���^Z\�K\��RQj	��q�D\�YB\��\��\�\�xf�`e:��+\�\� \�Ki�\�\r($`����n��\� \�R$p��OF$kH!h�X	:U���6\�S\�=9�]\ra\�|}�\�eYF҄<��X:���heg���l��\�\�q\�e�\�[b�����d(\�2��g5\��\�\�\�\�\�/r|� �x^��v\�k4 Ǜ\�\�W\�tm��\��9�� �\�m>�� \�\�H\�s\Z\��]\�\��\�B\�]\�W�\r�\�\�',38,32),(40,'2019-09-14 14:55:45.133696','2019-09-14 14:55:45.133738',_binary 'x^�V*\�I\�+V���V\�K\�MU�R�M\�\�S\0�*\�(\�\�T�\�C\�K2�\n+���t�*��,ju�\�&8��`J`z0E��\�\�(\�\�\��Aܐ[�S�YPZT�_����ݘ昘�\�25�8S�\\�:��$�(1\�6�pJ~~(ckck/�_N',37,32),(41,'2019-09-14 14:55:50.681669','2019-09-14 14:55:50.681710',_binary 'x^�V*\�I\�+V���V\�K\�MU�R�M\�\�S\0�*\�(\�\�T�\�C\�K2�\n+���t�*��,ju�\�&8��`J`z0E��\�\�(\�\�\��Aܐ[�S�YPZT�_����ݘ昘�\�25�8S�\\�:��$�(1\�6�pJ~~(ckck/�_N',40,32),(42,'2019-09-14 14:56:54.153578','2019-09-14 14:56:54.153621',_binary 'x^�V*\�I\�+V���V\�K\�MU�R�M\�\�S\0�*\�(\�\�T�\�C\�K2�\n+���t�*��,ju�\�&8��`J`z0E��\�\�(\�\�\��Aܐ[�S�YPZT�_����ݘ昘�\�25�8S�\\�:��$�(1\�6�pJ~~(ckck/�_N',41,32),(43,'2019-09-14 15:00:03.235137','2019-09-14 15:11:42.347778',_binary 'x^�T\�n�0��=S��J\��T\�\�K\���(��-���\���R\"�:�\�\�\�>�Д�n!��B-�R8��4�\�\�jzl������4J|:H\�\�\�o\"��(�\�<�Z�\�m\�P�ө�|�78 o�JV�/G�<s\�\��[F�L4;�\��9p\Z�0\�)h�+	\�9b\�\�T�\�\�\�\��e8�{�$\"���y��)-Μ�\�:��\�\�#\�\�\�皫�ə%�$\��j\�>\Z�2�\�Hb\�y^\�3��-\���\�\rٴg-�$���\�G�#l0�8Sh-r\�Q*��F\�.�\�\r�O����\�\�^��j����tv�[(-�ڈ�ީߋ�\�ު_�n��\�0E\�\�У�\�\�<\�DY\�������',NULL,33),(44,'2019-09-14 15:11:44.841008','2019-09-14 15:12:23.727534',_binary 'x^�T\�n�0��=S��J\��T\�\�K\���(��-���\���R\"�:�\�\�\�>�Д�n!��B-�R8��4�\�\�jzl������4J|:H\�\�\�o\"��(�\�<�Z�\�m\�P�ө�|�78 o�JV�/G�<s\�\��[F�L4;�\��9p\Z�0\�)h�+	\�9b\�\�T�\�\�\�\��e8�{�$\"���y��)-Μ�\�:��\�\�#\�\�\�皫�ə%�$\��j\�>\Z�2�\�Hb\�y^\�3��-\���\�\rٴg-�$���\�G�#l0�8Sh-r\�Q*��F\�.�\�\r�O����\�\�^��j����tv�[(-�ڈ�ީߋ�\�ު_�n��\�0E\�\�У�\�\�<\�DY\�������',43,33),(45,'2019-09-14 15:57:05.150590','2019-09-14 15:57:05.150629','',NULL,34),(46,'2019-09-14 15:57:10.614129','2019-09-14 15:57:10.614166','',NULL,35),(48,'2019-09-14 16:09:16.479196','2019-09-14 16:09:16.479234','',NULL,37),(111,'2019-10-19 15:40:34.428245','2019-10-19 15:40:34.428279','',NULL,100),(112,'2019-10-26 17:42:15.355638','2019-10-26 17:42:15.355672','',NULL,101),(113,'2019-12-27 13:55:13.832230','2019-12-27 13:55:32.063077',_binary 'x^��\�n�0E�e\�T\�A_\�U�U7��\�`d��(\�\�[c�yHl�ם;<��D\�A��F\�%dp�/1DЪ��+��\�k|�cq=d	��hAXwo6H�o�\�\�9�<�\��PB�[�G���\�\�,��2�}\�Vu%\�^\�c$>�\�\"�\�e=%4ʒeySj-\nZ�J\�\�\�\�KJ\�i� \�\�YV\�\�\�N+\�\�f��%p�^%Ӣ�7�f�dٝ(����\'+���\�H\�\�5t\r%4ʒ��1\�X����z�بe\�J\�ntd�\�T�@\�/к?\�N>�\�\�\�\�\\U\'�T\rd\�q�\���,#\�wxk\�	\Z�?\Z�:s\�\�A�<FIVA�{�|#hw��~;ܞWoK���\�:ے\�C>�WT�^',NULL,102),(114,'2020-01-04 08:35:45.231935','2020-01-04 08:41:25.619788',_binary 'x^���j�0�\�e\��ڲ�=�=�R<d�l\�H̶�\�wo3F��$~\�?��Or��m�\�Z\�T�\�ـ�\"\��\�?vB��?\�_\��#��d; �K��SPD���ɽ�\�Zv7\�a_�\�4fFi�q&�\�p\�i*\�$C}9a�R\��69g���-g>\'N�Ȁu.�RJ�<\�9\'����@�l#\�O\�\�\��\�C��N\�(^Āլ#��r\�{H���D�p&�\�Lp\�U��}K�|\�BhHd��7儫,Y��\Z��������+k/\�{�%���\�H��̶��Z-�\��1Ͻ\�PBn/\�ۮh����CN��7.�G�\�v$rr��Q�\�/vGT�\�� �X',NULL,103),(115,'2020-01-14 22:47:11.484484','2020-01-14 22:47:32.422320',_binary 'x^���n�0�\�\�g&\����\'\�i\�i��C\�P��t�x�%!&��Ԟ��\�\��\�ղ\�!��B+�28\Z\�)�:��3�\�N\�ow\���8������/\�A\�W��	\�B�Bl\�\'zs�u\�]T�}	��\�@I�!�p�)\\\�p%���\\a�d���J,�S߈⻰�\�f2º/�TJ�%�y\�b\�I���G.�Xך\�kT�\�ɯ��\�J\"�)\�\�\�Yck<�x��q�\0)\�\�0gn>�\�]VYs�i�� W�z̕\� �e��u�0yF�BT\�\�\��8b_\�\n[\�\�>&\�9TU\�j9�\�\����)�K\�\�\�n-�]�\�c�D�\\\�&�x��|<����O,g�\�x�G�\�\��1�\�r��',NULL,104),(116,'2020-01-14 22:53:02.724718','2020-01-14 23:06:19.239623',_binary 'x^���n�0D�e\�T\"ĭ\"���*�\\*E�%�\�8mQĿ�ׄN�h�\�\�\�\�\�ˍ�R\�-��7�eUPJ\�<\�Q�\�\��a#\���\����#\�(=\�}4�}�D�\�P%�\�h]�L\r��|\�ȕ�7}�,v��I\�-��ȁ�iu-�j��\�mއ\�{.\�09����U\�\�̜\�.f\�F2��\n�S-�?s6X��\�\�l�*$�uk�����ceg$8�ژt0�7-��;^oϩ�ֶ0F\�8tXx\��\��\��f\�wh\�Mk3\�۬�n�U��t\�j.\�n��QEm\�tN\�\���_��\�iM\���\'Q\�\��8\rb�i�=q�g\�\Z\�\�1^\�VQ\�kE��Y�\r�۞x',NULL,105),(117,'2020-01-14 23:06:57.353058','2020-01-14 23:09:44.490171',_binary 'x^�S\�n�0��=S�\'������z�rp(J-��\�E��\Z��Ǧj���3;;{��PU\�\�\r*U\�\��/1DPcў\�����\�_]!݈8�R!\�{4C$!I<�\��\�c�|4��\�\��bjlr\�8��Z\�Y@\� Q����Bg�tc\�%�\�\�om[&o\�ݑD�0jBvAUq\���S\�\��qc���\r\�\�6pd\�\�\' ��;\�z\�\�m�	A^\�Gp�\�\"�F���S�dl�a�e� �(8\�Ϝ��hԙo#\�\�\�\r�\�\�\�U�J\n<�\\���OD3qw(l�\�XA\�g\"�X�$�F\�U\�x%\�Eҧx]�߰袿`z����x��>�O��XS$|\�*y��LΈ��~ ő_',NULL,106),(118,'2020-01-14 23:10:15.692560','2020-01-14 23:13:37.928912',_binary 'x^��\�n�0�\�e\�T\"���\'\�ʩ���CQj	X\�8mPĻ�m~6T\�:�����%�H�P�ν�B\0\���vQr�3\�C\Z�a\0-��`P\�iK9$n�sQŜ����1Cu+��7%�)�0^\�\�\�\�#�*SD\Z\�)Ƶ\��\\�_�[�N֠�m)3�uQe�\�;|\�P��ҽ�*�t](\����8��0��*1!�x�l�=�p�\\�\�j�b\\\�w�\�\�\'䭜B�T���s�\�F�\�׾\�^�FT\��~\�Fh�5�\�PE6\�00�J�\�\�:��\�+��\�\�s\�\�z5�\"m���\�/\�C�ݛ캓L�#i��˺\'�o',NULL,107),(119,'2020-01-17 21:23:13.886722','2020-01-17 21:52:20.445695',_binary 'x^�T\�n�0��=S	��\"���*�\\*E�%�\�8mQĿ\�?b�\�:xvfwg�AWӶ���-m*\�ᨀ�\"\�x=\\��\�Q��_�A�fq\�I�Q�d\��#���\"�y�1{����`*��\�LU�t0\�\�a\�\�\"�c\�#\���\�IT��ZJ�\�\�Z\�!_\�\"X\Z#�5!�t\�\�\��;:\�$5��*�,���͵������xsjB:3��4\�B�iι�,�LuB�\�\�\Z���T0�|8�\'\�l��\�q�+)DIu�\�\�\�7�{�\�^/���\rq.\�C�.\�\�{&o!\�\�28\�\0�j%��\�\�\�uI2n�N��-�z���3�,����d#�JOJ�\��i{���(mbo�e\�b,\���%',NULL,108),(120,'2020-01-17 22:00:19.585831','2020-01-17 22:04:23.238934',_binary 'x^�TKn�0�ˬ�\�/Q\�	���ʦb\�P�\"F\�i�\"\�^�=\�΀D�Ϟy��]\�\��\���)!��\�B�\��p\�\�c�{��\�)`�,	\�1��ij�P�) @p\�|h5�^�Z����m�H�\"mk\�$\�;�\�\�!\�\�\�\��BV?���\�35\"6TG�E�\�\�\'���(I,�\�\�9��DY7�GH\�\�v4u\�KB��A�\�#8Y\�t�|y�\�\�hxd�q9b�.$^��O�[�qQ��)_\�#�\�L�\�\�\�6�ZV\�]t�W�\�\�\�B?�\�9�y_Ɋ��\�/7u\���\�V2}\�V�sF0=�\�Ef:*PRt\�d2�\�y�ʤ2\"E�L�Aj\�:\�e\�ɿB�?j\�R>\�\�?Kc�a',NULL,109),(121,'2020-01-17 22:05:47.066951','2020-01-17 22:10:02.275999',_binary 'x^��\�n�0\�\�\�g&Q��\�	v�z\�e\�!e��D	\n\�6T\�\��F�\"\rq���s\�\�7\�\Z\��T�ݨ��J:X\�)��:\�g~v\�|��o*wI\�@\�>��B���\�>H�\�1\"�\�\�\�7p�6FvWݩ������.�PA�\��އ��9����ZkQ!7\�\�t\�J:�C*H���\��dF?.\�7�A3�\�ൡ��Ge9�F�N\�[ʳNx��3G\�L\�,TƬ%���� ����� ��\�}=����\�嬻\n\�y�Fiq��szWJ�\�o\�zi�j�tWi�\�6\�lOJ˺5\���\�i�wIy8\�mIl��\�5�\���\��l�{Ӧ�$�3�VҦ$>1\�\n \�A\��d돔',NULL,110),(122,'2020-01-17 22:12:09.461947','2020-01-17 22:17:14.356226',_binary 'x^�T\�n�0��=ӊ��\"���*�^*E�%\�\"\�E�^�mlXE�\�8xvǳ��C\��\��-�\�P�IO1D\�a3\\\��\���O�@q�#�8�x�B��rs�\"�4e��j|W0\�\r;�z�����I��ԝ!\�E*�WJ|	5yYl\�,�r\�\�!\�b�cQ\�\�=\�J~�I\�$5�}\rf�P$͝1�E���\�|�5Jt7\�aO\�\�$x�,@�D�\�&>{\�tZ\�k�|�qaX̦\�Ȭu^�C���0	\�\�\�*�^;\�[B�\�Y\�W\�R�J�B\��\�\�\�,\'\�\�B.��4F�Rԭ\�\�7�-9\�p��\�<\�\r\�\�)	���{I\�:\�5{�\�/�_�?��X�sV�\�r,\�_���',NULL,111),(123,'2020-01-17 22:17:50.765779','2020-01-17 22:22:51.014799',_binary 'x^�TMo�0�/>3	(E�`���^�R��H@PH��j�}I�͇W�M\\Ћ���l\�]-\��\�;�������b��S�pU\�\�\�G}A�\�qYG\�g��$ǘ,c8�K1o\�\�:G��j^F���\\p\�\�r���)��PE�{���4�C\ZN�&��\�\��\�,���%us��\�n�S}\�*OY\�ur�*�߳��,)V8�\�5c\�\'�(\�\�\� ���sml	�˜��HJ�`G��Fiq\�\� �\�+/y�� �g��7�֢�\�֋7���\�n���F�\n��\�[\�\���Uk\�x\'\�\�*)>ym��\�GI��XKµq�\�,/<&�	\�*o��$z�~1ºw�\�~(�[',NULL,112),(124,'2020-01-19 22:33:49.818301','2020-01-19 22:39:13.661487',_binary 'x^��\�n�0�\�e\�T��Ҋ\'\�\�)���CQj	02N[�\�\�\�k&�\�\r}x<\��z/Ԕ�n)}�P-��R\�\�!��\ZUv\'e6\�|N�~(��0��\�(	�`Av1��p^�U#\�\�JUos\r�:;\Z7�\�\�e��*A2Ը�\rɨZ��Fiq*�ٝ\�9\'6\�\�\���\n	:\�`��y�n\n\0�[�\�%\0��Er\�eU\�\�\�\�\�br|���\�۳\n	&\'r#���v�K\�sr8ވ�/\�\�>\�vٴ�̟m��K`�\�H\�\�\�Z�\�\�h}{\��\0�ɶ\�P͇Rz\�ݫV\Z�jJ�\�`|���,j#\��tp}���\�Ŷ��1�rz\�rb\�\�\�7�x轠\�\�3E��\\O\��\�EY�������',NULL,113),(125,'2020-01-19 22:49:41.231041','2020-01-19 22:53:41.741304',_binary 'x^���n�0�\�\�g61��\�	v�z\�e\�2\�E�B�\rU���%S�r���ۿ�ܠoX7@�q���5p\�\�)�zь\�~�L}����\"\�\�F(�8����d�;C	�Ҥ�@\nѾ\�\Z\Zq>�`�o\�f��+��\�e�X��J�o���o\�\� �YsW	Fƚ�̲S��N�$y�\�I\�\�`%�gUKɪ�x�O��}9\�#�FQ�_\�o\�<1\��C\�<\0�\�;�\�\nG�SK6V\Z-��\�j=%ۛ�\��9,lPB�X�\�$���\���\�E�d�\�H�H2\"C\�\�k�x��t�ߧ\�>A涟\��\�Ӓ\�{B�S\���w?�U�\�s��r�\�\���Ŵ�~�+�A\�ϽA~\Z�p��\�H��\�\�j\�w��S9��G\�',NULL,114),(126,'2020-01-19 22:53:49.412181','2020-01-19 22:53:49.412222','',NULL,115),(127,'2020-01-19 22:55:52.614180','2020-01-19 22:56:34.345798',_binary 'x^�T\�n�0��=S�A_\�S�S.��	02N[�\�5�dBJ�cώwv\�WjJV��|\\�fUN	�\�G\r/�37�\r�_\�_J\�\����$��\�[\"{�D�����z$8�\��J~:u4�\�\�ndU\���\0:Ĳ	ԝ��̅`Y\�\�\�\�U}ݯ!��e!�]9�:-2�\�\� 9�cs����	@}@�\�U�R\�E4�E\�\�*�\�0��c6���\�`f6�@ˤ`$h��\\�3v�Q�\�\�ن��s��,�\�w!q�pƏ�C\�\�Ywg�\�FL\�\���<�r.�4,����,xM\��g�U��\"�%\�\�tt3�!�\�=E22f�F\�mUɒ�E\�Jr�g���{z��\�c\�\�\�\�Ϳ$�}\��uN\�W',NULL,116),(128,'2020-01-19 22:56:53.390018','2020-01-19 23:02:57.607929',_binary 'x^���n�0�\�\�g&Q\�P\�\�4��\�\�!e���t�x��&N\0���~�\�߿�\\��E\�C�v�V4\�p0\�!�:���\�N\�\�o\��8��4�\�\�Dҽ�\�	2��@!6/V���eS�?\�&\�J�\�\�xJ\�N��\�@\�N\rs\�\�7\�Z\�\�:\�y�/\�ٹ8I�Q\��\�;�\�Z�+J-?���\�D(\�\�\r��2g:\'����\��bh.a����\�3��\���Җp¶b��g\�p�\�#�\�\�\�\�$bT\�Kr\�8	u\�y�u�J>S\�ZHH\�\�d\�\Zڟ\�Y\�5*q2\�n�;���\��p\�K-��\��\�{f�T�j��\��ꅯ�RRrWP\�^�4\�U�\�_+Qд^�]W�\� �9&\�\�o5\�o�vP1\��M�)',NULL,117);
/*!40000 ALTER TABLE `floorplanner_snapshot` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-07 14:22:43
