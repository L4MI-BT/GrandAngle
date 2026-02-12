<?php

/**
 * Classe ModelManager
 * Parent de tous les managers
 */

namespace shared\core;  // ← AJOUTER le namespace

use PDO;  
class ModelManager {
    
    protected $db;           // Connexion à la BDD
    protected $table;        // Nom de la table
    protected $entityClass;  // Nom de la classe entity (ex: 'Artiste')
    
    public function __construct() {
        // Récupérer la connexion BDD
        $this->db = Database::getInstance()->getConnection();
    }
    
    /**
     * Récupérer tous les enregistrements
     * @return array Tableau d'objets
     */
    public function getAll() {
        $sql = "SELECT * FROM {$this->table}";
        $stmt = $this->db->query($sql);
        
        // Transformer chaque ligne en objet entity
        $entities = [];
        foreach ($stmt->fetchAll() as $row) {
            $entities[] = new $this->entityClass($row);
        }
        
        return $entities;
    }
    
    /**
     * Récupérer un enregistrement par ID
     * @return object|null
     */
    public function getById($id) {
        $sql = "SELECT * FROM {$this->table} WHERE id{$this->table} = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(['id' => $id]);
        
        $row = $stmt->fetch();
        
        // Retourner un objet ou null
        return $row ? new $this->entityClass($row) : null;
    }
    
    /**
     * Créer un enregistrement
     */
    public function create($data) {
        $columns = implode(', ', array_keys($data));
        $placeholders = ':' . implode(', :', array_keys($data));
        
        $sql = "INSERT INTO {$this->table} ({$columns}) VALUES ({$placeholders})";
        $stmt = $this->db->prepare($sql);
        return $stmt->execute($data);
    }
    
    /**
     * Modifier un enregistrement
     */
    public function update($id, $data) {
        $set = [];
        foreach ($data as $key => $value) {
            $set[] = "{$key} = :{$key}";
        }
        $setString = implode(', ', $set);
        
        $sql = "UPDATE {$this->table} SET {$setString} WHERE id{$this->table} = :id";
        $data['id'] = $id;
        $stmt = $this->db->prepare($sql);
        return $stmt->execute($data);
    }
    
    /**
     * Supprimer un enregistrement
     */
    public function delete($id) {
        $sql = "DELETE FROM {$this->table} WHERE id{$this->table} = :id";
        $stmt = $this->db->prepare($sql);
        return $stmt->execute(['id' => $id]);
    }
}
?>