  var ruta_contenedores_ptc="./contenedores/ptc/";
  var ruta_cruds_ptc="./cruds/ptc/";
  var ruta_grillas_ptc="./grillas/ptc/";
  var ruta_consultas_ptc="./consultas/ptc/";
  
$(document).on('click', '.btn_remove', function () {
    var button_id = $(this).attr("id");
    //cuando da click obtenemos el id del boton
    $('#row' + button_id + '').remove(); //borra la fila
    //limpia el para que vuelva a contar las filas de la tabla
    $("#adicionados").text("");
    var nFilas = $("#grilla_transfer tr").length;
    $("#adicionados").append(nFilas - 1);
    calcular_tipos_grilla();
    sumar_grilla_reprocesos();
    // obtener_fila();     
});

function cargar_datos_key_trans() {
        if (event.keyCode == 13 || event.which == 13) {
            consulta_lotes_ALMACENAMIENTO ($('#txt_lote').val());
        }
}

function cargar_datos_key_trans_sc() {
        if (event.keyCode == 13 || event.which == 13) {
            consulta_lotes_transferencias_SC($('#txt_lote').val());
        }
}
function cargar_datos_key_trans_procesar() 
{
        if (event.keyCode == 13 || event.which == 13) 
        {
            consulta_lotes_procesar ($('#txt_lote').val());
        }
}

function cargar_datos_key_reproceso_alimentacion() {
        if (event.keyCode == 13 || event.which == 13) {
            consulta_lotes_reproceso_alimentacion($('#txt_lote').val());
        }
}

  function consulta_lotes_ALMACENAMIENTO(id) {
     
        $.ajax({
            type: "POST",
            url: ruta_consultas_ptc + 'transferencia_select_almacenamiento.jsp',
            data: ({id: id}),
            beforeSend: function () {
                $('#div_cargar').show();
            },
            success: function (data)
            {
                 $.each(data, function (i, item)
                {
                    if (item.estado === "0") {
                        aviso_existencia(item.nro_carrito);
                    } else {
                        //alert(item.nro_carrito);
                       cargar_grilla_trans_ptc(item.item_codigo, item.nro_carrito, item.cod_lote, item.cantidad, item.fecha_puesta, item.estado, item.id, item.motivo, item.estado_costeo);
                    }
                });
                 $('#txt_lote').val("");
                 $('#div_cargar').hide();
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
    
}

function consulta_lotes_procesar(id) {
       
   
         $.ajax({
             type: "POST",
            url: ruta_consultas_ptc+'transferencia_select_procesar.jsp',
            data: ({ id: id}),
           // dataType: "html",
            beforeSend: function() {
    $('#div_cargar').show();
            },
            success: function (data) {
               $('#div_cargar').hide();
           $.each(data,function(i, item)
           {  
               if(item.estado==="0"){
                   
                        aviso_existencia(item.nro_carrito);
               }
               else {
                  // alert(item.nro_carrito);
                  cargar_grilla_trans_ptc(item.item_codigo,item.nro_carrito,item.cod_lote,item.cantidad,item.fecha_puesta,item.estado,item.id,item.motivo,item.estado_costeo);   

               
               }
            }    );
              
                
                //alert(data.cod_lote);
               $('#txt_lote').val('');
              //  return data;
             },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
             else {
                aviso_error_conexion();
            }
         }
            
        });
    
}

function consulta_lotes_transferencias_SC(carro) {
   
         $.ajax({
             type: "POST",
            url: ruta_consultas_ptc+'consulta_lotes_transferencias_SC.jsp',
            data: ({ carro: carro}),
            beforeSend: function() {
               $('#div_cargar').show();
                       },           
            success: function (data) {
               $('#div_cargar').hide();
           $.each(data,function(i, item)
           {  
               if(item.estado==="0"){
                        aviso_existencia(item.cod_carrito);
               }
               else {
                     cargar_grilla_trans_SC(item.tipo_huevo,item.cod_carrito,item.cod_interno,item.cantidad,item.fecha_puesta);   
               }
            }    );
               $('#txt_lote').val('');
               
             } ,
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
   
}


function consulta_lotes_reproceso_alimentacion(carro) {
   
         $.ajax({
             type: "POST",
            url: ruta_consultas_ptc+'consulta_lotes_reproceso.jsp',
            data: ({ carro: carro}),
            beforeSend: function() {
               $('#div_cargar').show();
                       },           
            success: function (data) 
            {
                $('#div_cargar').hide();
                $.each(data,function(i, item)
                {  
                    if(item.estado==="0"){
                             aviso_existencia(item.cod_carrito);
                    }
                    else {
                          cargar_grilla_alimentacion_ptc(item.tipo_huevo,item.cod_carrito,item.cod_interno,item.cantidad,item.fecha_puesta,item.descfalla,item.clasificadora_origen);   
                    }
                 }    );
                $('#txt_lote').val('');
                sumar_grilla_reprocesos();   
            } ,
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
}


function cargar_grilla_trans_ptc(item_codigo,nro_carrito,cod_lote,cantidad,fecha_puesta,estado,id,motivo,estado_costeo) {
  
   if (checkId(id)) {
        return aviso_duplicado();
    }  


    $('#grilla_transfer tbody').append('<tr class="suma" id="row' +id + '" > '+
            '<td  class="ocultar" for="id"><b>' + id + '</b></td> '+
            '<td class="ocultar"><b>' + cod_lote +'</b></td>'+
            '<td><b>' +nro_carrito + '</b></td>'+
            '<td><b>' + cantidad+ '</b></td>'+
            '<td><b>' + item_codigo + '</b></td>'+
            '<td><b>' + fecha_puesta + '</b></td>'+
            '<td><b>' +estado +'</b></td>'+
            '<td><b>'+motivo +'</b></td>'+
            '<td><input type="button" value="ELIMINAR" name="remove" id="' + id + '" class="btn btn-danger btn_remove"></td> '+
            '<td><b>' + estado_costeo + '</b></td></tr>');
            calcular_tipos_grilla();
            $(".ocultar").hide();
} 

function cargar_grilla_trans_SC(tipo_huevo,cod_carrito,cod_interno,cantidad,fecha_puesta) 
{
   if (checkId(cod_interno)) {
        return aviso_duplicado();
    }  

  var planchas=parseInt(cantidad)/30;
  var unidades=parseInt(cantidad)-(parseInt(planchas)*30);
  
    $('#grilla_transfer tbody').prepend('<tr class="suma" id="row'+cod_interno + '" > '+
            '<td for="id"><b>' + cod_interno +'</b></td>'+
            '<td><b>' + cod_carrito     + '</b></td>'+
            '<td><b>' + cantidad        + '</b></td>'+
            '<td><b>' + parseInt(planchas)        + '</b></td>'+
            '<td><b>' + unidades        + '</b></td>'+
            '<td><b>' + fecha_puesta    + '</b></td>'+
            '<td><b>' + tipo_huevo      +'</b></td>'+
            '<td><input type="button" value="ELIMINAR" name="remove" id="' + cod_interno + '" class="btn btn-danger btn_remove"></td> ');
} 



function cargar_grilla_alimentacion_ptc(tipo_huevo,cod_carrito,cod_interno,cantidad,fecha_puesta,falla,origen) 
{
   if (checkId(cod_interno)) {
        return aviso_duplicado();
    }  

  var planchas=parseInt(cantidad)/30;
  var unidades=parseInt(cantidad)-(parseInt(planchas)*30);
  
    $('#grilla_transfer tbody').prepend('<tr class="suma" id="row'+cod_interno + '" > '+
            '<td for="id"><b>' + cod_interno +'</b></td>'+
            '<td><b>' + cod_carrito     + '</b></td>'+
            '<td><b>' + cantidad        + '</b></td>'+
            '<td><b>' + parseInt(planchas)        + '</b></td>'+
            '<td><b>' + unidades        + '</b></td>'+
            '<td><b>' + fecha_puesta    + '</b></td>'+
            '<td><b>' + tipo_huevo      +'</b></td>'+
            '<td><b>' + falla      +'</b></td>'+ 
            '<td><b>' + origen      +'</b></td>'+
            '<td><input type="button" value="ELIMINAR" name="remove" id="' + cod_interno + '" class="btn btn-danger btn_remove"></td> ');
} 


function checkId(id) {
    let ids = document.querySelectorAll('#grilla_transfer td[for="id"]');

    return [].filter.call(ids, td => td.textContent === id).length === 1;
}
 
 

function calcular_tipos_grilla(){
     // obtenemos todas las filas del tbody
    var filas = document.querySelectorAll("#grilla_transfer tbody tr");
    var total_tipoCC = 0;
    var total_tipoCA = 0;
    var total_tipoCB = 0;
    var total_tipoCD = 0;
    var total_tipoCS = 0;
    var total_tipoCG = 0;
    var total_tipoCJ = 0;
    // recorremos cada una de las filas
    $('#tipo_ca').val('0');
    $('#tipo_cb').val('0');
    $('#tipo_cc').val('0');
    $('#tipo_cd').val('0');
    $('#tipo_cs').val('0');
    $('#tipo_cj').val('0');
    $('#tipo_cg').val('0');
 var c=0;
    filas.forEach(function (e) {
       
     // if(c>0){
        // obtenemos las columnas de cada fila
        var columnas = e.querySelectorAll("td");
        // obtenemos los valores de la cantidad y importe
        var cantidad_tipoCC = parseFloat(columnas[3].textContent);
        var cantidad_tipoCA = parseFloat(columnas[3].textContent);
        var cantidad_tipoCB = parseFloat(columnas[3].textContent);
        var cantidad_tipoCD = parseFloat(columnas[3].textContent);
        var cantidad_tipoCS = parseFloat(columnas[3].textContent);
        var cantidad_tipoCJ = parseFloat(columnas[3].textContent);
        var cantidad_tipoCG = parseFloat(columnas[3].textContent); 
        var tipo_carro =  columnas[4].textContent;
         
        if (tipo_carro == 'G' && cantidad_tipoCG=="2160") {
            total_tipoCG += cantidad_tipoCG;
            $('#tipo_cg').val(parseInt(total_tipoCG) / 2160);

        }

        if (tipo_carro == 'J' && cantidad_tipoCJ == "4320") {
            total_tipoCJ += cantidad_tipoCJ;
            $('#tipo_cj').val(parseInt(total_tipoCJ) / 4320);

        }
        if (tipo_carro == 'S' && cantidad_tipoCS == "4320") {
            total_tipoCS += cantidad_tipoCS;
            $('#tipo_cs').val(parseInt(total_tipoCS) / 4320);

        }
        if (tipo_carro == 'A' && cantidad_tipoCA == "4320") {
            total_tipoCA += cantidad_tipoCA;
            $('#tipo_ca').val(parseInt(total_tipoCA) / 4320);

        }
        if (tipo_carro == 'B' && cantidad_tipoCB == "4320") {
            total_tipoCB += cantidad_tipoCB;
            $('#tipo_cb').val(parseInt(total_tipoCB) / 4320);

        }
        if (tipo_carro == 'C' && cantidad_tipoCC == "4320") {

            total_tipoCC += cantidad_tipoCC;
            $('#tipo_cc').val(parseInt(total_tipoCC) / 4320);

        }
        if (tipo_carro == 'D' && cantidad_tipoCD == "4320") {
            total_tipoCD += cantidad_tipoCD;

            $('#tipo_cd').val(parseInt(total_tipoCD) / 4320);
        }  
    //}
    c++;
    });
}
 

function enviar_datos_transferencia_PTC(tipo_transferencia) {

    var filas = document.querySelectorAll("#grilla_transfer tbody tr");
    var cod_lote;
    var id;
    var cod_carrito;
    var estado_liberacion;
    var motivo;
    var estado_costeo;
    var cantidad;
    var tipo;

    var c = 0;
    var valores = '';
    // recorremos cada una de las filas
    filas.forEach(function (e)
    {
        var columnas = e.querySelectorAll("td");

     /*   if (c > 0)
        {*/
            id                  = columnas[0].textContent;
            cod_lote            = columnas[1].textContent;
            cod_carrito         = columnas[2].textContent;
            estado_liberacion   = columnas[6].textContent;
            motivo              = columnas[7].textContent;
            cantidad            = columnas[3].textContent;
            tipo                = columnas[4].textContent;
            estado_costeo       = columnas[9].textContent;
            var arr = id + '-' + cod_lote + '-' + cod_carrito + '-' + estado_liberacion + '-' + motivo + '-' + estado_costeo + '-' + cantidad + '-' + tipo;
            if (c == 0) {

                valores = arr;

            } else {
                valores = valores + '&' + arr;
            }
       // }
        c++;
    });
    // alert(valores);
    confirmar_registro_transfer_PTC(valores, tipo_transferencia);

}


function confirmar_registro_transfer_PTC(valor,tipo_transferencia) {
 
    Swal.fire({
           title: 'TRANSFERENCIA DE LOTES',
           text: "DESEA TRANSFERIR LOS LOTES?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
           confirmButtonText: 'SI, TRANSFERIR!',
           cancelButtonText: 'NO, CANCELAR!'
    }).then((result) => {
        if (result.value) {

       control_transferencia_PTC(valor,tipo_transferencia);
      
        }
        });

     
}
 

function control_transferencia_PTC(valor,tipo_transferencia){
   var destino = $('#cbox_destino').val();
   var cbox_camion = $('#cbox_camion').val();
   var cbox_chofer = $('#cbox_chofer').val();

      
     
     Swal.fire({
        title: 'PROCESANDO!',
        html: 'ESPERE<strong></strong>...',
        allowOutsideClick: false,
         willOpen: () => {
                    Swal.showLoading()
                }
               
    }); 
         $.ajax({
            type: "POST",
            url: ruta_cruds_ptc+'transferencia_lotes_control.jsp',
            data: ({
                valor: valor,destino:destino,cbox_camion:cbox_camion,cbox_chofer:cbox_chofer,tipo_transferencia:tipo_transferencia,fecha:$('#fecha').val()}),
             success: function (data) 
            {
                 aviso_registro_transfer(data.tipo,data.mensaje);
                return data;
            } ,
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
}
 
  
 
function sumar_grilla_reprocesos() 
{
    // obtenemos todas las filas del tbody
    var filas = document.querySelectorAll("#grilla_transfer tbody tr");

    var c = 0;
    var cantidad_contenedor = 0;
  
    filas.forEach(function (e)
    {
         if(c>0){
    
        var columnas = e.querySelectorAll("td");
        var cantidad = parseFloat(columnas[2].textContent);
        cantidad_contenedor = cantidad_contenedor + cantidad;
           
   }c++;
    });

    $("#id_cantidad").html("Cantidad ingresada:" + cantidad_contenedor);
}

function validar_transferencia_almacenamiento(){
    
 var cbox_camion=$('#cbox_camion').val();   
 var cbox_destino=$('#cbox_destino').val();   
 var cbox_chofer=$('#cbox_chofer').val();   
 var x = document.getElementById("grilla_transfer").rows.length;
   if(cbox_camion=="-" ||cbox_destino.length==0||cbox_chofer=="-"|| x=="1") {
      
      swal.fire({
            type: 'error',
            title: "ERROR COMPLETAR DATOS ",
            confirmButtonText: "CERRAR"
                        });
        
  } 
  else {
      
        enviar_datos_transferencia_PTC('A');    
  }
 
    
}

function validar_transferencia_procesar_PTC(){
    
 var cbox_camion=$('#cbox_camion').val();   
 var cbox_destino=$('#cbox_destino').val();   
 var cbox_chofer=$('#cbox_chofer').val();   
 var x = document.getElementById("grilla_transfer").rows.length;

  if(cbox_camion=="-" ||cbox_destino.length==0||cbox_chofer=="-"|| x=="1") {
      
      swal.fire({
            type: 'error',
            title: "ERROR COMPLETAR DATOS ",
            confirmButtonText: "CERRAR"
                        });
        
  } 
  else {
      
     enviar_datos_transferencia_PTC('P');    
  }    
}

 
function enviar_datos_transferencia_sc()
{
    var filas = document.querySelectorAll("#grilla_transfer tbody tr");
    jsonObj = [];
    var cont=0;
    filas.forEach(function (e) 
    {
        var columnas = e.querySelectorAll("td");
        item = {}
        item ["cod_interno"]    = columnas[0].textContent;
        item ["cod_carrito"]    = columnas[1].textContent;
        item ["cantidad"]       = columnas[2].textContent;
        jsonObj.push(item);
        cont++;
    });
    
    var destino=$("#cbox_destino").val();
    if($("#cbox_destino").val()==null)
    {
        aviso_error("DEBE SELECCIONAR EL DESTINO");
    }
    else if($("#cbox_chofer").val()==null)
    {
        aviso_error("DEBE SELECCIONAR EL CHOFER");
    }
    else if($("#cbox_camion").val()==null)
    {
        aviso_error("DEBE SELECCIONAR EL CAMION");
    }
    else if(cont==0)
    {
        aviso_error("DEBE INGRESAR LOTE");
    }   
    else
    {
        var json_string = JSON.stringify(jsonObj);
        confirmar_registro_transfer_SC(json_string);     
    }
}

function confirmar_registro_transfer_SC(valor) {
 
    Swal.fire({
           title: 'TRANSFERENCIA DE LOTES',
           text: "DESEA TRANSFERIR LOS LOTES?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
           confirmButtonText: 'SI, TRANSFERIR!',
           cancelButtonText: 'NO, CANCELAR!'
    }).then((result) => {
        if (result.value) 
        {
            $.ajax({
            type: "POST",
            url: ruta_cruds_ptc+'control_registro_transferencia_sc.jsp',
            data: ({
                valor:valor ,chofer:$('#cbox_chofer').val(),destino:$('#cbox_destino').val(),camion:$('#cbox_camion').val() }),
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
                    aviso_registro_transfer(data.tipo_respuesta,data.mensaje)  
             } ,
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
      
        }
        });

     
}
