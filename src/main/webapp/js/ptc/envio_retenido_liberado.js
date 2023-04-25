var ruta_contenedores_ptc = "./contenedores/ptc/";
var ruta_cruds_ptc = "./cruds/ptc/";
var ruta_grillas_ptc = "./grillas/ptc/";
var ruta_consultas_ptc = "./consultas/ptc/";

function boton_animacion_eliminar() {
    swal({
        title: "Registro realizado con exito!!",
        text: "",
        timer: 1000,
        showConfirmButton: false
    }
    );
    Eliminar_fila_carro_mesa();
}

function boton_animacion_validacion_carromesa() {
    swal({
        title: "Error, debe cargar el numero de mesa.",
        text: "",
        timer: 1500,

        showConfirmButton: false
    }
    );
}

function mensaje_error() {
    swal.fire({
        type: 'error',
        title: "CARGAR DATOS ",
        confirmButtonText: "CERRAR"
    });
}

function detalle_reproceso(calendario, combo_disposicion) {
    $.get(ruta_grillas_ptc + 'grilla_reproceso.jsp', {calendario: calendario, combo_disposicion: combo_disposicion, tipo: $('#tipo').val()}, function (res) {
        $("#contenedor_grilla_reproceso").html(res);
        $("#box_reproceso").on('click', function () {
            chequear_reproceso();
        });
    });
    gatillar_diposicion_cambio();

}


//Esta es la función que una vez se cargue el documento será gatillada.
function gatillar_diposicion_cambio() {
    $("#disposicion_insert").val($("#disposicion").val());
}

function chequear_reproceso() {
    var checked = $("#box_reproceso").prop('checked');
    $('#contenedor_grilla_reproceso').find('input:checkbox').prop('checked', checked);
}

function setear_check() {
    var arr = $('[name="checks[]"]:checked').map(function () {
        return this.value;
    }).get();
    var resultado_seleccionado = arr.join(',');
    $('#caja_check').val(resultado_seleccionado);
}

function Enviar_datos_cambio_disposicion_lib() {

    setear_check();
    var fecha_alimentacion = $("#calendario_alimentacion").val();
    var liberado_por = $("#txt_lib").val();
    var fecha_clasificacion = $("#calendario_reproceso").val();
    var disposicion_insert = $("#disposicion_insert").val();
    var combo_disposicion = $("#disposicion").val();
    var resultado = $("#caja_check").val();



    if (disposicion_insert === "8" && combo_disposicion === "8" || disposicion_insert === "9" && combo_disposicion === "9"
            || disposicion_insert === "27" && combo_disposicion === "27" || disposicion_insert === "30" && combo_disposicion === "30") {

        aviso_duplicado_disposicion();

    } else {

        if (disposicion_insert === "6" && combo_disposicion === "6" || disposicion_insert === "7" && combo_disposicion === "7") {

            if (resultado === "") {
                aviso("ERROR, SELECCIONAR LOTE");
            }

            if (liberado_por === "") {
                aviso("ERROR, COMPLETAR DATOS");
            } else if (fecha_alimentacion === "") {
                aviso("ERROR, INGRESAR FECHA DE ALIMENTACION");
            } else if (fecha_clasificacion === "") {
                aviso("ERROR, INGRESAR FECHA DE CLASIFICACION");
            } else {

                Swal.fire({
                    title: 'CONFIRMACION',
                    text: "DESEA APLICAR LOS CAMBIOS A LOS LOTES SELECCIONADOS?",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'SI!',
                    cancelButtonText: 'NO, CANCELAR!'
                }).then((result) => {
                    if (result.value) {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            willOpen: () => {
                                Swal.showLoading()
                            }

                        });

                        enviar_datos_reproceso();

                    }
                });
            }
        }

        // else   if(disposicion_insert==="8"||disposicion_insert==="9"||disposicion_insert==="27"||disposicion_insert==="30"){
        else {

            if (resultado === "") {
                aviso("ERROR, SELECCIONAR LOTE");
            } else if (fecha_clasificacion === "") {
                aviso("ERROR, INGRESAR FECHA DE CLASIFICACION");
            } else {
                Swal.fire({
                    title: 'CONFIRMACION',
                    text: "DESEA APLICAR LOS CAMBIOS A LOS LOTES SELECCIONADOS?",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'SI!',
                    cancelButtonText: 'NO, CANCELAR!'
                }).then((result) => {
                    if (result.value) {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            willOpen: () => {
                                Swal.showLoading()
                            }

                        });

                        enviar_datos_reproceso();

                    }
                });

            }
        }
    }
}

function enviar_datos_reproceso()
{
    $.ajax({
        type: "POST",
        url: ruta_cruds_ptc + "control_disposicion.jsp",
        data: $("#formulario_reproceso").serialize(),
        success: function (data)
        {
            aviso_registrado_dispo(data.tipo_mensaje, data.mensaje);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
;

function aviso(mensaje) {


    swal.fire({
        type: "error",
        title: mensaje,
        text: "",
        showConfirmButton: true

    }
    );

    $.preloader.stop();
}

function aviso_duplicado_disposicion() {


    swal.fire({
        type: "error",
        title: "ERROR, DEBE CAMBIAR A OTRO TIPO DE DISPOSICION",
        text: "",

        showConfirmButton: true

    }
    );

    $.preloader.stop();
}

function aviso2() {


    swal.fire({
        title: "CORRECTO",
        text: "",
        timer: 2000,

        showConfirmButton: false

    }
    );
}

function aviso_registrado_dispo(tipo, mensaje) {
    if (tipo == "1") {
        swal.fire({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        $("#contenedor_principal").html("");
    } else {
        swal.fire({
            type: 'error',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
    }
}

function ver_div() {
    var disposicion = $("#disposicion").val();

    if (disposicion === "6" || disposicion === "7") {
        $("#calendario_alimentacion").val('');
        $("#div_fecha_ali").show();
        $("#div_registro").show();
        $("#div_disposicion").show();
    }

    if (disposicion === "8" || disposicion === "9" || disposicion === "30") {
        $("#calendario_alimentacion").val('');
        $("#div_fecha_ali").hide();
        $("#div_registro").show();
        $("#div_disposicion").show();
    }
}

function funcion_disposicion()
{
    var disposicion_insert = $("#disposicion_insert").val();
    var disposicion = $("#disposicion").val();

    if (disposicion_insert === "7" && disposicion === "7" || disposicion_insert === "6" && disposicion === "6")
    {
        $("#div_fecha_ali").show();
        $("#div_registro").show();
        $("#div_disposicion").show();
        $("#txt_lib").show();
    } else
    {
        $("#div_fecha_ali").hide();
        $("#div_registro").show();
        $("#div_disposicion").show();
        $("#txt_lib").hide();
    }
}

function accion_combo_ptc()
{
    var disposicion = $("#disposicion").val();
    if (disposicion === "6" || disposicion === "7")
    {
        $("#calendario_alimentacion").val('');
        $("#div_fecha_ali").show();
        $("#div_registro").show();
        $("#div_disposicion").show();
    }
    if (disposicion === "8" || disposicion === "9" || disposicion === "30" || disposicion === "27")
    {
        $("#calendario_alimentacion").val('');
        $("#div_fecha_ali").hide();
        $("#div_registro").show();
        $("#div_disposicion").show();
    }
    detalle_reproceso($('#calendario_reproceso').val(), $('#disposicion').val())
}

function enviar_movimiento(estado, disposicion, estado_liberacion, liberado_por) {

    var arr = $('[name="checks[]"]:checked').map(function () {
        return this.value;
    }).get();
    var valor_grilla = arr.join(',');

    if (valor_grilla.length == 0) {
        swal.fire({
            type: 'error',
            title: "ERROR, SELECCIONE LOTE!!!",
            confirmButtonText: "CERRAR"
        });
    } else {

        if (estado === "L") {
            if (liberado_por === "") {
                swal.fire({
                    type: 'error',
                    title: "ERROR, COMPLETE DATOS REQUERIDOS!!!",
                    timer: 2000,
                    showConfirmButton: false
                }
                );
            } else {
                Swal.fire({
                    title: 'CONFIRMACION',
                    text: "DESEA LIBERAR LOS CARROS SELECCIONADOS?",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'SI, LIBERAR!',
                    cancelButtonText: 'NO, CANCELAR!'
                }).then((result) => {
                    if (result.value) {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            willOpen: () => {
                                Swal.showLoading()
                            }

                        });
                        insertar_registro(valor_grilla, liberado_por, estado);
                    }
                });
            }
        } else if (estado == "R" || estado == "Z") {

            var motivo_retencion = $('#motivo_retencion option:selected').toArray().map(item => item.text).join();
            if (disposicion == "-" || motivo_retencion.length == 0 || estado_liberacion == "-") {
                swal.fire({
                    title: "ERROR, COMPLETE DATOS REQUERIDOS!!!",
                    text: "",
                    timer: 2000,
                    showConfirmButton: false
                });
            } else {
                Swal.fire({
                    title: 'CONFIRMACION',
                    text: "DESEA RETENER LOS CARROS SELECCIONADOS?" + disposicion,
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'SI, RETENER!',
                    cancelButtonText: 'NO, CANCELAR!'
                }).then((result) => {
                    if (result.value) {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            willOpen: () => {
                                Swal.showLoading()
                            }

                        });
                        insertar_registro_retenido(valor_grilla, disposicion, motivo_retencion, estado, estado_liberacion);
                    }
                });

            }
        }
    }
}

function insertar_registro_retenido(id_carro, disposicion, motivo_retencion, estado_requerido, estado_liberacion) {
    $.get(ruta_cruds_ptc + 'control_movimientos.jsp', {id_carro: id_carro, disposicion: disposicion,
        estado_requerido: estado_requerido, motivo_retencion: motivo_retencion, estado_liberacion: estado_liberacion},
            function (res) {
                resultado_aviso_movimiento_retenido(res.tipo_mensaje, res.mensaje);
            });
}

function insertar_registro(id_carro, responsable, estado_requerido) {
    $.get(ruta_cruds_ptc + 'control_movimientos.jsp', {id_carro: id_carro, responsable: responsable, estado_requerido: estado_requerido},
            function (res) {
                resultado_aviso_movimiento_retenido(res.tipo_mensaje, res.mensaje);
            });
}

function agregar_motivo_retencion() {
    //alert(motivo_retencion);
    $.ajax({
        type: "POST",
        url: ruta_cruds_ptc + 'control_agregar_motivo_retencion.jsp',
        data: $("#form_motivo_retencion").serialize(),
        beforeSend: function () {
            $('#div_cargar').show();
            $('#btn_motivo').hide()
        },
        success: function (res)
        {
            var id = $('#cod_interno').val();

            $('#' + id).remove();
            $('.modal').click();

            $('#div_cargar').hide();

            resultado_motivo_retencion(res.tipo_respuesta, res.mensaje);
            $('#btn_cancelar').show();

        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function reemplazar_motivo_retencion() {
    //alert(motivo_retencion);
    $.ajax({
        type: "POST",
        url: ruta_cruds_ptc + 'control_reemplazar_motivo_retencion.jsp',
        data: $("#form_motivo_retencion").serialize(),
        beforeSend: function () {
            $('#div_cargar').show();
            $('#btn_motivo').hide()
        },
        success: function (res)
        {

            $('#div_cargar').hide();
            $('.modal').click();
            resultado_motivos_panel(res.tipo_respuesta, res.mensaje);
            $('#btn_cancelar').show();

        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function reemplazar_estado_producto() {

    $.ajax({
        type: "POST",
        url: ruta_cruds_ptc + 'control_reemplazar_estado_producto.jsp',
        data: $("#form_estado_producto").serialize(),
        beforeSend: function () {
            $('#div_cargar_estado').show();
            $('#btn_producto').hide();
        },
        success: function (res)
        {

            $('.modal').click();
            $('#div_cargar_estado').hide();

            resultado_motivos_panel(res.tipo_respuesta, res.mensaje);
            $('#btn_cancelar').show();

        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function reemplazar_disposicion() {

    $.ajax({
        type: "POST",
        url: ruta_cruds_ptc + 'control_reemplazar_disposicion.jsp',
        data: $("#form_disposicion").serialize(),
        beforeSend: function () {
            $('#div_cargar_disposicion').show();
            $('#btn_disposicion').hide();
        },
        success: function (res)
        {

            $('.modal').click();
            $('#div_cargar_disposicion').hide();

            resultado_motivos_panel(res.tipo_respuesta, res.mensaje);
            $('#btn_cancelar_disposicion').show();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function agregar_estado_producto() {
    //alert(motivo_retencion);
    $.ajax({
        type: "POST",
        url: ruta_cruds_ptc + 'control_agregar_estado_producto.jsp',
        data: $("#form_estado_producto").serialize(),
        beforeSend: function () {
            $('#div_cargar_estado').show();
            $('#btn_producto').hide();
        },
        success: function (res)
        {
            var id = $('#cod_interno_estado').val();

            $('#' + id).remove();
            $('.modal').click();
            $('#div_cargar_estado').hide();

            resultado_motivo_retencion(res.tipo_respuesta, res.mensaje);
            $('#btn_cancelar').show();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}


function resultado_liberados(tipo, mensaje) {
    if (tipo == "1") {
        swal.fire({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        //  traer_pendiente_liberacion();  
    } else {
        swal.fire({
            type: 'error',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
    }
}

function resultado_motivos_panel(tipo, mensaje) {
    if (tipo == 1) {

        swal.fire({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        ir_grilla_retenidos_panel();

    } else {
        swal.fire({
            type: 'error',
            html: mensaje,
            confirmButtonText: "CERRAR"
        });
    }
}

function resultado_motivo_retencion(tipo, mensaje) {
    if (tipo == 1) {

        swal.fire({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        // ir_agregar_motivo_retencion();  

    } else {
        swal.fire({
            type: 'error',
            html: mensaje,
            confirmButtonText: "CERRAR"
        });
    }
}

function resultado_aviso_movimiento_retenido(tipo, mensaje) {
    if (tipo == "1") {
        swal.fire({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        $("#contenedor_principal").html("");
    } else {
        swal.fire({
            type: 'error',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
    }
}

function resultado_aviso_registro(tipo_respuesta, mensaje, tipo_registro, cajones_cargados)
{

    if (tipo_respuesta == 1)
    {
        swal.fire({
            type: 'success',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
        if (tipo_registro == "LIBERADO")
        {
            traer_registro_lib();
        } else if (tipo_registro == "RETENIDO")
        {
            traer_registro_retenido();
        } else if (tipo_registro == "SC")
        {
            traer_registro_SC()();
        } else
        {
            ir_panel();
        }
    } else if (tipo_respuesta == 0)
    {
        swal.fire({
            type: 'error',
            title: mensaje,
            confirmButtonText: "CERRAR"
        });
    } else if (tipo_respuesta == 2)
    {
        swal.fire({
            type: 'error',
            html: mensaje + cajones_cargados,
            confirmButtonText: "CERRAR"
        });
    } else
    {
        swal.fire({
            type: 'error',
            html: mensaje,
            confirmButtonText: "CERRAR"
        });
    }

}

function procesar_PTC(tipo_registro) {

    var cod_carrito = $('#cod_carrito').val();
    var fecha_clasificacion = $('#calendario_registro').val();
    var fecha_puesta = $('#fecha_puesta').val();
    var fecha_clasificacion_final = $('#fecha_clas_final').val();
    var subs_cod_carrito = cod_carrito.substr(-20, 2);

    if (tipo_registro === "control_registro" || tipo_registro === "control_registro_costeado")
    {
        if (fecha_clasificacion.length == 0 || fecha_puesta.length == 0 || fecha_clasificacion_final.length == 0)
        {
            mensaje_error();
        } else if (cod_carrito.length != 6)
        {
            swal.fire({
                type: 'error',
                title: "ERROR DE NUMERO DE CARRO, VERIFIQUE... ",
                confirmButtonText: "CERRAR"
            });
        } else
        {
            if (subs_cod_carrito == "60" || subs_cod_carrito == "90")
            {
                Swal.fire({
                    title: 'CONFIRMACION',
                    text: "DESEA REGISTRAR LOS DATOS?",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'SI, REGISTRAR!',
                    cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
                {
                    if (result.value)
                    {
                        Swal.fire
                                ({
                                    title: 'PROCESANDO!',
                                    html: "<strong>ESPERE</strong>...",
                                    showCancelButton: false,
                                    showConfirmButton: false,
                                    allowOutsideClick: false,
                                    willOpen: () => {
                                        Swal.showLoading()
                                    }

                                });
                        enviar_datos_lotes_ptc(tipo_registro);
                    }
                });
            } else
            {
                swal.fire({
                    type: 'error',
                    title: "ERROR, NUMERO DE CARRO INCORRECTO!!!",
                    confirmButtonText: "CERRAR"
                });
            }
        }
    } else if (tipo_registro === "control_retenidos" || tipo_registro === "control_retenidos_costeados") {


        if (fecha_clasificacion.length == 0 || fecha_puesta.length == 0 || fecha_clasificacion_final.length == 0)
        {
            mensaje_error();
        } else if (cod_carrito.length != 6)
        {
            swal.fire({
                type: 'error',
                title: "ERROR DE NUMERO DE CARRO, VERIFIQUE... ",
                confirmButtonText: "CERRAR"
            });
        } else
        {
            if (subs_cod_carrito == "60" || subs_cod_carrito == "90")
            {
                Swal.fire({
                    title: 'CONFIRMACION',
                    text: "DESEA REGISTRAR LOS DATOS?",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'SI, REGISTRAR!',
                    cancelButtonText: 'NO, CANCELAR!'
                }).then((result) =>
                {
                    if (result.value)
                    {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            willOpen: () => {
                                Swal.showLoading()
                            }

                        });
                        enviar_datos_lotes_ptc(tipo_registro);
                    }
                });
            } else
            {
                swal.fire({
                    type: 'error',
                    title: "ERROR, NUMERO DE CARRO INCORRECTO!!!",
                    confirmButtonText: "CERRAR"
                });
            }
        }


    }
}





function procesar_sc()
{

    var cod_carrito = $('#cod_carrito').val();
    var fecha_clasificacion = $('#calendario_registro').val();
    var fecha_puesta = $('#fecha_puesta').val();
    var fecha_clasificacion_final = $('#fecha_clas_final').val();
    var subs_cod_carrito = cod_carrito.substr(-20, 2);


    if (fecha_clasificacion.length == 0 || fecha_puesta.length == 0 || fecha_clasificacion_final.length == 0)
    {
        mensaje_error();
    } else if (cod_carrito.length != 6)
    {
        swal.fire({
            type: 'error',
            title: "ERROR DE NUMERO DE CARRO, VERIFIQUE... ",
            confirmButtonText: "CERRAR"
        });
    } else
    {
        if (subs_cod_carrito == "60" || subs_cod_carrito == "90" || subs_cod_carrito == "70")
        {
            Swal.fire({
                title: 'CONFIRMACION',
                text: "DESEA REGISTRAR LOS DATOS?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'SI, REGISTRAR!',
                cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
            {
                if (result.value)
                {
                    Swal.fire
                            ({
                                title: 'PROCESANDO!',
                                html: "<strong>ESPERE</strong>...",
                                showCancelButton: false,
                                showConfirmButton: false,
                                allowOutsideClick: false,
                                willOpen: () => {
                                    Swal.showLoading()
                                }

                            });
                    var url = ruta_cruds_ptc + "control_registro_sc.jsp";
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: $("#formulario").serialize(),
                        success: function (data)
                        {
                            resultado_aviso_registro(data.tipo_respuesta, data.mensaje, 'SC', data.cajones_cargados);
                        },
                        error: function (error) {
                            swal.fire({
                                type: 'error',
                                title: "HUBO UN ERROR CON LA COMUNICACION AL SERVIDOR, FAVOR VUELVA A INTENTAR",
                                confirmButtonText: "CERRAR"
                            });
                        }
                    });
                }
            });
        } else
        {
            swal.fire({
                type: 'error',
                title: "ERROR, NUMERO DE CARRO INCORRECTO!!!",
                confirmButtonText: "CERRAR"
            });
        }
    }


}


function calculo() {

    var valor_combo, valor_cantidad, resultado;
    valor_combo = document.getElementById('unidad_medida').value;
    valor_cantidad = document.getElementById('txt_cantidad').value;
    resultado = valor_combo * valor_cantidad;
    document.getElementById('txt_resultado_multiplicacion').value = resultado;
}

function limpiar_cantidad() {
    var cantidad1, cantidad2;
    medida = $("#unidad_medida");

    if (medida.val() === "180" || medida.val() === "360") {
        cantidad2 = document.getElementById("txt_cantidad").value = "";
    } else {
        cantidad1 = document.getElementById("txt_cantidad").value = "1";
    }
}

function contar() {
    var input = document.getElementById('cod_carrito');
    input.addEventListener('input', function () {
        if (this.value.length > 9)
            this.value = this.value.slice(0, 9);
    });
}

function soloNumeros(e)
{
    var key = window.Event ? e.which : e.keyCode
    return ((key >= 48 && key <= 57) || (key == 8))
}

function limpiar_cantidad_retenido() {
    var cantidad1, cantidad2;
    medida = $("#unidad_medida_retenido");

    if (medida.val() === "180" || medida.val() === "360") {
        cantidad2 = $("#txt_cantidad").val("");
    } else {
        cantidad1 = $("#txt_cantidad").val("1");
    }
}

function visualizar_codigo_borroso_retenido() {

    if ($("#categoria_registro_recogida").val() === "LDO") {

        $('#div_codigo_borroso_registro_recogida').show();

    } else {
        $('#div_codigo_borroso_registro_recogida').hide();

    }
}

function setear_si() {
    var arr = $('[name="codigo_borroso_registro_retenido"]:checked').map(function () {
        return this.value;
    }).get();
    $('#txt_codigo_borroso_registro_retenido').val(arr);


    if ($("#categoria_registro_recogida").val() !== "LDO") {
        $("#codigo_borroso_registro_retenido").prop('checked', false);
        $('#txt_codigo_borroso_registro_retenido').val('');
    } else {


    }
}

function visualizar_zona_liberado() {


    var tipo_huevo = $("#tipo_huevo");

    if (tipo_huevo.val() === "SC") {

        // $('#div_zona_liberado').show();
        $('#div_reproceso_liberado').hide();
        $('#div_sub_liberado').hide();
        $('#div_grupo_aviario_almacenamiento').hide();
        $('#div_empacadora').hide();

        $('#div_responsable_liberado').hide();
        $('#div_estado_liberado_registro').hide();
        $("#cbox_zona_liberado").prop('required', true);
        $("#cbox_reproceso").prop('required', false);
        $("#cbox_zona_liberado").prop('required', false);

        $("#txt_liberado").prop('required', false);
        $("#tipo_aviario").prop('required', false);
        $("#tipo_almacenamiento").prop('required', false);
        $("#txt_liberado").val('');
        $("#nro_empacadora").prop('required', false);
        limpiar_codigo_rotos();
    }

    if (tipo_huevo.val() === "9") {

        // $('#div_zona_liberado').show();
        $('#div_reproceso_liberado').hide();
        $('#div_sub_liberado').hide();
        $('#div_grupo_aviario_almacenamiento').hide();
        $('#div_empacadora').hide();

        $('#div_responsable_liberado').hide();
        $('#div_estado_liberado_registro').hide();
        $("#cbox_zona_liberado").prop('required', true);
        $("#cbox_reproceso").prop('required', false);
        $("#cbox_zona_liberado").prop('required', false);

        $("#txt_liberado").prop('required', false);
        $("#tipo_aviario").prop('required', false);
        $("#tipo_almacenamiento").prop('required', false);
        $("#txt_liberado").val('');
        $("#nro_empacadora").prop('required', false);
        setear_cbox_almacenamiento();
        setear_cbox_tipo_aviario();
        setear_codigo_rotos();

    }

    if (tipo_huevo.val() === "RP") {

        //  $('#div_zona_liberado').hide();
        $('#div_reproceso_liberado').show();
        $('#div_sub_liberado').hide();
        $('#div_empacadora').hide();
        $('#div_grupo_aviario_almacenamiento').hide();
        $('#div_estado_liberado_registro').hide();
        $('#txt_liberado').hide();

        $("#cbox_reproceso").prop('required', true);
        $("#nro_empacadora").prop('required', false);
        $("#tipo_aviario").prop('required', false);
        $("#tipo_almacenamiento").prop('required', false);
        $("#cbox_sub").prop('required', false);
        $("#cbox_zona_liberado").prop('required', false);
        $("#txt_liberado").prop('required', false);
        $("#txt_liberado").val('');
        setear_cbox_almacenamiento();
        setear_cbox_tipo_aviario();
        limpiar_codigo_rotos();
    }


    if (tipo_huevo.val() === "8") {

        //  $('#div_zona_liberado').hide();
        $('#div_reproceso_liberado').hide();
        $('#div_sub_liberado').show();
        $('#div_empacadora').hide();
        $('#div_estado_liberado_registro').hide();
        $('#txt_liberado').hide();
        $('#div_grupo_aviario_almacenamiento').hide();
        $("#cbox_sub").prop('required', true);
        $("#cbox_zona_liberado").prop('required', false);
        $("#cbox_reproceso").prop('required', false);


        $("#txt_liberado").prop('required', false);
        $("#tipo_aviario").prop('required', false);
        $("#tipo_almacenamiento").prop('required', false);
        $("#txt_liberado").val('');
        $("#nro_empacadora").prop('required', false);

        setear_cbox_almacenamiento();
        setear_cbox_tipo_aviario();
        limpiar_codigo_rotos();
    }

    if (tipo_huevo.val() === "1" || tipo_huevo.val() === "2" || tipo_huevo.val() === "3" || tipo_huevo.val() === "4"
            || tipo_huevo.val() === "5" || tipo_huevo.val() === "6" || tipo_huevo.val() === "7") {

        // $('#div_zona_liberado').hide();
        $('#div_reproceso_liberado').hide();
        $('#div_sub_liberado').hide();
        $('#div_empacadora').show();
        $('#div_responsable_liberado').show();

        setear_detalle_almacenamiento();
        setear_detalle_tipo_aviario();

        $('#div_estado_liberado_registro').show();
        $('#div_grupo_aviario_almacenamiento').show();
        $('#txt_liberado').show();
        $("#cbox_reproceso").prop('required', false);
        $("#cbox_zona_liberado").prop('required', false);
        $("#cbox_sub").prop('required', false);
        $("#txt_liberado").prop('required', true);
        $("#tipo_aviario").prop('required', true);
        $("#tipo_almacenamiento").prop('required', true);
        $("#nro_empacadora").prop('required', true);
        limpiar_codigo_rotos();
    }
}

function setear_cbox_almacenamiento() {
    var descripcion = "-";
    var valor = "-";
    $('#tipo_almacenamiento').children().remove();
    $('#tipo_almacenamiento').append('<option value="' + valor + '">' + descripcion + '</option>');

}

function setear_cbox_tipo_aviario() {
    var descripcion = "-";
    var valor = "-";
    $('#tipo_aviario').children().remove();
    $('#tipo_aviario').append('<option value="' + valor + '">' + descripcion + '</option>');

}

function setear_detalle_tipo_aviario() {
    var descripcion1;
    var descripcion = new Array();
    var valor = new Array();

    descripcion1 = "Tipo Aviario";
    descripcion[0] = "M";
    valor[0] = "M";
    descripcion[1] = "T";
    valor[1] = "T";

    $('#tipo_aviario').children().remove();
    //  $('#tipo_aviario').append('<option selected disabled>' +   descripcion1+ '</option>');
    for (var i = 0; i < descripcion.length; i++) {
        $('#tipo_aviario').append('<option value="' + valor[i] + '">' + descripcion[i] + '</option>');
    }
}

function setear_detalle_almacenamiento() {
    var descripcion1, valor1;
    var descripcion = new Array();
    var valor = new Array();

    descripcion1 = "Tipo almacenamiento";
    descripcion[0] = "C";
    valor[0] = "C";
    descripcion[1] = "P";
    valor[1] = "P";
    descripcion[2] = "M";
    valor[2] = "M";
    $('#tipo_almacenamiento').children().remove();
    $('#tipo_almacenamiento').append('<option selected disabled>' + descripcion1 + '</option>');
    for (var i = 0; i < descripcion.length; i++) {
        $('#tipo_almacenamiento').append('<option value="' + valor[i] + '">' + descripcion[i] + '</option>');
    }

}

function setear_codigo_rotos()
{
    var mesa;
    mesa = $('#id_date').val() + "_" + $('#id_clasificadora').val();
    $('#cod_carrito').val(mesa);
}
/*
function limpiar_codigo_rotos() {

    $('#cod_carrito').val('');

}*/



function Eliminar_fila_carro_mesa() {
    var codi;
    codi = $('#codigo_carro').val();
    $('#' + codi + '').remove();

    $('#boton_reg').attr("data-dismiss", "modal");
    enviar_datos_carromesa();
    $('#codigo_mesa').val('');


}

function Eliminar_fila_grilla_eliminar(cod_lote) {
    $('#' + cod_lote + '').remove();
}


function eliminar_lotes_ptc(cod_carrito, cod_lote, cod_interno) {

    Swal.fire({
        title: '¿Seguro que deseas ELIMINAR el registro?',
        text: 'Eliminar carro Nº ' + cod_carrito,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, ELIMINAR!',
        cancelButtonText: 'NO, CANCELAR!'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO!',
                html: "<strong>ESPERE</strong>...",
                showCancelButton: false,
                showConfirmButton: false,
                allowOutsideClick: false,
                willOpen: () => {
                    Swal.showLoading()
                }

            });
            traer_control_eliminar(cod_interno, cod_lote);

        }
    });
}

function validacion_eliminacion_ptc(clasificadora, cod_interno, cantidad, itemcode, fecha, cod_carrito, cod_lote, tipo) {

    if (tipo == "C") {

        Swal.fire({
            title: '¿Seguro que deseas ELIMINAR el registro?',
            text: 'Eliminar carro Nº ' + cod_carrito,
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI, ELIMINAR!',
            cancelButtonText: 'NO, CANCELAR!'
        }).then((result) => {
            if (result.value) {
                Swal.fire({
                    title: 'PROCESANDO!',
                    html: "<strong>ESPERE</strong>...",
                    showCancelButton: false,
                    showConfirmButton: false,
                    allowOutsideClick: false,
                    willOpen: () => {
                        Swal.showLoading()
                    }

                });
                $.ajax({
                    type: "POST",
                    url: "http://192.168.6.162/ws/salida_inventario.aspx",
                    data: ({clasificadora: clasificadora, cod_interno: cod_interno, cantidad: cantidad, itemcode: itemcode, fecha: fecha}),
                    beforeSend: function () {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: '<strong>ESPERE</strong>...',
                            allowOutsideClick: false,
                            willOpen: () => {
                                Swal.showLoading()
                            }

                        });
                    },
                    success: function (data) {

                        if (data.band == "0") {
                            swal.fire({
                                type: 'error',
                                html: data.mensaje,
                                confirmButtonText: "CERRAR"
                            });

                        } else {
                            Eliminar_fila_grilla_eliminar(cod_lote);
                            swal.fire({
                                type: 'error',
                                title: "ELIMINADO CON EXITO",
                                confirmButtonText: "CERRAR"
                            });
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
    } else {
        eliminar_lotes_ptc(cod_carrito, cod_lote, cod_interno);
    }
}



function procesar_carro_alimentado() {

    var cod_carrito = $('#cod_carrito').val();
    var fecha_clasificacion = $('#calendario_registro').val();
    var fecha_puesta = $('#fecha_puesta').val();
    var fecha_clasificacion_final = $('#fecha_clas_final').val();
    var subs_cod_carrito = cod_carrito.substr(-20, 2);

    if (fecha_clasificacion.length == 0 || fecha_puesta.length == 0 || fecha_clasificacion_final.length == 0)
    {
        mensaje_error();
    } else if (cod_carrito.length != 6)
    {
        swal.fire({
            type: 'error',
            title: "ERROR DE NUMERO DE CARRO, VERIFIQUE... ",
            confirmButtonText: "CERRAR"
        });
    } else
    {
        if (subs_cod_carrito == "60" || subs_cod_carrito == "90")
        {
            if ($('#codigo_reposicion').val() == 'SI')
            {
                if ($('#txt_lotes_reposicionados').val() == "")
                {

                    swal.fire({
                        type: 'error',
                        title: "ERROR DEBE INGRESAR HUEVOS DE RECOGIDAS ",
                        confirmButtonText: "CERRAR"
                    });
                } else
                {
                    confirmar_registro_ptc_alimentacion("control_registro_alimentacion_ptc");

                }

            } else
            {
                confirmar_registro_ptc_alimentacion("control_registro_alimentacion_ptc");
            }

        } else
        {
            swal.fire({
                type: 'error',
                title: "ERROR, NUMERO DE CARRO INCORRECTO!!!",
                confirmButtonText: "CERRAR"
            });
        }
    }
}


function confirmar_registro_ptc_alimentacion(pagina) {
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA REGISTRAR LOS DATOS?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!'}).then((result) =>
    {
        if (result.value)
        {
            Swal.fire
                    ({
                        title: 'PROCESANDO!',
                        html: "<strong>ESPERE</strong>...",
                        showCancelButton: false,
                        showConfirmButton: false,
                        allowOutsideClick: false,
                        willOpen: () => {
                            Swal.showLoading()
                        }

                    });
            $.ajax({
                type: "POST",
                url: ruta_cruds_ptc + pagina + ".jsp",
                data: $("#formulario").serialize(),
                success: function (data)
                {
                    aviso_registro_general(data.tipo_respuesta, data.mensaje, "ptc_alimentacion")
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