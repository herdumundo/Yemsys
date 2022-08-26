    function ir_pagina(pagina)
    {
            $.ajax({
                        type: "POST",
                        url: ruta_contenedores+pagina+"",
                        beforeSend: function() 
                        {
                            cargar_load();
                            $("#contenedor_principal").html("");
                        },           
                        success: function (res) 
                        {
                            $("#contenedor_principal").html(res);

                            cerrar_load()
                            cargar_estilo_calendario_insert("dd/mm/yyyy");
                            $('.datatable').DataTable(
                            {
                                paging: false,
                                responsive: true,
                                "autoWidth": false,
                                scrollCollapse: true,
                                "scrollX": true,
                                "ordering": false, 
                                bFilter: false,
                                dom: "Bfrtip",
                                "language":
                                {
                                    "sUrl": "js/Spanish.txt"
                                },
                                buttons: 
                                [
                                    {extend: "copyHtml5", text: "COPIAR GRILLA", header: false,footer:false,title: ''} 
                                ]
                            });
                            cerrar_load();
                         },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
              recargar_pagina();
             }
         }
                });  
    }
      
    function ir_menu_principal()
    {
         $.ajax({
                    type: "POST",
                    url: ruta_consultas+'generar_menu.jsp',
                    beforeSend: function() 
                    {
                        cargar_load("Consultando...")
                        $('#contenedor_principal').html("");    
                    },           
                    success: function (res) 
                    {
                        $("#contenido_modulos").html("");
                        $('#contenedor_principal').html(res.menu);  
                        cerrar_load()
                        
                        
        $('#div_cuadro_pedido').click(function(){
            ir_pedido(1); 
        });
         $('#div_cuadro_pedido_update').click(function(){
            ir_pagina('contenedor_pedidos_generados_menu.jsp');
        });
         $('#div_cuadro_pedido_rep').click(function(){
            
             ir_pagina('contenedor_reporte.jsp')    ;     
         });
         $('#div_cuadro_facturacion').click(function(){
             ir_pagina('contenedor_pedidos_facturar.jsp')    ;     
        });
         $('#div_cuadro_cyo').click(function(){
             ir_pagina('contenedor_pedidos_generados_cyo.jsp')    ;     
        });
                    },
                    error: function (error) 
                    {
                        cerrar_load();
                    }
                });  
    }  
    

    function ir_pedido(tipo,codigo,id_chofer)
    {
        $.ajax({
                type: "POST",
                url: ruta_contenedores+'contenedor_pedidos.jsp',
            beforeSend: function() 
            {
                $("#contenedor_principal").html("");
                reset_cero_variables_log();
            },           
            success: function (res) 
            {
                
                $("#contenedor_principal").html(res);
                if(tipo==5){
                    $("#titulo_menu").html("<center><b>INFORME STOCK CLASIFICADORAS</b></center>")
                    $("#modalActivate").html("Abrir ventana de stock")
                }
              generar_grilla_pedido_log(tipo,codigo);
                
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
              recargar_pagina();
             }
         }
            
                });  
    }
    
    function ir_pedido_modificar_logistica(tipo,codigo,codigo_camion,id_chofer)
    {
        $.ajax({
                type: "POST",
                url: ruta_contenedores+'contenedor_pedidos_modificar_logistica.jsp',
                data: ({id:codigo}),
            beforeSend: function() 
            {
                $("#contenedor_principal").html("");
                reset_cero_variables_log();
            },           
            success: function (res) 
            {
                
                $("#contenedor_principal").html(res);
                if(tipo==5){
                    $("#titulo_menu").html("<center><b>INFORME STOCK CLASIFICADORAS</b></center>")
                    $("#modalActivate").html("Abrir ventana de stock")
                }
                $("#id_pedido").val(codigo);
              generar_grilla_pedido_log(2,codigo,codigo_camion,id_chofer);
                
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
              
         } 
            
                });  
    } 
    
    
    
    function ir_pedido_cyo(id,id_chofer,id_camion)
    {
        $.ajax(
        {
            type: "POST",type: "POST",
            url: ruta_contenedores+'contenedor_pedidos_cyo.jsp',
            
            beforeSend: function() 
            {
                    cargar_load();
                $("#contenedor_principal").html("");
            },           
            success: function (res) 
            {
                $("#contenedor_principal").html(res);
                $("#id_chofer").val(id_chofer);
                $("#cbox_camion").val(id_camion);
                 $("#cbox_camion").prop('disabled', 'disabled'); 
                $("#id_pedido").val(id);
                generar_grilla_cyo_log(id,id_camion);
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });  
    }
    
    function ir_pedido_modificacion_porArea(id,id_chofer,id_camion,area)
    {
        $.ajax(
        {
            type: "POST",type: "POST",
            url: ruta_contenedores+'contenedor_pedidos_modificar_porArea.jsp',
            
            beforeSend: function() 
            {
                    cargar_load();
                $("#contenedor_principal").html("");
            },           
            success: function (res) 
            {
                $("#contenedor_principal").html(res);
                $("#id_chofer").val(id_chofer);
                $("#cbox_camion").val(id_camion);
                 $("#cbox_camion").prop('disabled', 'disabled'); 
                $("#id_pedido").val(id);
                generar_grilla_modificar_pedido_porArea_log(id,id_camion,area);
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });  
    }
    
     function generar_grilla_modificar_pedido_porArea_log(id,id_camion,area)
    {
        $.ajax(
        {
            type: "POST",
            url: ruta_consultas+'generar_grilla_preembarque_modificar_porArea.jsp',
            data:{id_pedido:id,id_camion:id_camion,area:area},
            beforeSend: function() 
            {
                $("#contenido_grilla").html("");
            },           
            success: function (res) 
            {
                $("#contenido_grilla").html(res.grilla);
                $("#huevos_cargados").val(res.huevos_cargados);
                $("#contenido_grilla_tipos").html(res.grilla_tipos);
                 
                 $("#tb_preembarque").DataTable(
                {
                        responsive: true,
                        scrollY: "547px",
                        scrollX: "500px",
                        paging: false,
                        "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        }
                });    /*   GENERA ERROR EN LAVADOS    */
                     grilla_funciones_cyo();
            },
            error: function (error) 
            {
                    
            }
        });  
    }
    
   function ir_stock_cyo()
    {
        $.ajax(
        {
            type: "POST",type: "POST",
            url: ruta_contenedores+'contenedor_pedidos_stock_cyo.jsp',
            beforeSend: function() 
            {
                    cargar_load();
                $("#contenedor_principal").html("");
            },           
            success: function (res) 
            {
                $("#contenedor_principal").html(res);
               
                generar_grilla_stock_cyo_log();
            },
            error: function (error) 
            {
                    
            }
        });  
    }    
    
    function generar_grilla_cyo_log(id,id_camion)
    {
        $.ajax(
        {
            type: "POST",
            url: ruta_consultas+'generar_grilla_preembarque_cyo.jsp',
            data:{id_pedido:id,id_camion:id_camion},
            beforeSend: function() 
            {
                $("#contenido_grilla").html("");
            },           
            success: function (res) 
            {
                $("#contenido_grilla").html(res.grilla);
                $("#huevos_cargados").val(res.huevos_cargados);
                $("#contenido_grilla_tipos").html(res.grilla_tipos);
                 
                 $("#tb_preembarque").DataTable(
                {
                        responsive: true,
                        scrollY: "547px",
                        scrollX: "500px",
                        paging: false,
                        "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        }
                });    /*   GENERA ERROR EN LAVADOS    */
                     grilla_funciones_cyo();
            },
            error: function (error) 
            {
                    
            }
        });  
    }
    
    
    
        function generar_grilla_stock_cyo_log()
    {
        $.ajax(
        {
            type: "POST",
            url: ruta_consultas+'generar_grilla_preembarque_stock_cyo.jsp',
            beforeSend: function() 
            {
                $("#contenido_grilla").html("");
            },           
            success: function (res) 
            {
                $("#contenido_grilla").html(res.grilla + res.grilla_mixto);
                    $("#tb_preembarque").DataTable(
                    {   
                        paging: false,
                        "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                   
                    });     
                    
                     $("#tb_preembarque_mixto").DataTable(
                    {   
                        paging: false,
                        "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                   
                    });   
                     grilla_funciones_cyo();
            },
            error: function (error) 
            {
                    
            }
        });  
    }
    
    
    
    
   function ir_stock_directorio_cyo()
    {
        $.ajax(
        {
            type: "POST",type: "POST",
            url: ruta_contenedores+'contenedor_pedidos_directorio.jsp',
            beforeSend: function() 
            {
                    cargar_load();
                $("#contenedor_principal").html("");
            },           
            success: function (res) 
            {
                $("#contenedor_principal").html(res);
               
                generar_grilla_stock_directorio_cyo();
            },
            error: function (error) 
            {
                    
            }
        });  
    }    
    
    
       
        function generar_grilla_stock_directorio_cyo()
    {
        $.ajax(
        {
            type: "POST",
            url: ruta_consultas+'generar_grilla_preembarque_directorio.jsp',
            beforeSend: function() 
            {
                $("#contenido_grilla").html("");
            },           
            success: function (res) 
            {
                $("#contenido_grilla").html(res.grilla);
                $("#contenido_grilla_mixto").html(res.grilla_mixto);
                $("#mensaje_div").html(res.mensaje_div);
                $("#cantidad_mensaje").html(res.cantidad_mensaje);
                ocultar_td_cyo_stock_directorio();
                
               $("#tb_preembarque").DataTable(
                {   
                         "ordering": false,
                    paging: false,
                    "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                         "autoWidth": false,
                        drawCallback: function () //SIRVE PARA QUE AL TIPEAR EL FILTRO SE EJECUTE
                        {
                                    sumar_grilla_tipos_directorio_logistica();
                        }
                });    
                
                $("#tb_preembarque_mixto").DataTable(
                {   
                    paging: false,
                    "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                }); 
                    cerrar_load();
  
            },
            error: function (error) 
            {
                    
            }
        });  
    }
    
 function ocultar_td_cyo_stock_directorio(){
      var columns = $("#tb_preembarque > tbody > tr:first > td").length;
                var ccha = 0;// 3 al 13
                var cchb = 0;//14 al 23
                var cchh = 0;//24 al 33
                var ovo = 0; //34 al 42
                var cyo = 0;//43 al 52
                for (var i = 3; i <= columns; )
                {
                    if ($("#tb_preembarque > tbody > tr > td:nth-child(" + i + ")").filter(function () {
                        return $(this).text() != 0;
                    }).length == 0)
                    {
                        var ing = 1 + i;
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + i + "), #tb_preembarque > thead > tr > th:nth-child(" + i + ")").hide();
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + ing + "), #tb_preembarque > thead > tr > th:nth-child(" + ing + ")").hide();

                        if (i >= 3 && i < 13) {
                            ccha = ccha + 2;
                        }
                        if (i >= 13 && i < 23) {
                            cchb = cchb + 2;
                        }
                        if (i >= 23 && i < 33) {
                            cchh = cchh + 2;
                        }
                        if (i >= 33 && i < 41) {
                            ovo = ovo + 2;
                        }
                        if (i >= 41 && i < 51) {
                            cyo = cyo + 2;
                        }
                        $("#th_ccha").show();
                        $("#th_cchb").show();
                        $("#th_cchh").show();
                        $("#th_ovo").show();
                        $("#th_cyo").show();

                    }
                    i = i + 2;
                }
                $("#th_ccha").attr('colspan', 10 - ccha);
                $("#th_cchb").attr('colspan', 10 - cchb);
                $("#th_cchh").attr('colspan', 10 - cchh);
                $("#th_ovo").attr('colspan', 8 - ovo);
                $("#th_cyo").attr('colspan', 10 - cyo);

                if (10 - ccha == 0) {
                    $("#th_ccha").hide();
                }
                if (10 - cchb == 0) {
                    $("#th_cchb").hide();
                }
                if (10 - cchh == 0) {
                    $("#th_cchh").hide();
                }
                if (8 - ovo == 0) {
                    $("#th_ovo").hide();
                }
                if (10 - cyo == 0) {
                    $("#th_cyo").hide();
                }
              
                 
                    
 }   
 
  function ir_pedidos_pendientes_log(){
       $.ajax(
        {
            type: "POST",
            url: ruta_contenedores+'contenedor_pedidos_pendientes.jsp',
            beforeSend: function() 
            {
                cargar_load("Cargando");
                $("#contenedor_principal").html("");
            },           
            success: function (res) 
            {
                $("#contenedor_principal").html(res); 
                $("#tabla_pedidos").DataTable(
                {   
                     "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                }); 
                
                 
                cerrar_load();
            },
            error: function (error) 
            {
                    
            }
        });  
  }





   function ir_pedido_log_vizualizacion_log(codigo)
    {
        $.ajax({
                type: "POST",
                url: ruta_consultas+'generar_grilla_preembarque_visualizacion.jsp',
                data: ({id:codigo}),
            beforeSend: function() 
            {
                $("#contenido_grillas").html("");
                $("#contenido_grillas_mixto").html("");
               
            },           
            success: function (res) 
            {
                
                $("#contenido_grillas").html(res.grilla);
                $("#contenido_grillas_mixto").html(res.grilla_mixto);
                 
             },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
              
         } 
            
                });  
    } 