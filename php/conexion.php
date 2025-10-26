<?php
$host = getenv('DB_HOST') ?: 'db';
$port = getenv('DB_PORT') ?: 5432;
$dbname = getenv('DB_DATABASE');
$user = getenv('DB_USER');
$password = getenv('DB_PASSWORD');

try {
    $dsn = "pgsql:host=$host;port=$port;dbname=$dbname";
    $pdo = new PDO($dsn, $user, $password, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
} catch (PDOException $e) {
    throw new PDOException("Error de conexión: " . $e->getMessage());
}
?>