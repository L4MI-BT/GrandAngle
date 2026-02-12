<?php

namespace shared\models\entities;

class Artiste {

    private $idArtiste;
    private $nom;
    private $prenom;
    private $anneeNaissance;
    private $description;
    private $image;
    private $dateAjout;
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

    public function getIdArtiste() {
        return $this->idArtiste;
    }

    public function getNom() {
        return $this->nom;
    }

    public function getPrenom() {
        return $this->prenom;
    }

    public function getAnneeNaissance() {
        return $this->anneeNaissance;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getImage() {
        return $this->image;
    }

    public function getDateAjout() {
        return $this->dateAjout;
    }

    public function getIdEmploye() {
        return $this->idEmploye;
    }

    public function setIdArtiste($idArtiste) {
        $this->idArtiste = $idArtiste;
    }

    public function setNom($nom) {
        $this->nom = $nom;
    }

    public function setPrenom($prenom) {
        $this->prenom = $prenom;
    }

    public function setAnneeNaissance($anneeNaissance) {
        $this->anneeNaissance = $anneeNaissance;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function setImage($image) {
        $this->image = $image;
    }

    public function setDateAjout($dateAjout) {
        $this->dateAjout = $dateAjout;
    }

    public function setIdEmploye($idEmploye) {
        $this->idEmploye = $idEmploye;
    }
}
?>