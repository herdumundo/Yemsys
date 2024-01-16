<!DOCTYPE html>
<html>
<head>
    <title>Formulario de carga de imagen</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
    <h1>Formulario de carga de imagen</h1>
    <form id="uploadForm" enctype="multipart/form-data">
        <input type="file" name="file" id="file" />
        <button type="button" onclick="uploadImage()">Subir Imagen</button>
    </form>

    <div id="result"></div>

    <script>
        function uploadImage() {
            var formData = new FormData(document.getElementById('uploadForm'));

            $.ajax({
                type: 'POST',
                url: 'TuServlet', // Asegúrate de cambiar 'TuServlet' al nombre correcto de tu servlet
                data: formData,
                contentType: false,
                processData: false,
                success: function(response) {
                    $('#result').html(response);
                },
                error: function(error) {
                    console.log(error);
                }
            });
        }
    </script>
</body>
</html>
