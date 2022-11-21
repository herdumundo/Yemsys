var ruta_cruds_ppr = "./cruds/ppr/";
var ruta_consultas_ppr = "./consultas/ppr/";
var ruta_vistas_ppr = "./contenedores/contenedores_ppr/";
var ruta_grilla_ppr = "./grillas/ppr/";
var ruta_vistas_general = "./contenedores/";
var ruta_imagen_necropsias = "./necropsias_imagen/";
var ruta_servlet = "../../../java/clases/";
var serial = 0;
let  myChart;
let  chart_lote_productividad;
let  chart_generalAves;
let  chart_generalSemanas;
let  chart_generalSemanasProductividad;
  const options_graf_pry =
    {
        
        legend:
        {
            display:true,
            position: 'top',
        },
        datalabels:
        {   
           align: chart =>{
            return chart.dataset.align;    
           },
            offset:20,
           backgroundColor: chart =>
           {
              return chart.dataset.borderColor;   
           },
           
            color:'white',
            borderRadius:5,
            formatter: function(value, context)
            { 
                 
                 return context.chart.data.labels[context.dataIndex] + '\n'+  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
             
            },
            labels: 
            {
               title: 
               {
                   font: 
                   {
                       weight: 'bold'
                   }
               } 
            }
        } 
    }
    
    
function registrar_usuario_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO USUARIO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_agregar_usuario.jsp",
                data: {nombre: $('#nombre').val(),
                    pass: $('#pass').val(),
                    usuario: $('#usuario').val(),
                    clasificadora: $('#clasificadora').val(),
                    select_rol: $('#select_rol').val()},
                beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (res)
                {
                    if (res.tipo_registro == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });

                        //$('#modal_add_usuarios').modal('toggle');

                        traer_vista_usuario_ppr();
                    } else {
                        swal.fire({
                            type: 'error',
                            html: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }
            });
        }
    });
}

function registrar_usuario_pendiente_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA ENVIAR SOLICITUD USUARIO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, ENVIAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_agregar_usuario_pendientes.jsp",
                data: {nombrepend: $('#nombrepend').val(),
                    apellidopend: $('#apellidopend').val(),
                    select_area: $('#select_area').val()
                },

                success: function (res)
                {
                    if (res.tipo_registro == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                        $('#modal_add_pendiente').modal('toggle');

                    } else {
                        swal.fire({
                            type: 'error',
                            html: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }
            });
        }
    });
}

function registrar_peticion_reset_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "ENVIAR PETICION?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, ENVIAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_agregar_peticion_reset.jsp",
                data: {peticionn: $('#peticionn').val()

                },

                success: function (res)
                {
                    if (res.tipo_registro == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });

                        $('#modal_add_').modal('toggle');


                    } else {
                        swal.fire({
                            type: 'error',
                            html: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }
            });
        }
    });
}

//function insert roles
function registrar_roles_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO ROL?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_agregar_rol.jsp",
                data: {
                    descripcion: $('#descripcion').val()

                }, beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (res) {
                    if (res.tipo_registro == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                        $('#modal_add_roles').modal('toggle');
                        cancelar_usuarios_ppr();
                    } else {
                        swal.fire({
                            type: 'error',
                            html: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }
            });
        }
    });
}

function cargar_grilla_roles_ppr() {
    window.location.hash = "pprRolesRegistrados";

    $.ajax({
        url: ruta_grilla_ppr + "grilla_rol.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();
        },
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            $("#tabla_roles").dataTable({language: {sUrl: "js/Spanish.txt"}});
            cerrar_load();
        }});
}
//fncion mensaje
function aviso_registro_user_ppr(tipo, mensaje) {
    if (tipo == "2") {
        swal.fire({
            icon: 'success',
            text: mensaje,
            confirmButtonText: "CERRAR"
        });
        $('#modal_add_usuarios').modal('hide');


    } else {
        swal.fire({
            icon: 'error',
            text: mensaje,
            confirmButtonText: "CERRAR"
        });

    }

}

function edit_usuario_ppr(id, usuario, nombre, clasificadora, desc_rol, select_estado) {
    $("#txt_id").val(id);
    $("#txt_usuario").val(usuario);
    $("#txt_nombre").val(nombre);
    $("#txt_clasificadora").val(clasificadora);
    $("#select_rol2").val(desc_rol);
    $("#select_estado").val(select_estado);


    $("#modal_upd_user").modal("show");

}

function edit_rol_ppr(id, descripcion, desc_estado) {
    $("#txt_id_rol").val(id);
    $("#txt_decri_rol").val(descripcion);
    $("#select_estado_roles").val(desc_estado);




    $("#modal_upd_rol").modal("show");


}

function edit_modulos_ppr(id, descripcion, desc_estado) {
    $("#txt_id_modulo").val(id);
    $("#txt_decri_modulo").val(descripcion);
    $("#select_estado_modulo").val(desc_estado);

    $(".modal-header").css("background-color", "#007bff");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("MODIFICAR MODULO");


    $("#modal_upd_modulos").modal("show");
}

function modificar_usuario_ppr() {

    txt_id = $.trim($("#txt_id").val());
    txt_nombre = $.trim($("#txt_nombre").val());
    txt_usuario = $.trim($("#txt_usuario").val());
    txt_clasificadora = $.trim($("#txt_clasificadora").val());
    select_rol2 = $.trim($("#select_rol2").val());
    select_estado = $.trim($("#select_estado").val());

    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GUARDAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {

            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_modificar_usuario.jsp",
                data: {txt_id: txt_id, txt_nombre: txt_nombre, txt_usuario: txt_usuario, txt_clasificadora: txt_clasificadora, select_rol2: select_rol2, select_estado: select_estado},
                beforeSend: function ()
                {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(), (timerInterval = setInterval(() =>
                            {
                                Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                            }, 1e3));
                        },
                    });
                },
                success: function (res)
                {
                    if (res.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });

                        $('#modal_upd_user').modal('toggle');

                        grilla_usuarios_ppr();
                        $('.modal-backdrop').remove();
                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }


            });
        }
    });
}

function traer_vista_roles_ppr() {
    window.location.hash = "pprCrearRoles";
    cargar_load();

    $.ajax({
        url: ruta_vistas_ppr + "vista_registrar_roles.jsp",
        type: "post",
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            cerrar_load();
        }});
}

function modificar_rol_ppr() {

    txt_id_rol = $.trim($("#txt_id_rol").val());
    txt_decri_rol = $.trim($("#txt_decri_rol").val());
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GUARDAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {

            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + 'crud_modificar_rol.jsp',
                data: {txt_id_rol: txt_id_rol, txt_decri_rol: txt_decri_rol, select_estado_roles: $("#select_estado_roles").val()},
                beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (ress)
                {
                    if (ress.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: ress.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                        $('#modal_upd_rol').modal('toggle');

                        $('.modal-backdrop').remove();
                        cargar_grilla_roles_ppr();
                    } else {
                        swal.fire({
                            type: 'error',
                            text: ress.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }


            });
        }
    });
}

function modificar_modulos_ppr() {

    id = $.trim($("#txt_id_modulo").val());
    descripcion = $.trim($("#txt_decri_modulo").val());
    desc_estadoo = $.trim($("#select_estado_modulo").val());
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GUARDAR LOS CAMBIOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {

            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + 'crud_modificar_modulo.jsp',
                data: {txt_id_modulo: id, txt_decri_modulo: descripcion, select_estado_modulo: desc_estadoo},
                success: function (ress)
                {
                    if (ress.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: ress.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                        $('#modal_upd_modulos').modal('toggle');
                        grilla_modulos();
                    } else {
                        swal.fire({
                            type: 'error',
                            text: ress.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                }


            });
        }
    });
}

function restablecer_pass_usuario_ppr() {
    id = $.trim($("#txt_id_reset").val());
    $.ajax({
        type: "POST",
        url: ruta_cruds_ppr + "crud_restablecer_pass.jsp",
        data: {txt_id_reset: id},

        success: function (res)
        {

            Swal.fire({
                type: 'success',
                //title: 'Oops...',
                text: res.mensaje,
                timer: '2000'

            });

            $('#modal_restablecer_pass').modal('toggle');




        }
    });
}



function nuevocambio_pass_usuario_ppr() {
    txt_id_cambiopas = $.trim($("#txt_id_cambiopas").val());
    passnueva = $.trim($("#passnueva").val());
    passactual = $.trim($("#passactual").val());
    $.ajax({
        type: "POST",
        url: ruta_cruds_ppr + "crud_nuevo_pass.jsp",
        data: {txt_id_cambiopas: txt_id_cambiopas, passnueva: passnueva, passactual: passactual},
        beforeSend: function ()
        {
            Swal.fire({
                title: 'PROCESANDO!',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft()
                    }, 5000);
                }
            });
        },
        success: function (res)
        {
            if (res.tipo_registro == "2") {
                swal.fire({
                    type: 'success',
                    text: res.mensaje,
                    confirmButtonText: "CERRAR"
                });
                $("#modal_nuevocambio_pass2").modal("hide");
                grilla_roles_ppr();
            } else {
                swal.fire({
                    type: 'error',
                    html: res.mensaje,
                    confirmButtonText: "CERRAR"
                });
            }
        }
    });
}

function cerrar_sesion_ppr() {
    $.ajax({
        url: "control/control_cerrarsesion.jsp",
        type: "post",
        success: function (data) {

        }});
}

function cancelar_usuarios_ppr()
{
    $('#nombre').val("");
    $('#apellido').val("");
    $('#usuario').val("");
    $('#pass').val("");
    $('#correo').val("");
    $('#descripcion').val("");


    grafico_mortandad();
}


function grilla_usuarios_ppr() {
    window.location.hash = "pprUsuariosRegistrados";

    $.ajax({
        url: ruta_grilla_ppr + "grilla_usuarios.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            $("#tabla_usuarios").dataTable({language: {sUrl: "js/Spanish.txt"}});
            cerrar_load();

        }});
}


function traer_vista_usuario_ppr() {
    window.location.hash = "pprRegistroUsuario";

    $.ajax({
        url: ruta_vistas_ppr + "vista_registrar_usuario.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            cerrar_load();
        }});
}

function traer_vista_usuario2_ppr() {

    $.ajax({
        type: "POST",
        url: "informes.jsp",
        beforeSend: function ()
        {
            cargar_load();
            $('#contenido_row').html("");
        },
        success: function (data)
        {
            $("#contenido_row").html(data);
            cerrar_load();
            //onclickMenu();
        }
    });
}

function modalinsertusuario_ppr() {
    $("#form_add_user").trigger("reset");


    $("#modal_add_usuarios").modal("show");

}

function modalinsertmodulos_ppr() {
    $("#form_add_rol").trigger("reset");
    $(".modal-header").css("background-color", "#28a745");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("REGISTAR MODULOS");

    $("#modal_add_modulos").modal("show");

}

function modalupdateusuario_ppr() {
    $("#form_upd_user").trigger("reset");
    $(".modal-header").css("background-color", "#28a745");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("Modificar Usuario");

    $("#modal_upd_user").modal("show");

}

function modalresetearpass_ppr(id, usuario) {
    $("#txt_id_reset").val(id);
    $("#txt_usuario_p").val(usuario);
    $("#modal_restablecer_pass").modal("show");
}

function modalnuevocambiopassword_ppr() {


    $(".modal-header").css("background-color", "#0157a0");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("CAMBIO PASSWORD");


    $("#modal_nuevocambio_pass2").modal("show");
}

function modalinsertpendientes_ppr() {
    $("#form_add_pendiente").trigger("reset");
    $("#modal_add_pendiente").modal("show");

}

function modalpeticionreset_ppr() {
    $("#form_add_reset").trigger("reset");
    $("#modal_add_").modal("show");

}

function modalreportezoom_ppr() {
    $("#form_zoon").trigger("reset");
    $(".modal-header").css("background-color", "#0066cc");
    $(".modal-header").css("color", "white");
    $(".modal-title").text("RESUMEN");

    $("#modal_reporter").modal("show");

}

function grafico_aviario_dinamico_vista_ppr()
{

    $.ajax({
        url: ruta_vistas_ppr + "vista_informe_aviarios_dinamico.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            grafico_aviarios_dinamico();
            cerrar_load();
        }});
}
function grafico_aviarios_dinamico_ppr() {
    window.location.hash = "pprGraficoAviariosDinamico";
    $.ajax({
        url: ruta_vistas_ppr + "vista_informe_aviarios_dinamico.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            formato_multiselect();
            $('#form_reporte_aviario_dinamicop').on('submit', function (event)
            {
                event.preventDefault();
                consulta_aviarios_dinamico_ppr("p");
                event.stopPropagation();

            });
            cerrar_load();
        }});

}
function consulta_aviarios_dinamico_ppr(serial)
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_reporte_aviarios_dinamico.jsp",
        data: $("#form_reporte_aviario_dinamico" + serial).serialize(),
        beforeSend: function (xhr) {
            cargar_load("Consultando...");
        },
        success: function (result)
        {
            var c = 0;
            $.each(result.charts, function (i, item)
            {
                var a = '  <div class="divinforme3" >   ';
                a += '  <div class="card-header bg-navy" > ';
                a += '   <h3 class="card-title"> Aviario - ' + result.charts[c].options.plugins.title.text + '</h3> ';
                a += '    <div class="card-tools"> ';

                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="A' + serial + '" style="  height: 30px; width: 100px; "></canvas>';

                a += '  </div> ';
                if (serial == "p") {
                    $("#div_graficop").html(a);
                } else {
                    $("#div" + serial).html(a);
                }
                var resChart = new Chart(document.getElementById("A" + serial), result.charts[c]);
                c++;
            });
            cerrar_load();
        }
    });

}

function generar_cuadros_consultas_aviarios_dinamicos_ppr() {

    serial++;
    var html = '<div class="card card-navy">   <div class="card-header">       <div class="card-tools">     <button type="button" class="btn btn-tool" data-card-widget="collapse">      <i class="fas fa-minus"></i>     </button>     <button type="button" class="btn btn-tool"  data-card-widget="remove">        <i class="fas fa-times"></i>   </button>   </div>     </div>      <div class="card-body">\n\
            <form id="form_reporte_aviario_dinamico' + serial + '" type="post" action="footer3" > \n\
                <br>\n\
                <table class="table" > \n\
                    <thead> \n\
                        <tr><th>DESDE</th> \n\
                            <th>HASTA</th> \n\
                            <th>AVIARIO</th> \n\
                            <th>SERIE</th> \n\
                            <th>TIPO RESULTADO</th> \n\
                            <th>TIPO GRAFICO</th> \n\
                            <th>BUSQUEDA </th>\n\
                        </tr> \n\
                    </thead> \n\
                    <tbody> \n\
                        <tr> \n\
                            <td> <input type="date" value="' + $("#fecha_desde").val() + '"  name="fecha_desde"></td>\n\
                            <td> <input type="date"  value="' + $("#fecha_hasta").val() + '"   name="fecha_hasta"></td>\n\
                            <td>\n\
                                <select class="selectpicker" multiple data-live-search="true" name="aviarios" required="true" data-actions-box="true"> \n\
                                    <option class="text-center" value="A2">A2</option> \n\
                                    <option class="text-center" value="A3">A3</option> \n\
                                    <option class="text-center" value="A4">A4</option> \n\
                                    <option class="text-center" value="A6">A6</option> \n\
                                    <option class="text-center" value="A7">A7</option> \n\
                                    <option class="text-center" value="A8">A8</option> \n\
                                    <option class="text-center" value="A9">A9</option>\n\
                                    <option class="text-center" value="A10">A10</option> \n\
                                    <option class="text-center" value="A11">A11</option> \n\
                                    <option class="text-center" value="A12">A12</option> \n\
                                    <option class="text-center" value="B2">B2</option> \n\
                                    <option class="text-center" value="B3">B3</option> \n\
                                    <option class="text-center" value="B4">B4</option> \n\
                                    <option class="text-center" value="B5">B5</option> \n\
                                    <option class="text-center" value="B6">B6</option> \n\
                                    <option class="text-center" value="B7">B7</option> \n\
                                    <option class="text-center" value="B8">B8</option> \n\
                                    <option class="text-center" value="B9">B9</option> \n\
                                    <option class="text-center" value="B10">B10</option> \n\
                                    <option class="text-center" value="B11">B11</option> \n\
                                    <option class="text-center" value="H1">H1</option> \n\
                                    <option class="text-center" value="H2">H2</option> \n\
                                    <option class="text-center" value="H3">H3</option> \n\
                                    </select>\n\
                            </td>   \n\
                            <td>\n\
                                <select class="selectpicker" multiple data-live-search="true" name="categorias" required="true" data-actions-box="true"> \n\
                                    <option value=mortandadd>Mortandad</option> \n\
                                    <option value=consumo_ball>Consumo de Balanceados</option> \n\
                                    <option value=producto>Productividad</option>   \n\
                                    <option value=caudalime>Consumo de Agua</option> \n\
                                    <option value=temp_mini>Tem. Min.</option> \n\
                                    <option value=temp_maxi>Tem. Max.</option> \n\
                                    <option value=huevo>Produccion Huevo</option> \n\
                                    <option value=pad_bala>Pad. Bal</option> \n\
                                    <option value=pad_produ>Pad. Prod</option> \n\
                                </select> \n\
                            </td>\n\
                            <td>\n\
                                <select name="tipoConsulta" class="btn btn-sm bg-navy"> \n\
                                    <option class="text-center" value="suma">Suma</option> \n\
                                    <option class="text-center" value="promedio">Promedio</option> \n\
                                    <option class="text-center" value="minimo">Minimo</option> \n\
                                    <option class="text-center" value="maximo">Maximo</option>\n\
                                </select>\n\
                            </td>\n\
                            <td>\n\
                                <select name="tipo_grafico" class="btn btn-sm bg-navy"> \n\
                                    <option class="text-center" value="line">Lineal</option> \n\
                                    <option class="text-center" value="bar">Barra</option> \n\
                                </select>\n\
                            </td>\n\
                            <td> \n\
                                 <button type="submit" class="btn btn-sm  bg-navy btn-block"  onclick="generar_serial_ppr(' + serial + ')"><i class="fa fa-search"></i> Buscar</button>  \n\
                            </td>\n\
                        </tr>\n\
                    </tbody> \n\
                </table> \n\
            </form>  <div id="div' + serial + '"></div>  </div>';
    $("#div_principal").append(html);



    formato_multiselect();
    $('#form_reporte_aviario_dinamico' + serial).on('submit', function (event)
    {
        event.preventDefault();

        consulta_aviarios_dinamico_ppr(serial);
        event.stopPropagation();

    });

}



function grafico_zoom_menu_principal_ppr(aviario) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_reporte_aviarios_dinamico_zoom.jsp",
        data: {aviario: aviario},
        success: function (result)
        {
            var c = 0;
            $.each(result.charts, function (i, item)
            {
                var a = '  <div class="card card-navy" >   ';
                a += '  <div class="card-header"> ';
                a += '   <h3 class="card-title">Resumen de Aviario - ' + result.charts[c].options.plugins.title.text + '</h3> ';
                a += '   <div class="card-tools"> ';
                a += '   <button type="button" class="btn btn-tool" onclick="cerrar_resumen()" \n\
                            data-card-widget="collapse" data-dismiss="modal" aria-label="Close"> ';
                a += '   </i> ';
                a += '   </button> ';
                a += '   <button data-card-widget="remove" class="close" type="submit"  \n\
                            data-dismiss="modal" aria-label="Close"><span  style="color: #ffffff" \n\
                            onclick="cerrar_resumen()" aria-hidden="true"><h2 style="color: #000">X</h2></span></button>';
                a += '   </div> ';
                a += '   </div> ';
                a += '  <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="' + result.charts[c].options.plugins.title.text + '"></canvas>';
                a += '  </div> ';




                $("#cargarzoom").append(a);


                var resChart = new Chart(document.getElementById(result.charts[c].options.plugins.title.text), result.charts[c]);
                c++;
            });

        }
    });
    cerrar_resumen_ppr();
    $("#modal_reportere").modal("show");


}

function generar_serial_ppr(serial_nuevo) {
    serial = serial_nuevo;
}

function cerrar_resumen_ppr()
{

    document.getElementById("cargarzoom").innerHTML = "";
    $('#modal_reportere').modal('hide');
    $('.modal-backdrop').remove();
}

function temperatura_ppr() {
    $.ajax({
        type: "get",
        url: "http://192.168.210.25/",
        dataType: "jsonp",
        jsonpCallback: "arduinoEthernetComCallback",
        success: function (j) {
            var temp = parseFloat(j.T);
            var hume = parseFloat(j.H);
            var ith = Math.round(temp + hume);

            $("#div_temp").html(' <span> Temperatura: <span id="temp" class="blink text-red">' + temp + '</span> &deg;C | Humedad: <span id="humedad">' + hume + '</span>% | ITH: <span id="ith">' + ith + '</span> | <span style="font-weight:normal;" ></span></span>');

            /*  $("#temp").html($.number(temp, 1, ",", "."));
             if (temp >= 29) {
             $("#temp").addClass("blink text-red");
             } else {
             $("#temp").removeClass("blink text-red");
             }
             $("#humedad").html($.number(hume, 1, ",", "."));
             if (hume >= 80) {
             $("#humedad").addClass("blink text-red");
             } else {
             $("#humedad").removeClass("blink text-red");
             }
             $("#ith").html($.number(ith, 0, ",", "."));
             if (ith >= 105) {
             $("#ith").addClass("blink text-red");
             } else {
             $("#ith").removeClass("blink text-red");
             }*/
        },
        error: function () {
            $("#temp").html("error").addClass("blink text-red");
            $("#hume").html("error").addClass("blink text-red");
            $("#ith").html("error").addClass("blink text-red");
        }
    });
}
function traer_vista_contador_huevo_ppr() {
    cargar_load();
    $.ajax({
        url: ruta_vistas_ppr + "vista_registro_contador_huevo.jsp",
        type: "post",
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            cerrar_load();
        }});
}

function traer_grilla_contador_huevo_ppr() {

    $.ajax({
        url: "grillas/grilla_comtador_huevo.jsp",
        type: "post",
        success: function (data) {

            $('#grilla_contador_huevo').html(data);


        }});
}

function consulta_contador_huevo_ppr(cant) {
    $.ajax({
        type: "POST",

        url: ruta_consultas_ppr + "consulta_aviario_contador_huevo.jsp",
        data: {
            fecha: $('#fecha').val(),
            aviario: $('#avi').val()
        },
        success: function (data) {
            var contador = 0;
            var contador2 = 0;
            var canti = 48;


            $.each(data.filas, function (i, item)
            {
                const decimal = numeral(item.cantidad).format('0,0');
                decimal.replace(',', '.');
                $(item.id).html(decimal);


                contador = parseInt(contador) + parseInt(item.cantidad);
                contador2 = contador / canti;
                //sum=parseInt(item.cantidad)+parseInt(item.cantidad);
            }
            );
            // 
            $("#huevos").val(contador);
            $("#promedio").val(Math.round(contador2));
            ppr_contador_onselect();

        }
    });
}

// function ppr_contador_onselect_ppr() {
//    var editables = document.querySelectorAll("[contentEditable]");
//    for (var i = 0, len = editables.length; i < len; i++) {
//        editables[i].setAttribute("data-orig", editables[i].innerHTML);
//        editables[i].setAttribute("data-fecha", editables[i].innerHTML);
//        editables[i].onfocus = function () {
//            celda_editable_selectElement(this);
//        };
//        editables[i].onblur = function () {
//            if (this.innerHTML == this.getAttribute("data-orig")) {
//                this.innerHTML = this.getAttribute("data-orig");
//            } else {
//                this.setAttribute("data-orig", this.innerHTML);
//                var valor = this.getAttribute("data-orig");
//                var regex = /<br\s*[\/]?>/gi;
//                valor = valor.replace(regex, "");
//                var fecha = this.setAttribute("fecha");
//                var avi = this.setAttribute("avi");
//                var fila = this.setAttribute("fila");
//                var lote = this.setAttribute("lote");
//               ppr_contador_reg(fecha, avi, lote, fila, valor)
//            }
//        };
//    }
//}

function ppr_contador_reg_ppr(fecha, avi, lote, fila, valor) {
    var phen = $("#phen").val();
    $.get(ruta_consultas_ppr + "consulta_aviario_contador_huevo.jsp", {fecha: fecha, avi: avi, lote: lote, fila: fila, cant: valor, phen: phen}, function (j) {
        $("#henday").val(j.henday);
        $("#huevos").val(j.huevos);
        $("#diff").val(j.diffp);
        if (j.diff >= 0) {
            $("#diff").addClass("custom-is-valid").removeClass("custom-is-invalid");
        } else {
            $("#diff").removeClass("custom-is-valid").addClass("custom-is-invalid");
        }
    });
}
function traer_vista_contador_huevo_ppr() {

    $.ajax({
        url: ruta_vistas_ppr + "vista_registro_contador_huevo.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html(data);
            cerrar_load();
        }});
}


function traer_grilla_balanceados_ppr() {

    $.ajax({
        url: "grillas/grilla_consumo_balanceado_bloque.jsp",
        type: "post",
        success: function (data) {

            $("#grilla_consumo_balanceado_bloque").html(data);


        }});
}
function  ocultar_div_balan_ppr() {
    $(".ocultar").hide();
}
function  mostrar_div_balan_ppr() {
    $(".ocultar").show();
}





function consulta_balanceado_bloque_ppr()
{
    var mes = $("#mes").val();
    var ano = $("#ano").val();
    $.ajax({
        url: ruta_consultas_ppr + "consulta_informe_balanceado_bloque.jsp",
        type: "post",
        data: {mes: mes, ano: ano},
        beforeSend: function (xhr) {
            cargar_load("Consultando...");

            traer_grilla_balanceados_ppr();


        },

        success: function (resut) {

            $('#tbody_A').html("");
            $('#tbody_B').html("");
            $('#tbody_H').html("");

            console.log(resut.fila_A.length);
            for (i = 0; i < resut.fila_A.length; i++) {
                const balan_decimal = numeral(resut.fila_A[i].balanceado).format('0,0');
                const aves_acum_decimal = numeral(resut.fila_A[i].aves_acumulado).format('0,0');
                $("#Table_bloque_A").append('<tr>' +
                        '<td align="center" id="bloque_a" style="dislay: none;">' + resut.fila_A[i].aviario + '</td>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_A[i].lote_nombre + '</td>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_A[i].edad_semanas + '</td>' +
                        '<td align="center" style="dislay: none;">' + aves_acum_decimal + '</td>' +
                        '<td align="center" style="dislay: none;">' + balan_decimal + '</td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_A[i].color_gramo + '" >' + resut.fila_A[i].gramo_ave + ' </td>' +
                        '<td align="center" style="dislay: none; ">' + resut.fila_A[i].balan_pad + '</td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_A[i].color_diferencia + ' " >' + resut.fila_A[i].diferencia + ' </td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_A[i].color_porcentaje + '" >' + resut.fila_A[i].diferencia_porcen + '% </td>' +
                        '</tr>');

            }
            for (i = 0; i < resut.fila_B.length; i++) {

                const balan_decimal = numeral(resut.fila_B[i].balanceado).format('0,0');
                const aves_acum_decimal = numeral(resut.fila_B[i].aves_acumulado).format('0,0');
                $("#Table_bloque_B").append('<tr>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_B[i].aviario + '</td>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_B[i].lote_nombre + '</td>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_B[i].edad_semanas + '</td>' +
                        '<td align="center" style="dislay: none;">' + aves_acum_decimal + '</td>' +
                        '<td align="center" style="dislay: none;">' + balan_decimal + '</td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_B[i].color_gramo + '" >' + resut.fila_B[i].gramo_ave + ' </td>' +
                        '<td align="center" style="dislay: none; ">' + resut.fila_B[i].balan_pad + '</td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_B[i].color_diferencia + ' " >' + resut.fila_B[i].diferencia + ' </td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_B[i].color_porcentaje + '" >' + resut.fila_B[i].diferencia_porcen + '% </td>' +
                        '</tr>');
            }  //resut.fila_A.length !== 0

            for (i = 0; i < resut.fila_H.length; i++) {

                const balan_decimal = numeral(resut.fila_H[i].balanceado).format('0,0');
                const aves_acum_decimal = numeral(resut.fila_H[i].aves_acumulado).format('0,0');


                $("#Table_bloque_H").append('<tr>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_H[i].aviario + '</td>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_H[i].lote_nombre + '</td>' +
                        '<td align="center" style="dislay: none;">' + resut.fila_H[i].edad_semanas + '</td>' +
                        '<td align="center" style="dislay: none;">' + aves_acum_decimal + '</td>' +
                        '<td align="center" style="dislay: none;">' + balan_decimal + '</td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_H[i].color_gramo + '" >' + resut.fila_H[i].gramo_ave + ' </td>' +
                        '<td align="center" style="dislay: none; ">' + resut.fila_H[i].balan_pad + '</td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_H[i].color_diferencia + ' " >' + resut.fila_H[i].diferencia + ' </td>' +
                        '<td align="center" style="dislay: none; background-color:' + resut.fila_H[i].color_porcentaje + '" >' + resut.fila_H[i].diferencia_porcen + '% </td>' +
                        '</tr>'
                        );
            }     //(resut !== []) 
            if (resut.fila_A.length === 0) {
                ocultar_div_balan();
                Swal.fire({
                    title: 'Mensaje!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {
                //traer_grilla_balanceados();
            }
            cerrar_load();

        }

    });


}



function consulta_balanceado_bloque2_ppr()
{

    $.ajax({
        url: ruta_consultas_ppr + "consulta_informe_balanceado_bloque.jsp",
        type: "post",
        data: {mes: $("#mes").val(), ano: $("#ano").val()},
        success: function (data) {

            $('#Table_bloque_A').html(data.fila_A);

            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");

        }});
}
function informe_consumo_balanceado_bloque_ppr() {
    window.location.hash = "pprConsumoBalanceadoBloque";
    $.ajax({
        url: ruta_vistas_ppr + "vista_informe_consumo_balanceado_bloque.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            cerrar_load();
        }});
}

function llamar_mortandad_80_sems_ppr()
{
    window.location.hash = "pprMortandad80Sms";
    $.ajax({
        url: ruta_vistas_ppr + "vista_mortandad_80_sems.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            ocultar_ppr();
            cerrar_load();
        }});
}


function mortandad_80_sems_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_mortandad_80_sems.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            mes_mort: $('#mes_mort').val(),
            ano_mort: $('#ano_mort').val()
        },

        success: function (data) {

            $('#tabla_mortandad_80_sems').html(data.grilla_80_sems);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            cerrar_load();

            if (!Object.keys(data.lote_id).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {
                $(".ocultar").show();
            }
        }
    });

}
function consulta_balanceado_bloque2_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_infrome_balanceado_bloque.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            mes_mort: $('#mes_mort').val(),
            ano_mort: $('#ano_mort').val()
        },

        success: function (data) {

            $('#tabla_a').html(data.grilla_a);
            $('#tabla_b').html(data.grilla_b);
            $('#tabla_h').html(data.grilla_h);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            cerrar_load();

            if (!Object.keys(data.aviario).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {
                $(".ocultar").show();
            }
        }
    });

}


function llamar_contador_huevos_ppr()
{
    window.location.hash = "pprContadorHuevos";
    $.ajax({
        url: ruta_vistas_ppr + "vista_contadores_huevos.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            ocultar_ppr();
            cerrar_load();
        }});
}



function consulta_contador_huevo_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_informe_contador_huevo.jsp",
        beforeSend: function (xhr) {
            limpiar_div_contadores_ppr(),
                    cargar_load("Consultando...");

        },
        data: {
            aviario: $('#aviario').val(),
            fecha: $('#fecha').val(),
            lote: $('#lote').val()
        },

        success: function (data) {

            $('#tabla_contador').html(data.grilla_contador);

            // $('#tabla_contador').html(data.grilla_cabecera2);
            $('#tabla_mortandad_periodo').html(data.grilla_mortandad_periodo);
            $('#tabla_contador_periodo').html(data.grilla_contador_periodo);
            $('#tabla_mortandad_global').html(data.grilla_mortandad_global);
            $('#huevos').val(data.cant);
            $('#phenday').val(data.pad_productividad);
            $('#henday').val(data.productividad);
            $('#edad').val(data.dl_edaddias);
            $('#promfila').val(data.prome_huevo);
            $('#maxfila').val(data.max_cant);
            $('#minfila').val(data.min_cant);
            $('#diff').val(data.dif_productividad);

            $('#diff').css("background-color", data.color);
            $('#7').css("background-color", data.fila1_color);
            $('#15').css("background-color", data.fila2_color);
            $('#23').css("background-color", data.fila3_color);
            $('#31').css("background-color", data.fila4_color);
            $('#39').css("background-color", data.fila5_color);
            $('#47').css("background-color", data.fila6_color);

            $('#7').addClass(data.fila1_blink);
            $('#15').addClass(data.fila2_blink);
            $('#23').addClass(data.fila3_blink);
            $('#31').addClass(data.fila4_blink);
            $('#39').addClass(data.fila5_blink);
            $('#47').addClass(data.fila6_blink);

            $('#7').append(data.fila1);
            $('#15').append(data.fila2);
            $('#23').append(data.fila3);
            $('#31').append(data.fila4);
            $('#39').append(data.fila5);
            $('#47').append(data.fila6);
            //$('#14').append(data.total_piso1);

            $('#total_periodo').val(data.total_huevos_acum);
            $('#prom_fila').val(data.total_prome_acum);
            $('#periodo_fecha_huevos').val(data.periodo_fecha);
            $('#periodo_fecha_mortandad').val(data.periodo_fecha);
            $('#prom_mor_fila').val(data.prom_mor_fila);
            $('#muerte_acum_periodo').val(data.total_mortandad_acum);
            $('#total_global_fila').val(data.total_mortandad_prom_global);
            $('#total_mor_global').val(data.total_mortandad_global);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");





            cerrar_load();

            if (!Object.keys(data.fila).length) {
                $(".ocultar").hide();
                Swal.fire({
                    title: 'ATENCION!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {
                $(".ocultar").show();
                mostrar_ppr();
            }
        }
    });

}


function consulta_lote_huevo_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_lote_aviario.jsp",
        beforeSend: function (xhr) {
            limpiar_div_contadores_ppr(),
                    cargar_load("Consultando...");
        },
        data: {
            aviario: $('#aviario').val(),
            fecha: $('#fecha').val()
        },

        success: function (data) {

            $('#lote').val(data.lote_name);
            $('#loteid').val(data.lote);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            cerrar_load();

            if (!Object.keys(data.lote_name).length) {
                ocultar_ppr();
                Swal.fire({
                    title: 'MENSAJE!',
                    text: "En la fecha no se encontra lote en  aviario seleccionada",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            }
        }
    });

}
function limpiar_div_contadores_ppr() {

    $('#tabla_contador').html("");
    $('#tabla_contador_periodo').html("");
    $('#tabla_mortandad_periodo').html("");
    $('#tabla_mortandad_global').html("");
    $('#grafico_resumen').html("");
    $('#grafico_resumen_lote').html("");
}

function grafico_resumen_periodo_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_chart_resumen_periodo_huevos.jsp",
        data: {
            aviario: $('#aviario').val(),
            fecha: $('#fecha').val()
        },

        success: function (data)
        {
            var c = 0;
            $.each(data.chartsdet, function (i, item)
            {
                var a = '  <div >   ';
                a += '  <div class="card-header"> ';
                a += '   <h3 class="card-title"><b>Grafico del Periodo</h3> ';
                a += '    <div class="card-tools"> ';
                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="' + data.chartsdet[c].options.plugins.title.text + '"></canvas>';
                a += '  </div> ';

                $("#grafico_resumen").append(a);

                var resChart = new Chart(document.getElementById(data.chartsdet[c].options.plugins.title.text), data.chartsdet[c]);
                c++;
            });

        }
    });
}

function grafico_fila_contador_huevo_fila_ppr(fila) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_chart_resumen_fila_huevo.jsp",
        data: {fila: fila,
            aviario: $('#aviario').val(),
            fecha: $('#fecha').val()},
        success: function (data)
        {
            var c = 0;
            $.each(data.chartsdet, function (i, item)
            {
                var a = '  <div >   ';
                a += '  <div class="card-header"> ';
                a += '    <h3 class="card-title"><b>Contador Huevos Fila</h3>';
                a += '    <div class="card-tools"> ';
                a += '   <button type="button" class="btn btn-tool"  \n\
                            data-card-widget="collapse" data-dismiss="modal" aria-label="Close"> ';
                a += '   </i> ';
                a += '   </button> ';
                a += '   <button class="close" type="button" style="font-weight: bold;color:black;" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span></button>';
                a += '   </div> ';
                a += '   </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="' + data.chartsdet[c].options.plugins.title.text + '" ></canvas>';
                a += '  </div> ';

                $("#fila_huevo_contador2").append(a);

                var resChart = new Chart(document.getElementById(data.chartsdet[c].options.plugins.title.text), data.chartsdet[c]);
                c++;
            });

        }
    });
    limpiar_modal_fila_ppr();
    $("#modal_huevo_resumen").modal("show");



}
function cerrar_modal_fila_ppr()
{

    document.getElementById("fila_huevo_contador2").innerHTML = "";
    $('#modal_huevo_resumen').modal('hide');
    $('.modal-backdrop').remove();
}
function limpiar_modal_fila_ppr() {

    $('#fila_huevo_contador2').html("");

}

function grafico_resumen_lote_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_chart_resumen_grafico_lote.jsp",
        data: {
            aviario: $('#aviario').val(),
            lote: $('#lote').val()
        },

        success: function (data)
        {
            var c = 0;
            $.each(data.chartsdet, function (i, item)
            {
                var a = '  <div >   ';
                a += '  <div class="card-header"> ';
                a += '   <h3 class="card-title"><b>Grafico Resumen Lote</h3> ';
                a += '    <div class="card-tools"> ';
                a += '  </div> ';
                a += '    </div> ';
                a += ' <div class="card-body"><div class="chartjs-size-monitor"><div class="chartjs-size-monitor-expand"><div class=""></div></div><div class="chartjs-size-monitor-shrink"><div class=""></div></div></div> ';
                a += '   <canvas id="' + data.chartsdet[c].options.plugins.title.text + '"></canvas>';
                a += '  </div> ';

                $("#grafico_resumen_lote").append(a);

                var resChart = new Chart(document.getElementById(data.chartsdet[c].options.plugins.title.text), data.chartsdet[c]);
                c++;
            });

        }
    });
}

function consulta_mortandad_mensual_ppr() {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_infrome_mortandad_mensual.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");
        },
        data: {
            mes_mort: $('#mes_mort').val(),
            ano_mort: $('#ano_mort').val()
        },

        success: function (data) {

            $('#tabla_a').html(data.grilla_a);
            $('#tabla_b').html(data.grilla_b);
            $('#tabla_h').html(data.grilla_h);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            mostrar_ppr();
            cerrar_load();

            if (!Object.keys(data.bloque).length) {
                $(".ocultar").hide();
                Swal.fire({
                    // title: 'ATENCION!',
                    text: "No Existen Registros",
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonColor: '#001F3F',
                    confirmButtonText: 'Aceptar',
                    timer: 4000});
            } else {
                $(".ocultar").show();
            }
        }
    });

}

function traer_vista_mortandad_mensual_ppr() {
    window.location.hash = "pprMortandadMensual";

    $.ajax({
        url: ruta_vistas_ppr + "vista_informe_mortandad_mensual.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            ocultar_ppr();
            cerrar_load();
        }

    });
}

function traer_vista_registro_necropsias_ppr() {
    window.location.hash = "pprRegistroNecropsias";

    $.ajax({
        url: ruta_vistas_ppr + "vista_registro_necropsias.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            cargar_estilo_calendario_insert("yyyy-mm-dd");
            ocultar_ppr();
            cerrar_load();
        }

    });
}

function ir_consultar_registro_necropsias_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_registro_necropsias.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");

        },
        data: {
            desde_necropsias: $('#desde_necropsias').val(),
            hasta_necropsias: $('#hasta_necropsias').val()
        },

        success: function (data) {

            $('#tabla_a').html(data.grilla_a);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            $('#tabla_b').html("");
            mostrar_ppr();

            cerrar_load();

            //  if (!Object.keys(data.fecha).length) {
            //      $(".ocultar").hide();
            //      Swal.fire({
            //         // title: 'ATENCION!',
            //          text: "No Existen Registros",
            //          type: 'warning',
            //          showCancelButton: false,
            //          confirmButtonColor: '#001F3F',
            //          confirmButtonText: 'Aceptar',
            //          timer: 4000});
            //  } else {
            $("#datosnecropsiasregistrados").dataTable({language: {sUrl: "js/Spanish.txt"}});
            $(".ocultar").show();

            // }
        }
    });
}



function traer_vista_necropsias_score_ppr(necrop_id) {

    let input = document.querySelector("#edad");
    $('#datosnecropsiasregistrados1 tr').on('click', function () {
        var fecha = $(this).find('td:first').html();
        var lote = $(this).find('td:nth-child(2)').html();
        var aviario = $(this).find('td:nth-child(3)').html();


        $('#lote2').val(lote);
        $('#aviario2').val(aviario);
        $.ajax({
            url: ruta_vistas_ppr + "vista_editar_necropsis.jsp",
            type: "post",
            success: function (data) {
                $(".ocultar_div_editar").html("");
                $('#idresumen_det').html("");
                $('#idresumen_huevos').html("");
                $('#tabla_b').html(data);
                $("#fecha").html(fecha);
                $("#lote").html(lote);
                $("#aviario").html(aviario);
                $('#contenido_row').html("");
                ocultar_ppr();
                {
                    $.ajax({
                        //String fecha;
                        url: ruta_consultas_ppr + "consulta_editar_necropsias.jsp",
                        type: "post",
                        beforeSend: function (xhr) {
                            limpiarg_ppr(), cargar_load("Consultando...");
                        },
                        data: {
                            necrop_id: necrop_id,
                            fecha: fecha
                        },

                        success: function (data) {

                            $('#datosnecropsiasregistrados').html(data.grilla_a);
                            $('#edad').html(data.edad);
                            var td = $("#datosnecropsiasregistrados tr td").length;


                            // document.getElementById('btn_agre_ave').disabled=true;  


                            cerrar_load();


                            necropsias_detalle_onselect_ppr();

                        }
                    });
                }
            }
        });
    });
}


function modificar_detalle_score_onselect_ppr() {
    var editables = document.querySelectorAll("[contentEditable]");
    for (var i = 0, len = editables.length; i < len; i++) {
        //editables[i].setAttribute("valor", editables[i].innerHTML);
        editables[i].onfocus = function () {
            celda_editable_selectElement_ppr()(this);
        };
        editables[i].onblur = function () {

            this.setAttribute("valor", this.innerHTML);
            var valor = this.getAttribute("valor");
            var regex = /<br\s*[\/]?>/gi;
            valor = valor.replace(regex, "");
            var campo = this.getAttribute("valor");
            var idscore = this.getAttribute("id-score");
            var valor_viejo = this.getAttribute("value-data");


            editar_necropsias_score_detalle(idscore, valor);




        };
    }
}
function consulta_necropsias_imagen_ppr(nro_necrop, ave) {
    $('#ul_contenido_imagenes').html("");
    $('#contenedor_imagenes').html("");
    $('#contenido_carga_imagen').html("");
    // $('#img_id').html("");
    $('#ave_nro').html("");
    //var s = "";
    var c = 0;
    var d = 1;
    $.ajax({
        url: ruta_consultas_ppr + "consulta_imagen_necropsis.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();
        },
        data: {
            nro_necrop: nro_necrop,
            ave: ave
        },
        success: function (data) {
            $('#listaArchivos').html(data.datos);
            var ave_nro = "<label>Ave nro. " + ave + "</label>";
            $.each(data.imagen_lista, function (i, item) {
                var contenido_imagen = "";//'<div id="image-'+d+'"class="carousel-item"><img class="d-block w-100"   src="'+data.imagen_lista[c].url+'" style="width:100%;" alt="'+d+'"/></div>';
                var contenido_ul_imagen = "";//'<div id="image-'+d+'"class="carousel-item"><img class="d-block w-100"   src="'+data.imagen_lista[c].url+'" style="width:100%;" alt="'+d+'"/></div>';
                var a = '<li data-target="carouselExampleIndicators" data-slide-to="' + d + '" ></li>';

                if (c == 0) {
                    contenido_imagen = "<div  class='carousel-item active'> <img id='img_id' src='" + data.imagen_lista[c].url + "' alt=''/> </div>";
                    contenido_ul_imagen = " <li data-target='#demo' data-slide-to='" + c + "' class='active'></li>";

                } else {
                    contenido_imagen = "<div  class='carousel-item'> <img id='img_id' src='" + data.imagen_lista[c].url + "' alt='' style='width: 1150px; height: 650px;' /> </div>";
                    contenido_ul_imagen = " <li data-target='#demo' data-slide-to='" + c + "' ></li>";
                }

                $("#ul_contenido_imagenes").append(contenido_ul_imagen);
                $("#contenedor_imagenes").append(contenido_imagen);





                c++;
            });

            var //contenido_carga_imagen  = '<div class="row" >';
                    //contenido_carga_imagen += '<div class="col-lg-8 col-sm-12 col-11 main-section">';
                    //contenido_carga_imagen += '<input type="text" id="nec_id" hidden="true" value="'+nro_necrop+ '" />';
                    //contenido_carga_imagen += '<input type="text" id="ave"    hidden="true" value="' +ave+ '"  />';
                    //contenido_carga_imagen += '<h4>Archivos de ave nro.<span class="text-blue"> ' +ave+ '</span></h4>';
                    //contenido_carga_imagen += '<form enctype="multipart/form-data">';
                    //contenido_carga_imagen += '<div class="upload-container">';
                    //contenido_carga_imagen += '<input type="file" id="file" multiple="true"  style="width: 600px;"/>';
                    //contenido_carga_imagen += '<button class="upload-btn" onclick="subir_imagen_necropsias_prr('+nro_necrop+',' +ave+ ')">subir imagen</button>';
                    //contenido_carga_imagen += '</div><br></form></div></div>';

                    contenido_carga_imagen = '<div class="row" >';
            contenido_carga_imagen += '<div class="col-lg-8 col-sm-12 col-11 main-section">';
            contenido_carga_imagen += '<h4>Archivos de ave nro.<span class="text-blue"> ' + ave + '</span></h4>';
            contenido_carga_imagen += '<form >';
            contenido_carga_imagen += '<div class="form-control bg-navy" class="upload-container">';
            contenido_carga_imagen += '<input  type="file" name="file" id="file" multiple  style="width: 600px;"/></div>';

            contenido_carga_imagen += '<input type="text" name="nec_id" id="nec_id" hidden="true" value="' + nro_necrop + '" />';
            contenido_carga_imagen += '<input type="text" name="ave_nro_imagen" id="ave_nro_imagen"    hidden="true" value="' + ave + '"  />';
            contenido_carga_imagen += '<input  type="button"id="boton_file" class="form-control bg-navy" type="button" onclick="upload_imagen_ppr(' + nro_necrop + ',' + ave + ')" value="subir imagen"/> ';
            contenido_carga_imagen += '<br></form></div></div>';



            $("#ave_nro").append(ave_nro);
            $("#contenido_carga_imagen").append(contenido_carga_imagen);
            $("#modal_imagen").modal("show");

            // $('#form_imagen').on('submit', function (event)
            //{
            //   event.preventDefault();
            //  consulta_aviarios_dinamico_ppr("p");
            //event.stopPropagation(); });
            cerrar_load();
        }


    });
}


$('.carousel-control-prev').click(function () {
    $('#demo_carrusel').carousel('prev');
});

$('.carousel-control-next').click(function () {
    $('#demo_carrusel').carousel('next');
});


function ppr_necropsias_files_preview(nro_necrop, ave) {
    $.post("apps/ppr/necropsias/necropsias.files.preview.php",
            {id: nro_necrop, ave: ave}, function (res) {
        $("#archivos_preview").html(res);
    });
}


function registrar_necropsias_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVA NECROPSIA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_agregar_necropsias.jsp",
                data: {fecha: $('#fecha').val(),
                    lote: $('#lote').val()
                },
                beforeSend: function (xhr) {
                    cargar_load();
                },
                success: function (res)
                {
                    cerrar_load();
                    //$('#ppr_necro_form').modal('toggle');
                    $('#ppr_necro_form').modal('hide');
                    ir_consultar_registro_necropsias_ppr();
                }

            });
        }
    });
}



function necropsias_nuevafila_ppr(score_id) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_items_necropsias.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");

        },
        data: {score_id: score_id},

        success: function (data) {


            $('#datosnecropsiasregistrados').html(data.grilla_a);
            necropsias_detalle_onselect_ppr();
            cerrar_load();


        }
    });
}
function registrar_necropsias_score_detalle(necrop_id, ave, fecha) {


    $.ajax({
        url: ruta_cruds_ppr + "crud_agregar_necropsias_score.jsp",
        type: "post",
        data: {necrop_id: necrop_id,
            ave: ave

                    //valor:valor
        },
        success: function (data) {

            {
                $.ajax({
                    //String fecha;
                    url: ruta_consultas_ppr + "consulta_editar_necropsias.jsp",
                    type: "post",
                    beforeSend: function (xhr) {
                        cargar_load();
                    },
                    data: {
                        necrop_id: necrop_id,
                        fecha: fecha
                    },

                    success: function (data) {

                        $('#datosnecropsiasregistrados').html(data.grilla_a);
                        $('#edad').html(data.edad);
                        var td = $("#datosnecropsiasregistrados tr td").length;


                        // document.getElementById('btn_agre_ave').disabled=true;  


                        necropsias_detalle_onselect_ppr();
                        cerrar_load();
                    }
                });
            }
        }
    });
}


function necropsias_detalle_onselect_ppr() {
    var editables = document.querySelectorAll("[contentEditable]");
    for (var i = 0, len = editables.length; i < len; i++) {
        //editables[i].setAttribute("valor", editables[i].innerHTML);
        editables[i].onfocus = function () {
            celda_editable_selectElement_ppr(this);
        };
        editables[i].onblur = function () {
            if (this.innerHTML == this.getAttribute("value-data") || this.innerHTML == "")
            {
                this.innerHTML = this.getAttribute("value-data");
            } else {
                this.setAttribute("valor", this.innerHTML);
                var valor = this.getAttribute("valor");
                var regex = /<br\s*[\/]?>/gi;
                valor = valor.replace(regex, "");
                var campo = this.getAttribute("id");
                var idscore = this.getAttribute("id-score");
                var valor_viejo = this.getAttribute("value-data");


                editar_necropsias_score_detalle(idscore, valor);

            }
        };
    }
}
function celda_editable_selectElement_ppr(el)
{
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
}





function modificar_necropsias_ppr(idlote) {


    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA ELIMINAR NECROPSIAS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {

            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_modificar_necropsias.jsp",
                data: {idlote: idlote},
                beforeSend: function ()
                {
                    cargar_load("Consultando...");
                },
                success: function (res)
                {
                    if (res.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });


                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                    cerrar_load();
                    ir_consultar_registro_necropsias_ppr();
                }


            });
        }
    });
}


function editar_necropsias_score_detalle(idscore, score) {



    $.ajax({
        url: ruta_cruds_ppr + "crud_modificar_necropsias_score_detalle.jsp",
        type: "post",
        data: {idscore: idscore,
            score: score

                    //valor:valor
        },
        success: function (data) {
        }
    });
}



function subir_imagen_necropsias_prr(ave_nro_imagen, nec_id) {

    var files = document.getElementById('file').files;
    if (files.length == 0) {
        alert("Por favor seleccione algun archivo(s)....");
        return;
    }
    var file;
    var c = 0;
    for (var i = 0; i < files.length; i++) {
        if (c == 0) {
            file = files[i].name + "";
        } else {
            file = file + "," + files[i].name;
        }
        c++;

    }

    $.ajax({
        url: ruta_cruds_ppr + "crud_agregar_necropsias_imagen12.jsp",
        type: "post",

        data: {file: file,
            ave_nro_imagen: ave_nro_imagen,
            nec_id: nec_id

        },

        success: function (data) {
            if (data.tipo_registro == "2") {
                swal.fire({
                    type: 'success',
                    text: data.mensaje,
                    confirmButtonText: "CERRAR"
                });


            }
        }
    });

}

function upload_imagen_ppr(nec_id, ave) {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA GUARDAR IMAGENES?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {

            var data = new FormData();

            $.each($("input[type='file']")[0].files, function (i, file) {
                data.append('file', file);
                data.append(nec_id, nec_id);
                data.append(ave, ave);
            });

            $.ajax({
                method: "POST",
                url: ruta_cruds_ppr + "crud_agregar_necropsias_imagen.jsp",
                contentType: false,
                processData: false,
                data: data,
                beforeSend: function ()
                {
                    cargar_load("Consultando...");
                },
                success: function (result) {
                    $("#file").val("");
                    if (result.tipo_registro == "2") {
                        swal.fire({
                            type: 'success',
                            text: result.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: result.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                    cerrar_load();
                }

            });
//alert('The file upload with Ajax and Java was a success!');
        }
    });
}

function ppr_necropsias_form_nuevafila() {

    var rowCount = $("#datosnecropsiasregistrados tr").length;
    rowCount = rowCount - 2;
    var conteo = parseInt($("#1lastsco").val());
    var necrop_id = parseInt($("#necrop-id").val());
    var fecha = $('#fecha_necro').val(),
            fecha
    valores = (necrop_id, rowCount, 1);

    var s = "<tr>";
    s += '<td class="text-center" pnec-items="' + (rowCount + 1) + '">' + (rowCount + 1) + "</td>";
    s += '<td style="background-color: #ffddb8" id="' + (necrop_id) + ',' + (rowCount + 1) + ',1" align="center" style= "dislay: none;" contentEditable="true" id="" value-data="0" tabindex="">0</td>';
    s += '<td style="background-color: #ffddb8" id="' + (necrop_id) + ',' + (rowCount + 1) + ',2" align="center" style= "dislay: none;" contentEditable="true" id=""  value-data="0"  tabindex="">0</td>';
    s += '<td style="background-color: #ffddb8" id="' + (necrop_id) + ',' + (rowCount + 1) + ',3" align="center" style= "dislay: none;" contentEditable="true" id=""  value-data="0"  tabindex="">0</td>';
    s += '<td style="background-color: #ffddb8" id="' + (necrop_id) + ',' + (rowCount + 1) + ',4" align="center" style= "dislay: none;" contentEditable="true" id=""  value-data="0" tabindex="">0</td>';
    s += '<td contentEditable="true"><button class="bg-navy" onclick=id="' + (necrop_id) + ',' + (rowCount + 1) + '">ver archivos</button></td>';
    s += "</tr>";
    $("#datosnecropsiasregistrados tbody").append(s);
    $("#1lastsco").val(conteo + 1);
    ave = rowCount + 1;


    registrar_necropsias_score_detalle(necrop_id, ave, fecha);

    necropsias_detalle_onselect_ppr();

}

function modal_agregar_lote_ppr(aviario) {

    $('#aviario_lote').val(aviario);
    $("#agregar_lote_aviario").modal("show");
}

function modal_desactivar_lote_ppr(aviario, lote, ultimo_registro) {

    $('#fecha_ultimo').val(ultimo_registro);
    $('#lote_desac').val(lote);
    $('#aviario_desac').val(aviario);
    $("#desactivar_lote_aviario").modal("show");
}

function desactivar_lote_ppr() {
    Swal.fire({
        title: 'Comfimacion',
        text: "Enviar Peticion?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Desactivar lote!',
        cancelButtonText: 'No, cancelar!'}).then((result) =>
    {
        if (result.value)
        {
            var fecha = $('#fecha_desac').val();
            ;
            var lote = $('#lote_desac').val();
            ;
            var aviario = $('#aviario_desac').val();
            ;

            $.ajax({

                type: "post",
                url: ruta_cruds_ppr + "crud_desactivar_aviario_lote.jsp",
                data: {
                    fecha: fecha,
                    lote: lote,
                    aviario: aviario

                },
                success: function (res) {

                    if (res.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR",

                        });

                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                    $('#desactivar_lote_aviario').modal('hide');
                }});
        }
    });
}

function activar_lote_ppr() {

    Swal.fire({
        title: 'Comfimacion',
        text: "Enviar Peticion?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Activar aviario!',
        cancelButtonText: 'No, cancelar!'}).then((result) =>
    {
        if (result.value)
        {
            var fecha = $('#fecha_actic').val();
            var lote = $('#lote').val();
            var aviario = $('#aviario_lote').val();
            var saldo_inicial = $('#saldo_inicial').val();


            $.ajax({

                type: "post",
                url: ruta_cruds_ppr + "crud_activar_aviario_lote.jsp",
                data: {
                    fecha: fecha,
                    lote: lote,
                    aviario: aviario,
                    saldo_inicial: saldo_inicial

                },
                success: function (res) {

                    if (res.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR",

                        });

                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });
                    }
                    $('#agregar_lote_aviario').modal('hide');
                    $('#lote').html("");
                    $('#saldo_inicial').html("");
                    $('#aviario_lote').html("");
                    carga_grilla_registro_datos_diarios_A_ppr();
                    //carga_grilla_pre_des_convencionales_ppr2();
                }});
        }
    });
}


function traer_vista_registro_contador_huevo_ppr() {
    window.location.hash = "pprRegistroNecropsias";

    $.ajax({
        url: ruta_vistas_ppr + "vista_registro_contadores_huevos.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            cargar_estilo_calendario_insert("yyyy-mm-dd");
            ocultar_ppr();
            cerrar_load();
        }

    });
}

function contador_registro_huevos_ppr(avi) {

    var inputs = document.querySelectorAll("[contenteditable]");
    for (var i = 0, len = inputs.length; i < len; i++) {
        inputs[i].setAttribute("conta_id", 0);
    }
    lote = $('select option:selected').data('lote');
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registros_contadores_huevos.jsp',
        data: {
            fecha: $('#idfecham').val(),
            aviario: $('#avis').val(),
            lote: lote
        },
        beforeSend: function (xhr) {
            limpiarm_ppr(), cargar_load("Consultando...");
            ;
        },
        success: function (data) {
            var total_huevos = 0;
            var productividad = 0;
            var diferencia = 0;
            $.each(data.filas, function (i, item)
            {
                $(item.id).html(item.cantidad);

                var nodo = document.getElementById(item.fila);
                valor = nodo.getAttribute("valor");
                if (item.fila === "") {
//
                } else {
                    var a = document.createAttribute("conta_id");
                    a.value = item.mor_id;
                    nodo.setAttributeNode(a);
                }

                total_huevos = parseInt(total_huevos) + parseInt(item.cantidad);

            }

            );

            productividad = (parseInt(total_huevos) * 100 / parseInt(data.saldoaves)).toFixed(1);
            diferencia = (productividad - parseInt(data.pad_productividad));
            var subTotalFormatted = Math.floor(diferencia * 10) / 10;


            if (productividad == "NaN" || productividad == "Infinity") {
                productividad = 0,
                        diferencia = -data.pad_productividad
            } else {

            }
            if (productividad >= data.pad_productividad) {
                $("#diferencia").css("background-color", "#90EE90");
            } else {
                $("#diferencia").css("background-color", "#FF6961");
            }

            cerrar_load();
            $(".ocultar").show();
            $("#total_filas").val(total_huevos);
            $("#lote").val(data.lote);
            $("#avi").val(data.aviario);
            $("#productividad").val(productividad + '%');
            $("#poduc_pad").val(data.pad_productividad + '%');
            $("#diferencia").val(subTotalFormatted + '%');
            $("#edad").val(data.dias + ' dias (' + data.sems + ' sems.)');
            $("#poduc_pad").css("background-color", "#EA80FC");
            onselect_grilla_contador_huevo_ppr();
        }
    });
}



function onselect_grilla_contador_huevo_ppr() {
    var inputs = document.querySelectorAll("[contenteditable]");
    for (var i = 0, len = inputs.length; i < len; i++) {
        inputs[i].setAttribute("valor", inputs[i].innerHTML);

        inputs[i].onfocus = function () {
            celda_editable_selectElement_ppr(this);
        };

        inputs[i].onblur = function () {
            if (this.innerHTML == this.getAttribute("valor"))
            {

            } else
            {
                this.setAttribute("valor", this.innerHTML);
                var valor = this.getAttribute("valor");
                var conta_id = this.getAttribute("conta_id");
                var fecha = $("#idfecham").val();
                var aviario = $("#avis").val();
                var fila = this.getAttribute("id");
                lote = $('select option:selected').data('lote');

                crud_update_contador_huevos_ppr(conta_id, valor, fecha, fila, lote, aviario);

            }
            ;
        };
    }
}


function crud_update_contador_huevos_ppr(conta_id, valor, fecha, fila, lote, aviario) {

    $.ajax({
        type: "post",
        url: ruta_cruds_ppr + "crud_update_contador_huevos.jsp",
        data: {
            conta_id: conta_id,
            fecha: fecha,
            valor: valor,
            fila: fila,
            lote: lote,
            aviario: aviario
        },
        success: function (data) {

            if (data.id_contador == "0") {

            }
            if (data.tipo_registro == 1) {
                var nodo = document.getElementById(fila);
                nodo.setAttribute("conta_id", 0);
            } else {
                var nodo = document.getElementById(fila);
                nodo.setAttribute("conta_id", data.id_contador);
            }
            contador_registro_huevos_actualizar_ppr();

        }});
}

function contador_registro_huevos_actualizar_ppr() {

    lote = $('select option:selected').data('lote');
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + '/consulta_registros_contadores_huevos.jsp',
        data: {
            fecha: $('#idfecham').val(),
            aviario: $('#avis').val(),
            lote: lote
        },

        success: function (data) {
            var total_huevos = 0;
            var productividad = 0;
            var diferencia = 0;


            productividad = (parseInt(data.huevos) * 100 / parseInt(data.saldoaves)).toFixed(1);
            diferencia = (productividad - parseInt(data.pad_productividad));
            var subTotalFormatted = Math.floor(diferencia * 10) / 10;


            if (productividad == "NaN" || productividad == "Infinity") {
                productividad = 0,
                        diferencia = -data.pad_productividad
            } else {

            }
            if (productividad >= data.pad_productividad) {
                $("#diferencia").css("background-color", "#90EE90");
            } else {
                $("#diferencia").css("background-color", "#FF6961");
            }

            cerrar_load();
            $(".ocultar").show();
            $("#total_filas").val(data.huevos);
            $("#lote").val(data.lote);
            $("#avi").val(data.aviario);
            $("#productividad").val(productividad + '%');
            $("#poduc_pad").val(data.pad_productividad + '%');
            $("#diferencia").val(subTotalFormatted + '%');
            $("#edad").val(data.dias + ' dias (' + data.sems + ' sems.)');
            $("#poduc_pad").css("background-color", "#EA80FC");
            onselect_grilla_contador_huevo_ppr();
        }
    });
}

function traer_vista_registro_lotes_ppr() {
    ir_consultar_registro_lotes_ppr();
    //window.location.hash = "pprRegistroNecropsias";

    $.ajax({
        url: ruta_vistas_ppr + "vista_registro_lotes.jsp",
        type: "post",
        beforeSend: function (xhr) {
            cargar_load();

        },
        success: function (data) {

            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenedor_principal').html(data);
            $('#contenido_row').html("");
            cargar_estilo_calendario_insert("yyyy-mm-dd");
            ocultar_ppr();
            cerrar_load();
        }

    });
}

function ir_consultar_registro_lotes_ppr() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_registro_lotes.jsp",
        beforeSend: function (xhr) {
            limpiarg_ppr(), cargar_load("Consultando...");

        },

        success: function (data) {

            $('#tabla_a').html(data.grilla_a);
            $('#idresumen_det').html("");
            $('#idresumen_huevos').html("");
            $('#contenido_row').html("");
            $('#tabla_b').html("");
            mostrar_ppr();

            cerrar_load();


            //$("#datosnecropsiasregistrados").dataTable({language: {sUrl: "js/Spanish.txt"}});
            $(".ocultar").show();

            // }
        }
    });
}

function registrar_lote_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA CREAR EL NUEVO LOTE?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_agregar_lote.jsp",
                data: {nombrelote: $('#nombrelote').val(),
                    lote_pedido: $('#lote_pedido').val(),
                    raza_lote: $('#raza_lote').val(),
                    fecha_pedido: $('#fecha_pedido').val(),
                    fecha_naci: $('#fecha_naci').val()
                },
                beforeSend: function (xhr) {
                    cargar_load();
                },
                success: function (res)
                {
                    if (res.tipo_registro == "2") {
                        swal.fire({
                            type: 'success',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR",
                        });


                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: res.mensaje,
                            confirmButtonText: "CERRAR"
                        });

                    }

                    $('#ppr_lote_form').modal('hide');
                    ir_consultar_registro_lotes_ppr();
                    cerrar_load();
                }
            });
        }
    });
}
function modificar_lote_ppr() {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA MODIFICAR LOTE?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI, CREAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_modificar_lote.jsp",
                data: {idlote: $('#idlote').val(),
                    nombrelote: $('#nombrelote').val(),
                    lote_pedido: $('#lote_pedido').val(),
                    raza_lote: $('#raza_lote').val(),
                    fecha_pedido: $('#fecha_pedido').val(),
                    fecha_naci: $('#fecha_naci').val()
                },
                beforeSend: function (xhr) {
                    cargar_load();
                },
                success: function (data)
                {
                    if (data.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: data.mensaje,
                            confirmButtonText: "CERRAR",
                        });


                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: data.mensaje,
                            confirmButtonText: "CERRAR"
                        });

                    }
                    $('#ppr_lote_form').modal('hide');
                    ir_consultar_registro_lotes_ppr();
                    cerrar_load();
                }
            });
        }
    });
}
function edit_lotes_ppr(lote_id, lote_name, lote_raza, lote_cped, lote_fped, lote_fnac) {
    $("#idlote").val(lote_id);
    $("#nombrelote").val(lote_name);
    $("#lote_pedido").val(lote_cped);
    $("#raza_lote").val(lote_raza);
    $("#fecha_pedido").val(lote_fped);
    $("#fecha_naci").val(lote_fnac);
    $(".modal-title").text("MODIFICAR LOTE");
    document.getElementById("cambio").setAttribute("onclick", "modificar_lote_ppr()");
    $("#ppr_lote_form").modal("show");
}

function modal_lotes_ppr() {
    document.getElementById("idlote").value = "";
    document.getElementById("nombrelote").value = "";
    document.getElementById("lote_pedido").value = "";
    document.getElementById("raza_lote").value = "";
    document.getElementById("fecha_pedido").value = "";
    document.getElementById("fecha_naci").value = "";
    $(".modal-title").text("REGISTRO NUEVO LOTE");
    document.getElementById("cambio").setAttribute("onclick", "registrar_lote_ppr()");
    $("#ppr_lote_form").modal("show");
}

function modificar_estado_lote_ppr(lote_id) {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA DESACTIVAR LOTE?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI, DESACTIVAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_modificar_estado_lote.jsp",
                data: {idlote: lote_id
                },
                beforeSend: function (xhr) {
                    cargar_load();
                },
                success: function (data)
                {
                    if (data.tipo_respuesta == "2") {
                        swal.fire({
                            type: 'success',
                            text: data.mensaje,
                            confirmButtonText: "CERRAR",
                        });


                    } else
                    {
                        swal.fire({
                            type: 'error',
                            text: data.mensaje,
                            confirmButtonText: "CERRAR"
                        });

                    }
                    ir_consultar_registro_lotes_ppr();
                    cerrar_load();
                }
            });
        }
    });
}


function ir_proyeccion_ppr()
{
  //  ir_pagina_generico(ruta_vistas_ppr, 'contenedor_proyeccion.jsp', "pry1", 'yyyy-mm-dd', false);
    
    $.ajax({
        type: "POST",
        url: ruta_vistas_ppr + "contenedor_proyeccion.jsp",
        
        beforeSend: function (xhr) 
        {
            cargar_load();
            $("#contenedor_principal").html("");
        },
        success: function (data)
        { 
            $("#contenedor_principal").html(data);
            control_crear_proyeccion_lote_ppr();
            registrar_lote_descarte();
            refrescar_grilla_pry_lotes_ppr();
            refrescar_grafico_proyeccion_general_ppr();
           cerrar_load();  
         },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
              recargar_pagina();
             }
         }
    }); 
    
}

  
function drawChart() {

 
    $.ajax({
        type: "POST",
        //   url: ruta_consultas_ppr + "consulta_gen_grafico_pry_aves_viabilidad.jsp",
        url: ruta_consultas_ppr + "consulta_gen_grafico_pry_gantt.jsp",
        beforeSend: function (xhr) {
        },
        success: function (result)
        {


            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Task ID');
            data.addColumn('string', 'Task Name');
            data.addColumn('string', 'Resource');
            data.addColumn('date', 'Start Date');
            data.addColumn('date', 'End Date');
            data.addColumn('number', 'Duration');
            data.addColumn('number', 'Percent Complete');
            data.addColumn('string', 'Dependencies');
            
            
            
            $.each(result.charts[0].data.labels, function (i, item)
            {
                data.addRow([
                    result.charts[0].data.datasets[0].id[i], 
                    result.charts[0].data.labels[i], 
                   null,  new Date(result.charts[0].data.datasets[0].data[i]), new Date(result.charts[0].data.datasets[0].data2[i]),
                   null, result.charts[0].data.datasets[0].color[i], result.charts[0].data.datasets[0].padre[i]]);
            });
             
           

            var options = {
 
                height: data.getNumberOfRows() * 35,
                gantt: {               barHeight: 10,          
                    trackHeight: 15,
                     palette: 
                        [
                            {
                              "color": "#ad1c1c",
                              "dark": "#1f7a0f",
                              "light": "#9ca6b5" 
                          }
                        ]
                 },
                
            };

            var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

            chart.draw(data, options);
        }
    }

    )


}


function gantt (){ 
    
    google.charts.load('current', {'packages':['gantt'], 'language': 'es'});

    google.charts.setOnLoadCallback(drawChart);
}




/*
function gantt (){

 $.ajax({
        type: "POST",
     //   url: ruta_consultas_ppr + "consulta_gen_grafico_pry_aves_viabilidad.jsp",
        url: ruta_consultas_ppr + "consulta_gen_grafico_pry_gantt.jsp",
        beforeSend: function (xhr) {
         },
        success: function (result)
        { 
              
             
            const data = {
      labels: result.charts[0].data.labels,
      datasets: [{
        label: 'CICLO DE VIDA',
        data:result.charts[0].data.datasets[0].data     
        
                 ,
        backgroundColor: [
          'rgba(255, 26, 104, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)',
          'rgba(0, 0, 0, 1)'
        ],
        borderColor: [
          'rgba(255, 26, 104, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)',
          'rgba(0, 0, 0, 1)'
        ],
        barPercentage:1
       // borderWidth: 1
      }]
    };

    // config 
    const config = {
      type: 'bar',
      data,
      options: {
          indexAxis:'y',
        scales: {
            x: {
                min:'2021-01-01',
            type: 'time',
            time: {
               unit:'day' 
            }
          }, 
          y: {
            beginAtZero: true
          }
        }
      }
    };

    // render init block
    const myChart = new Chart(
      document.getElementById('grafico_gral_aves2'),
      config
    ); 
        
  } 
}

)
}
 */

 
function refrescar_grafico_proyeccion_general_ppr() 
{
    $.ajax({
        type: "POST",
         url: ruta_consultas_ppr + "consulta_gen_grafico_pry_aves_viabilidad.jsp",
         beforeSend: function (xhr) {
         },
        success: function (result)
        { 
            refrescar_grilla_pry_lotes_ppr();//SE REFRESCA LA GRILLA DE LOS LOTES
            gantt();
            
            
            
            const config = 
                {
                    data    : result.charts[0].data,
                    options : 
                            {
                                plugins:options_graf_pry
                                ,
                                scales:result.charts[0].options.scales                             
                            },
                    type    : result.charts[0].type,
                  plugins : [ChartDataLabels]
                } 
                 
            if (chart_generalAves) 
            {
                chart_generalAves.destroy();
            } 
            chart_generalAves= new Chart(document.getElementById("grafico_gral_aves"),  config  );
            
  
            $.ajax({
            type: "POST",
            url: ruta_consultas_ppr + "consulta_gen_grafico_pry_aves_semanas.jsp",
            data: ({tipo:2}),
            beforeSend: function (xhr) 
            {
                $("#grafico_pry3").html("");
            },
            success: function (result)
            { 
                
    const options_graf_pry_semanas =
    {
        
        legend:
        {
            display:true,
            position: 'top',
        },
        datalabels:
        {   
           align: chart =>{
            return chart.dataset.align;    
           },
            offset:20,
           backgroundColor: chart =>
           {
                var index = chart.dataIndex;
                var value = chart.dataset.data[index];
                if(value<=18)
               {
                  return 'rgba(0, 80, 219, 1)'; 
               }
                 else if(value<=44){
                  return 'rgba(0, 122, 31, 1)'; 
               }
               else   if(value<=64){
                return 'rgba(245, 200, 0, 1)'; 
               }
               else {
                   
                 return 'rgba(168, 0, 0, 1)';   
               }
          },
           
            color: chart =>
           {
                var index = chart.dataIndex;
                var value = chart.dataset.data[index];
                if(value<=44)
                {
                  return 'white'; 
                }
                else if(value<=64)
                {
                    return 'black'; 
                }
                else 
                {
                    return 'white';   
                }
          },
            borderRadius:5,
            formatter:  function(value, context)
            { 
                 
                 return context.chart.data.labels[context.dataIndex] + '\n'+  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
             
            } ,
            labels: 
            {
               title: 
               {
                   font: 
                   {
                       weight: 'bold'
                   }
               } 
            }
        } 
    }
                
                
                
                
                
                
                
                const config = 
                {
                    data    : result.charts[0].data,
                    options : 
                            {
                                plugins:options_graf_pry_semanas,
                                 
                                scales:result.charts[0].options.scales 
                            },
                    type    : result.charts[0].type,
                    plugins : [ChartDataLabels]
                } 
                if (chart_generalSemanas) 
                {
                    chart_generalSemanas.destroy();
                } 
                chart_generalSemanas= new Chart(document.getElementById("grafico_gral_semanas"), config);
                
                
                
                    cargar_grafico_global_productividad();
                
                
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) 
            {
                if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500)
                {
                    recargar_pagina();
                }
            }
            });
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) 
        {
            if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500)
            {
                recargar_pagina();
            }
        }
    });
}
 
function cargar_grafico_global_productividad(){
      $.ajax({
            type: "POST",
            url: ruta_consultas_ppr + "consulta_gen_grafico_pry_aves_productividad.jsp",
            data: ({tipo:2}),
            beforeSend: function (xhr) 
            {
                $("#grafico_pry3").html("");
            },
            success: function (result)
            { 
                const config = 
                {
                    data    : result.charts[0].data,
                    options : 
                            {
                                plugins: options_graf_pry,
                                scales:result.charts[0].options.scales 
                            },
                    type    : result.charts[0].type,
                    plugins : [ChartDataLabels]
                } 
                if (chart_generalSemanasProductividad) 
                {
                    chart_generalSemanasProductividad.destroy();
                } 
                chart_generalSemanasProductividad= new Chart(document.getElementById("grafico_gral_productividad"), config);
                
                
                
                
                
                chart_generalSemanasProductividad
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) 
            {
                if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500)
                {
                    recargar_pagina();
                }
            }
            });
}


function grafico_proyeccion_ppr(id, aviario, nacimiento, produccion, predescarte, lote, raza) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_grafico_pry1.jsp",
        data: {id: id, aviario: aviario},
        beforeSend: function (xhr) {
            cargar_load();
        },
        success: function (result)
        {
            var c = 0;
             
                var a = '  <div class="card card-navy" >   ';
                a += '  <div class="card-header"> ';
                a += '   <h3 class="card-title"><b>Aviario '+aviario+' - '+ lote+ '</b> </h3> <br> '


                a += '   </div> ';
                a += ' <table class="table "> \n\
                        <tr> \n\
                            <th> Fecha de nacimiento: ' + nacimiento + '  </th>\n\
                            <th>  Fecha de produccion: ' + produccion + ' </th>\n\
                            <th> Fecha de predescarte: ' + predescarte + '   </th>\n\
                        </tr>\n\
                        <tr> \n\
                            <th> Ultima carga:  <input type="date" id="semana_barra" onchange="modificar_fecha_carga_pry_barra_lote_ppr()" class="form-control">   </th>\n\
                            <th>  Raza: ' + raza + ' </th> \n\
                            <th class="bg-green" id="td_titulo_semanas_graf_lote">  ' + result.subtitulo + ' </th> \n\
                        </tr>\n\
                        \n\                     <tr> \n\
                            <th><br>  <input onclick="restablecer_barra_viabilidad_lote_ppr();" type="button" value="Restablecer a ultima carga" class="form-control bg-navy">   </th>\n\
                            <th></th> \n\
                            <th>  <input type="hidden" id="id_lote_barra" class="form-control"> <input type="hidden" id="id_pry_barra" class="form-control">   </th> \n\
                        </tr>\n\
                        </table>  '; 


                $("#div_cabecera_graf_lote").html("");

                $("#div_cabecera_graf_lote").html(a);
                
                
            if (myChart) {
                myChart.destroy();
            }
             myChart=   new Chart(document.getElementById("grafViab"), result.charts[0]);
              
            
            $("#grilla_log").html(result.grilla);
            $("#grilla_log_prod").html(result.grilla_productividad);
            $("#semana_barra").val(result.semana_barra);
            $("#id_lote_barra").val(result.id_lote);
            $("#id_pry_barra").val(id);
            
            
            $("#tb_log").dataTable({"language":
                    {
                        "sUrl": "js/Spanish.txt"
                    }});
              
            $("#tb_log_prod").dataTable({"language":
                    {
                        "sUrl": "js/Spanish.txt"
                    }});
            grafico_proyeccion_productividad_lote_ppr(id);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
              recargar_pagina();
             }
         }
        
        
        
        
    });


}



function grafico_proyeccion_productividad_lote_ppr(id) {

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_grafico_pry_lote_productividad.jsp",
        data: {id: id },
        beforeSend: function (xhr) {
            cargar_load();
        },
        success: function (result)
        {
            $("#grafProd").html("");
            if (chart_lote_productividad) {
                chart_lote_productividad.destroy();
            }
            chart_lote_productividad=   new Chart(document.getElementById("grafProd"), result.charts[0]);
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
              recargar_pagina();
             }
         }
        
        
        
        
    });


}



function refrescar_grafico_proyeccion_lote_ppr(id,tipo_respuesta, mensaje) 
{
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_grafico_pry1.jsp",
        data: {id: id},
        beforeSend: function (xhr) {
         },
        success: function (result)
        { 
            $("#td_titulo_semanas_graf_lote").html(result.subtitulo);
            
              if (myChart) {
                myChart.destroy();
            }
            
           myChart= new Chart(document.getElementById("grafViab"), result.charts[0]);
           
            grafico_proyeccion_productividad_lote_ppr(id);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
              recargar_pagina();
             }
         }
    });
}


function refrescar_grilla_pry_lotes_ppr() 
{
    $.ajax({
        type: "POST",
        url: ruta_grilla_ppr + "grilla_pry_lotes.jsp",
        success: function (result)
        { 
            $("#div_grilla_pry").html("");
            $("#div_grilla_pry").html(result);
            $("#grilla_proyeccion_lotes").DataTable
            ({
                paging: false,searching: false,
                "language":
                {
                    "sUrl": "js/Spanish.txt"
                }
                
            }); 
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) 
        {
            if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500)
            {
                recargar_pagina();
            }
        }
    });
}



function modificar_fecha_carga_pry_barra_lote_ppr()
{
    $.ajax({
        type: "POST",
        url: ruta_cruds_ppr + "control_modificar_proyeccion_barra_lote.jsp",
        data: {id: $("#id_lote_barra").val(),id_cab:$("#id_pry_barra").val(),fecha:$("#semana_barra").val()},
        beforeSend: function ()
        { 
        },
        success: function (data)
        {
            
            refrescar_grafico_proyeccion_lote_ppr($("#id_pry_barra").val(),data.tipo_respuesta, data.mensaje);
            refrescar_grafico_proyeccion_general_ppr();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) 
        {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });


}





function restablecer_barra_viabilidad_lote_ppr (){
       Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA RESTABLECER LA ULTIMA CARGA?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
        {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_resetear_barra_viabilidad_pry_lote.jsp",
                data: {id:$("#id_lote_barra").val(),id_cab:$("#id_pry_barra").val() },
                beforeSend: function () 
                { 
                },
                success: function (data)
                {
                    $("#semana_barra").val(data.fecha);
                     modificar_fecha_carga_pry_barra_lote_ppr();
                },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
            });
        }
    });
}


function edit_lote_proyeccion_ppr(id, lote, aviario, aves, nacimiento, produccion, predescarte,aves_predescarte,edad_descarte_semanas,fecha_predescarte_format,flag) {

    $("#txt_id").val(id);
    $("#txt_lote").val(lote);
    $("#txt_aviario").val(aviario);
    $("#txt_cantidad_aves").val(aves);
    $("#txt_fecha_nacimiento").val(nacimiento);
    $("#txt_fecha_produccion").val(produccion);
    $("#txt_fecha_predescarte").val(predescarte);
    $("#modalLote").modal("show");
    
     contar_dias_proyeccion_ppr();
    $("#div_crear_pred").html("");
     if(flag=="NO")
     {
         var boton= "  <button class='btn btn-xs btn-warning'  "
                        + "onclick=\"clonar_lote_predescarte("+id+" ,'"+predescarte+"',"
                        +  aves_predescarte+"," 
                        + ""+edad_descarte_semanas+"," 
                        + "'"+nacimiento+"','"
                        +lote+"','"
                        +fecha_predescarte_format+"')\"  title='Crear Lote Predescarte' >Crear Lote Predescarte <i class='fa fa-plus'></i></button>";
            $("#div_crear_pred").append(boton);

        
          
     }
}



function abrir_crear_lote_proyeccion_ppr() {


    $("#modal_crear_lote").modal("show");
}


function ajuste_lote_proyeccion_ppr(id, lote, aviario, aves, nacimiento, produccion, predescarte,dias_predescarte,semanas_predescarte) {

    $("#txt_id_ajuste").val(id);
    $("#txt_fnac_ajuste").val(nacimiento);
    $("#txt_lote_ajuste").val(lote);
    $("#txt_aviario_ajuste").val(aviario);
    $("#txt_cantidad_aves_ajuste").val(aves);
    $("#txt_fecha_ajuste").val(produccion);
    $("#txt_fecha_predescarte_ajuste").val(predescarte);
    $("#txt_edad_dias_pred_ajuste").val(dias_predescarte);
    $("#txt_edad_sems_pred_ajuste").val(semanas_predescarte);

 
}



function diferencia_saldo_ajuste_lote_proyeccion_ppr() {

    var saldo_actual_fecha = $("#txt_cantidad_aves_ajuste").val();
    var saldo_nuevo = $("#txt_nuevo_saldo_ajuste").val();

    var diferencia = (parseInt(saldo_nuevo) - parseInt(saldo_actual_fecha));
    $("#txt_cantidad_ajuste").val(diferencia);



}


function sumar_dias_fechas_ppr(fecha_nacimiento) {


    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_fecha_pry.jsp",
        data: {fecha_nacimiento: fecha_nacimiento},
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#txt_fecha_produccion").val(res.fecha_produccion);
            $("#txt_fecha_predescarte").val(res.fecha_predescarte);
            $("#label_produccion").html('Fecha de produccion ' + res.dias_produccion + ' dias');
            $("#label_predescarte").html('Fecha de predescarte ' + res.dias_predescarte + ' dias');
        }
    });

}


function sumar_dias_fechas_crear_ppr(fecha_nacimiento) {


    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_fecha_pry.jsp",
        data: {fecha_nacimiento: fecha_nacimiento},
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#txt_fecha_produccion_crear").val(res.fecha_produccion);
            $("#txt_fecha_predescarte_crear").val(res.fecha_predescarte);
            $("#txt_eddad_dias_prod_crear").val(res.dias_produccion);
            $("#txt_eddad_dias_pred_crear").val(res.dias_predescarte);
            $("#txt_eddad_sems_prod_crear").val(res.semanas_produccion);
            $("#txt_eddad_sems_pred_crear").val(res.semanas_predescarte);
        }
    });

}


function capacidad_aviario_set_pry() {

    var aviario = $("#select_aviario_crear").find(':selected').attr('data-capacidad');
    $("#txt_capacidad_crear").val(aviario);

}


function cal_fecha_dia_crear_pry_ppr() {

    var fecha_nacimiento = $("#txt_fecha_nacA_crear").val();
    var dias_produccion = $("#txt_eddad_dias_prod_crear").val();
    var dias_predescarte = $("#txt_eddad_dias_pred_crear").val();

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_fecha_pry_1.jsp",
        data: {fecha_nacimiento: fecha_nacimiento, dias_produccion: dias_produccion, dias_predescarte: dias_predescarte},
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#txt_fecha_produccion_crear").val(res.fecha_produccion);
            $("#txt_fecha_predescarte_crear").val(res.fecha_predescarte);
            $("#txt_eddad_sems_prod_crear").val(res.semanas_produccion);
            $("#txt_eddad_sems_pred_crear").val(res.semanas_predescarte);


        }
    });

}


function cal_fecha_dia_predescarte_ajuste_pry_ppr() {

    var fecha_nacimiento = $("#txt_fnac_ajuste").val();
    var dias_predescarte = $("#txt_edad_dias_pred_ajuste").val();

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_fecha_pry_1.jsp",
        data: {fecha_nacimiento: fecha_nacimiento, dias_produccion: dias_predescarte, dias_predescarte: dias_predescarte},
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#txt_edad_sems_pred_ajuste").val(res.semanas_predescarte);
            $("#txt_fecha_predescarte_ajuste").val(res.fecha_predescarte);

        }
    });

}

function sumar_dias_semanas_ajuste_ppr() {

    var id = $("#txt_id_ajuste").val();
    var fecha = $("#txt_fecha_ajuste").val();
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_dias_semanas_ajuste.jsp",
        data: {id: id, fecha: fecha},
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#txt_cantidad_aves_ajuste").val(res.saldo_ave);
            $("#label_dias_ajuste").html(res.dias);
            $("#label_semanas_ajuste").html(res.semanas);
        }
    });

}


function contar_dias_proyeccion_ppr() {
    var fecha_nacimiento = $("#txt_fecha_nacimiento").val();
    var fecha_produccion = $("#txt_fecha_produccion").val();
    var fecha_predescarte = $("#txt_fecha_predescarte").val();

    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_fecha_pry_2.jsp",
        data: {fecha_nacimiento: fecha_nacimiento, fecha_produccion: fecha_produccion, fecha_predescarte: fecha_predescarte},
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#label_produccion").html('Fecha de produccion ' + res.dias_produccion + ' dias');
            $("#label_predescarte").html('Fecha de predescarte ' + res.dias_predescarte + ' dias');

        }
    });


}


function control_modificar_proyeccion_lote_ppr() {
    var id = $("#txt_id").val();
    var aves = $("#txt_cantidad_aves").val();
    var nacimiento = $("#txt_fecha_nacimiento").val();
    var produccion = $("#txt_fecha_produccion").val();
    var predescarte = $("#txt_fecha_predescarte").val();

    $.ajax({
        type: "POST",
        url: ruta_cruds_ppr + "control_modificar_proyeccion_lote.jsp",
        data: {id: id, aves: aves, nacimiento: nacimiento, produccion: produccion, predescarte: predescarte},
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
            $('.modal-backdrop').remove();
            aviso_generico(data.tipo_respuesta, data.mensaje)
            if (data.tipo_respuesta == 1)
            {
                $("#contenedor_principal").html("");
                ir_proyeccion_ppr();
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}



function control_modificar_proyeccion_lote_ajuste_ppr() {
    var id = $("#txt_id_ajuste").val();
    var fecha_ajuste = $("#txt_fecha_ajuste").val();
    var saldo_nuevo = $("#txt_nuevo_saldo_ajuste").val();
    var saldo_viejo = $("#txt_cantidad_aves_ajuste").val();
    var dia_ajuste = $("#label_dias_ajuste").html();
    var fecha_descarte = $("#txt_fecha_predescarte_ajuste").val();
    var semana_ajuste = $("#label_semanas_ajuste").html();
    var comentario = $("#comentario_ajuste").val();


    /*
     String id               = request.getParameter("id");
     String fecha_ajuste     = request.getParameter("fecha_ajuste");
     String saldo_nuevo      = request.getParameter("saldo_nuevo");
     String saldo_viejo      = request.getParameter("saldo_viejo");
     String dia_ajuste       = request.getParameter("dia_ajuste");
     String semana_ajuste    = request.getParameter("semana_ajuste");
     
     */
    $.ajax({
        type: "POST",
        url: ruta_cruds_ppr + "control_modificar_proyeccion_lote_ajuste.jsp",
        data: {id: id,
            fecha_ajuste: fecha_ajuste,
            saldo_nuevo: saldo_nuevo,
            saldo_viejo: saldo_viejo,
            dia_ajuste: dia_ajuste,
            comentario: comentario,
            semana_ajuste: semana_ajuste,
            fecha_descarte: fecha_descarte
        },
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
            $('.modal-backdrop').remove();
            aviso_generico(data.tipo_respuesta, data.mensaje)
            if (data.tipo_respuesta == 1)
            {
                $("#contenedor_principal").html("");
                ir_proyeccion_ppr();
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}



function control_crear_proyeccion_lote_ppr() 
{  
    $("#form_crear").submit(function (e) {
        e.preventDefault();
        $.ajax({
                    type: "POST",
                    url: ruta_cruds_ppr + "control_crear_lote_proyeccion.jsp",
                    data:$("#form_crear").serialize() ,
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
                        {   $('.modal-backdrop').remove();
                            $("#contenedor_principal").html("");
                            ir_proyeccion_ppr();
                        }      
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                             location.reload();
                        }
                    }
                });   
        e.stoppropagation();
    });
        
    }
    
function ppr_pro_lotes_delete (id){
      Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA ELIMINAR EL LOTE?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#001F3F',
        cancelButtonColor: '#001F3F',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: ruta_cruds_ppr + "crud_eliminar_lote_proyeccion.jsp",
                data: {id: id },
                beforeSend: function () {
                    Swal.fire({
                        title: "PROCESANDO!",
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: !1,
                        onBeforeOpen: () => {
                            Swal.showLoading(),
                                    (timerInterval = setInterval(() => {
                                        Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
                                    }, 1e3));
                        },
                    });
                },
                success: function (data)
                {
                    aviso_generico(data.tipo_respuesta, data.mensaje)
                    if (data.tipo_respuesta == 1)
                    {
                        $("#contenedor_principal").html("");
                        ir_proyeccion_ppr();
                    }
                },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
            });
        }
    });
    
}



function modificar_fecha_carga_pry_global_ppr()
{
    $.ajax({
        type: "POST",
        url: ruta_cruds_ppr + "control_modificar_proyeccion_viabilidad_global.jsp",
        data: {fecha_proyeccion_principal: $("#fecha_proyeccion_principal").val()},
        beforeSend: function ()
        { 
             Swal.fire({
                            title: "ACTUALIZANDO PROYECCION",
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
                        });
        },
        success: function (data)
        {
            aviso_generico(data.tipo_respuesta, data.mensaje);
            refrescar_grilla_pry_lotes_ppr();
            refrescar_grafico_proyeccion_general_ppr(); 
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) 
        {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });


}

function get_val_lote_predescarte_ppr(){
    
    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_get_pry_datos_lote_ppr.jsp",
        data: {lote: $("#txt_lote_crear_pred").val()},
       
        success: function (data)
        {
            $("#txt_fecha_nacA_crear_pred")         .val(data.fechaA);
            $("#txt_fecha_nacB_crear_pred")         .val(data.fechaB);
            $("#txt_eddad_dias_prod_crear_pred")    .val(data.eddadProduccionDias);
            $("#txt_eddad_sems_prod_crear_pred")    .val(data.eddadProduccionSemanas);
            $("#txt_fecha_produccion_crear_pred")   .val(data.fechaProduccion);
            $("#txt_eddad_dias_pred_crear_pred")    .val(data.eddadPredescarteDias);
            $("#txt_eddad_dias_salida_pred")    .val(data.eddadPredescarteDias);
            $("#txt_eddad_sems_pred_crear_pred")    .val(data.eddadPredescarteSemanas);
            $("#txt_fecha_predescarte_crear_pred")  .val(data.fechaPredescarte);
            $("#txt_cant_aves_crear_pred")  .val(data.cantidad_aves);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) 
        {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}




function registrar_lote_descarte()
{
    $("#clonar_pred").submit(function (e) 
    {
        e.preventDefault();
        $.ajax({
                    type: "POST",
                    url: ruta_cruds_ppr + "control_crear_lote_descarte_proyeccion.jsp",
                    data:$("#clonar_pred").serialize() ,
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
                        {   $('.modal-backdrop').remove();
                            $("#contenedor_principal").html("");
                            ir_proyeccion_ppr();
                        }      
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                             location.reload();
                        }
                    }
                });   
        e.stoppropagation();
    });
        
}

function clonar_lote_predescarte(id,fecha_predescarte,cantidad,semana_inicio,fecha_nacimiento,lote,fecha_predescarte_format){
    
    $('#modalLote').modal('toggle');
    
    
      const decimal = numeral(cantidad).format('0,0');
      var html='<div class="modal-header bg-navy">'+
               ' <h5 class="modal-title " id="exampleModalLabel"><strong>Crear Lote para Pre-descarte '+lote+'</strong></h5>'+
            ' </div> '+"<form id='clonar_pred'> <br>\n\
                \n\
              <table class='table'>\n\
            <tr>\n\
            <th >Cantidad de aves "+decimal.replace(',', '.')+" </th>\n\
            <th><p style='color:red'>Excedentes 0*</p> </th>\n\
            </tr>\n\
\n\         <tr>\n\
\n\            <th>Fecha a predescarte <br><label id='label_semana_inicial'> "+fecha_predescarte_format+" </label>  <input type='hidden'    name='calendario_pred_inicio' id='calendario_pred_inicio' value="+fecha_predescarte+" ></th>\n\
            <th>Fecha finalizacion predescarte <br><input required  class='form-control  is-invalid  '    onchange=\"sumar_dias_fechas_crear_salida_ppr('"+fecha_nacimiento+"',$('#calendario_pred_fin').val(),'label_semana_final')\" type='date' name='calendario_pred_fin' id='calendario_pred_fin' value="+fecha_predescarte+" ></th>\n\
           </tr>\n\
\n\         <tr>\n\
\n\            <th><label id='label_semana_inicial'>Semana: "+semana_inicio+" </label></th>\n\
\n\            <th><label id='label_semana_final'>Semana: "+semana_inicio+" </label></th>\n\
           </tr>\n\
</table> <br> <input type='hidden' required name='id_clon_pred' id='id_clon_pred' value="+id+" >  <input type='submit' class='btn bg-navy' value='Crear lote' ></form> ";
    
    Swal.fire({
                             html: html,
                            showCancelButton: false,
                            showConfirmButton: false,
                                customClass: 'swal-wide',

                        });
                        
                        
         registrar_lote_descarte();               
}


function sumar_dias_fechas_crear_salida_ppr(fecha_nacimiento,fecha_descarte,id_input) {


    $.ajax({
        type: "POST",
        url: ruta_consultas_ppr + "consulta_gen_calculo_fecha_descarte_pry.jsp",
        data:   { 
                    fecha_nacimiento:   fecha_nacimiento,
                    fecha_descarte:     fecha_descarte
                },
        beforeSend: function (xhr) {
        },
        success: function (res)
        {
            $("#"+id_input).html(res.semana_salida);
              
        }
    });

}


function ventana_venta_predescarte(fecha){
      
        var html='<div class="modal-header bg-navy">'+
               ' <h5 class="modal-title " id="exampleModalLabel"><strong>Calculo de Pre-Descarte / Venta</strong></h5>'+
            ' </div> '+"<form  > <br>\n\
                \n\
            <table class='table' > \n\
                <tr>\n\
                    <th class='text-left'>Fecha Inicio Venta:</th>\n\
                    <th  ><input required    class=\"form-control text-center\"   value='"+fecha+"'  onchange=\"gen_grilla_lotes_ventas_ppr($('#calendario_venta').val());\"  type='date'  id='calendario_venta'  ></th>\n\
                </tr>\n\
    \n\         <tr>\n\
    \n\             <th class='text-left'>Cantidad Venta:  </th>\n\
                    <th > <input required    class=\"form-control text-center\"  placeholder='Ingrese cantidad de aves'     type='number'  id='cantidad_venta'  ></th>\n\
                </tr>\n\
            </table><div id='div_grilla_lotes_ventas'> </div> <br>  \n\
            <input type='button' class='btn bg-navy' value='Registrar'  onclick='crud_registrar_venta_ppr()'>\n\
</form> ";  
    
    Swal.fire({
                             html: html,
                            showCancelButton: false,
                            showConfirmButton: false,
                            customClass: 'swal-wide',

                        });
                gen_grilla_lotes_ventas_ppr($("#calendario_venta").val());        
                  
 }

function gen_grilla_lotes_ventas_ppr(fecha){
    $.ajax({
                    type: "POST",
                    url: ruta_consultas_ppr + "consulta_gen_grilla_lotes_ventas.jsp",
                    data:({fecha:fecha}),
                   
                    success: function (data) 
                    {     
                        $("#div_grilla_lotes_ventas").html(data.grilla);
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                             location.reload();
                        }
                    }
                }); 
}



function crud_registrar_venta_ppr(){
    $.ajax({
                    type: "POST",
                    url: ruta_cruds_ppr + "control_modificar_proyeccion_ventas.jsp",
                    data:({fecha:$("#calendario_venta").val(),venta:$("#cantidad_venta").val()}),
                   
                    success: function (data) 
                    {     
                         aviso_generico(data.tipo_respuesta, data.mensaje);  
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                             location.reload();
                        }
                    }
                }); 
}