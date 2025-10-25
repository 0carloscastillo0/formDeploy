/*
Función para cargar las bodegas desde un archivo PHP y llenar un select HTML.
Entrada:
    - file: Ruta a la carpeta PHP.
    - selectId: ID del elemento select donde se cargarán las bodegas.
*/
export async function cargarBodegas(file, selectId) {
  const bodegaSelect = document.getElementById(selectId);

  // Realizar la petición para obtener las bodegas
  try {
    const res = await fetch(file + "cargarBodegas.php");
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const data = await res.json();

    bodegaSelect.innerHTML = "";

    const blackOption = document.createElement("option");
    blackOption.value = "";
    blackOption.textContent = "";
    bodegaSelect.appendChild(blackOption);

    if (data.error) {
      const option = document.createElement("option");
      option.textContent = "Error: " + data.error;
      bodegaSelect.appendChild(option);
      return;
    }

    data.forEach(bodega => {
      const option = document.createElement("option");
      option.value = bodega.id;
      option.textContent = bodega.nombre;
      bodegaSelect.appendChild(option);
    });
  } catch (err) {
    const option = document.createElement("option");
    option.textContent = "Error: " + err.message;
    bodegaSelect.appendChild(option);
  }
}
