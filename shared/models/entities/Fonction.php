<?php

namespace shared\models\entities;

class Fonction {

    private $idFonction;
    private $intitule;


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

    public function getIdFonction() {
        return $this->idFonction;
    }

    public function getIntitule() {
        return $this->intitule;
    }

    public function setIdFonction($idFonction): self {
        $this->idFonction = $idFonction;
        return $this;
    }

    public function setIntitule($intitule): self {
        $this->intitule = $intitule;
        return $this;
    }
}

?>