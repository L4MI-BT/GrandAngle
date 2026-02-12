<?php
namespace shared\models\entities;

class Espace {

    private $idEspace;
    private $nomEspace;
    private $description;
    private $superficieM2;

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

    public function getIdEspace() {
        return $this->idEspace;
    }

    public function getNomEspace() {
        return $this->nomEspace;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getSuperficieM2() {
        return $this->superficieM2;
    }

    public function setIdEspace($idEspace) {
        $this->idEspace = $idEspace;
    }

    public function setNomEspace($nomEspace) {
        $this->nomEspace = $nomEspace;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function setSuperficieM2($superficieM2) {
        $this->superficieM2 = $superficieM2;
    }
}

?>