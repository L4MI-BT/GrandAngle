<?php

namespace shared\models\entities;

class TradOeuvre extends AbstractTrad {
    private $idOeuvre;
    
    public function getEntityId() {
        return $this->idOeuvre;
    }
    
    public function setEntityId($id) {
        $this->idOeuvre = $id;
    }
    
    public function getIdOeuvre() {
        return $this->idOeuvre;
    }
    
    public function setIdOeuvre($idOeuvre) {
        $this->idOeuvre = $idOeuvre;
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