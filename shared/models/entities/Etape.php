<?php
namespace shared\models\entities;

class Etape {

    private $idEtape;
    private $libelle;
    private $ordre;
    private $idExposition;

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

    public function getIdEtape() {
        return $this->idEtape;
    }

    public function getLibelle() {
        return $this->libelle;
    }

    public function getOrdre() {
        return $this->ordre;
    }

    public function getIdExposition() {
        return $this->idExposition;
    }

    public function setIdEtape($idEtape): self {
        $this->idEtape = $idEtape;
        return $this;
    }

    public function setLibelle($libelle): self {
        $this->libelle = $libelle;
        return $this;
    }

    public function setOrdre($ordre): self {
        $this->ordre = $ordre;
        return $this;
    }

    public function setIdExposition($idExposition): self {
        $this->idExposition = $idExposition;
        return $this;
    }
}

?>