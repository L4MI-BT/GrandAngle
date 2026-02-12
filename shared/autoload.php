<?php
spl_autoload_register(function ($class) {
    // Préfixe de namespace pour ce projet
    $prefix = 'shared';
    
    // Dossier de base (le dossier "shared")
    $baseDir = __DIR__ . '/';
    
    // Vérifier si la classe utilise notre namespace
    $len = strlen($prefix);
    if (strncmp($prefix, $class, $len) !== 0) {
        return; // Pas notre namespace, on laisse tomber
    }
    
    // Obtenir la partie après "Shared\"
    $relativeClass = substr($class, $len);
    
    // Convertir namespace en chemin de fichier
    // Models\Class\TradArtistes => Models/Class/TradArtistes.php
    $file = $baseDir . str_replace('\\', '/', $relativeClass) . '.php';
    
    // Charger le fichier
    if (file_exists($file)) {
        require $file;
    }
});