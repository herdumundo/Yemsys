var ruta_contenedores_ptc = "./contenedores/ppr/";
var ruta_controles_ptc = "./cruds/ppr/";
var ruta_grillas_ptc = "./grillas/ppr/";
var ruta_consultas_ptc = "./consultas/ppr/";
function ocultar_div_fecha(disposicion) {

    $('#div_calendario').val("");
    $('#calendario_registro').val("");

    if (disposicion == "7" || disposicion == "6") {
        $('#div_calendario').show();
    } else {
        $('#div_calendario').hide();
    }
}

function enviar_datos_lotes_ptc(tipo_registro)
{
    var url = ruta_controles_ptc + tipo_registro + ".jsp";
    $.ajax({
        type: "POST",
        url: url,
        data: $("#formulario").serialize(),
        success: function (data)
        {
            if (tipo_registro == "control_registro")
            {
                resultado_aviso_registro(data.tipo_respuesta, data.mensaje, 'LIBERADO', data.cajones_cargados);
            } else if (tipo_registro == "control_registro_costeado")
            {
                resultado_aviso_registro(data.tipo_respuesta, data.mensaje, 'LIBERADO_COSTEADO', data.cajones_cargados);
            } else if (tipo_registro == "control_retenidos")
            {
                resultado_aviso_registro(data.tipo_respuesta, data.mensaje, 'RETENIDO', data.cajones_cargados);
            } else
            {
                resultado_aviso_registro(data.tipo_respuesta, data.mensaje, 'RETENIDO_COSTEADO', data.cajones_cargados);
            }
        }
    });
}



function enviar_datos_carromesa() {

    $.ajax({
        type: "POST",
        url: ruta_controles_ptc + "control_carro_mesa.jsp",
        data: $("#formulario_carro_mesa").serialize(),
        success: function (data) {
        }
    });

}
;

function enviar_datos_carromesa() {

    $.ajax({
        type: "POST",
        url: ruta_controles_ptc + "control_carro_mesa.jsp",
        data: $("#formulario_carro_mesa").serialize(),
        success: function (data) {
            //   $('#contenido_reporte').html(data);
        }
    });

}
;

function enviar_datos_correccion() {

    $.ajax({
        type: "POST",
        url: ruta_controles_ptc + "control_correccion.jsp",
        data: $("#formulario_correccion").serialize(),
        success: function (data) {
            $('#mensaje_correccion').html(data);
        }
    });

}
;

function modificar_visualizacion(lote, comentario, liberado_por) {

    $.get(ruta_controles_ptc + 'control_editar_comentario.jsp', {lote: lote, comentario: comentario, liberado_por: liberado_por},
            function (res) {

                // $("#container").html(res);
                buscar_lotes_visualizacion();
            });

}
 
function limpiar_datos() {

    $('#txt_cod_lote').val('');
    //$('#cantidad_huevos').val('');
    $('#fecha_involucrada').val('');


}

 
function buscar_lotes_visualizacion()
{
    var fecha = $("#calendario_informe").val();
    $("#cabecera_informe").html('');
    $.ajax({
        method: "POST",
        url: ruta_consultas_ptc + 'consulta_visualizacion_registros.jsp',
        dataType: "json",
        data: ({calendario_informe: fecha, estado: $('#estado').val()}),
        timeout: 100000,
        success: function (data)
        {
            console.info("Success");
            $("#cabecera_informe").html(data.table);
            $('#grilla_lotes').DataTable({"scrollX": true});
            ObtenerDatosGrillaVisualizar();
        },
        error: function (e)
        {
            console.info("Error");
        },
        done: function (e)
        {
            $("#cabecera_informe").html(data.table);
        }
    });
}

function ObtenerDatosGrillaVisualizar()
{
    var a = document.getElementsByClassName('otherButton');
    for (var i = 0; i < a.length; i++)
    {
        a[i].addEventListener('click', function () {

            $('#txt_comentario').val(this.parentNode.parentNode.cells[15].textContent);
            $('#id_lote').val(this.parentNode.parentNode.cells[19].textContent);
            $('#txt_liberado').val(this.parentNode.parentNode.cells[14].textContent);

        });
    }
}