 
    
    <!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mostrar Imagen en Modal</title>
<style>
/* Estilos para el modal */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.9);
}

.modal-content {
  margin: auto;
  display: block;
  width: 80%;
  max-width: 600px;
}

.close {
  color: #fff;
  position: absolute;
  top: 10px;
  right: 25px;
  font-size: 35px;
  font-weight: bold;
  transition: 0.3s;
}

.close:hover,
.close:focus {
  color: #bbb;
  text-decoration: none;
  cursor: pointer;
}
</style>
</head>
<body>

<h2>Mostrar Imagen en Modal</h2>

<!-- Botón para abrir el modal -->
<button id="openModalBtn">Abrir modal</button>

<!-- Modal -->
<div id="myModal" class="modal">
  <span class="close">&times;</span>
  <img class="modal-content" id="modalImage">
</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
// Función para abrir el modal con una imagen específica
function abrirModalConImagen(nombreImagen) {
  // Construir la ruta de la imagen utilizando el nombre de la imagen
  var rutaImagen = "http://localhost:8000/imagen?nombreImagen=68491";
  // Obtener el elemento de la imagen del modal
  var modalImage = document.getElementById("modalImage");
  // Actualizar la src de la imagen del modal con la ruta de la imagen
  modalImage.src = rutaImagen;
  // Obtener el modal
  var modal = document.getElementById("myModal");
  // Mostrar el modal
  modal.style.display = "block";
}

// Cuando el usuario hace clic en la "X", cerrar el modal
var closeBtn = document.getElementsByClassName("close")[0];
closeBtn.addEventListener("click", function() {
  var modal = document.getElementById("myModal");
  modal.style.display = "none";
});
</script>

</body>
</html>

    