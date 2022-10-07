var ruta_cruds_ptc = "./cruds/ptc/";
var ruta_consultas_ptc = "./consultas/ptc/";
var ruta_vistas_ptc = "./contenedores/ptc/";
var ruta_grilla_ptc = "./grillas/ptc/";
var ruta_vistas_general = "./contenedores/";

var serial2 = 0;
function grafico_clasificadora_dinamico_vista_ptc()
{

    $.ajax({
        url: ruta_vistas_ptc + "contenedor_indicadores_menu_ptc.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            // $('#tabla_opciones').DataTable(({bPaginate: !1,"ordering": !1,"searching": !1,"info":     !1})); 

            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }});
}

function ir_indicador_global_ptc() {

    $.ajax({
        url: ruta_vistas_ptc + "contenedor_indicador_ptc_global.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_indicadores').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");

            formato_multiselect();
            $('#form_reporte_dinamicop_clasificadora').on('submit', function (event)
            {
                event.preventDefault();
                consulta_clasificadora_dinamico_ptc("p");
                event.stopPropagation();

            });

            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }});
}


function ir_indicador_global_detallados_ptc() {

    $.ajax({
        url: ruta_vistas_ptc + "contenedor_indicador_ptc_global_detallado.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_indicadores').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");

            formato_multiselect();
            $('#form_indicadores_detallados').on('submit', function (event)
            {
                event.preventDefault();
                consulta_grafico_detallado_indicadores_ptc();
                event.stopPropagation();

            });

            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }});
}
 


function consulta_grafico_detallado_indicadores_ptc()
{
    var fecha_desde = $('#fecha_desde_cla').val();
    var fecha_hasta = $('#fecha_hasta_cla').val();
    var tipo_grafico = $('#tipo_grafico').val();
    
    
    
   // var select =  $('#clasif_cla').text();
    var clasificadoras_seleccionadas = $( "#clasif_cla option:selected" ).text();

    $.ajax({
        url: ruta_consultas_ptc + "consulta_grafico_detallado_indicadores_ptc.jsp",
        type: "post",
        data: $('#form_indicadores_detallados').serialize(),

        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (res)
        {
            var a = '  <div class="divinforme table table-bordered table-responsive order-column"style="width:25%;height:25%" >   ';
            a += '  <div class="card-header bg-navy" > ';
            a += '   <h3 class="card-title"> Indicador Global ' + fecha_desde + ' al ' + fecha_hasta + ' '+clasificadoras_seleccionadas+' </h3> ';
            a += '    <div class="card-tools"> ';
            a += '  </div> ';
            a += '    </div> ';
            a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
            a += ' <canvas style="width:25%;height:25%" id="myChart"></canvas>';
            a += '  </div></div>  ';
            a += '  <div class="divinforme table table-bordered table-responsive order-column"style="width:25%;height:25%" >   ';
            a += '  <div class="card-header bg-navy" > ';
            a += '   <h3 class="card-title">Subproductos ' + fecha_desde + ' al ' + fecha_hasta + ' '+clasificadoras_seleccionadas+'  </h3> ';
            a += '    <div class="card-tools"> ';
            a += '  </div> ';
            a += '    </div> ';
            a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
            a += ' <canvas style="width:25%;height:25%" id="chart2"></canvas>';
            a += '  </div></div>  ';
            a += '  <div class="divinforme table table-bordered table-responsive order-column"style="width:25%;height:25%" >   ';
            a += '  <div class="card-header bg-navy" > ';
            a += '   <h3 class="card-title">Reprocesos ' + fecha_desde + ' al ' + fecha_hasta + ' '+clasificadoras_seleccionadas+'   </h3> ';
            a += '    <div class="card-tools"> ';
            a += '  </div> ';
            a += '    </div> ';
            a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
            a += ' <canvas style="width:25%;height:25%" id="chart3"></canvas>';
            a += '  </div></div>  ';
            a += '  <div class="divinforme table table-bordered table-responsive order-column"style="width:25%;height:25%" >   ';
            a += '  <div class="card-header bg-navy" > ';
            a += '   <h3 class="card-title">PTC ' + fecha_desde + ' al ' + fecha_hasta + ' '+clasificadoras_seleccionadas+'   </h3> ';
            a += '    <div class="card-tools"> ';
            a += '  </div> ';
            a += '    </div> ';
            a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
            a += ' <canvas style="width:25%;height:25%" id="chart4"></canvas>';
            a += '  </div></div>  ';

            $("#div_graficop_clasificadora").html(a);

            const config = {
                type: tipo_grafico,
                data: {
                    labels: ['PTC', 'SUBPRODUCTOS', 'REPROCESOS', 'ROTOS'],
                    datasets:
                            [{
                                    label: 'Porcentaje',
                                    data: [res.PTC, res.SUBPRODUCTOS, res.REPROCESOS, res.ROTOS],
                                    backgroundColor:
                                            [
                                                'rgba(255, 26, 104, 0.2)',
                                                'rgba(54, 162, 235, 0.2)',
                                                'rgba(255, 206, 86, 0.2)',
                                                'rgba(0, 0, 0, 0.29)'

                                            ],
                                    borderColor:
                                            [
                                                'rgba(255, 26, 104, 1)',
                                                'rgba(54, 162, 235, 1)',
                                                'rgba(255, 206, 86, 1)',
                                                'rgba(75, 192, 192, 1)'

                                            ],
                                    borderWidth: 1
                                }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                },
                plugins: [ChartDataLabels]
            };
            // render init block
            const myChart = new Chart(
                    document.getElementById('myChart'),
                    config
                    );



            const config2 = {
                type: tipo_grafico,
                data: {
                    labels: ['FISURADOS', 'PS', 'FFC', 'OTROS', 'PM'],
                    datasets:
                            [{
                                    label: 'Porcentaje',
                                    data: [res.F, res.PS, res.FFC, res.OT, res.PM],
                                    backgroundColor:
                                            [
                                                'rgba(255, 26, 104, 0.2)',
                                                'rgba(0, 255, 17, 0.5)',
                                                'rgba(54, 162, 235, 0.2)',
                                                'rgba(255, 206, 86, 0.2)',
                                                'rgba(0, 0, 0, 0.29)'

                                            ],
                                    borderColor:
                                            [
                                                'rgba(255, 26, 104, 1)',
                                                'rgba(0, 255, 17, 0.99)',
                                                'rgba(54, 162, 235, 1)',
                                                'rgba(255, 206, 86, 1)',
                                                'rgba(75, 192, 192, 1)'

                                            ],
                                    borderWidth: 1
                                }]
                },

                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                },
                plugins: [ChartDataLabels]
            }

            const myChart2 = new Chart(
                    document.getElementById('chart2'),
                    config2
                    );




            const config3 = {
                type: tipo_grafico,
                data: {
                    labels: ['EC', 'S/S', 'S'],
                    datasets:
                            [{
                                    label: 'Porcentaje',
                                    data: [res.EC, res.SS, res.S],
                                    backgroundColor:
                                            [
                                                'rgba(255, 26, 104, 0.2)',
                                                'rgba(0, 255, 17, 0.5)',
                                                'rgba(54, 162, 235, 0.2)'

                                            ],
                                    borderColor:
                                            [
                                                'rgba(255, 26, 104, 1)',
                                                'rgba(0, 255, 17, 0.99)',
                                                'rgba(54, 162, 235, 1)',
                                            ],
                                    borderWidth: 1
                                }]
                },

                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                },
                plugins: [ChartDataLabels]
            }


            const myChart3 = new Chart(
                    document.getElementById('chart3'),
                    config3
                    );


            const config4 = {
                type: tipo_grafico,
                data: {
                    labels: ['A', 'GIGANTE', 'B', 'C', 'D', 'SUPER',  'JUMBO'],
                    datasets:
                            [{
                                    label: 'Porcentaje',
                                    data: [res.A,res.G,  res.B, res.C, res.D, res.SUPER, res.J],
                                    backgroundColor:
                                            [
                                                'rgba(255, 26, 104, 0.2)',
                                                'rgba(255, 157, 0, 0.81)',
                                                'rgba(0, 255, 17, 0.5)',
                                                'rgba(54, 162, 235, 0.2)',
                                                'rgba(0, 77, 255, 0.58)',
                                                'rgba(255, 206, 86, 0.2)',
                                                'rgba(0, 0, 0, 0.29)'

                                            ],
                                    borderColor:
                                            [
                                                'rgba(255, 26, 104, 1)',
                                                'rgba(255, 157, 0, 0.98)',
                                                'rgba(0, 255, 17, 0.99)',
                                                'rgba(54, 162, 235, 1)',
                                                'rgba(0, 77, 255, 0.97)',
                                                'rgba(255, 206, 86, 1)',
                                                'rgba(75, 192, 192, 1)'

                                            ],
                                    borderWidth: 1
                                }]
                },

                options: {
        plugins: {
            legend: {
                labels: {
                    // This more specific font property overrides the global property
                    font: {
                        size: 14
                    }
                }
            }
        }
    },
        plugins: [ChartDataLabels],
     
                
            }



            const myChart4 = new Chart(
                    document.getElementById('chart4'),
                    config4);

           $("#div_grilla_detalle").html(res.grilla);
            $("#tb_grilla").DataTable({
                "scrollX": true,
                dom: "Bfrtip",
                ordering: false,
                responsive: true,
                "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },

                columnDefs: [{
                        targets: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35],
                        className: 'bolded'
                    }
                ],
                buttons: [
                    {extend: "copyHtml5", text: "COPIAR GRILLA", exportOptions: {columns: [0, ":visible"]}},
                    {extend: "excelHtml5", title: "INDICADORES CYO " + fecha_desde + " AL " + fecha_hasta+ " "+clasificadoras_seleccionadas, text: "EXCEL", exportOptions: {columns: ":visible"}},
                     
                    "colvis",
                ],
                keys: {clipboard: !1},
            });

 
            cerrar_load();
        }
    });

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

            //formato_multiselect();
            $('#form_reporte_dinamicop_clasificadora').on('submit', function (event)
            {
                event.preventDefault();
                consulta_clasificadora_dinamico_ptc("p");
                event.stopPropagation();

            });
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
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
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}
function consulta_clasificadora_dinamico_ptc2(serial2)
{
    $.ajax({
        url: ruta_consultas_ptc + "consulta_reporte_clasificadora_dinamico_cuadros.jsp",
        type: "post",
        serial: serial2,
        data: $("#form_reporte_clasificadora_dinamico" + serial2).serialize(),

        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (result)
        {
            $("#div_principal_clasificadora_grilla" + serial2).html(result.grillas);
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
                    $("#div_principal_clasificadora_grilla" + serial2)
                } else {
                    $("#div2" + serial2).html(a);
                }
                var resChart = new Chart(document.getElementById("C" + serial2), result.charts_clasificadora[c]);
                c++;
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

function generar_cuadros_consultas_clasificadora_dinamicos_ptc() {

    serial2++;
    var idcyo = "'#datoscyo" + serial2 + "'";
    var outerhtml = "'outerHTML'";
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
                                 <button type="button" class="btn btn-sm  bg-navy btn-block" onclick="ExportToExcel_cyo_ptc(jQuery(' + idcyo + ').prop(' + outerhtml + '))"><i class="fa fa-download"> Excel</i></button>  \n\
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
        sa = iframeExport.document.execCommand("SaveAs", true, 'KPI_CYO' + '-' + $('#fecha_desde_cla').val() + '' + 'al' + '' + $('#fecha_hasta_cla').val() + ".xls");
    } else {
        var link = document.createElement('a');

        document.body.appendChild(link); // Firefox requiere que el enlace esté en el cuerpo
        link.download = ("SaveAs", true, 'KPI_CYO' + '-' + $('#fecha_desde_cla').val() + ' ' + 'al' + ' ' + $('#fecha_hasta_cla').val() + ".xls");
        link.href = 'data:application/vnd.ms-excel,' + escape(htmlExport);
        link.click();
        document.body.removeChild(link);
    }
}

