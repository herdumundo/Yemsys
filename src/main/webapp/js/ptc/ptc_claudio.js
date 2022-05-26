var ruta_cruds_ptc = "./cruds/ptc/";
var ruta_consultas_ptc = "./consultas/ptc/";
var ruta_vistas_ptc = "./contenedores/ptc/";
var ruta_grilla_ptc = "./grillas/ptc/";
var ruta_vistas_general = "./contenedores/";

var serial2 = 0;
function grafico_clasificadora_dinamico_vista_ptc()
{

    $.ajax({
        url: ruta_vistas_ptc + "contenedor_clasificadora_dinamica.jsp",
        type: "post",
         beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
             $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            grafico_clasificadora_dinamico_ptc();
            cerrar_load();
        }});
}
function grafico_clasificadora_dinamico_ptc() {
    //window.location.hash = "ptcGraficoClasificadoraDinamico";
    $.ajax({
        url: ruta_vistas_ptc + "contenedor_clasificadora_dinamica.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");

            formato_multiselect();
            $('#form_reporte_dinamicop_clasificadora').on('submit', function (event)
            {
                event.preventDefault();
                consulta_clasificadora_dinamico_ptc("p");
                event.stopPropagation();

            });
            cerrar_load();
        }});

}
function consulta_clasificadora_dinamico_ptc(serial2)
{
    $.ajax({
        url: ruta_consultas_ptc + "consulta_reporte_clasificadora_dinamico.jsp",
        type: "post",
        data: $('#form_reporte_dinamicop_clasificadora').serialize(),
        
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (result)
        {
            var c = 0;
            $.each(result.charts_clasificadora, function (i, item)
            {
                var a = '  <div class="divinforme table table-bordered table-responsive order-column"style="width:100%;height:100%" >   ';
                a += '  <div class="card-header bg-navy" > ';
                a += '   <h3 class="card-title"> Clasificadora - Sumatoria por fecha </h3> ';
                a += '    <div class="card-tools"> ';

                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="C' + serial2 + '" style="  height: 30px; width: 100px; "></canvas>';

                a += '  </div> ';
                if (serial2 == "p") {
                    $("#div_graficop_clasificadora").html(a);
                } else {
                    $("#div2" + serial2).html(a);
                }
                var resChart = new Chart(document.getElementById("C" + serial2), result.charts_clasificadora[c]);
               
                
                 var b = '  <div class="divinforme table table-bordered table-responsive order-column"style="width:100%;height:100%" >   ';
                b += '  <div class="card-header bg-navy" > ';
                b += '   <h3 class="card-title"> Clasificadora - Sumatoria global por rango de fechas </h3> ';
                b += '    <div class="card-tools"> ';

                b += '  </div> ';
                b += '    </div> ';
                b += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                b += '   <canvas id="D' + serial2 + '" style="  height: 30px; width: 100px; "></canvas>';

                b += '  </div> ';
                if (serial2 == "p") {
                    $("#div_graficop_total").html(b);
                } else {
                    $("#div3" + serial2).html(b);
                }
                var resChart = new Chart(document.getElementById("D" + serial2), result.totales2[c]);
                c++;
                
                
            });
            cerrar_load();
  
        }
    });

}
function consulta_clasificadora_dinamico_ptc2(serial2)

{
    $.ajax({
        url: ruta_consultas_ptc + "consulta_reporte_clasificadora_dinamico_cuadros.jsp",
        type: "post",
        serial:serial2,
        data: $("#form_reporte_clasificadora_dinamico" + serial2).serialize(),
        
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (result)
        {
            $("#div_principal_clasificadora_grilla"+ serial2).html(result.grillas);
            var c = 0;
            $.each(result.charts_clasificadora, function (i, item)
            {
                var a = '  <div class="divinforme table table-bordered table-responsive order-column"style="width:100%;height:100%" >   ';
                a += '  <div class="card-header bg-navy" > ';
                a += '   <h3 class="card-title"> Sumatoria total ' + result.charts_clasificadora[c].options.plugins.title.text + '</h3> ';
                a += '    <div class="card-tools"> ';

                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="C' + serial2 + '" style="  height: 30px; width: 100px; "></canvas>';

                a += '  </div> ';
                if (serial2 == "p") {
                    $("#div_graficop_clasificadora").html(a);
                    $("#div_principal_clasificadora_grilla"+serial2)
                } else {
                    $("#div2" + serial2).html(a);
                }
                var resChart = new Chart(document.getElementById("C" + serial2), result.charts_clasificadora[c]);
                c++;
            });
            cerrar_load();
        }
    });

}

function generar_cuadros_consultas_clasificadora_dinamicos_ptc() {

    serial2++;
    var idcyo="'#datoscyo"+serial2+"'";
    var outerhtml="'outerHTML'";
    var html = '<div class="card card-warning "style="width:100%;height:100%">    <div class="card-header">   <center><h3 class="card-title"> Cuadro ' + serial2 + '</h3></center>    <div class="card-tools">    <button type="button" class="btn btn-tool" data-card-widget="collapse">      <i class="fas fa-minus"></i>     </button>     <button type="button" class="btn btn-tool"  data-card-widget="remove">        <i class="fas fa-times"></i>   </button>   </div>     </div>      <div class="card-body">\n\
            <form id="form_reporte_clasificadora_dinamico' + serial2 + '" type="post"> \n\
                <br>\n\
                <table class="table" > \n\
                    <thead> \n\
                        <tr class"divinforme table table-bordered table-responsive order-column"><th>DESDE</th> \n\
                            <th>HASTA</th> \n\
                            <th>CLASIFICADORA</th> \n\
                            <th>SERIE(%)</th> \n\
                            <th>TIPO GRAFICO</th> \n\
                            <th class="text-center" colspan="2">ACCIONES </th>\n\
                        </tr> \n\
                    </thead> \n\
                    <tbody> \n\
                        <tr> \n\
                            <td> <input type="date" value="' + $("#fecha_desde_cla").val() + '" id="fecha_desde_cla"  name="fecha_desde_cla"></td>\n\
                            \n\<input type="hidden" name="serial2" value="' + serial2 + '">\n\
                            <td> <input type="date"  value="' + $("#fecha_hasta_cla").val() + '" id="fecha_hasta_cla"   name="fecha_hasta_cla"></td>\n\
                            <td>\n\
                                <select class="selectpicker" multiple data-live-search="true" name="clasif_cla" required="true" data-actions-box="true"> \n\
                                    <option class="text-center" value="A">CCHA</option> \n\
                                    <option class="text-center" value="B">CCHB</option> \n\
                                    <option class="text-center" value="H">CCHH</option> \n\
                                    <option class="text-center" value="O">LAVADOS</option> \n\
                                    </select>\n\
                            </td>   \n\
                            <td>\n\
                                <select class="selectpicker" multiple data-live-search="true" name="categorias2_cla" required="true" data-actions-box="true"> \n\
                                    <option value=ptcc>PTC</option> \n\
                                    <option value=rpp>REPROCESO</option> \n\
                                    <option value=pii>SUBPRODUCTO</option>   \n\
                                    <option value=rr>ROTOS</option>   \n\
                                </select> \n\
                            </td>\n\
                            <td>\n\
                                <select name="tipo_grafico_cla" class="btn btn-sm bg-navy"> \n\
                                    <option class="text-center" value="line">Lineal</option> \n\
                                    <option class="text-center" value="bar">Barra</option> \n\
                                </select>\n\
                            </td>\n\
                            <td> \n\
                                 <button type="submit" class="btn btn-sm  bg-navy btn-block"  onclick="generar_serial_ptc(' + serial2 + ')"><i class="fa fa-search"></i></button>  \n\
                            </td>\n\
                            <td> \n\
                                 <button type="button" class="btn btn-sm  bg-navy btn-block" onclick="ExportToExcel_cyo_ptc(jQuery('+idcyo+').prop('+outerhtml+'))"><i class="fa fa-download"> Excel</i></button>  \n\
                            </td>\n\
                        </tr>\n\
                    </tbody> \n\
                </table> \n\
            </form>  <div id="div2' + serial2 + '"></div><div id="div3' + serial2 + '"></div><div id="div_principal_clasificadora_grilla' + serial2 + '"></div>  </div>';
    $("#div_principal_clasificadora").append(html);
    formato_multiselect();
    $('#form_reporte_clasificadora_dinamico' + serial2).on('submit', function (event)
    {
        event.preventDefault();

        consulta_clasificadora_dinamico_ptc2(serial2);
        event.stopPropagation();

    });

}

function generar_serial_ptc(serial_nuevo2) {
    serial2 = serial_nuevo2;
    
    
}

function ExportToExcel_cyo_ptc(htmlExport) {
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
        sa = iframeExport.document.execCommand("SaveAs", true, 'KPI_CYO' + '-' + $('#fecha_desde_cla').val() +''+ 'al' +''+ $('#fecha_hasta_cla').val() + ".xls");
    } else {
        var link = document.createElement('a');

        document.body.appendChild(link); // Firefox requiere que el enlace esté en el cuerpo
        link.download = ("SaveAs", true, 'KPI_CYO' + '-' + $('#fecha_desde_cla').val() +' '+ 'al' +' '+ $('#fecha_hasta_cla').val() + ".xls");
        link.href = 'data:application/vnd.ms-excel,' + escape(htmlExport);
        link.click();
        document.body.removeChild(link);
    }
}

