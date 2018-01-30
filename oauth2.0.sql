/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.7.9 : Database - yii2_oauth2
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`oauth2` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

/*Table structure for table `migration` */

DROP TABLE IF EXISTS `migration`;

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `migration` */

insert  into `migration`(`version`,`apply_time`) values ('m000000_000000_base',1516349756),('m140501_075311_add_oauth2_server',1516349946);

/*Table structure for table `oauth_access_tokens` */

DROP TABLE IF EXISTS `oauth_access_tokens`;

CREATE TABLE `oauth_access_tokens` (
  `access_token` varchar(40) NOT NULL,
  `client_id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scope` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`access_token`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `oauth_access_tokens_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_access_tokens` */

insert  into `oauth_access_tokens`(`access_token`,`client_id`,`user_id`,`expires`,`scope`) values ('029d8f59cf2e65ff8ecec4d87e14340ba8e38c4c','testclient',11,'2018-01-30 16:57:18','userinfo'),('0be465148bc4bf093b0c00bda9d0aeb142bfc23f','testclient',11,'2018-01-30 17:32:03','userinfo'),('0ee044d11b9cc12732b9e91be9f674a5fe97622f','testclient',11,'2018-01-30 17:31:18','userinfo'),('122c544f87100771ca590de3fea2b9534db44926','testclient',11,'2018-01-30 16:54:35','userinfo'),('21194b92df18db78f30937929653bc5bc14432e7','testclient',11,'2018-01-30 17:00:17','userinfo'),('318f741e00df0b07807110ca845eeed3a5587369','testclient',11,'2018-01-30 16:57:49','userinfo'),('391d2e42622a9b2171fa876d8dbeb2d49511216a','testclient2',12,'2018-01-30 15:32:38',NULL),('4b109d71f9b920c2dbfb94fa4fc7e3b97fe2f229','testclient',11,'2018-01-30 17:34:07','userinfo'),('56048988090bb57166181aafa5062b8921400b5d','testclient',11,'2018-01-30 16:57:15','userinfo'),('5e4740dd3a53a08bcd218ca8c07162e2942458fc','testclient',11,'2018-01-30 17:01:57','userinfo'),('67355b8df3d328241be29f724819b1fdec997613','testclient',11,'2018-01-30 16:55:33','userinfo'),('6b0531a1597096a97803bc9bf964eeb1e084dda0','testclient',11,'2018-01-30 17:41:23','userinfo'),('6faf68e3f983736c5cf5201a34761c66ebd2bf7a','testclient',11,'2018-01-30 16:57:20','userinfo'),('742752a428236bfeed759e4a0322466b538a2e85','testclient',11,'2018-01-30 16:53:22','userinfo'),('871d594857165f571ceed3da2b70a1f5e2d90a88','testclient',11,'2018-01-30 17:00:21','userinfo'),('876d47ae3aecbca0138f331399cf056666378abc','testclient',12,'2018-01-30 11:44:11',NULL),('9493eb5f3468e8561ae9e1d3dd94bbdf256fbffb','testclient',11,'2018-01-30 17:01:31','userinfo'),('99b020fc3bb38d3c20bd7a3d51c696768833bc77','testclient',11,'2018-01-30 17:34:18','userinfo'),('a3fd2e31ab9dd4e134cc9e9b259f30afd1c228ac','testclient',11,'2018-01-30 17:01:55','userinfo'),('a74edc77510e4cfd606805aa029a88730d501879','testclient',11,'2018-01-30 16:57:51','userinfo'),('a8e2e3bf7d96167a33bf2219c925934a1e001126','testclient2',11,'2018-01-30 11:19:39',NULL),('b02d67c9faf31b68a205ca08c6a70f74f1980db2','testclient',11,'2018-01-30 17:01:32','userinfo'),('ba80699853d22f1a30e97b56936e9bd7dbef646b','testclient',11,'2018-01-30 16:58:00','userinfo'),('bbe2ad05804f786366080ca05d2fa6ebd14c9567','testclient',11,'2018-01-30 16:58:50','userinfo'),('c04dcc1a83c454b220a0bc932e6670bd48cc4b92','testclient',11,'2018-01-30 16:57:02','userinfo'),('c6fb556705523a4837a3ec862c01e77f3d8711e4','testclient',11,'2018-01-30 16:53:25','userinfo'),('d3ab964a3de29ad8080c913401d267c4d5de68a4','testclient',11,'2018-01-30 17:02:09','userinfo'),('d7509d4599d97d9fdbb239d8544ca00fb456c8c7','testclient',11,'2018-01-30 17:31:43','userinfo'),('dccde5d188adfc660af1f6ecdf281fa5a732948d','testclient',11,'2018-01-30 16:53:19','userinfo'),('eb3097d6f4c5a1ec6deb93e841443cb0c26e9f3a','testclient',11,'2018-01-30 17:00:09','userinfo'),('f1fc449743dd94cee8a55311e6ac78a4eb35f97b','testclient',11,'2018-01-30 17:31:22','userinfo'),('f4644ac09e875eade5cccb59bff8489f5647cebe','testclient',11,'2018-01-30 17:01:50','userinfo'),('fc1065ea080c88084545570e0c79e50f27c6cba2','testclient',12,'2018-01-30 16:48:19',NULL),('fdf57ec8ccfe74f197eb5afa94178bb0745916ac','testclient',11,'2018-01-30 17:00:19','userinfo');

/*Table structure for table `oauth_authorization_codes` */

DROP TABLE IF EXISTS `oauth_authorization_codes`;

CREATE TABLE `oauth_authorization_codes` (
  `authorization_code` varchar(40) NOT NULL,
  `client_id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `redirect_uri` varchar(1000) NOT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scope` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`authorization_code`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `oauth_authorization_codes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_authorization_codes` */

insert  into `oauth_authorization_codes`(`authorization_code`,`client_id`,`user_id`,`redirect_uri`,`expires`,`scope`) values ('0eba25ac5bf7015229c40f095b68f4a75be2642c','testclient2',12,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:46:45',NULL),('10458414f0da8688c6e6c510d3ec995c9334bf47','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:16:34',NULL),('155ef863f7bfadc266abbd8ef7e2e9cbec88faf3','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:40:00',NULL),('1588b1af076f07dfbacd46c368d555ae8cf6ec38','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:05:15',NULL),('19b4ea59a6f3143cee42e848dba75ff9372ec06a','testclient2',0,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:15:00',NULL),('327545134f20d99845e0af9fb5e74fa0859670d7','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:38:11',NULL),('36654e7c45fd5a5419fe49b53d7dad1c615ef6d0','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:40:51',NULL),('441931d3d941cec3e795d425af234a4f726bb773','testclient2',12,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 14:59:56',NULL),('4c32bbfd9adfdc275353a51b3c84aff6986032fb','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:13:15',NULL),('53d17fef58a32597f43d3a248e7769ccd843582c','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:16:57',NULL),('705e740984b85077b6778ddc71aed22f5af1dbcc','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:33:59',NULL),('7cdb2986d71b950eb66d4a15b6c66b4f5add13c6','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:38:35',NULL),('8a759e996db9a18762777a66b585444ec785c833','testclient2',12,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:43:58',NULL),('bd5e6386980a55cea59d99ad882264746f7eb7b8','testclient2',11,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 10:41:30',NULL),('d27787128e3bf3d82cd880446a0cab86f1304a9c','testclient',12,'http://www.c.com/public/index.php/Index/Oauth/client','2018-01-30 16:13:59',NULL),('d58f1f2e8f4c32997c6404ef31953b85f5d71447','testclient2',12,'http://www.d.com/public/index.php/Index/Oauth/client','2018-01-30 14:33:24',NULL),('f8420799364ea1d9cf65e159f610bffa42d366ea','testclient',12,'http://www.c.com/public/index.php/Index/Oauth/client','2018-01-30 11:12:00',NULL);

/*Table structure for table `oauth_clients` */

DROP TABLE IF EXISTS `oauth_clients`;

CREATE TABLE `oauth_clients` (
  `client_id` varchar(32) NOT NULL,
  `client_secret` varchar(32) DEFAULT NULL,
  `redirect_uri` varchar(1000) NOT NULL,
  `grant_types` varchar(100) NOT NULL,
  `scope` varchar(2000) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_clients` */

insert  into `oauth_clients`(`client_id`,`client_secret`,`redirect_uri`,`grant_types`,`scope`,`user_id`) values ('testclient','testpass','http://www.c.com/public/index.php/Index/Server/login','client_credentials authorization_code password implicit','userinfo',11),('testclient2','testpass2','http://www.d.com/public/index.php/Index/Oauth/client','client_credentials authorization_code password implicit','userinfo',11);

/*Table structure for table `oauth_jwt` */

DROP TABLE IF EXISTS `oauth_jwt`;

CREATE TABLE `oauth_jwt` (
  `client_id` varchar(32) NOT NULL,
  `subject` varchar(80) DEFAULT NULL,
  `public_key` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_jwt` */

/*Table structure for table `oauth_public_keys` */

DROP TABLE IF EXISTS `oauth_public_keys`;

CREATE TABLE `oauth_public_keys` (
  `client_id` varchar(255) NOT NULL,
  `public_key` varchar(2000) DEFAULT NULL,
  `private_key` varchar(2000) DEFAULT NULL,
  `encryption_algorithm` varchar(100) DEFAULT 'RS256'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_public_keys` */

/*Table structure for table `oauth_refresh_tokens` */

DROP TABLE IF EXISTS `oauth_refresh_tokens`;

CREATE TABLE `oauth_refresh_tokens` (
  `refresh_token` varchar(40) NOT NULL,
  `client_id` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expires` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `scope` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`refresh_token`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `oauth_refresh_tokens_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_refresh_tokens` */

insert  into `oauth_refresh_tokens`(`refresh_token`,`client_id`,`user_id`,`expires`,`scope`) values ('2f54deaf3318a4120abac019caa7f5e059a47862','testclient',12,'2018-02-13 10:44:11',NULL),('40ade33decaf68ca0bfb02c078952a8398995fea','testclient',12,'2018-02-13 15:48:19',NULL),('630561f17100fd97ea8f93384564333aa73fae0d','testclient2',11,'2018-02-13 10:19:39',NULL),('ae43449ac5db40a9a6c58de729fd949e06ffcd89','testclient2',12,'2018-02-13 14:32:38',NULL);

/*Table structure for table `oauth_scopes` */

DROP TABLE IF EXISTS `oauth_scopes`;

CREATE TABLE `oauth_scopes` (
  `scope` varchar(2000) NOT NULL,
  `is_default` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_scopes` */

/*Table structure for table `oauth_users` */

DROP TABLE IF EXISTS `oauth_users`;

CREATE TABLE `oauth_users` (
  `user_id` int(15) unsigned NOT NULL DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(2000) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `oauth_users` */

insert  into `oauth_users`(`user_id`,`username`,`password`,`first_name`,`last_name`) values (11,'username','123456','username','user'),(12,'admin','qq123456','ad','min');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
