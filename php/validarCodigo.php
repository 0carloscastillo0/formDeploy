<?php
header("Content-Type: application/json; charset=UTF-8");
require_once 'conexion.php';

if (isset($_GET['codigo'])) {
    $codigo = trim($_GET['codigo']);

    try {
        $stmt = $pdo->prepare("SELECT COUNT(*) as total FROM producto WHERE codigo = ?");
        $stmt->execute([$codigo]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        
        echo json_encode(["existe" => $row['total'] > 0]);
    } catch (PDOException $e) {
        echo json_encode(["error" => "Error al validar código: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["error" => "No se recibió el código."]);
}
?>
