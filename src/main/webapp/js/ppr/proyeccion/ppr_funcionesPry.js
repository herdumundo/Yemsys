
function ir_padrones_ppr() {
    $.ajax({
        type: "POST",
        url: rutaContenedoresPprProyeccion + "contenedor_padrones.jsp",
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data) {
            $("#contenedor_principal").html(data);
            ir_grillaPadronesCabecera_ppr()
            cerrar_load();
        }
    });
}



function ir_grillaPadronesById_ppr(id,nombrePadron) {
    $.ajax({
        type: "POST",
        url: rutaConsultasPprProyeccion + "consulta_grilla_padronById.jsp",
        data:{id:id,nombrePadron:nombrePadron},
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data) {
            $("#div_grilla_pry_det").html("");
            $("#div_grilla_pry_det").html(data.grilla);
            $("#grillaPadronById").DataTable()
            cerrar_load();
        }
    });
}


function ir_grillaPadronesCabecera_ppr() {
    $.ajax({
        type: "POST",
        url: rutaConsultasPprProyeccion + "consulta_grilla_padronPrincipal.jsp",
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data) {
            $("#div_grilla_pry").html("");
            $("#div_grilla_pry").html(data.grilla);
            $("#grillaPadronCab").DataTable()
            cerrar_load();
        }
    });
}


function clonarPadronPpr(id){
      
   
    var html='<div class="modal-header bg-navy">'+
               ' <h5 class="modal-title " id="exampleModalLabel"><strong>Duplicacion de padron</strong></h5> <div id="noti_capacidad">   </div> </div> '+"<form  > <br>\n\
                \n\
            <table class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable ' > \n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Nombre padron:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese nombre'     type='text'  id='txt_nombrePadron'  ></th>\n\
                </tr>\n\
            </table><div class='box01'><div class='box02' id='div_grilla_ventas_mes'></div> <div class='box03' id='div_grilla_ventas_mes_log'></div></div>  <div id='div_grilla_saldo_ventas'> </div> <div id='div_grilla_lotes_ventas'> </div> <br>  \n\
            <input type='button' class='btn bg-navy' value='Registrar'  onclick=\"crudClonarPadron_ppr("+id+",$('#txt_nombrePadron').val())\">\n\
</form> ";  
    
    Swal.fire({
                             html: html,
                            showCancelButton: false,
                            showConfirmButton: false,
 
                        });
 }
 
 
function crudClonarPadron_ppr(id,nombrePadron) {
    $.ajax({
        type: "POST",
        url: crudPprProyeccion + "crudClonarPadronPor.jsp",
        data:{id:id,nombrePadron:nombrePadron},
        beforeSend: function (xhr) {
             Swal.fire({
                title: "PROCESANDO!",
                html: "<strong>ESPERE</strong>...",
                showCancelButton: false,
                showConfirmButton: false,
                allowOutsideClick: !1,
                willOpen: () => {
                    Swal.showLoading()
                }
            });        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaPadronesCabecera_ppr()
        }
    });
}

 
function registrarCambiosPadron(id){
    var filas = document.querySelectorAll("#grillaPadronById tbody tr");
    jsonObj = [];
    var cont = 0;
    filas.forEach(function (e)
    {
        var columnas = e.querySelectorAll("td");
        item = {}
        item ["padron_id"] = id;
        item ["edad"] = columnas[0].textContent;
        item ["viabilidad"] = columnas[1].textContent;
        item ["mortandad_diaria"] = columnas[3].textContent;
        item ["productividad"] = columnas[2].textContent;
        jsonObj.push(item);
        cont++;
    });
    var json_string = JSON.stringify(jsonObj);
        
        $.ajax({
        type: "POST",
        url: crudPprProyeccion + "crudActualizarPadron.jsp",
        data:{id:id,json_string:json_string},
        beforeSend: function (xhr) {
             Swal.fire({
                title: "PROCESANDO!",
                html: "<strong>ESPERE</strong>...",
                showCancelButton: false,
                showConfirmButton: false,
                allowOutsideClick: !1,
                willOpen: () => {
                    Swal.showLoading()
                }
            });        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaPadronesCabecera_ppr()
        }
    });
} 