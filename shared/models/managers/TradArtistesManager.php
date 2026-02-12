<?php

namespace Shared\Models\Managers;

use shared\models\entities\TradArtistes;

class TradArtistesManager extends AbstractTradManager {
    protected $table = 'traductionartiste';
    protected $entityClass = TradArtistes::class;
    
    protected function getEntityColumnName(): string {
        return 'idArtiste';
    }

    protected function getPrimaryKeyName(): string {
        return 'idTraductionArtiste';
    }

    /**
     * Méthode spécifique : Rechercher par nom d'artiste traduit
     */
    public function searchByNom(string $nom, int $langueId): array {
        $sql = "SELECT * FROM {$this->table} 
                WHERE traductionTexte LIKE :nom 
                AND idLangue = :langueId";
        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            'nom' => "%{$nom}%",
            'langueId' => $langueId
        ]);
        
        $entities = [];
        foreach ($stmt->fetchAll() as $row) {
            $entities[] = new $this->entityClass($row);
        }
        
        return $entities;
    }
}