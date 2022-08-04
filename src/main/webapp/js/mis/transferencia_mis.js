var ruta_contenedores_mis = "./contenedores/mis/";
var ruta_cruds_mis = "./cruds/mis/";
var ruta_grillas_mis = "./grillas/mis/";
var ruta_consultas_mis = "./consultas/mis/";

function cargar_datos_key_trans_mis() {
    if (event.keyCode == 13 || event.which == 13) {
        consulta_lotes_transferencias_reprocesos($('#txt_lote').val());
    }
}

function cargar_datos_key_trans_subproducto() {
    if (event.keyCode == 13 || event.which == 13) {
        consulta_lotes_transferencias_subproductos($('#txt_lote').val());
    }
}


function consulta_lotes_transferencias_reprocesos(carro) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_mis + 'consulta_lotes_transferencias_reprocesos.jsp',
        data: ({carro: carro}),
        beforeSend: function () {
            $('#div_cargar').show();
        },
        success: function (data) {
             
            $('#div_cargar').hide();
            $.each(data, function (i, item)
            {
                if (item.estado === "0") {
                    aviso_existencia(item.cod_carrito);
                } else {
                    cargar_grilla_trans_mis(item.tipo_huevo, item.cod_carrito, item.cod_interno, item.cantidad, item.fecha_puesta, item.desFallaZona);
                }
            });
            $('#txt_lote').val('');
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}



function cargar_grilla_trans_mis(tipo_huevo, cod_carrito, cod_interno, cantidad, fecha_puesta, desFallaZona) {

    if (checkId_mis(cod_interno)) {
        return aviso_duplicado();
    }

    var planchas = parseInt(cantidad) / 30;
    var unidades = parseInt(cantidad) - (parseInt(planchas) * 30);


    $('#grilla_transfer tbody').prepend('<tr class="suma" id="row' + cod_interno + '" > ' +
            '<td for="id"><b>' + cod_interno + '</b></td>' +
            '<td><b>' + cod_carrito + '</b></td>' +
            '<td><b>' + cantidad + '</b></td>' +
            '<td><b>' + parseInt(planchas) + '</b></td>' +
            '<td><b>' + unidades + '</b></td>' +
            '<td><b>' + fecha_puesta + '</b></td>' +
            '<td><b>' + tipo_huevo + '</b></td>' +
            '<td><b>' + desFallaZona + '</b></td>' +
            '<td><input type="button" value="ELIMINAR" name="remove" id="' + cod_interno + '" class="btn btn-danger btn_remove"></td> ');

}



function consulta_lotes_transferencias_subproductos(carro) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_mis + 'consulta_lotes_transferencias_subproductos.jsp',
        data: ({carro: carro}),
        beforeSend: function () {
            $('#div_cargar').show();
        },
        success: function (data) {
            $('#div_cargar').hide();
            $.each(data, function (i, item)
            {
                if (item.estado === "0") {
                    aviso_existencia(item.cod_carrito);
                } else {
                    cargar_grilla_trans_subproductos(item.tipo_huevo, item.cod_carrito, item.cod_interno, item.cantidad, item.fecha_puesta, item.estado_costeo, item.cod_lote, item.desFallaZona);
                }
            });
            $('#txt_lote').val('');
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}


function cargar_grilla_trans_subproductos(tipo_huevo, cod_carrito, cod_interno, cantidad, fecha_puesta,
        estado_costeo, cod_lote, desFallaZona) {

    if (checkId_mis(cod_interno)) {
        return aviso_duplicado();
    }

    var planchas = parseInt(cantidad) / 30;
    var unidades = parseInt(cantidad) - (parseInt(planchas) * 30);


    $('#grilla_transfer tbody').prepend('<tr class="suma" id="row' + cod_interno + '" > ' +
            '<td for="id"><b>' + cod_interno + '</b></td>' +
            '<td><b>' + cod_carrito + '</b></td>' +
            '<td><b>' + cantidad + '</b></td>' +
            '<td><b>' + parseInt(planchas) + '</b></td>' +
            '<td><b>' + unidades + '</b></td>' +
            '<td><b>' + fecha_puesta + '</b></td>' +
            '<td><b>' + tipo_huevo + '</b></td>' +
            '<td><b>' + estado_costeo + '</b></td>' +
            '<td><b>' + cod_lote + '</b></td>' +
            '<td><b>' + desFallaZona + '</b></td>' +
            '<td><input type="button" value="ELIMINAR" name="remove" id="' + cod_interno + '" class="btn btn-danger btn_remove"></td> ');

}



function checkId_mis(id)
{
    let ids = document.querySelectorAll('#grilla_transfer td[for="id"]');

    return [].filter.call(ids, td => td.textContent === id).length === 1;
}




 
function enviar_datos_transferencia_mis()
{
    var filas = document.querySelectorAll("#grilla_transfer tbody tr");
    jsonObj = [];
    var cont = 0;
    filas.forEach(function (e)
    {
        // obtenemos las columnas de cada fila
        var columnas = e.querySelectorAll("td");
        item = {}
        item ["cod_interno"] = columnas[0].textContent;
        item ["cod_carrito"] = columnas[1].textContent;
        item ["cantidad"] = columnas[2].textContent;
        jsonObj.push(item);
        cont++;
    });

    var destino = $("#cbox_destino").val();
    if ($("#cbox_destino").val() == null)
    {
        aviso_error("DEBE SELECCIONAR EL DESTINO");
    } else if ($("#cbox_chofer").val() == null)
    {
        aviso_error("DEBE SELECCIONAR EL CHOFER");
    } else if ($("#cbox_camion").val() == null)
    {
        aviso_error("DEBE SELECCIONAR EL CAMION");
    } else if (cont == 0)
    {
        aviso_error("DEBE INGRESAR LOTE");
    } else
    {
        var json_string = JSON.stringify(jsonObj);
        confirmar_registro_transfer_mis(json_string, 'control_registro_transferencia_rp');
    }
}

function enviar_datos_transferencia_subproductos()
{
    var filas = document.querySelectorAll("#grilla_transfer tbody tr");
    jsonObj = [];
    var cont = 0;
    filas.forEach(function (e)
    {
        // obtenemos las columnas de cada fila
        var columnas = e.querySelectorAll("td");
        item = {}
        item ["cod_interno"] = columnas[0].textContent;
        item ["cod_carrito"] = columnas[1].textContent;
        item ["cantidad"] = columnas[2].textContent;
        item ["estado_costeo"] = columnas[7].textContent;
        item ["cod_lote"] = columnas[8].textContent;
        jsonObj.push(item);
        cont++;
    });

    var destino = $("#cbox_destino").val();
    if ($("#cbox_destino").val() == null)
    {
        aviso_error("DEBE SELECCIONAR EL DESTINO");
    } else if ($("#cbox_chofer").val() == null)
    {
        aviso_error("DEBE SELECCIONAR EL CHOFER");
    } else if ($("#cbox_camion").val() == null)
    {
        aviso_error("DEBE SELECCIONAR EL CAMION");
    } else if (cont == 0)
    {
        aviso_error("DEBE INGRESAR LOTE");
    } else
    {
        var json_string = JSON.stringify(jsonObj);
        confirmar_registro_transfer_mis(json_string, 'control_registro_transferencia_sp'); //subproducto     
    }
}
 
function confirmar_registro_transfer_mis(valor, pagina) {

    Swal.fire({
        title: 'TRANSFERENCIA DE LOTES',
        text: "DESEA TRANSFERIR LOS LOTES?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, TRANSFERIR!',
        cancelButtonText: 'NO, CANCELAR!'
    }).then((result) => {
        if (result.value) {

            $.ajax({
                type: "POST",
                url: ruta_cruds_mis + pagina + '.jsp',
                data: ({
                    valor: valor, chofer: $('#cbox_chofer').val(), destino: $('#cbox_destino').val(), camion: $('#cbox_camion').val()}),
                beforeSend: function ()
                {
                    Swal.fire({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                         willOpen: () => {
                    Swal.showLoading()
                }
               
                    });
                },
                success: function (data)
                {
                    aviso_registro_transfer(data.tipo_respuesta, data.mensaje);
                },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
            });

        }
    });


}







  