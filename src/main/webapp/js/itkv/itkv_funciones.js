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
            $('.selectpicker').selectpicker({size: '10'
            });
            $('#ubicacion').val('UB-00000').prop('selected', true);
            $('#ubicacion').selectpicker('refresh');

            $('#rubro').val('UPR-001').prop('selected', true);
            $('#rubro').selectpicker('refresh');

            $('#actividad').val('GAN').prop('selected', true);
            $('#actividad').selectpicker('refresh');

            $('#boca').val('DEP_TAL').prop('selected', true);
            $('#boca').selectpicker('refresh');


            $("#form_add_consumo").on("submit", function (e) {
                e.preventDefault(),
                        registrar_salida1_itkv();
                e.stopPropagation();
            }),
                    $(".autoNumeric").autoNumeric('init', {
                aSep: '.',
                aDec: ',',
                aForm: true,
                vMax: '999999999',
                vMin: '0'
            });


            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}


function ir_cisterna_combustible_itkv() {

    window.location.hash = "IRINVITKV";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_itkv + "contenedor_traslado_combustible.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            $('.selectpicker').selectpicker({size: '10'
            });
            $('#boca').val('DEP_TAL').prop('selected', true);
            $('#boca').selectpicker('refresh');
            $("#form_add_consumo").on("submit", function (e) {
                e.preventDefault(),
                        registrar_salida2_itkv();
                e.stopPropagation();
            }),
                    $(".autoNumeric").autoNumeric('init', {
                aSep: '.',
                aDec: ',',
                aForm: true,
                vMax: '999999999',
                vMin: '0'
            });


            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });


}



function ir_salida_repuesto_itkv()
{
    $.ajax({
        type: "POST",
        url: ruta_contenedores_itkv + "contenedor_salida_repuesto.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            $('.selectpicker').selectpicker({size: '10'
            });
            $('#ubicacion').val('UB-00000').prop('selected', true);
            $('#ubicacion').selectpicker('refresh');

            $('#rubro').val('UPR-001').prop('selected', true);
            $('#rubro').selectpicker('refresh');

            $('#actividad').val('GAN').prop('selected', true);
            $('#actividad').selectpicker('refresh');

            $('#boca').val('DEP_TAL').prop('selected', true);
            $('#boca').selectpicker('refresh');


            $("#form_add_consumo").on("submit", function (e) {
                e.preventDefault(),
                        registrar_transferencias_itkv();
                e.stopPropagation();
            }),
                    $(".autoNumeric").autoNumeric('init', {
                aSep: '.',
                aDec: ',',
                aForm: true,
                vMax: '999999999',
                vMin: '0'
            });


            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}




function ir_balanceado_itkv() {


}
function registrar_salida1_itkv() {

    if ($("#retirado_por").val() == "") {
        aviso_generico(0, "SELECCIONE RESPONSABLE");
    } else {

        var responsable = $("#retirado_por").val();
        var id_activo = $("#activo").attr('code');
        var desc_activo = $("#activo").attr('value');
        var id_ubicacion = $("#ubicacion").find(':selected').attr('value');
        var desc_ubicacion = $("#ubicacion").find(':selected').attr('desc');
        var id_rubro = $("#rubro").find(':selected').attr('value');
        var desc_rubro = $("#rubro").find(':selected').attr('desc');
        var id_actividad = $("#actividad").find(':selected').attr('value');
        var desc_actividad = $("#actividad").find(':selected').attr('desc');
        var km_ho = $("#km_ho").val();
        var id_boca = $("#boca").find(':selected').attr('value');
        var desc_boca = $("#boca").find(':selected').attr('desc');

        var lt_inicio = $("#lt_inicio").val();
        var lt_fin = $("#lt_fin").val();
        var lt_total = $("#lt_total").val();
        var id_tipo_combustible = $("#tipo_combus").find(':selected').attr('value');
        var tipo_combustible = $("#tipo_combus").find(':selected').attr('desc');


        Swal.fire({
            title: 'CONFIRMACION',
            text: "DESEA GENERAR EL DOCUMENTO?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#001F3F',
            cancelButtonColor: '#001F3F',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'}).then((result) =>
        {
            if (result.value)
            {
                $.ajax({
                    type: "POST",
                    url: ruta_cruds_itkv + "crud_registrar_salida_combustible.jsp",
                    data: {

                        responsable: responsable,
                        id_activo: id_activo,
                        desc_activo: desc_activo,
                        id_ubicacion: id_ubicacion,
                        desc_ubicacion: desc_ubicacion,
                        id_rubro: id_rubro,
                        desc_rubro: desc_rubro,
                        id_actividad: id_actividad,
                        desc_actividad: desc_actividad,
                        id_boca: id_boca,
                        desc_boca: desc_boca,
                        km_ho: km_ho.replaceAll(".", ""),
                        lt_inicio: lt_inicio.replaceAll(".", ""),
                        lt_fin: lt_fin.replaceAll(".", ""),
                        lt_total: lt_total.replaceAll(".", ""),
                        id_tipo_combustible: id_tipo_combustible,
                        tipo_combustible: tipo_combustible


                    },
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: !1,
                            onBeforeOpen: () => {
                                Swal.showLoading(),
                                        (timerInterval = setInterval(() => {
                                            Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                        }, 1e3));
                            },
                        });
                    },
                    success: function (res)
                    {
                        aviso_generico(res.tipo_respuesta, res.mensaje);
                        if (res.tipo_respuesta == 1)
                        {
                            ir_consumo_combustible_itkv();
                        }
                    }
                });
            }
        });

    }
}


function registrar_salida2_itkv() {
 
    var responsable = $("#retirado_por").val();
    var id_boca = $("#boca").find(':selected').attr('value');
    var desc_boca = $("#boca").find(':selected').attr('desc');

    var id_boca_destino = $("#boca_destino").find(':selected').attr('value');
    var desc_boca_destino = $("#boca_destino").find(':selected').attr('desc');

    var lt_inicio = $("#lt_inicio").val();
    var lt_fin = $("#lt_fin").val();
    var lt_total = $("#lt_total").val();
    var id_tipo_combustible = $("#tipo_combus").find(':selected').attr('value');
    var tipo_combustible = $("#tipo_combus").find(':selected').attr('desc');







    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GENERAR EL DOCUMENTO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_itkv + "crud_registrar_salida2_combustible.jsp",
                data: {

                    responsable: responsable,
                    id_boca: id_boca,
                    desc_boca: desc_boca,
                    id_boca_destino: id_boca_destino,
                    desc_boca_destino: desc_boca_destino,
                    lt_inicio: lt_inicio.replaceAll(".", ""),
                    lt_fin: lt_fin.replaceAll(".", ""),
                    lt_total: lt_total.replaceAll(".", ""),
                    id_tipo_combustible: id_tipo_combustible,
                    tipo_combustible: tipo_combustible


                },
                beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (res)
                {
                    aviso_generico(res.tipo_respuesta, res.mensaje);
                    if (res.tipo_respuesta == 1)
                    {
                        ir_cisterna_combustible_itkv();
                    }
                }
            });
        }
    });
}









function calcular_litros_itkv() {
    var lt_inicio = $("#lt_inicio").val().replaceAll(".", "");
    var lt_fin = $("#lt_fin").val().replaceAll(".", "");


    $("#lt_total").val(parseInt(lt_fin) - parseInt(lt_inicio));


}
function ir_reporte_consumo_combustible_itkv()
{
    window.location.hash = "IRCCI";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_itkv + "contenedor_consumo_combustible_reporte.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_global('dd/mm/yyyy', true);


            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}

function ir_grilla_consumo_combustible_itkv()
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_itkv + "consulta_gen_grilla_impresion_combustible.jsp",
        data: ({fecha: $("#fecha").val()}),
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            // $("#div_grilla").html("");
            $("#div_grilla").html(data.tabla);
            $("#grilla").DataTable
                    ({
                        paging: false,
                        "ordering": false,
                        "language":
                                {
                                    "sUrl": "js/Spanish.txt"
                                },
                        scrollX: true,
                    });
            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}


function insert_valor_responsable_combo_itkv() {
    var responsable = $("#retirado_por_select").val();
    var activo = $("#activo_select").val();

    $("#retirado_por").val(responsable);

    if ($("#retirado_por_select").val() == "OTROS") {
        $("#retirado_por").show();
        $("#retirado_por").val("");
        $("#retirado_por").attr("required");


    } else {

        $("#retirado_por").hide();
        $("#retirado_por").removeAttr("required");
    }


    if ($("#activo_select").val() == "OTROS")
    {
        $("#activo").show();
        $("#activo").val("");
        $("#activo").attr("code", "N/A");


    } else
    {
        var id_activo = $("#activo_select").find(':selected').attr('value');
        var desc_activo = $("#activo_select").find(':selected').attr('desc');
        $("#activo").hide();
        $("#activo").attr("code", id_activo);
        $("#activo").attr("value", desc_activo);
    }
}





function cargar_grilla_salida_repuesto()
{

    var cod_articulo = $("#item").find(':selected').attr('value');
    var articulo = $("#item").find(':selected').attr('desc');
    var cantidad = $("#cantidad").val();

    if (cantidad == '') {
        aviso_generico(0, "INGRESE CANTIDAD");
    } else {


        var contador = 0;
        var table = $('#tabla').DataTable();
        var data = table.rows({selected: true}).data();
        for (var i = 0; i < data.length; i++)
        {
            if (data[i][0] == cod_articulo)
            {
                contador++;
            }
        }
        if (contador == 0)
        {
            // registrar_pendientes(cod_lote, tipo, nro_carrito, item_codigo, cantidad, fecha_puesta, estado, identificador);

            var newData = [cod_articulo, articulo, cantidad, '<a class=" btn btn-danger font-weight-bold remove"   > <i class="fa fa-trash-o fa-lg"></i></a>'];

            var rowNode = table.row.add(newData).order([0, 'desc']).draw(false).node();
            $(rowNode).find('td').eq(0).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
            $(rowNode).find('td').eq(1).addClass('font-weight-bold');
            $(rowNode).find('td').eq(2).addClass('font-weight-bold');
            $(rowNode).find('td').eq(3).addClass('font-weight-bold');
            $(rowNode).attr('id', 'row' + cod_articulo);//AGREGA ID AL <tr> FILA.
            counter++;// CONTADOR GLOBAL, PARA EL ORDER BY PREPEND. 
        } else {
            swal.fire({
                type: 'error',
                title: "ARTICULO DUPLICADO",
                confirmButtonText: "CERRAR"
            });
        }

        $("#cantidad").val("");

    }
}




function registrar_transferencias_itkv(){
    
    
    var filas = document.querySelectorAll("#tabla tbody tr");
    jsonObj = [];
    var cont = 0;
    filas.forEach(function (e)
    {
         var columnas = e.querySelectorAll("td");
        item = {}
        item ["codigo"] = columnas[0].textContent;
        item ["articulo"] = columnas[1].textContent;
        item ["cantidad"] = columnas[2].textContent;
        jsonObj.push(item);
        cont++;
    });
    
        var json_string = JSON.stringify(jsonObj);
        if(json_string=='[]'){
                    aviso_generico('0','NO SE HA INGRESADO ARTICULO');
        }
        
        else {
            
    var responsable         = $("#retirado_por").val();
  
    var id_activo           = $("#activo").attr('code');
    var desc_activo         = $("#activo").attr('value');
    
    var id_rubro            = $("#rubro").find(':selected').attr('value');
    var desc_rubro          = $("#rubro").find(':selected').attr('desc');
  
    var id_actividad        = $("#actividad").find(':selected').attr('value');
    var desc_actividad      = $("#actividad").find(':selected').attr('desc');

 
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GENERAR EL DOCUMENTO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_itkv + "crud_registrar_transferencias_itkv.jsp",
                data: {

                    responsable     : responsable,
                    id_activo       : id_activo,
                    desc_activo     : desc_activo,
                    id_rubro        : id_rubro,
                    desc_rubro      : desc_rubro,
                    id_actividad    : id_actividad,
                    desc_actividad  : desc_actividad,
                    jsonObj         : json_string


                },
                beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (res)
                {
                    aviso_generico(res.tipo_respuesta, res.mensaje);
                    if (res.tipo_respuesta == 1)
                    {
                        ir_salida_repuesto_itkv();
                    }
                }
            });
        }
    });


        }


}