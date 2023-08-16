
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


function ir_escenarios_ppr() {
    $.ajax({
        type: "POST",
        url: rutaContenedoresPprProyeccion + "contenedor_escenario.jsp",
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data) {
            $("#contenedor_principal").html(data);
            ir_grillaEscenariosCabecera_ppr()
            cerrar_load();
        }
    });
}


function ir_grillaEscenariosById_ppr(id, nombre) {
    $.ajax({
        type: "POST",
        url: rutaConsultasPprProyeccion + "consulta_grilla_escenarioById.jsp",
        data: {id: id, nombre: nombre},
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data) {
            $("#div_grilla_pry_det").html("");
            $("#div_grilla_pry_det").html(data.grilla);
            $("#grillaPadronById").DataTable({
                "paging": false // Desactivar paginación
                        // Puedes agregar más opciones de configuración aquí si es necesario
            })
            cerrar_load();
        }
    });
}

function ir_grillaPadronesById_ppr(id, nombrePadron) {
    $.ajax({
        type: "POST",
        url: rutaConsultasPprProyeccion + "consulta_grilla_padronById.jsp",
        data: {id: id, nombrePadron: nombrePadron},
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (data) {
            $("#div_grilla_pry_det").html("");
            $("#div_grilla_pry_det").html(data.grilla);
            $("#grillaPadronById").DataTable({
                "paging": false // Desactivar paginación
                        // Puedes agregar más opciones de configuración aquí si es necesario
            })
            cerrar_load();
        }
    });
}

function ir_grillaEscenariosCabecera_ppr() {
    $.ajax({
        type: "POST",
        url: rutaConsultasPprProyeccion + "consulta_grilla_escenarioPrincipal.jsp.jsp",
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


function clonarEscenarioPpr(id) {


    var html = '<div class="modal-header bg-navy">' +
            ' <h5 class="modal-title " id="exampleModalLabel"><strong>Duplicacion de escenario</strong></h5> <div id="noti_capacidad">   </div> </div> ' + "<form  > <br>\n\
                \n\
            <table class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable ' > \n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Nombre escenario:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese nombre'     type='text'  id='nombreEscenario'  ></th>\n\
                </tr>\n\
            </table><div class='box01'><div class='box02' id='div_grilla_ventas_mes'></div> <div class='box03'  ></div></div>    <br>  \n\
            <input type='button' class='btn bg-navy' value='Registrar'  onclick=\"crudClonarEscenario_ppr(" + id + ",$('#nombreEscenario').val())\">\n\
</form> ";

    Swal.fire({
        html: html,
        showCancelButton: false,
        showConfirmButton: false,

    });
}

function clonarPadronPpr(id) {


    var html = '<div class="modal-header bg-navy">' +
            ' <h5 class="modal-title " id="exampleModalLabel"><strong>Duplicacion de padron</strong></h5> <div id="noti_capacidad">   </div> </div> ' + "<form  > <br>\n\
                \n\
            <table class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable ' > \n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Nombre padron:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese nombre'     type='text'  id='txt_nombrePadron'  ></th>\n\
                </tr>\n\
            </table><div class='box01'><div class='box02' id='div_grilla_ventas_mes'></div> <div class='box03' id='div_grilla_ventas_mes_log'></div></div>  <div id='div_grilla_saldo_ventas'> </div> <div id='div_grilla_lotes_ventas'> </div> <br>  \n\
            <input type='button' class='btn bg-navy' value='Registrar'  onclick=\"crudClonarPadron_ppr(" + id + ",$('#txt_nombrePadron').val())\">\n\
</form> ";

    Swal.fire({
        html: html,
        showCancelButton: false,
        showConfirmButton: false,

    });
}


function cuadroCreacionPadron() {


    var html = '<div class="modal-header bg-navy">' +
            ' <h5 class="modal-title " id="exampleModalLabel"><strong>Creacion de padron</strong></h5> <div id="noti_capacidad">   </div> </div> ' + "<form  > <br>\n\
                \n\
            <table class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable ' > \n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Nombre padron:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese nombre'     type='text'  id='txt_nombrePadron'  ></th>\n\
                </tr>\n\
   \n\         <tr>\n\
    \n\             <th class='text-left'>Raza:  </th>\n\
                    <th > <select class='form-control' id='selectRaza' ><option value='3'>BROWN NICK</option><option value='2'>HISEX BROWN</option><option  value='1'>LOHMANN BROWN</option> </select> </th>\n\
                </tr>\n\
            </table> \n\
            <input type=\"button\" class=\"btn bg-navy\" value=\"Crear\" onclick=\"crudCrearPadron_ppr($('#txt_nombrePadron').val(),$('#selectRaza').val())\">\n\
</form> ";

    Swal.fire({
        html: html,
        showCancelButton: false,
        showConfirmButton: false,

    });
}


function cuadroCreacionEscenario() {

    var option="<option value='1'>Segun padron por dias</option><option value='2'>Segun padron por semanas</option><option  value='3'>Segun parametro general</option><option value='4'>Segun parametro por etapas</option> ";
    var html = '<div class="modal-header bg-navy">' +
            ' <h5 class="modal-title " id="exampleModalLabel"><strong>Creacion de escenarios</strong></h5>  </div> ' + "<form  > <br>\n\
                \n\
            <table class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable ' > \n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Nombre del escenario:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese nombre'     type='text'  id='nombreEscenario'  ></th>\n\
                </tr>\n\
\n\    \n\         <tr>\n\
    \n\             <th class='text-left'>Inicio periodo:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese inicio periodo'     type='text'  id='inicioPeriodo'  ></th>\n\
                </tr>\n\
\n\    \n\         <tr>\n\
    \n\             <th class='text-left'>Fin periodo:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese fin periodo'     type='text'  id='finPeriodo'  ></th>\n\
                </tr>\n\
   \n\         <tr>\n\
    \n\             <th class='text-left'>Raza:  </th>\n\
                    <th > <select class='form-control' id='idRaza' ><option value='3'>BROWN NICK</option><option value='2'>HISEX BROWN</option><option  value='1'>LOHMANN BROWN</option> </select> </th>\n\
                </tr>\n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Calculo de mortandad:  </th>\n\
                    <th > <select class='form-control' id='calculoMortandad' >"+option+"</select> </th>\n\
                </tr>\n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Calculo de produccion:  </th>\n\
                    <th > <select class='form-control' id='calculoProduccion' > "+option+"</select> </th>\n\
                </tr>\n\
            </table> \n\
            <input type=\"button\" class=\"btn bg-navy\" value=\"Crear\" onclick=\"crudCrearEscenario_ppr($('#nombreEscenario').val(),$('#inicioPeriodo').val(),$('#finPeriodo').val(),$('#idRaza').val(),$('#calculoMortandad').val(),$('#calculoProduccion').val())\">\n\
</form> ";

    Swal.fire({
        html: html,
        showCancelButton: false,
        showConfirmButton: false,

    });
    
 }


function crudClonarEscenario_ppr(id, nombreEscenario) {
    $.ajax({
        type: "POST",
        url: crudPprProyeccion + "crudClonarEscenario.jsp",
        data: {id: id, nombreEscenario: nombreEscenario},
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
            });
        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaEscenariosCabecera_ppr()()
        }
    });
}
function crudClonarPadron_ppr(id, nombrePadron) {
    $.ajax({
        type: "POST",
        url: crudPprProyeccion + "crudClonarPadronPor.jsp",
        data: {id: id, nombrePadron: nombrePadron},
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
            });
        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaPadronesCabecera_ppr()
        }
    });
}


function crudCrearEscenario_ppr(nombreEscenario,inicioPeriodo,finPeriodo,idRaza,calculoMortandad,calculoProduccion) {
    $.ajax({
        type: "POST",
        url: crudPprProyeccion + "crudCrearEscenario.jsp",
        data: {nombreEscenario: nombreEscenario, inicioPeriodo: inicioPeriodo,finPeriodo:finPeriodo,idRaza:idRaza,calculoMortandad:calculoMortandad,calculoProduccion:calculoProduccion},
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
            });
        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaEscenariosCabecera_ppr()
        }
    });
}

function crudCrearPadron_ppr(nombrePadron,idRaza) {
    $.ajax({
        type: "POST",
        url: crudPprProyeccion + "crudCrearPadron.jsp",
        data: {idRaza: idRaza, nombrePadron: nombrePadron},
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
            });
        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaPadronesCabecera_ppr()
        }
    });
}
function registrarCambiosPadron(id) {
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
        data: {id: id, json_string: json_string},
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
            });
        },
        success: function (data) {
            aviso_generico(data.tipo_respuesta, data.mensaje)
            ir_grillaPadronesCabecera_ppr()
        }
    });
} 