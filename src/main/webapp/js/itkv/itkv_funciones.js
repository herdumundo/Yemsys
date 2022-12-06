function ir_consumo_combustible_itkv()
{
    window.location.hash = "SCFBAL";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_itkv + "contenedor_consumo_combustible.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
           
            $(".checkbox").bootstrapToggle(),
           // cargar_toggles_bal();
    
        /*    $("#formulario").on("submit", function (e) {
                e.preventDefault(), 
                    validar_datos_mtp_sol(), 
                e.stopPropagation();
            })*/
            cerrar_load();
    
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}