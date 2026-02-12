<?php

namespace shared\models\entities;

class Employe {

    private $idEmploye;
    private $nom;
    private $prenom;
    private $email;
    private $role;
    private $login;
    private $mdp;
    private $actif;
    private $supprime;
    private $dateCreation;
    private $dateSuppression;
    private $idFonction;
    


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

    public function getIdEmploye() {
        return $this->idEmploye;
    }

    public function getNom() {
        return $this->nom;
    }

    public function getPrenom() {
        return $this->prenom;
    }

    public function getEmail() {
        return $this->email;
    }

    public function getRole() {
        return $this->role;
    }

    public function getLogin() {
        return $this->login;
    }

    public function getMdp() {
        return $this->mdp;
    }

    public function getActif() {
        return $this->actif;
    }

    public function getSupprime() {
        return $this->supprime;
    }

    public function getDateCreation() {
        return $this->dateCreation;
    }

    public function getDateSuppression() {
        return $this->dateSuppression;
    }

    public function getIdFonction() {
        return $this->idFonction;
    }

    public function setIdEmploye($idEmploye) {
        $this->idEmploye = $idEmploye;
    }

    public function setNom($nom) {
        $this->nom = $nom;
    }

    public function setPrenom($prenom) {
        $this->prenom = $prenom;
    }

    public function setEmail($email) {
        $this->email = $email;
    }

    public function setRole($role) {
        $this->role = $role;
    }

    public function setLogin($login) {
        $this->login = $login;
    }

    public function setMdp($mdp) {
        $this->mdp = $mdp;
    }

    public function setActif($actif) {
        $this->actif = $actif;
    }

    public function setSupprime($supprime) {
        $this->supprime = $supprime;
    }

    public function setDateCreation($dateCreation) {
        $this->dateCreation = $dateCreation;
    }

    public function setDateSuppression($dateSuppression) {
        $this->dateSuppression = $dateSuppression;
    }

    public function setIdFonction($idFonction) {
        $this->idFonction = $idFonction;
    }
}
?>