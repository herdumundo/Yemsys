function ir_alimentacion_hp(tipo)
{
    window.location.hash = "AHP";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_hp + "contenedor_alimentacion_hp.jsp",
        data: ({titulo: tipo}),
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cerrar_load();
        }
    });

}
function ir_informe_hp()
{
    window.location.hash = "IHP";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_hp + "contenedor_informe_hp.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_insert("dd/mm/yyyy");
            cerrar_load();
        }
    });

}


function consulta_grilla_hp_alimentacion(fecha_alimentacion) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_hp + 'consulta_lotes_grilla_hp.jsp',
        data: ({fecha_alimentacion: fecha_alimentacion}),
        beforeSend: function () {
            $('#div_cargar').show();
        },
        success: function (data)
        {
           
            $('#div_grilla').html(data);
            $('#tb_alimentacion').DataTable({
                            scrollY: "500px",
                            scrollX: !0,
                            dom: "Bfrtip",
                            pageLength: 100,
                            language: {
                                sSearch: "Buscar:",
                                sLengthMenu: "Mostrar _MENU_ registros",
                                sZeroRecords: "No se encontraron resultados",
                                sEmptyTable: "Ningún dato disponible en esta tabla",
                                sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                                sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
                                sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                                sInfoThousands: ",",
                                sLoadingRecords: "Cargando...",
                                oPaginate: {sFirst: "Primero", sLast: "Último", sNext: "Siguiente", sPrevious: "Anterior"},
                                buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}},
                            },
                            buttons: [
                                {extend: "copyHtml5", text: "COPIAR GRILLA", exportOptions: {columns: [0, ":visible"]}},
                                {extend: "excelHtml5", title:"REPORTE ALIMENTADOS FECHA "+fecha_alimentacion, text: "EXCEL", exportOptions: {columns: ":visible"}},
                                {
                                    extend: "pdfHtml5",
                                    text: "PDF",
                                    title:  "REPORTE ALIMENTADOS FECHA "+fecha_alimentacion,
                                    orientation: "landscape",
                                    pageSize: "LEGAL",
                                    
                                    exportOptions: {columns: ":visible"},
                                },
                                "colvis",
                            ],
                            keys: {clipboard: !1},
                        });
            
         }
    });

}


function cargar_datos_key_hp_alimentacion() {
    if (event.keyCode == 13 || event.which == 13) {
        consulta_lotes_hp_alimentacion($('#txt_lote').val());
    }
}


function consulta_lotes_hp_alimentacion(carro) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_hp + 'consulta_lotes_hp.jsp',
        data: ({carro: carro}),
        beforeSend: function () {
            $('#div_cargar').show();
        },
        success: function (data)
        {
            $('#div_cargar').hide();
            $.each(data, function (i, item)
            {
                if (item.estado === "0") {
                    aviso_existencia(item.cod_carrito);
                } else {
                    cargar_grilla_alimentacion_hp(item.tipo_huevo, item.cod_carrito, item.cod_interno, item.cantidad, item.fecha_puesta, item.descfalla, item.clasificadora_origen);
                }
            });
            $('#txt_lote').val('');
            sumar_grilla_reprocesos();
        }
    });

}



function cargar_grilla_alimentacion_hp(tipo_huevo, cod_carrito, cod_interno, cantidad, fecha_puesta, falla, origen)
{
    if (checkId(cod_interno)) {
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
            '<td><b>' + falla + '</b></td>' +
            '<td><b>' + origen + '</b></td>' +
            '<td><input type="button" value="ELIMINAR" name="remove" id="' + cod_interno + '" class="btn btn-danger btn_remove"></td> ');
}



function enviar_datos_alimentacion_hp()
{
    var filas = document.querySelectorAll("#grilla_transfer tbody tr");
    jsonObj = [];
    var cont = 0;
    filas.forEach(function (e)
    {
        var columnas = e.querySelectorAll("td");
        item = {}
        item ["cod_interno"] = columnas[0].textContent;
        item ["cod_carrito"] = columnas[1].textContent;
        item ["cantidad"] = columnas[2].textContent;
        item ["fecha_puesta"] = columnas[5].textContent;
        item ["tipo_huevo"] = columnas[6].textContent;
        jsonObj.push(item);
        cont++;
    });

    if (cont == 0)
    {
        aviso_generico(2, "DEBE INGRESAR LOTE");
    } else
    {
        var json_string = JSON.stringify(jsonObj);

        Swal.fire({
            title: 'ALIMENTACION DE LOTES',
            text: "DESEA REALIZAR EL REGISTRO?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'
        }).then((result) => {
            if (result.value)
            {
                $.ajax({
                    type: "POST",
                    url: ruta_cruds_hp + 'control_registro_alimentacion_hp.jsp',
                    data: ({
                        json_string: json_string}),
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
                        aviso_generico(data.tipo_respuesta, data.mensaje)
                        if(data.tipo_respuesta==1)
                        {
                            $("#contenedor_principal").html("");
                        }
                    }
                });

            }
        });
    }
}