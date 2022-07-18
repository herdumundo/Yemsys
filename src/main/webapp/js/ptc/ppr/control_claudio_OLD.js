var ruta_consultas_ppr = "./consultas/ppr/";
var ruta_vistas_ppr = "./contenedores/contenedores_ppr/";
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
    window.location.hash = "pprAviarioFecha";

    $.ajax({
        url: ruta_vistas_ppr + "/vista_registro_de_datos_diarios_A.jsp",
        type: "post",
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            
            contador_u_registro_datos_diarios_ppr()
        }
        
    });
}
function carga_aviario_fecha_ppr(avia){
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_cargar_aviario_fecha.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), 
            cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),
            avia:avia
            //agregar aca avia y fecha
    
        },

        success: function (data) {
            $('#tabla_datos_diarios').html(data.grilla_datos_diarios);
            $('#avi').html(data.grilla_datos_diarios);
            $('#idfecham').val(data.fecha1);
            $('#avis').val(data.avia);
            
            $('#contenido_row').html("");
            cerrar_load();
            
            $(window).ready(function(){
            $('#idfecham').trigger('change');
            $('#avis').trigger('change');
            });
        }
    });

}
function carga_aviario_fecha_B_ppr(avia){
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_cargar_aviario_fecha_B.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),
            avia:avia
    //agregar aca avia y fecha
    
        },

        success: function (data) {
            $('#tabla_datos_diarios').html(data.grilla_datos_diarios);
            $('#avi').html(data.grilla_datos_diarios);
            $('#idfecham').val(data.fecha1);
            $('#avis').val(data.avia);
            
            $('#contenido_row').html("");
            cerrar_load();
            
            $(window).ready(function(){
            $('#idfecham').trigger('change');
            $('#avis').trigger('change');
});
        }
    });

}
function carga_grilla_registro_datos_diarios_A_ppr(avia) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_datos_diario_A.jsp',
        beforeSend: function (xhr) {
            limpiarg_ppr(), 
                    cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),
            avia:$('#avis2').val(),
    //agregar aca avia y fecha
    
        },

        success: function (data) {
            $('#tabla_datos_diarios').html(data.grilla_datos_diarios);
            $('#avi').html(data.grilla_datos_diarios);
            $('#idfecham').val(data.fecha1);
            $('#avis').val(data.avia);
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
            carga_grilla_registro_datos_diarios_B_ppr()
        }
    });

}
function contador_u_registro_datos_diarios_ppr(cant) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr+"consulta_carga_ultimo_registro_grilla_registro_datos_diarios.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr();
        },
        success: function (data) {

                //$(item.id).css("background-color",item.color); 
                $("#idfechad").val(data.fecha);
                $(window).ready(function(){
                $('#idfechad').trigger('change');
        });
        
        }
    });
}

function carga_grilla_registro_datos_diarios_B_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_datos_diarios_B.jsp',

        data: {
            idfechad: $('#idfechad').val()
        },

        success: function (data) {
            $('#tabla_datos_diariosb').html(data.grilla_datos_diariosb);
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

function dd_mec2_ppr() {
    var f = $("#idfecha").val();
    $.ajax({
        url: ruta_vistas_ppr + '/vista_registro_diario_aviarios_mecanizados.jsp',
        type: "post",
        success: function (data) {
            
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            //registro_diario_mecanizado_resumen();

        }});
}
 
 
function llamar_mortandad_lotes_ppr()
{
    window.location.hash = "pprMortandadLotes";
    $.ajax({
        url: ruta_vistas_ppr + 'vista_mortandad_lotes.jsp',
        type: "post",
         beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            ocultar_ppr();
            cerrar_load();
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
     window.location.hash = "pprDatosContadores";
    $.ajax({
        url: ruta_vistas_ppr + 'vista_datos_contadores.jsp',
        type: "post",
         beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            ocultar_ppr();
            cerrar_load();
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
        url: ruta_consultas_ppr+"consulta_carga_grilla_aviarios_ultimo_registro.jsp",
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
                total_muertes = parseInt(total_muertes) + parseInt(item.cantidad);
            }
            );
            $("#total-morfilas2").val(total_muertes);
            cerrar_load();
            registro_diario_mecanizado_resumen_ppr()
        }

    });
}
function registro_diario_mecanizado_resumen_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registro_aviarios_mecanizados_resumen.jsp',
        data: {
            fecha: $('#idfecham').val(),
            aviario: $('#avis').val()
        },
        success: function (data) {
            $.each(data, function (i, item)
            {
                $('#dl_edad').val(data.sems);
                $('#dl_saldoant').val(data.saldoant);
                $('#dl_mortpor').val(data.mor);
                $('#dl_saldo').val(data.saldo);
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
                $('#cons_agua_t').val(data.litros);
                $('#cons_agua').val(data.litros);
                $('#baltotal').val(data.totalbalanceados);
                $('#dia_ant').val(data.dia_ant);

                $('#total-muertos').val(data.totalm);
            });
            cerrar_load();
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

function enviar_fecha_avi_ppr(avi){
    var aviario=avi;
    var fecha=$('#idfechad');
    abrir_ppr(aviario,fecha);
}
function abrir_ppr(aviario,fecha){
    $.ajax({
  
        type: "post",
        url: 'grillas/grilla_registro_diario_aviarios_mecanizados.jsp',
        success: function (data) {
            $('#avis').val(aviario);
             $('#idfecham').val(fecha);

        }});
}
function ppr_dd_mec3(avi) {
    var f = $("#idfechad").val();
    loader();
    $.post("grillas/grilla_registro_diario_aviarios_mecanizados.jsp", {avi: avi, f: f}, function (res) {
        $("#contenido").html(res);
        $("#avis").on("change", function () {
            ppr_dd_mec3($(this).val());
        });
        var lote = $("#lote").val();
        $("#idfechad")
                .datepicker({autoclose: true, format: "dd/mm/yyyy", language: "es"})
                .change(function () {
                    var a = $("#avis").val();
                    registro_diario_mecanizado_resumen(a);
                });
        
        closeLoader();
    });
}
function ppr_dd_mec_onSelect() {
    var editables = document.querySelectorAll("[contentEditable]");
    for (var i = 0, len = editables.length; i < len; i++) {
        editables[i].setAttribute("data-orig", editables[i].innerHTML);
        editables[i].onfocus = function () {
            celda_editable_selectElement(this);
        };
        editables[i].onblur = function () {
            if (this.innerHTML == this.getAttribute("data-orig")) {
                this.innerHTML = this.getAttribute("data-orig");
            } else {
                this.setAttribute("data-orig", this.innerHTML);
                var valor = this.getAttribute("data-orig");
                var regex = /<br\s*[\/]?>/gi;
                valor = valor.replace(regex, "");
                var fecha = $("#fecha").val();
                var avi = $("#avi").val();
                var lote = $("#lote").val();
                var campo = this.getAttribute("campo");
                if (campo == "mor") {
                    var fila = this.getAttribute("fila");
                    ppr_dd_mec_regmor(fecha, avi, lote, fila, valor);
                }
            }
        };
    }
}
function ppr_dd_mec_regmor(fecha, avi, lote, fila, valor) {
    var mf = $("#total-morfilas").html();
    var tm = $("#total-muertos").html();
    $.post("apps/ppr/dd/dd.mec.morfila.php", {fecha: fecha, avi: avi, lote: lote, fila: fila, valor: valor}, function (j) {
        $("#saldo").html(j.saldo);
        $("#total-muertos").html(j.muertos);
        $("#total-morfilas").html(j.muertos);
        $("#pmort").html(j.pmort);
        if (j.mornoclas > 0) {
            $("#mornoclas").html(j.mornoclas).addClass("bg-red");
            $("#total-muertos").addClass("bg-red");
        } else {
            $("#total-muertos").removeClass("bg-red");
            $("#mornoclas").html(j.mornoclas).removeClass("bg-red");
        }
        $("#mlave").html(j.mlave);
    });
}


