<?php
namespace shared\core;

use PDO;
use PDOException;
require_once __DIR__."/../config/config.php";

/**
 * Classe Database (Singleton)
 */
class Database {
    
    private static $instance = null;
    private $pdo;
    
    private function __construct() {
        try {
            $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;
            
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false
            ];
            
            $this->pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
            
        } catch (PDOException $e) {
            if (defined('DEBUG_MODE') && DEBUG_MODE === true) {
                die("❌ Erreur de connexion BDD : " . $e->getMessage());
            } else {
                die("Erreur de connexion à la base de données.");
            }
        }
    }
    
    private function __clone() {}
    
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    public function getConnection() {
        return $this->pdo;
    }
}
?>