<?php
$host = getenv('DB_HOST') ?: 'db';
$port = getenv('DB_PORT') ?: 5432;
$db   = getenv('DB_DATABASE');
$user = getenv('DB_USER');
$pass = getenv('DB_PASSWORD');

try {
    $pdo = new PDO("pgsql:host=$host;port=$port;dbname=$db", $user, $pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    echo "✅ Conexión exitosa a la base de datos: $db<br>";

    $stmt = $pdo->query("SELECT COUNT(*) AS total FROM producto");
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo "Total de productos cargados: " . $row['total'] . "<br>";
} catch (PDOException $e) {
    echo "❌ Error de conexión: " . $e->getMessage() . "<br>";
}
?>
