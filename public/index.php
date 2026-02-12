<?php
require_once __DIR__ . '/../shared/autoload.php';

require_once __DIR__."/../shared/core/Database.php";

if(isset($_GET['controller']) && $_GET['method']){
    $controller = $_GET['controller'];
    $method = $_GET['method'];
}else{
    $controller = 'global';
    $method = 'index';
}

require_once "php/views/layout.php";
