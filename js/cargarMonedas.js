/*
Función para cargar las monedas desde un archivo PHP y llenar un select HTML.
Entrada:
    - file: Ruta a la carpeta PHP.
    - selectId: ID del elemento select donde se cargarán las monedas.
*/
export async function cargarMonedas(file, selectId) {
  const monedaSelect = document.getElementById(selectId);
  
  // Realizar la petición para obtener las monedas
  try {
    const res = await fetch(file + "cargarMonedas.php");
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const data = await res.json();

    monedaSelect.innerHTML = "";

    const blackOption = document.createElement("option");
    blackOption.value = "";
    blackOption.textContent = "";
    monedaSelect.appendChild(blackOption);

    if (data.error) {
      const option = document.createElement("option");
      option.textContent = "Error: " + data.error;
      monedaSelect.appendChild(option);
      return;
    }

    data.forEach(moneda => {
      const option = document.createElement("option");
      option.value = moneda.id;
      option.textContent = moneda.nombre;
      monedaSelect.appendChild(option);
    });
  } catch (err) {
    const option = document.createElement("option");
    option.textContent = "Error: " + err.message;
    monedaSelect.appendChild(option);
  }
}
