import { validarCodigoDB } from './validarCodigo.js';

/*
Función para validar el formulario de producto
*/
export async function validaciones() {
    let d = document;

    // Obtener los valores de los campos
    let codigo = d.getElementById("codigo").value.trim();
    let nombre = d.getElementById("nombre").value.trim();
    let bodega = d.getElementById("bodega").value;
    let sucursal = d.getElementById("sucursal").value;
    let moneda = d.getElementById("moneda").value;
    let precio = d.getElementById("precio").value.trim();
    let material = d.querySelectorAll('input[name="material"]:checked');
    let descripcion = d.getElementById("descripcion").value.trim();

    // Validaciones del código
    if(!codigo) { alert("El código del producto no puede estar en blanco."); return false; }
    if (!/^[A-Z0-9]+$/i.test(codigo)) { alert("El código del producto debe contener letras y números."); return false; }
    if (codigo.length < 5 || codigo.length > 15) { alert("El código del producto debe tener entre 5 y 15 caracteres."); return false; }
    const codigoValido = await validarCodigoDB(codigo, "El código del producto ya está registrado");
    if (!codigoValido) return false;

    // Validaciones del nombre
    if (!nombre) { alert("El nombre del producto no puede estar en blanco."); return false; }
    if (nombre.length < 2 || nombre.length > 50) { alert("El nombre del producto debe tener entre 2 y 50 caracteres."); return false; }
    
    // Validaciones de bodega, sucursal y moneda
    if (!bodega) { alert("Debes seleccionar una bodega."); return false; }
    if (!sucursal) { alert("Debes seleccionar una sucursal de la bodega seleccionada."); return false; }
    if (!moneda) { alert("Debes seleccionar una moneda para el producto."); return false; }

    // Validaciones del precio
    if (!precio) { alert("El precio del producto no puede estar en blanco."); return false; }
    if (!/^\d+(\.\d{1,2})?$/.test(precio)) { alert("El precio del producto debe ser un número positivo con hasta dos decimales."); return false; }

    // Validación del material
    if (material.length < 2) { alert("Debes seleccionar al menos dos materiales para el producto."); return false; }

    // Validaciones de la descripción
    if (!descripcion) { alert("La descripción del producto no puede estar en blanco."); return false; }
    if (descripcion.length < 10 || descripcion.length > 1000) { alert("La descripción del producto debe tener entre 10 y 1000 caracteres."); return false; }

    return true;
}