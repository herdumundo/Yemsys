
function irTransferenciaProduc()
{
    $.ajax({
        type: "POST",
        url: rutaVimarContenedores+"contenedor_transferencia_vimar.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
           
            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}


function obtenerLote(){
    
     var destinoSeleccionado2= $("#selectDestino").find(':selected').attr('descripcion');
     var txt_lote = $("#txt_lote").val()
   alert(txt_lote)
    
}
