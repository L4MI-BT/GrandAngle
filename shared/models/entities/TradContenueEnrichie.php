<?php

namespace shared\models\entities;

class TradContenuEnrichie extends AbstractTrad {
    private $idContenuEnrichi;
    private $ordreAffichage = 1;
    
    public function getEntityId() {
        return $this->idContenuEnrichi;
    }
    
    public function setEntityId($id) {
        $this->idContenuEnrichi = $id;
    }
    
    public function getIdContenuEnrichi() {
        return $this->idContenuEnrichi;
    }
    
    public function setIdContenuEnrichi($idContenuEnrichi) {
        $this->idContenuEnrichi = $idContenuEnrichi;
    }
    
    public function getOrdreAffichage() {
        return $this->ordreAffichage;
    }
    
    public function setOrdreAffichage($ordreAffichage) {
        $this->ordreAffichage = $ordreAffichage;
    }
    
    public function getTraductionTexte() {
        return $this->traductionTexte;
    }
    
    public function setTraductionTexte($traductionTexte) {
        $this->traductionTexte = $traductionTexte;
    }
    
    public function getUrlAcces() {
        return $this->urlAcces;
    }
    
    public function setUrlAcces($urlAcces) {
        $this->urlAcces = $urlAcces;
    }
}