<?php

namespace shared\models\entities;

class TradArtistes extends AbstractTrad {
    private $idArtiste;
    
    public function getEntityId() {
        return $this->idArtiste;
    }
    
    public function setEntityId($id) {
        $this->idArtiste = $id;
    }
    
    public function getIdArtiste() {
        return $this->idArtiste;
    }
    
    public function setIdArtiste($idArtiste) {
        $this->idArtiste = $idArtiste;
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