<?php
// Edita aquí tus credenciales (a excepción de $dbname)
$host = "localhost";
$port = "5432";
$dbname = "productos_db";
$user = "postgres"; 
$password = "1234";

try {
    $dsn = "pgsql:host=$host;port=$port;dbname=$dbname";
    $pdo = new PDO($dsn, $user, $password, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
} catch (PDOException $e) {
    throw new PDOException("Error de conexión: " . $e->getMessage());
}
?>