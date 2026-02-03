-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 03 fév. 2026 à 08:26
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `grandangle`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `spGetArtistesExposition`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetArtistesExposition` (IN `pIdExposition` INT)   BEGIN
    SELECT DISTINCT
        a.idArtiste,
        a.nom,
        a.prenom,
        a.anneeNaissance,
        a.image,
        COUNT(DISTINCT o.idOeuvre) AS nbOeuvres
    FROM Artiste a
    JOIN Oeuvre o ON a.idArtiste = o.idArtiste
    WHERE o.idExposition = pIdExposition
    GROUP BY a.idArtiste, a.nom, a.prenom, a.anneeNaissance, a.image
    ORDER BY a.nom, a.prenom;
END$$

DROP PROCEDURE IF EXISTS `spGetTraductionsOeuvre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `spGetTraductionsOeuvre` (IN `pIdOeuvre` INT)   BEGIN
    SELECT 
        l.code AS langueCode,
        l.nom AS langueNom,
        tro.traductionTexte,
        tro.urlAcces,
        tro.dateAjout
    FROM TraductionOeuvre tro
    JOIN Langue l ON tro.idLangue = l.idLangue
    WHERE tro.idOeuvre = pIdOeuvre
    ORDER BY l.code;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `artiste`
--

DROP TABLE IF EXISTS `artiste`;
CREATE TABLE IF NOT EXISTS `artiste` (
  `idArtiste` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anneeNaissance` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idArtiste`),
  KEY `idEmploye` (`idEmploye`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Artistes (créateurs des œuvres)';

-- --------------------------------------------------------

--
-- Structure de la table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
CREATE TABLE IF NOT EXISTS `configuration` (
  `idConfiguration` int NOT NULL AUTO_INCREMENT,
  `cle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valeur` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`idConfiguration`),
  UNIQUE KEY `cle` (`cle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Paramètres de configuration du système';

--
-- Déchargement des données de la table `configuration`
--

INSERT INTO `configuration` (`idConfiguration`, `cle`, `valeur`, `description`) VALUES
(1, 'siteName', 'Centre d\'Art Grand Angle', 'Nom du centre'),
(2, 'siteUrl', 'https://www.grandangle.fr', 'URL du site web'),
(3, 'emailContact', 'contact@grandangle.fr', 'Email de contact'),
(4, 'horairesCentre', 'Lundi-Vendredi 10h-18h, Samedi 10h-20h, Dimanche fermé', 'Horaires par défaut du centre');

-- --------------------------------------------------------

--
-- Structure de la table `consultation`
--

DROP TABLE IF EXISTS `consultation`;
CREATE TABLE IF NOT EXISTS `consultation` (
  `idConsultation` int NOT NULL AUTO_INCREMENT,
  `dateConsultation` datetime DEFAULT CURRENT_TIMESTAMP,
  `idOeuvre` int NOT NULL,
  PRIMARY KEY (`idConsultation`),
  KEY `idxConsultationOeuvre` (`idOeuvre`),
  KEY `idxConsultationDate` (`dateConsultation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Logs de consultation des œuvres (module public)';

-- --------------------------------------------------------

--
-- Structure de la table `contenuenrichi`
--

DROP TABLE IF EXISTS `contenuenrichi`;
CREATE TABLE IF NOT EXISTS `contenuenrichi` (
  `idContenuEnrichi` int NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordreAffichage` int DEFAULT '1',
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idOeuvre` int NOT NULL,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idContenuEnrichi`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxContenuOeuvre` (`idOeuvre`),
  KEY `idxContenuOrdre` (`idOeuvre`,`ordreAffichage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Contenus enrichis supplémentaires en français (audio, vidéo, images détail...)';

-- --------------------------------------------------------

--
-- Structure de la table `emplacement`
--

DROP TABLE IF EXISTS `emplacement`;
CREATE TABLE IF NOT EXISTS `emplacement` (
  `idEmplacement` int NOT NULL AUTO_INCREMENT,
  `positionX` decimal(5,2) DEFAULT NULL,
  `positionY` decimal(5,2) DEFAULT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idEspace` int NOT NULL,
  `idExposition` int NOT NULL,
  PRIMARY KEY (`idEmplacement`),
  KEY `idxEmplacementEspace` (`idEspace`),
  KEY `idxEmplacementExpo` (`idExposition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Emplacements physiques des œuvres (avec coordonnées X/Y)';

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `idEmploye` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `supprime` tinyint(1) DEFAULT '0',
  `dateCreation` datetime DEFAULT CURRENT_TIMESTAMP,
  `dateSuppression` datetime DEFAULT NULL,
  `idFonction` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idEmploye`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `login` (`login`),
  KEY `idFonction` (`idFonction`),
  KEY `idxEmployeActif` (`actif`),
  KEY `idxEmployeSupprime` (`supprime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Employés du centre (avec soft delete)';

--
-- Déclencheurs `employe`
--
DROP TRIGGER IF EXISTS `trEmployeSuppression`;
DELIMITER $$
CREATE TRIGGER `trEmployeSuppression` BEFORE UPDATE ON `employe` FOR EACH ROW BEGIN
    IF NEW.supprime = TRUE AND OLD.supprime = FALSE THEN
        SET NEW.dateSuppression = NOW();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `espace`
--

DROP TABLE IF EXISTS `espace`;
CREATE TABLE IF NOT EXISTS `espace` (
  `idEspace` int NOT NULL AUTO_INCREMENT,
  `nomEspace` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `superficieM2` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idEspace`),
  UNIQUE KEY `nomEspace` (`nomEspace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Espaces physiques du centre (Salle A, Salle B, Jardin...)';

-- --------------------------------------------------------

--
-- Structure de la table `etape`
--

DROP TABLE IF EXISTS `etape`;
CREATE TABLE IF NOT EXISTS `etape` (
  `idEtape` int NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordre` int NOT NULL,
  `idExposition` int NOT NULL,
  PRIMARY KEY (`idEtape`),
  UNIQUE KEY `idExposition` (`idExposition`,`ordre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Étapes de préparation d''une exposition (Conception, Installation, Vernissage...)';

-- --------------------------------------------------------

--
-- Structure de la table `exposition`
--

DROP TABLE IF EXISTS `exposition`;
CREATE TABLE IF NOT EXISTS `exposition` (
  `idExposition` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `horaires` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modulePublicActif` tinyint(1) DEFAULT '0',
  `dateCreation` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idExposition`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxExpositionDates` (`dateDebut`,`dateFin`),
  KEY `idxExpositionActif` (`modulePublicActif`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `fonction`
--

DROP TABLE IF EXISTS `fonction`;
CREATE TABLE IF NOT EXISTS `fonction` (
  `idFonction` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `intitule` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idFonction`),
  UNIQUE KEY `intitule` (`intitule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Fonctions métier des employés (Directeur, Gestionnaire, Traducteur...)';

--
-- Déchargement des données de la table `fonction`
--

INSERT INTO `fonction` (`idFonction`, `intitule`) VALUES
('ASS', 'Assistante'),
('CCO', 'Chargé de Communication'),
('DIR', 'Directeur'),
('RCO', 'Responsable Communication'),
('RTE', 'Responsable Technique'),
('TEC', 'Technicien'),
('TRA', 'Traductrice');

-- --------------------------------------------------------

--
-- Structure de la table `langue`
--

DROP TABLE IF EXISTS `langue`;
CREATE TABLE IF NOT EXISTS `langue` (
  `idLangue` int NOT NULL AUTO_INCREMENT,
  `code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idLangue`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Langues disponibles (FR, EN, DE, RU, ZH)';

--
-- Déchargement des données de la table `langue`
--

INSERT INTO `langue` (`idLangue`, `code`, `nom`) VALUES
(1, 'FR', 'Français'),
(2, 'EN', 'English'),
(3, 'DE', 'Deutsch'),
(4, 'RU', 'Русский'),
(5, 'ZH', '中文');

-- --------------------------------------------------------

--
-- Structure de la table `oeuvre`
--

DROP TABLE IF EXISTS `oeuvre`;
CREATE TABLE IF NOT EXISTS `oeuvre` (
  `idOeuvre` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `technique` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anneeCreation` int DEFAULT NULL,
  `hauteurCm` decimal(10,2) DEFAULT NULL,
  `largeurCm` decimal(10,2) DEFAULT NULL,
  `profondeurCm` decimal(10,2) DEFAULT NULL,
  `dateLivraisonPrevue` date DEFAULT NULL,
  `dateLivraisonReelle` date DEFAULT NULL,
  `numeroIdentification` int DEFAULT NULL,
  `ordreVisite` int DEFAULT NULL,
  `urlQrCode` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idExposition` int DEFAULT NULL,
  `idEmplacement` int DEFAULT NULL,
  `idArtiste` int NOT NULL,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idOeuvre`),
  UNIQUE KEY `numeroIdentification` (`numeroIdentification`),
  KEY `idEmplacement` (`idEmplacement`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxOeuvreExposition` (`idExposition`),
  KEY `idxOeuvreArtiste` (`idArtiste`),
  KEY `idxOeuvreTechnique` (`technique`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `traductionartiste`
--

DROP TABLE IF EXISTS `traductionartiste`;
CREATE TABLE IF NOT EXISTS `traductionartiste` (
  `idTraductionArtiste` int NOT NULL AUTO_INCREMENT,
  `idArtiste` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idTraductionArtiste`),
  KEY `idLangue` (`idLangue`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxTradArtisteArtisteLangue` (`idArtiste`,`idLangue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des descriptions d''artistes';

-- --------------------------------------------------------

--
-- Structure de la table `traductioncontenuenrichi`
--

DROP TABLE IF EXISTS `traductioncontenuenrichi`;
CREATE TABLE IF NOT EXISTS `traductioncontenuenrichi` (
  `idTraductionContenu` int NOT NULL AUTO_INCREMENT,
  `idContenuEnrichi` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordreAffichage` int DEFAULT '1',
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idTraductionContenu`),
  KEY `idLangue` (`idLangue`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxTradContenuContenuLangue` (`idContenuEnrichi`,`idLangue`),
  KEY `idxTradContenuOrdre` (`idContenuEnrichi`,`idLangue`,`ordreAffichage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des contenus enrichis';

-- --------------------------------------------------------

--
-- Structure de la table `traductionexpo`
--

DROP TABLE IF EXISTS `traductionexpo`;
CREATE TABLE IF NOT EXISTS `traductionexpo` (
  `idTraductionExpo` int NOT NULL AUTO_INCREMENT,
  `idExposition` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idTraductionExpo`),
  KEY `idLangue` (`idLangue`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxTradExpoExpoLangue` (`idExposition`,`idLangue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des descriptions d''expositions';

-- --------------------------------------------------------

--
-- Structure de la table `traductionoeuvre`
--

DROP TABLE IF EXISTS `traductionoeuvre`;
CREATE TABLE IF NOT EXISTS `traductionoeuvre` (
  `idTraductionOeuvre` int NOT NULL AUTO_INCREMENT,
  `idOeuvre` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL,
  PRIMARY KEY (`idTraductionOeuvre`),
  KEY `idLangue` (`idLangue`),
  KEY `idEmploye` (`idEmploye`),
  KEY `idxTradOeuvreOeuvreLangue` (`idOeuvre`,`idLangue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des descriptions d''œuvres';

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vexpositionsactives`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vexpositionsactives`;
CREATE TABLE IF NOT EXISTS `vexpositionsactives` (
`dateDebut` date
,`dateFin` date
,`idExposition` int
,`modulePublicActif` tinyint(1)
,`nbArtistes` bigint
,`nbOeuvres` bigint
,`theme` varchar(250)
,`titre` varchar(255)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `voeuvrescompletes`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `voeuvrescompletes`;
CREATE TABLE IF NOT EXISTS `voeuvrescompletes` (
`anneeCreation` int
,`artisteComplet` varchar(511)
,`artisteNom` varchar(255)
,`artistePrenom` varchar(255)
,`description` text
,`emplacementDescription` varchar(1000)
,`espaceNom` varchar(250)
,`expositionDebut` date
,`expositionFin` date
,`expositionTitre` varchar(255)
,`idOeuvre` int
,`image` varchar(500)
,`ordreVisite` int
,`technique` varchar(255)
,`titre` varchar(255)
,`urlQrCode` varchar(500)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `vstatistiquesoeuvres`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `vstatistiquesoeuvres`;
CREATE TABLE IF NOT EXISTS `vstatistiquesoeuvres` (
`artisteNom` varchar(255)
,`artistePrenom` varchar(255)
,`derniereConsultation` datetime
,`idOeuvre` int
,`nbConsultations` bigint
,`titre` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure de la vue `vexpositionsactives`
--
DROP TABLE IF EXISTS `vexpositionsactives`;

DROP VIEW IF EXISTS `vexpositionsactives`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vexpositionsactives`  AS SELECT `e`.`idExposition` AS `idExposition`, `e`.`titre` AS `titre`, `e`.`theme` AS `theme`, `e`.`dateDebut` AS `dateDebut`, `e`.`dateFin` AS `dateFin`, `e`.`modulePublicActif` AS `modulePublicActif`, count(distinct `o`.`idOeuvre`) AS `nbOeuvres`, count(distinct `o`.`idArtiste`) AS `nbArtistes` FROM (`exposition` `e` left join `oeuvre` `o` on((`e`.`idExposition` = `o`.`idExposition`))) WHERE (`e`.`modulePublicActif` = true) GROUP BY `e`.`idExposition`, `e`.`titre`, `e`.`theme`, `e`.`dateDebut`, `e`.`dateFin`, `e`.`modulePublicActif` ;

-- --------------------------------------------------------

--
-- Structure de la vue `voeuvrescompletes`
--
DROP TABLE IF EXISTS `voeuvrescompletes`;

DROP VIEW IF EXISTS `voeuvrescompletes`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `voeuvrescompletes`  AS SELECT `o`.`idOeuvre` AS `idOeuvre`, `o`.`titre` AS `titre`, `o`.`description` AS `description`, `o`.`technique` AS `technique`, `o`.`anneeCreation` AS `anneeCreation`, `o`.`image` AS `image`, `o`.`urlQrCode` AS `urlQrCode`, `a`.`nom` AS `artisteNom`, `a`.`prenom` AS `artistePrenom`, concat(`a`.`prenom`,' ',`a`.`nom`) AS `artisteComplet`, `e`.`titre` AS `expositionTitre`, `e`.`dateDebut` AS `expositionDebut`, `e`.`dateFin` AS `expositionFin`, `esp`.`nomEspace` AS `espaceNom`, `emp`.`description` AS `emplacementDescription`, `o`.`ordreVisite` AS `ordreVisite` FROM ((((`oeuvre` `o` join `artiste` `a` on((`o`.`idArtiste` = `a`.`idArtiste`))) left join `exposition` `e` on((`o`.`idExposition` = `e`.`idExposition`))) left join `emplacement` `emp` on((`o`.`idEmplacement` = `emp`.`idEmplacement`))) left join `espace` `esp` on((`emp`.`idEspace` = `esp`.`idEspace`))) ;

-- --------------------------------------------------------

--
-- Structure de la vue `vstatistiquesoeuvres`
--
DROP TABLE IF EXISTS `vstatistiquesoeuvres`;

DROP VIEW IF EXISTS `vstatistiquesoeuvres`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vstatistiquesoeuvres`  AS SELECT `o`.`idOeuvre` AS `idOeuvre`, `o`.`titre` AS `titre`, `a`.`nom` AS `artisteNom`, `a`.`prenom` AS `artistePrenom`, count(`c`.`idConsultation`) AS `nbConsultations`, max(`c`.`dateConsultation`) AS `derniereConsultation` FROM ((`oeuvre` `o` join `artiste` `a` on((`o`.`idArtiste` = `a`.`idArtiste`))) left join `consultation` `c` on((`o`.`idOeuvre` = `c`.`idOeuvre`))) GROUP BY `o`.`idOeuvre`, `o`.`titre`, `a`.`nom`, `a`.`prenom` ;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `artiste`
--
ALTER TABLE `artiste`
  ADD CONSTRAINT `artiste_ibfk_1` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `consultation`
--
ALTER TABLE `consultation`
  ADD CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`idOeuvre`) REFERENCES `oeuvre` (`idOeuvre`);

--
-- Contraintes pour la table `contenuenrichi`
--
ALTER TABLE `contenuenrichi`
  ADD CONSTRAINT `contenuenrichi_ibfk_1` FOREIGN KEY (`idOeuvre`) REFERENCES `oeuvre` (`idOeuvre`),
  ADD CONSTRAINT `contenuenrichi_ibfk_2` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `emplacement`
--
ALTER TABLE `emplacement`
  ADD CONSTRAINT `emplacement_ibfk_1` FOREIGN KEY (`idEspace`) REFERENCES `espace` (`idEspace`),
  ADD CONSTRAINT `emplacement_ibfk_2` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`);

--
-- Contraintes pour la table `employe`
--
ALTER TABLE `employe`
  ADD CONSTRAINT `employe_ibfk_1` FOREIGN KEY (`idFonction`) REFERENCES `fonction` (`idFonction`);

--
-- Contraintes pour la table `etape`
--
ALTER TABLE `etape`
  ADD CONSTRAINT `etape_ibfk_1` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`);

--
-- Contraintes pour la table `exposition`
--
ALTER TABLE `exposition`
  ADD CONSTRAINT `exposition_ibfk_1` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `oeuvre`
--
ALTER TABLE `oeuvre`
  ADD CONSTRAINT `oeuvre_ibfk_1` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`),
  ADD CONSTRAINT `oeuvre_ibfk_2` FOREIGN KEY (`idEmplacement`) REFERENCES `emplacement` (`idEmplacement`),
  ADD CONSTRAINT `oeuvre_ibfk_3` FOREIGN KEY (`idArtiste`) REFERENCES `artiste` (`idArtiste`),
  ADD CONSTRAINT `oeuvre_ibfk_4` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `traductionartiste`
--
ALTER TABLE `traductionartiste`
  ADD CONSTRAINT `traductionartiste_ibfk_1` FOREIGN KEY (`idArtiste`) REFERENCES `artiste` (`idArtiste`),
  ADD CONSTRAINT `traductionartiste_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductionartiste_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `traductioncontenuenrichi`
--
ALTER TABLE `traductioncontenuenrichi`
  ADD CONSTRAINT `traductioncontenuenrichi_ibfk_1` FOREIGN KEY (`idContenuEnrichi`) REFERENCES `contenuenrichi` (`idContenuEnrichi`),
  ADD CONSTRAINT `traductioncontenuenrichi_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductioncontenuenrichi_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `traductionexpo`
--
ALTER TABLE `traductionexpo`
  ADD CONSTRAINT `traductionexpo_ibfk_1` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`),
  ADD CONSTRAINT `traductionexpo_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductionexpo_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Contraintes pour la table `traductionoeuvre`
--
ALTER TABLE `traductionoeuvre`
  ADD CONSTRAINT `traductionoeuvre_ibfk_1` FOREIGN KEY (`idOeuvre`) REFERENCES `oeuvre` (`idOeuvre`),
  ADD CONSTRAINT `traductionoeuvre_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductionoeuvre_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
