function irRecuentoInventarioVimar() {

    $.ajax({
        type: "POST",
        url: rutaContenedoresRecuentoInventarioVimar + "contenedor_recuento_inventario.jsp",
        beforeSend: function (xhr) {
            //    cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);

            $('#ubicacion').selectpicker({selectAllText: "Seleccionar todo",
                deselectAllText: "Deseleccionar todo", noneSelectedText: "Seleccionar ubicacion",
                noneResultsText: "No se encontraron resultados"});
            //  irGrillaRecuentoInventarioVimar();

            //   cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}


function irGrillaRecuentoInventarioVimar() {

    $.ajax({
        type: "POST",
        url: rutaConsultasRecuentoInventarioVimar + "consulta_gen_grilla_recuento_inventario.jsp",
        data: ({ubicacion: $("#ubicacion").val()}),
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            generarOptionGroupCargadosItemCode($("#ubicacion").val());
            $("#divGrupos").html(data);
            $('.table').DataTable({
                scrollX: true, "bPaginate": false,
                "bLengthChange": false, "bInfo": false,
                "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        }
            });
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}



function irGrillaRecuentoInventarioByItemCodeVimar(itemCode, uMedida) {

    $.ajax({
        type: "POST",
        url: rutaConsultasRecuentoInventarioVimar + "consulta_gen_grilla_recuento_inventario_byItemCode.jsp",
        data: ({ubicacion: $("#ubicacion").val(), itemCode: itemCode, uMedida: uMedida}),
        beforeSend: function (xhr) {
            //  $("#card" + itemCode).html("");
        },
        success: function (data)
        {
            //  $("#card" + itemCode).html(data);
            var dataTable = $('#' + itemCode).DataTable();
            // Destruye el DataTable existente
            dataTable.destroy();
            $("#tbody" + itemCode).html("");
            $("#tbody" + itemCode).html(data.mensaje);
            $('#' + itemCode).DataTable({
                scrollX: true,
                "bPaginate": false,
                "bLengthChange": false,
                "bInfo": false,
                "language": {
                    "sUrl": "js/Spanish.txt"
                }
            });
            generarOptionGroupCargadosItemCode($("#ubicacion").val());
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}
function cuadroRecuentoInventarioVimar(lote, cantidad, ubicacion, itemCode, uMedida) {
    
    
    var tdCajas = "<td>CAJAS " + uMedida + "</td>";
    var tdCajasDet = "<td><input type=\"number\" id=\"cantidadCaja\" placeholder=\"CAJAS\" class=\"form-control\" ></td>";
   if(parseInt(uMedida)==1){
          tdCajas = "";
          tdCajasDet = "<td><input type=\"hidden\" id=\"cantidadCaja\" placeholder=\CAJAS\" value=\"0\" class=\"form-control\" ></td>";
   }
    
    Swal.fire({
        icon: "warning",
        customClass: 'swal-wide',
        html: `
 
       <div class="form-container">
    <div class="form-group">
        <input type="button" id="btnCalculadora" value="Restar" class="form-control bg-danger" onclick="agregarRecuentoInventario('` + lote + `','` + cantidad + `','` + ubicacion + `',-$('#cantidad').val(),'` + itemCode + `','` + uMedida + `',-$('#cantidadCaja').val())">
        <br>
        <br>
        <br>
        <table  class="table">
        <thead>
        <tr>
           <td>UNIDAD</td>
           ` + tdCajas + ` 
        </tr>
         <tr>
            
            <td><input type="number" id="cantidad" placeholder="UNIDAD" class="form-control" ></td>
         ` + tdCajasDet + ` 
        
        </tr>
        
        </thead>
        </table>

    </div>
        <br>
        <br>
        <br>
    <div class="form-group">
        <input type="button" class="btn btn-success form-control" value="SUMAR" onclick="agregarRecuentoInventario('` + lote + `','` + cantidad + `','` + ubicacion + `',$('#cantidad').val(),'` + itemCode + `','` + uMedida + `',$('#cantidadCaja').val())"  > 
      </div>
</div>
    `,
        title: lote,
        showCancelButton: false,
        showConfirmButton: false
    });

}

function cuadroRecuentoInventarioNuevoLoteVimar(itemCode, ubicacion, uMedida) {
    $.ajax({
        type: "POST",
        url: rutaConsultasRecuentoInventarioVimar + "consulta_gen_nuevo_lote.jsp",
        data: ({ubicacion: $("#ubicacion").val(), itemCode: itemCode}),
        beforeSend: function (xhr) {
            Swal.fire({
                icon: "warning",
                customClass: 'swal-wide',
                html: `
 
                <div class="form-container">
                    <div class="form-group">
                        <select class=" selectpicker form-control bg-warning "    data-selected-text-format="count" data-live-search="true" name="loteNuevo" id="loteNuevo"  required="true"   >
                        </select> 
                    </div>
                <div class="form-group">
                    <input type="button" class="btn btn-success form-control" value="Agregar" onclick="agregarRecuentoInventarionNuevoLote( '` + ubicacion + `',$('#loteNuevo').val(),'` + itemCode + `', '` + uMedida + `')"  > 
                </div>
                </div> `,
                title: itemCode,
                showCancelButton: false,
                showConfirmButton: false
            });
        },
        success: function (data)
        {
            $("#loteNuevo").html(data.option)
            $('#loteNuevo').selectpicker({selectAllText: "Seleccionar todo",
                deselectAllText: "Deseleccionar todo", noneSelectedText: "Seleccionar lote",
                noneResultsText: "No se encontraron resultados"});
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });



}

function agregarRecuentoInventario(lote, cantidad, ubicacion, conteo, itemCode, uMedida, conteoCaja) {
    //  console.log(id, cantidad, fecha, tipo, gramos);

    $.ajax({
        type: 'POST',
        url: rutaCrudsRecuentoInventarioVimar + 'control_agregar_conteo.jsp',
        data: ({lote: lote, cantidad: cantidad, ubicacion: ubicacion, conteo: conteo, itemCode: itemCode, uMedida: uMedida, conteoCaja: conteoCaja}),
        beforeSend: function (xhr) {
            procesando_swal();
        },
        success: function (data) {
            // aviso_generico(data.tipo, data.msg);
            //   irGrillaRecuentoInventarioByItemCodeVimar(itemCode);
            var dataTable = $('#' + itemCode).DataTable();

            // Destruye el DataTable existente
            dataTable.destroy();


            $("#tbody" + itemCode).html("");
            $("#tbody" + itemCode).html(data.mensaje);
            // Vuelve a inicializar el DataTable con las nuevas configuraciones
            $('#' + itemCode).DataTable({
                scrollX: true,
                "bPaginate": false,
                "bLengthChange": false,
                "bInfo": false,
                "language": {
                    "sUrl": "js/Spanish.txt"
                }
            });
            Swal.close();
        }
    });

}


function agregarRecuentoInventarionNuevoLote(ubicacion, lote, itemCode, uMedida) {
    //  console.log(id, cantidad, fecha, tipo, gramos);

    $.ajax({
        type: 'POST',
        url: rutaCrudsRecuentoInventarioVimar + 'control_agregar_lote.jsp',
        data: ({lote: lote, ubicacion: ubicacion, itemCode: itemCode}),
        beforeSend: function (xhr) {
            procesando_swal();
        },
        success: function (data) {
            // aviso_generico(data.tipo, data.msg);
            irGrillaRecuentoInventarioByItemCodeVimar(itemCode, uMedida);

            Swal.close();
        }
    });

}


function eliminarLoteNuevoRecuentoInventario(ubicacion, lote, itemCode, uMedida) {

    Swal.fire({
        title: 'ATENCION ',
        text: "DESEA ELIMINAR LA SELECCION DE LOTE " + lote,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'
    }).then((result) => {
        if (result.value)
        {
            $.ajax({
                type: 'POST',
                url: rutaCrudsRecuentoInventarioVimar + 'control_eliminar_lote.jsp',
                data: ({lote: lote, ubicacion: ubicacion, itemCode: itemCode}),
                beforeSend: function (xhr) {
                    procesando_swal();
                },
                success: function (data) {
                    // aviso_generico(data.tipo, data.msg);
                    irGrillaRecuentoInventarioByItemCodeVimar(itemCode, uMedida);
                    Swal.close();
                }
            });
        }
    });


}


function generarOptionGroupCargadosItemCode(ubicacion) {
    $.ajax({
        type: 'POST',
        url: rutaConsultasRecuentoInventarioVimar + 'consulta_gen_itemCode_contados.jsp',
        data: ({ubicacion: ubicacion}),
        beforeSend: function (xhr) {
        },
        success: function (data) {
            $("#grupo_itemCodeCargados").html(data.option)
            generarOptionGroupNoCargadosItemCode(ubicacion);
        }
    });

}


function generarOptionGroupNoCargadosItemCode(ubicacion) {
    $.ajax({
        type: 'POST',
        url: rutaConsultasRecuentoInventarioVimar + 'consulta_gen_itemCode_noContados.jsp',
        data: ({ubicacion: ubicacion}),
        beforeSend: function (xhr) {
        },
        success: function (data) {
            $("#grupo_itemCodeCargados").append("&nbsp&nbsp" + data.option)
            generarOptionGroupNoCargadosItemCodeColores(ubicacion);
        }
    });

}


function generarOptionGroupNoCargadosItemCodeColores(ubicacion) {
    $.ajax({
        type: 'POST',
        url: rutaConsultasRecuentoInventarioVimar + 'consulta_gen_itemCode_noContados_colores.jsp',
        data: ({ubicacion: ubicacion}),
        beforeSend: function (xhr) {
        },
        success: function (data) {
            //  console.log(data.options);
            if (Array.isArray(data.options) && data.options.length > 0) {
                // Iterar sobre el array y mostrar cada opción en la consola
                data.options.forEach(function (option) {
                    // Cambiar la clase de "btn-secondary" a "btn-success" utilizando jQuery
                    $("#optionContados" + option).removeClass("btn-secondary").addClass("btn-warning");
                });
            } else {
                console.log('No hay opciones disponibles.');
            }
        }
    });
}


function registrarRecuentoInventario() {

    Swal.fire({
        title: 'ATENCION ',
        text: "DESEAS FINALIZAR EL INVENTARIO ",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'
    }).then((result) => {
        if (result.value)
        {
            $.ajax({
                type: 'POST',
                url: rutaCrudsRecuentoInventarioVimar + 'control_registrar_inventario.jsp',
                data: ({ubicacion: $("#ubicacion").val()}),
                beforeSend: function (xhr) {
                    procesando_swal();
                },
                success: function (data) {
                    aviso_generico(data.tipo, data.mensaje);
                    if (data.tipo == 1) {
                        irGrillaRecuentoInventarioVimar();
                    }
                }
            });
        }
    });

}



function irRecuentoInformeInventarioVimar() {
    $.ajax({
        type: "POST",
        url: rutaContenedoresRecuentoInventarioVimar + "contenedor_informe_recuento_inventario.jsp",
        beforeSend: function (xhr) {
            //    cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_insert("dd/mm/yyyy");

            /* $('#ubicacion').selectpicker({selectAllText: "Seleccionar todo",
             deselectAllText: "Deseleccionar todo", noneSelectedText: "Seleccionar ubicacion",
             noneResultsText: "No se encontraron resultados"});*/
            //  irGrillaRecuentoInventarioVimar();

            //   cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}

function generarInformeRecuentoInventarioVimarCabecera() {
    // Crear un objeto de datos que contenga la fecha
    var data = {
        fecha: $("#fecha").val()
    };

    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: rutaConsultasRecuentoInventarioVimar + "consulta_gen_grilla_informe_cab.jsp",
        data: data,
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);
            // Pegar la información generada en el div "informe_transferencia"
            $("#div_grilla").html(response.grilla);
            $('#tb_grilla_cab').DataTable({
                scrollX: true,
                "language":
                        {
                            "sUrl": "js/Spanish.txt"
                        }

            }); //le damos formato DataTable 
            cerrar_load();
        },
        error: function (error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}



function generarInformeRecuentoInventarioVimarDetalle(id) {
    // Crear un objeto de datos que contenga la fecha
    var data = {
        id: id
    };

    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: rutaConsultasRecuentoInventarioVimar + "consulta_gen_grilla_informe_det.jsp",
        data: data,
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);
            // Pegar la información generada en el div "informe_transferencia"
            $("#div_grilla_detalle").html(response.grilla);





            $('#tb_grilla_det').DataTable({
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
                        title: 'INFORME RECUENTO NRO. ' + id, // Establecer el nombre del archivo aquí
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        text: 'PDF',
                        title: 'INFORME RECUENTO NRO. ' + id,
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
                        title: 'INFORME RECUENTO NRO. ' + id,
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
        error: function (error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}