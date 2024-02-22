/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
/* global rutaContenedoresComedorVimar, swal, Swal, rutaCrudsComedorVimar, rutaConsultasComedorVimar */

//**************************************REGISTRO MENU DIARIO*****************************************//

//CONTENEDOR MENU DIARIO 
function traer_registro_semana() {
    $.ajax({
        type: 'POST',
        url: rutaContenedoresComedorVimar + 'contenedor_registro_menu_diario.jsp',
        beforeSend: function (xhr) {
            cargar_load('Cargando...');
            $('#contenedor_principal').html('');
        },
        success: function (data) {
            $('#contenedor_principal').html(data);
            $('#tb_registro_semanal').DataTable();
            cargar_estilo_calendario_global("dd/mm/yyyy");
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//INSERTA FILAS A LA TABLA 
function cargar_datos() {
    var table = $('#tb_registro_semanal').DataTable();
    var fecha = $("#fechaRegistro").val();
    var menu = $("#menuDiario").val();
    var array = menu.split("-");
    var menu_uno = array[0];
    var menu_dos = array[1];
    var fechaExists = table.column(0).data().toArray().includes(fecha);
    if (menu == '-') {

        Swal.fire({
            icon: 'error',
            title: "ERROR, SELECCIONAR MENÚ",
            confirmButtonText: "CERRAR"
        });
    } else if (fecha == "") {

        Swal.fire({
            icon: 'error',
            title: "ERROR, DEBES SELECCIONAR LA FECHA",
            confirmButtonText: "CERRAR"
        });
    } else if (fechaExists) {
        aviso_generico(0, "ERROR, LA FECHA YA HA SIDO SELECCIONADA");
    } else {
        var newFila = [fecha, menu_uno, menu_dos, "<input type=\"button\" value=\"ELIMINAR\" name=\"remove\" class='btn btn-danger eliminar-fila-menu' onclick=\"eliminar_fila_menu('" + menu_uno + "')\">"
        ];
        var rowNode = table.row.add(newFila).order([0, 'desc']).draw(false).node();
        $(rowNode).attr('id', $.trim('row' + menu_uno)); // Elimina espacios adicionales // AGREGA ID AL <tr> FILA.

        $('#fechaRegistro').val("");
        $('#menuDiario').prop('selectedIndex', 0);
    }
}

//ELIMINA FILAS CREADAS
function eliminar_fila_menu(id_tr)
{
    var table = $('#tb_registro_semanal').DataTable(); //OBTENGO EL ID DE MI TABLA.
    table.row($('#row' + id_tr)).remove().draw();
}

//VERIFICA SI HAY LA GRILLA ESTA VACIA 
function verificarGrillaVaciaMenu() {
// Aquí puedes realizar la validación de la grilla    

// Por ejemplo, si estás utilizando DataTables, puedes verificar el número de filas
    var numRows = $('#tb_registro_semanal').DataTable().rows().count();
    return numRows === 0;
}

//ALERT PARA CONFIRMAR EL REGISTRO
function confirmar_registro_menu() {
    if (verificarGrillaVaciaMenu()) {
        aviso_generico(0, "INGRESE DATOS AL MENÚ SEMANAL");
    } else {
        Swal.fire({
            title: 'REGISTRO DEL MENU DIARIO',
            text: "DESEA REGISTRAR LOS DATOS INGRESADOS?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'
        }).then((result) => {
            if (result.value) {
                Swal.fire({
                    title: 'PROCESANDO!',
                    html: 'ESPERE<strong></strong>...',
                    allowOutsideClick: false,
                    onBeforeOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong')
                                    .textContent = Swal.getTimerLeft()
                        }, 1000)
                    }
                });
                obtener_dato_fila();
            }
        });
    }
}

//FUNCION QUE OBTIENE LOS DATOS DE LA TABLA 
function obtener_dato_fila() {

// obtenemos todas las filas del tbody

    var filas = document.querySelectorAll("#tb_registro_semanal tbody tr");
    var fecha_grilla;
    var codigo_menu;
    var c = 0;
    var valores = '';
    // recorremos cada una de las filas

    filas.forEach(function (e) {

        // obtenemos las columnas de cada fila
        var columnas = e.querySelectorAll("td");
        // obtenemos los valores de la cantidad y importe
        fecha_grilla = columnas[0].textContent;
        codigo_menu = columnas[1].textContent;
        var arr = fecha_grilla + '-' + codigo_menu;
        if (c == 0) {
            valores = arr;
        } else {
            valores = valores + ',' + arr;
        }
        c++;
    });
    insert_menu_semanal(valores);
}

//FUNCION QUE SE SE COMUNICA CON LA BD, ENVIA Y RECIBE LAS RESPUESTAS 
function insert_menu_semanal(contenedor) {


    $.ajax({
        type: "POST",
        url: rutaCrudsComedorVimar + "crud_registrar_menu_semanal.jsp",
        data: ({contenedor: contenedor}),
        beforeSend: function () {
            Swal.fire({
                title: 'PROCESANDO!',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong').textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
        },
        success: function (res) {
            if (res.tipo == "1") {
                swal.fire({
                    icon: 'success',
                    title: res.msg,
                    confirmButtonText: "CERRAR"
                });
                traer_registro_semana();
            } else {
                swal.fire({
                    icon: 'error',
                    html: res.msg,
                    confirmButtonText: "CERRAR"
                });
            }
        }
    });
}

//*********************************** AGREGAR MENÚ ******************************************************//

//CONTENEDOR AGREGAR MENU

function traer_agregar_menu() {
    $.ajax({
        type: 'POST',
        url: rutaContenedoresComedorVimar + 'contenedor_agregar_menu.jsp',
        beforeSend: function (xhr) {
            cargar_load('Cargando...');
            $('#contenedor_principal').html('');
        },
        success: function (res) {
            $('#contenedor_principal').html(res);
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//REGISTRAR NUEVO MENU
function validar_menu() {
    var contenido = $('#txt_menu').val();
    if (contenido == '') {
        Swal.fire({
            icon: 'error',
            title: 'DEBE INGRESAR DATOS',
            confirmButtomText: 'CERRAR'
        });
    } else {
        Swal.fire({
        title: 'REGISTRO DEL MENÚ',
        text: '¿DESEA REGISTRAR NUEVO MENÚ ' + contenido + '?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SÍ, REGISTRAR!',
        cancelButtonText: 'NO, CANCELAR!'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
            $.get(rutaCrudsComedorVimar + 'crud_agregar_menu.jsp', {txt_menu: contenido},
                        function (res) {

                            aviso_generico(res.tipo, res.msg);

                            traer_agregar_menu();
                        });
        }
    });
    }
}

//*********************************** DETALLE MENÚ ******************************************************//

//CONTENEDOR INFORME MENU 
function traer_informeMenuVimar() {
    $.ajax({
        type: 'POST',
        url: rutaContenedoresComedorVimar + "contenedor_informe_menu_vimar.jsp",
        beforeSend: function (xhr) {
            $("#contenedor_principal").html("");
            cargar_load("Cargando...");
        },
        success: function (res) {
            $("#contenedor_principal").html(res);
            cargar_estilo_calendario_global("dd/mm/yyyy");
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }

    });
}

//GENERA LA TABLA INFORME SEMANAL 
function informe_menu_semanal() {
    var fechaDesde = $("#fecha_desde").val();
    var fechaHasta = $("#fecha_hasta").val();
    $.ajax({
        type: "post",
        url: rutaConsultasComedorVimar + "consulta_gen_grilla_detalle_menu.jsp",
        data: {fechaDesde: fechaDesde, fechaHasta: fechaHasta},
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data) {
            $("#div_tb_informe_menu").html(data.grilla);
            $("#tb_informe_menu").DataTable({
                scrollY: "500px",
                pageLength: 100,
                "language":
                        {
                            sSearch: "Buscar:",
                            sLengthMenu: "Mostrar _MENU_ registros",
                            sZeroRecords: "No se encontraron resultados",
                            sEmptyTable: "Ningún dato disponible en esta tabla",
                            sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                            sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
                            sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                            sInfoThousands: ",",
                            sLoadingRecords: "Cargando...",
                            oPaginate: {sFirst: "Primero", sLast: "Último", sNext: "Siguiente", sPrevious: "Anterior"},
                            buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}}
                        },
                keys: {clipboard: !1}


            });
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//TOMA LOS DATOS DE LA FILA SELECCIONADA 
function confirmar_delete(id, menu, dia) {
    Swal.fire({
        title: 'ELIMINAR',
        text: `¿DESEA ELIMINAR EL MENÚ ${menu} DEL DÍA ${dia}?`,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SÍ, ELIMINAR',
        cancelButtonText: 'NO, CANCELAR'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
            Eliminar_fila(id);
        }
    });
}




//ELIMINA LA FILA DEL DATATABLE 
function Eliminar_fila(codi) {


    $('#' + codi + '').remove().draw;
    control_eliminar(codi);
}

//ELIMINA DE LA BASE DE DATOS EL MENU SELECCIONADO
function control_eliminar(id) {

    $.get(rutaCrudsComedorVimar + 'control_eliminar_menu.jsp', {id: id},
            function (res) {
                aviso_generico(res.tipo, res.msg);
            });
}


//*********************************** INFOME ANOTADOS ******************************************************//

//CONTENEDOR INFORME ANOTADOS
function irInformeAnotadosVimar() {
    $.ajax({
        type: "post",
        url: rutaContenedoresComedorVimar + "contenedor_informe_anotados.jsp",
        beforeSend: function (xhr) {
            $("#contenedor_principal").html("");
            cargar_load("Cargando...");
        },
        success: function (res) {
            $("#contenedor_principal").html(res);
            cargar_estilo_calendario_global("dd/mm/yyyy");
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//GENERAR GRILLA INFORME ANOTADOS
function informe_menu_anotados() {
    var fechaDesde = $("#fecha_desde").val();
    var fechaHasta = $("#fecha_hasta").val();
    $.ajax({
        type: "post",
        url: rutaConsultasComedorVimar + "consulta_gen_grilla_anotados.jsp",
        data: {fechaDesde: fechaDesde, fechaHasta: fechaHasta},
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data) {
            $("#div_tb_informe_anotados").html(data.grilla);
            $("#tb_informe_anotados").DataTable({
                scrollY: "500px",
                dom: "Bfrtip",
                pageLength: 100,
                "language":
                        {
                            sSearch: "Buscar:",
                            sLengthMenu: "Mostrar _MENU_ registros",
                            sZeroRecords: "No se encontraron resultados",
                            sEmptyTable: "Ningún dato disponible en esta tabla",
                            sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                            sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
                            sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                            sInfoThousands: ",",
                            sLoadingRecords: "Cargando...",
                            oPaginate: {sFirst: "Primero", sLast: "Último", sNext: "Siguiente", sPrevious: "Anterior"},
                            buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}}
                        },
                buttons: [
                    {
                        extend: 'colvis',
                        text: 'MOSTRAR / OCULTAR',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'excelHtml5',
                        text: 'EXCEL',
                        title: 'INFORME ANOTADOS DESDE: ' + $("#fecha_desde").val() + ' HASTA: ' + $("#fecha_hasta").val(), // Establecer el nombre del archivo aquí
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        text: 'PDF',
                        title: 'INFORME ANOTADOS DESDE: ' + $("#fecha_desde").val() + ' HASTA: ' + $("#fecha_hasta").val(), // Establecer el nombre del archivo aquí
                        orientation: "landscape",
                        pageSize: "LEGAL",
                        customize: function (e) {
                            (e.styles.title = {color: "white", fontSize: "20", background: "black", alignment: "center"}),
                                    (e.styles.tableHeader = {fontSize: "6"}),
                                    (e.styles.tableBodyEven = {fontSize: "6"}),
                                    (e.styles.tableBodyOdd = {fontSize: "6"}),
                                    (e.styles.tableFooter = {fontSize: "6"}),
                                    (e.styles["td:nth-child(2)"] = {width: "100px", "max-width": "100px"});
                        },
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'print',
                        text: 'IMPRIMIR',
                        title: 'INFORME ANOTADOS DESDE: ' + $("#fecha_desde").val() + ' HASTA: ' + $("#fecha_hasta").val(), // Establecer el nombre del archivo aquí
                        exportOptions: {
                            columns: ':visible'
                        }
                    }, // Botón para IMPRIMIR
                    {
                        extend: 'copy',
                        text: 'COPIAR GRILLA',
                        exportOptions: {
                            columns: ':visible'
                        }
                    } // Botón para copiar al portapapeles
                ],
                keys: {clipboard: !1}


            });
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//*********************************** REGISTRAR USUARIO ******************************************************//

//CONTENEDOR REGISTRAR USUARIO
function irRegistroUsuarioComedor() {
    $.ajax({
        type: "post",
        url: rutaContenedoresComedorVimar + "contenedor_registro_usuario_comedor.jsp",
        beforeSend: function (xhr) {
            $("#contenedor_principal").html("");
            cargar_load("Cargando...");
        },
        success: function (res) {
            $("#contenedor_principal").html(res);
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//REGISTRAR USUARIO 
function confirmar_registro_usuario() {
    var nombre = $("#txt_nombre").val();
    var ci = $("#txt_nro").val();
    var area = $("#txt_area").val();

    // Validación de campos
    if (!nombre || !ci || !area) {
        aviso_generico(0, 'Todos los campos son obligatorios. Por favor, complete todos los campos.');
        return;
    }

    Swal.fire({
        title: 'REGISTRAR',
        text: '¿DESEA REGISTRAR A ' + nombre + ' AL ÁREA DE ' + area + '?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SÍ, REGISTRAR',
        cancelButtonText: 'NO, CANCELAR'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
            $.ajax({
                type: "post",
                url: rutaCrudsComedorVimar + "crud_agregar_nuevo_usuario.jsp",
                data: {
                    nombre: nombre,
                    ci: ci,
                    area: area
                },
                beforeSend: function (xhr) {
                    cargar_load("Cargando...");
                },
                success: function (data) {
                    aviso_generico(data.tipo, data.msg);
                    cerrar_load();
                    irRegistroUsuarioComedor();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                        console.log(textStatus);
                        console.log(errorThrown);
                        location.reload();
                    }
                }

            });
        }
    });
}

//*********************************** NUEVO CÓDIGO TARJETA ******************************************************//
//CONTENEDOR NUEVO CÓDIGO TARJETA
function irNuevoCodigoTarjeta() {
    $.ajax({
        type: "post",
        url: rutaContenedoresComedorVimar + "contenedor_generar_codigo_barra.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (res) {
            $("#contenedor_principal").html(res);
            irGrillaCodBarra();
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//GENERAR GRILLA CODIGO BARRA
function irGrillaCodBarra() {
    $.ajax({
        type: "post",
        url: rutaConsultasComedorVimar + "consulta_gen_grilla_codigo_barra.jsp",
        success: function (data) {
            $("#div_grilla_codigo_barra").html(data.grilla);
            $("#tb_gen_cod_barra").DataTable({
                scrollY: "500px",
                pageLength: 100,
                "language":
                        {
                            sSearch: "Buscar:",
                            sLengthMenu: "Mostrar _MENU_ registros",
                            sZeroRecords: "No se encontraron resultados",
                            sEmptyTable: "Ningún dato disponible en esta tabla",
                            sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                            sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
                            sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                            sInfoThousands: ",",
                            sLoadingRecords: "Cargando...",
                            oPaginate: {sFirst: "Primero", sLast: "Último", sNext: "Siguiente", sPrevious: "Anterior"},
                            buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}}
                        },
                keys: {clipboard: !1}
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//GENERAR NUEVO CODIGO DE BARRA 
function generar_cod_barra(id, nombre) {
    Swal.fire({
        title: 'REGISTRO DE NUEVO CÓDIGO DE TARJETA',
        text: '¿DESEA GENERAR NUEVO CÓDIGO PARA ' + nombre + '?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SÍ, REGISTRAR',
        cancelButtonText: 'NO, CANCELAR'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
            $.ajax({
                type: "post",
                url: rutaCrudsComedorVimar + "crud_generar_tarjeta.jsp",
                data: {id: id},
                beforeSend: function (xhr) {
                    cargar_load("Cargando...");
                },
                success: function (data) {
                    aviso_generico(data.tipo, data.msg);
                    cerrar_load();
                    irNuevoCodigoTarjeta();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                        console.log(textStatus);
                        console.log(errorThrown);
                        location.reload();
                    }
                }

            });
        }
    });
}

//*********************************** ELIMINAR MENÚ ******************************************************//
//CONTENEDOR ELIMINAR MENÚ
function irEliminarMenuComedor() {
    $.ajax({
        type: "post",
        url: rutaContenedoresComedorVimar + "contenedor_eliminar_menu.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (res) {
            $("#contenedor_principal").html(res);
            irGrillaMenuComedor();
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//GENERAR GRILLA MENÚ
function irGrillaMenuComedor() {
    $.ajax({
        type: "post",
        url: rutaConsultasComedorVimar + "consulta_gen_grilla_menu_comedor.jsp",
        success: function (data) {
            $("#div_grilla_eliminar_menu").html(data.grilla);
            $("#tb_gen_menu").DataTable({
                scrollY: "500px",
                pageLength: 100,
                "language":
                        {
                            sSearch: "Buscar:",
                            sLengthMenu: "Mostrar _MENU_ registros",
                            sZeroRecords: "No se encontraron resultados",
                            sEmptyTable: "Ningún dato disponible en esta tabla",
                            sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                            sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
                            sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                            sInfoThousands: ",",
                            sLoadingRecords: "Cargando...",
                            oPaginate: {sFirst: "Primero", sLast: "Último", sNext: "Siguiente", sPrevious: "Anterior"},
                            buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}}
                        },
                keys: {clipboard: !1}
            });
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//ELIMINAR MENÚ
function eliminar_menu(id, menu) {
    Swal.fire({
        title: 'ELIMINACIÓN DE REGISTRO',
        text: '¿DESEA ELIMINAR EL MENÚ ' + menu + '?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SÍ, ELIMINAR',
        cancelButtonText: 'NO, CANCELAR'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
            $.ajax({
                type: "post",
                url: rutaCrudsComedorVimar + "control_eliminar_menu_comedor.jsp",
                data: {id: id},
                beforeSend: function (xhr) {
                    cargar_load("Cargando...");
                },
                success: function (data) {
                    aviso_generico(data.tipo, data.msg);
                    cerrar_load();
                    irEliminarMenuComedor();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                        console.log(textStatus);
                        console.log(errorThrown);
                        location.reload();
                    }
                }

            });
        }
    });
}

//*********************************** ELIMINAR USUARIO ******************************************************//
//CONTENEDOR ELIMINAR USUARIO
function irEliminarUsuarioComedor() {
    $.ajax({
        type: "post",
        url: rutaContenedoresComedorVimar + "contenedor_eliminar_usuario.jsp",
        beforeSend: function (xhr) {
            $("#contenedor_principal").html("");
            cargar_load("Cargando...");
        },
        success: function (res) {
            $("#contenedor_principal").html(res);
            generar_grilla_usuarios();
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//GENERAR GRILLA USUARIOS 
function generar_grilla_usuarios() {
    $.ajax({
        type: "post",
        url: rutaConsultasComedorVimar + "consulta_gen_grilla_usuarios.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data) {
            $("#div_grilla_eliminar_usuario").html(data.grilla);
            $("#tb_gen_usuarios").DataTable({
                scrollY: "500px",
                pageLength: 100,
                "language":
                        {
                            sSearch: "Buscar:",
                            sLengthMenu: "Mostrar _MENU_ registros",
                            sZeroRecords: "No se encontraron resultados",
                            sEmptyTable: "Ningún dato disponible en esta tabla",
                            sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                            sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
                            sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
                            sInfoThousands: ",",
                            sLoadingRecords: "Cargando...",
                            oPaginate: {sFirst: "Primero", sLast: "Último", sNext: "Siguiente", sPrevious: "Anterior"},
                            buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}}
                        },
                keys: {clipboard: !1}
            });
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                console.log(textStatus);
                console.log(errorThrown);
                location.reload();
            }
        }
    });
}

//ELIMINAR USUARIO
function eliminar_usuario(id, nombre) {
    Swal.fire({
        title: 'ELIMINACIÓN DE USUARIO',
        text: '¿DESEA ELIMINAR EL USUARIO ' + nombre + '?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SÍ, ELIMINAR',
        cancelButtonText: 'NO, CANCELAR'
    }).then((result) => {
        if (result.value) {
            Swal.fire({
                title: 'PROCESANDO',
                html: 'ESPERE<strong></strong>...',
                allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading();
                    timerInterval = setInterval(() => {
                        Swal.getContent().querySelector('strong')
                                .textContent = Swal.getTimerLeft();
                    }, 1000);
                }
            });
            $.ajax({
                type: "post",
                url: rutaCrudsComedorVimar + "control_eliminar_usuario.jsp",
                data: {id: id},
                beforeSend: function (xhr) {
                    cargar_load("Cargando...");
                },
                success: function (data) {
                    aviso_generico(data.tipo, data.msg);
                    cerrar_load();
                    irEliminarUsuarioComedor();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                        console.log(textStatus);
                        console.log(errorThrown);
                        location.reload();
                    }
                }

            });
        }
    });
}
