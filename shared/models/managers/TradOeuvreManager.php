<?php

namespace shared\models\managers;

use shared\models\entities\TradOeuvre;

class TradOeuvreManager extends AbstractTradManager {
    protected $table = 'traductionoeuvre';
    protected $entityClass = TradOeuvre::class;
    
    protected function getEntityColumnName(): string {
        return 'idOeuvre';
    }

    protected function getPrimaryKeyName(): string {
        return 'idTraductionOeuvre';
    }
}