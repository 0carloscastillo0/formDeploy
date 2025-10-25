<?php
header("Content-Type: application/json; charset=UTF-8");
require_once 'conexion.php';

if(isset($_GET['bodega_id'])) {
    $bodega_id = intval($_GET['bodega_id']);

    try {
        $stmt = $pdo->prepare("SELECT id, nombre FROM sucursal WHERE bodega_id = ? ORDER BY nombre");
        $stmt->execute([$bodega_id]);
        $sucursales = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo json_encode($sucursales);
    } catch (PDOException $e) {
        echo json_encode(["error" => "Error al obtener sucursales: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["error" => "No se recibió la bodega"]);
}
?>
