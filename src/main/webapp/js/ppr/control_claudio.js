var ruta_consultas_ppr = "./consultas/ppr/";
var ruta_vistas_ppr = "./contenedores/contenedores_ppr/";
var ruta_cruds_ppr = "./cruds/ppr/";


function grafico_detalles_ppr()
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_chart_rango_fecha.jsp',
        data: {
            fechad: $('#idfechadesde').val(),
            fechah: $('#idfechahasta').val(),
            aviario1: $('#avi').val()
        },
        beforeSend: function (xhr) {
            cargar_load("Consultando...");


        },

        success: function (data)
        {
            var c = 0;
            $.each(data.chartsdet, function (i, item)
            {
                var a = '  <div class="card card-navy">   ';
                a += '  <div class="card-header"> ';
                a += '   <h3 class="card-title">Resumen Detalles - ' + data.chartsdet[c].options.plugins.title.text + '</h3> ';
                a += '    <div class="card-tools"> ';
                a += '    <button type="button" class="btn btn-tool" data-card-widget="collapse"> ';
                a += '     <i class="fas fa-minus"></i> ';
                a += '    </button> ';
                a += '   <button type="button" class="btn btn-tool" data-card-widget="remove"> ';
                a += '     <i class="fas fa-times"></i> ';
                a += '  </button> ';
                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="' + data.chartsdet[c].options.plugins.title.text + '"></canvas>';
                a += '  </div> ';

                $("#divR").append(a);

                var resChart = new Chart(document.getElementById(data.chartsdet[c].options.plugins.title.text), data.chartsdet[c]);
                c++;
            });
            cerrar_load();
        }
    });
}
function llamar_grafico_detalles_ppr()
{
    $.ajax({
        url: ruta_vistas_ppr + "vista_informe_detalle.jsp",
        type: "post",
        success: function (data) {
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            $('#contenido_row').html("");
            grafico_detalles_ppr();
        }});
}

function grafico_detalles_fila_ppr(name2)
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_chart_fila.jsp',
        data: {
            fechadf: $('#idfechadesde').val(),
            fechahf: $('#idfechahasta').val(),
            aviariof: $('#avi').val(),
            filaf: name2
        },
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data)
        {
            var c = 0;
            $.each(data.chartsdetfila, function (i, item)
            {
                var a = '  <div class="card card-navy">   ';
                a += '  <div class="card-header"> ';
                a += '   <h3 class="card-title">Detalle de Fila: ' + data.chartsdetfila[c].options.plugins.title.text + '</h3> ';
                a += '    <div class="card-tools"> ';
                a += '    <button type="button" class="btn btn-tool" data-card-widget="collapse"> ';
                a += '     <i class="fas fa-minus"></i> ';
                a += '    </button> ';
                a += '   <button type="button" class="btn btn-tool" data-card-widget="remove"> ';
                a += '     <i class="fas fa-times"></i> ';
                a += '  </button> ';
                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class="col-12 col-md-10"></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="' + data.chartsdetfila[c].options.plugins.title.text + '"></canvas>';
                a += '  </div> ';

                $("#divF").append(a);

                var resChart = new Chart(document.getElementById(data.chartsdetfila[c].options.plugins.title.text), data.chartsdetfila[c]);
                c++;
            });

            cerrar_load();
        }
    });
}
function llamar_grafico_detalles_fila_ppr(name2)
{
    $.ajax({
        url: ruta_vistas_ppr + 'vista_grafico_fila.jsp',
        type: "post",
        success: function (data) {
            $('#idresumen_huevos').html("");
            $('#idresumen_det').html(data);
            $('#contenido_row').html("");
            grafico_detalles_fila_ppr(name2);
        }});
}
function traer_vista_contador_huevo2_ppr() {
    fecha = $('#idfecham').val(),
            aviario = $('#avis').val(),
            $.ajax({
                url: ruta_vistas_ppr + "/vista_registro_de_datos_diarios_A.jsp",
                type: "post",
                success: function (data) {

                    $('#contenedor_principal').html(data);
                    $('#contenido_row').html("");

                    contador_u_registro_datos_diarios_ppr(fecha)

                }

            });
}

function traer_vista_contador_huevo3_ppr() {
    fecha = $('#idfecham').val(),
            aviario = $('#avis').val(),
            $.ajax({
                url: ruta_vistas_ppr + "/vista_registro_de_datos_diarios_A.jsp",
                type: "post",
                success: function (data) {

                    $('#contenedor_principal').html(data);
                    $('#contenido_row').html("");

                    $.ajax({
                        type: "POST",
                        url: ruta_consultas_ppr + "consulta_carga_ultimo_registro_grilla_registro_datos_diarios.jsp",
                        beforeSend: function (xhr) {
                            limpiarg_ppr();
                        },
                        success: function (data) {


                            $("#idfechad").val(fecha);
                            $(window).ready(function () {

                                $('#idfechad').trigger('change');
                            });

                        }
                    });
                }

            });
}
function carga_aviario_fecha_ppr(avia, id_datos) {
    fecha = $('#idfechad').val();
    dd_mec2_ppr(id_datos);
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_cargar_aviario_fecha.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),
            avia: avia
                    //agregar aca avia y fecha

        },

        success: function (data) {

            $('#tabla_datos_diarios').html(data.grilla_datos_diarios);
            $('#avi').html(data.grilla_datos_diarios);
            $('#idfecham').val(data.fecha1);
            $('#avis').val(data.avia);
            $('#id_datos').val(id_datos);
            $('#contenido_row').html("");

            cerrar_load();

            $(window).ready(function () {
                $('#idfecham').trigger('change');
                $('#avis').trigger('change');
            });
            onSelect_mortandad_grilla_ppr();
            $(".ocultar").hide();


        }
    });

}
function carga_aviario_fecha_B_ppr(avia) {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_cargar_aviario_fecha_B.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),
            avia: avia
                    //agregar aca avia y fecha

        },

        success: function (data) {
            $('#tabla_datos_diarios').html(data.grilla_datos_diarios);
            $('#avi').html(data.grilla_datos_diarios);
            $('#idfecham').val(data.fecha1);
            $('#avis').val(data.avia);

            $('#contenido_row').html("");
            cerrar_load();

            $(window).ready(function () {
                $('#idfecham').trigger('change');
                $('#avis').trigger('change');
            });
        }
    });

}
function carga_grilla_registro_datos_diarios_A_ppr(avia) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_datos_diario.jsp',
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),
            avia: $('#avis2').val()

        },

        success: function (data) {

            $('#tabla_datos_diarios').html(data.grilla_datos_diarios);
            $('#tabla_datos_diariosb').html(data.grilla_datos_diariosb);
            $('#tabla_datos_diarios_h').html(data.grilla_datos_diariosh);
            $('#tabla_datos_diarios_descarte').html(data.grilla_datos_diarios_descarte);
            $('#tabla_datos_diarios_pre_descarte').html(data.grilla_datos_diarios_pre_descarte);

            $('#avi').html(data.grilla_datos_diarios);
            $('#avi').html(data.grilla_datos_diariosb);
            $('#avi').html(data.grilla_datos_diariosh);
            $('#avi').html(data.grilla_datos_diarios_descarte);
            $('#avi').html(data.grilla_datos_diarios_pre_descarte);
            $('#idfecham').val(data.fecha1);
            $('#avis').val(data.avia);
            $('#contenido_row').html("");
            cerrar_load();
            //  if (!Object.keys(data.aviario).length) {
            //      $(".ocultar").hide();
            //      Swal.fire({
            //          title: 'ATENCION!',
            //          text: 'No Existen Registros',
            //          type: 'warning',
            //          showCancelButton: false,
            //          confirmButtonColor: '#001F3F',
            //          confirmButtonText: 'Aceptar',
            //          timer: 6000});
            //  } else {
            //      $(".ocultar").show();
            //  }

        }
    });

}
function contador_u_registro_datos_diarios_ppr(fecha) {
    //$('#idfechad').val(fecha);
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_carga_ultimo_registro_grilla_registro_datos_diarios.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr();
        },
        success: function (data) {

            //$(item.id).css("background-color",item.color); 
            //$("#idfechad").val(data.fecha);
            $(window).ready(function () {

                $('#idfechad').trigger('change');
            });

        }
    });
}

function carga_grilla_registro_datos_diarios_Descarte_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_datos_diario_descarte.jsp',

        data: {
            idfechad: $('#idfechad').val()
        },

        success: function (data) {
            $('#tabla_datos_diarios_descarte').html(data.grilla_datos_diarios_descarte);
            $('#contenido_row').html("");
            cerrar_load();
            if (!Object.keys(data.aviario).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: 'No Existen Registros',
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 6000});
            } else {
                $(".ocultar").show();
            }

        }
    });

}


function dd_mec2_ppr(id_datos) {

    var f = $("#idfecha").val();
    $.ajax({
        url: ruta_vistas_ppr + '/vista_registro_diario_aviarios_mecanizados.jsp',
        type: "post",
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            //registro_diario_mecanizado_resumen();
            $(".ocultar").hide();
        }});
}
function dd_mec2_pre_des_convencionales_ppr(fecha) {
    var f = $("#idfecha").val();
    $.ajax({
        url: ruta_vistas_ppr + '/vista_registro_diario_pre_descarte.jsp',
        type: "post",
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            //registro_diario_mecanizado_resumen();
            carga_grilla_pre_des_convencionales_ppr(fecha);
        }});
}



function carga_grilla_pre_des_convencionales_ppr(fecha) {
 
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_datos_diario_pre_descarte_global.jsp',
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        data: {
            idfechad: fecha
                    // idfechad: f

        },

        success: function (data) {
            $('#tabla_datos_diarios_pre_descarte_mecanizados').html(data.grilla_datos_diarios_pre_descarte_global);

            $('#idfecham').val(fecha);
            //$('#avis').val(data.avia);
            $('#contenido_row').html("");
            onselect_datos_diarios_predescarte_ppr();
            cerrar_load();


        }
    });

}
function carga_grilla_pre_des_convencionales_ppr2() {
   

    var fecha = $("#idfecham").val();
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_datos_diario_pre_descarte_global.jsp',
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        data: {
            idfechad: fecha
        },

        success: function (data) {
            $('#tabla_datos_diarios_pre_descarte_mecanizados').html(data.grilla_datos_diarios_pre_descarte_global);

            $('#idfechadm').val(fecha);
            //$('#avis').val(data.avia);
            $('#contenido_row').html("");
            onselect_datos_diarios_predescarte_ppr();
            cerrar_load();


        }
    });

}


function llamar_mortandad_lotes_ppr()

{
    $.ajax({
        url: ruta_vistas_ppr + 'vista_mortandad_lotes.jsp',
        type: "post",
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            ocultar_ppr();
        }});
}

function lote_mortandad_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_mortandad_lotes.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            meslote: $('#meslote').val(),
            anolote: $('#anolote').val()
        },

        success: function (data) {
            $('#tabla_mortandad_lotes').html(data.grillalote);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            cerrar_load();
            if (!Object.keys(data.edad_dias).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {
                $(".ocultar").show();
            }
        }
    });

}

function ExportToExcel_ppr(htmlExport) {
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");

    //otro navegador no probado en IE 11
    // Si Internet Explorer
    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))
    {
        jQuery('body').append(" <iframe id=\"iframeExport\" style=\"display:none\"></iframe>");
        iframeExport.document.open("txt/html", "replace");
        iframeExport.document.write(htmlExport);
        iframeExport.document.close();
        iframeExport.focus();
        sa = iframeExport.document.execCommand("SaveAs", true, 'mortandad_lotes' + '-' + $('#meslote').val() + '-' + $('#anolote').val() + ".xls");
    } else {
        var link = document.createElement('a');

        document.body.appendChild(link); // Firefox requiere que el enlace esté en el cuerpo
        link.download = ("SaveAs", true, 'mortandad_lotes' + '-' + $('#meslote').val() + '-' + $('#anolote').val() + ".xls");
        link.href = 'data:application/vnd.ms-excel,' + escape(htmlExport);
        link.click();
        document.body.removeChild(link);
    }
}
function ExportToExceldatos_con_ppr(htmlExport) {
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");

    //otro navegador no probado en IE 11
    // Si Internet Explorer
    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))
    {
        jQuery('body').append(" <iframe id=\"iframeExport\" style=\"display:none\"></iframe>");
        iframeExport.document.open("txt/html", "replace");
        iframeExport.document.write(htmlExport);
        iframeExport.document.close();
        iframeExport.focus();
        sa = iframeExport.document.execCommand("SaveAs", true, 'datos_contadores_huevos' + '-' + $('#meslotec').val() + '-' + $('#anolotec').val() + '-' + $('#avic').val() + ".xls");
    } else {
        var link = document.createElement('a');

        document.body.appendChild(link); // Firefox requiere que el enlace esté en el cuerpo
        link.download = ("SaveAs", true, 'datos_contadores_huevos' + '-' + $('#meslotec').val() + '-' + $('#anolotec').val() + '-' + $('#avic').val() + ".xls");
        link.href = 'data:application/vnd.ms-excel,' + escape(htmlExport);
        link.click();
        document.body.removeChild(link);
    }
}

function llamar_datos_contadores_ppr()
{
    $.ajax({
        url: ruta_vistas_ppr + 'vista_datos_contadores.jsp',
        type: "post",
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            ocultar_ppr();
        }});
}

function datos_contadores_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_datos_contadores_huevos.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            mescon: $('#meslotec').val(),
            anocon: $('#anolotec').val(),
            avicon: $('#avic').val()
        },

        success: function (data) {
            var number = data.saldo_dias;
            $('#tabla_dato_c').html(data.grilladato);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            cerrar_load();

            if (!Object.keys(data.edad).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: 'No Existen Registros en:' + ' ' + $('#meslotec').val() + ' / ' + $('#anolotec').val() + ' ' + '; Aviario:' + ' ' + $('#avic').val(),
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 6000});
            } else {
                $(".ocultar").show();
            }
        }
    });

}
function contador_huevos_ppr(cant)
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_cargar_grilla_aviarios.jsp',
        data: {
            fecha1: $('#idfechadesde').val(),
            fecha2: $('#idfechahasta').val(),
            aviario: $('#avi').val()
        },
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        success: function (data) {
            var total_huevos = 0;
            var promedio = 0;
            var canti = 48;
            var cantidad = 0;
            $.each(data.filas, function (i, item)
            {
                //cantidad=$(item.id).html(decimal);
                const decimal = numeral(item.cantidad).format('0,0');
                $(item.id).html(decimal);
                $(item.id).css("background-color", item.color);
                //$(item.id).css("background-color",item.minimo1); 
                //$(item.id).addClass(item.color);
                //document.getElementById(item.id_sin).style.backgroundColor = 'red';  
                total_huevos = parseInt(total_huevos) + parseInt(item.cantidad);
                promedio = total_huevos / canti;
                cantidad = decimal;
            }

            );

            $("#huevos").val(numeral(total_huevos).format('0,0'));
            $("#promedio").val(numeral(Math.round(promedio)).format('0,0'));
            colorestext_ppr();
            if (cantidad === 0) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000})
            } else {
                $(".ocultar").show();
            }
            cerrar_load();
        }

    });
}

function resumen_detalle_huevos_ppr(name) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'generar_grilla_resumen_det_huevos.jsp',
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        data: {
            fecha1: $('#idfechadesde').val(),
            fecha2: $('#idfechahasta').val(),
            aviario: $('#avi').val(),
            fila1: name
        },

        success: function (data) {

            var grilla;
            grilla = (data.grillas);

            $('#idresumen_huevos').html(grilla);
            $('#contenido_row').html("");
            cerrar_load();
        }
    });
}

function limpiarg_ppr()
{

    $(".cero").html("0");
    $(".cero").css("background-color", "#828282");
    $("#promedio").css("background-color", "#828282");
    $("#maximo").css("background-color", "#828282");
    $("#minimo2").css("background-color", "#828282");
    $("#huevos").css("background-color", "#828282");
}
function limpiarm_ppr()
{

    $(".cerom").html("");
}
function colorestext_ppr()
{

    $("#promedio").css("background-color", "#007d3c");
    $("#promedio").css("color", "#ffffff");
    $("#maximo").css("background-color", "#007dff");
    $("#maximo").css("color", "#ffffff");
    $("#minimo2").css("background-color", "#ff0000");
    $("#minimo2").css("color", "#ffffff");
    $("#huevos").css("background-color", "#001f3f");
    $("#huevos").css("color", "#ffffff");
}

function max_min_ppr(cant) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_max.jsp',
        data: {
            fecha1: $('#idfechadesde').val(),
            fecha2: $('#idfechahasta').val(),
            aviario: $('#avi').val()
        },
        success: function (data) {

            var max = 0;
            var min = 0;
            $.each(data.filas13, function (i, item)
            {

                max = item.maximo;
                min = item.minimo;

            }
            );

            $("#maximo").val(numeral(max).format('0,0'));
            $("#minimo2").val(numeral(min).format('0,0'));
        }

    });
}
function max_min_inicio_ppr(cant) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_max_min.jsp',

        success: function (data) {

            var max = 0;
            var min = 0;
            $.each(data.filas14, function (i, item)
            {

                max = item.maximo;
                min = item.minimo;

            }
            );

            $("#maximo").val(numeral(max).format('0,0'));
            $("#minimo2").val(numeral(min).format('0,0'));
        }

    });
}

function confirmacion_ppr()
{

    $(".cero").html("0");
    $(".cero").css("background-color", "#828282");
    $("#promedio").css("background-color", "#828282");
    $("#maximo").css("background-color", "#828282");
    $("#minimo2").css("background-color", "#828282");
    $("#huevos").css("background-color", "#828282");
}
function contador_u_registro_ppr(cant) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_carga_grilla_aviarios_ultimo_registro.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr();
        },
        success: function (data) {

            $.each(data.filass, function (i, item)
            {
                const decimal = numeral(item.cantidad).format('0,0');
                $(item.id).html(decimal);
                //$(item.id).css("background-color",item.color); 
                $("#idfechadesde").val(item.fecha);
                $("#idfechahasta").val(item.fecha);
                $("#avi").val(item.aviario);
            }
            );
            llamar_ultimo_registro_ppr();
        }
    });
}
function ocultar_ppr()
{
    $(".ocultar").hide();
}
function mostrar_ppr()
{
    $(".ocultar").show();
}

function llamar_ultimo_registro_ppr() {
    $(document).ready(function () {
        $(".cargar").click();
    });
}

function contador_mortandad_ppr(avi) {

    $('#dl_edad').val("");
    $('#dl_saldoant').val("");
    $('#dl_mortpor').val("");
    $('#dl_saldo').val("");
    $('#prodpor').val("");
    $('#kg_bal').val("");
    $('#ave_bal').val("");
    $('#cons_agua').val("");
    $('#cons_agua_t').val("");

    $('#dl_muertos_normal').val("");
    $('#dl_muertos_prolapso').val("");
    $('#dl_muertos_livianos').val("");
    $('#dl_balkg1').val("");
    $('#dl_balkg2').val("");
    $('#dl_calcico').val("");
    $('#dl_caudal').val("");
    $('#dl_caudal2').val("");
    $('#dl_tempm2').val("");
    $('#dl_tempm1').val("");
    $('#dl_huevos').val("");
    $('#dl_transferin').val("");
    $('#dl_transferout').val("");
    $('#dl_ajuste').val("");
    $('#dl_venta').val("");
    $('#dl_anota').val("");
    $('#cons_agua_t').val("");
    $('#cons_agua').val("");
    $('#baltotal').val("");
    $('#dia_ant').val("");
    $('#total-muertos').val("");
    $('#edad_dias').val("");
    $('#id_datos').val("");


    lote = $('select option:selected').data('lote');
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_datos_mortandad.jsp',
        data: {
            fecha: $('#idfecham').val(),
            aviario: $('#avis').val()
        },
        beforeSend: function (xhr) {
            limpiarm_ppr(), cargar_load("Consultando...");
            ;
        },
        success: function (data) {
            var total_muertes = 0;
            $.each(data.filas, function (i, item)
            {
                $(item.id).html(item.cantidad);

                var nodo = document.getElementById(item.fila);
                valor = nodo.getAttribute("valor");
                if (item.fila === "") {

                } else {
                    var a = document.createAttribute("mor_id");
                    a.value = item.mor_id;
                    nodo.setAttributeNode(a);
                }


                total_muertes = parseInt(total_muertes) + parseInt(item.cantidad);
            }

            );

            cerrar_load();

            if (!Object.keys(data.fecha_anterior).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No existen registros en el dia anterior, por favor registre",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {

                $(".ocultar").show();
                $("#total-morfilas2").val(total_muertes);
                $("#lote").val(data.lote);
                $("#avi").val(data.aviario);
                $("#id_datos").val(data.id_datos);
                registro_diario_mecanizado_resumen_ppr(data.id_datos);
                onchange_datos_diarios_ppr();

            }


        }

    });
}

function contador_mortandad_ppr2(avi) {

    id_datos = $('#id_datos').val(),
            fecha = $('#idfecham').val(),
            aviario = $('#avis').val(),
            lote = $('select option:selected').data('lote');
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_datos_mortandad.jsp',
        data: {
            fecha: $('#idfecham').val(),
            aviario: $('#avis').val()
        },
        beforeSend: function (xhr) {
            limpiarm_ppr(), cargar_load("Consultando...");
            ;
        },
        success: function (data) {
            var total_muertes = 0;
            $.each(data.filas, function (i, item)
            {
                $(item.id).html(item.cantidad);

                var nodo = document.getElementById(item.fila);
                valor = nodo.getAttribute("valor");
                if (item.fila === "") {

                } else {
                    var a = document.createAttribute("mor_id");
                    a.value = item.mor_id;
                    nodo.setAttributeNode(a);
                }


                total_muertes = parseInt(total_muertes) + parseInt(item.cantidad);
            }

            );

            cerrar_load();

            if (!Object.keys(data.fecha_anterior).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No existen registros en el dia anterior, por favor registre",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {

                $(".ocultar").show();
                $("#total-morfilas2").val(total_muertes);
                $("#lote").val(data.lote);
                $("#avi").val(data.aviario);
                $("#id_datos").val(data.id_datos);
                registro_diario_mecanizado_resumen_ppr();
                onchange_datos_diarios_ppr();

            }


        }

    });
}

function crud_insert_datos_diarios_ppr(fecha, aviario, lote) {
    dl_edad = $('#dl_edad').val();
    saldoant = $('#dl_saldoant').val();
    edad_dias = $('#edad_dias').val();
    $.ajax({

        type: "post",
        url: ruta_cruds_ppr + "crud_agregar_datos_diarios.jsp",
        data: {
            fecha: fecha,
            lote: lote,
            aviario: aviario,
            dl_edad: dl_edad,
            saldoant: saldoant,
            edad_dias: edad_dias
        },
        success: function (data) {
            $('#id_datos').val(data.id_datos);
            onchange_datos_diarios_ppr();



        }});
}







function registro_diario_mecanizado_resumen_ppr(id_datos) {

    var lote = $('select option:selected').data('lote');
    var aviario = $('#avis').val();
    var fecha = $('#idfecham').val();
    $('#lote_registro').val(lote);
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_aviarios_mecanizados_resumen.jsp',
        data: {
            fecha: fecha,
            aviario: aviario

        },
        success: function (data) {



            $.each(data, function (i, item)
            {
                var total_mor = $("#total-morfilas2").val();
                $('#dl_edad').val(data.sems);
                $('#dl_saldoant').val(data.saldoant);
                $('#dl_mortpor').val(data.mor);
                $('#dl_saldo').val(data.saldoini2);
                if (data.saldoini2 === "" || data.saldoini2 === "0") {
                    $('#dl_saldo').val(data.saldoant);
                }
                $('#prodpor').val(data.prodpor);
                $('#kg_bal').val(data.kg);
                $('#ave_bal').val(data.gr_ave);
                $('#cons_agua').val(data.sems);
                $('#cons_agua_t').val(data.sems);

                $('#dl_muertos_normal').val(data.normal);
                $('#dl_muertos_prolapso').val(data.prolapso);
                $('#dl_muertos_livianos').val(data.livianos);
                $('#dl_balkg1').val(data.silo1);
                $('#dl_balkg2').val(data.silo2);
                $('#dl_calcico').val(data.calcico);
                $('#dl_caudal').val(data.caudal1);
                $('#dl_caudal2').val(data.caudal2);
                $('#dl_tempm2').val(data.tmin);
                $('#dl_tempm1').val(data.tmax);
                $('#dl_huevos').val(data.cant);
                $('#dl_transferin').val(data.ti);
                $('#dl_transferout').val(data.ts);
                $('#dl_ajuste').val(data.aj);
                $('#dl_venta').val(data.ve);
                $('#dl_anota').val(data.notas);
                $('#cons_agua_t').val(data.ml_ave);
                $('#cons_agua').val(data.litros);
                $('#baltotal').val(data.totalbalanceados);
                $('#dia_ant').val(data.dia_ant);
                $('#total-muertos').val(data.totalm);
                $('#id_datos').val(data.id_datos);
                $('#edad_dias').val(data.dias);


            });

            cerrar_load();
            if (data.id_datos === "" || data.id_datos === "0") {
                crud_insert_datos_diarios_ppr(fecha, aviario, lote);

            }

        }
    });
}

function modal_agregar_lote_ppr(aviario) {
    
    $('#aviario_lote').val(aviario);
    $("#agregar_lote_aviario").modal("show");
}

function modal_desactivar_lote_ppr(aviario, lote, ultimo_registro) {

    $('#fecha_ultimo').val(ultimo_registro);
    $('#lote_desac').val(lote);
    $('#aviario_desac').val(aviario);
    $("#desactivar_lote_aviario").modal("show");
}

function desactivar_lote_ppr() {
    Swal.fire({
        title: 'Comfimacion',
        text: "Enviar Peticion?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Desactivar lote!',
        cancelButtonText: 'No, cancelar!'}).then((result) =>
    {
        if (result.value)
        {
            var fecha = $('#fecha_desac').val();
            ;
            var lote = $('#lote_desac').val();
            ;
            var aviario = $('#aviario_desac').val();
            ;

            $.ajax({

                type: "post",
                url: ruta_cruds_ppr + "crud_desactivar_aviario_lote.jsp",
                data: {
                    fecha: fecha,
                    lote: lote,
                    aviario: aviario

                },
                success: function (res) {

                    if (res.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR",

                        });

                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                    $('#desactivar_lote_aviario').modal('hide');
                }});
        }
    });
}





function limpiar_ppr(data) {

    $.each(data.filas, function (i, item)
    {
        $(item.id).html("");
    }
    );
}

function enviar_fecha_avi_ppr(avi) {
    var aviario = avi;
    var fecha = $('#idfechad');
    abrir_ppr(aviario, fecha);
}
function abrir_ppr(aviario, fecha) {
    $.ajax({

        type: "post",
        url: 'grillas/grilla_registro_diario_aviarios_mecanizados.jsp',
        success: function (data) {
            $('#avis').val(aviario);
            $('#idfecham').val(fecha);

        }});
}


function onSelect_mortandad_grilla_ppr() {
    var editables = document.querySelectorAll("[contentEditable]");
    for (var i = 0, len = editables.length; i < len; i++) {

        editables[i].setAttribute("valor", editables[i].innerHTML);
        editables[i].setAttribute("valor", 0);

        editables[i].onfocus = function () {
            celda_editable_selectElement_ppr(this);
        };

        editables[i].onblur = function ()
        {

            if (this.innerHTML == this.getAttribute("valor"))
            {

            } else
            {
                var id_datos = $("#id_datos").val();
                var sum = 0;
                $(".cerom").each(function () {
                    sum += +$(this).val();
                });
                $("#total-morfilas2").val(sum);

                this.setAttribute("valor", this.innerHTML);
                var valor_viejo = this.getAttribute("valor");
                var id_mor = this.getAttribute("mor_id");
                var total_mor = $("#total-morfilas2").val();
                var fecha = $("#idfecham").val();
                var aviario = $("#avis").val();
                var saldo = $("#dl_saldoant").val();

                {
                    this.setAttribute("valor", this.innerHTML);
                    var valor = this.getAttribute("valor");
                    var regex = /<br\s*[\/]?>/gi;
                    valor = valor.replace(regex, "");

                    var lote = $("#lote_registro").val();
                    var fila = this.getAttribute("id");
                    var suma_nueva = parseInt(valor) + parseInt(total_mor);

                    var sum = 0;
                    $(".cerom").each(function () {
                        var value = $(this).text();
                        if (!isNaN(value) && value.length != 0) {
                            sum += parseFloat(value);
                        }
                    });
                    $('#total-morfilas2').val(sum);
                    nuevo_saldo = parseInt(saldo) - parseInt(sum);
                    $("#dl_saldo").val(nuevo_saldo);

                    crud_insert_mortandad_ppr(fecha, lote, fila, valor, aviario, id_datos, sum);
                }
            }

        };
    }
}


function onchange_datos_diarios_ppr() {
    var inputs = document.querySelectorAll("[data]");
    for (var i = 0, len = inputs.length; i < len; i++) {
        inputs[i].setAttribute("valor", inputs[i].innerHTML);

        var dl_balkg1 = 0;
        var dl_balkg2 = 0;
        $(".avi-input").focus(function () {
            $(this).select();
        });

        inputs[i].onblur = function () {
            this.setAttribute("valor", this.innerHTML);
            var id_datos = $("#id_datos").val();
            var campo = this.getAttribute("id");
            var valor = document.getElementById(campo).value;
            crud_update_datos_diarios(id_datos, campo, valor);
            var saldo_ant = $("#dl_saldoant").val();
            if (campo == "dl_balkg2" || campo == "dl_balkg1") {
                dl_balkg1 = $("#dl_balkg1").val();
                dl_balkg2 = $("#dl_balkg2").val();
                suma = parseInt(dl_balkg1) + parseInt(dl_balkg2);
                $('#baltotal').val(suma);
                $('#kg_bal').val(suma);
                campo = 'kg_bal';
                campo2 = 'dl_balave';
                bal_xave = ((parseInt(suma) / parseInt(saldo_ant)) * 1000).toFixed(1);
                $('#ave_bal').val(bal_xave);

            }

            if (campo == "dl_caudal") {
                var dl_caudal = $("#dl_caudal").val();
                var dia_ant = $("#dia_ant").val();
                suma_agua = (parseInt(dl_caudal)) - (parseInt(dia_ant));
                campo = 'dl_litros';
                $('#cons_agua').val(suma_agua);
                agua_ave = (((parseInt(suma_agua)) / (parseInt(saldo_ant))) * 1000).toFixed(1) + "mL/ave";
                $('#cons_agua_t').val(agua_ave);
                crud_update_datos_diarios(id_datos, campo, suma_agua);
            }
            if (campo == "dl_transferin") {
                var ingreso = $("#dl_transferin").val();
                var saldo = $("#dl_saldo").val();
                var total_muerte = $("#total-morfilas2").val();
                campo = 'dl_transferin';
                saldo_nuevo = ((parseInt(saldo)) + (parseInt(ingreso)));
                $('#dl_saldo').val(saldo_nuevo);
                //crud_update_datos_diarios (id_datos,campo,suma_agua);
            }
            if (campo == "dl_transferout") {
                var egreso = $("#dl_transferout").val();
                var saldo = $("#dl_saldo").val();
                var total_muerte = $("#total-morfilas2").val();
                campo = 'dl_transferin';
                saldo_nuevo = ((parseInt(saldo)) - (parseInt(egreso)));
                $('#dl_saldo').val(saldo_nuevo);
                //crud_update_datos_diarios (id_datos,campo,suma_agua);
            }
            if (campo == "dl_ajuste") {
                var egreso = $("#dl_ajuste").val();
                var saldo = $("#dl_saldo").val();
                var total_muerte = $("#total-morfilas2").val();
                campo = 'dl_transferin';
                saldo_nuevo = ((parseInt(saldo)) - (parseInt(egreso)));
                $('#dl_saldo').val(saldo_nuevo);
                //crud_update_datos_diarios (id_datos,campo,suma_agua);
            }
            if (campo == "dl_venta") {
                var egreso = $("#dl_venta").val();
                var saldo = $("#dl_saldo").val();
                var total_muerte = $("#total-morfilas2").val();
                campo = 'dl_transferin';
                saldo_nuevo = ((parseInt(saldo)) - (parseInt(egreso)));
                $('#dl_saldo').val(saldo_nuevo);
                //crud_update_datos_diarios (id_datos,campo,suma_agua);
            }

        };


    }
}


function crud_update_datos_diarios(id_datos, campo, valor) {
    var aviario = $('#avis').val();
    $.ajax({

        type: "post",
        url: ruta_cruds_ppr + "crud_update_datos_diarios.jsp",
        data: {
            id_datos: id_datos,
            campo: campo,
            valor: valor
        },
        success: function (data) {
            // actualizar_contador_mortandad_ppr(fecha,aviario,id_datos);



        }});
}






function crud_insert_mortandad_ppr(fecha, lote, fila, cantidad, aviario, id_datos, sum) {
    $.ajax({

        type: "post",
        url: ruta_cruds_ppr + "crud_agregar_mortandad.jsp",
        data: {
            fecha: fecha,
            lote: lote,
            fila: fila,
            cantidad: cantidad,
            aviario: aviario,
            sum: sum
        },
        success: function (data) {


        }});
}



function onselect_datos_diarios_predescarte_ppr() {
    var editables = document.querySelectorAll("[contentEditable]");
    for (var i = 0, len = editables.length; i < len; i++) {
        editables[i].setAttribute("valor", editables[i].innerHTML);

        var dl_balkg1 = 0;
        var dl_balkg2 = 0;

        editables[i].onfocus = function () {
            celda_editable_selectElement_ppr(this);
        };

        editables[i].onblur = function () {
            if (this.innerHTML == this.getAttribute("valor"))
            {

            } else
            {
                this.setAttribute("valor", this.innerHTML);
                var id_datos =this.getAttribute("id_datos");
                var campo    = this.getAttribute("id");
                var valor    = this.getAttribute("valor");
                crud_update_datos_diarios(id_datos, campo, valor);
               // var saldo_ant = $("#dl_saldoant").val();
              
                if (campo == "dl_ajuste") {
                    var egreso = $("#dl_ajuste").val();
                    var saldo = $("#dl_saldo").val();
                    var total_muerte = $("#total-morfilas2").val();
                    campo = 'dl_transferin';
                    saldo_nuevo = ((parseInt(saldo)) - (parseInt(egreso)));
                    $('#dl_saldo').val(saldo_nuevo);
                    //crud_update_datos_diarios (id_datos,campo,suma_agua);
                }
                if (campo == "dl_venta") {
                    var egreso = $("#dl_venta").val();
                    var saldo = $("#dl_saldo").val();
                    var total_muerte = $("#total-morfilas2").val();
                    campo = 'dl_transferin';
                    saldo_nuevo = ((parseInt(saldo)) - (parseInt(egreso)));
                    $('#dl_saldo').val(saldo_nuevo);
                    //crud_update_datos_diarios (id_datos,campo,suma_agua);
                }

            }
            ;
        };

    }
}
