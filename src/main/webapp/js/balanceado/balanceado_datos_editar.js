 
function editar_solicitud_bal(id,estado)
{

    $.ajax({
        type: "POST",
        url: ruta_contenedores_bal + 'contenedor_solicitud_cambio_formula_editar.jsp',
        data: ({
            id: id,estado:estado }),
        beforeSend: function ()
        { 
            cargar_load("Cargando...");
        },
        success: function (data)
        { 
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_global("dd/mm/yyyy",false);

             $("#tb_formulacion").DataTable({
                paging: false,
                ordering:false,
                        responsive: true,
                 "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
            });
            
             
            var editables = document.querySelectorAll("[contentEditable]");
            for (var i = 0, len = editables.length; i < len; i++)
            {
                editables[i].onblur = function ()
                { 
                    var cantidad_inicial=this.innerHTML.replaceAll(",",".") ;
                    this.setAttribute("cantidad",cantidad_inicial);
                    var cantidad_original=this.getAttribute("cantidad_sap");
                    if(cantidad_original==cantidad_inicial)
                    {
                        this.setAttribute("estado", "NEUTRO");                    
                    }
                    else
                    {
                        this.setAttribute("estado", "MODIFICADO");                    
                    }
                    sumar_cantidad_mtp_bal();                  
                    colorear_celdas_cantidad_sol_edit_bal(this.getAttribute("id"));
                }
                
                colorear_celdas_cantidad_sol_edit_bal(editables[i].getAttribute("id"));
                    sumar_cantidad_mtp_bal();                  

            }
            $('[contenteditable="true"]').keypress(function(e) 
            {
                var x = event.charCode || event.keyCode;
                if (isNaN(String.fromCharCode(e.which)) && x!=44 || x===32 || x===13 || (x===44 && event.currentTarget.innerText.includes(','))) e.preventDefault();
            });
            
            
            $("#formulario").on("submit", function (e) {
                e.preventDefault(), 
                    validar_datos_mtp_edit_sol(), 
                e.stopPropagation();
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





function validar_datos_mtp_edit_sol(){
    var cantidad_validada=$("#total_insumos").html();
    var id=$("#id_pedido").val();
    var fecha_modificacion=$("#fecha_solicitud").val();
    var estado=$("#estado").val();
       
    if(cantidad_validada=="1000.000")
    {
        var grilla = document.querySelectorAll("[grilla]");
             jsonObj = [];
        for (var i = 0, len = grilla.length; i < len; i++)
        {
                item = {}
                item ["accion"]             = grilla[i].getAttribute("estado");
                item ["codigo_formula"]     = $("#select_formula").val();
                item ["codigo_mtp"]         = grilla[i].getAttribute("id");
                item ["descripcion"]        = grilla[i].getAttribute("ingrediente");
                item ["cantidad_nueva"]     = grilla[i].getAttribute("cantidad");
                item ["cantidad_actual"]    = grilla[i].getAttribute("cantidad_sap");
                item ["costo"]              = grilla[i].getAttribute("costo");
                item ["grupo"]              = grilla[i].getAttribute("grupo"); 
                jsonObj.push(item);

        }
        var json_string = JSON.stringify(jsonObj);

                Swal.fire({
                          title: 'FORMULA ',
                          text: "DESEA REALIZAR LA MODIFICACION DE SOLICITUD DE CAMBIO DE FORMULA?",
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
                                  url: ruta_cruds_bal + 'control_modificacion_solicitud_mtp_bal.jsp',
                                  data: ({
                                      json_string: json_string,id:id,estado:estado,fecha_modificacion:fecha_modificacion}),
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

                  else {
        
          aviso_generico(2, "LA SOLICITUD DEBE SER IGUAL A 1 TONELADA.");
    }
    
}

function colorear_celdas_cantidad_sol_edit_bal(id)
{
    
    var cantidad=$("#"+id).attr("cantidad").replaceAll(",",".");
    var cantidad_original= $("#"+id).attr("cantidad_sap");
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


function calculo_grilla_edit_solicitud_bal(id)
{
        
    if($("."+id).val()=="Reactivar")
    {
        $("."+id).html("Quitar de formula");
        $("."+id).val("Quitar de formula");
        $("#"+id).attr("contentEditable",true);
        $("#"+id).attr("estado_anterior",$("#"+id).attr("estado"));
        $("#BTN" + id).removeClass('bg-danger ').addClass('bg-success');
        var cantidad=$("#"+id).attr("cantidad").replaceAll(",",".");
        var cantidad_sap=$("#"+id).attr("cantidad_sap").replaceAll(",",".");
        var cantidad_original= $("#"+id).attr("cantidad_historial");
        if(cantidad==cantidad_sap)
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

function eliminar_fila_mtp_edit_sol(id_tr)
{
    var table = $('#tb_formulacion').DataTable();//OBTENGO EL ID DE MI TABLA.
    //  var id_tr = table.cell($(this).closest('tr'), 7).data();// OBTENGO EL VALOR DE LA POSICION 8 DE LA FILA SELECCIONADA PARA ELIMINAR, EN ESTE CASO SELECCIONO EL ID DEL LOTE.
    table.row($('#row' + id_tr)).remove().draw();
    sumar_cantidad_mtp_bal();
}



function add_filas_sol_edit_bal() {
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
        $(rowNode).find('td').eq(2).attr("cantidad_sap",cantidad_planificada);//AGREGAR CLASES AL LA CELDA POSICION 1
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
 
function modal_detalle_formulacion_bal(id_seleccionado,formula_seleccionada,desc_formula)
 {
        var n  ="<form id=\"form_verificar\"><br>\n\
        <div class='ribbonvert'> <span class='ribbon2'><b>Nro. <br>"+id_seleccionado+"</b></span>  \n\
        <br> <center><b>"+desc_formula+"</b></center>  </div>\n\
        \n\
        \n\        <div class='bg-black'><label> Formulas pendientes que desea incluir (Opcional)</label></div> \n\ \n\
        <div id=\"div_grilla_form_pen\"> </div> <br>         \n\
        <button type='button' onclick=\"visualizar_detalle_formulacion_bal()\" class='btn bg-black btn-block'><i class='fa fa-eye '></i> Visualizar detalle</button> \n\
        </form>";
        Swal.fire({ type: "warning",   customClass: 'swal-wide',html: n, showCancelButton: false, showConfirmButton: false});
        cargar_select_formulas_seleccionables_bal(id_seleccionado,formula_seleccionada,desc_formula);
        $(".colorear").css('background','white');
        $(".colorear").css('color','black');
        $("#p"+id_seleccionado).css('background','#030E3C');            
        $("#p"+id_seleccionado).css('color','white');            
        
 }
 
 function cargar_select_formulas_seleccionables_bal(id_seleccionado,formula_seleccionada,desc_formula)
 {
   
    $.ajax({
        type: "POST",
        url: ruta_consultas_bal+'consulta_gen_select_formulas_pendientes.jsp',
        data: ({ id_seleccionado:id_seleccionado,formula_seleccionada:formula_seleccionada,desc_formula:desc_formula}),
        success: function (data)
        {
            $("#div_grilla_form_pen").html(data.grilla);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
 }
 
 
function seleccionar_row_formulacion_pendiente_bal(id)
{
    var valor=$("#"+id).attr("data-boleano");   
    if(valor=="false")
    {
        $("#"+id).val("Quitar");
        $("#"+id).attr("data-boleano",true);
        $("#" + id).removeClass('bg-navy').addClass('bg-danger');
    }
    else 
    {
        $("#"+id).val("Seleccionar");
        $("#"+id).attr("data-boleano",false);
        $("#" + id).removeClass('bg-danger').addClass('bg-navy');
    }
}

function visualizar_detalle_formulacion_bal(){
        var ids="";
        var cod_formulas="";
        var cod_formula=$("#formula_seleccionada").attr("data-formula");
        var id_pedido   =$("#formula_seleccionada").attr("data-id_pedido");
        var editables = document.querySelectorAll("[data-boleano=true]");
        for (var i = 0, len = editables.length; i < len; i++)
        {
            if(i==0)
            {
                ids= editables[i].getAttribute("id"); 
                cod_formulas= editables[i].getAttribute("data-formula"); 
            }
            else
            {
                ids= ids+","+editables[i].getAttribute("id"); 
                cod_formulas=cod_formulas+","+ editables[i].getAttribute("data-formula"); 
            }
        }
        ir_pendientes_solicitud_ingredientes_bal(ids,cod_formulas,id_pedido,cod_formula);
        
 }
 
 
 
 
function baja_pedido_bal(id) {
    var n  ="<form id='form_baja'><br><br>\n\
         \n\
        <label>Ingrese Motivo</label>\n\
        <textarea rows='4' cols='50'  class='form-control ' id='verificar' name='verificar' placeholder='Motivo' required='true' >   </textarea> \n    \n\
        <input type='hidden' name='id_pedido' id='id_pedido' value='"+id+"'>            \n\
 <input type='submit'  value='DAR DE BAJA' class='form-control bg-success btn color_letra'>\n                \n\
        </form>";
            Swal.fire({title: "Baja del pedido" , type: "warning", html: n, showCancelButton: false, showConfirmButton: false});
            
            control_baja_bal();
  }
  
  
  
function control_baja_bal() {
    $("#form_baja").submit(function (e) {
        e.preventDefault();
        var ver=$("#verificar").val().trim();
        if(ver.length==0){
            
            alert("DEBE INGRESAR EL MOTIVO");
        }
        else{
            
                $.ajax({
                    type: "POST",
                    url: ruta_cruds_bal + "control_baja_bal.jsp",
                    data: $("#form_baja").serialize(),
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
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });        
            }
            e.stoppropagation();
    });
}

/*
function probar_api(){
    
    $.ajax({
                type: "POST",
                url:  "control.jsp",
                
                headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJtbG9wZXoiLCJleHAiOjE2NjI0MDc3NDMsImlhdCI6MTY2MjQwNDc0M30.52lCwPIUEJhBNWcxcCT3w9ny-7K46CZsMqlmDdHMOnk"},
                beforeSend: function () 
                {

                },
                success: function (data) 
                { 
                    $.each(data, function (i, item)
                    {
                        document.write(item.nombre);    
                    } ); 
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) 
                {
                     
                       alert(textStatus);     
                    
                }
            });  
}*/