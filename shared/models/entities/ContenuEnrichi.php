<?php
namespace shared\models\entities;

class ContenuEnrichi {

    private $idContenuEnrichi;
    private $description;
    private $urlAcces;
    private $ordreAffichage;
    private $dateAjout;
    private $idOeuvre;
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

    public function getIdContenuEnrichi() {
        return $this->idContenuEnrichi;
    }

    public function getDescription() {
        return $this->description;
    }

    public function getUrlAcces() {
        return $this->urlAcces;
    }

    public function getOrdreAffichage() {
        return $this->ordreAffichage;
    }

    public function getDateAjout() {
        return $this->dateAjout;
    }

    public function getIdOeuvre() {
        return $this->idOeuvre;
    }

    public function getIdEmploye() {
        return $this->idEmploye;
    }

    public function setIdContenuEnrichi($idContenuEnrichi) {
        $this->idContenuEnrichi = $idContenuEnrichi;
    }

    public function setDescription($description) {
        $this->description = $description;
    }

    public function setUrlAcces($urlAcces) {
        $this->urlAcces = $urlAcces;
    }

    public function setOrdreAffichage($ordreAffichage) {
        $this->ordreAffichage = $ordreAffichage;
    }

    public function setDateAjout($dateAjout) {
        $this->dateAjout = $dateAjout;
    }

    public function setIdOeuvre($idOeuvre) {
        $this->idOeuvre = $idOeuvre;
    }

    public function setIdEmploye($idEmploye) {
        $this->idEmploye = $idEmploye;
    }
}
?>