/*
Función para cargar las sucursales a partir de una bodega seleccionada.
Entrada:
    - file: Ruta a la carpeta PHP.
    - selectBodegaId: ID del elemento select de las bodegas.
    - selectSucursalId: ID del elemento select de las sucursales.
*/
export async function cargarSucursales(file, selectBodegaId, selectSucursalId) {
    // Obtener los elementos select y el ID de la bodega seleccionada
    const sucursalSelect = document.getElementById(selectSucursalId);
    const bodega = document.getElementById(selectBodegaId);
    const bodegaId = parseInt(bodega.value);

    sucursalSelect.innerHTML = "";

    // Agregar una opción en blanco al inicio
    const blankOption = document.createElement("option");
    blankOption.value = "";
    blankOption.textContent = "";
    sucursalSelect.appendChild(blankOption);

    if (!bodegaId) return; 

    // Realizar la petición para obtener las sucursales
    try {
        const res = await fetch(file + "cargarSucursales.php?bodega_id=" + bodegaId);
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const data = await res.json();

        if (data.error) {
            const option = document.createElement("option");
            option.textContent = "Error: " + data.error;
            sucursalSelect.appendChild(option);
            return;
        }

        data.forEach(sucursal => {
            const option = document.createElement("option");
            option.value = sucursal.id;
            option.textContent = sucursal.nombre;
            sucursalSelect.appendChild(option);
        });
    } catch (err) {
        const option = document.createElement("option");
        option.textContent = "Error: " + err.message;
        sucursalSelect.appendChild(option);
    }
}
