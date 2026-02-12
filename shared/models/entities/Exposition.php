<?php

namespace shared\models\entities;

class Exposition {

    private $idExposition;
    private $titre;
    private $theme;
    private $dateDebut;
    private $dateFin;
    private $horaires;
    private $description;
    private $image;
    private $modulePublicActif;
    private $dateCreation;
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

    public function getIdExposition() {
        return $this->idExposition;
    }

    
    public function getTitre() {
        return $this->titre;
    }

    public function getTheme() {
        return $this->theme;
    }

    public function getDateDebut() {
        return $this->dateDebut;
    }

    public function getDateFin() {
        return $this->dateFin;
    }

    public function getHoraires() {
        return $this->horaires;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getImage() {
        return $this->image;
    }

    public function getModulePublicActif() {
        return $this->modulePublicActif;
    }

    public function getDateCreation() {
        return $this->dateCreation;
    }

    public function getIdEmploye() {
        return $this->idEmploye;
    }

    public function setTheme($theme): self {
        $this->theme = $theme;
        return $this;
    }

    public function setIdExposition($idExposition): self {
        $this->idExposition = $idExposition;
        return $this;
    }

    public function setTitre($titre): self {
        $this->titre = $titre;
        return $this;
    }

    public function setDateDebut($dateDebut): self {
        $this->dateDebut = $dateDebut;
        return $this;
    }

    public function setDateFin($dateFin): self {
        $this->dateFin = $dateFin;
        return $this;
    }

    public function setHoraires($horaires): self {
        $this->horaires = $horaires;
        return $this;
    }

    public function setDescription($description): self {
        $this->description = $description;
        return $this;
    }

    public function setImage($image): self {
        $this->image = $image;
        return $this;
    }

    public function setModulePublicActif($modulePublicActif): self {
        $this->modulePublicActif = $modulePublicActif;
        return $this;
    }

    public function setDateCreation($dateCreation): self {
        $this->dateCreation = $dateCreation;
        return $this;
    }

    public function setIdEmploye($idEmploye): self {
        $this->idEmploye = $idEmploye;
        return $this;
    }
}
?>