<?php

namespace shared\models\entities; 

abstract class AbstractTrad {
    protected  $id;
    protected  $idLangue;
    protected  $idEmploye;
    protected  $traductionTexte = null;
    protected  $urlAcces = null;
    protected  $dateAjout; // TIMESTAMP stocké comme string
    
    // Méthode abstraite pour l'ID de l'entité traduite
    abstract public function getEntityId();
    abstract public function setEntityId($id);
    

    public function __construct($valeur = [])
    {
        if(!empty($valeur)){
            $this->hydrate($valeur);
        }        
    }
    
    public function hydrate($donnee) {
        foreach ($donnee as $key => $value){
            $method = 'set'.ucfirst($key);
            if(method_exists($this, $method)){
                $this->$method($value);
            }else{
                echo $method.' introuvable';
            }
        }
    }
    // Getters/Setters communs
    public function getId() {
        return $this->id;
    }
    
    public function setId( $id) {
        $this->id = $id;
    }
    
    public function getIdLangue() {
        return $this->idLangue;
    }
    
    public function setIdLangue($idLangue) {
        $this->idLangue = $idLangue;
    }
    
    public function getIdEmploye() {
        return $this->idEmploye;
    }
    
    public function setIdEmploye( $idEmploye) {
        $this->idEmploye = $idEmploye;
    }
    
    public function getDateAjout() {
        return $this->dateAjout;
    }
    
    public function setDateAjout( $dateAjout) {
        $this->dateAjout = $dateAjout;
    }
}