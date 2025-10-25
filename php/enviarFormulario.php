<?php
header("Content-Type: application/json; charset=UTF-8");
require_once 'conexion.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    // Obtener y sanitizar datos del formulario
    $codigo = trim($_POST['codigo']);
    $nombre = trim($_POST['nombre']);
    $bodega_id = (int)$_POST['bodega'];
    $sucursal_id = (int)$_POST['sucursal'];
    $moneda_id = (int)$_POST['moneda'];
    $precio = (float)$_POST['precio'];
    $material = trim($_POST['material']);
    $descripcion = trim($_POST['descripcion']);

    // Validar campos obligatorios
    if (
        !$codigo || !$nombre || !$bodega_id || !$sucursal_id ||
        !$moneda_id || !$precio || !$material || !$descripcion
    ) {
        echo json_encode(["error" => "Todos los campos obligatorios deben ser completados."]);
        exit();
    }

    // Insertar en la base de datos
    try {
        $pdo->beginTransaction();

        $stmt = $pdo->prepare("INSERT INTO producto 
            (codigo, nombre, bodega_id, sucursal_id, moneda_id, precio, material, descripcion)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );

        $stmt->execute([
            $codigo, $nombre, $bodega_id, $sucursal_id,
            $moneda_id, $precio, $material, $descripcion
        ]);

        $pdo->commit();

        echo json_encode(["success" => true, "message" => "Producto registrado exitosamente."]);

    } catch (PDOException $e) {
        $pdo->rollBack();
        echo json_encode(["error" => "Error al registrar el producto: " . $e->getMessage()]);
    }

} else {
    echo json_encode(["error" => "Acceso no permitido."]);
}
