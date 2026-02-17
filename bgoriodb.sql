-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 03-Mar-2022 às 05:33
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bgo`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `mtaserial` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL DEFAULT 0,
  `adminStats` varchar(4096) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0 ]]',
  `regdate` timestamp NULL DEFAULT NULL,
  `lastlogin` timestamp NULL DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT 'Desconhecido',
  `aseged` int(11) NOT NULL DEFAULT 0,
  `online` varchar(10) NOT NULL DEFAULT '0',
  `guard` varchar(40) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `password`, `mtaserial`, `ip`, `admin`, `adminStats`, `regdate`, `lastlogin`, `email`, `aseged`, `online`, `guard`) VALUES
(1, 'Track', 'B996D2FC5B611D6ED9BDCAD5880A4662', 'A3A3968925B5CE5CFE4A1315C77B87F3', '132.255.45.165', 10, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 00:10:34', '2022-03-03 04:28:00', 'Desconhecido', 0, '1', '0'),
(2, 'CRUZZ', 'C92237209C06079925514CF31471A417', 'E5421724A5DE3AB97CF4D0F9CD8595B3', '200.146.213.42', 10, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 00:19:01', '2022-03-03 04:09:00', 'Desconhecido', 0, '0', '0'),
(3, 'big', '5B636320B03503D3C8F40D8D11A80D29', 'F4AC7F44BDB3D25D80A99505301E0492', '187.121.146.243', 10, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 00:42:58', '2022-03-03 04:28:00', 'Desconhecido', 0, '1', '0'),
(4, 'daddy', '093EC71F562BA6CBF5825B7C9A48F19E', '728B514592554F20BF15A7B3497978B2', '177.133.28.229', 8, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-27 20:10:29', '2022-03-03 02:43:00', 'Desconhecido', 0, '0', '0'),
(5, 'TrovaoJN', '58AA35992E19DA7EEC3B499E48F5956B', 'C7AEBAD68C1E092E6F558BCBEBCAFB93', '45.168.114.220', 9, '[[ 0, 0, 0, 0, 0, 0 ]]', '2022-02-28 06:56:20', '2022-02-28 07:08:00', 'Desconhecido', 0, '0', '0');

-- --------------------------------------------------------

--
-- Estrutura da tabela `actionbaritems`
--

CREATE TABLE `actionbaritems` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL DEFAULT 0,
  `itemdbid` int(11) NOT NULL DEFAULT 0,
  `item` int(11) NOT NULL DEFAULT 0,
  `category` varchar(300) NOT NULL,
  `actionslot` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `actionslot`
--

CREATE TABLE `actionslot` (
  `id` int(11) NOT NULL,
  `slot` int(11) NOT NULL DEFAULT -1,
  `item` int(11) NOT NULL DEFAULT -1,
  `value` int(11) NOT NULL DEFAULT -1,
  `count` int(11) NOT NULL DEFAULT -1,
  `owner` int(11) NOT NULL DEFAULT -1,
  `type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `adminjails`
--

CREATE TABLE `adminjails` (
  `id` int(100) NOT NULL,
  `jailed_player` varchar(100) NOT NULL,
  `jailed_playerSerial` varchar(100) NOT NULL,
  `jailed_accountID` varchar(50) NOT NULL,
  `jailed_admin` varchar(100) NOT NULL,
  `jailed_adminSerial` varchar(100) NOT NULL,
  `jailed_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `jailed_ido` int(100) NOT NULL,
  `jailed_idopont` varchar(100) NOT NULL,
  `jailed_idopontora` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `adminlog`
--

CREATE TABLE `adminlog` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `adminacc_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `tevkod` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `chatlog` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `target_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL,
  `targetacc_id` varchar(100) NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `admin_warns`
--

CREATE TABLE `admin_warns` (
  `id` int(10) NOT NULL,
  `addedby` varchar(100) NOT NULL,
  `reason` varchar(2000) NOT NULL,
  `admin` varchar(100) NOT NULL,
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `atms`
--

CREATE TABLE `atms` (
  `id` int(10) NOT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `dimension` int(11) DEFAULT NULL,
  `interior` int(11) DEFAULT NULL,
  `rotation` float DEFAULT NULL,
  `deposit` int(11) DEFAULT 0,
  `maxLimit` int(11) DEFAULT 5000
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `atms`
--

INSERT INTO `atms` (`id`, `x`, `y`, `z`, `dimension`, `interior`, `rotation`, `deposit`, `maxLimit`) VALUES
(28, 1090.82, -1800.07, 13.203, 0, 0, 180.898, 0, 5000),
(26, 2645.31, 1129.67, 10.7797, 0, 0, -8.78369, 0, 5000),
(31, 1001.73, -929.151, 41.9281, 0, 0, -81.2451, 0, 5000);

-- --------------------------------------------------------

--
-- Estrutura da tabela `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `accountID` int(11) NOT NULL,
  `bannedBy` varchar(50) NOT NULL,
  `timeZone` varchar(255) NOT NULL,
  `Date` varchar(255) NOT NULL,
  `playerSerial` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `playername` varchar(50) NOT NULL,
  `ipadress` varchar(40) NOT NULL,
  `status` varchar(40) NOT NULL,
  `adminID` int(11) NOT NULL,
  `unbanReason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `bins`
--

CREATE TABLE `bins` (
  `id` int(11) NOT NULL,
  `pos` varchar(500) NOT NULL DEFAULT '[[ 0,0,0,0,0,0,0,0 ]]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `bins`
--

INSERT INTO `bins` (`id`, `pos`) VALUES
(68, '[ [ -2820.5146484375, -1526.85546875, 140.84375, 0, 0, 279.7299194335938, 0, 0 ] ]'),
(69, '[ [ 1090.8212890625, -1794.53125, 13.62193965911865, 0, 0, 274.0224304199219, 0, 0 ] ]');

-- --------------------------------------------------------

--
-- Estrutura da tabela `changelog`
--

CREATE TABLE `changelog` (
  `id` int(11) NOT NULL,
  `msg` varchar(255) NOT NULL DEFAULT 'Nenhuma mensagem especificada!',
  `Date` date DEFAULT NULL,
  `irta` varchar(255) NOT NULL DEFAULT 'Nenhum autor especificado!'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `charname` varchar(255) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT 100,
  `armor` int(11) NOT NULL DEFAULT 0,
  `drink` int(11) NOT NULL DEFAULT 100,
  `hunger` int(11) NOT NULL DEFAULT 100,
  `gender` text NOT NULL,
  `skin` int(11) NOT NULL,
  `pos` varchar(255) NOT NULL,
  `money` bigint(20) NOT NULL DEFAULT 1500,
  `bankmoney` bigint(20) NOT NULL DEFAULT 4000,
  `slotCoin` bigint(20) NOT NULL DEFAULT 0,
  `premiumpont` bigint(20) NOT NULL DEFAULT 0,
  `carSlot` int(11) NOT NULL DEFAULT 3,
  `houseSlot` int(11) NOT NULL DEFAULT 3,
  `adminduty` int(11) NOT NULL DEFAULT 0,
  `suly` int(11) NOT NULL,
  `magassag` int(11) NOT NULL,
  `eletkor` int(11) NOT NULL,
  `leiras` varchar(255) NOT NULL,
  `anick` varchar(255) NOT NULL DEFAULT 'Admin',
  `playedTime` int(11) NOT NULL DEFAULT 0,
  `License` varchar(255) NOT NULL DEFAULT '[[0,0]]' COMMENT '1: Car | 2: Weapon',
  `job` varchar(255) NOT NULL DEFAULT 'Desempregado',
  `adminjail` int(10) NOT NULL DEFAULT 0,
  `adminjail_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'Desconhecido',
  `adminjail_idoTelik` int(10) NOT NULL DEFAULT 0,
  `adminjail_alapIdo` int(10) NOT NULL DEFAULT 0,
  `adminjail_admin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci NOT NULL DEFAULT 'Desconhecido',
  `adminjail_adminSerial` varchar(100) NOT NULL DEFAULT '0',
  `account` int(10) NOT NULL,
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
  `cuffed` int(11) NOT NULL DEFAULT 0,
  `walkStyle` int(11) NOT NULL DEFAULT 118,
  `fightStyle` int(11) NOT NULL DEFAULT 4,
  `lastSpin` bigint(20) DEFAULT 0,
  `Level` int(255) NOT NULL DEFAULT 0,
  `LevelEXP` int(255) NOT NULL DEFAULT 1,
  `cj` varchar(500) NOT NULL DEFAULT 'vest,player_face,player_legs,foot, , , , , , , , , , , , , , ',
  `cjm` varchar(500) NOT NULL DEFAULT 'vest,head,legs,feet, , , , , , , , , , , , , , ',
  `data` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `characters`
--

INSERT INTO `characters` (`id`, `charname`, `hp`, `armor`, `drink`, `hunger`, `gender`, `skin`, `pos`, `money`, `bankmoney`, `slotCoin`, `premiumpont`, `carSlot`, `houseSlot`, `adminduty`, `suly`, `magassag`, `eletkor`, `leiras`, `anick`, `playedTime`, `License`, `job`, `adminjail`, `adminjail_reason`, `adminjail_idoTelik`, `adminjail_alapIdo`, `adminjail_admin`, `adminjail_adminSerial`, `account`, `rfrekvencia`, `adutyTime`, `dutySkin`, `jailed`, `jailed_player`, `jailed_reason`, `jailed_idoTelik`, `jailed_alapIdo`, `buscode`, `weapon_skills`, `cuffed`, `walkStyle`, `fightStyle`, `lastSpin`, `Level`, `LevelEXP`, `cj`, `cjm`, `data`) VALUES
(1, 'Track', 57, 0, 0, 21, 'ferfi', 158, '[ [ 1723.177734375, -1721.2216796875, 13.54661178588867, 0, 0 ] ]', 1975090, 4000, 0, 929002, 3, 3, 0, 80, 170, 18, '171', '[CEO]Track', 5376649, '[[0,0]]', 'SemEmprego', 0, '0', 0, 0, '0', '0', 1, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'tshirtilovels,player_face,shortsgrey,sandalsock, , , , , , , , , ,neckgold,watchyellow,bandgang3, , ', 'tshirt,head,shorts,flipflop, , , , , , , , , ,neck2,watch,bandmask, , ', '2022-03-03 01:28'),
(2, 'CRUZZ', 71, 0, 3, 10, 'ferfi', 2, '[ [ 2342.771484375, 1394.7099609375, 42.81559753417969, 0, 0 ] ]', 2831838207482, 0, 0, 1, 13, 3, 0, 80, 170, 19, 'RealCrya', '[CEO]Mineiro', 1244307, '[[0,0]]', 'SemEmprego', 0, '0', 0, 0, '0', '0', 2, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 1, 50, 'player_torso,highfade,jeansdenim,foot, , , , , , , , , ,neckropes, ,bandblack3, , ', 'torso,head,jeans,feet, , , , , , , , , ,neck2, ,bandmask, , ', ''),
(3, 'BUGG', 100, 0, 11, 10, 'ferfi', 1, '[ [ 1856.623046875, -1751.2490234375, 13.3828125, 0, 0 ] ]', -9223372036854767616, 1000, 0, 128500, 7, 3, 0, 80, 170, 22, 'Honest', '[CEO]BUUG', 8775461, '[[0,0]]', 'SemEmprego', 0, '0', 0, 0, '0', '0', 3, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 1, 270, 'vestblack,player_face,jeansdenim,sneakerbincblk, , , , , , , , , , , , , , ', 'vest,head,jeans,sneaker, , , , , , , , , , , , , , ', '2022-03-03 01:28'),
(4, 'Daddy', 81, 90, 38, 49, 'ferfi', 104, '[ [ 1550.677734375, 2571.9501953125, 10.8203125, 0, 0 ] ]', 40218, 4000, 0, 23918321766232, 3, 3, 1, 80, 170, 19, 'pokas', '[DIR]Daddy', 7183887, '[[0,0]]', 'ifood', 0, '0', 0, 0, '0', '0', 4, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 1, 180, 'tshirt2horiz,player_face,tracktr,sandalsock, , , , , , , , , ,neckgold,watchsub2, , , ', 'tshirt2,head,tracktr,flipflop, , , , , , , , , ,neck2,watch, , , ', ''),
(5, 'Trovao JN', 100, 0, 100, 100, 'ferfi', 1, '[ [ 1936.8251953125, -1796.2880859375, 13.65536594390869, 0, 0 ] ]', 2000, 4000, 0, 0, 3, 3, 1, 80, 170, 21, '157', '[CO]TrovaoJN', 4760310, '[[0,0]]', 'Desempregado', 0, 'Desconhecido', 0, 0, 'Desconhecido', '0', 5, '0', '1', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'vestblack,player_face,jeansdenim,sneakerbincblk, , , , , , , , , , , , , , ', 'vest,head,jeans,sneaker, , , , , , , , , , , , , , ', ''),
(13, 'dfdf', 100, 0, 73, 75, 'ferfi', 2, '[ [ 1082.189453125, -1771.7841796875, 13.35281944274902, 0, 0 ] ]', 2000, 4000, 0, 0, 3, 3, 0, 80, 170, 20, 'dfdf', 'Admin', 1991129, '[[0,0]]', 'Desempregado', 0, 'Desconhecido', 0, 0, 'Desconhecido', '0', 13, '0', '0', '0', '0', 'Desconhecido', 'Desconhecido', '0', '0', '0', '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]', 0, 118, 4, 0, 0, 1, 'vestblack,player_face,jeansdenim,sneakerbincblk, , , , , , , , , , , , , , ', 'vest,head,jeans,sneaker, , , , , , , , , , , , , , ', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `owner` int(255) NOT NULL,
  `targetid` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `colordoc`
--

CREATE TABLE `colordoc` (
  `id` int(11) NOT NULL,
  `serial` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL DEFAULT '[[124,197,118]]',
  `colorHEX` varchar(255) NOT NULL DEFAULT '#7CC576'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` int(255) NOT NULL,
  `owner` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `elevators`
--

CREATE TABLE `elevators` (
  `id` int(11) NOT NULL,
  `x1` float NOT NULL,
  `y1` float NOT NULL,
  `z1` float NOT NULL,
  `x2` float NOT NULL,
  `y2` float NOT NULL,
  `z2` float NOT NULL,
  `interior1` int(11) NOT NULL,
  `dim1` int(11) NOT NULL,
  `interior2` int(11) NOT NULL,
  `dim2` int(11) NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT 'Lift'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fuels`
--

CREATE TABLE `fuels` (
  `id` int(11) NOT NULL,
  `position` varchar(1024) NOT NULL DEFAULT '[[ 0, 0, 0, -90 ]]'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `gamemachine`
--

CREATE TABLE `gamemachine` (
  `id` int(11) NOT NULL,
  `pos` varchar(1024) NOT NULL,
  `interior` int(11) NOT NULL DEFAULT 0,
  `dimension` int(11) NOT NULL DEFAULT 0,
  `object` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `garages`
--

CREATE TABLE `garages` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `opened` int(11) NOT NULL,
  `vehRot` int(11) NOT NULL,
  `interiorTypeID` int(11) NOT NULL DEFAULT 1,
  `bought` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 2500
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `gates`
--

CREATE TABLE `gates` (
  `id` int(11) NOT NULL,
  `x` float NOT NULL DEFAULT 0,
  `y` float NOT NULL DEFAULT 0,
  `z` float NOT NULL DEFAULT -3,
  `interior` int(11) NOT NULL DEFAULT 0,
  `dim` int(11) NOT NULL DEFAULT 0,
  `r` float NOT NULL DEFAULT 0,
  `rx` float NOT NULL DEFAULT 0,
  `ry` float NOT NULL DEFAULT 0,
  `move` float NOT NULL DEFAULT 5,
  `state` int(11) NOT NULL DEFAULT 0,
  `object` int(11) NOT NULL DEFAULT 980
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `groupattach`
--

CREATE TABLE `groupattach` (
  `id` int(11) NOT NULL,
  `groupID` int(11) NOT NULL,
  `characterID` int(11) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `isLeader` int(11) NOT NULL DEFAULT 0,
  `dutyskin` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `groupattach`
--

INSERT INTO `groupattach` (`id`, `groupID`, `characterID`, `rank`, `isLeader`, `dutyskin`) VALUES
(1, 1, 2, 1, 0, 0),
(2, 3, 1, 3, 1, 0),
(6, 6, 1, 1, 0, 0),
(8, 6, 4, 1, 0, 0),
(9, 6, 2, 1, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `groups`
--

CREATE TABLE `groups` (
  `groupID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `balance` int(11) NOT NULL,
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
  `rank_1_pay` int(11) NOT NULL DEFAULT 0,
  `rank_2_pay` int(11) NOT NULL DEFAULT 0,
  `rank_3_pay` int(11) NOT NULL DEFAULT 0,
  `rank_4_pay` int(11) NOT NULL DEFAULT 0,
  `rank_5_pay` int(11) NOT NULL DEFAULT 0,
  `rank_6_pay` int(11) NOT NULL DEFAULT 0,
  `rank_7_pay` int(11) NOT NULL DEFAULT 0,
  `rank_8_pay` int(11) NOT NULL DEFAULT 0,
  `rank_9_pay` int(11) NOT NULL DEFAULT 0,
  `rank_10_pay` int(11) NOT NULL DEFAULT 0,
  `rank_11_pay` int(11) NOT NULL DEFAULT 0,
  `rank_12_pay` int(11) NOT NULL DEFAULT 0,
  `rank_13_pay` int(11) NOT NULL DEFAULT 0,
  `rank_14_pay` int(11) NOT NULL DEFAULT 0,
  `rank_15_pay` int(11) NOT NULL DEFAULT 0,
  `description` varchar(255) NOT NULL DEFAULT '4i20 Roleplay'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `groups`
--

INSERT INTO `groups` (`groupID`, `Name`, `type`, `balance`, `rank_1`, `rank_2`, `rank_3`, `rank_4`, `rank_5`, `rank_6`, `rank_7`, `rank_8`, `rank_9`, `rank_10`, `rank_11`, `rank_12`, `rank_13`, `rank_14`, `rank_15`, `rank_1_pay`, `rank_2_pay`, `rank_3_pay`, `rank_4_pay`, `rank_5_pay`, `rank_6_pay`, `rank_7_pay`, `rank_8_pay`, `rank_9_pay`, `rank_10_pay`, `rank_11_pay`, `rank_12_pay`, `rank_13_pay`, `rank_14_pay`, `rank_15_pay`, `description`) VALUES
(1, 'D.R.V.V', 4, 0, 'Cargo #1', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
(2, 'PC', 1, 0, 'Cargo #1', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
(3, 'Petrobras', 4, 0, 'Frentista', 'Gerente', 'Dono', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 3000, 5000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
(5, 'CV', 6, 0, 'Cargo #1', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay'),
(6, 'Comando Vermelho', 6, 0, 'CV', 'Cargo #2', 'Cargo #3', 'Cargo #4', 'Cargo #5', 'Cargo #6', 'Cargo #7', 'Cargo #8', 'Cargo #9', 'Cargo #10', 'Cargo #11', 'Cargo #12', 'Cargo #13', 'Cargo #14', 'Cargo #15', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '4i20 Roleplay');

-- --------------------------------------------------------

--
-- Estrutura da tabela `hifi`
--

CREATE TABLE `hifi` (
  `id` int(11) NOT NULL,
  `pos` varchar(1024) NOT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `volume` int(11) NOT NULL DEFAULT 1,
  `radio` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `identity`
--

CREATE TABLE `identity` (
  `ID` int(11) NOT NULL,
  `cardID` int(11) NOT NULL,
  `Skin` int(11) NOT NULL,
  `Lejarat` date NOT NULL,
  `keszitett` date NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `interiors`
--

CREATE TABLE `interiors` (
  `id` int(10) NOT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `locked` tinyint(4) NOT NULL DEFAULT 0,
  `cost` int(15) DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `interior` int(11) DEFAULT NULL,
  `interiorx` float DEFAULT NULL,
  `interiory` float DEFAULT NULL,
  `interiorz` float DEFAULT NULL,
  `dimensionwithin` int(11) DEFAULT NULL,
  `interiorwithin` int(11) DEFAULT NULL,
  `angle` float DEFAULT NULL,
  `angleexit` float DEFAULT NULL,
  `max_items` int(11) DEFAULT NULL,
  `fee` int(10) DEFAULT 0,
  `disabled` tinyint(4) DEFAULT 0,
  `safepositionX` float DEFAULT NULL,
  `safepositionY` float DEFAULT NULL,
  `safepositionZ` float DEFAULT NULL,
  `safepositionRZ` float DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `supplies` int(11) NOT NULL DEFAULT 250000,
  `intid` int(11) NOT NULL DEFAULT 0,
  `outint` int(11) NOT NULL DEFAULT 0,
  `outdim` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `itemlist`
--

CREATE TABLE `itemlist` (
  `id` int(11) NOT NULL,
  `item_owner` int(11) NOT NULL,
  `item_type` varchar(30) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_slot` int(11) NOT NULL,
  `item_value` varchar(128) NOT NULL DEFAULT '0',
  `item_count` int(11) NOT NULL,
  `item_duty` int(11) NOT NULL,
  `item_health` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `items`
--

CREATE TABLE `items` (
  `id` int(10) NOT NULL,
  `itemid` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `count` varchar(255) DEFAULT NULL,
  `slot` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `dutyitem` varchar(255) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `actionslot` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `items`
--

INSERT INTO `items` (`id`, `itemid`, `value`, `count`, `slot`, `type`, `dutyitem`, `owner`, `actionslot`) VALUES
(93, '29', '[ [ \"Admin\", \"244PECD\", 1, \"2022.03.27.\" ] ]', '1', '1', '0', '0', '4', NULL),
(37, '18', '1', '1', '1', '1', '0', '4', NULL),
(235, '29', '[ [ \"dfdf\", \"230DDJV\", 0, \"2022.03.29.\" ] ]', '1', '1', '0', '0', '13', NULL),
(173, '29', '[ [ \"[GM]Fulano\", \"291UCJH\", 0, \"2022.03.27.\" ] ]', '1', '2', '0', '0', '2', NULL),
(67, '302', '1', '1', '5', '0', '0', '2', '0'),
(114, '339', '15416255', '1', '2', '0', '0', '4', '1'),
(56, '361', '1', '1', '3', '0', '0', '2', '1'),
(185, '112', '1', '1', '3', '0', '0', '2', NULL),
(304, '66', '1', '1', '8', '0', '0', '2', NULL),
(71, '9', '1', '1', '2', '0', '0', '1', NULL),
(305, '133', '1', '1', '1', '0', '0', '2', NULL),
(306, '151', '1', '1', '9', '0', '0', '2', NULL),
(302, '139', '1', '1', '29', '0', '0', '2', NULL),
(90, '19', '10', '1', '1', '0', '0', '2', NULL),
(313, '22', '1', '900', '9', '0', '1', '1', NULL),
(310, '1', '1', '1', '6', '0', '0', '1', NULL),
(321, '29', '[ [ \"BUGG\", \"172KTDN\", 0, \"2022.03.26.\" ] ]', '1', '7', '0', '0', '1', NULL),
(315, '22', '1', '5400', '10', '0', '0', '1', NULL),
(316, '282', '1', '1', '11', '0', '0', '1', NULL),
(303, '1', '1', '1', '7', '0', '0', '2', NULL),
(112, '126', '50020176', '1', '1', '0', '0', '4', '6'),
(115, '338', '36890435', '1', '3', '0', '0', '4', '2'),
(317, '282', '1', '1', '12', '0', '0', '1', NULL),
(138, '16', '1', '1', '3', '0', '0', '1', NULL),
(292, '66', '1', '1', '4', '0', '0', '2', NULL),
(309, '1', '1', '1', '5', '0', '0', '1', NULL),
(257, '151', '1', '1', '6', '0', '0', '2', NULL),
(320, '303', '1', '1', '2', '0', '0', '2', '2'),
(307, '151', '60176736', '1', '1', '0', '0', '1', NULL),
(163, '7', '1', '1', '3', '0', '0', '4', NULL),
(164, '5', '1', '1', '4', '0', '0', '4', NULL),
(289, '110', '1', '1', '1', '0', '0', '2', NULL),
(284, '67', '1', '1', '5', '0', '0', '2', NULL),
(308, '151', '95369324', '1', '4', '0', '0', '1', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `itemsworld`
--

CREATE TABLE `itemsworld` (
  `id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rotX` float NOT NULL,
  `rotY` float NOT NULL,
  `rotZ` float NOT NULL,
  `dimension` int(11) NOT NULL DEFAULT 0,
  `interior` int(11) NOT NULL DEFAULT 0,
  `model` int(11) NOT NULL DEFAULT 0,
  `item` int(11) NOT NULL DEFAULT 0,
  `value` varchar(200) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `itemState` int(11) NOT NULL DEFAULT 0,
  `name` varchar(200) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `owner` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `job_data`
--

CREATE TABLE `job_data` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL DEFAULT 0,
  `data_key` varchar(128) NOT NULL DEFAULT '',
  `data_value` varchar(128) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `killlogs`
--

CREATE TABLE `killlogs` (
  `id` int(11) NOT NULL,
  `text` varchar(500) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `date` datetime NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mdcaccounts`
--

CREATE TABLE `mdcaccounts` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `frakcio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mdctickets`
--

CREATE TABLE `mdctickets` (
  `id` int(11) NOT NULL,
  `targetname` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `jailtime` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mdcwantedcars`
--

CREATE TABLE `mdcwantedcars` (
  `id` int(11) NOT NULL,
  `modelname` varchar(255) NOT NULL,
  `numberplate` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mdcwantedpersons`
--

CREATE TABLE `mdcwantedpersons` (
  `id` int(11) NOT NULL,
  `charactername` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `leiras` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `multas`
--

CREATE TABLE `multas` (
  `id` int(100) NOT NULL,
  `drvv` varchar(100) NOT NULL,
  `dono` varchar(100) NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `placa` varchar(100) NOT NULL,
  `valor` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `multas`
--

INSERT INTO `multas` (`id`, `drvv`, `dono`, `motivo`, `placa`, `valor`, `nome`) VALUES
(0, '[GM]Track', '1', 'A', 'UUN-387', '100', '[GM]Track'),
(0, 'RADAR', '3', 'Passou na velocidade acima de 47 no radar', 'EZL-211', '58', '[GM]BUUG'),
(0, 'RADAR', '3', 'Passou na velocidade acima de 44 no radar', 'EZL-211', '56', '[GM]BUUG'),
(0, 'RADAR', '4', 'Passou na velocidade acima de 47 no radar', 'TOA-417', '59', '[DIR]Daddy'),
(0, 'RADAR', '4', 'Passou na velocidade acima de 64 no radar', 'EZL-211', '80', '[DIR]Daddy'),
(0, 'RADAR', '4', 'Passou na velocidade acima de 59 no radar', 'EZL-211', '74', '[DIR]Daddy');

-- --------------------------------------------------------

--
-- Estrutura da tabela `namechanges`
--

CREATE TABLE `namechanges` (
  `id` int(11) NOT NULL,
  `cname` varchar(255) NOT NULL,
  `wantedname` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `characterID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `elfogadva` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` int(11) NOT NULL DEFAULT 1,
  `elfogadta` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oldbans`
--

CREATE TABLE `oldbans` (
  `id` int(11) NOT NULL,
  `accountID` varchar(100) NOT NULL,
  `bannedBy` varchar(200) NOT NULL,
  `banEnd` varchar(200) NOT NULL,
  `banStart` varchar(200) NOT NULL,
  `playerSerial` varchar(200) NOT NULL,
  `reason` varchar(2000) NOT NULL,
  `playername` varchar(200) NOT NULL,
  `ipadress` varchar(200) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `paylog`
--

CREATE TABLE `paylog` (
  `id` int(10) NOT NULL,
  `playername` varchar(200) NOT NULL,
  `playerid` varchar(40) NOT NULL,
  `tevkod` varchar(40) NOT NULL,
  `log` varchar(2000) NOT NULL,
  `targetname` varchar(200) NOT NULL,
  `targetid` varchar(40) NOT NULL,
  `date` varchar(40) NOT NULL,
  `time` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pets`
--

CREATE TABLE `pets` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT 'Kutya',
  `type` int(11) NOT NULL DEFAULT 1,
  `owner` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 100,
  `food` int(11) NOT NULL DEFAULT 100,
  `thirsty` int(11) NOT NULL DEFAULT 100,
  `isdead` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phones`
--

CREATE TABLE `phones` (
  `id` int(11) NOT NULL,
  `number` int(255) NOT NULL,
  `wallpaper` int(255) NOT NULL DEFAULT 1,
  `music` int(255) NOT NULL DEFAULT 1,
  `battery` int(255) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `phone_sms`
--

CREATE TABLE `phone_sms` (
  `id` int(11) NOT NULL,
  `fr` int(11) NOT NULL DEFAULT 0,
  `t` int(11) NOT NULL DEFAULT 0,
  `msg` varchar(1024) NOT NULL DEFAULT '',
  `dat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `safe`
--

CREATE TABLE `safe` (
  `ID` int(1) NOT NULL,
  `Interior` int(1) NOT NULL,
  `Dimension` int(1) NOT NULL,
  `Position` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `safe`
--

INSERT INTO `safe` (`ID`, `Interior`, `Dimension`, `Position`) VALUES
(10, 10, 2, '[ [ 2262.408203125, -1222.40234375, 1048.5234375, 0, 0, 90.40789794921875 ] ]');

-- --------------------------------------------------------

--
-- Estrutura da tabela `safes`
--

CREATE TABLE `safes` (
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `rx` int(11) NOT NULL,
  `ry` int(11) NOT NULL,
  `rz` int(11) NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `serialchanges`
--

CREATE TABLE `serialchanges` (
  `id` int(11) NOT NULL,
  `mtaserial` varchar(255) NOT NULL,
  `reason` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accountID` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `elfogadva` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` int(11) NOT NULL,
  `elfogadta` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `shops`
--

CREATE TABLE `shops` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `pos` varchar(255) NOT NULL DEFAULT '[[ 0, 0, 0, 0 ]]',
  `skin` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Desconhecido'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `shops`
--

INSERT INTO `shops` (`id`, `type`, `pos`, `skin`, `name`) VALUES
(15, 1, '[ [ 1487.27734375, -1906.7509765625, 22.23081588745117, 0, 0, 87.69692993164063 ] ]', 1, 'vida'),
(16, 2, '[ [ 1487.4775390625, -1900.8935546875, 22.22964477539063, 0, 0, 90.70175170898438 ] ]', 1, 'arma');

-- --------------------------------------------------------

--
-- Estrutura da tabela `smslog`
--

CREATE TABLE `smslog` (
  `id` int(11) NOT NULL,
  `ar` text NOT NULL,
  `tel` text NOT NULL,
  `kuldo` text NOT NULL,
  `uzi` text NOT NULL,
  `chname` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sms_log`
--

CREATE TABLE `sms_log` (
  `id` int(11) NOT NULL,
  `netFizID` bigint(20) NOT NULL DEFAULT -1,
  `tel` varchar(32) NOT NULL DEFAULT 'undefinied',
  `value` int(11) NOT NULL DEFAULT 0,
  `text` varchar(32) NOT NULL DEFAULT '-1',
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `szefek`
--

CREATE TABLE `szefek` (
  `id` int(11) NOT NULL,
  `pos` varchar(500) NOT NULL DEFAULT '[[ 0,0,0,0,0,0,0,0 ]]'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ucp_news`
--

CREATE TABLE `ucp_news` (
  `id` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `content` text NOT NULL,
  `creator` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ucp_serial`
--

CREATE TABLE `ucp_serial` (
  `id` int(11) NOT NULL,
  `key` text DEFAULT NULL,
  `acc` int(11) NOT NULL,
  `serialchangeid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `utlevelek`
--

CREATE TABLE `utlevelek` (
  `ID` int(11) NOT NULL,
  `cardID` int(11) NOT NULL,
  `Skin` int(11) NOT NULL,
  `Lejarat` date NOT NULL,
  `keszitett` date NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicle`
--

CREATE TABLE `vehicle` (
  `id` int(50) NOT NULL,
  `model` int(50) NOT NULL,
  `pos` varchar(255) NOT NULL DEFAULT '[[ -2322.2243652344, -1644.830078125, 483.703125, 0, 0, 0 ]]',
  `interior` varchar(255) NOT NULL DEFAULT '0',
  `dimension` varchar(255) NOT NULL DEFAULT '0',
  `fuel` int(50) NOT NULL DEFAULT 100,
  `hp` int(50) NOT NULL DEFAULT 1000,
  `motor` int(50) NOT NULL DEFAULT 0,
  `color` varchar(1024) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]]',
  `owner` int(100) NOT NULL,
  `nitro` int(50) NOT NULL DEFAULT 0,
  `lefoglalva` int(50) NOT NULL DEFAULT 0,
  `engine` int(11) NOT NULL DEFAULT 1,
  `turbo` int(11) NOT NULL DEFAULT 1,
  `gearbox` int(11) NOT NULL DEFAULT 1,
  `suspensions` int(11) NOT NULL DEFAULT 1,
  `ecu` int(11) NOT NULL DEFAULT 1,
  `tires` int(11) NOT NULL DEFAULT 1,
  `brakes` int(11) NOT NULL DEFAULT 1,
  `weightReduction` int(11) NOT NULL DEFAULT 1,
  `lightColor` varchar(255) NOT NULL DEFAULT '[ [255, 255, 255] ]',
  `OpticalUpgrade` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]',
  `paintjob` int(2) NOT NULL DEFAULT 0,
  `variant` int(11) NOT NULL DEFAULT 255,
  `neon` varchar(255) NOT NULL DEFAULT '0',
  `wheelSize_rear` int(255) NOT NULL DEFAULT 0,
  `wheelSize_front` int(255) NOT NULL DEFAULT 0,
  `steeringLock` int(11) NOT NULL DEFAULT 0,
  `driveType` int(2) NOT NULL DEFAULT 1,
  `airride` int(255) NOT NULL DEFAULT 0,
  `LSDDoor` int(10) NOT NULL DEFAULT 0,
  `traveled` int(255) NOT NULL DEFAULT 0,
  `trafiradar` int(11) NOT NULL DEFAULT 0,
  `optimalization` int(11) NOT NULL DEFAULT 0,
  `opticalTunings` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]',
  `performanceTuning` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0 ]]',
  `oilstate` float NOT NULL DEFAULT 0,
  `rendszam` varchar(25) NOT NULL DEFAULT '000-000',
  `panel` varchar(255) NOT NULL DEFAULT '[[ 0, 0, 0, 0, 0, 0, 0 ]]',
  `wheel` varchar(255) NOT NULL DEFAULT '[[ 0, 0, 0, 0 ]]',
  `door` varchar(255) NOT NULL DEFAULT '[ [ 0, 0, 0, 0, 0, 0 ]]',
  `status` int(255) NOT NULL DEFAULT 0,
  `lampa` int(255) NOT NULL DEFAULT 0,
  `faction` int(255) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `vehicle`
--

INSERT INTO `vehicle` (`id`, `model`, `pos`, `interior`, `dimension`, `fuel`, `hp`, `motor`, `color`, `owner`, `nitro`, `lefoglalva`, `engine`, `turbo`, `gearbox`, `suspensions`, `ecu`, `tires`, `brakes`, `weightReduction`, `lightColor`, `OpticalUpgrade`, `paintjob`, `variant`, `neon`, `wheelSize_rear`, `wheelSize_front`, `steeringLock`, `driveType`, `airride`, `LSDDoor`, `traveled`, `trafiradar`, `optimalization`, `opticalTunings`, `performanceTuning`, `oilstate`, `rendszam`, `panel`, `wheel`, `door`, `status`, `lampa`, `faction`) VALUES
(4, 561, '[ [ 2137.8720703125, 1434.0634765625, 10.65019702911377, 79, 27983 ] ]', '0', '0', 69, 969, 0, '[ [ 219, 10, 91, 0, 0, 0 ] ]', 2, 0, 0, 5, 5, 5, 1, 5, 1, 5, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1082, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 30, 2, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'AJN-666', '[ [ 1, 0, 0, 0, 0, 1, 1 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 2, 0, 0, 0, 0 ] ]', 1, 1, 0),
(5, 483, '[ [ 1948.1025390625, -1810.0478515625, 13.64985942840576, 29, 15901 ] ]', '0', '0', 97, 1000, 0, '[ [ 251, 9, 220, 0, 0, 0 ] ]', 1, 0, 0, 5, 5, 5, 1, 5, 5, 5, 1, '[ [ 96, 248, 252 ] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1087, 0, 0, 1077, 0, 0, 0 ] ]', 0, 255, 'ice', 0, 8, 0, 2, 1, 1, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'UUN-387', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0),
(6, 418, '[ [ 2138.5078125, 1433.16796875, 10.64899444580078, 87, 27479 ] ]', '0', '0', 9, 1000, 0, '[ [ 0, 0, 0, 0, 0, 0 ] ]', 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'NFV-662', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0),
(7, 522, '[ [ 2792.455078125, -1603.9013671875, 10.51559829711914, 0, 1317 ] ]', '0', '0', 7, 982, 0, '[ [ 255, 204, 0, 0, 0, 0 ] ]', 3, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'EZL-211', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 1, 0),
(8, 500, '[ [ 2792.44140625, -1603.896484375, 10.829833984375, 0, 9956 ] ]', '0', '0', 5, 1000, 0, '[ [ 255, 204, 0, 0, 0, 0 ] ]', 2, 0, 0, 5, 1, 5, 1, 5, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1087, 0, 0, 1073, 0, 0, 0 ] ]', 0, 255, 'white', 0, 0, 0, 2, 1, 1, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'UBC-478', '[ [ 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0),
(9, 496, '[ [ 2503.8525390625, -2013.6142578125, 12.89653968811035, 0, 0 ] ]', '0', '0', 47, 963, 0, '[ [ 255, 255, 255, 0, 0, 0 ] ]', 2, 0, 0, 5, 5, 5, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1074, 0, 0, 0 ] ]', 0, 255, '0', 1, 2, 0, 1, 1, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'AGK-681', '[ [ 1, 0, 0, 0, 0, 1, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 0, 1, 0),
(10, 2, '[ [ 2435.24609375, -2086.1455078125, 13.546875, 0, 0 ] ]', '0', '0', 10, 1000, 0, '[ [ 255, 255, 255, 0, 0, 0 ] ]', 2, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, '[ [255, 255, 255] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', 0, 255, '0', 0, 0, 0, 1, 0, 0, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'OMY-776', '[[ 0, 0, 0, 0, 0, 0, 0 ]]', '[[ 0, 0, 0, 0 ]]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 0, 0),
(11, 541, '[ [ 1099.6123046875, -1775.2783203125, 12.99890518188477, 239, 57583 ] ]', '0', '0', 39, 936, 0, '[ [ 95, 1, 0, 0, 0, 0 ] ]', 4, 0, 0, 5, 5, 5, 1, 5, 5, 5, 1, '[ [ 22, 158, 238 ] ]', '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1087, 0, 0, 1074, 0, 0, 0 ] ]', 0, 255, '0', 8, 8, 0, 1, 1, 1, 0, 0, 0, '[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ]]', 0, 'TOA-417', '[ [ 1, 0, 0, 0, 1, 2, 0 ] ]', '[ [ 0, 0, 0, 0 ] ]', '[ [ 0, 0, 0, 0, 0, 0 ] ]', 1, 2, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicleitem`
--

CREATE TABLE `vehicleitem` (
  `id` int(11) NOT NULL,
  `itemID` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `itemDB` int(11) NOT NULL,
  `slot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `actionbaritems`
--
ALTER TABLE `actionbaritems`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `actionslot`
--
ALTER TABLE `actionslot`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `adminjails`
--
ALTER TABLE `adminjails`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `adminlog`
--
ALTER TABLE `adminlog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `admin_warns`
--
ALTER TABLE `admin_warns`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `atms`
--
ALTER TABLE `atms`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `bins`
--
ALTER TABLE `bins`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `changelog`
--
ALTER TABLE `changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `colordoc`
--
ALTER TABLE `colordoc`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `elevators`
--
ALTER TABLE `elevators`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `fuels`
--
ALTER TABLE `fuels`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `gamemachine`
--
ALTER TABLE `gamemachine`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `gates`
--
ALTER TABLE `gates`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `groupattach`
--
ALTER TABLE `groupattach`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`groupID`);

--
-- Índices para tabela `hifi`
--
ALTER TABLE `hifi`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `identity`
--
ALTER TABLE `identity`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `interiors`
--
ALTER TABLE `interiors`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `itemlist`
--
ALTER TABLE `itemlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Índices para tabela `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `itemsworld`
--
ALTER TABLE `itemsworld`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `job_data`
--
ALTER TABLE `job_data`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `killlogs`
--
ALTER TABLE `killlogs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `mdcaccounts`
--
ALTER TABLE `mdcaccounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `mdctickets`
--
ALTER TABLE `mdctickets`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `mdcwantedcars`
--
ALTER TABLE `mdcwantedcars`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `mdcwantedpersons`
--
ALTER TABLE `mdcwantedpersons`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `namechanges`
--
ALTER TABLE `namechanges`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `oldbans`
--
ALTER TABLE `oldbans`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `paylog`
--
ALTER TABLE `paylog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phones`
--
ALTER TABLE `phones`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `phone_sms`
--
ALTER TABLE `phone_sms`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `safe`
--
ALTER TABLE `safe`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Índices para tabela `safes`
--
ALTER TABLE `safes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `serialchanges`
--
ALTER TABLE `serialchanges`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `sms_log`
--
ALTER TABLE `sms_log`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `szefek`
--
ALTER TABLE `szefek`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `ucp_news`
--
ALTER TABLE `ucp_news`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Índices para tabela `ucp_serial`
--
ALTER TABLE `ucp_serial`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `utlevelek`
--
ALTER TABLE `utlevelek`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `vehicleitem`
--
ALTER TABLE `vehicleitem`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `actionbaritems`
--
ALTER TABLE `actionbaritems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `actionslot`
--
ALTER TABLE `actionslot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `adminjails`
--
ALTER TABLE `adminjails`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `adminlog`
--
ALTER TABLE `adminlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `admin_warns`
--
ALTER TABLE `admin_warns`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atms`
--
ALTER TABLE `atms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de tabela `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `bins`
--
ALTER TABLE `bins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de tabela `changelog`
--
ALTER TABLE `changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `colordoc`
--
ALTER TABLE `colordoc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `elevators`
--
ALTER TABLE `elevators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `fuels`
--
ALTER TABLE `fuels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de tabela `gamemachine`
--
ALTER TABLE `gamemachine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `garages`
--
ALTER TABLE `garages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `gates`
--
ALTER TABLE `gates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `groupattach`
--
ALTER TABLE `groupattach`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `groups`
--
ALTER TABLE `groups`
  MODIFY `groupID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `hifi`
--
ALTER TABLE `hifi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `identity`
--
ALTER TABLE `identity`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `interiors`
--
ALTER TABLE `interiors`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itemlist`
--
ALTER TABLE `itemlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `items`
--
ALTER TABLE `items`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=322;

--
-- AUTO_INCREMENT de tabela `itemsworld`
--
ALTER TABLE `itemsworld`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `job_data`
--
ALTER TABLE `job_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `killlogs`
--
ALTER TABLE `killlogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `mdcaccounts`
--
ALTER TABLE `mdcaccounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `mdctickets`
--
ALTER TABLE `mdctickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `mdcwantedcars`
--
ALTER TABLE `mdcwantedcars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `mdcwantedpersons`
--
ALTER TABLE `mdcwantedpersons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `namechanges`
--
ALTER TABLE `namechanges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `oldbans`
--
ALTER TABLE `oldbans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `paylog`
--
ALTER TABLE `paylog`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pets`
--
ALTER TABLE `pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `phones`
--
ALTER TABLE `phones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `phone_sms`
--
ALTER TABLE `phone_sms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `safe`
--
ALTER TABLE `safe`
  MODIFY `ID` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `safes`
--
ALTER TABLE `safes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `serialchanges`
--
ALTER TABLE `serialchanges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `shops`
--
ALTER TABLE `shops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `sms_log`
--
ALTER TABLE `sms_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `szefek`
--
ALTER TABLE `szefek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ucp_serial`
--
ALTER TABLE `ucp_serial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `utlevelek`
--
ALTER TABLE `utlevelek`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `vehicleitem`
--
ALTER TABLE `vehicleitem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
