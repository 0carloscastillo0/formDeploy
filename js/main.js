import { cargarBodegas } from "./cargarBodegas.js";
import { cargarSucursales } from "./cargarSucursales.js";
import { cargarMonedas } from "./cargarMonedas.js";
import { validaciones } from "./validaciones.js";
import { enviarFormulario } from "./enviarFormulario.js";

let php = "./php/";

document.addEventListener("DOMContentLoaded", () => {
    // Cargar las bodegas
    cargarBodegas(php, "bodega");

    // Escuchar cambios en el select de bodegas para cargar las sucursales
    const bodegaSelect = document.getElementById("bodega");
    bodegaSelect.addEventListener("change", () => {
        cargarSucursales(php, "bodega", "sucursal");
    });

    // Cargar las monedas
    cargarMonedas(php, "moneda");

    // Validar el formulario y despues enviarlo
    const formulario = document.getElementById("formProducto");
    formulario.addEventListener("submit", async (e) => {
        e.preventDefault();
        
        const esValido = await validaciones();
        if (!esValido) return;

        const exito = await enviarFormulario(php);
        if (exito) {
            formulario.reset();
            bodegaSelect.dispatchEvent(new Event('change'));
        }
        
    });
});
