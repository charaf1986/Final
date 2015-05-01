-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Jeu 24 Avril 2014 à 16:49
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `projet`
--
CREATE DATABASE IF NOT EXISTS `projet` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `projet`;

-- --------------------------------------------------------

--
-- Structure de la table `dessins`
--

CREATE TABLE IF NOT EXISTS `dessins` (
  `idDessin` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `path` varchar(30) NOT NULL,
  `heureDate` date NOT NULL,
  `nbVotes` int(11) DEFAULT NULL,
  `idUser` int(11) NOT NULL,
  PRIMARY KEY (`idDessin`),
  KEY `idUser` (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `dessins`
--

INSERT INTO `dessins` (`idDessin`, `title`, `path`, `heureDate`, `nbVotes`, `idUser`) VALUES
(1, 'Elephants', 'images/Elephants.png', '2014-04-14', 5, 1),
(2, 'Fleur', 'images/Fleur.png', '2014-04-15', 7, 1),
(3, 'Poisson', 'images/Poisson.png', '2014-04-15', 10, 3),
(4, 'Bonheur', 'images/Bonheur.png', '2014-04-15', 6, 2);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `idUser` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `courriel` varchar(30) NOT NULL,
  `ville` varchar(30) NOT NULL,
  `province` varchar(30) DEFAULT NULL,
  `pays` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`idUser`, `username`, `password`, `nom`, `prenom`, `courriel`, `ville`, `province`, `pays`) VALUES
(1, 'user', 'pass', 'Username', 'Test', 'test@gmail.com', 'Québec', 'Québec', 'Canada'),
(2, 'mounir', '123456', 'Hallab', 'Mounir', 'mvic@gmail.com', 'Québec', 'Québec', 'Canada'),
(3, 'ismail', '123456', 'Amri', 'Ismail', 'ismail@yahoo.fr', 'Casablanca', NULL, 'Maroc');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `dessins`
--
ALTER TABLE `dessins`
  ADD CONSTRAINT `FK_UserId` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
