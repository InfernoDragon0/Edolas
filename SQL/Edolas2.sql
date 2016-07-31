/*
SQLyog Community v12.2.4 (64 bit)
MySQL - 10.1.16-MariaDB : Database - edolas
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`edolas` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `edolas`;

/*Table structure for table `accounts` */

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(13) NOT NULL DEFAULT '',
  `password` varchar(128) NOT NULL DEFAULT '',
  `salt` varchar(32) DEFAULT NULL,
  `2ndpassword` varchar(134) DEFAULT NULL,
  `salt2` varchar(32) DEFAULT NULL,
  `loggedin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastlogin` timestamp NULL DEFAULT NULL,
  `createdat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `birthday` date NOT NULL DEFAULT '0000-00-00',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `banreason` text,
  `gm` tinyint(1) NOT NULL DEFAULT '0',
  `email` tinytext,
  `macs` tinytext,
  `tempban` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `greason` tinyint(4) unsigned DEFAULT NULL,
  `ACash` int(11) NOT NULL DEFAULT '0',
  `mPoints` int(11) NOT NULL DEFAULT '0',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `SessionIP` varchar(64) DEFAULT NULL,
  `points` int(11) NOT NULL DEFAULT '0',
  `vpoints` int(11) NOT NULL DEFAULT '0',
  `dpoints` int(11) NOT NULL DEFAULT '0',
  `epoints` int(11) NOT NULL DEFAULT '0',
  `lastWorld` tinyint(3) DEFAULT NULL,
  `monthvotes` int(11) NOT NULL DEFAULT '0',
  `totalvotes` int(11) NOT NULL DEFAULT '0',
  `lastvote` int(11) NOT NULL DEFAULT '0',
  `lastvote2` int(11) NOT NULL DEFAULT '0',
  `lastlogon` timestamp NULL DEFAULT NULL,
  `lastvoteip` varchar(64) DEFAULT NULL,
  `webadmin` int(1) DEFAULT '0',
  `rebirths` int(11) NOT NULL DEFAULT '0',
  `ip` text,
  `mainchar` int(6) NOT NULL DEFAULT '0',
  `nxCredit` varchar(45) NOT NULL DEFAULT '0',
  `sitelogged` text,
  `nick` varchar(20) DEFAULT NULL,
  `mute` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ranking1` (`id`,`banned`,`gm`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `achievements` */

DROP TABLE IF EXISTS `achievements`;

CREATE TABLE `achievements` (
  `achievementid` int(9) NOT NULL DEFAULT '0',
  `charid` int(9) NOT NULL DEFAULT '0',
  `accountid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`achievementid`,`charid`),
  KEY `achievementid` (`achievementid`),
  KEY `accountid` (`accountid`),
  KEY `charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `adminlog` */

DROP TABLE IF EXISTS `adminlog`;

CREATE TABLE `adminlog` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `command` text NOT NULL,
  `mapid` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `alliances` */

DROP TABLE IF EXISTS `alliances`;

CREATE TABLE `alliances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(13) NOT NULL,
  `leaderid` int(11) NOT NULL,
  `guild1` int(11) NOT NULL,
  `guild2` int(11) NOT NULL,
  `guild3` int(11) NOT NULL DEFAULT '0',
  `guild4` int(11) NOT NULL DEFAULT '0',
  `guild5` int(11) NOT NULL DEFAULT '0',
  `rank1` varchar(13) NOT NULL DEFAULT 'Master',
  `rank2` varchar(13) NOT NULL DEFAULT 'Jr.Master',
  `rank3` varchar(13) NOT NULL DEFAULT 'Member',
  `rank4` varchar(13) NOT NULL DEFAULT 'Member',
  `rank5` varchar(13) NOT NULL DEFAULT 'Member',
  `capacity` int(11) NOT NULL DEFAULT '2',
  `notice` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `id` (`id`),
  KEY `leaderid` (`leaderid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `androids` */

DROP TABLE IF EXISTS `androids`;

CREATE TABLE `androids` (
  `uniqueid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(13) NOT NULL DEFAULT 'Android',
  `skin` int(11) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '0',
  `face` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uniqueid`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=InnoDB AUTO_INCREMENT=2462 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `auth_server_channel_ip` */

DROP TABLE IF EXISTS `auth_server_channel_ip`;

CREATE TABLE `auth_server_channel_ip` (
  `channelconfigid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channelid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` tinytext NOT NULL,
  `value` tinytext NOT NULL,
  PRIMARY KEY (`channelconfigid`),
  KEY `channelid` (`channelid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `battlelog` */

DROP TABLE IF EXISTS `battlelog`;

CREATE TABLE `battlelog` (
  `battlelogid` int(11) NOT NULL AUTO_INCREMENT,
  `accid` int(11) NOT NULL DEFAULT '0',
  `accid_to` int(11) NOT NULL DEFAULT '0',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`battlelogid`),
  KEY `accid` (`accid`),
  CONSTRAINT `battlelog_ibfk_1` FOREIGN KEY (`accid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `bbs_replies` */

DROP TABLE IF EXISTS `bbs_replies`;

CREATE TABLE `bbs_replies` (
  `replyid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `threadid` int(10) unsigned NOT NULL,
  `postercid` int(10) unsigned NOT NULL,
  `timestamp` bigint(20) unsigned NOT NULL,
  `content` varchar(26) NOT NULL DEFAULT '',
  `guildid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`replyid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `bbs_threads` */

DROP TABLE IF EXISTS `bbs_threads`;

CREATE TABLE `bbs_threads` (
  `threadid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `postercid` int(10) unsigned NOT NULL,
  `name` varchar(26) NOT NULL DEFAULT '',
  `timestamp` bigint(20) unsigned NOT NULL,
  `icon` smallint(5) unsigned NOT NULL,
  `startpost` text NOT NULL,
  `guildid` int(10) unsigned NOT NULL,
  `localthreadid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`threadid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `bcomments` */

DROP TABLE IF EXISTS `bcomments`;

CREATE TABLE `bcomments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `bid` int(10) NOT NULL,
  `author` varchar(16) NOT NULL,
  `feedback` int(1) NOT NULL,
  `date` varchar(32) NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `buddies` */

DROP TABLE IF EXISTS `buddies`;

CREATE TABLE `buddies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL,
  `buddyid` int(11) NOT NULL,
  `pending` tinyint(4) NOT NULL DEFAULT '0',
  `groupname` varchar(16) NOT NULL DEFAULT 'ETC',
  PRIMARY KEY (`id`),
  KEY `buddies_ibfk_1` (`characterid`),
  KEY `buddyid` (`buddyid`),
  KEY `id` (`id`),
  CONSTRAINT `buddies_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2767 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `buynx` */

DROP TABLE IF EXISTS `buynx`;

CREATE TABLE `buynx` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meso` int(11) NOT NULL,
  `nx` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cashshop_categories` */

DROP TABLE IF EXISTS `cashshop_categories`;

CREATE TABLE `cashshop_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent` int(11) NOT NULL,
  `flag` int(11) NOT NULL,
  `sold` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `cashshop_items` */

DROP TABLE IF EXISTS `cashshop_items`;

CREATE TABLE `cashshop_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL,
  `subcategory` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sn` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `flag` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `discountPrice` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `expire` int(11) NOT NULL,
  `gender` tinyint(1) NOT NULL DEFAULT '2',
  `likes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1228 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `cashshop_limit_sell` */

DROP TABLE IF EXISTS `cashshop_limit_sell`;

CREATE TABLE `cashshop_limit_sell` (
  `serial` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serial`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `cashshop_menuitems` */

DROP TABLE IF EXISTS `cashshop_menuitems`;

CREATE TABLE `cashshop_menuitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` int(11) NOT NULL,
  `subcategory` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sn` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `flag` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `discountPrice` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `expire` int(11) NOT NULL,
  `gender` tinyint(1) NOT NULL DEFAULT '2',
  `likes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `cashshop_modified_items` */

DROP TABLE IF EXISTS `cashshop_modified_items`;

CREATE TABLE `cashshop_modified_items` (
  `serial` int(11) NOT NULL,
  `discount_price` int(11) NOT NULL DEFAULT '-1',
  `mark` tinyint(1) NOT NULL DEFAULT '-1',
  `showup` tinyint(1) NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  `priority` tinyint(3) NOT NULL DEFAULT '0',
  `package` tinyint(1) NOT NULL DEFAULT '0',
  `period` tinyint(3) NOT NULL DEFAULT '0',
  `gender` tinyint(1) NOT NULL DEFAULT '0',
  `count` tinyint(3) NOT NULL DEFAULT '0',
  `meso` int(11) NOT NULL DEFAULT '0',
  `unk_1` tinyint(1) NOT NULL DEFAULT '0',
  `unk_2` tinyint(1) NOT NULL DEFAULT '0',
  `unk_3` tinyint(1) NOT NULL DEFAULT '0',
  `extra_flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serial`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `character_cards` */

DROP TABLE IF EXISTS `character_cards`;

CREATE TABLE `character_cards` (
  `accid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `worldid` int(11) NOT NULL,
  `characterid` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`accid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `character_slots` */

DROP TABLE IF EXISTS `character_slots`;

CREATE TABLE `character_slots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accid` int(11) NOT NULL DEFAULT '0',
  `worldid` int(11) NOT NULL DEFAULT '0',
  `charslots` int(11) NOT NULL DEFAULT '6',
  PRIMARY KEY (`id`),
  KEY `accid` (`accid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `characters` */

DROP TABLE IF EXISTS `characters`;

CREATE TABLE `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` int(11) NOT NULL DEFAULT '0',
  `world` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(13) NOT NULL DEFAULT '',
  `level` int(3) NOT NULL DEFAULT '0',
  `exp` bigint(11) NOT NULL DEFAULT '0',
  `str` int(5) NOT NULL DEFAULT '0',
  `dex` int(5) NOT NULL DEFAULT '0',
  `luk` int(5) NOT NULL DEFAULT '0',
  `int` int(5) NOT NULL DEFAULT '0',
  `hp` int(5) NOT NULL DEFAULT '0',
  `mp` int(5) NOT NULL DEFAULT '0',
  `maxhp` int(5) NOT NULL DEFAULT '0',
  `maxmp` int(5) NOT NULL DEFAULT '0',
  `meso` bigint(11) NOT NULL DEFAULT '0',
  `hpApUsed` int(5) NOT NULL DEFAULT '0',
  `job` int(5) NOT NULL DEFAULT '0',
  `skincolor` tinyint(1) NOT NULL DEFAULT '0',
  `gender` tinyint(1) NOT NULL DEFAULT '0',
  `fame` int(5) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '0',
  `face` int(11) unsigned NOT NULL DEFAULT '0',
  `faceMarking` int(11) NOT NULL DEFAULT '0',
  `tail` int(11) NOT NULL DEFAULT '0',
  `ears` int(11) NOT NULL DEFAULT '0',
  `ap` int(11) NOT NULL DEFAULT '0',
  `map` int(11) NOT NULL DEFAULT '0',
  `spawnpoint` int(3) NOT NULL DEFAULT '0',
  `gm` int(3) NOT NULL DEFAULT '0',
  `party` int(11) NOT NULL DEFAULT '0',
  `buddyCapacity` int(11) NOT NULL DEFAULT '25',
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `guildid` int(10) unsigned NOT NULL DEFAULT '0',
  `guildrank` tinyint(1) unsigned NOT NULL DEFAULT '5',
  `allianceRank` tinyint(1) unsigned NOT NULL DEFAULT '5',
  `guildContribution` int(11) NOT NULL DEFAULT '0',
  `pets` varchar(13) NOT NULL DEFAULT '-1,-1,-1',
  `sp` varchar(255) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0',
  `hsp` varchar(255) NOT NULL DEFAULT '0,0,0',
  `subcategory` int(11) NOT NULL DEFAULT '0',
  `rank` int(11) NOT NULL DEFAULT '1',
  `rankMove` int(11) NOT NULL DEFAULT '0',
  `jobRank` int(11) NOT NULL DEFAULT '1',
  `jobRankMove` int(11) NOT NULL DEFAULT '0',
  `marriageId` int(11) NOT NULL DEFAULT '0',
  `familyid` int(11) NOT NULL DEFAULT '0',
  `seniorid` int(11) NOT NULL DEFAULT '0',
  `junior1` int(11) NOT NULL DEFAULT '0',
  `junior2` int(11) NOT NULL DEFAULT '0',
  `currentrep` int(11) NOT NULL DEFAULT '0',
  `totalrep` int(11) NOT NULL DEFAULT '0',
  `gachexp` int(11) NOT NULL DEFAULT '0',
  `fatigue` tinyint(4) NOT NULL DEFAULT '0',
  `charm` mediumint(7) NOT NULL DEFAULT '0',
  `craft` mediumint(7) NOT NULL DEFAULT '0',
  `charisma` mediumint(7) NOT NULL DEFAULT '0',
  `will` mediumint(7) NOT NULL DEFAULT '0',
  `sense` mediumint(7) NOT NULL DEFAULT '0',
  `insight` mediumint(7) NOT NULL DEFAULT '0',
  `totalWins` int(11) NOT NULL DEFAULT '0',
  `totalLosses` int(11) NOT NULL DEFAULT '0',
  `pvpExp` int(11) NOT NULL DEFAULT '0',
  `pvpPoints` int(11) NOT NULL DEFAULT '0',
  `rebirths` int(11) NOT NULL DEFAULT '0',
  `prefix` varchar(45) DEFAULT NULL,
  `reborns` int(11) NOT NULL DEFAULT '0',
  `apstorage` int(11) NOT NULL DEFAULT '0',
  `elf` int(11) NOT NULL DEFAULT '0',
  `honourExp` int(11) NOT NULL DEFAULT '0',
  `honourLevel` int(11) NOT NULL DEFAULT '0',
  `friendshippoints` varchar(255) NOT NULL DEFAULT '0,0,0,0',
  `friendshiptoadd` int(11) NOT NULL DEFAULT '0',
  `chatcolour` int(5) NOT NULL DEFAULT '0',
  `starterquest` int(11) NOT NULL DEFAULT '0',
  `starterquestid` int(11) NOT NULL DEFAULT '0',
  `evoentry` int(11) NOT NULL DEFAULT '5',
  `secondHair` int(11) NOT NULL,
  `secondFace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountid` (`accountid`),
  KEY `id` (`id`),
  KEY `guildid` (`guildid`),
  KEY `familyid` (`familyid`),
  KEY `marriageId` (`marriageId`),
  KEY `seniorid` (`seniorid`)
) ENGINE=InnoDB AUTO_INCREMENT=477 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `cheatlog` */

DROP TABLE IF EXISTS `cheatlog`;

CREATE TABLE `cheatlog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) unsigned NOT NULL DEFAULT '0',
  `offense` tinytext NOT NULL,
  `count` int(11) unsigned NOT NULL DEFAULT '0',
  `lastoffensetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `param` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`characterid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `chrimg` */

DROP TABLE IF EXISTS `chrimg`;

CREATE TABLE `chrimg` (
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `compensationlog_confirmed` */

DROP TABLE IF EXISTS `compensationlog_confirmed`;

CREATE TABLE `compensationlog_confirmed` (
  `chrname` varchar(25) NOT NULL DEFAULT '',
  `donor` tinyint(1) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `taken` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`chrname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `coreauras` */

DROP TABLE IF EXISTS `coreauras`;

CREATE TABLE `coreauras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `str` int(11) NOT NULL DEFAULT '0',
  `dex` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `luk` int(11) NOT NULL DEFAULT '0',
  `att` int(11) NOT NULL DEFAULT '0',
  `magic` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL DEFAULT '0',
  `expire` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7276 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `csequipment` */

DROP TABLE IF EXISTS `csequipment`;

CREATE TABLE `csequipment` (
  `inventoryequipmentid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `upgradeslots` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `str` int(11) NOT NULL DEFAULT '0',
  `dex` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `luk` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `watk` int(11) NOT NULL DEFAULT '0',
  `matk` int(11) NOT NULL DEFAULT '0',
  `wdef` int(11) NOT NULL DEFAULT '0',
  `mdef` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `avoid` int(11) NOT NULL DEFAULT '0',
  `hands` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `jump` int(11) NOT NULL DEFAULT '0',
  `ViciousHammer` tinyint(2) NOT NULL DEFAULT '0',
  `itemEXP` int(11) NOT NULL DEFAULT '0',
  `durability` int(11) NOT NULL DEFAULT '-1',
  `enhance` tinyint(3) NOT NULL DEFAULT '0',
  `potential1` int(5) NOT NULL DEFAULT '0',
  `potential2` int(5) NOT NULL DEFAULT '0',
  `potential3` int(5) NOT NULL DEFAULT '0',
  `potential4` int(5) NOT NULL DEFAULT '0',
  `potential5` int(5) NOT NULL DEFAULT '0',
  `potential6` int(5) NOT NULL DEFAULT '0',
  `fusionAnvil` int(11) NOT NULL DEFAULT '0',
  `socket1` int(5) NOT NULL DEFAULT '-1',
  `socket2` int(5) NOT NULL DEFAULT '-1',
  `socket3` int(5) NOT NULL DEFAULT '-1',
  `incSkill` int(11) NOT NULL DEFAULT '-1',
  `charmEXP` int(6) NOT NULL DEFAULT '-1',
  `pvpDamage` int(6) NOT NULL DEFAULT '0',
  `enhanctBuff` int(3) NOT NULL DEFAULT '0',
  `reqLevel` int(3) NOT NULL DEFAULT '0',
  `yggdrasilWisdom` tinyint(2) NOT NULL DEFAULT '0',
  `finalStrike` tinyint(2) NOT NULL DEFAULT '0',
  `bossDamage` int(3) NOT NULL DEFAULT '0',
  `ignorePDR` int(3) NOT NULL DEFAULT '0',
  `totalDamage` int(3) NOT NULL DEFAULT '0',
  `allStat` int(3) NOT NULL DEFAULT '0',
  `karmaCount` int(3) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`inventoryequipmentid`),
  KEY `inventoryitemid` (`inventoryitemid`),
  CONSTRAINT `csequipment_ibfk_1` FOREIGN KEY (`inventoryitemid`) REFERENCES `csitems` (`inventoryitemid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16013 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `csitems` */

DROP TABLE IF EXISTS `csitems`;

CREATE TABLE `csitems` (
  `inventoryitemid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `accountid` int(10) DEFAULT NULL,
  `packageid` int(11) DEFAULT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `inventorytype` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `owner` tinytext,
  `GM_Log` tinytext,
  `uniqueid` int(11) NOT NULL DEFAULT '-1',
  `flag` int(2) NOT NULL DEFAULT '0',
  `expiredate` bigint(20) NOT NULL DEFAULT '-1',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `sender` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`inventoryitemid`),
  KEY `inventoryitems_ibfk_1` (`characterid`),
  KEY `characterid` (`characterid`),
  KEY `inventorytype` (`inventorytype`),
  KEY `accountid` (`accountid`),
  KEY `packageid` (`packageid`),
  KEY `characterid_2` (`characterid`,`inventorytype`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `dojo_ranks` */

DROP TABLE IF EXISTS `dojo_ranks`;

CREATE TABLE `dojo_ranks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Table structure for table `dojorankings` */

DROP TABLE IF EXISTS `dojorankings`;

CREATE TABLE `dojorankings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` int(11) NOT NULL,
  `name` varchar(13) NOT NULL,
  `time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `donation` */

DROP TABLE IF EXISTS `donation`;

CREATE TABLE `donation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `username` varchar(13) NOT NULL,
  `quantity` smallint(5) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `donorlog` */

DROP TABLE IF EXISTS `donorlog`;

CREATE TABLE `donorlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accname` varchar(25) NOT NULL DEFAULT '',
  `accId` int(11) NOT NULL DEFAULT '0',
  `chrname` varchar(25) NOT NULL DEFAULT '',
  `chrId` int(11) NOT NULL DEFAULT '0',
  `log` varchar(4096) NOT NULL DEFAULT '',
  `time` varchar(25) NOT NULL DEFAULT '',
  `previousPoints` int(11) NOT NULL DEFAULT '0',
  `currentPoints` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `drop_data` */

DROP TABLE IF EXISTS `drop_data`;

CREATE TABLE `drop_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dropperid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `minimum_quantity` int(11) NOT NULL DEFAULT '1',
  `maximum_quantity` int(11) NOT NULL DEFAULT '1',
  `questid` int(11) NOT NULL DEFAULT '0',
  `chance` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mobid` (`dropperid`)
) ENGINE=MyISAM AUTO_INCREMENT=45202 DEFAULT CHARSET=latin1;

/*Table structure for table `drop_data_global` */

DROP TABLE IF EXISTS `drop_data_global`;

CREATE TABLE `drop_data_global` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `continent` int(11) NOT NULL,
  `dropType` tinyint(1) NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  `minimum_quantity` int(11) NOT NULL DEFAULT '1',
  `maximum_quantity` int(11) NOT NULL DEFAULT '1',
  `questid` int(11) NOT NULL DEFAULT '0',
  `chance` int(11) unsigned NOT NULL DEFAULT '0',
  `comments` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobid` (`continent`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `dueyequipment` */

DROP TABLE IF EXISTS `dueyequipment`;

CREATE TABLE `dueyequipment` (
  `inventoryequipmentid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `upgradeslots` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `str` int(11) NOT NULL DEFAULT '0',
  `dex` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `luk` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `watk` int(11) NOT NULL DEFAULT '0',
  `matk` int(11) NOT NULL DEFAULT '0',
  `wdef` int(11) NOT NULL DEFAULT '0',
  `mdef` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `avoid` int(11) NOT NULL DEFAULT '0',
  `hands` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `jump` int(11) NOT NULL DEFAULT '0',
  `ViciousHammer` tinyint(2) NOT NULL DEFAULT '0',
  `itemEXP` int(11) NOT NULL DEFAULT '0',
  `durability` int(11) NOT NULL DEFAULT '-1',
  `enhance` tinyint(3) NOT NULL DEFAULT '0',
  `potential1` int(5) NOT NULL DEFAULT '0',
  `potential2` int(5) NOT NULL DEFAULT '0',
  `potential3` int(5) NOT NULL DEFAULT '0',
  `potential4` int(5) NOT NULL DEFAULT '0',
  `potential5` int(5) NOT NULL DEFAULT '0',
  `potential6` int(5) NOT NULL DEFAULT '0',
  `fusionAnvil` int(11) NOT NULL DEFAULT '0',
  `socket1` int(5) NOT NULL DEFAULT '-1',
  `socket2` int(5) NOT NULL DEFAULT '-1',
  `socket3` int(5) NOT NULL DEFAULT '-1',
  `incSkill` int(11) NOT NULL DEFAULT '-1',
  `charmEXP` smallint(6) NOT NULL DEFAULT '-1',
  `pvpDamage` smallint(6) NOT NULL DEFAULT '0',
  `enhanctBuff` int(3) NOT NULL DEFAULT '0',
  `reqLevel` int(3) NOT NULL DEFAULT '0',
  `yggdrasilWisdom` tinyint(2) NOT NULL DEFAULT '0',
  `finalStrike` tinyint(2) NOT NULL DEFAULT '0',
  `bossDamage` int(3) NOT NULL DEFAULT '0',
  `ignorePDR` int(3) NOT NULL DEFAULT '0',
  `totalDamage` int(3) NOT NULL DEFAULT '0',
  `allStat` int(3) NOT NULL DEFAULT '0',
  `karmaCount` int(3) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`inventoryequipmentid`),
  KEY `inventoryitemid` (`inventoryitemid`),
  CONSTRAINT `dueyequipment_ibfk_1` FOREIGN KEY (`inventoryitemid`) REFERENCES `dueyitems` (`inventoryitemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `dueyitems` */

DROP TABLE IF EXISTS `dueyitems`;

CREATE TABLE `dueyitems` (
  `inventoryitemid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `accountid` int(10) DEFAULT NULL,
  `packageid` int(11) DEFAULT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `inventorytype` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `owner` tinytext,
  `GM_Log` tinytext,
  `uniqueid` int(11) NOT NULL DEFAULT '-1',
  `flag` int(2) NOT NULL DEFAULT '0',
  `expiredate` bigint(20) NOT NULL DEFAULT '-1',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `sender` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`inventoryitemid`),
  KEY `inventoryitems_ibfk_1` (`characterid`),
  KEY `characterid` (`characterid`),
  KEY `inventorytype` (`inventorytype`),
  KEY `accountid` (`accountid`),
  KEY `packageid` (`packageid`),
  KEY `characterid_2` (`characterid`,`inventorytype`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `dueypackages` */

DROP TABLE IF EXISTS `dueypackages`;

CREATE TABLE `dueypackages` (
  `PackageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RecieverId` int(10) NOT NULL,
  `SenderName` varchar(13) NOT NULL,
  `Mesos` bigint(20) unsigned DEFAULT '0',
  `TimeStamp` bigint(20) unsigned DEFAULT NULL,
  `Checked` tinyint(1) unsigned DEFAULT '1',
  `Type` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`PackageId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `ecomments` */

DROP TABLE IF EXISTS `ecomments`;

CREATE TABLE `ecomments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `eid` int(10) NOT NULL,
  `author` varchar(16) NOT NULL,
  `feedback` int(1) NOT NULL,
  `date` varchar(32) NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `events` */

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `author` varchar(16) NOT NULL,
  `date` varchar(32) NOT NULL,
  `type` varchar(100) NOT NULL,
  `status` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `views` int(10) NOT NULL DEFAULT '0',
  `locked` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `extendedslots` */

DROP TABLE IF EXISTS `extendedslots`;

CREATE TABLE `extendedslots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `itemId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `famelog` */

DROP TABLE IF EXISTS `famelog`;

CREATE TABLE `famelog` (
  `famelogid` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `characterid_to` int(11) NOT NULL DEFAULT '0',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`famelogid`),
  KEY `characterid` (`characterid`),
  CONSTRAINT `famelog_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `familiars` */

DROP TABLE IF EXISTS `familiars`;

CREATE TABLE `familiars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `familiar` int(11) NOT NULL DEFAULT '0',
  `name` varchar(40) NOT NULL DEFAULT '',
  `fatigue` int(11) NOT NULL DEFAULT '0',
  `expiry` bigint(20) NOT NULL DEFAULT '0',
  `vitality` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6238 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `families` */

DROP TABLE IF EXISTS `families`;

CREATE TABLE `families` (
  `familyid` int(11) NOT NULL AUTO_INCREMENT,
  `leaderid` int(11) NOT NULL DEFAULT '0',
  `notice` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`familyid`),
  KEY `familyid` (`familyid`),
  KEY `leaderid` (`leaderid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `gdcache` */

DROP TABLE IF EXISTS `gdcache`;

CREATE TABLE `gdcache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Table structure for table `gifts` */

DROP TABLE IF EXISTS `gifts`;

CREATE TABLE `gifts` (
  `giftid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recipient` int(11) NOT NULL DEFAULT '0',
  `from` varchar(13) NOT NULL DEFAULT '',
  `message` varchar(255) NOT NULL DEFAULT '',
  `sn` int(11) NOT NULL DEFAULT '0',
  `uniqueid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`giftid`),
  KEY `recipient` (`recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `gmblog` */

DROP TABLE IF EXISTS `gmblog`;

CREATE TABLE `gmblog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `author` varchar(16) NOT NULL,
  `date` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `views` int(10) NOT NULL DEFAULT '0',
  `locked` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `gmlog` */

DROP TABLE IF EXISTS `gmlog`;

CREATE TABLE `gmlog` (
  `gmlogid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `command` text NOT NULL,
  `mapid` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gmlogid`)
) ENGINE=InnoDB AUTO_INCREMENT=37090 DEFAULT CHARSET=latin1;

/*Table structure for table `guilds` */

DROP TABLE IF EXISTS `guilds`;

CREATE TABLE `guilds` (
  `guildid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leader` int(10) unsigned NOT NULL DEFAULT '0',
  `GP` int(11) NOT NULL DEFAULT '0',
  `logo` int(10) unsigned DEFAULT NULL,
  `logoColor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL,
  `rank1title` varchar(45) NOT NULL DEFAULT 'Master',
  `rank2title` varchar(45) NOT NULL DEFAULT 'Jr. Master',
  `rank3title` varchar(45) NOT NULL DEFAULT 'Member',
  `rank4title` varchar(45) NOT NULL DEFAULT 'Member',
  `rank5title` varchar(45) NOT NULL DEFAULT 'Member',
  `capacity` int(10) unsigned NOT NULL DEFAULT '10',
  `logoBG` int(10) unsigned DEFAULT NULL,
  `logoBGColor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `notice` varchar(101) DEFAULT NULL,
  `signature` int(11) NOT NULL DEFAULT '0',
  `alliance` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`),
  UNIQUE KEY `name` (`name`),
  KEY `guildid` (`guildid`),
  KEY `leader` (`leader`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `guildskills` */

DROP TABLE IF EXISTS `guildskills`;

CREATE TABLE `guildskills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guildid` int(11) NOT NULL DEFAULT '0',
  `skillid` int(11) NOT NULL DEFAULT '0',
  `level` smallint(3) NOT NULL DEFAULT '1',
  `timestamp` bigint(20) NOT NULL DEFAULT '0',
  `purchaser` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `hiredmerch` */

DROP TABLE IF EXISTS `hiredmerch`;

CREATE TABLE `hiredmerch` (
  `PackageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(10) unsigned DEFAULT '0',
  `accountid` int(10) unsigned DEFAULT NULL,
  `Mesos` bigint(20) unsigned DEFAULT '0',
  `time` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`PackageId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `hiredmerchequipment` */

DROP TABLE IF EXISTS `hiredmerchequipment`;

CREATE TABLE `hiredmerchequipment` (
  `inventoryequipmentid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `upgradeslots` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `str` int(11) NOT NULL DEFAULT '0',
  `dex` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `luk` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `watk` int(11) NOT NULL DEFAULT '0',
  `matk` int(11) NOT NULL DEFAULT '0',
  `wdef` int(11) NOT NULL DEFAULT '0',
  `mdef` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `avoid` int(11) NOT NULL DEFAULT '0',
  `hands` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `jump` int(11) NOT NULL DEFAULT '0',
  `ViciousHammer` tinyint(2) NOT NULL DEFAULT '0',
  `itemEXP` int(11) NOT NULL DEFAULT '0',
  `durability` int(11) NOT NULL DEFAULT '-1',
  `enhance` tinyint(3) NOT NULL DEFAULT '0',
  `potential1` int(5) NOT NULL DEFAULT '0',
  `potential2` int(5) NOT NULL DEFAULT '0',
  `potential3` int(5) NOT NULL DEFAULT '0',
  `potential4` int(5) NOT NULL DEFAULT '0',
  `potential5` int(5) NOT NULL DEFAULT '0',
  `potential6` int(5) NOT NULL DEFAULT '0',
  `fusionAnvil` int(11) NOT NULL DEFAULT '0',
  `socket1` int(5) NOT NULL DEFAULT '-1',
  `socket2` int(5) NOT NULL DEFAULT '-1',
  `socket3` int(5) NOT NULL DEFAULT '-1',
  `incSkill` int(11) NOT NULL DEFAULT '-1',
  `charmEXP` smallint(6) NOT NULL DEFAULT '-1',
  `pvpDamage` smallint(6) NOT NULL DEFAULT '0',
  `enhanctBuff` int(3) NOT NULL DEFAULT '0',
  `reqLevel` int(3) NOT NULL DEFAULT '0',
  `yggdrasilWisdom` tinyint(2) NOT NULL DEFAULT '0',
  `finalStrike` tinyint(2) NOT NULL DEFAULT '0',
  `bossDamage` int(3) NOT NULL DEFAULT '0',
  `ignorePDR` int(3) NOT NULL DEFAULT '0',
  `totalDamage` int(3) NOT NULL DEFAULT '0',
  `allStat` int(3) NOT NULL DEFAULT '0',
  `karmaCount` int(3) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`inventoryequipmentid`),
  KEY `inventoryitemid` (`inventoryitemid`),
  CONSTRAINT `hiredmerchequipment_ibfk_1` FOREIGN KEY (`inventoryitemid`) REFERENCES `hiredmerchitems` (`inventoryitemid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `hiredmerchitems` */

DROP TABLE IF EXISTS `hiredmerchitems`;

CREATE TABLE `hiredmerchitems` (
  `inventoryitemid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `accountid` int(10) DEFAULT NULL,
  `packageid` int(11) DEFAULT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `inventorytype` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `owner` tinytext,
  `GM_Log` tinytext,
  `uniqueid` int(11) NOT NULL DEFAULT '-1',
  `flag` int(2) NOT NULL DEFAULT '0',
  `expiredate` bigint(20) NOT NULL DEFAULT '-1',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `sender` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`inventoryitemid`),
  KEY `inventoryitems_ibfk_1` (`characterid`),
  KEY `characterid` (`characterid`),
  KEY `inventorytype` (`inventorytype`),
  KEY `accountid` (`accountid`),
  KEY `packageid` (`packageid`),
  KEY `characterid_2` (`characterid`,`inventorytype`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `hyperrocklocations` */

DROP TABLE IF EXISTS `hyperrocklocations`;

CREATE TABLE `hyperrocklocations` (
  `trockid` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `mapid` int(11) DEFAULT NULL,
  PRIMARY KEY (`trockid`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

/*Table structure for table `imps` */

DROP TABLE IF EXISTS `imps`;

CREATE TABLE `imps` (
  `impid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `closeness` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `fullness` mediumint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`impid`),
  KEY `impid` (`impid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `inner_ability_skills` */

DROP TABLE IF EXISTS `inner_ability_skills`;

CREATE TABLE `inner_ability_skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_level` int(3) NOT NULL,
  `max_level` int(3) NOT NULL,
  `rank` int(3) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8037 DEFAULT CHARSET=latin1;

/*Table structure for table `internlog` */

DROP TABLE IF EXISTS `internlog`;

CREATE TABLE `internlog` (
  `gmlogid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `command` tinytext NOT NULL,
  `mapid` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gmlogid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventoryequipment` */

DROP TABLE IF EXISTS `inventoryequipment`;

CREATE TABLE `inventoryequipment` (
  `inventoryequipmentid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `upgradeslots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `str` int(6) NOT NULL DEFAULT '0',
  `dex` int(6) NOT NULL DEFAULT '0',
  `int` int(6) NOT NULL DEFAULT '0',
  `luk` int(6) NOT NULL DEFAULT '0',
  `hp` int(6) NOT NULL DEFAULT '0',
  `mp` int(6) NOT NULL DEFAULT '0',
  `watk` int(6) NOT NULL DEFAULT '0',
  `matk` int(6) NOT NULL DEFAULT '0',
  `wdef` int(6) NOT NULL DEFAULT '0',
  `mdef` int(6) NOT NULL DEFAULT '0',
  `acc` int(6) NOT NULL DEFAULT '0',
  `avoid` int(6) NOT NULL DEFAULT '0',
  `hands` int(6) NOT NULL DEFAULT '0',
  `speed` int(6) NOT NULL DEFAULT '0',
  `jump` int(6) NOT NULL DEFAULT '0',
  `ViciousHammer` tinyint(2) NOT NULL DEFAULT '0',
  `itemEXP` int(11) NOT NULL DEFAULT '0',
  `durability` mediumint(9) NOT NULL DEFAULT '-1',
  `enhance` tinyint(3) NOT NULL DEFAULT '0',
  `potential1` int(5) NOT NULL DEFAULT '0',
  `potential2` int(5) NOT NULL DEFAULT '0',
  `potential3` int(5) NOT NULL DEFAULT '0',
  `potential4` int(5) NOT NULL DEFAULT '0',
  `potential5` int(5) NOT NULL DEFAULT '0',
  `potential6` int(5) NOT NULL DEFAULT '0',
  `fusionAnvil` int(11) NOT NULL DEFAULT '0',
  `socket1` int(5) NOT NULL DEFAULT '-1',
  `socket2` int(5) NOT NULL DEFAULT '-1',
  `socket3` int(5) NOT NULL DEFAULT '-1',
  `incSkill` int(11) NOT NULL DEFAULT '-1',
  `charmEXP` int(6) NOT NULL DEFAULT '-1',
  `pvpDamage` int(6) NOT NULL DEFAULT '0',
  `enhanctBuff` int(3) NOT NULL DEFAULT '0',
  `reqLevel` int(3) NOT NULL DEFAULT '0',
  `yggdrasilWisdom` tinyint(2) NOT NULL DEFAULT '0',
  `finalStrike` tinyint(2) NOT NULL DEFAULT '0',
  `bossDamage` int(3) NOT NULL DEFAULT '0',
  `ignorePDR` int(3) NOT NULL DEFAULT '0',
  `totalDamage` int(3) NOT NULL DEFAULT '0',
  `allStat` int(3) NOT NULL DEFAULT '0',
  `karmaCount` int(3) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`inventoryequipmentid`),
  KEY `inventoryitemid` (`inventoryitemid`),
  CONSTRAINT `inventoryequipment_ibfk_1` FOREIGN KEY (`inventoryitemid`) REFERENCES `inventoryitems` (`inventoryitemid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3523229 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `inventoryitems` */

DROP TABLE IF EXISTS `inventoryitems`;

CREATE TABLE `inventoryitems` (
  `inventoryitemid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `accountid` int(10) DEFAULT NULL,
  `packageid` int(11) DEFAULT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `inventorytype` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `owner` tinytext,
  `GM_Log` tinytext,
  `uniqueid` int(11) NOT NULL DEFAULT '-1',
  `flag` int(2) NOT NULL DEFAULT '0',
  `expiredate` bigint(20) NOT NULL DEFAULT '-1',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `sender` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`inventoryitemid`),
  KEY `inventorytype` (`inventorytype`),
  KEY `accountid` (`accountid`),
  KEY `packageid` (`packageid`),
  KEY `characterid_2` (`characterid`,`inventorytype`)
) ENGINE=InnoDB AUTO_INCREMENT=8778415 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `inventorylog` */

DROP TABLE IF EXISTS `inventorylog`;

CREATE TABLE `inventorylog` (
  `inventorylogid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` int(10) unsigned NOT NULL DEFAULT '0',
  `msg` tinytext NOT NULL,
  PRIMARY KEY (`inventorylogid`),
  KEY `inventoryitemid` (`inventoryitemid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventoryslot` */

DROP TABLE IF EXISTS `inventoryslot`;

CREATE TABLE `inventoryslot` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(10) unsigned DEFAULT NULL,
  `equip` tinyint(3) unsigned DEFAULT NULL,
  `use` tinyint(3) unsigned DEFAULT NULL,
  `setup` tinyint(3) unsigned DEFAULT NULL,
  `etc` tinyint(3) unsigned DEFAULT NULL,
  `cash` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `characterid` (`characterid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138200 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `ipbans` */

DROP TABLE IF EXISTS `ipbans`;

CREATE TABLE `ipbans` (
  `ipbanid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`ipbanid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `iplog` */

DROP TABLE IF EXISTS `iplog`;

CREATE TABLE `iplog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accid` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `time` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `ipvotelog` */

DROP TABLE IF EXISTS `ipvotelog`;

CREATE TABLE `ipvotelog` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accid` int(11) NOT NULL DEFAULT '0',
  `ipaddress` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `votetime` bigint(20) NOT NULL DEFAULT '0',
  `votetype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipvotes` */

DROP TABLE IF EXISTS `ipvotes`;

CREATE TABLE `ipvotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(30) NOT NULL,
  `accid` int(11) NOT NULL,
  `lastvote` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `keymap` */

DROP TABLE IF EXISTS `keymap`;

CREATE TABLE `keymap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `key` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `keymap_ibfk_1` (`characterid`),
  CONSTRAINT `keymap_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4213857 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `macbans` */

DROP TABLE IF EXISTS `macbans`;

CREATE TABLE `macbans` (
  `macbanid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mac` varchar(30) NOT NULL,
  PRIMARY KEY (`macbanid`),
  UNIQUE KEY `mac_2` (`mac`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `macfilters` */

DROP TABLE IF EXISTS `macfilters`;

CREATE TABLE `macfilters` (
  `macfilterid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filter` varchar(30) NOT NULL,
  PRIMARY KEY (`macfilterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `mail` */

DROP TABLE IF EXISTS `mail`;

CREATE TABLE `mail` (
  `mailid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `to` varchar(50) NOT NULL,
  `from` varchar(50) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '-1',
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `ipaddress` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `timestamp` varchar(40) NOT NULL DEFAULT '-',
  `dateadded` varchar(30) DEFAULT 'NULL DATE',
  PRIMARY KEY (`mailid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `marriages` */

DROP TABLE IF EXISTS `marriages`;

CREATE TABLE `marriages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `husbandId` int(11) NOT NULL,
  `wifeId` int(11) NOT NULL DEFAULT '0',
  `ring` int(11) NOT NULL DEFAULT '0',
  `husbandName` varchar(15) NOT NULL DEFAULT '0',
  `WifeName` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `monsterbook` */

DROP TABLE IF EXISTS `monsterbook`;

CREATE TABLE `monsterbook` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `charid` int(10) unsigned NOT NULL DEFAULT '0',
  `cardid` int(10) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(2) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `charid` (`charid`)
) ENGINE=InnoDB AUTO_INCREMENT=2706 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `moonlightachievements` */

DROP TABLE IF EXISTS `moonlightachievements`;

CREATE TABLE `moonlightachievements` (
  `achievementid` int(9) NOT NULL DEFAULT '0',
  `charid` int(9) NOT NULL DEFAULT '0',
  `accountid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`achievementid`,`charid`),
  KEY `achievementid` (`achievementid`),
  KEY `accountid` (`accountid`),
  KEY `charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `mountdata` */

DROP TABLE IF EXISTS `mountdata`;

CREATE TABLE `mountdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(10) unsigned DEFAULT NULL,
  `Level` int(3) unsigned NOT NULL DEFAULT '0',
  `Exp` int(10) unsigned NOT NULL DEFAULT '0',
  `Fatigue` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `characterid` (`characterid`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7612 DEFAULT CHARSET=latin1;

/*Table structure for table `mts_cart` */

DROP TABLE IF EXISTS `mts_cart`;

CREATE TABLE `mts_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `characterid` (`characterid`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `mts_items` */

DROP TABLE IF EXISTS `mts_items`;

CREATE TABLE `mts_items` (
  `id` int(11) NOT NULL,
  `tab` tinyint(1) NOT NULL DEFAULT '1',
  `price` int(11) NOT NULL DEFAULT '0',
  `characterid` int(11) NOT NULL DEFAULT '0',
  `seller` varchar(13) NOT NULL DEFAULT '',
  `expiration` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `mtsequipment` */

DROP TABLE IF EXISTS `mtsequipment`;

CREATE TABLE `mtsequipment` (
  `inventoryequipmentid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `upgradeslots` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `str` int(11) NOT NULL DEFAULT '0',
  `dex` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `luk` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `watk` int(11) NOT NULL DEFAULT '0',
  `matk` int(11) NOT NULL DEFAULT '0',
  `wdef` int(11) NOT NULL DEFAULT '0',
  `mdef` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `avoid` int(11) NOT NULL DEFAULT '0',
  `hands` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `jump` int(11) NOT NULL DEFAULT '0',
  `ViciousHammer` tinyint(2) NOT NULL DEFAULT '0',
  `itemEXP` int(11) NOT NULL DEFAULT '0',
  `durability` int(11) NOT NULL DEFAULT '-1',
  `enhance` tinyint(3) NOT NULL DEFAULT '0',
  `potential1` int(5) NOT NULL DEFAULT '0',
  `potential2` int(5) NOT NULL DEFAULT '0',
  `potential3` int(5) NOT NULL DEFAULT '0',
  `potential4` int(5) NOT NULL DEFAULT '0',
  `potential5` int(5) NOT NULL DEFAULT '0',
  `socket1` int(5) NOT NULL DEFAULT '-1',
  `socket2` int(5) NOT NULL DEFAULT '-1',
  `socket3` int(5) NOT NULL DEFAULT '-1',
  `incSkill` int(11) NOT NULL DEFAULT '-1',
  `charmEXP` smallint(6) NOT NULL DEFAULT '-1',
  `pvpDamage` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`inventoryequipmentid`),
  KEY `inventoryitemid` (`inventoryitemid`),
  CONSTRAINT `mtsequipment_ibfk_1` FOREIGN KEY (`inventoryitemid`) REFERENCES `mtsitems` (`inventoryitemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `mtsitems` */

DROP TABLE IF EXISTS `mtsitems`;

CREATE TABLE `mtsitems` (
  `inventoryitemid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `accountid` int(10) DEFAULT NULL,
  `packageId` int(11) DEFAULT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `inventorytype` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `owner` tinytext,
  `GM_Log` tinytext,
  `uniqueid` int(11) NOT NULL DEFAULT '-1',
  `flag` int(2) NOT NULL DEFAULT '0',
  `expiredate` bigint(20) NOT NULL DEFAULT '-1',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `sender` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`inventoryitemid`),
  KEY `inventoryitems_ibfk_1` (`characterid`),
  KEY `characterid` (`characterid`),
  KEY `inventorytype` (`inventorytype`),
  KEY `accountid` (`accountid`),
  KEY `characterid_2` (`characterid`,`inventorytype`),
  KEY `packageid` (`packageId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `mtstransfer` */

DROP TABLE IF EXISTS `mtstransfer`;

CREATE TABLE `mtstransfer` (
  `inventoryitemid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `accountid` int(10) DEFAULT NULL,
  `packageid` int(11) DEFAULT NULL,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `inventorytype` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `owner` tinytext,
  `GM_Log` tinytext,
  `uniqueid` int(11) NOT NULL DEFAULT '-1',
  `flag` int(2) NOT NULL DEFAULT '0',
  `expiredate` bigint(20) NOT NULL DEFAULT '-1',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `sender` varchar(13) NOT NULL DEFAULT '',
  PRIMARY KEY (`inventoryitemid`),
  KEY `inventoryitems_ibfk_1` (`characterid`),
  KEY `characterid` (`characterid`),
  KEY `inventorytype` (`inventorytype`),
  KEY `accountid` (`accountid`),
  KEY `packageid` (`packageid`),
  KEY `characterid_2` (`characterid`,`inventorytype`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `mtstransferequipment` */

DROP TABLE IF EXISTS `mtstransferequipment`;

CREATE TABLE `mtstransferequipment` (
  `inventoryequipmentid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventoryitemid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `upgradeslots` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `str` int(11) NOT NULL DEFAULT '0',
  `dex` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `luk` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `watk` int(11) NOT NULL DEFAULT '0',
  `matk` int(11) NOT NULL DEFAULT '0',
  `wdef` int(11) NOT NULL DEFAULT '0',
  `mdef` int(11) NOT NULL DEFAULT '0',
  `acc` int(11) NOT NULL DEFAULT '0',
  `avoid` int(11) NOT NULL DEFAULT '0',
  `hands` int(11) NOT NULL DEFAULT '0',
  `speed` int(11) NOT NULL DEFAULT '0',
  `jump` int(11) NOT NULL DEFAULT '0',
  `ViciousHammer` tinyint(2) NOT NULL DEFAULT '0',
  `itemEXP` int(11) NOT NULL DEFAULT '0',
  `durability` int(11) NOT NULL DEFAULT '-1',
  `enhance` tinyint(3) NOT NULL DEFAULT '0',
  `potential1` int(5) NOT NULL DEFAULT '0',
  `potential2` int(5) NOT NULL DEFAULT '0',
  `potential3` int(5) NOT NULL DEFAULT '0',
  `potential4` int(5) NOT NULL DEFAULT '0',
  `potential5` int(5) NOT NULL DEFAULT '0',
  `socket1` int(5) NOT NULL DEFAULT '-1',
  `socket2` int(5) NOT NULL DEFAULT '-1',
  `socket3` int(5) NOT NULL DEFAULT '-1',
  `incSkill` int(11) NOT NULL DEFAULT '-1',
  `charmEXP` smallint(6) NOT NULL DEFAULT '-1',
  `pvpDamage` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`inventoryequipmentid`),
  KEY `inventoryitemid` (`inventoryitemid`),
  CONSTRAINT `mtstransferequipment_ibfk_1` FOREIGN KEY (`inventoryitemid`) REFERENCES `mtstransfer` (`inventoryitemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `ncomments` */

DROP TABLE IF EXISTS `ncomments`;

CREATE TABLE `ncomments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nid` int(10) NOT NULL,
  `author` varchar(16) NOT NULL,
  `feedback` int(1) NOT NULL,
  `date` varchar(32) NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `news` */

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `author` varchar(16) NOT NULL,
  `date` varchar(32) NOT NULL,
  `type` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `views` int(10) NOT NULL DEFAULT '0',
  `locked` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `notes` */

DROP TABLE IF EXISTS `notes`;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to` varchar(13) NOT NULL DEFAULT '',
  `from` varchar(13) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `timestamp` bigint(20) unsigned NOT NULL,
  `gift` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `to` (`to`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `nxcode` */

DROP TABLE IF EXISTS `nxcode`;

CREATE TABLE `nxcode` (
  `code` varchar(15) NOT NULL,
  `valid` int(11) NOT NULL DEFAULT '1',
  `user` varchar(13) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `item` int(11) NOT NULL DEFAULT '10000',
  `quantity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `pages` */

DROP TABLE IF EXISTS `pages`;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `slug` text NOT NULL,
  `author` text NOT NULL,
  `content` text NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `parttime` */

DROP TABLE IF EXISTS `parttime`;

CREATE TABLE `parttime` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `job` tinyint(1) NOT NULL DEFAULT '0',
  `time` bigint(20) NOT NULL DEFAULT '0',
  `reward` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `pets` */

DROP TABLE IF EXISTS `pets`;

CREATE TABLE `pets` (
  `petid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(13) DEFAULT NULL,
  `level` int(3) unsigned NOT NULL,
  `closeness` int(6) unsigned NOT NULL,
  `fullness` int(3) unsigned NOT NULL,
  `seconds` int(11) NOT NULL DEFAULT '0',
  `flags` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`petid`),
  KEY `petid` (`petid`)
) ENGINE=InnoDB AUTO_INCREMENT=2456 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `playernpcs` */

DROP TABLE IF EXISTS `playernpcs`;

CREATE TABLE `playernpcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(13) NOT NULL,
  `hair` int(11) NOT NULL,
  `face` int(11) NOT NULL,
  `skin` int(11) NOT NULL,
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `map` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  `scriptid` int(11) NOT NULL,
  `foothold` int(11) NOT NULL,
  `dir` tinyint(1) NOT NULL DEFAULT '0',
  `gender` tinyint(1) NOT NULL DEFAULT '0',
  `pets` varchar(25) DEFAULT '0,0,0',
  `job` int(5) NOT NULL,
  `elf` int(11) NOT NULL,
  `demonmarking` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scriptid` (`scriptid`),
  KEY `playernpcs_ibfk_1` (`charid`),
  CONSTRAINT `playernpcs_ibfk_1` FOREIGN KEY (`charid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `playernpcs_equip` */

DROP TABLE IF EXISTS `playernpcs_equip`;

CREATE TABLE `playernpcs_equip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npcid` int(11) NOT NULL,
  `equipid` int(11) NOT NULL,
  `equippos` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `playernpcs_equip_ibfk_1` (`charid`),
  KEY `playernpcs_equip_ibfk_2` (`npcid`),
  CONSTRAINT `playernpcs_equip_ibfk_1` FOREIGN KEY (`charid`) REFERENCES `characters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `playernpcs_equip_ibfk_2` FOREIGN KEY (`npcid`) REFERENCES `playernpcs` (`scriptid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `profile` */

DROP TABLE IF EXISTS `profile`;

CREATE TABLE `profile` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `accountid` int(10) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `mainchar` int(10) DEFAULT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `age` int(2) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `motto` varchar(255) DEFAULT NULL,
  `favjob` varchar(255) DEFAULT NULL,
  `text` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accountid_UNIQUE` (`accountid`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Table structure for table `properties` */

DROP TABLE IF EXISTS `properties`;

CREATE TABLE `properties` (
  `name` text,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `client` text,
  `server` text,
  `version` int(11) NOT NULL DEFAULT '0',
  `forumurl` text,
  `siteurl` text,
  `exprate` text,
  `mesorate` text,
  `droprate` text,
  `banner` text,
  `background` text,
  `bgcolor` varchar(6) DEFAULT NULL,
  `bgrepeat` varchar(20) DEFAULT NULL,
  `bgcenter` tinyint(1) DEFAULT NULL,
  `bgfixed` tinyint(1) DEFAULT NULL,
  `bgcover` tinyint(1) DEFAULT NULL,
  `flood` tinyint(4) NOT NULL DEFAULT '1',
  `floodint` int(11) DEFAULT NULL,
  `pcap` text,
  `maxaccounts` tinyint(4) NOT NULL DEFAULT '3',
  `gmlevel` int(11) NOT NULL DEFAULT '1',
  `theme` text NOT NULL,
  `nav` text NOT NULL,
  `colnx` text NOT NULL,
  `colvp` text NOT NULL,
  `homecontent` text,
  `jailmaps` text,
  `githubapi` int(12) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pwreset` */

DROP TABLE IF EXISTS `pwreset`;

CREATE TABLE `pwreset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(14) NOT NULL,
  `email` varchar(100) NOT NULL,
  `confirmkey` varchar(100) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestamp` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `questinfo` */

DROP TABLE IF EXISTS `questinfo`;

CREATE TABLE `questinfo` (
  `questinfoid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `quest` int(6) NOT NULL DEFAULT '0',
  `customData` varchar(555) DEFAULT NULL,
  PRIMARY KEY (`questinfoid`),
  KEY `characterid` (`characterid`),
  CONSTRAINT `questsinfo_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1761 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `queststatus` */

DROP TABLE IF EXISTS `queststatus`;

CREATE TABLE `queststatus` (
  `queststatusid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `quest` int(6) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT '0',
  `forfeited` int(11) NOT NULL DEFAULT '0',
  `customData` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`queststatusid`),
  KEY `characterid` (`characterid`),
  KEY `queststatusid` (`queststatusid`),
  CONSTRAINT `queststatus_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=275835 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `queststatusmobs` */

DROP TABLE IF EXISTS `queststatusmobs`;

CREATE TABLE `queststatusmobs` (
  `queststatusmobid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `queststatusid` int(10) unsigned NOT NULL DEFAULT '0',
  `mob` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`queststatusmobid`),
  KEY `queststatusid` (`queststatusid`),
  CONSTRAINT `queststatusmobs_ibfk_1` FOREIGN KEY (`queststatusid`) REFERENCES `queststatus` (`queststatusid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=593 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `reactordrops` */

DROP TABLE IF EXISTS `reactordrops`;

CREATE TABLE `reactordrops` (
  `reactordropid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reactorid` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `chance` int(11) NOT NULL,
  `questid` int(5) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`reactordropid`),
  KEY `reactorid` (`reactorid`)
) ENGINE=InnoDB AUTO_INCREMENT=841 DEFAULT CHARSET=latin1 PACK_KEYS=1;

/*Table structure for table `readable_cheatlog` */

DROP TABLE IF EXISTS `readable_cheatlog`;

CREATE TABLE `readable_cheatlog` (
  `accountname` tinyint(4) NOT NULL,
  `accountid` tinyint(4) NOT NULL,
  `name` tinyint(4) NOT NULL,
  `characterid` tinyint(4) NOT NULL,
  `offense` tinyint(4) NOT NULL,
  `count` tinyint(4) NOT NULL,
  `lastoffensetime` tinyint(4) NOT NULL,
  `param` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `readable_last_hour_cheatlog` */

DROP TABLE IF EXISTS `readable_last_hour_cheatlog`;

CREATE TABLE `readable_last_hour_cheatlog` (
  `accountname` tinyint(4) NOT NULL,
  `accountid` tinyint(4) NOT NULL,
  `name` tinyint(4) NOT NULL,
  `characterid` tinyint(4) NOT NULL,
  `numrepos` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `regrocklocations` */

DROP TABLE IF EXISTS `regrocklocations`;

CREATE TABLE `regrocklocations` (
  `trockid` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `mapid` int(11) DEFAULT NULL,
  PRIMARY KEY (`trockid`),
  KEY `characterid` (`characterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `reports` */

DROP TABLE IF EXISTS `reports`;

CREATE TABLE `reports` (
  `reportid` int(9) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(2) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`reportid`,`characterid`),
  KEY `characterid` (`characterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rewards` */

DROP TABLE IF EXISTS `rewards`;

CREATE TABLE `rewards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `start` bigint(20) NOT NULL DEFAULT '-1',
  `end` bigint(20) NOT NULL DEFAULT '-1',
  `type` int(11) NOT NULL DEFAULT '0',
  `itemId` int(11) NOT NULL DEFAULT '0',
  `mp` int(11) NOT NULL DEFAULT '0',
  `meso` int(11) NOT NULL DEFAULT '0',
  `exp` int(11) NOT NULL DEFAULT '0',
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5603 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `rings` */

DROP TABLE IF EXISTS `rings`;

CREATE TABLE `rings` (
  `ringid` int(11) NOT NULL AUTO_INCREMENT,
  `partnerRingId` int(11) NOT NULL DEFAULT '0',
  `partnerChrId` int(11) NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  `partnername` varchar(255) NOT NULL,
  PRIMARY KEY (`ringid`),
  KEY `ringid` (`ringid`),
  KEY `partnerChrId` (`partnerChrId`),
  KEY `partnerRingId` (`partnerRingId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `savedlocations` */

DROP TABLE IF EXISTS `savedlocations`;

CREATE TABLE `savedlocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL,
  `locationtype` int(11) NOT NULL DEFAULT '0',
  `map` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `savedlocations_ibfk_1` (`characterid`),
  CONSTRAINT `savedlocations_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1270 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `scroll_log` */

DROP TABLE IF EXISTS `scroll_log`;

CREATE TABLE `scroll_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accId` int(11) NOT NULL DEFAULT '0',
  `chrId` int(11) NOT NULL DEFAULT '0',
  `scrollId` int(11) NOT NULL DEFAULT '0',
  `itemId` int(11) NOT NULL DEFAULT '0',
  `oldSlots` tinyint(4) NOT NULL DEFAULT '0',
  `newSlots` tinyint(4) NOT NULL DEFAULT '0',
  `hammer` tinyint(4) NOT NULL DEFAULT '0',
  `result` varchar(13) NOT NULL DEFAULT '',
  `whiteScroll` tinyint(1) NOT NULL DEFAULT '0',
  `legendarySpirit` tinyint(1) NOT NULL DEFAULT '0',
  `vegaId` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `shopitems` */

DROP TABLE IF EXISTS `shopitems`;

CREATE TABLE `shopitems` (
  `shopitemid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shopid` int(10) unsigned NOT NULL DEFAULT '0',
  `itemid` int(11) NOT NULL DEFAULT '0',
  `price` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `reqitem` int(11) NOT NULL DEFAULT '0',
  `reqitemq` int(11) NOT NULL DEFAULT '0',
  `rank` tinyint(3) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `buyable` int(11) NOT NULL DEFAULT '0',
  `category` tinyint(3) NOT NULL DEFAULT '0',
  `minLevel` int(11) NOT NULL DEFAULT '0',
  `expiration` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shopitemid`),
  KEY `shopid` (`shopid`)
) ENGINE=MyISAM AUTO_INCREMENT=15961 DEFAULT CHARSET=latin1;

/*Table structure for table `shopranks` */

DROP TABLE IF EXISTS `shopranks`;

CREATE TABLE `shopranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopid` int(11) NOT NULL DEFAULT '0',
  `rank` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `itemid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `shops` */

DROP TABLE IF EXISTS `shops`;

CREATE TABLE `shops` (
  `shopid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `npcid` int(11) DEFAULT '0',
  PRIMARY KEY (`shopid`)
) ENGINE=MyISAM AUTO_INCREMENT=9270066 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `sidekicks` */

DROP TABLE IF EXISTS `sidekicks`;

CREATE TABLE `sidekicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `firstid` int(11) NOT NULL DEFAULT '0',
  `secondid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `skillmacros` */

DROP TABLE IF EXISTS `skillmacros`;

CREATE TABLE `skillmacros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) NOT NULL DEFAULT '0',
  `position` tinyint(1) NOT NULL DEFAULT '0',
  `skill1` int(11) NOT NULL DEFAULT '0',
  `skill2` int(11) NOT NULL DEFAULT '0',
  `skill3` int(11) NOT NULL DEFAULT '0',
  `name` varchar(30) DEFAULT NULL,
  `shout` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `characterid` (`characterid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Table structure for table `skills` */

DROP TABLE IF EXISTS `skills`;

CREATE TABLE `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skillid` int(11) NOT NULL DEFAULT '0',
  `characterid` int(11) NOT NULL DEFAULT '0',
  `skilllevel` int(11) NOT NULL DEFAULT '0',
  `masterlevel` tinyint(4) NOT NULL DEFAULT '0',
  `expiration` bigint(20) NOT NULL DEFAULT '-1',
  `victimid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `skills_ibfk_1` (`characterid`),
  CONSTRAINT `skills_ibfk_1` FOREIGN KEY (`characterid`) REFERENCES `characters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=320247 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `skills_cooldowns` */

DROP TABLE IF EXISTS `skills_cooldowns`;

CREATE TABLE `skills_cooldowns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `SkillID` int(11) NOT NULL,
  `length` bigint(20) NOT NULL,
  `StartTime` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid` (`charid`)
) ENGINE=InnoDB AUTO_INCREMENT=909 DEFAULT CHARSET=latin1;

/*Table structure for table `speedruns` */

DROP TABLE IF EXISTS `speedruns`;

CREATE TABLE `speedruns` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(13) NOT NULL,
  `leader` varchar(13) NOT NULL,
  `timestring` varchar(1024) NOT NULL,
  `time` bigint(20) NOT NULL DEFAULT '0',
  `members` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Table structure for table `stolen` */

DROP TABLE IF EXISTS `stolen`;

CREATE TABLE `stolen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `characterid` varchar(45) NOT NULL,
  `skillid` varchar(45) NOT NULL,
  `chosen` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=latin1;

/*Table structure for table `storages` */

DROP TABLE IF EXISTS `storages`;

CREATE TABLE `storages` (
  `storageid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accountid` int(11) NOT NULL DEFAULT '0',
  `slots` int(11) NOT NULL DEFAULT '0',
  `meso` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`storageid`),
  KEY `accountid` (`accountid`),
  CONSTRAINT `storages_ibfk_1` FOREIGN KEY (`accountid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3292 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `tcomments` */

DROP TABLE IF EXISTS `tcomments`;

CREATE TABLE `tcomments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticketid` int(10) unsigned NOT NULL,
  `user` varchar(30) NOT NULL,
  `content` longtext NOT NULL,
  `date_com` varchar(100) NOT NULL,
  PRIMARY KEY (`id`,`ticketid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tickets` */

DROP TABLE IF EXISTS `tickets`;

CREATE TABLE `tickets` (
  `ticketid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `support_type` varchar(20) NOT NULL,
  `details` longtext NOT NULL,
  `date` varchar(100) NOT NULL,
  `ip` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`ticketid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tournamentlog` */

DROP TABLE IF EXISTS `tournamentlog`;

CREATE TABLE `tournamentlog` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `winnerid` int(11) NOT NULL DEFAULT '0',
  `numContestants` int(11) NOT NULL DEFAULT '0',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `trocklocations` */

DROP TABLE IF EXISTS `trocklocations`;

CREATE TABLE `trocklocations` (
  `trockid` int(11) NOT NULL AUTO_INCREMENT,
  `characterid` int(11) DEFAULT NULL,
  `mapid` int(11) DEFAULT NULL,
  PRIMARY KEY (`trockid`),
  KEY `characterid` (`characterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `vote` */

DROP TABLE IF EXISTS `vote`;

CREATE TABLE `vote` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `link` text NOT NULL,
  `gnx` int(11) unsigned NOT NULL DEFAULT '10',
  `gvp` int(11) unsigned NOT NULL DEFAULT '1',
  `waittime` int(11) unsigned NOT NULL DEFAULT '21600',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `votes` */

DROP TABLE IF EXISTS `votes`;

CREATE TABLE `votes` (
  `account` varchar(13) NOT NULL DEFAULT '0',
  `ip` varchar(30) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  `times` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `votingrecords` */

DROP TABLE IF EXISTS `votingrecords`;

CREATE TABLE `votingrecords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(30) NOT NULL DEFAULT '0',
  `siteid` int(11) DEFAULT NULL,
  `account` varchar(13) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  `times` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `web_news` */

DROP TABLE IF EXISTS `web_news`;

CREATE TABLE `web_news` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `month` varchar(30) DEFAULT NULL,
  `day` varchar(30) DEFAULT NULL,
  `content` varchar(10000) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Table structure for table `web_settings` */

DROP TABLE IF EXISTS `web_settings`;

CREATE TABLE `web_settings` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `maxplayers` int(255) DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `website_events` */

DROP TABLE IF EXISTS `website_events`;

CREATE TABLE `website_events` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `author` varchar(16) NOT NULL,
  `date` varchar(32) NOT NULL,
  `type` varchar(100) NOT NULL,
  `status` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `views` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `website_news` */

DROP TABLE IF EXISTS `website_news`;

CREATE TABLE `website_news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `author` varchar(16) NOT NULL,
  `date` varchar(32) NOT NULL,
  `type` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `views` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `wishlist` */

DROP TABLE IF EXISTS `wishlist`;

CREATE TABLE `wishlist` (
  `characterid` int(11) NOT NULL,
  `sn` int(11) NOT NULL,
  KEY `characterid` (`characterid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `wz_customlife` */

DROP TABLE IF EXISTS `wz_customlife`;

CREATE TABLE `wz_customlife` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataid` int(11) NOT NULL,
  `f` int(11) NOT NULL,
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `fh` int(11) NOT NULL,
  `type` varchar(1) NOT NULL,
  `cy` int(11) NOT NULL,
  `rx0` int(11) NOT NULL,
  `rx1` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `mobtime` int(11) DEFAULT '1000',
  `mid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Table structure for table `wz_itemadddata` */

DROP TABLE IF EXISTS `wz_itemadddata`;

CREATE TABLE `wz_itemadddata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL,
  `key` varchar(30) NOT NULL,
  `subKey` varchar(30) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9154 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_itemdata` */

DROP TABLE IF EXISTS `wz_itemdata`;

CREATE TABLE `wz_itemdata` (
  `itemid` int(11) NOT NULL,
  `name` tinytext,
  `msg` varchar(4096) DEFAULT NULL,
  `desc` varchar(4096) DEFAULT NULL,
  `slotMax` smallint(5) NOT NULL DEFAULT '1',
  `price` varchar(255) NOT NULL DEFAULT '-1.0',
  `wholePrice` int(11) NOT NULL DEFAULT '-1',
  `stateChange` int(11) NOT NULL DEFAULT '0',
  `flags` smallint(4) NOT NULL DEFAULT '0',
  `karma` tinyint(1) NOT NULL DEFAULT '0',
  `meso` int(11) NOT NULL DEFAULT '0',
  `monsterBook` int(11) NOT NULL DEFAULT '0',
  `itemMakeLevel` smallint(6) NOT NULL DEFAULT '0',
  `questId` int(11) NOT NULL DEFAULT '0',
  `scrollReqs` varchar(4096) DEFAULT NULL,
  `consumeItem` tinytext,
  `totalprob` int(11) NOT NULL DEFAULT '0',
  `incSkill` varchar(255) NOT NULL DEFAULT '',
  `replaceid` int(11) NOT NULL DEFAULT '0',
  `replacemsg` varchar(255) NOT NULL DEFAULT '',
  `create` int(11) NOT NULL DEFAULT '0',
  `afterImage` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_itemequipdata` */

DROP TABLE IF EXISTS `wz_itemequipdata`;

CREATE TABLE `wz_itemequipdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL,
  `itemLevel` int(11) NOT NULL DEFAULT '-1',
  `key` varchar(30) NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=836103 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_itemrewarddata` */

DROP TABLE IF EXISTS `wz_itemrewarddata`;

CREATE TABLE `wz_itemrewarddata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `prob` int(11) NOT NULL DEFAULT '0',
  `quantity` smallint(5) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '-1',
  `worldMsg` varchar(255) NOT NULL DEFAULT '',
  `effect` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=63205 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_mobskilldata` */

DROP TABLE IF EXISTS `wz_mobskilldata`;

CREATE TABLE `wz_mobskilldata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skillid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT '100',
  `mpcon` int(11) NOT NULL DEFAULT '0',
  `x` int(11) NOT NULL DEFAULT '1',
  `y` int(11) NOT NULL DEFAULT '1',
  `time` int(11) NOT NULL DEFAULT '0',
  `prop` int(11) NOT NULL DEFAULT '100',
  `limit` int(11) NOT NULL DEFAULT '0',
  `spawneffect` int(11) NOT NULL DEFAULT '0',
  `interval` int(11) NOT NULL DEFAULT '0',
  `summons` varchar(1024) NOT NULL DEFAULT '',
  `ltx` int(11) NOT NULL DEFAULT '0',
  `lty` int(11) NOT NULL DEFAULT '0',
  `rbx` int(11) NOT NULL DEFAULT '0',
  `rby` int(11) NOT NULL DEFAULT '0',
  `once` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8278 DEFAULT CHARSET=latin1;

/*Table structure for table `wz_npcnamedata` */

DROP TABLE IF EXISTS `wz_npcnamedata`;

CREATE TABLE `wz_npcnamedata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npc` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7697 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_oxdata` */

DROP TABLE IF EXISTS `wz_oxdata`;

CREATE TABLE `wz_oxdata` (
  `questionset` smallint(6) NOT NULL DEFAULT '0',
  `questionid` smallint(6) NOT NULL DEFAULT '0',
  `question` varchar(200) NOT NULL DEFAULT '',
  `display` varchar(200) NOT NULL DEFAULT '',
  `answer` enum('o','x') NOT NULL,
  PRIMARY KEY (`questionset`,`questionid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `wz_questactdata` */

DROP TABLE IF EXISTS `wz_questactdata`;

CREATE TABLE `wz_questactdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(127) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `intStore` int(11) NOT NULL DEFAULT '0',
  `applicableJobs` varchar(1024) NOT NULL DEFAULT '',
  `uniqueid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `quests_ibfk_2` (`questid`)
) ENGINE=MyISAM AUTO_INCREMENT=39568 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_questactitemdata` */

DROP TABLE IF EXISTS `wz_questactitemdata`;

CREATE TABLE `wz_questactitemdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemid` int(11) NOT NULL DEFAULT '0',
  `count` smallint(5) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `gender` tinyint(1) NOT NULL DEFAULT '2',
  `job` int(11) NOT NULL DEFAULT '-1',
  `jobEx` int(11) NOT NULL DEFAULT '-1',
  `prop` int(11) NOT NULL DEFAULT '-1',
  `uniqueid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=46361 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `wz_questactquestdata` */

DROP TABLE IF EXISTS `wz_questactquestdata`;

CREATE TABLE `wz_questactquestdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quest` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(1) NOT NULL DEFAULT '2',
  `uniqueid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=96 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `wz_questactskilldata` */

DROP TABLE IF EXISTS `wz_questactskilldata`;

CREATE TABLE `wz_questactskilldata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skillid` int(11) NOT NULL DEFAULT '0',
  `skillLevel` int(11) NOT NULL DEFAULT '-1',
  `masterLevel` int(11) NOT NULL DEFAULT '-1',
  `uniqueid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=701 DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

/*Table structure for table `wz_questdata` */

DROP TABLE IF EXISTS `wz_questdata`;

CREATE TABLE `wz_questdata` (
  `questid` int(11) NOT NULL,
  `name` varchar(1024) NOT NULL DEFAULT '',
  `autoStart` tinyint(1) NOT NULL DEFAULT '0',
  `autoPreComplete` tinyint(1) NOT NULL DEFAULT '0',
  `viewMedalItem` int(11) NOT NULL DEFAULT '0',
  `selectedSkillID` int(11) NOT NULL DEFAULT '0',
  `blocked` tinyint(1) NOT NULL DEFAULT '0',
  `autoAccept` tinyint(1) NOT NULL DEFAULT '0',
  `autoComplete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`questid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_questpartydata` */

DROP TABLE IF EXISTS `wz_questpartydata`;

CREATE TABLE `wz_questpartydata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questid` int(11) NOT NULL DEFAULT '0',
  `rank` varchar(1) NOT NULL DEFAULT '',
  `mode` varchar(13) NOT NULL DEFAULT '',
  `property` varchar(255) NOT NULL DEFAULT '',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `quests_ibfk_7` (`questid`)
) ENGINE=MyISAM AUTO_INCREMENT=201 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `wz_questreqdata` */

DROP TABLE IF EXISTS `wz_questreqdata`;

CREATE TABLE `wz_questreqdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `intStore` int(11) NOT NULL DEFAULT '-1',
  `stringStore` varchar(1024) NOT NULL DEFAULT '',
  `intStoresFirst` varchar(1024) NOT NULL DEFAULT '',
  `intStoresSecond` varchar(4096) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `quests_ibfk_1` (`questid`)
) ENGINE=MyISAM AUTO_INCREMENT=54977 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
