<?php
header("Content-Type: application/json; charset=UTF-8");
require_once 'conexion.php';

try {
    $stmt = $pdo->query("SELECT id, nombre FROM moneda ORDER BY nombre");
    $monedas = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($monedas);
} catch (PDOException $e) {
    echo json_encode(["error" => "Error al obtener monedas: " . $e->getMessage()]);
}
?>
