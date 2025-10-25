<?php
header("Content-Type: application/json; charset=UTF-8");
require_once 'conexion.php';

try {
    $stmt = $pdo->query("SELECT id, nombre FROM bodega ORDER BY nombre");
    $bodegas = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($bodegas);
} catch (PDOException $e) {
    echo json_encode(["error" => "Error al obtener bodegas: " . $e->getMessage()]);
}
?>
