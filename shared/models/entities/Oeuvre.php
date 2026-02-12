<?php
namespace shared\models\entities;

class Oeuvre {

    private $idOeuvre;
    private $titre;
    private $description;
    private $image;
    private $technique;
    private $anneeCreation;
    private $hauteurCm;
    private $largeurCm;
    private $profondeurCm;
    private $dateLivraisonPrevue;
    private $dateLivraisonReelle;
    private $numeroIdentification;
    private $ordreVisite;
    private $urlQrCode;
    private $dateAjout;
    private $idExposition;
    private $idEmplacement;
    private $idArtiste;
    private $idEmploye;

    public function __construct($valeur = [])
    {
        if(!empty($valeur)) {
            $this->hydrate($valeur);
        }
    }

    public function hydrate($donnees) {
        foreach($donnees as $key => $value) {
            $method = 'set' . ucfirst($key);
            if(method_exists($this, $method)) {
                $this->$method($value);
            }else{
                echo $method." introuvable";
            }
        }
    }

    public function getIdOeuvre() {
        return $this->idOeuvre;
    }

    public function getTitre() {
        return $this->titre;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getImage() {
        return $this->image;
    }

    public function getTechnique() {
        return $this->technique;
    }

    public function getAnneeCreation() {
        return $this->anneeCreation;
    }

    public function getHauteurCm() {
        return $this->hauteurCm;
    }

    public function getLargeurCm() {
        return $this->largeurCm;
    }

    public function getProfondeurCm() {
        return $this->profondeurCm;
    }

    public function getDateLivraisonPrevue() {
        return $this->dateLivraisonPrevue;
    }

    public function getDateLivraisonReelle() {
        return $this->dateLivraisonReelle;
    }

    public function getNumeroIdentification() {
        return $this->numeroIdentification;
    }

    public function getOrdreVisite() {
        return $this->ordreVisite;
    }

    public function getUrlQrCode() {
        return $this->urlQrCode;
    }

    public function getDateAjout() {
        return $this->dateAjout;
    }

    public function getIdExposition() {
        return $this->idExposition;
    }

    public function getIdEmplacement() {
        return $this->idEmplacement;
    }

    public function getIdArtiste() {
        return $this->idArtiste;
    }

    public function getIdEmploye() {
        return $this->idEmploye;
    }

    public function setIdOeuvre($idOeuvre) {
        $this->idOeuvre = $idOeuvre;
    }

    public function setTitre($titre) {
        $this->titre = $titre;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function setImage($image) {
        $this->image = $image;
    }

    public function setTechnique($technique) {
        $this->technique = $technique;
    }

    public function setAnneeCreation($anneeCreation) {
        $this->anneeCreation = $anneeCreation;
    }

    public function setHauteurCm($hauteurCm) {
        $this->hauteurCm = $hauteurCm;
    }

    public function setLargeurCm($largeurCm) {
        $this->largeurCm = $largeurCm;
    }

    public function setProfondeurCm($profondeurCm) {
        $this->profondeurCm = $profondeurCm;
    }

    public function setDateLivraisonPrevue($dateLivraisonPrevue) {
        $this->dateLivraisonPrevue = $dateLivraisonPrevue;
    }

    public function setDateLivraisonReelle($dateLivraisonReelle) {
        $this->dateLivraisonReelle = $dateLivraisonReelle;
    }

    public function setNumeroIdentification($numeroIdentification) {
        $this->numeroIdentification = $numeroIdentification;
    }

    public function setOrdreVisite($ordreVisite) {
        $this->ordreVisite = $ordreVisite;
    }

    public function setUrlQrCode($urlQrCode) {
        $this->urlQrCode = $urlQrCode;
    }

    public function setDateAjout($dateAjout) {
        $this->dateAjout = $dateAjout;
    }

    public function setIdExposition($idExposition) {
        $this->idExposition = $idExposition;
    }

    public function setIdEmplacement($idEmplacement) {
        $this->idEmplacement = $idEmplacement;
    }

    public function setIdArtiste($idArtiste) {
        $this->idArtiste = $idArtiste;
    }

    public function setIdEmploye($idEmploye) {
        $this->idEmploye = $idEmploye;
    }
}
?>