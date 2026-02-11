<?php
require_once "connexionBdd.php";

if(isset($_GET['controller']) && $_GET['method']){
    $controller = $_GET['controller'];
    $method = $_GET['method'];
}else{
    $controller = 'global';
    $method = 'index';
}

require_once "views/layout.php";
