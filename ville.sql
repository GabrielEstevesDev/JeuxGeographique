-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 28 déc. 2022 à 16:53
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet`
--

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

CREATE TABLE `ville` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `info` text NOT NULL,
  `img` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ville`
--

INSERT INTO `ville` (`id`, `nom`, `info`, `img`) VALUES
(1, 'Paris', 'Paris est la capitale de la France. Divisée en vingt arrondissements, elle est le chef-lieu de la région Île-de-France et le siège de la métropole du Grand Paris.', '../img/Villes/Paris.jpg'),
(2, 'Lyon', 'Lyon  est une commune française située dans le quart sud-est de la France, au confluent du Rhône et de la Saône.Siège du conseil de la métropole de LyonNote 1, à laquelle son statut particulier confère à la fois les attributions d\'une métropole et d\'un département, elle est aussi le chef-lieu de l\'arrondissement de Lyon, celui de la circonscription départementale du Rhône et celui de la région Auvergne-Rhône-Alpes.', '../img/Villes/Lyon.jpg'),
(3, 'Bordeaux', 'Bordeaux (/bɔʁ.do/ ) est une commune française située dans le département de la Gironde, en région Nouvelle-Aquitaine. Au 1er janvier 2019, elle est la neuvième commune de France par sa population avec 260 958 habitants.', '../img/Villes/Bordeaux.webp'),
(4, 'Marseille', 'Marseille est une commune du Sud-Est de la France, chef-lieu du département des Bouches-du-Rhône et préfecture de la région Provence-Alpes-Côte d\'Azur. En 2019, Marseille est la deuxième commune la plus peuplée de France avec 870 731 habitants. Son unité urbaine, qui s\'étend au nord jusqu\'à Aix-en-Provence, est la troisième de France avec 1 614 501 habitants, derrière Paris et Lyon.', '../img/Villes/Marseille.webp'),
(5, 'Lille', 'Lille est une ville du nord de la France, préfecture du département du Nord et chef-lieu de la région Hauts-de-France.Dans sa partie française, son unité urbaine et ses 1 051 609 habitants en 2019 font de Lille la quatrième agglomération de France derrière Paris, Lyon et Marseille, tout comme son aire d\'attraction qui rassemble 1,5 million d\'habitants.', '../img/Villes/Lille.jpg'),
(6, 'Toulouse', '', '../img/Villes/Toulouse.jpg'),
(7, 'Nice', '', '../img/Villes/Nice.jpg'),
(9, 'Nantes', '', '../img/Villes/Nantes.jpg'),
(10, 'Montpellier', '', '../img/Villes/Montpellier.jpg'),
(11, 'Strasbourg', '', '../img/Villes/Strasbourg.jpg'),
(12, 'Rennes', '', '../img/Villes/Rennes.jpg'),
(13, 'Reims', '', '../img/Villes/Reims.jpg'),
(14, 'Toulon', '', '../img/Villes/Toulon.jpg'),
(15, 'Saint-Etienne', '', '../img/Villes/Saint-Etienne.jpg'),
(16, 'Le Havre', '', '../img/Villes/LeHavre.jpg'),
(17, 'Grenoble', '', '../img/Villes/Grenoble.jpg'),
(18, 'Dijon', '', '../img/Villes/Dijon.jpg'),
(19, 'Angers', '', '../img/Villes/Angers.jpg'),
(20, 'Le Mans', '', '../img/Villes/LeMans.jpg'),
(21, 'Limoges', '', '../img/Villes/Limoges.jpg');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ville`
--
ALTER TABLE `ville`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ville`
--
ALTER TABLE `ville`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
