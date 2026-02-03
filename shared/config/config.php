<?php
define('ROOT', dirname(dirname(__DIR__)));
define('URL_ROOT_ADMIN', 'http://localhost/grandangle/admin');
define('URL_ROOT_PUBLIC', 'http://localhost/grandangle/public');
define('SITE_NAME', 'Centre d\'Art Grand Angle');
define('DEBUG_MODE', true);

if (DEBUG_MODE) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
}
?>