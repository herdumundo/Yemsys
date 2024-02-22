/* global rutaContenedoresDesechosVimar, rutaConsultasDesechosVimar, rutaCrudsDesechosVimar, Swal */

function irDesechosAveriados() {
    $.ajax({
        type: "POST",
        url: rutaContenedoresDesechosVimar + "contenedor_desechos.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
            $("#contenedor_principal").html("");
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);
             $('.table').DataTable({ 
             
            scrollX: true, "bPaginate": false,
            "bLengthChange": false, "bInfo": false});
            cerrar_load();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });
}

function cuadroDesechos(id, cantidad, fecha, tipo, linea) {
    Swal.fire({
        icon: "warning",
        customClass: 'swal-wide',
        html: `
    <label >` + linea + `: Nro. ` + id + ` </label> <br>
    <label >Lote: ` + fecha + ` </label>
       <div class="form-container">
    <div class="form-group">
        
        <input type="number" id="cantidad" placeholder="Ingrese cantidad de gramos" class="form-control">
    </div>

    <div class="form-group">
        <input type="button" class="btn btn-success form-control" value="Registrar" onclick="registrarDesechos(` + id + `,` + cantidad + `,'` + fecha + `','` + tipo + `',$('#cantidad').val())"> 
      </div>
</div>
    `,
        title: tipo + ': ' + cantidad,
        text: 'Tu subtítulo aquí', // Agrega el subtítulo utilizando la propiedad text
        showCancelButton: false,
        showConfirmButton: false
    });

}

function registrarDesechos(id, cantidad, fecha, tipo, gramos) {
    console.log(id, cantidad, fecha, tipo, gramos);

    $.ajax({
        type: 'POST',
        url: rutaCrudsDesechosVimar + 'crud_desechos.jsp',
        data: ({id: id, cantidad: cantidad, fecha: fecha, tipo: tipo, gramos: gramos}),
        beforeSend: function (xhr) {
            procesando_swal();
        },
        success: function (data) {
            aviso_generico(data.tipo, data.msg);
            irDesechosAveriados();
        }
    });

}


function irInformeAveriadosDesecho() {
    $.ajax({
        type: "POST",
        url: rutaContenedoresDesechosVimar + "contenedor_informe_desechos.jsp",
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
            if (XMLHttpRequest.status === 404 || XMLHttpRequest.status === 500) {
                location.reload();
            }
        }
    });
}

function generarInformeDesechos() {
    // Obtener la fecha ingresada por el usuario
    var fecha = $("#fechaDesechos").val();
    var data = {fecha: fecha};

    // Realizar una solicitud AJAX tipo POST
    $.ajax({
        type: "POST",
        url: rutaConsultasDesechosVimar + "consulta_gen_grilla_desechos.jsp",
        data: data,
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (response) {
            // Manejar la respuesta del servidor aquí
            console.log(response);
            // Pegar la información generada en el div "informe_transferencia"
            $("#informe_desechos").html(response.grilla);
            $('#tb_informe_desechos').DataTable({
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
                        title: 'INFORME DESECHOS '+ $("#fechaDesechos").val(), // Establecer el nombre del archivo aquí
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        text: 'PDF',
                        title: 'INFORME DESECHOS '+ $("#fechaDesechos").val(),
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
                        title: 'INFORME DESECHOS '+ $("#fechaDesechos").val(),
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


            }); //le damos formato DataTable 
            cerrar_load();
        },
        error: function (error) {
            // Manejar errores aquí
            console.error(error);
        }
    });
}
