/*
Función para validar si el código del producto ya existe en la base de datos
Entrada:
    - codigo: código del producto a validar
    - mensaje: mensaje a mostrar si el código ya existe
Salida:
    - true si el código no existe, false si ya existe o hay un error
*/
export async function validarCodigoDB(codigo, mensaje) {
  try {
    const res = await fetch(`./php/validarCodigo.php?codigo=${encodeURIComponent(codigo)}`);
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    const data = await res.json();

    if (data.error) {
      alert(data.error);
      return false;
    }

    if (data.existe) {
      alert(mensaje);
      return false;
    }

    return true;
  } catch (err) {
    alert("Error al validar el código: " + err.message);
    return false;
  }
}
