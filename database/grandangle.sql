-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 11, 2026 at 10:53 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grand_angle`
--

DELIMITER $$
--
-- Procedures
--
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
-- Table structure for table `artiste`
--

CREATE TABLE `artiste` (
  `idArtiste` int NOT NULL,
  `nom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `anneeNaissance` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Artistes (créateurs des œuvres)';

--
-- Dumping data for table `artiste`
--

INSERT INTO `artiste` (`idArtiste`, `nom`, `prenom`, `anneeNaissance`, `description`, `image`, `dateAjout`, `idEmploye`) VALUES
(1, 'DUPONT', 'Jean', 1975, 'Peintre contemporain reconnu pour ses œuvres abstraites utilisant des couleurs vives et des formes géométriques. Ses travaux explorent les émotions humaines à travers la couleur.', 'dupont_jean.jpg', '2025-01-20 10:00:00', 1),
(2, 'MARTIN', 'Claire', 1982, 'Sculptrice spécialisée dans les installations monumentales en métal recyclé. Son travail questionne notre rapport à la consommation et à l\'environnement.', 'martin_claire.jpg', '2025-01-20 11:00:00', 1),
(3, 'BERNARD', 'Paul', 1968, 'Photographe documentaire primé, connu pour ses séries sur les paysages urbains en transformation. Ses clichés capturent la poésie des lieux abandonnés.', 'bernard_paul.jpg', '2025-01-21 09:30:00', 2),
(4, 'PETIT', 'Anne', 1990, 'Artiste multimédia explorant les frontières entre réel et virtuel. Ses créations immersives mêlent vidéo, son et installation interactive.', 'petit_anne.jpg', '2025-01-21 14:00:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `configuration`
--

CREATE TABLE `configuration` (
  `idConfiguration` int NOT NULL,
  `cle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `valeur` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Paramètres de configuration du système';

--
-- Dumping data for table `configuration`
--

INSERT INTO `configuration` (`idConfiguration`, `cle`, `valeur`, `description`) VALUES
(1, 'siteName', 'Centre d\'Art Grand Angle', 'Nom du centre'),
(2, 'siteUrl', 'https://www.grandangle.fr', 'URL du site web'),
(3, 'emailContact', 'contact@grandangle.fr', 'Email de contact'),
(4, 'horairesCentre', 'Lundi-Vendredi 10h-18h, Samedi 10h-20h, Dimanche fermé', 'Horaires par défaut du centre');

-- --------------------------------------------------------

--
-- Table structure for table `consultation`
--

CREATE TABLE `consultation` (
  `idConsultation` int NOT NULL,
  `dateConsultation` datetime DEFAULT CURRENT_TIMESTAMP,
  `idOeuvre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Logs de consultation des œuvres (module public)';

--
-- Dumping data for table `consultation`
--

INSERT INTO `consultation` (`idConsultation`, `dateConsultation`, `idOeuvre`) VALUES
(1, '2026-02-05 14:30:00', 1),
(2, '2026-02-05 14:45:00', 2),
(3, '2026-02-05 15:00:00', 1),
(4, '2026-02-05 15:15:00', 3),
(5, '2026-02-06 10:20:00', 1),
(6, '2026-02-06 10:35:00', 4),
(7, '2026-04-20 16:10:00', 5),
(8, '2026-04-20 16:25:00', 6);

-- --------------------------------------------------------

--
-- Table structure for table `contenuenrichi`
--

CREATE TABLE `contenuenrichi` (
  `idContenuEnrichi` int NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordreAffichage` int DEFAULT '1',
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idOeuvre` int NOT NULL,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Contenus enrichis supplémentaires en français (audio, vidéo, images détail...)';

--
-- Dumping data for table `contenuenrichi`
--

INSERT INTO `contenuenrichi` (`idContenuEnrichi`, `description`, `urlAcces`, `ordreAffichage`, `dateAjout`, `idOeuvre`, `idEmploye`) VALUES
(1, 'Interview de l\'artiste sur le processus créatif de cette œuvre', 'video/aube_doree_interview.mp4', 1, '2025-12-25 10:00:00', 1, 2),
(2, 'Vue détaillée des techniques de peinture utilisées', 'video/aube_doree_technique.mp4', 2, '2025-12-25 10:30:00', 1, 2),
(3, 'Reportage sur le lieu avant sa fermeture', 'video/usine_07_reportage.mp4', 1, '2026-01-07 11:00:00', 5, 2),
(4, 'Galerie de clichés du même lieu à différentes époques', 'galerie/usine_07_evolution/', 2, '2026-01-07 11:30:00', 5, 2);

-- --------------------------------------------------------

--
-- Table structure for table `emplacement`
--

CREATE TABLE `emplacement` (
  `idEmplacement` int NOT NULL,
  `positionX` decimal(5,2) DEFAULT NULL,
  `positionY` decimal(5,2) DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idEspace` int NOT NULL,
  `idExposition` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Emplacements physiques des œuvres (avec coordonnées X/Y)';

--
-- Dumping data for table `emplacement`
--

INSERT INTO `emplacement` (`idEmplacement`, `positionX`, `positionY`, `description`, `idEspace`, `idExposition`) VALUES
(1, 2.50, 1.00, 'Mur sud - Espace 1', 2, 1),
(2, 5.00, 2.50, 'Mur est - Espace 1', 2, 1),
(3, 3.00, 1.50, 'Mur nord - Espace 2', 3, 1),
(4, 6.00, 2.00, 'Zone centrale - Espace 2', 3, 1),
(5, 2.00, 1.00, 'Section friches - Mur ouest', 4, 2),
(6, 5.00, 1.00, 'Section chantiers - Mur nord', 4, 2),
(7, 8.00, 2.50, 'Panorama grand format - Mur est', 4, 2),
(8, 4.00, 3.00, 'Installation centrale', 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `employe`
--

CREATE TABLE `employe` (
  `idEmploye` int NOT NULL,
  `nom` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `login` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `supprime` tinyint(1) DEFAULT '0',
  `dateCreation` datetime DEFAULT CURRENT_TIMESTAMP,
  `dateSuppression` datetime DEFAULT NULL,
  `idFonction` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Employés du centre (avec soft delete)';

--
-- Dumping data for table `employe`
--

INSERT INTO `employe` (`idEmploye`, `nom`, `prenom`, `email`, `role`, `login`, `mdp`, `actif`, `supprime`, `dateCreation`, `dateSuppression`, `idFonction`) VALUES
(1, 'FIORET', 'Marc', 'marc.fioret@grandangle.fr', 'admin', 'mfioret', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 0, '2025-01-15 09:00:00', NULL, 'DIR'),
(2, 'LECOURT', 'Sophie', 'sophie.lecourt@grandangle.fr', 'gestionnaire', 'slecourt', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 0, '2025-01-16 10:30:00', NULL, 'RCO'),
(3, 'DUBRAC', 'Pierre', 'pierre.dubrac@grandangle.fr', 'gestionnaire', 'pdubrac', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 0, '2025-01-16 11:00:00', NULL, 'RTE'),
(4, 'MARTIN', 'Julie', 'julie.martin@grandangle.fr', 'gestionnaire', 'jmartin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 0, '2025-01-17 09:30:00', NULL, 'ASS');

--
-- Triggers `employe`
--
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
-- Table structure for table `espace`
--

CREATE TABLE `espace` (
  `idEspace` int NOT NULL,
  `nomEspace` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `superficieM2` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Espaces physiques du centre (Salle A, Salle B, Jardin...)';

--
-- Dumping data for table `espace`
--

INSERT INTO `espace` (`idEspace`, `nomEspace`, `description`, `superficieM2`) VALUES
(1, 'Hall Principal', 'Hall d\'accueil et espace de circulation principal. Permet l\'accès aux trois espaces d\'exposition.', 150.00),
(2, 'Espace 1', 'Salle d\'exposition polyvalente située au sud-est du bâtiment. Éclairage mixte naturel et artificiel.', 300.00),
(3, 'Espace 2', 'Salle d\'exposition située au nord-est. Baies vitrées offrant une lumière naturelle abondante.', 350.00),
(4, 'Espace 3', 'Grande salle d\'exposition principale située à l\'ouest. Espace modulable pour installations monumentales et expositions temporaires majeures.', 400.00);

-- --------------------------------------------------------

--
-- Table structure for table `etape`
--

CREATE TABLE `etape` (
  `idEtape` int NOT NULL,
  `libelle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordre` int NOT NULL,
  `idExposition` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Étapes de préparation d''une exposition (Conception, Installation, Vernissage...)';

--
-- Dumping data for table `etape`
--

INSERT INTO `etape` (`idEtape`, `libelle`, `ordre`, `idExposition`) VALUES
(1, 'Conception du projet', 1, 1),
(2, 'Sélection des œuvres', 2, 1),
(3, 'Installation technique', 3, 1),
(4, 'Vernissage', 4, 1),
(5, 'Validation commissaire', 1, 2),
(6, 'Encadrement photos', 2, 2),
(7, 'Accrochage', 3, 2),
(8, 'Soirée d\'ouverture', 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `exposition`
--

CREATE TABLE `exposition` (
  `idExposition` int NOT NULL,
  `titre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateDebut` date DEFAULT NULL,
  `dateFin` date DEFAULT NULL,
  `horaires` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modulePublicActif` tinyint(1) DEFAULT '0',
  `dateCreation` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `exposition`
--

INSERT INTO `exposition` (`idExposition`, `titre`, `theme`, `dateDebut`, `dateFin`, `horaires`, `description`, `image`, `modulePublicActif`, `dateCreation`, `idEmploye`) VALUES
(1, 'Lumières et Ombres', 'Art contemporain', '2026-02-01', '2026-03-31', NULL, 'Une exploration fascinante du contraste entre lumière et obscurité à travers les œuvres de quatre artistes contemporains. Cette exposition invite le visiteur à réfléchir sur les dualités de l\'existence humaine.', 'expo_lumieres.jpg', 1, '2025-12-15 10:00:00', 1),
(2, 'Métamorphoses Urbaines', 'Photographie', '2026-04-15', '2026-06-30', 'Lundi-Vendredi 14h-22h, Samedi 10h-23h', 'Paul Bernard présente une rétrospective de 20 ans de photographie urbaine. Des friches industrielles aux gratte-ciels en construction, découvrez la ville comme vous ne l\'avez jamais vue.', 'expo_urbain.jpg', 1, '2025-12-20 11:00:00', 1),
(3, 'Sculptures du Futur', 'Sculpture', '2026-07-01', '2026-08-31', NULL, 'Claire Martin expose ses créations monumentales en métal recyclé. Une réflexion puissante sur notre société de consommation et l\'avenir de notre planète à travers des œuvres impressionnantes.', 'expo_sculptures.jpg', 0, '2026-01-10 09:00:00', 2),
(4, 'Réalités Virtuelles', 'Art numérique', '2026-09-15', '2026-11-15', NULL, 'Anne Petit propose une immersion totale dans des univers numériques fascinants. Une expérience sensorielle unique qui questionne notre rapport au réel et au virtuel.', 'expo_virtuel.jpg', 0, '2026-01-15 14:30:00', 2);

-- --------------------------------------------------------

--
-- Table structure for table `fonction`
--

CREATE TABLE `fonction` (
  `idFonction` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `intitule` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Fonctions métier des employés (Directeur, Gestionnaire, Traducteur...)';

--
-- Dumping data for table `fonction`
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
-- Table structure for table `langue`
--

CREATE TABLE `langue` (
  `idLangue` int NOT NULL,
  `code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Langues disponibles (FR, EN, DE, RU, ZH)';

--
-- Dumping data for table `langue`
--

INSERT INTO `langue` (`idLangue`, `code`, `nom`, `img`) VALUES
(1, 'FR', 'Français', 'asset/img/drapeau_francais.svg'),
(2, 'EN', 'English', 'asset/img/drapeau_anglais.svg'),
(3, 'DE', 'Deutsch', 'asset/img/drapeau_allemand.svg'),
(4, 'RU', 'Русский', 'asset/img/drapeau_russe.svg'),
(5, 'ZH', '中文', 'asset/img/drapeau_chinois.svg');

-- --------------------------------------------------------

--
-- Table structure for table `oeuvre`
--

CREATE TABLE `oeuvre` (
  `idOeuvre` int NOT NULL,
  `titre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `technique` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `anneeCreation` int DEFAULT NULL,
  `hauteurCm` decimal(10,2) DEFAULT NULL,
  `largeurCm` decimal(10,2) DEFAULT NULL,
  `profondeurCm` decimal(10,2) DEFAULT NULL,
  `dateLivraisonPrevue` date DEFAULT NULL,
  `dateLivraisonReelle` date DEFAULT NULL,
  `numeroIdentification` int DEFAULT NULL,
  `ordreVisite` int DEFAULT NULL,
  `urlQrCode` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idExposition` int DEFAULT NULL,
  `idEmplacement` int DEFAULT NULL,
  `idArtiste` int NOT NULL,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `oeuvre`
--

INSERT INTO `oeuvre` (`idOeuvre`, `titre`, `description`, `image`, `technique`, `anneeCreation`, `hauteurCm`, `largeurCm`, `profondeurCm`, `dateLivraisonPrevue`, `dateLivraisonReelle`, `numeroIdentification`, `ordreVisite`, `urlQrCode`, `dateAjout`, `idExposition`, `idEmplacement`, `idArtiste`, `idEmploye`) VALUES
(1, 'Aube Dorée', 'Explosion de lumière matinale capturée à travers des aplats de couleurs chaudes. L\'artiste joue avec les contrastes pour évoquer l\'espoir du nouveau jour.', 'aube_doree.jpg', 'Huile sur toile', 2024, 120.00, 80.00, NULL, NULL, NULL, 1001, 1, NULL, '2025-12-20 10:00:00', 1, 1, 1, 2),
(2, 'Nuit Étoilée Urbaine', 'Interprétation moderne de la nuit en ville, où les lumières artificielles créent une constellation terrestre fascinante.', 'nuit_urbaine.jpg', 'Acrylique sur toile', 2025, 100.00, 150.00, NULL, NULL, NULL, 1002, 2, NULL, '2025-12-20 11:00:00', 1, 2, 1, 2),
(3, 'L\'Ombre du Doute', 'Sculpture représentant une silhouette humaine fragmentée, symbolisant l\'incertitude et les questionnements intérieurs.', 'ombre_doute.jpg', 'Bronze patiné', 2023, 180.00, 60.00, 60.00, NULL, NULL, 1003, 3, NULL, '2025-12-21 09:00:00', 1, 3, 2, 2),
(4, 'Entre Chien et Loup', 'Photographie capturant ce moment suspendu entre jour et nuit, où la lumière hésite et crée une ambiance mystérieuse.', 'chien_loup.jpg', 'Photographie numérique', 2024, 90.00, 120.00, NULL, NULL, NULL, 1004, 4, NULL, '2025-12-21 10:00:00', 1, 4, 3, 2),
(5, 'Usine Désaffectée #7', 'Une friche industrielle baignée de lumière naturelle, témoignage silencieux d\'un passé révolu. La nature reprend doucement ses droits.', 'usine_07.jpg', 'Photographie argentique', 2018, 70.00, 100.00, NULL, NULL, NULL, 2001, 1, NULL, '2026-01-05 11:00:00', 2, 5, 3, 2),
(6, 'Tour en Construction', 'Le squelette d\'acier d\'une future tour se dresse vers le ciel. L\'image capture l\'ambition humaine de toujours construire plus haut.', 'tour_construction.jpg', 'Photographie numérique', 2022, 150.00, 100.00, NULL, NULL, NULL, 2002, 2, NULL, '2026-01-05 11:30:00', 2, 6, 3, 2),
(7, 'Panorama Métropolitain', 'Vue panoramique nocturne de la ville en mutation. Des milliers de lumières témoignent de l\'activité humaine incessante.', 'panorama_metro.jpg', 'Photographie grand format', 2023, 100.00, 300.00, NULL, NULL, NULL, 2003, 3, NULL, '2026-01-05 14:00:00', 2, 7, 3, 2),
(8, 'Triptyque Urbain', 'Trois moments d\'une même rue : aube, midi, crépuscule. La lumière transforme complètement l\'espace urbain au fil du jour.', 'triptyque_urbain.jpg', 'Série photographique', 2024, 80.00, 240.00, NULL, NULL, NULL, 2004, 4, NULL, '2026-01-05 15:00:00', 2, 8, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `traductionartiste`
--

CREATE TABLE `traductionartiste` (
  `idTraductionArtiste` int NOT NULL,
  `idArtiste` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des descriptions d''artistes';

--
-- Dumping data for table `traductionartiste`
--

INSERT INTO `traductionartiste` (`idTraductionArtiste`, `idArtiste`, `idLangue`, `traductionTexte`, `urlAcces`, `dateAjout`, `idEmploye`) VALUES
(1, 1, 2, 'Contemporary painter renowned for his abstract works using vibrant colors and geometric shapes. His work explores human emotions through color.', 'audio/dupont_bio_en.mp3', '2025-12-22 14:00:00', 4),
(2, 1, 3, 'Zeitgenössischer Maler, bekannt für seine abstrakten Werke mit lebendigen Farben und geometrischen Formen. Seine Arbeiten erforschen menschliche Emotionen durch Farbe.', 'audio/dupont_bio_de.mp3', '2025-12-22 14:15:00', 4),
(3, 3, 2, 'Award-winning documentary photographer, known for his series on transforming urban landscapes. His shots capture the poetry of abandoned places.', 'audio/bernard_bio_en.mp3', '2025-12-23 10:00:00', 4),
(4, 3, 3, 'Preisgekrönter Dokumentarfotograf, bekannt für seine Serien über sich wandelnde Stadtlandschaften. Seine Aufnahmen fangen die Poesie verlassener Orte ein.', 'audio/bernard_bio_de.mp3', '2025-12-23 10:15:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `traductioncontenuenrichi`
--

CREATE TABLE `traductioncontenuenrichi` (
  `idTraductionContenu` int NOT NULL,
  `idContenuEnrichi` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordreAffichage` int DEFAULT '1',
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des contenus enrichis';

--
-- Dumping data for table `traductioncontenuenrichi`
--

INSERT INTO `traductioncontenuenrichi` (`idTraductionContenu`, `idContenuEnrichi`, `idLangue`, `traductionTexte`, `urlAcces`, `ordreAffichage`, `dateAjout`, `idEmploye`) VALUES
(1, 1, 2, 'Artist interview about the creative process of this work', 'video/aube_doree_interview_en.mp4', 1, '2025-12-26 10:00:00', 4),
(2, 1, 3, 'Künstlerinterview über den kreativen Prozess dieses Werks', 'video/aube_doree_interview_de.mp4', 1, '2025-12-26 10:15:00', 4),
(3, 3, 2, 'Documentary about the place before its closure', 'video/usine_07_reportage_en.mp4', 1, '2026-01-08 10:00:00', 4),
(4, 3, 3, 'Dokumentation über den Ort vor seiner Schließung', 'video/usine_07_reportage_de.mp4', 1, '2026-01-08 10:15:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `traductionexpo`
--

CREATE TABLE `traductionexpo` (
  `idTraductionExpo` int NOT NULL,
  `idExposition` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des descriptions d''expositions';

--
-- Dumping data for table `traductionexpo`
--

INSERT INTO `traductionexpo` (`idTraductionExpo`, `idExposition`, `idLangue`, `traductionTexte`, `urlAcces`, `dateAjout`, `idEmploye`) VALUES
(1, 1, 2, 'A fascinating exploration of the contrast between light and darkness through the works of four contemporary artists. This exhibition invites visitors to reflect on the dualities of human existence.', 'audio/expo_lumieres_en.mp3', '2025-12-23 11:00:00', 4),
(2, 1, 3, 'Eine faszinierende Erkundung des Kontrasts zwischen Licht und Dunkelheit durch die Werke von vier zeitgenössischen Künstlern. Diese Ausstellung lädt Besucher ein, über die Dualitäten der menschlichen Existenz nachzudenken.', 'audio/expo_lumieres_de.mp3', '2025-12-23 11:15:00', 4),
(3, 2, 2, 'Paul Bernard presents a 20-year retrospective of urban photography. From industrial wastelands to skyscrapers under construction, discover the city as you have never seen it.', 'audio/expo_urbain_en.mp3', '2025-12-24 10:00:00', 4),
(4, 2, 3, 'Paul Bernard präsentiert eine 20-jährige Retrospektive der urbanen Fotografie. Von Industriebrachen bis zu Wolkenkratzern im Bau, entdecken Sie die Stadt, wie Sie sie noch nie gesehen haben.', 'audio/expo_urbain_de.mp3', '2025-12-24 10:15:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `traductionoeuvre`
--

CREATE TABLE `traductionoeuvre` (
  `idTraductionOeuvre` int NOT NULL,
  `idOeuvre` int NOT NULL,
  `idLangue` int NOT NULL,
  `traductionTexte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `urlAcces` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateAjout` datetime DEFAULT CURRENT_TIMESTAMP,
  `idEmploye` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Traductions des descriptions d''œuvres';

--
-- Dumping data for table `traductionoeuvre`
--

INSERT INTO `traductionoeuvre` (`idTraductionOeuvre`, `idOeuvre`, `idLangue`, `traductionTexte`, `urlAcces`, `dateAjout`, `idEmploye`) VALUES
(1, 1, 2, 'An explosion of morning light captured through warm color blocks. The artist plays with contrasts to evoke the hope of a new day.', 'audio/aube_doree_en.mp3', '2025-12-22 10:00:00', 4),
(2, 1, 3, 'Eine Explosion von Morgenlicht, eingefangen durch warme Farbflächen. Der Künstler spielt mit Kontrasten, um die Hoffnung eines neuen Tages hervorzurufen.', 'audio/aube_doree_de.mp3', '2025-12-22 10:15:00', 4),
(3, 2, 2, 'A modern interpretation of the city at night, where artificial lights create a fascinating terrestrial constellation.', 'audio/nuit_urbaine_en.mp3', '2025-12-22 11:00:00', 4),
(4, 2, 3, 'Eine moderne Interpretation der Nacht in der Stadt, wo künstliche Lichter eine faszinierende irdische Konstellation schaffen.', 'audio/nuit_urbaine_de.mp3', '2025-12-22 11:15:00', 4),
(5, 5, 2, 'An abandoned industrial site bathed in natural light, silent witness to a bygone past. Nature slowly reclaims its rights.', 'audio/usine_07_en.mp3', '2026-01-06 10:00:00', 4),
(6, 5, 3, 'Eine verlassene Industrieanlage in natürlichem Licht, stiller Zeuge einer vergangenen Zeit. Die Natur erobert langsam ihre Rechte zurück.', 'audio/usine_07_de.mp3', '2026-01-06 10:15:00', 4);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vexpositionsactives`
-- (See below for the actual view)
--
CREATE TABLE `vexpositionsactives` (
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
-- Stand-in structure for view `voeuvrescompletes`
-- (See below for the actual view)
--
CREATE TABLE `voeuvrescompletes` (
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
-- Stand-in structure for view `vstatistiquesoeuvres`
-- (See below for the actual view)
--
CREATE TABLE `vstatistiquesoeuvres` (
`artisteNom` varchar(255)
,`artistePrenom` varchar(255)
,`derniereConsultation` datetime
,`idOeuvre` int
,`nbConsultations` bigint
,`titre` varchar(255)
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artiste`
--
ALTER TABLE `artiste`
  ADD PRIMARY KEY (`idArtiste`),
  ADD KEY `idEmploye` (`idEmploye`);

--
-- Indexes for table `configuration`
--
ALTER TABLE `configuration`
  ADD PRIMARY KEY (`idConfiguration`),
  ADD UNIQUE KEY `cle` (`cle`);

--
-- Indexes for table `consultation`
--
ALTER TABLE `consultation`
  ADD PRIMARY KEY (`idConsultation`),
  ADD KEY `idxConsultationOeuvre` (`idOeuvre`),
  ADD KEY `idxConsultationDate` (`dateConsultation`);

--
-- Indexes for table `contenuenrichi`
--
ALTER TABLE `contenuenrichi`
  ADD PRIMARY KEY (`idContenuEnrichi`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxContenuOeuvre` (`idOeuvre`),
  ADD KEY `idxContenuOrdre` (`idOeuvre`,`ordreAffichage`);

--
-- Indexes for table `emplacement`
--
ALTER TABLE `emplacement`
  ADD PRIMARY KEY (`idEmplacement`),
  ADD KEY `idxEmplacementEspace` (`idEspace`),
  ADD KEY `idxEmplacementExpo` (`idExposition`);

--
-- Indexes for table `employe`
--
ALTER TABLE `employe`
  ADD PRIMARY KEY (`idEmploye`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `idFonction` (`idFonction`),
  ADD KEY `idxEmployeActif` (`actif`),
  ADD KEY `idxEmployeSupprime` (`supprime`);

--
-- Indexes for table `espace`
--
ALTER TABLE `espace`
  ADD PRIMARY KEY (`idEspace`),
  ADD UNIQUE KEY `nomEspace` (`nomEspace`);

--
-- Indexes for table `etape`
--
ALTER TABLE `etape`
  ADD PRIMARY KEY (`idEtape`),
  ADD UNIQUE KEY `idExposition` (`idExposition`,`ordre`);

--
-- Indexes for table `exposition`
--
ALTER TABLE `exposition`
  ADD PRIMARY KEY (`idExposition`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxExpositionDates` (`dateDebut`,`dateFin`),
  ADD KEY `idxExpositionActif` (`modulePublicActif`);

--
-- Indexes for table `fonction`
--
ALTER TABLE `fonction`
  ADD PRIMARY KEY (`idFonction`),
  ADD UNIQUE KEY `intitule` (`intitule`);

--
-- Indexes for table `langue`
--
ALTER TABLE `langue`
  ADD PRIMARY KEY (`idLangue`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `oeuvre`
--
ALTER TABLE `oeuvre`
  ADD PRIMARY KEY (`idOeuvre`),
  ADD UNIQUE KEY `numeroIdentification` (`numeroIdentification`),
  ADD KEY `idEmplacement` (`idEmplacement`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxOeuvreExposition` (`idExposition`),
  ADD KEY `idxOeuvreArtiste` (`idArtiste`),
  ADD KEY `idxOeuvreTechnique` (`technique`);

--
-- Indexes for table `traductionartiste`
--
ALTER TABLE `traductionartiste`
  ADD PRIMARY KEY (`idTraductionArtiste`),
  ADD KEY `idLangue` (`idLangue`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxTradArtisteArtisteLangue` (`idArtiste`,`idLangue`);

--
-- Indexes for table `traductioncontenuenrichi`
--
ALTER TABLE `traductioncontenuenrichi`
  ADD PRIMARY KEY (`idTraductionContenu`),
  ADD KEY `idLangue` (`idLangue`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxTradContenuContenuLangue` (`idContenuEnrichi`,`idLangue`),
  ADD KEY `idxTradContenuOrdre` (`idContenuEnrichi`,`idLangue`,`ordreAffichage`);

--
-- Indexes for table `traductionexpo`
--
ALTER TABLE `traductionexpo`
  ADD PRIMARY KEY (`idTraductionExpo`),
  ADD KEY `idLangue` (`idLangue`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxTradExpoExpoLangue` (`idExposition`,`idLangue`);

--
-- Indexes for table `traductionoeuvre`
--
ALTER TABLE `traductionoeuvre`
  ADD PRIMARY KEY (`idTraductionOeuvre`),
  ADD KEY `idLangue` (`idLangue`),
  ADD KEY `idEmploye` (`idEmploye`),
  ADD KEY `idxTradOeuvreOeuvreLangue` (`idOeuvre`,`idLangue`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artiste`
--
ALTER TABLE `artiste`
  MODIFY `idArtiste` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `configuration`
--
ALTER TABLE `configuration`
  MODIFY `idConfiguration` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `consultation`
--
ALTER TABLE `consultation`
  MODIFY `idConsultation` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `contenuenrichi`
--
ALTER TABLE `contenuenrichi`
  MODIFY `idContenuEnrichi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `emplacement`
--
ALTER TABLE `emplacement`
  MODIFY `idEmplacement` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `employe`
--
ALTER TABLE `employe`
  MODIFY `idEmploye` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `espace`
--
ALTER TABLE `espace`
  MODIFY `idEspace` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `etape`
--
ALTER TABLE `etape`
  MODIFY `idEtape` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `exposition`
--
ALTER TABLE `exposition`
  MODIFY `idExposition` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `langue`
--
ALTER TABLE `langue`
  MODIFY `idLangue` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oeuvre`
--
ALTER TABLE `oeuvre`
  MODIFY `idOeuvre` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `traductionartiste`
--
ALTER TABLE `traductionartiste`
  MODIFY `idTraductionArtiste` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `traductioncontenuenrichi`
--
ALTER TABLE `traductioncontenuenrichi`
  MODIFY `idTraductionContenu` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `traductionexpo`
--
ALTER TABLE `traductionexpo`
  MODIFY `idTraductionExpo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `traductionoeuvre`
--
ALTER TABLE `traductionoeuvre`
  MODIFY `idTraductionOeuvre` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

-- --------------------------------------------------------

--
-- Structure for view `vexpositionsactives`
--
DROP TABLE IF EXISTS `vexpositionsactives`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vexpositionsactives`  AS SELECT `e`.`idExposition` AS `idExposition`, `e`.`titre` AS `titre`, `e`.`theme` AS `theme`, `e`.`dateDebut` AS `dateDebut`, `e`.`dateFin` AS `dateFin`, `e`.`modulePublicActif` AS `modulePublicActif`, count(distinct `o`.`idOeuvre`) AS `nbOeuvres`, count(distinct `o`.`idArtiste`) AS `nbArtistes` FROM (`exposition` `e` left join `oeuvre` `o` on((`e`.`idExposition` = `o`.`idExposition`))) WHERE (`e`.`modulePublicActif` = true) GROUP BY `e`.`idExposition`, `e`.`titre`, `e`.`theme`, `e`.`dateDebut`, `e`.`dateFin`, `e`.`modulePublicActif` ;

-- --------------------------------------------------------

--
-- Structure for view `voeuvrescompletes`
--
DROP TABLE IF EXISTS `voeuvrescompletes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `voeuvrescompletes`  AS SELECT `o`.`idOeuvre` AS `idOeuvre`, `o`.`titre` AS `titre`, `o`.`description` AS `description`, `o`.`technique` AS `technique`, `o`.`anneeCreation` AS `anneeCreation`, `o`.`image` AS `image`, `o`.`urlQrCode` AS `urlQrCode`, `a`.`nom` AS `artisteNom`, `a`.`prenom` AS `artistePrenom`, concat(`a`.`prenom`,' ',`a`.`nom`) AS `artisteComplet`, `e`.`titre` AS `expositionTitre`, `e`.`dateDebut` AS `expositionDebut`, `e`.`dateFin` AS `expositionFin`, `esp`.`nomEspace` AS `espaceNom`, `emp`.`description` AS `emplacementDescription`, `o`.`ordreVisite` AS `ordreVisite` FROM ((((`oeuvre` `o` join `artiste` `a` on((`o`.`idArtiste` = `a`.`idArtiste`))) left join `exposition` `e` on((`o`.`idExposition` = `e`.`idExposition`))) left join `emplacement` `emp` on((`o`.`idEmplacement` = `emp`.`idEmplacement`))) left join `espace` `esp` on((`emp`.`idEspace` = `esp`.`idEspace`))) ;

-- --------------------------------------------------------

--
-- Structure for view `vstatistiquesoeuvres`
--
DROP TABLE IF EXISTS `vstatistiquesoeuvres`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vstatistiquesoeuvres`  AS SELECT `o`.`idOeuvre` AS `idOeuvre`, `o`.`titre` AS `titre`, `a`.`nom` AS `artisteNom`, `a`.`prenom` AS `artistePrenom`, count(`c`.`idConsultation`) AS `nbConsultations`, max(`c`.`dateConsultation`) AS `derniereConsultation` FROM ((`oeuvre` `o` join `artiste` `a` on((`o`.`idArtiste` = `a`.`idArtiste`))) left join `consultation` `c` on((`o`.`idOeuvre` = `c`.`idOeuvre`))) GROUP BY `o`.`idOeuvre`, `o`.`titre`, `a`.`nom`, `a`.`prenom` ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `artiste`
--
ALTER TABLE `artiste`
  ADD CONSTRAINT `artiste_ibfk_1` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `consultation`
--
ALTER TABLE `consultation`
  ADD CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`idOeuvre`) REFERENCES `oeuvre` (`idOeuvre`);

--
-- Constraints for table `contenuenrichi`
--
ALTER TABLE `contenuenrichi`
  ADD CONSTRAINT `contenuenrichi_ibfk_1` FOREIGN KEY (`idOeuvre`) REFERENCES `oeuvre` (`idOeuvre`),
  ADD CONSTRAINT `contenuenrichi_ibfk_2` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `emplacement`
--
ALTER TABLE `emplacement`
  ADD CONSTRAINT `emplacement_ibfk_1` FOREIGN KEY (`idEspace`) REFERENCES `espace` (`idEspace`),
  ADD CONSTRAINT `emplacement_ibfk_2` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`);

--
-- Constraints for table `employe`
--
ALTER TABLE `employe`
  ADD CONSTRAINT `employe_ibfk_1` FOREIGN KEY (`idFonction`) REFERENCES `fonction` (`idFonction`);

--
-- Constraints for table `etape`
--
ALTER TABLE `etape`
  ADD CONSTRAINT `etape_ibfk_1` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`);

--
-- Constraints for table `exposition`
--
ALTER TABLE `exposition`
  ADD CONSTRAINT `exposition_ibfk_1` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `oeuvre`
--
ALTER TABLE `oeuvre`
  ADD CONSTRAINT `oeuvre_ibfk_1` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`),
  ADD CONSTRAINT `oeuvre_ibfk_2` FOREIGN KEY (`idEmplacement`) REFERENCES `emplacement` (`idEmplacement`),
  ADD CONSTRAINT `oeuvre_ibfk_3` FOREIGN KEY (`idArtiste`) REFERENCES `artiste` (`idArtiste`),
  ADD CONSTRAINT `oeuvre_ibfk_4` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `traductionartiste`
--
ALTER TABLE `traductionartiste`
  ADD CONSTRAINT `traductionartiste_ibfk_1` FOREIGN KEY (`idArtiste`) REFERENCES `artiste` (`idArtiste`),
  ADD CONSTRAINT `traductionartiste_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductionartiste_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `traductioncontenuenrichi`
--
ALTER TABLE `traductioncontenuenrichi`
  ADD CONSTRAINT `traductioncontenuenrichi_ibfk_1` FOREIGN KEY (`idContenuEnrichi`) REFERENCES `contenuenrichi` (`idContenuEnrichi`),
  ADD CONSTRAINT `traductioncontenuenrichi_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductioncontenuenrichi_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `traductionexpo`
--
ALTER TABLE `traductionexpo`
  ADD CONSTRAINT `traductionexpo_ibfk_1` FOREIGN KEY (`idExposition`) REFERENCES `exposition` (`idExposition`),
  ADD CONSTRAINT `traductionexpo_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductionexpo_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);

--
-- Constraints for table `traductionoeuvre`
--
ALTER TABLE `traductionoeuvre`
  ADD CONSTRAINT `traductionoeuvre_ibfk_1` FOREIGN KEY (`idOeuvre`) REFERENCES `oeuvre` (`idOeuvre`),
  ADD CONSTRAINT `traductionoeuvre_ibfk_2` FOREIGN KEY (`idLangue`) REFERENCES `langue` (`idLangue`),
  ADD CONSTRAINT `traductionoeuvre_ibfk_3` FOREIGN KEY (`idEmploye`) REFERENCES `employe` (`idEmploye`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
