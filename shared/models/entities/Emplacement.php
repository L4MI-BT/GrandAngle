<?php
namespace shared\models\entities;

class Emplacement {

    private $idEmplacement;
    private $positionX;
    private $positionY;
    private $description;
    private $idEspace;
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

    public function getIdEmplacement() {
        return $this->idEmplacement;
    }

    public function getPositionX() {
        return $this->positionX;
    }

    public function getPositionY() {
        return $this->positionY;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getIdEspace() {
        return $this->idEspace;
    }

    public function getIdExposition() {
        return $this->idExposition;
    }

    public function setIdEmplacement($idEmplacement) {
        $this->idEmplacement = $idEmplacement;
    }

    public function setPositionX($positionX) {
        $this->positionX = $positionX;
    }

    public function setPositionY($positionY) {
        $this->positionY = $positionY;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function setIdEspace($idEspace) {
        $this->idEspace = $idEspace;
    }

    public function setIdexposition($idExposition) {
        $this->idExposition = $idExposition;
    }
}

?>