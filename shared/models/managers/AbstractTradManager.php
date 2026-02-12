<?php 

namespace shared\models\managers;

use shared\core\ModelManager;
use PDO;

abstract class AbstractTradManager extends ModelManager {

    abstract protected function getEntityColumnName(): string;
    abstract protected function getPrimaryKeyName(): string;

    /**
     * Récupérer toutes les traductions d'une entité
     */
    public function getByEntityId(int $entityId): array {
        $query = $this->db->prepare("SELECT * FROM {$this->table} WHERE {$this->getEntityColumnName()} = :entityId");
        $query->bindValue(':entityId', $entityId, PDO::PARAM_INT);
        $query->execute();
        
        $entities = [];
        foreach ($query->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $entities[] = new $this->entityClass($row);
        }
        
        return $entities;
    }

    /**
     * Récupérer une traduction pour une entité et une langue spécifiques
     */
    public function getByEntityAndLangue(int $entityId, int $langueId): ?object {
        $sql = "SELECT * FROM {$this->table} 
                WHERE {$this->getEntityColumnName()} = :entityId 
                AND idLangue = :langueId";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            'entityId' => $entityId,
            'langueId' => $langueId
        ]);
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ? new $this->entityClass($row) : null;
    }

    /**
     * Récupérer une traduction par code langue (ex: 'FR', 'EN')
     */
    public function getByEntityAndLangueCode(int $entityId, string $langueCode): ?object {
        $sql = "SELECT t.* FROM {$this->table} t
                JOIN langue l ON t.idLangue = l.idLangue
                WHERE {$this->getEntityColumnName()} = :entityId 
                AND l.code = :langueCode";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            'entityId' => $entityId,
            'langueCode' => $langueCode
        ]);
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ? new $this->entityClass($row) : null;
    }

    /**
     * Vérifier si une traduction existe
     */
    public function exists(int $entityId, int $langueId): bool {
        return $this->getByEntityAndLangue($entityId, $langueId) !== null;
    }

    /**
     * Override getById pour utiliser la bonne clé primaire
     */
    public function getById($id): ?object {
        $sql = "SELECT * FROM {$this->table} WHERE {$this->getPrimaryKeyName()} = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->execute(['id' => $id]);
        
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ? new $this->entityClass($row) : null;
    }

    /**
     * Override delete pour utiliser la bonne clé primaire
     */
    public function delete($id): bool {
        $sql = "DELETE FROM {$this->table} WHERE {$this->getPrimaryKeyName()} = :id";
        $stmt = $this->db->prepare($sql);
        return $stmt->execute(['id' => $id]);
    }

    /**
     * Supprimer toutes les traductions d'une entité
     */
    public function deleteByEntityId(int $entityId): bool {
        $sql = "DELETE FROM {$this->table} WHERE {$this->getEntityColumnName()} = :entityId";
        $stmt = $this->db->prepare($sql);
        return $stmt->execute(['entityId' => $entityId]);
    }
}