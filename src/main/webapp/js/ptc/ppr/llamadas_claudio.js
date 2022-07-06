 
var ruta_cruds_ppr = "./cruds/ppr/";
var ruta_consultas_ppr = "./consultas/ppr/";
var ruta_vistas_ppr = "./contenedores/contenedores_ppr/";


///AJAX REGISTROS

  
  
   
 
    function ir_informes_ppr() 
    {
    direccion = "1";
    $.ajax({
        type: "POST",
        url: ruta_vistas_ppr + 'vista_informes.jsp',
        beforeSend: function ()
        {
            $('#div_cargar_menu').show();
            $('#contenido_row').html('');
            $('#contenedor_principal').html('');
            $('#contenido').html('');

        },
        success: function (res)
        {
            $('#contenido_row').html(res);

             $('#div_informe_mortandad').click(function () {
                grafico_mortandad_ppr();
            });
            $('#div_informe_huevos').click(function () {
                grilla_huevos_ppr();
            });
            $('#div_informe_muerte').click(function () {
                grilla_muertes_ppr();
            });
           
        }
    });

    }
     
    function grafico_aviarios_general_ppr()
    {
        $.ajax({
        type: "POST",
        url: ruta_consultas_ppr+'consulta_chart_general.jsp',
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (result) 
        {     
            var c=0;
            $.each(result.charts,function(i, item)
            {
            var a =     '  <div class="card card-navy" >   ' ;
                a +=    '  <div class="card-header"> ' ;
                a +=    '   <h3 class="card-title">Resumen de Aviario - '+result.charts[c].options.plugins.title.text+'</h3> ' ;
                a +=    '    <div class="card-tools"> ' ;
                a +=    '    <button type="button" class="btn btn-tool" data-card-widget="collapse"> ' ;
                a +=    '     <i class="fas fa-minus"></i> ' ;
                a +=    '    </button> ' ;
                a +=    '   <button type="button" class="btn btn-tool" onclick="cerrar_resumen()" data-card-widget="remove"> ' ;
                a +=    '     <i class="fas fa-times"></i> ' ;
                a +=    '  </button> ' ;
                a +=    '  </div> ' ;
                a +=    '    </div> ' ;
                a +=    ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ' ;
                a +=    '   <canvas id="' +result.charts[c].options.plugins.title.text+ '"></canvas>' ;
                a +=    ' <button class="btn btn-sm   btn-secondary float-right" id="btnzoom" onclick="grafico_zoom_menu_principal_ppr( ' +"'" +result.charts[c].options.plugins.title.text+ '\')" type="button"  ><i class="fa fa-search-plus"></i></button></div> ' 
                a +=    '  </div> ' ;
          
                
                if(result.charts[c].options.plugins.title.text.charAt(0)=="A")
                {
                    $("#divA").append(a);
                }
                else if (result.charts[c].options.plugins.title.text.charAt(0)=="B")
                {
                    $("#divB").append(a);
                }
                else 
                {
                    $("#divH").append(a);
                }         
                
                var resChart = new Chart(document.getElementById(result.charts[c].options.plugins.title.text), result.charts[c]);
                c++;       
            });       
            cerrar_load();
        }
      }); 
       
    }

    function grafico_mortandad_ppr() 
    {
        window.location.hash = "pprGraficoMortandad";
        $.ajax({
            url: ruta_vistas_ppr+"vista_informe_aviarios.jsp",
            type: "post",
            success: function (data) {
                $('#contenedor_principal').html(data);
                $('#contenido_row').html("");
                grafico_aviarios_general_ppr();
                 temperatura_ppr();
            }});
    }
    
    function grilla_huevos_ppr() 
    {
        window.location.hash = "pprGrillaHuevos";
        $.ajax({
                url: ruta_vistas_ppr+"vista_grilla_contadores_de_huevos.jsp",
                type: "post",
                 beforeSend: function (xhr) {
              cargar_load(); },
                success: function (data) {
                    $('#contenedor_principal').html(data);
                    $('#contenido_row').html("");
                    contador_u_registro_ppr();
                    //  $('#select_modulos').selectpicker();
                    cerrar_load();
                }});
    }

 
 
 