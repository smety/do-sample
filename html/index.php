<?php

require __DIR__ . '/../vendor/autoload.php';

use Nette\Neon\Neon;
use Nette\Utils\Json;
use Tracy\Debugger;

header('Content-type: application/json');
header('Access-Control-Allow-Credentials: true');


Debugger::enable(Debugger::PRODUCTION, __DIR__ . '/../log');
Debugger::$showBar = true;

try {
    try {
        $config = Neon::decodeFile(__DIR__ . '/../config/database.neon');
        $db = $config["database"];
        $database = new Nette\Database\Connection($db["dsn"], $db["user"], $db["password"]);
        echo Json::encode($database->query('SELECT * FROM `books`')->fetchAll(), 1);
    } catch (\Nette\Neon\Exception $e) {
        Debugger::log($e);
    }
} catch (\Nette\Utils\JsonException $e) {
    Debugger::log($e);
}

