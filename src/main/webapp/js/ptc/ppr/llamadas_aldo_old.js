var ruta_cruds_ppr = "./cruds/ppr/";
var ruta_consultas_ppr = "./consultas/ppr/";
var ruta_vistas_ppr = "./contenedores/contenedores_ppr/";
var ruta_grilla_ppr = "./grillas/ppr/";
var ruta_vistas_general = "./contenedores/";

var serial = 0;


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

                },   beforeSend: function () {
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

function edit_usuario_ppr(id, usuario, nombre, clasificadora, desc_rol,select_estado) {
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
                data: {txt_id: txt_id, txt_nombre: txt_nombre, txt_usuario: txt_usuario, txt_clasificadora: txt_clasificadora, select_rol2: select_rol2,   select_estado: select_estado},
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
                                { Swal.getContent().querySelector("strong").textContent = Swal.getTimerLeft();
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
                    } 
                    else 
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
                data: {txt_id_rol: txt_id_rol, txt_decri_rol: txt_decri_rol, select_estado_roles: $("#select_estado_roles").val() },
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
                       cargar_grilla_roles_ppr() ;
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
    window.location.hash = "SegRegistroUsuario";

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

function ppr_contador_onselect_ppr() {
    var editables = document.querySelectorAll("[contentEditable]");
    for (var i = 0, len = editables.length; i < len; i++) {
        editables[i].setAttribute("data-orig", editables[i].innerHTML);
        editables[i].setAttribute("data-fecha", editables[i].innerHTML);
        editables[i].onfocus = function () {
            celda_editable_selectElement(this);
        };
        editables[i].onblur = function () {
            if (this.innerHTML == this.getAttribute("data-orig")) {
                this.innerHTML = this.getAttribute("data-orig");
            } else {
                this.setAttribute("data-orig", this.innerHTML);
                var valor = this.getAttribute("data-orig");
                var regex = /<br\s*[\/]?>/gi;
                valor = valor.replace(regex, "");
                var fecha = this.setAttribute("fecha");
                var avi = this.setAttribute("avi");
                var fila = this.setAttribute("fila");
                var lote = this.setAttribute("lote");
                ppr_contador_reg(fecha, avi, lote, fila, valor)
            }
        };
    }
}

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
        url: ruta_consultas_ppr+"consulta_chart_resumen_fila_huevo.jsp",
        data: {fila: fila,
               aviario: $('#aviario').val(),
               fecha: $('#fecha').val() },
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



