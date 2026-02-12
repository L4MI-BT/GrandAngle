<?php
namespace shared\models\entities;

class Configuration {

    private $idConfiguration;
    private $cle;
    private $valeur;
    private $description;


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

    public function getIdConfiguration() {
        return $this->idConfiguration;
    }

    public function getCle() {
        return $this->cle;
    }

    public function getValeur() {
        return $this->valeur;
    }

    public function getDescription() {
        return $this->description;
    }

    public function setIdConfiguration($idConfiguration) {
        $this->idConfiguration = $idConfiguration;
    }

    public function setCle($cle) {
        $this->cle = $cle;
    }

    public function setValeur($valeur) {
        $this->valeur = $valeur;
    }

    public function setDescription($description) {
        $this->description = $description;
    }
}

?>