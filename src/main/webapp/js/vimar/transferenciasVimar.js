
/* global rutaConsultasVimar, responseJSON, fechaSeleccionada, rutaVimarContenedores, Swal, rutaCrudsVimar, ruta_cruds_ppr */

function irTransferenciaProduc()
{
    $.ajax({
        type: "POST",
        url: rutaVimarContenedores + "contenedor_transferencia_vimar_produccion.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            $('#tb_transferencia').DataTable();



            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}

/*captura los eventos al oprimir enter*/
function consultaCodigoBarraKey() {
    if (event.keyCode === 13 || event.which === 13) {
        consultaCodigoBarra();
    }
}

function consultaCodigoBarra()
{
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_get_lotes.jsp",
        data: ({codBarra: $("#cod_barra_consulta").val(),
            origen: $("#origen_OWHS").find(':selected').attr('codigo')
        }),
        success: function (data)
        {
            $("#item_code").val(data.VariableJsonItemCode);
            $("#item_name").val(data.VariableJsonItemName);
            $("#lote_largo").val(data.VariableJsonLoteLargo);
            $("#lote").val(data.VariableJsonLote);
            $("#lote_corto").val(data.VariableJsonLoteCorto);
            $("#cod_barra").val(data.VariableJsonCodigoBarra);
            $("#onhand").val(data.VariableJsonOnhand);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
            }
        }
    });

}

function obtenerPersonaKey() {
    if (event.keyCode == 13 || event.which == 13) {
        obtenerPersona();
    }
}

function obtenerPersona()
{
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_get_usuarios.jsp",
        data: ({numeroCedula: $("#nro_ci_consulta").val()
        }),
        success: function (data)
        {
            $("#codigo_persona").val(data.VariableJsonId);
            $("#nro_ci_consulta").val(data.VariableJsonCi);
            $("#nombre_persona").val(data.VariableJsonNombre);
            $("#apellido_persona").val(data.VariableJsonApellido);
            $("#telefono_persona").val(data.VariableJsonTelefono);
            $("#ciudad_persona").val(data.VariableJsonCiudad);
            $("#edad_persona").val(data.VariableJsonEdad);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
            }
        }
    });

}



function actualizarDatosVimar()
{
    $.ajax({
        type: "POST", // Método de la solicitud (POST)
        url: rutaConsultasVimar + "update_usuarios_vimar.jsp", // Ruta a tu JSP de inserción
        data: ({
            cedulaUpdate: $('#nro_ci_consulta').val(),
            nombreUpdate: $('#nombre_persona').val(),
            apellidoUpdate: $('#apellido_persona').val(),
            telefonoUpdate: $('#telefono_persona').val(),
            ciudadUpdate: $('#ciudad_persona').val(),
            edadUpdate: $('#edad_persona').val()
        }),

        success: function (res) {
            aviso_generico(res.tipo, res.msg);

            $('#codigo_persona').val('');
            $('#nro_ci_consulta').val('');
            $('#nombre_persona').val('');
            $('#apellido_persona').val('');
            $('#telefono_persona').val('');
            $('#ciudad_persona').val('');
            $('#edad_persona').val('');
        }
    });

}

function registrarTransferencia() {
    if (verificarGrillaVacia()) {
        aviso_generico(0, "Ingrese datos en la grilla");
    } else {
        Swal.fire({
            title: 'FORMULA ',
            text: "DESEA REGISTRAR TRANSFERENCIA?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'SI!',
            cancelButtonText: 'NO!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    type: "POST", // Método de la solicitud (POST)
                    url: rutaCrudsVimar + "crud_registrar_transferencia.jsp", // Ruta a tu JSP de inserción                
                    beforeSend: function () {
                        Swal.fire({
                            title: 'PROCESANDO!',
                            html: 'ESPERE<strong></strong>...',
                            allowOutsideClick: false,
                            showCancelButton: false,
                            showConfirmButton: false,
                            willOpen: () => {
                                Swal.showLoading();
                            }
                        });
                    },

                    success: function (res) {
                        if (res.tipo === 0) {
                            aviso_generico2(res.tipo, res.msg);
                            irTransferenciaProduc();
                        } else {
                            // Si la API devuelve un error, muestra un aviso usando aviso_generico2()
                            aviso_generico2(res.tipo, res.msg);
                        }
                    },
                    error: function () {
                        // Manejar errores de la solicitud AJAX aquí
                        aviso_generico2(1, "Error en la solicitud a la API");
                    }
                });
            }
        });
    }
}

    



function verificarGrillaVacia() {
    // Aquí puedes realizar la validación de la grilla    
   
// Por ejemplo, si estás utilizando DataTables, puedes verificar el número de filas
    var numRows = $('#tb_transferencia').DataTable().rows().count();
    return numRows === 0;   
}




function recuperarOption()
{
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_gen_option_test.jsp",
        beforeSend: function (xhr) {
        },
        success: function (data)
        {
            //$("#contenedor_principal").html("");
            $("#selectDestino2").html(data.select);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}

function recuperarOption2()
{
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_gen_option2_test.jsp",
        beforeSend: function (xhr) {
        },
        success: function (data)
        {
            //$("#contenedor_principal").html("");
            $("#option2").html(data.select);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}

function recuperarTextoJson()
{
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_gen_input_text.jsp",
        beforeSend: function (xhr) {
        },
        success: function (data)
        {
            //$("#contenedor_principal").html("");
            $("#txt_json").val(data.select);

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}

function insertarDatos() {
    // Enviar una solicitud AJAX al servidor para insertar datos
    $.ajax({
        type: "POST", // Método de la solicitud (POST)
        url: rutaConsultasVimar + "insert_usuario_nuevo.jsp", // Ruta a tu JSP de inserción
        data: ({
// variable definida para enviar al jsp ||  ID para recuperar el valor del componente.
            numeroCedula: $("#nro_ci_consulta").val(),
            nombreUsuario: $("#nombre_persona").val(),
            apellidoUsuario: $("#apellido_persona").val(),
            telefonoUsuario: $("#telefono_persona").val(),
            ciudadUsuario: $("#ciudad_persona").val(),
            edadUsuario: $("#edad_persona").val(),
        }),
        success: function (res) {
            // Función que se ejecuta si la solicitud es exitosa

            // Mostrar un aviso utilizando la función aviso_generico
            // res.tipo es el tipo de aviso (éxito o error)
            // res.msg es el mensaje que se mostrará en el aviso
            aviso_generico(res.tipo, res.msg);

            // Limpiar los campos de entrada después de la inserción exitosa
            $("#nro_ci_consulta").val("");
            $("#nombre_persona").val("");
            $("#apellido_persona").val("");
            $("#telefono_persona").val("");
            $("#ciudad_persona").val("");
            $("#edad_persona").val("");
        },
        error: function (error) {
            // Función que se ejecuta si hay un error en la solicitud
            alert("Error al insertar datos: " + error.responseText);
        }
    });
}

function InsertarLoteTransferencia()
{          //variables donde se cargan valores//valores seleccionados
    var     origen = $("#origen_OWHS").find(':selected').attr('codigo'),
            destino = $("#destino_OWHS").find(':selected').attr('codigo'),
            cardCode = "",//$("#cliente_ocrd").find(':selected').attr('codigo'),
            cardName = "",//$("#cliente_ocrd").find(':selected').attr('cardName'),
            address = "",//$("#cliente_ocrd").find(':selected').attr('descripcion'),
            itemCode = $("#item_code").val(),
            itemName = $("#item_name").val(),
            loteLargo = $("#lote_largo").val(),
            lote = $("#lote").val(),
            loteCorto = $("#lote_corto").val(),
            codBarra = $("#cod_barra_consulta").val(),
            cantidad = $("#cantidad").val(),
            observacion = $("#observacion").val(),
            detalleObservacion = $("#detalle_observacion").val(),
            onhand = $("#onhand").val();

    var table = $('#tb_transferencia').DataTable();
    var loteExists = table.column(10).data().toArray().includes(codBarra);
    if (loteExists) {
        aviso_generico(0, "El código de barra ya existe");
    }
    else if (codBarra === "") {
        aviso_generico(0, "Ingrese el código de barras antes de insertar grilla");
    }
    else if (origen === destino) {
        aviso_generico(0,"El origen no puede ser igual al destino");
    }
    else if (itemCode === "" || itemName === "" || loteLargo === ""|| lote === ""|| loteCorto === ""|| codBarra === ""  || onhand === "" ) {
        aviso_generico(0,"Los campos deben estar completos, \n\
                        sólo las observaciones son opcionales.");        
    }
    //validar cantidad
    else if (parseInt(cantidad) > parseInt(onhand)) {
        aviso_generico(0, "La cantidad no puede ser mayor que el stock");
    } 
    else if (cantidad <= 0) {
        aviso_generico(0, "Debe ingresar un número entero positivo");
    } else {

    // Desactivar el botón
    $("#btnInsertarLoteTransferencia").prop("disabled", true);

    
        $.ajax({
            type: "POST",
            url: rutaCrudsVimar + "crud_insert_fila_lote_transferencia.jsp",
            data: ({
                // variable definida para enviar al jsp ||  recuperamos el valor de las variables ya declaradas mas arriba
                CardCode: cardCode,
                CardName: cardName,
                Address: address,
                observacion: observacion,
                ItemCode: itemCode,
                BarCode: codBarra,
                ItemName: itemName,
                Quantity: cantidad,
                origen: origen,
                destino: destino,
                lote: lote,
                observacion_detalle: detalleObservacion,
                loteLargo: loteLargo,
                loteCorto: loteCorto
            }),
            beforeSend: function (xhr) {                
                
            },
            success: function (data) {
                // Verificar el tipo en la respuesta JSON
                //si existe el lote entonces que meta a grilla, o sino, que borre el contenido y no meta a la grilla.                
                if (data.tipo === 0) {
                    // Mostrar un aviso genérico con el mensaje de error
                    aviso_generico(0, data.msg);
                } else {
                // Si el tipo no es 0, procesa la respuesta como lo haces actualmente
                    add_filas_transferencia_vimar(origen, destino, cardCode, cardName, address, itemCode, itemName, loteLargo, lote, loteCorto, codBarra, cantidad, observacion, detalleObservacion);
                }
                // Habilitar el botón nuevamente después de la solicitud (independientemente de si fue exitosa o no)                    
                    $("#btnInsertarLoteTransferencia").prop("disabled", false);
                    
             
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                    location.reload();
                }
            }
            
        });

    }
}


function add_filas_transferencia_vimar(origen, destino, cardCode, cardName, address, itemCode, itemName, loteLargo, lote, loteCorto, codBarra, cantidad, observacion, detalleObservacion)
{
    var table = $('#tb_transferencia').DataTable();

    var newData = [
        origen,
        destino,
        cardCode,
        cardName,
        address,
        itemCode,
        itemName,
        loteLargo,
        lote,
        loteCorto,
        codBarra,
        cantidad,
        observacion,
        detalleObservacion,
        "<input id=\"BTN" + codBarra +"\"type=\"button\"class=\"btn btn-warning "+codBarra +"\" onclick=\"eliminarLoteTransferencia('"+ codBarra + "')\" value=\"Deshacer\">"];

    var rowNode = table.row.add(newData).order([8, 'desc']).draw(false).node();
    $(rowNode).attr('id', 'row' + codBarra);//AGREGA ID AL <tr> FILA.

    $('#cod_barra_consulta').val('');
    $('#item_code').val('');
    $('#item_name').val('');
    $('#lote_largo').val('');
    $('#lote').val('');
    $('#lote_corto').val('');
    $('#cod_barra').val('');
    $('#onhand').val('');
    $('#cantidad').val('');
    $('#observacion').val('');
    $('#detalle_observacion').val('');
}
//-----------------------------------------------------------------------------------------------
function eliminar_fila_transf_vimar(id_tr)
{
    var table = $('#tb_transferencia').DataTable();//OBTENGO EL ID DE MI TABLA.
    table.row($('#' + id_tr)).remove().draw();
    
    
}
function eliminarLoteTransferencia(codBarra)
{          //variables donde se cargan valores//valores seleccionados
         $.ajax({
            type: "POST",
            url: rutaCrudsVimar + "crud_delete_fila_lote_transferencia.jsp",
            data: ({
                // variable definida para enviar al jsp ||  recuperamos el valor de las variables ya declaradas mas arriba
                BarCode: codBarra
            }),
            beforeSend: function (xhr) {

            },
            success: function(data) {
                    // Parsear la respuesta JSON
                    console.log(data.tipo, data.msg);

                    // Verificar si la ejecución del procedimiento fue exitosa
                    if (data.tipo === 1) {
                        // Llamar a la función de eliminación con el parámetro adecuado
                        eliminar_fila_transf_vimar("row" + codBarra);
                    }
                },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                    location.reload();
                }
            }
        });


}

function limpiarPagina(){
    $("#contenedor_principal").html("");
}

function informeTransferencia()
{
    $.ajax({
        type: "POST",
        url: rutaVimarContenedores + "contenedor_informes_transferencias.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_insert("dd/mm/yyyy");
          cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
          //      location.reload();
            }
        }
    });

}

function informeAveriados()
{
    $.ajax({
        type: "POST",
        url: rutaVimarContenedores + "contenedor_informes_averiados.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_insert("dd/mm/yyyy");
            



            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
             //   location.reload();
            }
        }
    });

}



// Definir la función generarInforme
function generarInforme() {
    // Obtener la fecha ingresada por el usuario
    var fecha = $("#fecha").val();

    // Crear un objeto de datos que contenga la fecha
    var data = {
        fecha: fecha
    };

    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_gen_grilla_transferencia.jsp",
        data: data,
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function(response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);
            // Pegar la información generada en el div "informe_transferencia"
            $("#informe_transferencia").html(response.grilla);
            $('#tb_informe_transfer').DataTable({ 
                "scrollX": true,
                paging: false,
                ordering:false,
                        responsive: true,
                 "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        },
                
            }); //le damos formato DataTable 
            cerrar_load();
        },
        error: function(error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}
/******************************************************************************/
function generarInformeAveriados() {
    // Obtener la fecha ingresada por el usuario
    var fecha = $("#fecha").val();

    // Crear un objeto de datos que contenga la fecha
    var data = {
        fecha: fecha
    };

    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: rutaConsultasVimar + "consulta_gen_grilla_averiados.jsp",
        data: data,
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function(response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);
            // Pegar la información generada en el div "informe_transferencia"
            $("#informe_transferencia_averiados").html(response.grilla);
            $('#tb_informe_averiados').DataTable({ 
                                                    scrollX: true,
                                                    "language":
                                                    {
                                                      "sUrl": "js/Spanish.txt"
                                                    }

                                                  }); //le damos formato DataTable 
            cerrar_load();
        },
        error: function(error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}

/*******************************************************************************************************/
//Funciones para enviar imagen desde un form 
//function uploadImage() {
//    var formData = new FormData($("#imageForm")[0]);
//    console.log(formData);
//
//    $.ajax({
//        type: "POST",
//        url: ruta_cruds_ppr + "upload_img_combus.jsp", // Ruta a tu script JSP
//        data: formData,
//        processData: false,
//        contentType: false,
//        success: function (response) {
//            console.log(response); // Maneja la respuesta del servidor
//            alert("Imagen subida con éxito.");
//        },
//        error: function (error) {
//            console.error(error);
//            alert("Error al subir imagen.");
//        }
//    });
//}

function uploadImageCombus() {
    // Obtener el archivo seleccionado
    var fileInput = document.getElementById('fileInput');
    var file = fileInput.files[0];

    // Validar el archivo
    if (!file.type.match('image.*')) {
        alert("El archivo debe ser una imagen.");
        return;
    }
    if (file.size > 1000000) {
        alert("El archivo no debe ser mayor de 1 MB.");
        return;
    }

    // Crear un objeto FormData y agregar el archivo
    var formData = new FormData();
    formData.append('file', file);

    // Realizar la solicitud AJAX
    $.ajax({
        type: 'POST',
        url: rutaCrudsVimar + 'upload_img_combus.jsp', // Reemplaza 'upload.jsp' con la URL de tu JSP
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            // Manejar la respuesta del servidor (si es necesario)
            console.log(response);
            alert("Imagen subida con éxito.");
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error(jqXHR.responseText); // Esto imprimirá el mensaje de error del servidor en la consola
            alert("Error al subir la imagen. Detalles: " + jqXHR.responseText);
        }

    });
}



