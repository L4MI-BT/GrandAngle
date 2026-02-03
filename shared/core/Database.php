<?php

class Database {
    private static $instance = NULL;
    

    private function __construct() {}

    private function __clone() {}

    public static function getInstance() {
        if(!isset(self::$instance)) {
            try {
                $pdo_options = [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES => false
                ];
                self::$instance = new PDO('mysql:host=' .DB_HOST. ';dbname='.DB_NAME, DB_USER, DB_PASS, $pdo_options);
            }catch (PDOException $e) {
                if (DEBUG_MODE) {
                    die("Erreur de connexion: " .$e->getMessage());
                }else{
                    die("Erreur de connexion à la base de données. Contactez l'administrateur.");
                }
            }   
        }
        return self::$instance;
    }
}         
?>