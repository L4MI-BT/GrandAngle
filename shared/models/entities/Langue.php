<?php

namespace shared\models\entities;

class Langue {

    private $idLangue;
    private $code;
    private $nom;
    private $img;


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

    public function getIdLangue() {
        return $this->idLangue;
    }

    public function setIdLangue($idLangue): self {
        $this->idLangue = $idLangue;
        return $this;
    }


    public function getCode() {
        return $this->code;
    }

    public function setCode($code): self {
        $this->code = $code;
        return $this;
    }


    public function getNom() {
        return $this->nom;
    }

    public function setNom($nom): self {
        $this->nom = $nom;
        return $this;
    }


    public function getImg() {
        return $this->img;
    }

    public function setImg($img): self {
        $this->img = $img;
        return $this;
    }
}