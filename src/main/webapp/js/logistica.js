var ruta_contenedores = "./contenedores/contenedores_logistica/";
var cruds = "./cruds/logistica/";
var ruta_grillas = "./grillas/logistica/";
var ruta_consultas = "./consultas/logistica/";

var direccion = "1";
var contador_mixto_pedido_log_ccha = 0;
var contador_mixto_pedido_log_cyo = 0;
var contador_mixto_pedido_log_cchb = 0;
var contador_mixto_pedido_log_cchh = 0;
var contador_mixto_pedido_log_lavado = 0;
var array_mixto_pedidos = "";
var cantidad_total_ccha = 0;
var cantidad_total_cchb = 0;
var cantidad_total_cchh = 0;
var cantidad_total_ovo = 0;
var cantidad_total_cyo = 0;
 var cantidad_total = 0;
var elem = document.documentElement;
var pantalla = "SI";
var variable_cambio = ""; //se usa como un websocket
var cont_filtro = 0; // SE USA PARA QUE AL USAR EL FILTRO DE DATATABLE, PUEDA CALCULAR LAS CELDAS.
var cantidad_negativa = 0;
var cantidad_total_mixtos = 0;
function openFullscreen() {

    if (pantalla == "SI")
    {
        if (elem.requestFullscreen) {
            elem.requestFullscreen();
        } else if (elem.webkitRequestFullscreen) { /* Safari */
            elem.webkitRequestFullscreen();
        } else if (elem.msRequestFullscreen) { /* IE11 */
            elem.msRequestFullscreen();
        }
        pantalla = "NO";
    } else if (pantalla == "NO")
    {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.webkitExitFullscreen) { /* Safari */
            document.webkitExitFullscreen();
        } else if (document.msExitFullscreen) { /* IE11 */
            document.msExitFullscreen();
        }
        pantalla = "SI";
    }
}

function generar_grilla_pedido_log(tipo, codigo, cod_camion, id_chofer)
{
    reset_cero_variables_log();
    var tipo_huevo_filtro=$('#filtro_tipo').val();
    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');
    
    cont_filtro = 0; //INICIALIZA A 0 PARA EL FILTRO DE DATATABLE EN FUNCION SOLO NUMEROS TD
    var tipo_pedido = "";
    var pagina = "";
    var area = "";//este sirve solo para enviar para que clasificadora es
    if (tipo == 1 || tipo == 4)
    {
        pagina = "generar_grilla_preembarque.jsp";
        tipo_pedido = "CREAR";
    }
    if (tipo == 6)
    {
        pagina = "generar_grilla_preembarque_camion.jsp?id_camion=" + codigo_camion;
        tipo_pedido = "CREAR";
    } 
    else if (tipo == 7||tipo == 9)
    {
        pagina = "generar_grilla_preembarque_refrescar.jsp?id_camion=" + codigo_camion;
        tipo_pedido = "CREAR";
    } 
    else if (tipo == 8)
    {
        codigo_camion = cod_camion;
        pagina = "generar_grilla_preembarque_modificar_refrescar.jsp?id_camion=" + codigo_camion + "&id_pedido=" + codigo;
        tipo_pedido = "MODIFICAR";
    } else if (tipo == 2)
    {
        codigo_camion = cod_camion;
        pagina = "generar_grilla_preembarque_modificar.jsp?id_pedido=" + codigo;
        tipo_pedido = "MODIFICAR";
    } else if (tipo == 3)
    {
        pagina = "generar_grilla_preembarque_cyo.jsp?id=" + codigo;
    } else if (tipo == 5)
    {
        pagina = "generar_grilla_preembarque_cajones.jsp";
    }
    $.ajax({
        type: "POST",
        url: ruta_consultas + pagina,
        beforeSend: function ()
        {
            cargar_load("Cargando");
        },
        success: function (res)
        {
            //TIPO 1 ES IGUAL A GENERACION DE PEDIDO
            //TIPO 2 ES IGUAL A FACTURACION
            //TIPO 3 ES IGUAL A CYO
            //FIRT ES EL DIV EN DONDE SE ALMACENA LA GRILLA DE CARROS ENTERO, EL SECOND ALMACENA LOS CARROS MIXTOS.
            $("#1").val("0");
            $("#2").val("0");
            $("#3").val("0");
            $("#4").val("0");
            $("#5").val("0");
            $("#6").val("0");
            $("#7").val("0");

            if (tipo == 1 || tipo == 2)
            {
                $("#contenido_grillas").html(res.grilla + " " + res.grilla_mixto);
                $("#tb_preembarque_mixto").DataTable(
                {
                    responsive: true,
                    scrollY: "547px",
                    scrollX: "500px",
                    paging: false,
                    "language":
                    {
                        "sUrl": "js/Spanish.txt"
                    }
                }
                );
            } else
            {
                $("#first").html("");
                $("#first").html(res.grilla);
                var c = 0;

                $.each(res.totales_cabecera, function (i, item)
                {
                    $("#" + res.totales_cabecera[c].id).val(res.totales_cabecera[c].cantidad);
                    c++;
                });

                var deseleccionar = document.querySelectorAll("[deseleccionar]");

                for (i = 0, len = deseleccionar.length; i < len; i++)
                {
                    $("#" + deseleccionar[i].getAttribute("cod_carrito")).removeClass(' btn-primary bg1 bg-red ').addClass('btn-dark ')
                    $("#" + deseleccionar[i].getAttribute("cod_carrito")).html("SELECCIONE");
                    $("#" + deseleccionar[i].getAttribute("cod_carrito")).removeAttr("mixto");
                }

                var f = 0;
                $.each(res.mixtos_seleccionados, function (i, item)
                {
                    $("#" + res.mixtos_seleccionados[f]).removeClass('btn-dark bg-red ').addClass(' btn-primary  bg1 ')
                    $("#" + res.mixtos_seleccionados[f]).html("SELECCIONADO");
                    $("#" + res.mixtos_seleccionados[f]).attr("mixto", true);
                    f++;
                });
                
                 var s= 0;
                $.each(res.carros_camiones, function (i, item)
                {
                     $("#"+res.carros_camiones[s].tipo_huevo).val(res.carros_camiones[s].cantidad);
                     s++;   
                 });
                
                
                sumar_mixtos_seleccionados_log(); 
            }
            
            var capacidad_camion=$("#cbox_camion").find(':selected').attr('capacidad');
            $('#txt_disponibilidad').val(capacidad_camion);
            var c = 0;
            $(".select_camion").removeClass("bg-red");
            $(".select_camion").addClass("bg-dark");
            $("#grupo_camiones").html("");
            
            $.each(res.select, function (i, item)
            {
                $("." + res.select[c]).removeClass("bg-dark");
                $("." + res.select[c]).addClass("bg-red");
                var group_camion='<label class="btn btn-secondary "> <input type="radio" name="options" id="option_a1" autocomplete="off" checked="" onclick="cambiar_select_camion_log('+res.select[c]+');traer_totales_carros_tipos_log()"> '+res.select[c]+'  </label>';
                
                if(res.select[c]==codigo_camion){
                    group_camion='<label class="btn btn-secondary focus  active"> <input type="radio" name="options" id="option_a1" autocomplete="off" checked=""   onclick="cambiar_select_camion_log('+res.select[c]+');traer_totales_carros_tipos_log()" > '+res.select[c]+'  </label>';
                }
                
                $("#grupo_camiones").append(group_camion);
                c++;
            });

            if (tipo == 1 || tipo == 2 || tipo == 6 || tipo == 7 || tipo == 8|| tipo == 9)
            {
                var columns = $("#tb_preembarque > tbody > tr:first > td").length;
                var ccha = 0;// 3 al 13
                var cchb = 0;//14 al 23
                var cchh = 0;//24 al 33
                var ovo = 0; //34 al 42
                var cyo = 0;//43 al 52
                var ing2 = 5;
                for (var i = 3; i <= columns; )
                {
                    if ($("#tb_preembarque > tbody > tr > td:nth-child(" + i + ")").filter(function () {
                        return $(this).text() != 0;
                    }).length == 0 && $("#tb_preembarque > tbody > tr > td:nth-child(" + (i + 2) + ")").filter(function () {
                        return $(this).text() != 0;
                    }).length == 0)
                    {
                        var ing = 1 + i;
                        var ing2 = ing + 1;
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + i + "), #tb_preembarque > thead > tr > th:nth-child(" + i + ")").hide();
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + ing + "), #tb_preembarque > thead > tr > th:nth-child(" + ing + ")").hide();
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + ing2 + "), #tb_preembarque > thead > tr > th:nth-child(" + ing2 + ")").hide();
                        
                        /*  $("#tb_preembarque > tbody > tr > td:nth-child(" + i + "), #tb_preembarque > thead > tr > td:nth-child(" + i + ")").addClass("eliminar");
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + ing + "), #tb_preembarque > thead > tr > td:nth-child(" + ing + ")").addClass("eliminar");
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + ing2 + "), #tb_preembarque > thead > tr > td:nth-child(" + ing2 + ")").addClass("eliminar");
                        */
                        if (i >= 3 && i < 18) {
                            ccha = ccha + 3;
                        }
                        if (i >= 18 && i < 33) {
                            cchb = cchb + 3;
                        }
                        if (i >= 33 && i < 48) {
                            cchh = cchh + 3;
                        }
                        if (i >= 48 && i < 60) {
                            ovo = ovo + 3;
                        }
                        if (i >= 60 && i < 75) {
                            cyo = cyo + 3;
                        }
                        $("#th_ccha").show();
                        $("#th_cchb").show();
                        $("#th_cchh").show();
                        $("#th_ovo").show();
                        $("#th_cyo").show();

                        ing2 = ing2 + 3;
                    }
                    i = i + 3;
                }
                $("#th_ccha").attr('colspan', 15 - ccha);
                $("#th_cchb").attr('colspan', 15 - cchb);
                $("#th_cchh").attr('colspan', 15 - cchh);
                $("#th_ovo").attr('colspan', 12 - ovo);
                $("#th_cyo").attr('colspan', 15 - cyo);

                if (15 - ccha == 0) {
                    $("#th_ccha").hide();
                }
                if (15 - cchb == 0) {
                    $("#th_cchb").hide();
                }
                if (15 - cchh == 0) {
                    $("#th_cchh").hide();
                }
                if (12 - ovo == 0) {
                    $("#th_ovo").hide();
                }
                if (15 - cyo == 0) {
                    $("#th_cyo").hide();
                }
                $("#btn_directorio_actualizar").remove();
            }


           // $(".eliminar").remove();
            


             $("#tb_preembarque").DataTable(
                    {
                       paging: false,
                        responsive: true,
                         "autoWidth": false,
                        scrollCollapse: true,
                         "scrollX": true,
                         "ordering": false, 
                             dom: "Bfrtip",
                         "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                        buttons: [
                                {extend: "copyHtml5", text: "COPIAR GRILLA", exportOptions: {columns: [0, ":visible"]}},
                                {extend: "excelHtml5", title:"REPORTE ALIMENTADOS FECHA", text: "EXCEL", exportOptions: {columns: ":visible"}},
                                {
                                    extend: "pdfHtml5",
                                    text: "PDF",
                                    title:  "REPORTE ALIMENTADOS FECHA ",
                                    orientation: "landscape",
                                    pageSize: "LEGAL",
                                    
                                    exportOptions: {columns: ":visible"},
                                },
                                "colvis",
                            ],
                            keys: {clipboard: !1},
                   "initComplete": function () {
                        var api = this.api();
                        api.search( tipo_huevo_filtro ).draw();
                        
                    },
                    drawCallback: function () //SIRVE PARA QUE AL TIPEAR EL FILTRO SE EJECUTE
                    {
                         var data = $('div.dataTables_filter input').val();
                         $('#filtro_tipo').val(data);
                        
                    },
                    
                    });
             
            if (tipo == 2) {
                generar_grilla_pedido_log(8, codigo, cod_camion),
                        $('#contenido_grillas').show();
                $("#cbox_camion").val(cod_camion);
                $("#cbox_chofer").val(id_chofer);
                $("#cbox_camion").prop('disabled', 'disabled');


            }
            solo_numeros_td();
            seleccionar_todo_input();
            grilla_funciones_log(tipo_pedido);
            cerrar_load();
            
            if(tipo==9){
                registrar_pedido_log();
            }
        },
        error: function (error)
        {
            generar_grilla_pedido_log(tipo, codigo);
        }

    });
 }
function cambiar_select_camion_log(id_camion){
    $("#cbox_camion").val(id_camion);
    generar_grilla_pedido_log(6);
    $('#contenido_grillas').show();
}
function sumar_grilla_tipos_directorio_logistica(){
    var editables = document.querySelectorAll("[contar]");
    var stock_ccha="0";
    var stock_cchb="0";
    var stock_cchh="0";
    var stock_cyo="0";
    var stock_clasificadora="0";
    var stock_lavado="0";
    var tipo=" ";
    
    for (var i = 0, len = editables.length; i < len; i++)
    {  
        var cantidad_celda=editables[i].getAttribute("cantidad");
        tipo=editables[i].getAttribute("tipo_huevo");
       
        stock_clasificadora      = parseInt(stock_ccha)+parseInt(stock_cchb)
                +parseInt(stock_cchh)+parseInt(stock_cyo)+parseInt(stock_lavado)+      
                parseInt(cantidad_celda);

         switch (editables[i].getAttribute("area"))
        {
          
            case "CCHA":
                stock_ccha      = parseInt(stock_ccha)      + parseInt(cantidad_celda);
                break;
            case "CCHB":
                stock_cchb      = parseInt(stock_cchb)      + parseInt(cantidad_celda);
                break;
            case "CCHH":
                stock_cchh      = parseInt(stock_cchh)      + parseInt(cantidad_celda);
                break;
            case "LAVADOS":
                stock_lavado    = parseInt(stock_lavado)    + parseInt(cantidad_celda);
                break;
            case "CYO":
                stock_cyo       = parseInt(stock_cyo)       + parseInt(cantidad_celda);
                break;
        }
    } 
        
        $('#th_clasificadora').  html('TOTAL:'+ "<div class='h5'><span class='badge badge-success'>"+stock_clasificadora.toLocaleString().replace(/,/g, ".", )+"</span></div>" );
        $('#td_ccha').  html('CCHA  CAJONES:  '            + "<div class='h5'><span class='badge badge-danger'>"+stock_ccha.toLocaleString().replace(/,/g, ".", )+"</span></div>" );
        $('#td_cchb').  html('CCHB  CAJONES:   '            + "<div class='h5'><span class='badge badge-danger'>"+stock_cchb.toLocaleString().replace(/,/g, ".", )+"</span></div>"  );
        $('#td_cchh').  html('CCHH  CAJONES:  '            + "<div class='h5'><span class='badge badge-danger'>"+stock_cchh.toLocaleString().replace(/,/g, ".", )+"</span></div>" );
        $('#th_ovo').   html('LAVADOS  CAJONES:  '         + "<div class='h5'><span class='badge badge-danger'>"+stock_lavado.toLocaleString().replace(/,/g, ".", )+"</span></div>" );
        $('#td_cyo').   html('DEPOSITO CYO  CAJONES:  '    + "<div class='h5'><span class='badge badge-danger'>"+stock_cyo.toLocaleString().replace(/,/g, ".", )+"</span></div>");
       
}

function grilla_funciones_log(tipo_pedido) //TIPO PEDIDO ES CREAR O MODIFICAR
{
    var editables = document.querySelectorAll("[contentEditable]");
    var stock = document.querySelectorAll("[stock]");

    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');
   /*var total_ccha = 0;
    var total_cchb = 0;
    var total_cchh = 0;
    var total_ccho = 0;
    var total_cyo = 0;*/
    var total_a = 0;
    var total_b = 0;
    var total_c = 0;
    var total_d = 0;
    var total_s = 0;
    var total_j = 0;
    cantidad_total = 0;
    cantidad_negativa = 0;

    for (var f = 0, len = stock.length; f < len; f++)
    {
        if (parseInt(stock[f].getAttribute("disponible")) < 0)
        {
            cantidad_negativa = parseInt(stock[f].getAttribute("disponible"));
        }
    }
    for (var i = 0, len = editables.length; i < len; i++)
    {
        editables[i].setAttribute("valor", editables[i].innerHTML);
        if (parseInt(editables[i].getAttribute("valor")) > 0)
        {
            editables[i].style.backgroundColor = 'blue';
            editables[i].setAttribute("activo",true );

        }
        editables[i].onfocus = function ()
        {
            celda_editable_selectElement(this);
        };
        editables[i].onblur = function ()
        { 
            var celda_ingresada=this.innerHTML;
            if (this.innerHTML == this.getAttribute("valor"))
            {
                if(celda_ingresada==0){
                    (this).style.backgroundColor = 'black';
                }
                else
                {
                    (this).style.backgroundColor = 'blue';
                    this.innerHTML = this.getAttribute("valor");
                }
            } 
            else
            {
              
                var stock = this.getAttribute("disponible");
                var area = this.getAttribute("area");
                var tipo = this.getAttribute("tipo");
                var categoria = this.getAttribute("categoria");
                var tipo_huevo = this.getAttribute("tipo_huevo");
                var fecha_puesta = this.getAttribute("fp");

                if ( celda_ingresada== 0)
                {
                    this.setAttribute("valor", this.innerHTML);
                    var valor = this.getAttribute("valor");
                    (this).style.backgroundColor = 'black';
                    this.setAttribute("activo",false );

                    insert_reservas(codigo_camion, valor, fecha_puesta, tipo, tipo_huevo, area, categoria, "0", "ENTERO", tipo_pedido);
                    
                } 
                else if (parseInt(stock) >= parseInt(this.innerHTML))
                {
                    this.setAttribute("valor", this.innerHTML);
                    var valor = this.getAttribute("valor");

                   (this).style.backgroundColor = 'blue';
                    insert_reservas(codigo_camion, valor, fecha_puesta, tipo, tipo_huevo, area, categoria, "0", "ENTERO", tipo_pedido);
                } 
                else if (parseInt(stock) < parseInt(this.innerHTML))
                {
                    (this).style.backgroundColor = 'red';
                    this.setAttribute("activo",false );
                }
            }
        }
       
    }
    var activos = document.querySelectorAll("[activo]");
    for (var i = 0, len = activos.length; i < len; i++)
    {
         switch (activos[i].getAttribute("tipo_huevo"))
        {
            case "A":
                total_a = parseInt(total_a) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "B":
                total_b = parseInt(total_b) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "C":
                total_c = parseInt(total_c) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "D":
                total_d = parseInt(total_d) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "S":
                total_s = parseInt(total_s) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "J":
                total_j = parseInt(total_j) + parseInt(activos[i].getAttribute("valor"));
                break;
        } 
        
         switch (activos[i].getAttribute("area"))
        {
            case "CCHA":
                cantidad_total_ccha = parseInt(cantidad_total_ccha) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "CCHB":
                cantidad_total_cchb = parseInt(cantidad_total_cchb) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "CCHH":
                cantidad_total_cchh = parseInt(cantidad_total_cchh) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "LAVADOS":
                cantidad_total_ovo = parseInt(cantidad_total_ovo) + parseInt(activos[i].getAttribute("valor"));
                break;
            case "CYO":
                cantidad_total_cyo = parseInt(cantidad_total_cyo) + parseInt(activos[i].getAttribute("valor"));
                break;
        }
      
        cantidad_total = parseInt(cantidad_total) + parseInt(activos[i].getAttribute("valor"));
    }
    $('#txt_restantes').val((parseInt(cantidad_total) + parseInt(cantidad_total_mixtos)) - parseInt($('#txt_disponibilidad').val()));
    $('#txt_cargados').val(parseInt(cantidad_total) + parseInt(cantidad_total_mixtos));

    $('#td_ccha').html('CCHA  TOTAL CARGADOS:' + (parseInt(cantidad_total_ccha)+parseInt(contador_mixto_pedido_log_ccha)));
    $('#td_cchb').html('CCHB  TOTAL CARGADOS:' + (parseInt(cantidad_total_cchb)+parseInt(contador_mixto_pedido_log_cchb)));
    $('#td_cchh').html('CCHH  TOTAL CARGADOS:' + (parseInt(cantidad_total_cchh)+parseInt(contador_mixto_pedido_log_cchh)));
    $('#td_ovo').html('LAVADOS  TOTAL CARGADOS:' + (parseInt(cantidad_total_ovo)+parseInt(contador_mixto_pedido_log_lavado)));
    $('#td_cyo').html('DEPOSITO CYO  TOTAL CARGADOS:' + (parseInt(cantidad_total_cyo)+parseInt(contador_mixto_pedido_log_cyo)));

    $('#txt_tipo_ac').val(total_a);
    $('#txt_tipo_bc').val(total_b);
    $('#txt_tipo_cc').val(total_c);
    $('#txt_tipo_dc').val(total_d);
    $('#txt_tipo_sc').val(total_s);
    $('#txt_tipo_jc').val(total_j);
    sumar_tipos_huevos_log(total_a, total_b, total_c, total_d, total_s, total_j);
}

function registrar_pedido_log()
{
     //actualiza grilla por si hubo un cambio despues de haber cargado todo.
    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');
    var codigo_chofer = $("#cbox_chofer").find(':selected').attr('codigo');
    var capacidad = $("#cbox_camion").find(':selected').attr('capacidad');
    var negativos = document.querySelectorAll("[negativo]");// CANTIDADES QUE FUERON ELIMINADOS DE CYO, Y APARECEN NEGATIVO EN PEDIDO
  
    var i =0;
    for (  i = 0, len = negativos.length; i < len; i++)
    {
        
    }
    if(i>0){
         aviso_generico(2,"LOS CARROS SELECCIONADOS RECAE EN INVENTARIO NEGATIVO.");
    }
    else if (codigo_camion == "-") 
    {
        aviso_generico(2,"SELECCIONE CAMION");
    } 
    else if (codigo_chofer == "-") 
    {
        aviso_generico(2,"SELECCIONE CHOFER");
    } 
    else if (parseInt(capacidad) > (cantidad_total + cantidad_total_mixtos)) 
    {
        aviso_generico(2,"FALTAN CARGAR CARROS");
    } 
    else if (parseInt(cantidad_negativa) < 0) 
    {
        aviso_generico(2,"NO CUENTA CON STOCK");
    }  
    else if ($("#txt_restantes").val() != "0") 
    {
        aviso_generico(2, "ERROR EN LA CANTIDAD DE CARROS");
    } 
    else
    {
        Swal.fire({

            title: 'CONFIRMACION',
            text: "DESEA REALIZAR EL PEDIDO?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'}).then((result) =>
        {
            if (result.value)
            {   
                $.ajax({
                    type: "POST",
                    url: cruds + "control_crear_pedido.jsp",
                    data: ({id_camion: codigo_camion, id_chofer: codigo_chofer, cantidad_total: capacidad}),
                    beforeSend: function ()
                    {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: 'ESPERE<strong></strong>...',
                            allowOutsideClick: false,
                            willOpen: () => 
                            {
                                Swal.showLoading();
                            }
                        });
                    },
                    success: function (res)
                    {
                        aviso_generico_log(res.tipo_respuesta, res.mensaje, 'PEDIDOS');
                    }
                    ,
                    error: function (error)
                    {
                        swal.fire({
                            type: 'error',
                            html: 'Ha ocurrido un error, intente de nuevo.',
                            confirmButtonText: "CERRAR"
                        });
                    }
                });
            }
        });  
    }
    
 

}

function registrar_pedido_mod_log()
{
    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');
    var codigo_chofer = $("#cbox_chofer").find(':selected').attr('codigo');
    var capacidad = $("#cbox_camion").find(':selected').attr('capacidad');


    if (codigo_camion == "-") 
    {
         aviso_generico(2, "SELECCIONE CAMION");
    } 
    else if (codigo_chofer == "-") 
    {
        aviso_generico(2, "SELECCIONE CHOFER");
    } 
    else if (parseInt(capacidad) > (cantidad_total + cantidad_total_mixtos)) 
    {
        aviso_generico(2, "FALTAN CARGAR CARROS");
    } 
    else if (parseInt(cantidad_negativa) < 0) 
    {
        aviso_generico(2, "NO CUENTA CON STOCK");
    } 
    else if ($("#txt_restantes").val() != "0") 
    {
        aviso_generico(2, "ERROR EN LA CANTIDAD DE CARROS");
    } 
    else 
    {
        Swal.fire({

            title: 'CONFIRMACION',
            text: "DESEA REALIZAR EL PEDIDO?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'}).then((result) =>
        {
            if (result.value)
            {
                $.ajax({
                    type: "POST",
                    url: cruds + "control_modificar_pedido.jsp",
                    data: ({id_camion: codigo_camion, id_chofer: codigo_chofer, cantidad_total: capacidad, id_pedido: $("#id_pedido").val()}),
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
                    success: function (res)
                    {
                        aviso_generico_log(res.tipo_respuesta, res.mensaje, 'PEDIDOS');
                    }
                    ,
                    error: function (error)
                    {
                        swal.fire({
                            type: 'error',
                            html: 'Ha ocurrido un error, intente de nuevo.',
                            confirmButtonText: "CERRAR"
                        });
                    }
                });


            }
        });

    }

}

function grilla_funciones_cyo() //TIPO PEDIDO ES CREAR O MODIFICAR
{
    var editables = document.querySelectorAll("[contentEditable]");
    var total_a = 0;
    var total_b = 0;
    var total_c = 0;
    var total_d = 0;
    var total_s = 0;
    var total_j = 0;
    cantidad_total = 0;
    var tipo_huevo_celda = "";
    var cont = $("#huevos_cargados").val();

    for (var i = 0, len = editables.length; i < len; i++)
    {
        editables[i].setAttribute("valor", editables[i].innerHTML);

        tipo_huevo_celda = editables[i].getAttribute("tipo_huevo");
        if (parseInt(editables[i].getAttribute("valor")) > 0)
        {
            editables[i].style.backgroundColor = 'blue';
        }
        editables[i].onfocus = function ()
        {
            celda_editable_selectElement(this);
        };
        editables[i].onblur = function ()
        {
            if (this.innerHTML == this.getAttribute("valor"))
            {
                this.innerHTML = this.getAttribute("valor");
            } else
            {
                var valor_viejo = this.getAttribute("valor");
                this.setAttribute("valor", this.innerHTML);
                var valor = this.getAttribute("valor");
                var stock = this.getAttribute("disponible");
                var area = this.getAttribute("area");
                var tipo = this.getAttribute("tipo");
                var categoria = this.getAttribute("categoria");
                var tipo_huevo = this.getAttribute("tipo_huevo");
                var fecha_puesta = this.getAttribute("fp");

                if (valor == 0)
                {
                    (this).style.backgroundColor = 'black';
                } else if (parseInt(stock) >= parseInt(valor))
                {
                    (this).style.backgroundColor = 'blue';


                } else if (parseInt(stock) < parseInt(valor))
                {
                    (this).style.backgroundColor = 'red';
                    cantidad_excedida_celda = true;
                }

                $("#" + tipo_huevo).val((parseInt($("#" + tipo_huevo).val()) - parseInt(valor_viejo)) + parseInt(valor));
                $("#" + tipo_huevo).attr("cargado", $("#" + tipo_huevo).val());


            }
            
        }

        switch (editables[i].getAttribute("tipo_huevo"))
        {
            case "A":
                total_a = parseInt(total_a) + parseInt(editables[i].getAttribute("valor"));
                break;
            case "B":
                total_b = parseInt(total_b) + parseInt(editables[i].getAttribute("valor"));
                break;
            case "C":
                total_c = parseInt(total_c) + parseInt(editables[i].getAttribute("valor"));
                break;
            case "D":
                total_d = parseInt(total_d) + parseInt(editables[i].getAttribute("valor"));
                break;
            case "S":
                total_s = parseInt(total_s) + parseInt(editables[i].getAttribute("valor"));
                break;
            case "J":
                total_j = parseInt(total_j) + parseInt(editables[i].getAttribute("valor"));
                break;
        }
        cantidad_total = parseInt(cantidad_total) + parseInt(editables[i].getAttribute("valor"));

        if (cont.includes(tipo_huevo_celda)) {

        } else {
            editables[i].setAttribute("contentEditable", false);
        }

    }
    ;

    $('#txt_restantes').val((parseInt(cantidad_total) + parseInt(cantidad_total_mixtos)) - parseInt($('#txt_disponibilidad').val()));
    $('#txt_cargados').val(parseInt(cantidad_total) + parseInt(cantidad_total_mixtos));
    
    
    cerrar_load();
}

function registrar_pedido_mod_cyo()
{
    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');
    var textos = document.querySelectorAll("[texto]");
    validacion_carros = 0;
    var cantidad_excedida_celda = false;
    var editables = document.querySelectorAll("[contentEditable]");

    jsonObj = [];

    for (var i = 0, len = editables.length; i < len; i++)
    {
        if (parseInt(editables[i].getAttribute("valor")) > parseInt(editables[i].getAttribute("disponible")))
        {
            cantidad_excedida_celda = true;
        }

        var valor = editables[i].getAttribute("valor");
        if (parseInt(valor) > 0)
        {
            item = {}
            item ["fecha_puesta"] = editables[i].getAttribute("fp");
            item ["area"] = editables[i].getAttribute("area");
            item ["tipo"] = editables[i].getAttribute("tipo");
            item ["tipo_huevo"] = editables[i].getAttribute("tipo_huevo");
            item ["cantidad"] = editables[i].getAttribute("valor");
            item ["categoria"] = editables[i].getAttribute("categoria");
            item ["cod_carrito"] = 0;
            item ["u_medida"] = "ENTERO";
            item ["id_pedido"] = $("#id_pedido").val();
            item ["id_camion"] = codigo_camion;
            jsonObj.push(item);
        }
    }
    ;

    for (var i = 0, len = textos.length; i < len; i++)
    {
        if (textos[i].getAttribute("cantidad") != textos[i].getAttribute("cargado"))
        {
            validacion_carros++;
        }
    }

    if (cantidad_excedida_celda == true)
    {
        swal.fire({
            type: 'error',
            html: 'CANTIDADES DE LA CELDA EXCEDEN.',
            confirmButtonText: "CERRAR"
        });
    } else if (parseInt(validacion_carros) > 0) {
        alert("CANTIDADES NO COINCIDEN");
        swal.fire({
            type: 'error',
            html: 'Ha ocurrido un error, intente de nuevo.',
            confirmButtonText: "CERRAR"
        });
    } else
    {


        var json_string = JSON.stringify(jsonObj);
        Swal.fire({

            title: 'CONFIRMACION',
            text: "DESEA REALIZAR EL PEDIDO?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'}).then((result) =>
        {
            if (result.value)
            {
                $.ajax({
                    type: "POST",
                    url: cruds + "control_modificar_pedido_cyo.jsp",
                    data: ({json: json_string, id_pedido: $("#id_pedido").val()}),
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
                    success: function (res)
                    {
                        aviso_generico_log(res.tipo_respuesta, res.mensaje, 'PEDIDOS');
                    }
                    ,
                    error: function (error)
                    {
                        swal.fire({
                            type: 'error',
                            html: 'Ha ocurrido un error, intente de nuevo.',
                            confirmButtonText: "CERRAR"
                        });
                    }
                });
            }
        });
    }




//}

}

function cerar_pedido_log() //TIPO PEDIDO ES CREAR O MODIFICAR
{

    $.ajax({
        type: "POST",
        url: cruds + "control_cancelar_reserva.jsp",
        data: ({id_camion: $("#cbox_camion").find(':selected').attr('codigo')}),
        beforeSend: function ()
        {

        },
        success: function (res)
        {
            generar_grilla_pedido_log(6), $('#contenido_grillas').show();
        }
        ,
        error: function (error)
        {

        }
    });
}

function seleccionar_mixtos(cod_carrito)
{
    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');
    var valor = "0";
    var fecha_puesta = $("#" + cod_carrito).attr("fecha_puesta");
    var tipo = "LIB";
    var tipo_huevo = "-";
    var area = $("#" + cod_carrito).attr("area");
    var categoria = $("#" + cod_carrito).attr("categoria");
    var cod_carrito = $("#" + cod_carrito).attr("cod_carrito");
    insert_reservas_mixtos_log(codigo_camion, valor, fecha_puesta, tipo, tipo_huevo, area, categoria, cod_carrito, "MIXTO");
    sumar_mixtos_seleccionados_log();
}
function insert_reservas_mixtos_log(id_camion, cantidad, fp, tipo, tipo_huevo, area, categoria, cod_carrito, tipo_carro) {
    $.ajax({
        type: "POST",
        url: cruds + "control_crear_reserva.jsp",
        data: ({id_camion: id_camion, cantidad: cantidad, id_chofer: $('#cbox_chofer').val(),
            fecha_puesta: fp, tipo: tipo, tipo_huevo: tipo_huevo, area: area, categoria: categoria, cod_carrito: cod_carrito, tipo_carro: tipo_carro, id_pedido: $("#id_pedido").val()}),
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            //  generar_grilla_pedido_log(6); 
            switch (res.tipo_respuesta)
            {
                case 3:
                    $("#" + res.carro_reserva).removeClass('btn-primary btn-dark bg1 ').addClass('btn bg-red ')
                    $("#" + res.carro_reserva).html(res.mensaje);
                    $("#" + res.carro_reserva).removeAttr("mixto");

                    break;
                case 1:
                    $("#" + res.carro_reserva).removeClass('btn-dark bg1 btn bg-red ').addClass(' btn-primary  bg1')
                    $("#" + res.carro_reserva).html(res.mensaje);
                    $("#" + res.carro_reserva).attr("mixto", true);
                    break;
                case 2:
                    $("#" + res.carro_reserva).removeClass('btn-primary bg1 btn bg-red ').addClass('btn btn-dark btn-sm')
                    $("#" + res.carro_reserva).html(res.mensaje);
                    $("#" + res.carro_reserva).removeAttr("mixto");
                    break;
            }


            sumar_mixtos_seleccionados_log();
        }
        ,
        error: function (error)
        {

        }
    });

}

function sumar_mixtos_seleccionados_log() {
    var mixto = document.querySelectorAll("[mixto]");
 
     var ccha_mix=0;
    var cchb_mix=0;
    var  cchh_mix=0;
    var ccho_mix=0;
    var  cyo_mix=0;
     
    for (cantidad_total_mixtos = 0, len = mixto.length; cantidad_total_mixtos < len; cantidad_total_mixtos++)
    {
        switch (mixto[cantidad_total_mixtos].getAttribute("area"))
        {
            case "CCHA":
                ccha_mix++;
                contador_mixto_pedido_log_ccha =  parseInt(ccha_mix);
                break;
            case "CCHB":
                cchb_mix++;
                contador_mixto_pedido_log_cchb =  parseInt(cchb_mix);
                break;
            case "CCHH":
                cchh_mix++;
                contador_mixto_pedido_log_cchh = parseInt(cchh_mix);
                break;
            case "LAVADOS":
                ccho_mix++;
                contador_mixto_pedido_log_lavado =   parseInt(ccho_mix);
                break;
            case "CYO":
                cyo_mix++;
                contador_mixto_pedido_log_cyo =   parseInt(cyo_mix);
                break;
        }
        
        
    }
    
     $('#td_ccha').html('CCHA  TOTAL CARGADOS:' + (parseInt(cantidad_total_ccha)+parseInt(contador_mixto_pedido_log_ccha)));
    $('#td_cchb').html('CCHB  TOTAL CARGADOS:' + (parseInt(cantidad_total_cchb)+parseInt(contador_mixto_pedido_log_cchb)));
    $('#td_cchh').html('CCHH  TOTAL CARGADOS:' + (parseInt(cantidad_total_cchh)+parseInt(contador_mixto_pedido_log_cchh)));
    $('#td_ovo').html('LAVADOS  TOTAL CARGADOS:' + (parseInt(cantidad_total_ovo)+parseInt(contador_mixto_pedido_log_lavado)));
    $('#td_cyo').html('DEPOSITO CYO  TOTAL CARGADOS:' + (parseInt(cantidad_total_cyo)+parseInt(contador_mixto_pedido_log_cyo)));


    $("#txt_tipo_mixtoc").val(cantidad_total_mixtos);
    $('#txt_restantes').val((parseInt(cantidad_total) + parseInt(cantidad_total_mixtos)) - parseInt($('#txt_disponibilidad').val()));

    var mixto_cargado = $('#txt_tipo_mixtoc').val();
    var mixto_ingresado = $('#7').val(); //CAJA DE TEXTO DE MISTO INGRESADO

    if (parseInt(mixto_cargado) > parseInt(mixto_ingresado))
    {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'red';
    } else if (parseInt(mixto_cargado) == parseInt(mixto_ingresado)) {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_mixtoc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'green';
    }
}

function insert_reservas(id_camion, cantidad, fp, tipo, tipo_huevo, area, categoria, cod_carrito, tipo_carro, tipo_pedido) { //tipo pedido o es MODIFICAR O CREAR
    $.ajax({
        type: "POST",
        url: cruds + "control_crear_reserva.jsp",
        data: ({id_camion: id_camion, cantidad: cantidad, id_chofer: $('#cbox_chofer').val(),
            fecha_puesta: fp, tipo: tipo, tipo_huevo: tipo_huevo, area: area, categoria: categoria,
            cod_carrito: cod_carrito, tipo_carro: tipo_carro, tipo_pedido: tipo_pedido, id_pedido: $('#id_pedido').val()}),
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            if (tipo_carro == "ENTERO")
            {
                if (tipo_pedido == "CREAR") {
                    generar_grilla_pedido_log(6);
                } else {
                    generar_grilla_pedido_log(8, $('#id_pedido').val(), id_camion);
                }

            }
            if (res.tipo_respuesta == 0)
            {
                $("#" + cod_carrito).removeClass('btn-primary btn-dark bg1 ').addClass('btn bg-navy ');
                $("#" + res.carro_reserva).html(res.mensaje);
                $("#" + res.carro_reserva).removeAttr("mixto");
                $("#" + res.carro_reserva).Attr("reservado", true);
            }
        }
        ,
        error: function (error)
        {

        }
    });

}

function aviso_generico_log(tipo, mensaje)
{
    if (tipo == "1") {
        swal.fire({
            type: 'success',
            text: mensaje,
            confirmButtonText: "CERRAR"

        });

        $("#contenedor_principal").html("")
    } else {
        swal.fire({
            type: 'error',
            html: mensaje,
            confirmButtonText: "CERRAR"
        });


    }
}

function insert_cabecera_totales_log(id, tipo_registro) { // tipo_registro: 1= CREAR PEDIDO, 2= MODIFICAR PEDIDO// 
    var codigo_camion = $("#cbox_camion").find(':selected').attr('codigo');

    if ($("#" + id).val() == $("#" + id).attr("cantidad")) {

    } else {
        $.ajax({
            type: "POST",
            data: ({id_camion: codigo_camion, tipo_huevo: $("#" + id).attr("tipo_huevo"), cantidad: $("#" + id).val(), id_pedido: $("#id_pedido").val()}),
            url: cruds + "control_crear_cabecera_totales.jsp",

            success: function (res)
            {
                if (res.tipo_respuesta == 1) {
                    $("#" + id).attr("cantidad", $("#" + id).val());
                }
            }
            ,
            error: function (error)
            {

            }
        });
    }
}


function insert_totales_carga_pedido_log(id) { // tipo_registro: 1= CREAR PEDIDO, 2= MODIFICAR PEDIDO// 
 
    if ($("#" + id).val() == $("#" + id).attr("cantidad")) {

    } 
    else {
        $.ajax({
            type: "POST",
            data: ({tipo_huevo: $("#" + id).attr("tipo_huevo"),id: $("#" + id).attr("id"), cantidad: $("#" + id).val()}),
            url: cruds + "control_crear_cabecera_pedidos_totales.jsp",

            success: function (res)
            {
                if (res.tipo_respuesta == 1) {
                    $("#" + id).attr("cantidad", $("#" + id).val());
                }
            }
            ,
            error: function (error)
            {

            }
        });
    }
}

function traer_totales_carros_tipos_log(){
    
     $.ajax({
            type: "POST",
             url: ruta_consultas + "consulta_totales_carros_tipos_log.jsp",

            success: function (res)
            {
                 var c = 0;

                $.each(res.totales, function (i, item)
                {
                    $("#" + res.totales[c].identificador).val(res.totales[c].cantidad);
                    $("#" + res.totales[c].identificador).attr("cantidad",res.totales[c].cantidad);
                    c++;
                });
            }
            ,
            error: function (error)
            {

            }
        });
}

function sumar_tipos_huevos_log(tipoA, tipoB, tipoC, tipoD, tipoS, tipoJ) {

    $('#txt_tipo_ac').val(tipoA);
    $('#txt_tipo_bc').val(tipoB);
    $('#txt_tipo_cc').val(tipoC);
    $('#txt_tipo_dc').val(tipoD);
    $('#txt_tipo_sc').val(tipoS);
    $('#txt_tipo_jc').val(tipoJ);

    var A = $('#1').val();
    var B = $('#2').val();
    var C = $('#3').val();
    var D = $('#4').val();
    var S = $('#5').val();
    var J = $('#6').val();

    $('#txt_tipo_af').val((parseInt(A) - parseInt(tipoA)));
    $('#txt_tipo_bf').val((parseInt(B) - parseInt(tipoB)));
    $('#txt_tipo_cf').val((parseInt(C) - parseInt(tipoC)));
    $('#txt_tipo_df').val((parseInt(D) - parseInt(tipoD)));
    $('#txt_tipo_sf').val((parseInt(S) - parseInt(tipoS)));
    $('#txt_tipo_jf').val((parseInt(J) - parseInt(tipoJ)));

    var ac = tipoA;
    var bc = tipoB;
    var cc = tipoC;
    var dc = tipoD;
    var sc = tipoS;
    var jc = tipoJ;

    if (parseInt(ac) > parseInt(A))
    {
        document.getElementById('txt_tipo_ac').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_ac').style.color = 'white';
    } else if (parseInt(ac) == parseInt(A)) {
        document.getElementById('txt_tipo_ac').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_ac').style.color = 'white';
    } else
    {
        $("#txt_tipo_ac").attr('style', 'background-color:green');
        document.getElementById('txt_tipo_ac').style.color = 'white';
    }
    if (parseInt(bc) > parseInt(B))
    {
        document.getElementById('txt_tipo_bc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_bc').style.color = 'white';

    } else if (parseInt(bc) == parseInt(B)) {
        document.getElementById('txt_tipo_bc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_bc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_bc').style.backgroundColor = 'green';
    }
    if (parseInt(cc) > parseInt(C))
    {
        document.getElementById('txt_tipo_cc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_cc').style.color = 'white';

    } else if (parseInt(cc) == parseInt(C)) {
        document.getElementById('txt_tipo_cc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_cc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_cc').style.backgroundColor = 'green';
    }
    if (parseInt(dc) > parseInt(D))
    {
        document.getElementById('txt_tipo_dc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_dc').style.color = 'white';
    } else if (parseInt(dc) == parseInt(D)) {
        document.getElementById('txt_tipo_dc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_dc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_dc').style.backgroundColor = 'green';
    }
    if (parseInt(sc) > parseInt(S))
    {
        document.getElementById('txt_tipo_sc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_sc').style.color = 'white';
    } else if (parseInt(sc) == parseInt(S)) {
        document.getElementById('txt_tipo_sc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_sc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_sc').style.backgroundColor = 'green';
    }
    if (parseInt(jc) > parseInt(J))
    {
        document.getElementById('txt_tipo_jc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_jc').style.color = 'white';
    } else if (parseInt(jc) == parseInt(J)) {
        document.getElementById('txt_tipo_jc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_jc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_jc').style.backgroundColor = 'green';
    }

}

function celda_editable_selectElement(el)
{
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
}
 
function registrar_pedido_cyo(contenido, area)
{
    var contenido_mixto = "";
    if (array_mixto_pedidos.length > 0)
    {
        contenido_mixto = "," + array_mixto_pedidos;
    }

    Swal.fire({

        title: 'CONFIRMACION',
        text: 'DESEA MODIFICAR EL PEDIDO?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: cruds + "control_editar_pedido_cyo.jsp",
                data: ({contenido: contenido, id_pedido: $('#id_pedido').val(), area: area}),
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
                success: function (res)
                {
                    aviso_generico_log(res.tipo_respuesta, res.mensaje, 'PEDIDOS');
                }
            });


        }
    });
}
function anular_pedido(id)
{
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA ANULAR EL PEDIDO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: cruds + 'control_anular_pedido.jsp',
                data: ({id: id}),
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
                success: function (res)
                {
                    aviso_generico_log(res.tipo_respuesta, res.mensaje, 'ANULAR')

                }
            });


        }
    });
}

function reset_cero_variables_log()
{
    contador_mixto_pedido_log_ccha = 0;
    contador_mixto_pedido_log_cchb = 0;
    contador_mixto_pedido_log_cchh = 0;
    contador_mixto_pedido_log_lavado = 0;
    array_mixto_pedidos = "";
    cantidad_total_ccha = 0;
    cantidad_total_cchb = 0;
    cantidad_total_cchh = 0;
    cantidad_total_ovo = 0;
    cantidad_total_cyo=0;
    cantidad_total = 0;
}

function registrar_factura(id)
{
    var html;
    html = "   <form id='form_cuadro_facturas'>   \n\
                        <div id='combo' class='form - group'> <a></a>\n\
                            <select  name = 'cbox_factura' id='cbox_factura' class='form - control'    required>\n\
                            </select ><br><br>\n\
                        </div > \n\
                         <br><br><br><input type='submit' style='font-weight:bold'  value='REGISTRAR' class='form-control bg-success btn color_letra' >  \n\
                    </form> ";
    Swal.fire({
        title: 'Registrar factura al pedido',
        // text: "",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
    });

    $.get(ruta_consultas + 'consulta_option_facturas.jsp', function (res)
    {
        $("#cbox_factura").html(res.mensaje);
        $('#form_cuadro_facturas').on('submit', function (e)
        {
            e.preventDefault();
            $.ajax({
                type: "POST",
                url: cruds + 'control_confirmar_factura.jsp',
                data: $("#form_cuadro_facturas").serialize() + "&id=" + id,
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
                success: function (res)
                {
                    aviso_generico_log(res.tipo_respuesta, res.mensaje, 'FACTURA');
                }
            });
            e.stopPropagation();
        });
    });
}
 
function cargar_cantidades() {

    $.ajax({
        type: "POST",
        url: ruta_consultas + 'test_carga.jsp',
        data: ({

            A: $('#txt_tipo_a').val(), B: $('#txt_tipo_b').val(), C: $('#txt_tipo_c').val(), D: $('#txt_tipo_d').val(), S: $('#txt_tipo_s').val(), J: $('#txt_tipo_j').val(),
            AC: $('#txt_tipo_ac').val(), BC: $('#txt_tipo_bc').val(), CC: $('#txt_tipo_cc').val(), DC: $('#txt_tipo_dc').val(), SC: $('#txt_tipo_sc').val(), JC: $('#txt_tipo_jc').val()

        }),
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            $('#txt_tipo_a').val(res.A);
            $('#txt_tipo_b').val(res.B);
            $('#txt_tipo_c').val(res.C);
            $('#txt_tipo_d').val(res.D);
            $('#txt_tipo_s').val(res.S);
            $('#txt_tipo_j').val(res.J);

            $('#txt_tipo_ac').val(res.AC);
            $('#txt_tipo_bc').val(res.BC);
            $('#txt_tipo_cc').val(res.CC);
            $('#txt_tipo_dc').val(res.DC);
            $('#txt_tipo_sc').val(res.SC);
            $('#txt_tipo_jc').val(res.JC);

        }
    });
}

function consultar_cantidades() {

    $.ajax({
        type: "POST",
        url: ruta_consultas + 'test.jsp',
        //  data:({A:$('#txt_tipo_a').val(),B:$('#txt_tipo_b').val(),C:$('#txt_tipo_c').val(),D:$('#txt_tipo_d').val(),S:$('#txt_tipo_s').val(),J:$('#txt_tipo_j').val()}),  
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            $('#txt_tipo_a').val(res.A);
            $('#txt_tipo_b').val(res.B);
            $('#txt_tipo_c').val(res.C);
            $('#txt_tipo_d').val(res.D);
            $('#txt_tipo_s').val(res.S);
            $('#txt_tipo_j').val(res.J);

            $('#txt_tipo_ac').val(res.AC);
            $('#txt_tipo_bc').val(res.BC);
            $('#txt_tipo_cc').val(res.CC);
            $('#txt_tipo_dc').val(res.DC);
            $('#txt_tipo_sc').val(res.SC);
            $('#txt_tipo_jc').val(res.JC);
            $('#txt_tipo_ac').bind('DOMSubtreeModified', function () {
                console.log('changed');
            });

        }
    });
}

function seleccionar_todo_input()
{
    $("input").blur(function ()
    {
        if ($(this).attr("data-selected-all"))
        {
            $(this).removeAttr("data-selected-all");
        }
    });

    $("input").click(function ()
    {
        if (!$(this).attr("data-selected-all")) {
            try {
                $(this).selectionStart = 0;
                $(this).selectionEnd = $(this).value.length + 1;
                //add atribute allowing normal selecting post focus
                $(this).attr("data-selected-all", true);
            } catch (err) {
                $(this).select();
                //add atribute allowing normal selecting post focus
                $(this).attr("data-selected-all", true);
            }
        }
    });
}

function cargar_cantidades_ingresadas_editar(tipo)
{
    if (tipo == 2)
    {
        $('#txt_tipo_a').val($('#txt_tipo_ac').val());
        $('#txt_tipo_b').val($('#txt_tipo_bc').val());
        $('#txt_tipo_c').val($('#txt_tipo_cc').val());
        $('#txt_tipo_d').val($('#txt_tipo_dc').val());
        $('#txt_tipo_s').val($('#txt_tipo_sc').val());
        $('#txt_tipo_j').val($('#txt_tipo_jc').val());
        $('#txt_tipo_mixto').val($('#txt_tipo_mixtoc').val());
    }

}

function filtro_reporte_pedidos_log(tipo) {
    switch (tipo)
    {
        case "7":
            $("#contenedor_fechas").show();
            break;
        case "1":
            $("#contenedor_fechas").hide();
            break;
        case "2":
            $("#contenedor_fechas").hide();
            break;
        case "5":
            $("#contenedor_fechas").show();
            break;

    }

}

function buscar_reporte_pedidos_log() {


    $.ajax({
        type: "POST",
        url: ruta_consultas + 'generar_grilla_reportes.jsp',
        data: ({estado: $('#cbox_tipo').val(), fecha_desde: $('#desde').val(), fecha_hasta: $('#hasta').val()}),
        beforeSend: function ()
        {
            cargar_load("Consultando..");
            $('#div_grilla').html("");
        },
        success: function (res)
        {
            $('#div_grilla').html(res.grilla);
            cerrar_load();
        },
        error: function (error)
        {
            cerrar_load();
        }
    });

}

function solo_numeros_td() {

    $(".single_line").keydown(function (e)
    {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 || ((e.keyCode == 65 || e.keyCode == 86 || e.keyCode == 67) && (e.ctrlKey === true || e.metaKey === true)) || (e.keyCode >= 35 && e.keyCode <= 40))
        {
            return;
        }
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))
        {
            e.preventDefault();
        }
        if (cont_filtro == 0) {
            $('input[type=search]').addClass('celdas');
            $(".celdas").keyup(function (event) // AL BUSCADOR DEL DATATABLE LE HAGO QUE AL TIPEAR CALCULE DE VUELTA TODAS LAS CELDAS
            {
                obtener_valores_celda('1');
            });
        }

        cont_filtro++;
    });
}

function cambiar_camion_log(id_camion, id_pedido, capacidad)
{
    $("#id_camion_cambio").val(id_camion);
    $("#id_pedido_cambio").val(id_pedido);
    $.ajax({
        type: "POST",
        url: ruta_consultas + 'consulta_option_camiones_cambio.jsp',
        data: ({capacidad: capacidad}),
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            $("#select_camion").html("");
            $("#select_camion").html(res.select);
            $("#select_camion").val(id_camion);

        }
    });
}

function crud_cambiar_camion(id_camion, id_pedido, id_camion_nuevo)
{

    Swal.fire({

        title: 'CONFIRMACION',
        text: "DESEA REALIZAR EL CAMION DE CAMION?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: cruds + 'control_editar_camion.jsp',
                data: ({id_camion: id_camion, id_pedido: id_pedido, id_camion_nuevo: id_camion_nuevo}),
                beforeSend: function ()
                {
                },
                success: function (res)
                {

                    swal.fire({
                        type: 'success',
                        html: res.mensaje,
                        confirmButtonText: "CERRAR"
                    });
                    $('#modal_cambio_camion').modal('toggle');
                    $('.modal-backdrop').remove();
                    ir_pagina('contenedor_pedidos_generados_menu.jsp');
                }
            });
        }
    });



}