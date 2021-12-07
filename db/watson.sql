-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : dim. 05 déc. 2021 à 22:23
-- Version du serveur : 8.0.26-0ubuntu0.20.04.2
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `watson`
--

-- --------------------------------------------------------

--
-- Structure de la table `tl_liens`
--

CREATE TABLE `tl_liens` (
  `lien_id` int NOT NULL,
  `lien_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lien_titre` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lien_desc` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_liens`
--

INSERT INTO `tl_liens` (`lien_id`, `lien_url`, `lien_titre`, `lien_desc`, `user_id`) VALUES
(1, 'https://cvtic.unilim.fr/', 'Campus Virtuel TIC', 'Site internet du CvTIC.', 1),
(2, 'https://duckduckgo.com/', 'Duck Duck Go', 'Le moteur de recherche qui ne trace pas ses utilisateurs.', 1),
(3, 'https://framasoft.org/', 'Framasoft', 'Un réseau dédié à la promotion du « libre » en général et du logiciel libre en particulier.', 1),
(4, 'https://nextcloud.com/', 'Nextcloud', 'Nextcloud est un logiciel libre de site d\'hébergement de fichiers et une plateforme de collaboration.', 3),
(5, 'https://1password.com/fr/', '1Password', '1Password est un gestionnaire de mots de passe et permet de générer et de conserver des mots de passe de façon sécurisée, ainsi que des notes et documents.', 3),
(6, 'https://signal.org/fr/', 'Signal', 'Signal est une application gratuite pour Android et iOS, permettant de communiquer de façon chiffrée et sécurisée dont l\'objectif est d\'assurer un maximum de confidentialité à ses utilisateurs.', 3),
(7, 'https://www.notion.so/product', 'Notion', 'Notion est une application de prise de notes, de bases de données, des tableaux Kanban, de wikis, de calendriers et de rappels. C\'est à la fois un idéateur et un wiki. Ce logiciel peut être utilisé pour un usage individuel ou en collaboration avec d\'autres.', 3),
(8, 'https://medium.com/', 'Medium', 'Medium est un site de blogging où des experts partagent leurs points de vue et autres connaissances.', 2),
(9, 'https://www.lemondeinformatique.fr/', 'Le Monde Informatique', 'Journal web pour les professionnels de l\'informatique.', 2),
(10, 'https://makezine.com/', 'Make: DIY Projects and Ideas for Makers', 'Site web qui regroupe des projets DIY sur l\'électronique.', 2),
(11, 'https://all3dp.com/fr/', 'All3DP', 'Site web sur le monde de l\'impression 3D.', 2),
(12, 'bitwarden.com', 'Bitwarden', 'Gestionnaire de mot de passe open source', 4),
(13, 'https://app.revolt.chat/', 'Revolt', 'Alternative à Discord open source', 4),
(14, 'https://anytype.io', 'Anytype', 'Alternative à Notion open source, crypté et local très intéressante', 4),
(15, 'https://www.opera.com/fr/gx', 'Opera GX', 'Navigateur dédié aux jeux mais avec beaucoup d\'option intéressantes pour tout le monde et permettant une meilleure productivité', 4);

-- --------------------------------------------------------

--
-- Structure de la table `tl_tags`
--

CREATE TABLE `tl_tags` (
  `tag_id` int NOT NULL,
  `tag_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_tags`
--

INSERT INTO `tl_tags` (`tag_id`, `tag_name`) VALUES
(1, 'fac'),
(2, 'vieprivee'),
(3, 'opensource'),
(4, 'apprendre'),
(5, 'blog'),
(6, 'informatique'),
(7, 'journal'),
(8, 'maker'),
(9, 'électronique'),
(10, 'impression-3d'),
(11, 'productivite');

-- --------------------------------------------------------

--
-- Structure de la table `tl_tags_liens`
--

CREATE TABLE `tl_tags_liens` (
  `tag_id` int NOT NULL,
  `lien_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_tags_liens`
--

INSERT INTO `tl_tags_liens` (`tag_id`, `lien_id`) VALUES
(1, 1),
(2, 2),
(3, 2),
(3, 3),
(5, 8),
(6, 9),
(7, 9),
(8, 10),
(9, 10),
(10, 11),
(3, 4),
(2, 5),
(2, 6),
(11, 7),
(3, 12),
(3, 13),
(3, 14),
(11, 15);

-- --------------------------------------------------------

--
-- Structure de la table `tl_users`
--

CREATE TABLE `tl_users` (
  `usr_id` int NOT NULL,
  `usr_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `usr_password` varchar(88) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `usr_salt` varchar(23) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `usr_role` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ROLE_ADMIN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `tl_users`
--

INSERT INTO `tl_users` (`usr_id`, `usr_name`, `usr_password`, `usr_salt`, `usr_role`) VALUES
(1, 'admin', 'LsJKppRTEPz4uKrkhScOE6HBSvHuaIcFbAX9FWC7h/f5HffX4TBcFt7p8M0hqvGzFXL+JV8TzEYePoimaosfMQ==', '>=28!7NLw!S37zLjs7Uu[nC', 'ROLE_ADMIN'),
(2, 'Gabriel', 'YXU6EeDwsWk4yZGUC12BNHIQ2V80s6lkzYr/TiR2HRQF4RZR3pZqlU6RGD3TXNqegqMRvJlJ96WAmGUoJPkFog==', '5f4410e2ffe311ea22ec03a', 'ROLE_ADMIN'),
(3, 'Martial', 'h/U5DF+qq83U8/msiOVOfAYAWoBJOn3TSneO148tGA62Wt2rIdgTOsrFiaJaTS1lnstb7iTQnDb8JhrVZ5hkSQ==', 'b65a788a8b647fd0c9bf919', 'ROLE_ADMIN'),
(4, 'Pacôme', 'reDp+6Enh/A5/SU9BXwRfkZ1IfBjJeINJU1nj+xGNUbT2htMP+bl8s83o5wP2bo0z6IWyCu//RpV5+WC5yRigA==', 'bf2fbccd29ed0755f761373', 'ROLE_ADMIN');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `tl_liens`
--
ALTER TABLE `tl_liens`
  ADD PRIMARY KEY (`lien_id`);

--
-- Index pour la table `tl_tags`
--
ALTER TABLE `tl_tags`
  ADD PRIMARY KEY (`tag_id`);

--
-- Index pour la table `tl_users`
--
ALTER TABLE `tl_users`
  ADD PRIMARY KEY (`usr_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `tl_liens`
--
ALTER TABLE `tl_liens`
  MODIFY `lien_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `tl_tags`
--
ALTER TABLE `tl_tags`
  MODIFY `tag_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `tl_users`
--
ALTER TABLE `tl_users`
  MODIFY `usr_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
