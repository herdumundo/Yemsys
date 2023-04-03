/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function ir_solCambioFormula_bal()
{
    window.location.hash = "SCFBAL";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_solicitud_cambio_formula.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            $('.selectpicker').selectpicker();
            formato_multiselect_idioma();
            cargar_estilo_calendario_global("dd/mm/yyyy",false);
            $(".checkbox").bootstrapToggle(),
            cargar_toggles_bal();
    
            $("#formulario").on("submit", function (e) {
                e.preventDefault(), 
                validar_datos_mtp_sol(), 
                e.stopPropagation();
            })
            cerrar_load();
    
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}

 function formato_multiselect_idioma() 
{
    $('.selectpicker').selectpicker({selectAllText: "Seleccionar todo",
        deselectAllText: "Deseleccionar todo", noneSelectedText: "Nada seleccionado",
        noneResultsText: "No se encontraron resultados"});
}

  
  
function clonar_cabecera_pedido_bal()
{
     $.ajax({
        type: "POST",
        url: ruta_consultas_bal+ "consulta_clonar_cabecera_pedido.jsp",
        data:({
            
         //Variable opcional-igualar al JSon                                            //Nombre del Campo
          id:                                                                          $("#Clonar_Cabecera").val() 
 
        }),
    
        success: function (data)
        {
            $("#indicadores").val                 ("");
            $("#motivo").val                      ("");     
            $("#plazo_evaluacion").val            ("");
            $("#recomendado").val                 (""); 
            $("#resultado_esperado").val          ("");
            $("#checkUrgente").val                ("");                   
            $("#observacion").val                 (""); 
            $("#fecha_solicitud").val       ("");
            $('#aviario').selectpicker('val','');
            $('#aviario').selectpicker('refresh');

            $("#indicadores").val                 (data.indicadores);
            $("#motivo").val                      (data.motivo);     
            $("#plazo_evaluacion").val            (data.plazo);
            $("#recomendado").val                 (data.recomendado); 
            $("#resultado_esperado").val          (data.resultado_esperado);
            
            $("#checkUrgente").val                (data.caracter);                   
            $("#observacion").val                 (data.observacion);
            $("#fecha_solicitud").val       (data.fecha_modificacion);
            
      
            
            if(data.selected.trim()!=""){
                   $('#aviario').val(data.selected.split(','));
            $('#aviario').selectpicker('refresh');  
             
            }
       
          
               if(data.tonela.trim()==""){
                 $("#chkToggle2").bootstrapToggle('on')   
                       
            }else{
                $("#chkToggle2").bootstrapToggle('off');
                  $("#toneladas").val  (data.tonela)
                
            } 
             
             
           
            if(data.impacto =="SI"){
                $("#chkToggleImpacto").bootstrapToggle('on');
                $("#impacto").val                     (data.impacto_desc);
            }else{
                $("#chkToggleImpacto").bootstrapToggle('off');
                
                
            }
             
            if(data.caracter =="SI"){
                $("#checkUrgente").bootstrapToggle('on');
            }else{
                $("#checkUrgente").bootstrapToggle('off');
            }
 
 
 
            $(document).ready(function ()
            {
                $("#Clonar_Cabecera").click(function () {
                    alert($('input:checkbox[name=cform-control is-invalid]:checked').val());
                    $("#formulario").submit();
                    
                });
            });
                
              
            
         },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}



function cargar_toggles_bal() 
{
    
     $("#chkToggle_1").change(function () {
         //1 == $(this).prop("checked") ? ($("#Clonar_Cabecera").removeAttr("required"),$("#div_cab").hide(),$("#Clonar_Cabecera").val(""))  :  ($("#Clonar_Cabecera").attr("required",true),$("#div_cab").show(),$("#Clonar_Cabecera").val(""))  ;
         1 == $(this).prop("checked") ? ($("#Clonar_Cabecera").attr("required",true),$("#div_cab").show() ,$("#Clonar_Cabecera").val(""))  :  ($("#Clonar_Cabecera").removeAttr("required"),$("#div_cab").hide(),$("#Clonar_Cabecera").val(""))  ;
         
         1 == $(this).prop("checked") ? ($("#impacto").attr("required",true),$("#div_impacto").show() ,$("#impacto").val(""))  :  ($("#impacto").removeAttr("required"),$("#div_impacto").hide(),$("#impacto").val(""))  ;

     }); 
    
    $("#chkToggle2").change(function () {
         1 == $(this).prop("checked") ? ($("#toneladas").removeAttr("required"),$("#div_ton").hide(),$("#toneladas").val(""))  :  ($("#toneladas").attr("required",true),$("#div_ton").show(),$("#toneladas").val(""))  ;
    }); 
    
    $("#chkToggleImpacto").change(function () {
         1 == $(this).prop("checked") ? ($("#impacto").attr("required",true),$("#div_impacto").show() ,$("#impacto").val(""))  :  ($("#impacto").removeAttr("required"),$("#div_impacto").hide(),$("#impacto").val(""))  ;
    }); 
    
    $("#checkUrgente").change(function () {
         1 == $(this).prop("checked") ? ($("#checkUrgente").attr("URGENTE","SI") )  :  ($("#checkUrgente").attr("URGENTE","NO") )  ;
    }); 
    
    
    
}

function ir_grilla_formulacion_bal()
{
     $.ajax({
        type: "POST",
        data:({
            father:          $('#select_formula').val()}),
       
        url: ruta_consultas_bal + "consulta_gen_grilla_formulacion.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#div_grilla").html("");
            $("#div_grilla").html(data.grilla);
            $("#div_grilla").html(data.grilla3);
            $("#tb_formulacion").DataTable({ 
                "scrollX": true,
                paging: false,
                ordering:false,
                        responsive: true,
                 "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                
            });
            ir_grilla_nutrientes_bal();
            sumar_cantidad_mtp_bal();
            var editables = document.querySelectorAll("[contentEditable]");
            for (var i = 0, len = editables.length; i < len; i++)
            {
                editables[i].onblur = function ()
                { 
                    var cantidad_inicial=this.innerHTML.replaceAll(",",".") ;
                    this.setAttribute("cantidad",cantidad_inicial);
                    var cantidad=this.innerHTML;
                    var cantidad_original=this.getAttribute("cantidad_historial");
                    if(cantidad_original==cantidad_inicial)
                    {
                        this.setAttribute("estado", "NEUTRO");                    
                    }
                    else
                    {
                        this.setAttribute("estado", "MODIFICADO");                    
                     }
                    sumar_cantidad_mtp_bal();                  
                    colorear_celdas_cantidad_sol_bal(this.getAttribute("id"));
                }
            }
            $('[contenteditable="true"]').keypress(function(e) 
            {
                var x = event.charCode || event.keyCode;
                if (isNaN(String.fromCharCode(e.which)) && x!=44 || x===32 || x===13 || (x===44 && event.currentTarget.innerText.includes(','))) e.preventDefault();
            });
            solo_numeros_td();
            get_mtp_bal_select();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}
function ir_grilla_nutrientes_bal()
{
     $.ajax({
        type: "POST",
        data:({
                             
            cod_formula:            $('#select_formula').val()}),
        
        url: ruta_consultas_bal + "consulta_gen_grilla_nutrientes.jsp",
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#div_nutrientes").html("");
            $("#div_nutrientes").html(data.grilla);
solo_numeros_td()
         
        
       
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}


 function sumar_cantidad_mtp_bal()
{
            var cant=0;
     var editables = document.querySelectorAll("[contentEditable=true]");
            for (var i = 0, len = editables.length; i < len; i++)
            {
               cant=cant+ parseFloat(editables[i].getAttribute("cantidad"));
             }
           $("#total_insumos").html(cant.toFixed(3));  
           $("#total_insumos_faltantes").html(cant.toFixed(3)-1000.000);  
            
}

function calculo_grilla_solicitud_bal(id)
{
        
    if($("."+id).val()=="Reactivar")
    {
        $("."+id).html("Quitar de formula");
        $("."+id).val("Quitar de formula");
        $("#"+id).attr("contentEditable",true);
        $("#"+id).attr("estado_anterior",$("#"+id).attr("estado"));
        $("#BTN" + id).removeClass('bg-danger ').addClass('bg-success');
        var cantidad=$("#"+id).attr("cantidad").replaceAll(",",".");
        var cantidad_original= $("#"+id).attr("cantidad_historial");
        if(cantidad_original==cantidad)
        {
             $("#"+id).attr("estado", "NEUTRO");       
         }
        else
        {
             $("#"+id).attr("estado", "MODIFICADO");                    
        }
    }
    else 
    {
        $("."+id).html("Reactivar");
        $("."+id).val("Reactivar");
        $("#"+id).attr("contentEditable",false);
        $("#"+id).attr("estado_anterior",$("#"+id).attr("estado"));
        $("#"+id).attr("estado","ELIMINADO");
        $("#BTN" + id).removeClass('bg-success ').addClass('bg-danger');

    }
     
    sumar_cantidad_mtp_bal();
}

function colorear_celdas_cantidad_sol_bal(id)
{
    
    var cantidad=$("#"+id).attr("cantidad").replaceAll(",",".");
    var cantidad_original= $("#"+id).attr("cantidad_historial");
    if(cantidad_original==cantidad)
    {
        $("#"+id).removeClass("bg-red");       
        $("#"+id).addClass("bg-white");       
        $("#"+id).removeClass("bg-green");         
    }
    else if (cantidad_original>cantidad)
    {
        $("#"+id).addClass("bg-red");       
        $("#"+id).removeClass("bg-white");       
        $("#"+id).removeClass("bg-green");       
    }
    else
    {
        $("#"+id).removeClass("bg-red");       
        $("#"+id).removeClass("bg-white");       
        $("#"+id).addClass("bg-green");         
    }
}


function get_mtp_bal_select()
{
     $.ajax({
        type: "POST",
        data:({father:$('#select_formula').val()}),
        url: ruta_consultas_bal + "consulta_gen_select.jsp",
        success: function (data)
        { 
            $("#select_mtp").html(data.select);
            cerrar_load();
        }
    });
    
}


function add_filas_sol_bal() {
    var     codigo                  = $("#select_mtp").find(':selected').attr('codigo'),
            descripcion             = $("#select_mtp").find(':selected').attr('descripcion'),
            cantidad_planificada    = $("#select_mtp").find(':selected').attr('cantidad_planificada'),
            cantidad_real           = $("#select_mtp").find(':selected').attr('cantidad_real'),
            costo                   = $("#select_mtp").find(':selected').attr('costo'),
            grupo                   = $("#select_mtp").find(':selected').attr('grupo'),
            codigo_formula          = $("#select_mtp").find(':selected').attr('codigo_formula');
  
    var contador=0;
    var table = $('#tb_formulacion').DataTable();
    var data = table.rows({selected: true}).data();
    for (var i = 0; i < data.length; i++)
    {
        if (data[i][0] == codigo)
        {
            contador++;
        }
    }
        
    if (contador == 0)
    {  
        var newData = [codigo,  descripcion, cantidad_planificada, cantidad_real, costo, 
            grupo, codigo_formula, 
            "<input id=\"BTN" + codigo+ "\"  type=\"button\" class=\"form-control bg-warning " +codigo + " \" onclick=\"eliminar_fila_mtp_sol('"+codigo+"') \" value=\"Deshacer\">"];
        var rowNode = table.row.add(newData).order([1, 'desc']).draw(false).node();
        $(rowNode).find('td').eq(0).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(1).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).addClass('font-weight-bold single_line2 only');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("grilla",true);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("contenteditable",true);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("id",codigo);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("estado","NUEVO");//AGREGAR CLASES AL LA CELDA POSICION 1

        $(rowNode).find('td').eq(2).attr("costo",costo);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("grupo",grupo);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("ingrediente",descripcion);//AGREGAR CLASES AL LA CELDA POSICION 1
        
        
        $(rowNode).find('td').eq(2).attr("onblur","onblur_nueva_mtp_bal('"+codigo+"')");//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("cantidad_historial",cantidad_planificada);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).attr("cantidad",cantidad_planificada);//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(3).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        
        
        $(rowNode).find('td').eq(4).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(5).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(6).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).attr('id', 'row' + codigo);//AGREGA ID AL <tr> FILA.
        solo_numeros_td();
 $('[contenteditable="true"]').keypress(function(e) 
            {
                var x = event.charCode || event.keyCode;
                if (isNaN(String.fromCharCode(e.which)) && x!=44 || x===32 || x===13 || (x===44 && event.currentTarget.innerText.includes(','))) e.preventDefault();
            });
    }
    else 
    {
        aviso_generico(2,"MATERIA PRIMA DUPLICADA");
    }
    
}


function eliminar_fila_mtp_sol(id_tr)
{
    var table = $('#tb_formulacion').DataTable();//OBTENGO EL ID DE MI TABLA.
  //  var id_tr = table.cell($(this).closest('tr'), 7).data();// OBTENGO EL VALOR DE LA POSICION 8 DE LA FILA SELECCIONADA PARA ELIMINAR, EN ESTE CASO SELECCIONO EL ID DEL LOTE.
   table.row($('#row' + id_tr)).remove().draw();
   sumar_cantidad_mtp_bal();
}

function onblur_nueva_mtp_bal(id)
{
    var  valor_td=$("#"+id).html().replaceAll(",",".");
    $("#"+id).attr("cantidad", valor_td);
    sumar_cantidad_mtp_bal();

}



function validar_datos_mtp_sol(){
    var cantidad_validada=      $("#total_insumos").html();
    var resultado_esperado=     $("#resultado_esperado").val();
    var impacto=                $("#impacto").val();
    var plazo_evaluacion=       $("#plazo_evaluacion").val();
    var indicadores=            $("#indicadores").val();
    var urgente=                $("#checkUrgente").attr("URGENTE");
   
    
     
    var desc_formula = $("#select_formula").find(':selected').attr('descripcion');
    
    if(cantidad_validada=="1000.000")
    {
        var grilla          =   document.querySelectorAll("[grilla]");
        
        var grillaNutriente =  document.querySelectorAll("#grillaNutriente tr");

        var fecha_solicitud =   $("#fecha_solicitud").val();
        var toneladas       =   $("#toneladas").val();
        var recomendado     =   $("#recomendado").val();
        var motivo          =   $("#motivo").val();
        var observacion     =   $("#observacion").val();
        
        var valores = $.map(
            $('#aviario option:selected'),
            function(o, i) { return $(o).text(); });
            
    
       
        jsonObj = [];
        for (var i = 0, len = grilla.length; i < len; i++)
        {
                item = {}
                item ["accion"]             = grilla[i].getAttribute("estado");
                item ["codigo_formula"]     = $("#select_formula").val();
                item ["codigo_mtp"]         = grilla[i].getAttribute("id");
                item ["descripcion"]        = grilla[i].getAttribute("ingrediente");
                item ["cantidad_nueva"]     = grilla[i].getAttribute("cantidad");
                item ["cantidad_actual"]    = grilla[i].getAttribute("cantidad_historial");
                item ["costo"]              = grilla[i].getAttribute("costo");
                item ["grupo"]              = grilla[i].getAttribute("grupo"); 
                jsonObj.push(item);

        }
        
        var json_string = JSON.stringify(jsonObj);
        
        
        
        
            jsonNutriente = [];
        for (var i = 1, len = grillaNutriente.length; i < len; i++)
        {
                itemNutriente = {}
                itemNutriente ["id"]            =  grillaNutriente[i].cells[0].innerHTML.toString().trim();
                itemNutriente ["descripcion"]   =  grillaNutriente[i].cells[1].innerHTML;
                itemNutriente ["actual"]        =  grillaNutriente[i].cells[2].innerHTML.toString().trim();
                itemNutriente ["nuevo"]         =  grillaNutriente[i].cells[3].innerHTML; 
                jsonNutriente.push(itemNutriente);

        }
        
        var json_Nutriente = JSON.stringify(jsonNutriente);
        
        
        

                Swal.fire({
                          title: 'FORMULA ',
                          text: "DESEA REALIZAR LA SOLICITUD DE CAMBIO DE FORMULA?",
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
                                  url: ruta_cruds_bal + 'control_registro_solicitud_mtp_bal.jsp',
                                  data: ({
                                      json_string:          json_string,
                                      json_Nutriente:       json_Nutriente,
                                      fecha_solicitud:      fecha_solicitud,
                                      recomendado:          recomendado,
                                      motivo:               motivo,
                                      desc_formula:         desc_formula,
                                      toneladas:            toneladas,
                                      cod_formula:          $("#select_formula").val(),
                                      resultado_esperado:   resultado_esperado,
                                      impacto:              impacto,
                                      plazo_evaluacion:     plazo_evaluacion,
                                      indicadores:          indicadores,
                                      observacion:          observacion,
                                      aviario:              valores.join(','),
                                      urgente:              urgente}),
                                  
                                  beforeSend: function ()
                                  {
                                      Swal.fire({
                                          title: 'PROCESANDO!',
                                          html: 'ESPERE<strong></strong>...',
                                          allowOutsideClick: false,
                        showCancelButton: false,
                        showConfirmButton: false,
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

                  else {
        
          aviso_generico(2, "LA SOLICITUD DEBE SER IGUAL A 1 TONELADA.");
    }
    
}

function ir_pendientes_solicitud_bal()
{
    window.location.hash = "SPENBAL";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_solicitud_pendientes.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cerrar_load();
            $('#example').DataTable({"scrollX": true,"ordering": false,"paging": false, "searching": false});
            $('#example02').DataTable({"scrollX": true,"ordering": false,"paging": false, "searching": false});
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}

function ir_pendientes_ger_solicitud_bal()
{
    window.location.hash = "SPENBAL";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_solicitud_pendientes_gerencia.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            $('#example').DataTable({"scrollX": true,"ordering": false,"paging": false, "searching": false});
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}

function ir_pendientes_formulas_procesar_bal()
{
    
    window.location.hash = "IPFPB";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_formulas_procesar.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            
            cerrar_load();
            
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}
function ir_pendientes_solicitud_ingredientes_bal(ids,cod_formulas,id_pedido,cod_formula)
{
     window.location.hash = "SPENBAL";
    $.ajax({
        type: "POST",
        url: ruta_consultas_bal + "consulta_gen_grilla_solicitud_mtp.jsp",
            data: ({
                ids         :       ids,
                cod_formulas:       cod_formulas,
                id_pedido   :       id_pedido,
                cod_formula :       cod_formula
                        }),
                 
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#div_grilla").html("");
            $("#div_grilla").html(data.grilla);
            $("#div_grilla3").html(data.grilla3);

            $("#tb_formulacion_det").DataTable({
            paging: false,
            "ordering": false,
            "language":
            {
                "sUrl": "js/Spanish.txt"
            
            },  
            
            "rowCallback": function( row, data ) 
            {
                $('td.td_gris', row).css( 'background', '#E8E8E8' );
                $('td.td_negro', row).css( 'background', '#000000' );
            }
                
            });

           
            
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}


function acepCance_solicitud_bal(id,tipo_operacion)
{
    Swal.fire({
            title: 'FORMULA ',
            text: "DESEA REALIZAR LA OPERACION?",
            type: 'warning',
            showCancelButton: false,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'
        }).then((result) => {
            if (result.value)
            {
                $.ajax({
                    type: "POST",
                    url: ruta_cruds_bal + 'control_aprobar_cancelar.jsp',
                    data: ({
                        id: id,
                        tipo_operacion:tipo_operacion }),
                    beforeSend: function ()
                    {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: 'ESPERE<strong></strong>...',
                             showCancelButton: false,
                             showConfirmButton :false,  
                            allowOutsideClick: false,
                            willOpen: () => 
                            {
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
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });

            }
        });
    
    
    }
    




function verificador_gerencia(id) {
    var n  ="<form id='form_verificar'><br><br>\n\
         \n\
        <label>Ingrese observacion</label>\n\
        <textarea rows='4' cols='50'  class='form-control ' id='verificar' name='verificar' placeholder='Motivo' required >   </textarea> \n    \n\
        <input type='hidden' name='id_pedido' id='id_pedido' value='"+id+"'>            \n\
 <input type='submit'  value='SOLICITAR VERIFICACION' class='form-control bg-success btn color_letra'>\n                \n\
        </form>";
            Swal.fire({title: "Solicitud de verificacion" , type: "warning", html: n, showCancelButton: false, showConfirmButton: false});
            
            control_verificador_gerencia();
  }
  
  
  
function control_verificador_gerencia(id) {
    $("#form_verificar").submit(function (e) {
        e.preventDefault(),
                $.ajax({
                    type: "POST",
                    url: ruta_cruds_bal + "control_verificar_bal.jsp",
                    data: $("#form_verificar").serialize(),
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (data) { 
                             
                         aviso_generico(data.tipo_respuesta, data.mensaje)
                        if(data.tipo_respuesta==1)
                        {
                            $("#contenedor_principal").html("");
                        }       
                    },
                }),
                e.stoppropagation();
    });
}


function ir_informes_formulas_procesar_bal (){
    window.location.hash = "IIFPB";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_informe_bal.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_global("dd/mm/yyyy",true);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}



function ir_informes_formulas_procesar_bal2 (desde,hasta){
     $.ajax({
        type: "POST",
        url: ruta_consultas_bal + "consulta_gen_informe.jsp",
        data:({desde:desde,hasta:hasta}),
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#div_grilla2").html("");
            $("#div_grilla2").html(data.grilla);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}





function procesar_sap_bal(id,cod_formula) 
{
    Swal.fire(
        {
            title: 'FORMULA ',
            text: "DESEA MODIFICAR LA FORMULA SAP?",
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
                url: 'http://192.168.6.162/ws/control_add_materia_prima.aspx',
                data: ({ 
                    id:id,cod_formula:cod_formula}),
                beforeSend: function ()
                {
                    Swal.fire({
                        title: 'PROCESANDO!',
                        html: 'ESPERE<strong></strong>...',
                        allowOutsideClick: false,
                        willOpen: () => 
                        {
                            Swal.showLoading()
                        }
                    });
                },
                success: function (data)
                {
                    aviso_generico(data.tipo_respuesta, data.mensaje)
                    if (data.tipo_respuesta == 1)
                    {
                        $("#contenedor_principal").html("");
                    }
                }
            });
        }
    });
}


function ir_pendientes_generados_area() 
{window.location.hash = "IPGA";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_solicitud_pendientes_gen_area.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}



 
function ir_informes_pedidos_creados_por_usuario_bal (){
    window.location.hash = "IIFPBU";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_informe_bal_creados.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_global("dd/mm/yyyy",true);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}




function consulta_informes_pedidos_creados_por_usuario_bal (desde,hasta){
     $.ajax({
        type: "POST",
        url: ruta_consultas_bal + "consulta_gen_informe_por_usuario.jsp",
        data:({desde:desde,hasta:hasta}),
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#div_grilla2").html("");
            $("#div_grilla2").html(data.grilla);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });

}
function ir_materia_prima_bal()
{
    window.location.hash = "SPENBAL";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + "contenedor_materia_prima_sap.jsp",
    
         beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);
            $("#tablaMTP").dataTable({language: {sUrl: "js/Spanish.txt"}});
             cerrar_load();

        }});
}

function activa_desactivar_mtp_bal(itemcode)
        {
    $.ajax({
        type: "POST",
        url: ruta_cruds_bal + 'control_registro_solicitud_mtp_bal_estado.jsp',
        data: ({
            itemcode:                   itemcode
        }),

        success: function (data)
        {
            if (data.estado == 'A')
            {
                $('#btn_mtp'+itemcode).val('Desactivar') 
                
                $('#btn_mtp'+itemcode).removeClass('bg-success') 
                $('#btn_mtp'+itemcode).addClass('bg-danger') 
                
            }
            else{
                $('#btn_mtp'+itemcode).val('Activar')
                
                $('#btn_mtp'+itemcode).removeClass('bg-danger') 
                $('#btn_mtp'+itemcode).addClass('bg-success')         
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}

function carga_grilla_nutrientes() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + 'consulta_gen_grilla_nutrientes.jsp',
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        data: {
            idfechad: $('#idfechad').val(),


        },

        success: function (data) {

            $('#tabla_nutrientes').html(data);

        }
    });

}