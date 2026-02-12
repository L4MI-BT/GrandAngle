<?php

namespace shared\models\managers;

use shared\models\entities\TradContenuEnrichie;

class TradContenuEnrichiManager extends AbstractTradManager {
    protected $table = 'traductioncontenuenrichi';
    protected $entityClass = TradContenuEnrichie::class;
    
    protected function getEntityColumnName(): string {
        return 'idContenuEnrichi';
    }

    protected function getPrimaryKeyName(): string {
        return 'idTraductionContenu';
    }
}