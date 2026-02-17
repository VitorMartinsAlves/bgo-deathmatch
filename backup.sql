-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.4.3 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para bgo
CREATE DATABASE IF NOT EXISTS `bgo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bgo`;

-- Copiando estrutura para tabela bgo.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mtaserial` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `admin` int NOT NULL DEFAULT '0',
  `adminStats` varchar(4096) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0 ]]',
  `regdate` timestamp NULL DEFAULT NULL,
  `lastlogin` timestamp NULL DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT 'Desconhecido',
  `aseged` int NOT NULL DEFAULT '0',
  `online` varchar(10) NOT NULL DEFAULT '0',
  `guard` varchar(40) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.accounts: ~6 rows (aproximadamente)
INSERT INTO `accounts` (`id`, `username`, `password`, `mtaserial`, `ip`, `admin`, `adminStats`, `regdate`, `lastlogin`, `email`, `aseged`, `online`, `guard`) VALUES
	(1, 'Track', 'B996D2FC5B611D6ED9BDCAD5880A4662', 'A3A3968925B5CE5CFE4A1315C77B87F3', '132.255.45.165', 10, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 00:10:34', '2022-03-03 04:28:00', 'Desconhecido', 0, '1', '0'),
	(2, 'CRUZZ', 'C92237209C06079925514CF31471A417', 'E5421724A5DE3AB97CF4D0F9CD8595B3', '200.146.213.42', 10, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 00:19:01', '2022-03-03 04:09:00', 'Desconhecido', 0, '0', '0'),
	(3, 'big', '5B636320B03503D3C8F40D8D11A80D29', 'F4AC7F44BDB3D25D80A99505301E0492', '187.121.146.243', 10, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 00:42:58', '2022-03-03 04:28:00', 'Desconhecido', 0, '1', '0'),
	(4, 'daddy', '093EC71F562BA6CBF5825B7C9A48F19E', '728B514592554F20BF15A7B3497978B2', '177.133.28.229', 8, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 20:10:29', '2022-03-03 02:43:00', 'Desconhecido', 0, '0', '0'),
	(5, 'TrovaoJN', '58AA35992E19DA7EEC3B499E48F5956B', 'C7AEBAD68C1E092E6F558BCBEBCAFB93', '45.168.114.220', 9, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-28 06:56:20', '2022-02-28 07:08:00', 'Desconhecido', 0, '0', '0'),
	(14, 'wavestwt', 'C98E6D96C99FB2E74BEB3209D4EE0EF2', 'A11FCEF6AFEE4BC6D0A43CEA52D5E05E', '192.168.15.10', 0, '[[ 0, 0, 0, 0, 0, 0 ]]', '2026-02-16 23:52:37', '2026-02-16 23:52:37', 'Desconhecido', 0, '1', '0');

-- Copiando estrutura para tabela bgo.actionbaritems
CREATE TABLE IF NOT EXISTS `actionbaritems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner` int NOT NULL DEFAULT '0',
  `itemdbid` int NOT NULL DEFAULT '0',
  `item` int NOT NULL DEFAULT '0',
  `category` varchar(300) NOT NULL,
  `actionslot` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.actionbaritems: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.actionslot
CREATE TABLE IF NOT EXISTS `actionslot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slot` int NOT NULL DEFAULT '-1',
  `item` int NOT NULL DEFAULT '-1',
  `value` int NOT NULL DEFAULT '-1',
  `count` int NOT NULL DEFAULT '-1',
  `owner` int NOT NULL DEFAULT '-1',
  `type` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.actionslot: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.adminjails
CREATE TABLE IF NOT EXISTS `adminjails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jailed_player` varchar(100) NOT NULL,
  `jailed_playerSerial` varchar(100) NOT NULL,
  `jailed_accountID` varchar(50) NOT NULL,
  `jailed_admin` varchar(100) NOT NULL,
  `jailed_adminSerial` varchar(100) NOT NULL,
  `jailed_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `jailed_ido` int NOT NULL,
  `jailed_idopont` varchar(100) NOT NULL,
  `jailed_idopontora` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.adminjails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.adminlog
CREATE TABLE IF NOT EXISTS `adminlog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `adminacc_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `tevkod` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `chatlog` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `target_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `targetacc_id` varchar(100) NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.adminlog: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.admin_warns
CREATE TABLE IF NOT EXISTS `admin_warns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `addedby` varchar(100) NOT NULL,
  `reason` varchar(2000) NOT NULL,
  `admin` varchar(100) NOT NULL,
  `date` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.admin_warns: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.atms
CREATE TABLE IF NOT EXISTS `atms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `dimension` int DEFAULT NULL,
  `interior` int DEFAULT NULL,
  `rotation` float DEFAULT NULL,
  `deposit` int DEFAULT '0',
  `maxLimit` int DEFAULT '5000',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.atms: 3 rows
/*!40000 ALTER TABLE `atms` DISABLE KEYS */;
INSERT INTO `atms` (`id`, `x`, `y`, `z`, `dimension`, `interior`, `rotation`, `deposit`, `maxLimit`) VALUES
	(26, 2645.31, 1129.67, 10.7797, 0, 0, -8.78369, 0, 5000),
	(28, 1090.82, -1800.07, 13.203, 0, 0, 180.898, 0, 5000),
	(31, 1001.73, -929.151, 41.9281, 0, 0, -81.2451, 0, 5000);
/*!40000 ALTER TABLE `atms` ENABLE KEYS */;

-- Copiando estrutura para tabela bgo.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accountID` int NOT NULL,
  `bannedBy` varchar(50) NOT NULL,
  `timeZone` varchar(255) NOT NULL,
  `Date` varchar(255) NOT NULL,
  `playerSerial` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `playername` varchar(50) NOT NULL,
  `ipadress` varchar(40) NOT NULL,
  `status` varchar(40) NOT NULL,
  `adminID` int NOT NULL,
  `unbanReason` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.bans: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.bins
CREATE TABLE IF NOT EXISTS `bins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pos` varchar(500) NOT NULL DEFAULT '[[ 0,0,0,0,0,0,0,0 ]]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.bins: ~2 rows (aproximadamente)
INSERT INTO `bins` (`id`, `pos`) VALUES
	(68, '[ [ -2820.5146484375, -1526.85546875, 140.84375, 0, 0, 279.7299194335938, 0, 0 ] ]'),
	(69, '[ [ 1090.8212890625, -1794.53125, 13.62193965911865, 0, 0, 274.0224304199219, 0, 0 ] ]');

-- Copiando estrutura para tabela bgo.changelog
CREATE TABLE IF NOT EXISTS `changelog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msg` varchar(255) NOT NULL DEFAULT 'Nenhuma mensagem especificada!',
  `Date` date DEFAULT NULL,
  `irta` varchar(255) NOT NULL DEFAULT 'Nenhum autor especificado!',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.changelog: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int NOT NULL,
  `charname` varchar(255) NOT NULL,
  `hp` int NOT NULL DEFAULT '100',
  `armor` int NOT NULL DEFAULT '0',
  `drink` int NOT NULL DEFAULT '100',
  `hunger` int NOT NULL DEFAULT '100',
  `gender` text NOT NULL,
  `skin` int NOT NULL,
  `pos` varchar(255) NOT NULL,
  `money` bigint NOT NULL DEFAULT '1500',
  `bankmoney` bigint NOT NULL DEFAULT '4000',
  `slotCoin` bigint NOT NULL DEFAULT '0',
  `premiumpont` bigint NOT NULL DEFAULT '0',
  `carSlot` int NOT NULL DEFAULT '3',
  `houseSlot` int NOT NULL DEFAULT '3',
  `adminduty` int NOT NULL DEFAULT '0',
  `suly` int NOT NULL,
  `magassag` int NOT NULL,
  `eletkor` int NOT NULL,
  `leiras` varchar(255) NOT NULL,
  `anick` varchar(255) NOT NULL DEFAULT 'Admin',
  `playedTime` int NOT NULL DEFAULT '0',
  `License` varchar(255) NOT NULL DEFAULT '[[0,0]]' COMMENT '1: Car | 2: Weapon',
  `job` varchar(255) NOT NULL DEFAULT 'Desempregado',
  `adminjail` int NOT NULL DEFAULT '0',
  `adminjail_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'Desconhecido',
  `adminjail_idoTelik` int NOT NULL DEFAULT '0',
  `adminjail_alapIdo` int NOT NULL DEFAULT '0',
  `adminjail_admin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'Desconhecido',
  `adminjail_adminSerial` varchar(100) NOT NULL DEFAULT '0',
  `account` int NOT NULL,
  `rfrekvencia` varchar(50) NOT NULL DEFAULT '0',
  `adutyTime` varchar(50) NOT NULL DEFAULT '0',
  `dutySkin` varchar(10) NOT NULL DEFAULT '0',
  `jailed` varchar(40) NOT NULL DEFAULT '0',
  `jailed_player` varchar(40) NOT NULL DEFAULT 'Desconhecido',
  `jailed_reason` varchar(100) NOT NULL DEFAULT 'Desconhecido',
  `jailed_idoTelik` varchar(40) NOT NULL DEFAULT '0',
  `jailed_alapIdo` varchar(40) NOT NULL DEFAULT '0',
  `buscode` varchar(50) NOT NULL DEFAULT '0',
  `weapon_skills` varchar(512) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]',
  `cuffed` int NOT NULL DEFAULT '0',
  `walkStyle` int NOT NULL DEFAULT '118',
  `fightStyle` int NOT NULL DEFAULT '4',
  `lastSpin` bigint DEFAULT '0',
  `Level` int NOT NULL DEFAULT '0',
  `LevelEXP` int NOT NULL DEFAULT '1',
  `cj` varchar(500) NOT NULL DEFAULT 'vest,player_face,player_legs,foot, , , , , , , , , , , , , , ',
  `cjm` varchar(500) NOT NULL DEFAULT 'vest,head,legs,feet, , , , , , , , , , , , , , ',
  `data` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.characters: ~6 rows (aproximadamente)
INSERT INTO `characters` (`id`, `charname`, `hp`, `armor`, `drink`, `hunger`, `gender`, `skin`, `pos`, `money`, `bankmoney`, `slotCoin`, `premiumpont`, `carSlot`, `houseSlot`, `adminduty`, `suly`, `magassag`, `eletkor`, `leiras`, `anick`, `playedTime`, `License`, `job`, `adminjail`, `adminjail_reason`, `adminjail_idoTelik`, `adminjail_alapIdo`, `adminjail_admin`, `adminjail_adminSerial`, `account`, `rfrekvencia`, `adutyTime`, `dutySkin`, `jailed`, `jailed_player`, `jailed_reason`, `jailed_idoTelik`, `jailed_alapIdo`, `buscode`, `weapon_skills`, `cuffed`, `walkStyle`, `fightStyle`, `lastSpin`, `Level`, `LevelEXP`, `cj`, `cjm`, `data`) VALUES
	(1, 'Track', 57, 0, 0, 21, 'ferfi', 158, '[ [ 1723.177734375, -1721.2216796875, 13.54661178588867, 0, 0 ] ]', 1975090, 4000, 0, 929002, 3, 3, 0, 80, 170, 18, '171', '[CEO]Track', 5376649, '[[0,0]]', 'SemEmprego', 0, '0', 0, 0, '0', '0', 1, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'tshirtilovels,player_face,shortsgrey,sandalsock, , , , , , , , , ,neckgold,watchyellow,bandgang3, , ', 'tshirt,head,shorts,flipflop, , , , , , , , , ,neck2,watch,bandmask, , ', '2022-03-03 01:28'),
	(2, 'CRUZZ', 71, 0, 3, 10, 'ferfi', 2, '[ [ 2342.771484375, 1394.7099609375, 42.81559753417969, 0, 0 ] ]', 2831838207482, 0, 0, 1, 13, 3, 0, 80, 170, 19, 'RealCrya', '[CEO]Mineiro', 1244307, '[[0,0]]', 'SemEmprego', 0, '0', 0, 0, '0', '0', 2, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 1, 50, 'player_torso,highfade,jeansdenim,foot, , , , , , , , , ,neckropes, ,bandblack3, , ', 'torso,head,jeans,feet, , , , , , , , , ,neck2, ,bandmask, , ', ''),
	(3, 'BUGG', 100, 0, 11, 10, 'ferfi', 1, '[ [ 1856.623046875, -1751.2490234375, 13.3828125, 0, 0 ] ]', -9223372036854767616, 1000, 0, 128500, 7, 3, 0, 80, 170, 22, 'Honest', '[CEO]BUUG', 8775461, '[[0,0]]', 'SemEmprego', 0, '0', 0, 0, '0', '0', 3, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 1, 270, 'vestblack,player_face,jeansdenim,sneakerbincblk, , , , , , , , , , , , , , ', 'vest,head,jeans,sneaker, , , , , , , , , , , , , , ', '2022-03-03 01:28'),
	(4, 'Daddy', 81, 90, 38, 49, 'ferfi', 104, '[ [ 1550.677734375, 2571.9501953125, 10.8203125, 0, 0 ] ]', 40218, 4000, 0, 23918321766232, 3, 3, 1, 80, 170, 19, 'pokas', '[DIR]Daddy', 7183887, '[[0,0]]', 'ifood', 0, '0', 0, 0, '0', '0', 4, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 1, 180, 'tshirt2horiz,player_face,tracktr,sandalsock, , , , , , , , , ,neckgold,watchsub2, , , ', 'tshirt2,head,tracktr,flipflop, , , , , , , , , ,neck2,watch, , , ', ''),
	(5, 'Trovao JN', 100, 0, 100, 100, 'ferfi', 1, '[ [ 1936.8251953125, -1796.2880859375, 13.65536594390869, 0, 0 ] ]', 2000, 4000, 0, 0, 3, 3, 1, 80, 170, 21, '157', '[CO]TrovaoJN', 4760310, '[[0,0]]', 'Desempregado', 0, 'Desconhecido', 0, 0, 'Desconhecido', '0', 5, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'vestblack,player_face,jeansdenim,sneakerbincblk, , , , , , , , , , , , , , ', 'vest,head,jeans,sneaker, , , , , , , , , , , , , , ', ''),
	(13, 'dfdf', 100, 0, 73, 75, 'ferfi', 2, '[ [ 1082.189453125, -1771.7841796875, 13.35281944274902, 0, 0 ] ]', 2000, 4000, 0, 0, 3, 3, 0, 80, 170, 20, 'dfdf', 'Admin', 1991129, '[[0,0]]', 'Desempregado', 0, 'Desconhecido', 0, 0, 'Desconhecido', '0', 13, '0', '0', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'vestblack,player_face,jeansdenim,sneakerbincblk, , , , , , , , , , , , , , ', 'vest,head,jeans,sneaker, , , , , , , , , , , , , , ', ''),
	(14, 'Vitor Martins', 100, 0, 100, 100, 'ferfi', 2, '[ [ 2414.178, 2355.074, 14.12, 0, 0 ] ]', 1500, 4000, 0, 0, 3, 3, 0, 80, 170, 26, 'Sensual', 'Admin', 0, '[[0,0]]', 'Desempregado', 0, 'Desconhecido', 0, 0, 'Desconhecido', '0', 14, '0', '0', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'vest,player_face,player_legs,foot, , , , , , , , , , , , , , ', 'vest,head,legs,feet, , , , , , , , , , , , , , ', '2026-02-17 14:47:54');

-- Copiando estrutura para tabela bgo.chat
CREATE TABLE IF NOT EXISTS `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner` int NOT NULL,
  `targetid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.chat: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.colordoc
CREATE TABLE IF NOT EXISTS `colordoc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL DEFAULT '[[124,197,118]]',
  `colorHEX` varchar(255) NOT NULL DEFAULT '#7CC576',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.colordoc: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.contacts
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `number` int NOT NULL,
  `owner` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.contacts: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.elevators
CREATE TABLE IF NOT EXISTS `elevators` (
  `id` int NOT NULL AUTO_INCREMENT,
  `x1` float NOT NULL,
  `y1` float NOT NULL,
  `z1` float NOT NULL,
  `x2` float NOT NULL,
  `y2` float NOT NULL,
  `z2` float NOT NULL,
  `interior1` int NOT NULL,
  `dim1` int NOT NULL,
  `interior2` int NOT NULL,
  `dim2` int NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT 'Lift',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.elevators: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.fuels
CREATE TABLE IF NOT EXISTS `fuels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `position` varchar(1024) NOT NULL DEFAULT '[[ 0, 0, 0, -90 ]]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.fuels: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.gamemachine
CREATE TABLE IF NOT EXISTS `gamemachine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pos` varchar(1024) NOT NULL,
  `interior` int NOT NULL DEFAULT '0',
  `dimension` int NOT NULL DEFAULT '0',
  `object` int NOT NULL DEFAULT '0',
  `type` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.gamemachine: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.garages
CREATE TABLE IF NOT EXISTS `garages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `x` int NOT NULL,
  `y` int NOT NULL,
  `z` int NOT NULL,
  `opened` int NOT NULL,
  `vehRot` int NOT NULL,
  `interiorTypeID` int NOT NULL DEFAULT '1',
  `bought` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '2500',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.garages: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.gates
CREATE TABLE IF NOT EXISTS `gates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '-3',
  `interior` int NOT NULL DEFAULT '0',
  `dim` int NOT NULL DEFAULT '0',
  `r` float NOT NULL DEFAULT '0',
  `rx` float NOT NULL DEFAULT '0',
  `ry` float NOT NULL DEFAULT '0',
  `move` float NOT NULL DEFAULT '5',
  `state` int NOT NULL DEFAULT '0',
  `object` int NOT NULL DEFAULT '980',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.gates: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.groupattach
CREATE TABLE IF NOT EXISTS `groupattach` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupID` int NOT NULL,
  `characterID` int NOT NULL,
  `rank` int NOT NULL DEFAULT '1',
  `isLeader` int NOT NULL DEFAULT '0',
  `dutyskin` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.groupattach: ~5 rows (aproximadamente)
INSERT INTO `groupattach` (`id`, `groupID`, `characterID`, `rank`, `isLeader`, `dutyskin`) VALUES
	(1, 1, 2, 1, 0, 0),
	(2, 3, 1, 3, 1, 0),
	(6, 6, 1, 1, 0, 0),
	(8, 6, 4, 1, 0, 0),
	(9, 6, 2, 1, 1, 0);

-- Copiando estrutura para tabela bgo.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `groupID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `type` int NOT NULL,
  `balance` int NOT NULL,
  `rank_1` varchar(255) NOT NULL DEFAULT 'Cargo #1',
  `rank_2` varchar(255) NOT NULL DEFAULT 'Cargo #2',
  `rank_3` varchar(255) NOT NULL DEFAULT 'Cargo #3',
  `rank_4` varchar(255) NOT NULL DEFAULT 'Cargo #4',
  `rank_5` varchar(255) NOT NULL DEFAULT 'Cargo #5',
  `rank_6` varchar(255) NOT NULL DEFAULT 'Cargo #6',
  `rank_7` varchar(255) NOT NULL DEFAULT 'Cargo #7',
  `rank_8` varchar(255) NOT NULL DEFAULT 'Cargo #8',
  `rank_9` varchar(255) NOT NULL DEFAULT 'Cargo #9',
  `rank_10` varchar(255) NOT NULL DEFAULT 'Cargo #10',
  `rank_11` varchar(255) NOT NULL DEFAULT 'Cargo #11',
  `rank_12` varchar(255) NOT NULL DEFAULT 'Cargo #12',
  `rank_13` varchar(255) NOT NULL DEFAULT 'Cargo #13',
  `rank_14` varchar(255) NOT NULL DEFAULT 'Cargo #14',
  `rank_15` varchar(255) NOT NULL DEFAULT 'Cargo #15',
  `rank_1_pay` int NOT NULL DEFAULT '0',
  `rank_2_pay` int NOT NULL DEFAULT '0',
  `rank_3_pay` int NOT NULL DEFAULT '0',
  `rank_4_pay` int NOT NULL DEFAULT '0',
  `rank_5_pay` int NOT NULL DEFAULT '0',
  `rank_6_pay` int NOT NULL DEFAULT '0',
  `rank_7_pay` int NOT NULL DEFAULT '0',
  `rank_8_pay` int NOT NULL DEFAULT '0',
  `rank_9_pay` int NOT NULL DEFAULT '0',
  `rank_10_pay` int NOT NULL DEFAULT '0',
  `rank_11_pay` int NOT NULL DEFAULT '0',
  `rank_12_pay` int NOT NULL DEFAULT '0',
  `rank_13_pay` int NOT NULL DEFAULT '0',
  `rank_14_pay` int NOT NULL DEFAULT '0',
  `rank_15_pay` int NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '4i20 Roleplay',
  PRIMARY KEY (`groupID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.groups: ~5 rows (aproximadamente)
INSERT INTO `groups` (`groupID`, `Name`, `type`, `balance`, `rank_1`, `rank_2`, `rank_3`, `rank_4`, `rank_5`, `rank_6`, `rank_7`, `rank_8`, `rank_9`, `rank_10`, `rank_11`, `rank_12`, `rank_13`, `rank_14`, `rank_15`, `rank_1_pay`, `rank_2_pay`, `rank_3_pay`, `rank_4_pay`, `rank_5_pay`, `rank_6_pay`, `rank_7_pay`, `rank_8_pay`, `rank_9_pay`, `rank_10_pay`, `rank_11_pay`, `rank_12_pay`, `rank_13_pay`, `rank_14_pay`, `rank_15_pay`, `description`) VALUES
	(1, 'D.R.V.V', 4, 0, 'Cargo #1', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
	(2, 'PC', 1, 0, 'Cargo #1', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
	(3, 'Petrobras', 4, 0, 'Frentista', 'Gerente', 'Dono', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 3000, 5000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
	(5, 'CV', 6, 0, 'Cargo #1', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
	(6, 'Comando Vermelho', 6, 0, 'CV', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay');

-- Copiando estrutura para tabela bgo.hifi
CREATE TABLE IF NOT EXISTS `hifi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pos` varchar(1024) NOT NULL,
  `state` int NOT NULL DEFAULT '0',
  `volume` int NOT NULL DEFAULT '1',
  `radio` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.hifi: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.identity
CREATE TABLE IF NOT EXISTS `identity` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `cardID` int NOT NULL,
  `Skin` int NOT NULL,
  `Lejarat` date NOT NULL,
  `keszitett` date NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Owner` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.identity: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.interiors
CREATE TABLE IF NOT EXISTS `interiors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `owner` int DEFAULT NULL,
  `locked` tinyint NOT NULL DEFAULT '0',
  `cost` int DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `interior` int DEFAULT NULL,
  `interiorx` float DEFAULT NULL,
  `interiory` float DEFAULT NULL,
  `interiorz` float DEFAULT NULL,
  `dimensionwithin` int DEFAULT NULL,
  `interiorwithin` int DEFAULT NULL,
  `angle` float DEFAULT NULL,
  `angleexit` float DEFAULT NULL,
  `max_items` int DEFAULT NULL,
  `fee` int DEFAULT '0',
  `disabled` tinyint DEFAULT '0',
  `safepositionX` float DEFAULT NULL,
  `safepositionY` float DEFAULT NULL,
  `safepositionZ` float DEFAULT NULL,
  `safepositionRZ` float DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `supplies` int NOT NULL DEFAULT '250000',
  `intid` int NOT NULL DEFAULT '0',
  `outint` int NOT NULL DEFAULT '0',
  `outdim` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.interiors: 0 rows
/*!40000 ALTER TABLE `interiors` DISABLE KEYS */;
/*!40000 ALTER TABLE `interiors` ENABLE KEYS */;

-- Copiando estrutura para tabela bgo.itemlist
CREATE TABLE IF NOT EXISTS `itemlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_owner` int NOT NULL,
  `item_type` varchar(30) NOT NULL,
  `item_id` int NOT NULL,
  `item_slot` int NOT NULL,
  `item_value` varchar(128) NOT NULL DEFAULT '0',
  `item_count` int NOT NULL,
  `item_duty` int NOT NULL,
  `item_health` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.itemlist: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemid` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `count` varchar(255) DEFAULT NULL,
  `slot` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `dutyitem` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `actionslot` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=323 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.items: 34 rows
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `itemid`, `value`, `count`, `slot`, `type`, `dutyitem`, `owner`, `actionslot`) VALUES
	(37, '18', '1', '1', '1', '1', '0', '4', NULL),
	(56, '361', '1', '1', '3', '0', '0', '2', '1'),
	(67, '302', '1', '1', '5', '0', '0', '2', '0'),
	(71, '9', '1', '1', '2', '0', '0', '1', NULL),
	(90, '19', '10', '1', '1', '0', '0', '2', NULL),
	(93, '29', '[ [ "Admin", "244PECD", 1, "2022.03.27." ] ]', '1', '1', '0', '0', '4', NULL),
	(112, '126', '50020176', '1', '1', '0', '0', '4', '6'),
	(114, '339', '15416255', '1', '2', '0', '0', '4', '1'),
	(115, '338', '36890435', '1', '3', '0', '0', '4', '2'),
	(138, '16', '1', '1', '3', '0', '0', '1', NULL),
	(163, '7', '1', '1', '3', '0', '0', '4', NULL),
	(164, '5', '1', '1', '4', '0', '0', '4', NULL),
	(173, '29', '[ [ "[GM]Fulano", "291UCJH", 0, "2022.03.27." ] ]', '1', '2', '0', '0', '2', NULL),
	(185, '112', '1', '1', '3', '0', '0', '2', NULL),
	(235, '29', '[ [ "dfdf", "230DDJV", 0, "2022.03.29." ] ]', '1', '1', '0', '0', '13', NULL),
	(257, '151', '1', '1', '6', '0', '0', '2', NULL),
	(284, '67', '1', '1', '5', '0', '0', '2', NULL),
	(289, '110', '1', '1', '1', '0', '0', '2', NULL),
	(292, '66', '1', '1', '4', '0', '0', '2', NULL),
	(302, '139', '1', '1', '29', '0', '0', '2', NULL),
	(303, '1', '1', '1', '7', '0', '0', '2', NULL),
	(304, '66', '1', '1', '8', '0', '0', '2', NULL),
	(305, '133', '1', '1', '1', '0', '0', '2', NULL),
	(306, '151', '1', '1', '9', '0', '0', '2', NULL),
	(307, '151', '60176736', '1', '1', '0', '0', '1', NULL),
	(308, '151', '95369324', '1', '4', '0', '0', '1', NULL),
	(309, '1', '1', '1', '5', '0', '0', '1', NULL),
	(310, '1', '1', '1', '6', '0', '0', '1', NULL),
	(313, '22', '1', '900', '9', '0', '1', '1', NULL),
	(315, '22', '1', '5400', '10', '0', '0', '1', NULL),
	(316, '282', '1', '1', '11', '0', '0', '1', NULL),
	(317, '282', '1', '1', '12', '0', '0', '1', NULL),
	(320, '303', '1', '1', '2', '0', '0', '2', '2'),
	(321, '29', '[ [ "BUGG", "172KTDN", 0, "2022.03.26." ] ]', '1', '7', '0', '0', '1', NULL),
	(322, '29', '[ [ "Vitor Martins", "296KJHI", 0, "2026.03.17." ] ]', '1', '1', '0', '0', '14', NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Copiando estrutura para tabela bgo.itemsworld
CREATE TABLE IF NOT EXISTS `itemsworld` (
  `id` int NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `dimension` int NOT NULL DEFAULT '0',
  `interior` int NOT NULL DEFAULT '0',
  `model` int NOT NULL DEFAULT '0',
  `item` int NOT NULL DEFAULT '0',
  `value` varchar(200) NOT NULL,
  `count` int NOT NULL DEFAULT '0',
  `itemState` int NOT NULL DEFAULT '0',
  `name` varchar(200) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `owner` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela bgo.itemsworld: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.job_data
CREATE TABLE IF NOT EXISTS `job_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL DEFAULT '0',
  `data_key` varchar(128) NOT NULL DEFAULT '',
  `data_value` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.job_data: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.killlogs
CREATE TABLE IF NOT EXISTS `killlogs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_hungarian_ci NOT NULL,
  `date` datetime NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.killlogs: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.mdcaccounts
CREATE TABLE IF NOT EXISTS `mdcaccounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `frakcio` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.mdcaccounts: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.mdctickets
CREATE TABLE IF NOT EXISTS `mdctickets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `targetname` varchar(255) NOT NULL,
  `price` int NOT NULL,
  `jailtime` int NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.mdctickets: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.mdcwantedcars
CREATE TABLE IF NOT EXISTS `mdcwantedcars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `modelname` varchar(255) NOT NULL,
  `numberplate` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.mdcwantedcars: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.mdcwantedpersons
CREATE TABLE IF NOT EXISTS `mdcwantedpersons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `charactername` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `leiras` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.mdcwantedpersons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.miner
CREATE TABLE IF NOT EXISTS `miner` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Value` longtext,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela bgo.miner: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.multas
CREATE TABLE IF NOT EXISTS `multas` (
  `id` int NOT NULL,
  `drvv` varchar(100) NOT NULL,
  `dono` varchar(100) NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `placa` varchar(100) NOT NULL,
  `valor` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela bgo.multas: ~6 rows (aproximadamente)
INSERT INTO `multas` (`id`, `drvv`, `dono`, `motivo`, `placa`, `valor`, `nome`) VALUES
	(0, '[GM]Track', '1', 'A', 'UUN-387', '100', '[GM]Track'),
	(0, 'RADAR', '3', 'Passou na velocidade acima de 47 no radar', 'EZL-211', '58', '[GM]BUUG'),
	(0, 'RADAR', '3', 'Passou na velocidade acima de 44 no radar', 'EZL-211', '56', '[GM]BUUG'),
	(0, 'RADAR', '4', 'Passou na velocidade acima de 47 no radar', 'TOA-417', '59', '[DIR]Daddy'),
	(0, 'RADAR', '4', 'Passou na velocidade acima de 64 no radar', 'EZL-211', '80', '[DIR]Daddy'),
	(0, 'RADAR', '4', 'Passou na velocidade acima de 59 no radar', 'EZL-211', '74', '[DIR]Daddy');

-- Copiando estrutura para tabela bgo.namechanges
CREATE TABLE IF NOT EXISTS `namechanges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) NOT NULL,
  `wantedname` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `characterID` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `elfogadva` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` int NOT NULL DEFAULT '1',
  `elfogadta` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.namechanges: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.oldbans
CREATE TABLE IF NOT EXISTS `oldbans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accountID` varchar(100) NOT NULL,
  `bannedBy` varchar(200) NOT NULL,
  `banEnd` varchar(200) NOT NULL,
  `banStart` varchar(200) NOT NULL,
  `playerSerial` varchar(200) NOT NULL,
  `reason` varchar(2000) NOT NULL,
  `playername` varchar(200) NOT NULL,
  `ipadress` varchar(200) NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.oldbans: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.paylog
CREATE TABLE IF NOT EXISTS `paylog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `playername` varchar(200) NOT NULL,
  `playerid` varchar(40) NOT NULL,
  `tevkod` varchar(40) NOT NULL,
  `log` varchar(2000) NOT NULL,
  `targetname` varchar(200) NOT NULL,
  `targetid` varchar(40) NOT NULL,
  `date` varchar(40) NOT NULL,
  `time` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.paylog: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.pets
CREATE TABLE IF NOT EXISTS `pets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'Kutya',
  `type` int NOT NULL DEFAULT '1',
  `owner` int NOT NULL DEFAULT '0',
  `health` int NOT NULL DEFAULT '100',
  `food` int NOT NULL DEFAULT '100',
  `thirsty` int NOT NULL DEFAULT '100',
  `isdead` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.pets: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.phones
CREATE TABLE IF NOT EXISTS `phones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` int NOT NULL,
  `wallpaper` int NOT NULL DEFAULT '1',
  `music` int NOT NULL DEFAULT '1',
  `battery` int NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.phones: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.phone_sms
CREATE TABLE IF NOT EXISTS `phone_sms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fr` int NOT NULL DEFAULT '0',
  `t` int NOT NULL DEFAULT '0',
  `msg` varchar(1024) NOT NULL DEFAULT '',
  `dat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.phone_sms: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.safe
CREATE TABLE IF NOT EXISTS `safe` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Interior` int NOT NULL,
  `Dimension` int NOT NULL,
  `Position` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.safe: ~1 rows (aproximadamente)
INSERT INTO `safe` (`ID`, `Interior`, `Dimension`, `Position`) VALUES
	(10, 10, 2, '[ [ 2262.408203125, -1222.40234375, 1048.5234375, 0, 0, 90.40789794921875 ] ]');

-- Copiando estrutura para tabela bgo.safes
CREATE TABLE IF NOT EXISTS `safes` (
  `x` int NOT NULL,
  `y` int NOT NULL,
  `z` int NOT NULL,
  `rx` int NOT NULL,
  `ry` int NOT NULL,
  `rz` int NOT NULL,
  `interior` int NOT NULL,
  `dimension` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `owner` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.safes: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.serialchanges
CREATE TABLE IF NOT EXISTS `serialchanges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mtaserial` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accountID` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `elfogadva` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` int NOT NULL,
  `elfogadta` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.serialchanges: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.shops
CREATE TABLE IF NOT EXISTS `shops` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL,
  `pos` varchar(255) NOT NULL DEFAULT '[[ 0, 0, 0, 0 ]]',
  `skin` int NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Desconhecido',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.shops: ~2 rows (aproximadamente)
INSERT INTO `shops` (`id`, `type`, `pos`, `skin`, `name`) VALUES
	(15, 1, '[ [ 1487.27734375, -1906.7509765625, 22.23081588745117, 0, 0, 87.69692993164063 ] ]', 1, 'vida'),
	(16, 2, '[ [ 1487.4775390625, -1900.8935546875, 22.22964477539063, 0, 0, 90.70175170898438 ] ]', 1, 'arma');

-- Copiando estrutura para tabela bgo.smslog
CREATE TABLE IF NOT EXISTS `smslog` (
  `id` int NOT NULL,
  `ar` text NOT NULL,
  `tel` text NOT NULL,
  `kuldo` text NOT NULL,
  `uzi` text NOT NULL,
  `chname` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.smslog: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.sms_log
CREATE TABLE IF NOT EXISTS `sms_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `netFizID` bigint NOT NULL DEFAULT '-1',
  `tel` varchar(32) NOT NULL DEFAULT 'undefinied',
  `value` int NOT NULL DEFAULT '0',
  `text` varchar(32) NOT NULL DEFAULT '-1',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.sms_log: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.szefek
CREATE TABLE IF NOT EXISTS `szefek` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pos` varchar(500) NOT NULL DEFAULT '[[ 0,0,0,0,0,0,0,0 ]]',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.szefek: 0 rows
/*!40000 ALTER TABLE `szefek` DISABLE KEYS */;
/*!40000 ALTER TABLE `szefek` ENABLE KEYS */;

-- Copiando estrutura para tabela bgo.ucp_news
CREATE TABLE IF NOT EXISTS `ucp_news` (
  `id` int NOT NULL,
  `title` varchar(64) NOT NULL,
  `content` text NOT NULL,
  `creator` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.ucp_news: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.ucp_serial
CREATE TABLE IF NOT EXISTS `ucp_serial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` text,
  `acc` int NOT NULL,
  `serialchangeid` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.ucp_serial: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.utlevelek
CREATE TABLE IF NOT EXISTS `utlevelek` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `cardID` int NOT NULL,
  `Skin` int NOT NULL,
  `Lejarat` date NOT NULL,
  `keszitett` date NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Owner` int NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.utlevelek: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela bgo.vehicle
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `model` int NOT NULL,
  `pos` varchar(255) NOT NULL DEFAULT '[[ -2322.2243652344, -1644.830078125, 483.703125, 0, 0, 0 ]]',
  `interior` varchar(255) NOT NULL DEFAULT '0',
  `dimension` varchar(255) NOT NULL DEFAULT '0',
  `fuel` int NOT NULL DEFAULT '100',
  `hp` int NOT NULL DEFAULT '1000',
  `motor` int NOT NULL DEFAULT '0',
  `color` varchar(1024) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]',
  `owner` int NOT NULL,
  `nitro` int NOT NULL DEFAULT '0',
  `lefoglalva` int NOT NULL DEFAULT '0',
  `engine` int NOT NULL DEFAULT '1',
  `turbo` int NOT NULL DEFAULT '1',
  `gearbox` int NOT NULL DEFAULT '1',
  `suspensions` int NOT NULL DEFAULT '1',
  `ecu` int NOT NULL DEFAULT '1',
  `tires` int NOT NULL DEFAULT '1',
  `brakes` int NOT NULL DEFAULT '1',
  `weightReduction` int NOT NULL DEFAULT '1',
  `lightColor` varchar(255) NOT NULL DEFAULT '[ [255, 255, 255] ]',
  `OpticalUpgrade` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]',
  `paintjob` int NOT NULL DEFAULT '0',
  `variant` int NOT NULL DEFAULT '255',
  `neon` varchar(255) NOT NULL DEFAULT '0',
  `wheelSize_rear` int NOT NULL DEFAULT '0',
  `wheelSize_front` int NOT NULL DEFAULT '0',
  `steeringLock` int NOT NULL DEFAULT '0',
  `driveType` int NOT NULL DEFAULT '1',
  `airride` int NOT NULL DEFAULT '0',
  `LSDDoor` int NOT NULL DEFAULT '0',
  `traveled` int NOT NULL DEFAULT '0',
  `trafiradar` int NOT NULL DEFAULT '0',
  `optimalization` int NOT NULL DEFAULT '0',
  `opticalTunings` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]',
  `performanceTuning` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0 ]]',
  `oilstate` float NOT NULL DEFAULT '0',
  `rendszam` varchar(25) NOT NULL DEFAULT '000-000',
  `panel` varchar(255) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0, 0 ]]',
  `wheel` varchar(255) NOT NULL DEFAULT '[[ 0, 0, 0, 0 ]]',
  `door` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0 ]]',
  `status` int NOT NULL DEFAULT '0',
  `lampa` int NOT NULL DEFAULT '0',
  `faction` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.vehicle: ~8 rows (aproximadamente)
INSERT INTO `vehicle` (`id`, `model`, `pos`, `interior`, `dimension`, `fuel`, `hp`, `motor`, `color`, `owner`, `nitro`, `lefoglalva`, `engine`, `turbo`, `gearbox`, `suspensions`, `ecu`, `tires`, `brakes`, `weightReduction`, `lightColor`, `OpticalUpgrade`, `paintjob`, `variant`, `neon`, `wheelSize_rear`, `wheelSize_front`, `steeringLock`, `driveType`, `airride`, `LSDDoor`, `traveled`, `trafiradar`, `optimalization`, `opticalTunings`, `performanceTuning`, `oilstate`, `rendszam`, `panel`, `wheel`, `door`, `status`, `lampa`, `faction`) VALUES
	(4, 561, '[ [ 2137.8720703125, 1434.0634765625, 10.65019702911377, 79, 27983 ] ]', '0', '0', 69, 969, 0, '[ [ 219, 10, 91, 0, 0, 0 ] ]', 2, 0, 0, 5, 5, 5, 1, 5, 1, 5, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1082, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 30, 2, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'AJN-666', '[ [ 1, 0, 0, 0, 0, 1, 1 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 2, 0, 0, 0, 0 ] ]', 1, 1, 0),
	(5, 483, '[ [ 1948.1025390625, -1810.0478515625, 13.64985942840576, 29, 15901 ] ]', '0', '0', 97, 1000, 0, '[ [ 251, 9, 220, 0, 0, 0 ] ]', 1, 0, 0, 5, 5, 5, 1, 5, 5, 5, 1, '[ [ 96, 248, 252 ] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1087, 0, 0, 1077, 0, 0, 0 ] ]', 0, 255, 'ice', 0, 8, 0, 2, 1, 1, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'UUN-387', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0),
	(6, 418, '[ [ 2138.5078125, 1433.16796875, 10.64899444580078, 87, 27479 ] ]', '0', '0', 9, 1000, 0, '[ [ 0, 0, 0, 0, 0, 0 ] ]', 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'NFV-662', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0),
	(7, 522, '[ [ 2792.455078125, -1603.9013671875, 10.51559829711914, 0, 1317 ] ]', '0', '0', 7, 982, 0, '[ [ 255, 204, 0, 0, 0, 0 ] ]', 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'EZL-211', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 1, 0),
	(8, 500, '[ [ 2792.44140625, -1603.896484375, 10.829833984375, 0, 9956 ] ]', '0', '0', 5, 1000, 0, '[ [ 255, 204, 0, 0, 0, 0 ] ]', 2, 0, 0, 5, 1, 5, 1, 5, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1087, 0, 0, 1073, 0, 0, 0 ] ]', 0, 255, 'white', 0, 0, 0, 2, 1, 1, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'UBC-478', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0),
	(9, 496, '[ [ 2503.8525390625, -2013.6142578125, 12.89653968811035, 0, 0 ] ]', '0', '0', 47, 963, 0, '[ [ 255, 255, 255, 0, 0, 0 ] ]', 2, 0, 0, 5, 5, 5, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1074, 0, 0, 0 ] ]', 0, 255, '0', 1, 2, 0, 1, 1, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'AGK-681', '[ [ 1, 0, 0, 0, 0, 1, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 0, 1, 0),
	(10, 2, '[ [ 2435.24609375, -2086.1455078125, 13.546875, 0, 0 ] ]', '0', '0', 10, 1000, 0, '[ [ 255, 255, 255, 0, 0, 0 ] ]', 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'OMY-776', '[[ 0, 0, 0, 0, 0, 0, 0 ]]', '[[ 0, 0, 0, 0 ]]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 0, 0),
	(11, 541, '[ [ 1099.6123046875, -1775.2783203125, 12.99890518188477, 239, 57583 ] ]', '0', '0', 39, 936, 0, '[ [ 95, 1, 0, 0, 0, 0 ] ]', 4, 0, 0, 5, 5, 5, 1, 5, 5, 5, 1, '[ [ 22, 158, 238 ] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1087, 0, 0, 1074, 0, 0, 0 ] ]', 0, 255, '0', 8, 8, 0, 1, 1, 1, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'TOA-417', '[ [ 1, 0, 0, 0, 1, 2, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0);

-- Copiando estrutura para tabela bgo.vehicleitem
CREATE TABLE IF NOT EXISTS `vehicleitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemID` int NOT NULL,
  `owner` int NOT NULL,
  `itemDB` int NOT NULL,
  `slot` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela bgo.vehicleitem: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
