<?php
namespace shared\models\entities;

class Consultation {

    private $idConsultation;
    private $dateConsultation;
    private $idOeuvre;


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

    public function getIdConsultation() {
        return $this->idConsultation;
    }

    public function getDateConsultation() {
        return $this->dateConsultation;
    }

    public function getIdOeuvre() {
        return $this->idOeuvre;
    }

    public function setIdConsultation($idConsultation) {
        $this->idConsultation = $idConsultation;
    }

    public function setIdOeuvre($idOeuvre) {
        $this->idOeuvre = $idOeuvre;
    }
}

?>