-- ============================================================================
-- DONNÉES DE TEST - GRAND ANGLE
-- ============================================================================
-- 4 enregistrements par table (sauf tables de référence déjà remplies)
-- ⚠️ Ordre d'insertion respecté pour les clés étrangères
-- ============================================================================

USE grand_angle;

-- ============================================================================
-- NETTOYAGE (si nécessaire - décommenter pour réinitialiser)
-- ============================================================================
/*
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Consultation;
TRUNCATE TABLE TraductionContenuEnrichi;
TRUNCATE TABLE ContenuEnrichi;
TRUNCATE TABLE TraductionExpo;
TRUNCATE TABLE TraductionArtiste;
TRUNCATE TABLE TraductionOeuvre;
TRUNCATE TABLE Oeuvre;
TRUNCATE TABLE Artiste;
TRUNCATE TABLE Emplacement;
TRUNCATE TABLE Etape;
TRUNCATE TABLE Exposition;
TRUNCATE TABLE Employe;
TRUNCATE TABLE Espace;
SET FOREIGN_KEY_CHECKS = 1;
*/

-- ============================================================================
-- 1. EMPLOYÉS (dépend de FONCTION)
-- ============================================================================

INSERT INTO Employe (nom, prenom, email, role, login, mdp, actif, dateCreation, idFonction) VALUES
-- Mot de passe pour tous : "password" (hash bcrypt)
('FIORET', 'Marc', 'marc.fioret@grandangle.fr', 'admin', 'mfioret', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', TRUE, '2025-01-15 09:00:00', 'DIR'),
('LECOURT', 'Sophie', 'sophie.lecourt@grandangle.fr', 'gestionnaire', 'slecourt', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', TRUE, '2025-01-16 10:30:00', 'RCO'),
('DUBRAC', 'Pierre', 'pierre.dubrac@grandangle.fr', 'gestionnaire', 'pdubrac', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', TRUE, '2025-01-16 11:00:00', 'RTE'),
('MARTIN', 'Julie', 'julie.martin@grandangle.fr', 'gestionnaire', 'jmartin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', TRUE, '2025-01-17 09:30:00', 'ASS');

-- ============================================================================
-- 2. ARTISTES (dépend de EMPLOYE)
-- ============================================================================

INSERT INTO Artiste (nom, prenom, anneeNaissance, description, image, dateAjout, idEmploye) VALUES
('DUPONT', 'Jean', 1975, 'Peintre contemporain reconnu pour ses œuvres abstraites utilisant des couleurs vives et des formes géométriques. Ses travaux explorent les émotions humaines à travers la couleur.', 'dupont_jean.jpg', '2025-01-20 10:00:00', 1),
('MARTIN', 'Claire', 1982, 'Sculptrice spécialisée dans les installations monumentales en métal recyclé. Son travail questionne notre rapport à la consommation et à l\'environnement.', 'martin_claire.jpg', '2025-01-20 11:00:00', 1),
('BERNARD', 'Paul', 1968, 'Photographe documentaire primé, connu pour ses séries sur les paysages urbains en transformation. Ses clichés capturent la poésie des lieux abandonnés.', 'bernard_paul.jpg', '2025-01-21 09:30:00', 2),
('PETIT', 'Anne', 1990, 'Artiste multimédia explorant les frontières entre réel et virtuel. Ses créations immersives mêlent vidéo, son et installation interactive.', 'petit_anne.jpg', '2025-01-21 14:00:00', 2);

-- ============================================================================
-- 3. EXPOSITIONS (dépend de EMPLOYE)
-- ============================================================================

INSERT INTO Exposition (titre, theme, dateDebut, dateFin, horaires, description, image, modulePublicActif, dateCreation, idEmploye) VALUES
('Lumières et Ombres', 'Art contemporain', '2026-02-01', '2026-03-31', NULL, 'Une exploration fascinante du contraste entre lumière et obscurité à travers les œuvres de quatre artistes contemporains. Cette exposition invite le visiteur à réfléchir sur les dualités de l\'existence humaine.', 'expo_lumieres.jpg', TRUE, '2025-12-15 10:00:00', 1),
('Métamorphoses Urbaines', 'Photographie', '2026-04-15', '2026-06-30', 'Lundi-Vendredi 14h-22h, Samedi 10h-23h', 'Paul Bernard présente une rétrospective de 20 ans de photographie urbaine. Des friches industrielles aux gratte-ciels en construction, découvrez la ville comme vous ne l\'avez jamais vue.', 'expo_urbain.jpg', TRUE, '2025-12-20 11:00:00', 1),
('Sculptures du Futur', 'Sculpture', '2026-07-01', '2026-08-31', NULL, 'Claire Martin expose ses créations monumentales en métal recyclé. Une réflexion puissante sur notre société de consommation et l\'avenir de notre planète à travers des œuvres impressionnantes.', 'expo_sculptures.jpg', FALSE, '2026-01-10 09:00:00', 2),
('Réalités Virtuelles', 'Art numérique', '2026-09-15', '2026-11-15', NULL, 'Anne Petit propose une immersion totale dans des univers numériques fascinants. Une expérience sensorielle unique qui questionne notre rapport au réel et au virtuel.', 'expo_virtuel.jpg', FALSE, '2026-01-15 14:30:00', 2);

-- ============================================================================
-- 4. ESPACES (salles du centre)
-- ============================================================================

INSERT INTO Espace (nomEspace, description, superficieM2) VALUES
('Hall Principal', 'Hall d\'accueil et espace de circulation principal. Permet l\'accès aux trois espaces d\'exposition.', 150.00),
('Espace 1', 'Salle d\'exposition polyvalente située au sud-est du bâtiment. Éclairage mixte naturel et artificiel.', 300.00),
('Espace 2', 'Salle d\'exposition située au nord-est. Baies vitrées offrant une lumière naturelle abondante.', 350.00),
('Espace 3', 'Grande salle d\'exposition principale située à l\'ouest. Espace modulable pour installations monumentales et expositions temporaires majeures.', 400.00);

-- ============================================================================
-- 5. ÉTAPES (dépend de EXPOSITION)
-- ============================================================================

-- Étapes pour expo 1 "Lumières et Ombres"
INSERT INTO Etape (libelle, ordre, idExposition) VALUES
('Conception du projet', 1, 1),
('Sélection des œuvres', 2, 1),
('Installation technique', 3, 1),
('Vernissage', 4, 1);

-- Étapes pour expo 2 "Métamorphoses Urbaines"
INSERT INTO Etape (libelle, ordre, idExposition) VALUES
('Validation commissaire', 1, 2),
('Encadrement photos', 2, 2),
('Accrochage', 3, 2),
('Soirée d\'ouverture', 4, 2);

-- ============================================================================
-- 6. EMPLACEMENTS (dépend de ESPACE et EXPOSITION)
-- ============================================================================

-- Emplacements pour expo 1 "Lumières et Ombres" (Espace 1 et Espace 2)
INSERT INTO Emplacement (positionX, positionY, description, idEspace, idExposition) VALUES
(2.5, 1.0, 'Mur sud - Espace 1', 2, 1),
(5.0, 2.5, 'Mur est - Espace 1', 2, 1),
(3.0, 1.5, 'Mur nord - Espace 2', 3, 1),
(6.0, 2.0, 'Zone centrale - Espace 2', 3, 1);

-- Emplacements pour expo 2 "Métamorphoses Urbaines" (Espace 3 - grande salle)
INSERT INTO Emplacement (positionX, positionY, description, idEspace, idExposition) VALUES
(2.0, 1.0, 'Section friches - Mur ouest', 4, 2),
(5.0, 1.0, 'Section chantiers - Mur nord', 4, 2),
(8.0, 2.5, 'Panorama grand format - Mur est', 4, 2),
(4.0, 3.0, 'Installation centrale', 4, 2);

-- ============================================================================
-- 7. ŒUVRES (dépend de EXPOSITION, EMPLACEMENT, ARTISTE, EMPLOYE)
-- ============================================================================

-- Œuvres expo 1 "Lumières et Ombres"
INSERT INTO Oeuvre (titre, description, image, technique, anneeCreation, hauteurCm, largeurCm, profondeurCm, numeroIdentification, ordreVisite, urlQrCode, dateAjout, idExposition, idEmplacement, idArtiste, idEmploye) VALUES
('Aube Dorée', 'Explosion de lumière matinale capturée à travers des aplats de couleurs chaudes. L\'artiste joue avec les contrastes pour évoquer l\'espoir du nouveau jour.', 'aube_doree.jpg', 'Huile sur toile', 2024, 120.00, 80.00, NULL, 1001, 1, NULL, '2025-12-20 10:00:00', 1, 1, 1, 2),
('Nuit Étoilée Urbaine', 'Interprétation moderne de la nuit en ville, où les lumières artificielles créent une constellation terrestre fascinante.', 'nuit_urbaine.jpg', 'Acrylique sur toile', 2025, 100.00, 150.00, NULL, 1002, 2, NULL, '2025-12-20 11:00:00', 1, 2, 1, 2),
('L\'Ombre du Doute', 'Sculpture représentant une silhouette humaine fragmentée, symbolisant l\'incertitude et les questionnements intérieurs.', 'ombre_doute.jpg', 'Bronze patiné', 2023, 180.00, 60.00, 60.00, 1003, 3, NULL, '2025-12-21 09:00:00', 1, 3, 2, 2),
('Entre Chien et Loup', 'Photographie capturant ce moment suspendu entre jour et nuit, où la lumière hésite et crée une ambiance mystérieuse.', 'chien_loup.jpg', 'Photographie numérique', 2024, 90.00, 120.00, NULL, 1004, 4, NULL, '2025-12-21 10:00:00', 1, 4, 3, 2);

-- Œuvres expo 2 "Métamorphoses Urbaines"
INSERT INTO Oeuvre (titre, description, image, technique, anneeCreation, hauteurCm, largeurCm, profondeurCm, numeroIdentification, ordreVisite, urlQrCode, dateAjout, idExposition, idEmplacement, idArtiste, idEmploye) VALUES
('Usine Désaffectée #7', 'Une friche industrielle baignée de lumière naturelle, témoignage silencieux d\'un passé révolu. La nature reprend doucement ses droits.', 'usine_07.jpg', 'Photographie argentique', 2018, 70.00, 100.00, NULL, 2001, 1, NULL, '2026-01-05 11:00:00', 2, 5, 3, 2),
('Tour en Construction', 'Le squelette d\'acier d\'une future tour se dresse vers le ciel. L\'image capture l\'ambition humaine de toujours construire plus haut.', 'tour_construction.jpg', 'Photographie numérique', 2022, 150.00, 100.00, NULL, 2002, 2, NULL, '2026-01-05 11:30:00', 2, 6, 3, 2),
('Panorama Métropolitain', 'Vue panoramique nocturne de la ville en mutation. Des milliers de lumières témoignent de l\'activité humaine incessante.', 'panorama_metro.jpg', 'Photographie grand format', 2023, 100.00, 300.00, NULL, 2003, 3, NULL, '2026-01-05 14:00:00', 2, 7, 3, 2),
('Triptyque Urbain', 'Trois moments d\'une même rue : aube, midi, crépuscule. La lumière transforme complètement l\'espace urbain au fil du jour.', 'triptyque_urbain.jpg', 'Série photographique', 2024, 80.00, 240.00, NULL, 2004, 4, NULL, '2026-01-05 15:00:00', 2, 8, 3, 2);

-- ============================================================================
-- 8. TRADUCTIONS ŒUVRES (dépend de OEUVRE, LANGUE, EMPLOYE)
-- ============================================================================

-- Traductions pour "Aube Dorée" (idOeuvre = 1)
INSERT INTO TraductionOeuvre (idOeuvre, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(1, 2, 'An explosion of morning light captured through warm color blocks. The artist plays with contrasts to evoke the hope of a new day.', 'audio/aube_doree_en.mp3', '2025-12-22 10:00:00', 4),
(1, 3, 'Eine Explosion von Morgenlicht, eingefangen durch warme Farbflächen. Der Künstler spielt mit Kontrasten, um die Hoffnung eines neuen Tages hervorzurufen.', 'audio/aube_doree_de.mp3', '2025-12-22 10:15:00', 4);

-- Traductions pour "Nuit Étoilée Urbaine" (idOeuvre = 2)
INSERT INTO TraductionOeuvre (idOeuvre, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(2, 2, 'A modern interpretation of the city at night, where artificial lights create a fascinating terrestrial constellation.', 'audio/nuit_urbaine_en.mp3', '2025-12-22 11:00:00', 4),
(2, 3, 'Eine moderne Interpretation der Nacht in der Stadt, wo künstliche Lichter eine faszinierende irdische Konstellation schaffen.', 'audio/nuit_urbaine_de.mp3', '2025-12-22 11:15:00', 4);

-- Traductions pour "Usine Désaffectée #7" (idOeuvre = 5)
INSERT INTO TraductionOeuvre (idOeuvre, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(5, 2, 'An abandoned industrial site bathed in natural light, silent witness to a bygone past. Nature slowly reclaims its rights.', 'audio/usine_07_en.mp3', '2026-01-06 10:00:00', 4),
(5, 3, 'Eine verlassene Industrieanlage in natürlichem Licht, stiller Zeuge einer vergangenen Zeit. Die Natur erobert langsam ihre Rechte zurück.', 'audio/usine_07_de.mp3', '2026-01-06 10:15:00', 4);

-- ============================================================================
-- 9. TRADUCTIONS ARTISTES (dépend de ARTISTE, LANGUE, EMPLOYE)
-- ============================================================================

-- Traductions pour Jean DUPONT (idArtiste = 1)
INSERT INTO TraductionArtiste (idArtiste, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(1, 2, 'Contemporary painter renowned for his abstract works using vibrant colors and geometric shapes. His work explores human emotions through color.', 'audio/dupont_bio_en.mp3', '2025-12-22 14:00:00', 4),
(1, 3, 'Zeitgenössischer Maler, bekannt für seine abstrakten Werke mit lebendigen Farben und geometrischen Formen. Seine Arbeiten erforschen menschliche Emotionen durch Farbe.', 'audio/dupont_bio_de.mp3', '2025-12-22 14:15:00', 4);

-- Traductions pour Paul BERNARD (idArtiste = 3)
INSERT INTO TraductionArtiste (idArtiste, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(3, 2, 'Award-winning documentary photographer, known for his series on transforming urban landscapes. His shots capture the poetry of abandoned places.', 'audio/bernard_bio_en.mp3', '2025-12-23 10:00:00', 4),
(3, 3, 'Preisgekrönter Dokumentarfotograf, bekannt für seine Serien über sich wandelnde Stadtlandschaften. Seine Aufnahmen fangen die Poesie verlassener Orte ein.', 'audio/bernard_bio_de.mp3', '2025-12-23 10:15:00', 4);

-- ============================================================================
-- 10. TRADUCTIONS EXPOSITIONS (dépend de EXPOSITION, LANGUE, EMPLOYE)
-- ============================================================================

-- Traductions pour "Lumières et Ombres" (idExposition = 1)
INSERT INTO TraductionExpo (idExposition, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(1, 2, 'A fascinating exploration of the contrast between light and darkness through the works of four contemporary artists. This exhibition invites visitors to reflect on the dualities of human existence.', 'audio/expo_lumieres_en.mp3', '2025-12-23 11:00:00', 4),
(1, 3, 'Eine faszinierende Erkundung des Kontrasts zwischen Licht und Dunkelheit durch die Werke von vier zeitgenössischen Künstlern. Diese Ausstellung lädt Besucher ein, über die Dualitäten der menschlichen Existenz nachzudenken.', 'audio/expo_lumieres_de.mp3', '2025-12-23 11:15:00', 4);

-- Traductions pour "Métamorphoses Urbaines" (idExposition = 2)
INSERT INTO TraductionExpo (idExposition, idLangue, traductionTexte, urlAcces, dateAjout, idEmploye) VALUES
(2, 2, 'Paul Bernard presents a 20-year retrospective of urban photography. From industrial wastelands to skyscrapers under construction, discover the city as you have never seen it.', 'audio/expo_urbain_en.mp3', '2025-12-24 10:00:00', 4),
(2, 3, 'Paul Bernard präsentiert eine 20-jährige Retrospektive der urbanen Fotografie. Von Industriebrachen bis zu Wolkenkratzern im Bau, entdecken Sie die Stadt, wie Sie sie noch nie gesehen haben.', 'audio/expo_urbain_de.mp3', '2025-12-24 10:15:00', 4);

-- ============================================================================
-- 11. CONTENUS ENRICHIS (dépend de OEUVRE, EMPLOYE)
-- ============================================================================

-- Contenus pour "Aube Dorée" (idOeuvre = 1)
INSERT INTO ContenuEnrichi (description, urlAcces, ordreAffichage, dateAjout, idOeuvre, idEmploye) VALUES
('Interview de l\'artiste sur le processus créatif de cette œuvre', 'video/aube_doree_interview.mp4', 1, '2025-12-25 10:00:00', 1, 2),
('Vue détaillée des techniques de peinture utilisées', 'video/aube_doree_technique.mp4', 2, '2025-12-25 10:30:00', 1, 2);

-- Contenus pour "Usine Désaffectée #7" (idOeuvre = 5)
INSERT INTO ContenuEnrichi (description, urlAcces, ordreAffichage, dateAjout, idOeuvre, idEmploye) VALUES
('Reportage sur le lieu avant sa fermeture', 'video/usine_07_reportage.mp4', 1, '2026-01-07 11:00:00', 5, 2),
('Galerie de clichés du même lieu à différentes époques', 'galerie/usine_07_evolution/', 2, '2026-01-07 11:30:00', 5, 2);

-- ============================================================================
-- 12. TRADUCTIONS CONTENUS ENRICHIS (dépend de CONTENU_ENRICHI, LANGUE, EMPLOYE)
-- ============================================================================

-- Traductions pour contenu 1 (Interview Aube Dorée)
INSERT INTO TraductionContenuEnrichi (idContenuEnrichi, idLangue, traductionTexte, urlAcces, ordreAffichage, dateAjout, idEmploye) VALUES
(1, 2, 'Artist interview about the creative process of this work', 'video/aube_doree_interview_en.mp4', 1, '2025-12-26 10:00:00', 4),
(1, 3, 'Künstlerinterview über den kreativen Prozess dieses Werks', 'video/aube_doree_interview_de.mp4', 1, '2025-12-26 10:15:00', 4);

-- Traductions pour contenu 3 (Reportage Usine)
INSERT INTO TraductionContenuEnrichi (idContenuEnrichi, idLangue, traductionTexte, urlAcces, ordreAffichage, dateAjout, idEmploye) VALUES
(3, 2, 'Documentary about the place before its closure', 'video/usine_07_reportage_en.mp4', 1, '2026-01-08 10:00:00', 4),
(3, 3, 'Dokumentation über den Ort vor seiner Schließung', 'video/usine_07_reportage_de.mp4', 1, '2026-01-08 10:15:00', 4);

-- ============================================================================
-- 13. CONSULTATIONS (dépend de OEUVRE)
-- ============================================================================

-- Consultations pour diverses œuvres
INSERT INTO Consultation (dateConsultation, idOeuvre) VALUES
('2026-02-05 14:30:00', 1),  -- Aube Dorée
('2026-02-05 14:45:00', 2),  -- Nuit Étoilée Urbaine
('2026-02-05 15:00:00', 1),  -- Aube Dorée (2e consultation)
('2026-02-05 15:15:00', 3),  -- L'Ombre du Doute
('2026-02-06 10:20:00', 1),  -- Aube Dorée (3e consultation)
('2026-02-06 10:35:00', 4),  -- Entre Chien et Loup
('2026-04-20 16:10:00', 5),  -- Usine Désaffectée #7
('2026-04-20 16:25:00', 6);  -- Tour en Construction

-- ============================================================================
-- VÉRIFICATIONS
-- ============================================================================

-- Afficher le résumé des données insérées
SELECT 'Employés' AS Table_Name, COUNT(*) AS Nb_Enregistrements FROM Employe
UNION ALL
SELECT 'Artistes', COUNT(*) FROM Artiste
UNION ALL
SELECT 'Expositions', COUNT(*) FROM Exposition
UNION ALL
SELECT 'Espaces', COUNT(*) FROM Espace
UNION ALL
SELECT 'Étapes', COUNT(*) FROM Etape
UNION ALL
SELECT 'Emplacements', COUNT(*) FROM Emplacement
UNION ALL
SELECT 'Œuvres', COUNT(*) FROM Oeuvre
UNION ALL
SELECT 'Traductions Œuvres', COUNT(*) FROM TraductionOeuvre
UNION ALL
SELECT 'Traductions Artistes', COUNT(*) FROM TraductionArtiste
UNION ALL
SELECT 'Traductions Expos', COUNT(*) FROM TraductionExpo
UNION ALL
SELECT 'Contenus Enrichis', COUNT(*) FROM ContenuEnrichi
UNION ALL
SELECT 'Trad. Contenus Enrichis', COUNT(*) FROM TraductionContenuEnrichi
UNION ALL
SELECT 'Consultations', COUNT(*) FROM Consultation;

-- ============================================================================
-- FIN DU SCRIPT
-- ============================================================================

-- ✅ Données insérées avec succès !
-- 
-- Pour se connecter en tant qu'admin :
-- Login : mfioret
-- Mot de passe : password
-- 
-- Autres employés :
-- Login : slecourt / Mot de passe : password
-- Login : pdubrac / Mot de passe : password
-- Login : jmartin / Mot de passe : password
