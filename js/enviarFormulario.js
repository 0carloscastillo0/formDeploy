/*
Función que envía el formulario de producto con todos los datos validados previamente
*/
export async function enviarFormulario(file) {

    // Obtener el formulario y sus datos
    const form = document.getElementById("formProducto");
    const submitBtn = form.querySelector('button[type="submit"]');
    const formData = new FormData(form);
    const resultadoDiv = document.getElementById("resultado");

    // Convertir tipos de datos según sea necesario
    formData.set('precio', parseFloat(formData.get('precio')));
    formData.set('bodega', parseInt(formData.get('bodega')));
    formData.set('sucursal', parseInt(formData.get('sucursal')));
    formData.set('moneda', parseInt(formData.get('moneda')));

    // Los materiales seleccionados se transforman en un string separado por comas
    const materiales = Array.from(document.querySelectorAll('input[name="material"]:checked'))
        .map(cb => cb.value);
    formData.set('material', materiales.join(','));
    
    submitBtn.disabled = true;

    // Enviar el formulario mediante fetch
    try {
        const res = await fetch(file + "enviarFormulario.php", {
            method: "POST",
            body: formData
        });

        resultadoDiv.innerHTML = "";
        
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const data = await res.json();

        if (data.error) {
           resultadoDiv.innerHTML = `<p style='color:red;'>${data.error}</p>`;
            return false;
        }

        resultadoDiv.innerHTML = `<p style='color:green;'>${data.message}</p>`;
        return true;
    } catch (err) {
        resultadoDiv.innerHTML = `<p style='color:red;'>Error al enviar el formulario: ${err.message}</p>`;
        return false;
    }
}
