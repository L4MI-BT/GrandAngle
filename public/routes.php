<?php


function call($controller, $method){
    require_once "php/controllers/".$controller."_controller.php";

    switch($controller){
        case 'global':
            $controller = new GlobalController();
        break;
    }
    
    $controller->{ $method }();
}

$controllerClassName = ucfirst($controller) . 'Controller';


require_once "php/controllers/".$controller."_controller.php";

if(method_exists($controllerClassName, $method)){
    call($controller, $method);
} else {
    call('global', 'error');
}
