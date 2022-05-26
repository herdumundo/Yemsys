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