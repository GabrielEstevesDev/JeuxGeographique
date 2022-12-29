-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  jeu. 29 déc. 2022 à 17:54
-- Version du serveur :  10.4.8-MariaDB
-- Version de PHP :  7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `web`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `signIn` (IN `plogin` VARCHAR(16), IN `pmail` VARCHAR(64), IN `mdp` VARCHAR(128))  NO SQL
BEGIN
	INSERT INTO comptes (login,email,mdphash) VALUES (plogin, pmail, MD5(mdp));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMail` (IN `pid` INT(11), IN `fmail` VARCHAR(64))  NO SQL
BEGIN
	UPDATE comptes SET email = fmail WHERE id = pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateMdp` (IN `pid` INT, IN `mdp` VARCHAR(128))  NO SQL
BEGIN
	UPDATE comptes SET mdphash = MD5(mdp) WHERE id = pid;
END$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `emailExists` (`fmail` VARCHAR(64)) RETURNS TINYINT(1) NO SQL
BEGIN
	DECLARE temp INTEGER;
    SELECT id INTO temp FROM comptes WHERE email = fmail;
    
    IF temp IS NULL THEN
    	RETURN FALSE;
    ELSE
    	RETURN TRUE;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `getIdByLogin` (`flogin` VARCHAR(64)) RETURNS INT(11) NO SQL
BEGIN
	DECLARE temp INTEGER;
    SELECT id INTO temp FROM comptes WHERE (login = flogin OR email = flogin);
    
    RETURN temp;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `loginExists` (`flogin` VARCHAR(16)) RETURNS TINYINT(1) NO SQL
BEGIN
	DECLARE temp INTEGER;
    SELECT id INTO temp FROM comptes WHERE login = flogin;
    
    IF temp IS NULL THEN
    	RETURN FALSE;
    ELSE
    	RETURN TRUE;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `logUser` (`flogin` VARCHAR(64), `fmdp` VARCHAR(128)) RETURNS INT(11) NO SQL
BEGIN
	DECLARE temp INTEGER;
    DECLARE mdp VARBINARY(128);
    SET mdp = MD5(fmdp);
    SELECT id INTO temp FROM comptes WHERE (login = flogin OR email = flogin) AND mdphash = mdp;
    
    IF temp = 0 THEN
    	RETURN NULL;
    ELSE
 		RETURN temp;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `samePassword` (`fid` INT(11), `mdp` VARCHAR(128)) RETURNS INT(1) NO SQL
BEGIN
	DECLARE temp INTEGER;
    SELECT id INTO temp FROM comptes WHERE id = fid AND mdphash = MD5(mdp);
    
    IF temp IS NULL THEN
    	RETURN FALSE;
    ELSE
    	RETURN TRUE;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `comptes`
--

CREATE TABLE `comptes` (
  `id` int(11) NOT NULL,
  `login` varchar(16) NOT NULL,
  `email` varchar(60) NOT NULL,
  `mdphash` varbinary(128) NOT NULL,
  `meilleurScore` int(11) NOT NULL DEFAULT 0,
  `scoreTotal` int(11) NOT NULL DEFAULT 0,
  `amis` longtext DEFAULT NULL,
  `demandeAmis` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `comptes`
--

INSERT INTO `comptes` (`id`, `login`, `email`, `mdphash`, `meilleurScore`, `scoreTotal`, `amis`, `demandeAmis`) VALUES
(1, 'yvann', 'yvann@iut.com', 0x3039386636626364343632316433373363616465346538333236323762346636, 60420, 61570, '[2,3,4]', '[]'),
(2, 'aaa', 'aaa@iut.com', 0x6238393062323037333831646630366231326338323230303036383935326536, 55484, 465134, '[1,3]', '[]'),
(3, 'gabriel', 'gabriel@iut.com', 0x6238393062323037333831646630366231326338323230303036383935326536, 0, 0, '[1,2]', '[]'),
(4, 'louis', 'louis@iut.com', 0x3039386636626364343632316433373363616465346538333236323762346636, 0, 0, '[1]', '[2]'),
(5, 'toto', 'test@iut.com', 0x3039386636626364343632316433373363616465346538333236323762346636, 0, 0, '[]', '[]');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `comptes`
--
ALTER TABLE `comptes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
