# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.21)
# Database: allymatch
# Generation Time: 2018-10-01 23:43:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `category_id`, `title`, `created_at`, `updated_at`)
VALUES
	(1,0,'Electric Motors','2018-10-01 15:05:05','2018-10-01 15:05:05'),
	(2,1,'Bearings','2018-10-01 15:05:42','2018-10-01 15:05:42'),
	(3,1,'Current Collectors','2018-10-01 15:05:57','2018-10-01 15:05:57'),
	(4,1,'Fans and fan impellers','2018-10-01 15:06:09','2018-10-01 15:06:09'),
	(5,1,'Insulators','2018-10-01 15:06:16','2018-10-01 15:06:16'),
	(6,1,'Rotors and Stators','2018-10-01 15:06:31','2018-10-01 15:06:31'),
	(7,2,'Blue Collectors','2018-10-01 15:26:21','2018-10-01 15:26:21'),
	(8,0,'Electric Equiments','2018-10-01 16:07:34','2018-10-01 16:07:34'),
	(12,0,'Electrical Components','2018-10-01 19:30:55','2018-10-01 19:30:55'),
	(13,0,'Laser Technology','2018-10-01 19:32:33','2018-10-01 19:32:33'),
	(15,0,'Process Automation','2018-10-01 19:49:01','2018-10-01 19:49:01'),
	(31,2,'Yellow Collectors','2018-10-01 20:27:31','2018-10-01 20:27:31'),
	(32,2,'Black Collectors','2018-10-01 20:27:39','2018-10-01 20:27:39'),
	(33,2,'White Collectors','2018-10-01 20:27:50','2018-10-01 20:27:50');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(1,'2018_10_01_141447_create_categories_table',1);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
