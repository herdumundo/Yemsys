
/* global rutaConsultasVimar, responseJSON, fechaSeleccionada, rutaVimarContenedores, data, id, motivoModal */


function pruebasTransferencia()
{
    $.ajax({
        type: "POST",
        url: rutaVimarContenedores + "contenedor_pruebas_transferencias.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            recuperarGrilla();

            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                location.reload();
            }
        }
    });

}


/*Función para recuperar la tabla vim_motivos luego de darle click al botón Prueba en el la parte de TransferenciasVimar*/
function recuperarGrilla(){    
    $.ajax({
        type: "POST",
        url: "./consultas/vimar/test" + "consulta_gen_grilla_motivos.jsp",
        beforeSend: function(xhr){
            cargar_load("Cargando...");            
        },
        success: function(responseJSON){
            $("#tbody_motivos").html(responseJSON.grilla);
            $("#tb_registros").DataTable();
            cerrar_load();
        },
        error: function(error){
            console.log(error);
        }      
        
    });
}

/*con esto mostramos el modal luego de clickear el botón edit*******************************************/
function edit_motivo_modal(id, descripcion,id_estado,tipo) {
    $("#id_txt").val(id);//id del motivo 
    $("#motivo_modal_txt").val(descripcion); //descripcion del motivo
    $("#estado_modal_txt").val(id_estado);
    $("#tipo_modal_txt").val(tipo);



    $("#modal_motivo").modal("show"); //id del contenedor modal 
}

/*Función que inserta el nuevo motivo ingresado en el input de texto*********************************/
function registrarMotivo() {
  
    // Realiza la solicitud AJAX
    $.ajax({
        type: "POST", // Método HTTP POST
        url: "./cruds/vimar/test" + "crud_insert_fila_motivo.jsp", // Ruta de tu página JSP
        data:({
            motivo : $("#motivo_txt").val()
            }), // Datos a enviar
        //dataType: "json", // Tipo de datos esperados en la respuesta
        success: function(data) {
            // Maneja la respuesta del servidor aquí
            if (data.tipo === 0) {
                // Éxito: Puedes mostrar un mensaje o realizar alguna acción adicional
                aviso_generico2(0,data.msg);              
                pruebasTransferencia();
            } else {
                // Error: Muestra un mensaje de error
                aviso_generico2(1, "El motivo ya existe: ");
            }
        },
        error: function(error) {
            // Maneja los errores de la solicitud AJAX aquí
            aviso_generico2("Error en la solicitud AJAX: " + error.statusText);
        }
    });
}

/*función para actualizar motivo desde el modal al hacer click en aceptar*********************************/

function updateModalMotivos() {
    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: "./cruds/vimar/test" + "update_motivos_vimar.jsp", // Reemplaza con la ruta correcta a tu JSP
        data:({
            id : $("#id_txt").val(),
            motivoModal : $("#motivo_modal_txt").val()
        }),
        beforeSend: function(xhr) {
            // Puedes mostrar un indicador de carga aquí si lo deseas
        },
        success: function(response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);

            // Actualizar la página u otras acciones en función de la respuesta
            if (response.tipo === 0) {
                aviso_generico2(0,response.msg);
                // Realizar alguna acción adicional si es necesario
                $('#modal_motivo').modal('toggle');
                recuperarGrilla();                
                
            } else {
                aviso_generico2(1, "El motivo ya existe: ");
            }
        },
        error: function(error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}

/*función para eliminar motivo desde el modal al hacer click en el boton*********************************/

function deleteMotivo(id) {
    // Crear un objeto de datos con los parámetros
    var data = {
        id: id
    };

    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: "./consultas/vimar/test" + "delete_motivos_vimar.jsp", // Reemplaza con la ruta correcta a tu JSP
        data: data,
        beforeSend: function(xhr) {
            // Puedes mostrar un indicador de carga aquí si lo deseas
        },
        success: function(response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);

            // Actualizar la página u otras acciones en función de la respuesta
            if (response.tipo === 0) {
                //aviso_generico2(0,response.msg);
                eliminar_fila_motivo_vimar("ROW" + id);
                // Realizar alguna acción adicional si es necesario                
                
            } else {
                aviso_generico2("Error al enviar el motivo: " + response.msg);
            }
        },
        error: function(error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}

function eliminar_fila_motivo_vimar(id_tr) {
    var table = $('#tb_registros').DataTable();
    
    // Almacena la página actual antes de eliminar la fila
    var paginaActual = table.page();
    
    table.row($('#' + id_tr)).remove().draw();
    
    // Vuelve a la página almacenada
    table.page(paginaActual).draw('page');
}



/*function eliminarLoteTransferencia(codBarra)
{          //variables donde se cargan valores//valores seleccionados
         $.ajax({
            type: "POST",
            url: rutaConsultasVimar + "crud_delete_fila_lote_transferencia.jsp",
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


}*/
