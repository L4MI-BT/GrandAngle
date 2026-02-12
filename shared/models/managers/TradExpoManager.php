<?php

namespace shared\models\managers;

use shared\models\entities\TradExpo;

class TradExpoManager extends AbstractTradManager {
    protected $table = 'traductionexpo';
    protected $entityClass = TradExpo::class;
    
    protected function getEntityColumnName(): string {
        return 'idExposition';
    }

    protected function getPrimaryKeyName(): string {
        return 'idTraductionExpo';
    }
}