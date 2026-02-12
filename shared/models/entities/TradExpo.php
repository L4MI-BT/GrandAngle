<?php

namespace shared\models\entities;

class TradExpo extends AbstractTrad {
    private $idExposition;
    
    public function getEntityId() {
        return $this->idExposition;
    }
    
    public function setEntityId($id) {
        $this->idExposition = $id;
    }
    
    public function getIdExposition() {
        return $this->idExposition;
    }
    
    public function setIdExposition($idExposition) {
        $this->idExposition = $idExposition;
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