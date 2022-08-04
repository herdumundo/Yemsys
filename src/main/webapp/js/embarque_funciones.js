
function filtrar_listado_embarque(calendario) {
    cargar_load("Consultando...")
    $.get(ruta_contenedores_emb+'informe_embarque.jsp', {calendario: calendario}, function (res) {
        $("#contenedor_embarque_lista").html(res);
        cerrar_load();
    });
}

function control_embarque(cbox_chofer, cbox_camion, resultado, calendario, numero_factura, hora_inicio) {
    $.ajax({
        type: "POST",
        url: cruds_emb + 'control_embarque.jsp',

        data: ({
            cbox_chofer: cbox_chofer,
            cbox_camion: cbox_camion, resultado: resultado, calendario: calendario, numero_factura: numero_factura,
            hora_inicio: hora_inicio}),

        beforeSend: function () {
            Swal.fire({
                title: 'PROCESANDO!',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                 showConfirmButton: false,
                  willOpen: () => {
                    Swal.showLoading()
                }
               
            });
        },

        success: function (data)
        {
            aviso_registro_embarque(data.tipo_respuesta, data.mensaje);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}


function control_sincronizar_lotes() {
    $.ajax({
        type: "POST",
      url: cruds_emb + 'control_sincro_lotes.jsp',
       //   url: 'http://192.168.6.162:8089/Yemsys/cruds/embarques/control_sincro_lotes.jsp',

        data: ({test: ''}),

        beforeSend: function () {
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

          swal.fire({
            type: 'success',
            text: data.mensaje,
            confirmButtonText: "CERRAR"

        });
        
           
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_control_embarque(id, calendario)
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_emb + 'select_lotes.jsp',
        data: ({id: id, calendario: calendario, factura: $('#txt_nro_fact').val()}),
        beforeSend: function () {

        },
        success: function (data)
        {
            //  Swal.close();
            $.each(data, function (i, item)
            {
                if (item.tipo_mensaje == "0") {
                    aviso_error_embarque(item.mensaje);
                } else {
                    if (item.cod_lote == "0") {
                        aviso_error_carro(item.nro_carrito);
                    } else if (item.estado_liberacion == 'R' || item.estado_liberacion == 'Z') {
                        aviso_error_carro_retenido();
                    } else {
                    cargar_grilla(item.cod_lote, item.tipo, item.nro_carrito, item.item_codigo, item.cantidad, item.fecha_puesta, item.estado, item.identificador_lote);
                  // function cargar_grilla(cod_lote, tipo, nro_carrito, item_codigo, cantidad, fecha_puesta, estado, identificador)

                    }
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

function registrar_pendientes(cod_lote, tipo, nro_carrito, item_codigo, cantidad, fecha_puesta, estado, identificador_lote) {
    var numero_factura = $('#txt_nro_fact').val();
    $.ajax({
        type: "POST",
        url: cruds_emb + 'control_lotes_pendientes.jsp',
        data: ({
            cod_lote: cod_lote,
            tipo_huevo: tipo, carro: nro_carrito, cod_huevo: item_codigo, cantidad: cantidad,
            fecha_puesta: fecha_puesta, estado_lote: estado, identificador_lote: identificador_lote, numero_factura: numero_factura}),
        //dataType: "html",
        success: function (data)
        {
            //  aviso_registro_embarque(data.resultad_final,data.out_cod_lote_rec,data.out_area_rec,data.out_numero_fact_rec,data.nro_embarque);
            //  return data;
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function eliminar_fila_embarque_pendientes() {

    $('.table').on('click', '.remove', function ()
    {   // EN ESTE PROCESO LO QUE SE BUSCA HACER ES, PRIMERO, RECUPERAR EL ID DE LA FILA CLICKEADA PARA LUEGO MANDAR EL ID AL CONTROL ELIMINAR, 
        //LUEGO ELIMINA LA FILA EN EL DATATABLE.
        var table = $('#myTable').DataTable();//OBTENGO EL ID DE MI TABLA.
        var id_carro = table.cell($(this).closest('tr'), 8).data();// OBTENGO EL VALOR DE LA POSICION 8 DE LA FILA SELECCIONADA PARA ELIMINAR, EN ESTE CASO SELECCIONO EL ID DEL LOTE.

        $.ajax({
            type: "POST",
            url: cruds_emb + 'control_grilla_recuperada_eliminar.jsp',
            data: ({id: id_carro, nro_factura: $('#txt_nro_fact').val()}),
            //dataType: "html",
            success: function (data)
            {
                table.row($('#row' + id_carro)).remove().draw();
                calculos_cantidades_grilla();
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });



    });

}


function activar_datatable() {

    $('#myTable').DataTable({
      // "retrieve": true,
       // "scrollX": true,
        "paging": false,
        "info": false
        , 'order': [[9, 'desc']],
        "oLanguage": {
            "sProcessing": "Procesando...",
            "sLengthMenu": "Mostrar _MENU_ registros",
            "sZeroRecords": "No se encontraron resultados",
            "sEmptyTable": "Ningun dato disponible en esta tabla",
            "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sSearch": "Buscar Lote:",
            "sInfoThousands": ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast": "Último",
                "sNext": "Siguiente",
                "sPrevious": "Anterior"
            }}
    });
    calculos_cantidades_grilla();

}
function sincronizar_lotes() {
    Swal.fire({
        title: 'ACTUALIZACION',
        text: "DESEA SINCRONIZAR LOS LOTES REGISTRADOS.?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, SINCRONIZAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) => {
        if (result.value) {
            control_sincronizar_lotes();
        }
    });
}



function confirmar_registro(datos_grilla) {
    var total = $('#total_cajones').val();

    Swal.fire({
        title: 'REGISTRO DE EMBARQUE TOTAL EN CAJONES:' + total,
        text: "DESEA REGISTRAR LOS DATOS INGRESADOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) => {
        if (result.value) {
            control_embarque($('#cbox_chofer').val(), $('#cbox_camion').val(), datos_grilla, $('#calendario_embarque').val(), $('#txt_nro_fact').val(), $('#hora_inicio').val());
        }
    });


}




function aviso_registro_embarque(tipo, mensaje) 
{
    if (tipo == 1)
    {
        swal.fire
        ({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        traer_informe_factura();
    } else
    {
        swal.fire
        ({
            type: 'error',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
     }
}