/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */



function irInformeFacturacionElectronica()
{
    $.ajax({
        type: "POST",
        url: rutaVimarContenedores + "contenedor_informeFacturacionElectronica.jsp",
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(data);
            cargar_estilo_calendario_global("dd/mm/yyyy")
            cerrar_load();

        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            if (XMLHttpRequest.status == 404 || XMLHttpRequest.status == 500) {
                location.reload();
            }
        }
    });

}

function vimarConsultarFacturasElectronicas() {
 
    $.ajax({
        type: "POST",
        url: rutaApiConsultaVimar + "consultaFacturasElectronicas.jsp",
        data: ({inicio: $("#fechaInicio").val(), fin: $("#fechaFinal").val()}),
        beforeSend: function (xhr) {
            cargar_load("Cargando...");
        },
        success: function (data)
        {
 
            var table = $('#myTable').DataTable();
            table.destroy();
            $('#myTable').DataTable({scrollX: true, scrollY: "500px",
                data: data,
 
                columns: [

                    {data: 'Accion'}
                    , {data: 'Nro_Interno_SAP'}
                    , {data: 'Tipo_de_Obeto_SAP'}
                    , {data: 'Tipo_de_Documento'}
                    , {data: 'DocNum'}
                    , {data: 'Fecha_de_Documento'}
                    , {data: 'Punto_de_Establecimiento'}
                    , {data: 'Punto_de_Emision'}
                    , {data: 'Folio'}
                    , {data: 'Timbrado'}
                    , {data: 'Numero_de_comprobante'}
                    , {data: 'Serie'}
                    , {data: 'Codigo_de_Cliente'}
                    , {data: 'Nombre_de_Cliente'}
                    , {data: 'Direccion'}
                    , {data: 'RUC'}
                    , {data: 'Vendedor'}
                    , {data: 'Cancelado_en_SAP'}
                    , {data: 'ID_SSC'}
                    , {data: 'CDC'}
                    , {data: 'Estado'}
                    , {data: 'Observacion'}
                    , {data: 'Insercion'}
                    , {data: 'Actualizacion'}
                    , {data: 'Origen'}
                    , {data: 'Archivo_XML'}
                    , {data: 'DocDate'}

                ],
                dom: 'Bfrtip',

                buttons: [
                    {extend: "copyHtml5", text: "COPIAR GRILLA", exportOptions: {columns: [0, ":visible"]}},
                    {extend: "excelHtml5", title: "Titulo", text: "EXCEL", exportOptions: {columns: ":visible"}},
                    {
                        extend: "pdfHtml5",
                        text: "PDF",
                        title: "\n    titulo:",
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
                        exportOptions: {columns: ":visible"},
                    },
                    "colvis",
                ],
                language: {"url": "//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json"},
               
                 initComplete: function() {
        var api = this.api();
        api.columns().every(function() {
            var column = this;
            if (!$(column.header()).has('input').length) {
                var input = $('<input type="text" placeholder="Filtrar..."/>')
                    .appendTo($(column.header()))
                    .on('keyup change clear', function () {
                        if (column.search() !== this.value) {
                            column.search(this.value).draw();
                        }
                    });
            }
        });
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