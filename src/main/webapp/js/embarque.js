var ruta_contenedores_emb = "./contenedores/contenedores_embarque/";
var cruds_emb = "./cruds/embarques/";
var ruta_grillas_emb = "./grillas/embarques/";
var ruta_consultas_emb = "./consultas/embarques/";
//var ruta_consultas                  =   "./consultas/";﻿    
var counter = 0;//VARIABLE PARA COLOCAR PREPEND EL ULTIMO CARRO INGRESADO ARRIBA. CON LA FUNCION DATATABLE Y ORDER BY.
 

function ir_informe_embarque() {
    
   window.location.hash = "embarque";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_emb + 'contenedor_reporte_embarque.jsp',
        beforeSend: function ()
        {
            cargar_load();
        },
        success: function (res)
        {         
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(res);
            cargar_estilo_calendario_insert("dd/mm/yyyy");
            cerrar_load();
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) 
        {
            if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500)
            {
                location.reload();
            }
        }
    }) ;
    }

 

function traer_embarque(id_camion, nro_factura, cod_chofer, fecha )
{
     
    $.ajax({
        type: "POST",
        url: ruta_contenedores_emb + 'embarque.jsp',
        beforeSend: function () {
            $("#contenedor_principal").html("");
              cargar_load();
        },
        success: function (data)
        {
            $("#contenedor_principal").html(data);
            $("#cbox_camion").val(id_camion).change();
            $("#cbox_chofer").val(cod_chofer).change();
            $('#txt_nro_fact').val(nro_factura);
            $('#calendario_embarque').val(fecha);
            $('#txt_lote').focus();
            
            llenar_grilla_pendientes(nro_factura);
          //  validar_factura(nro_factura);
            factura_togle();
            cargar_estilo_calendario_insert("dd/mm/yyyy");
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function traer_informe_factura() {
    window.location.hash = "traer_informe_factura";
     $.ajax({
        type: "POST",
        url: ruta_contenedores_emb + 'informe_factura.jsp',
         beforeSend: function ()
        {
            cargar_load();
        },
        success: function (res)
        {         
            $("#contenedor_principal").html("");
            $("#contenedor_principal").html(res);
            cerrar_load();
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) 
        {
            if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500)
            {
                location.reload();
            }
        }
    }) ;



}

function llenar_grilla_pendientes(nro_factura) {
    
     $.ajax({
        type: "POST",
        url: cruds_emb + 'control_grilla_recuperada.jsp',
        data:({nro_factura: nro_factura}),
        beforeSend: function ()
        {
            cargar_load("Cargando")
        },
        success: function (res)
        {
            $("#tbody_embarque").html(res.grilla);
            $("#div_aviso").html("");
            $("#div_aviso").html(res.div_aviso);
            $(".ocultar").hide();
            activar_datatable();// EN ESTE PROCESO SE HABILITA POR UNICA VEZ EL DATATABLE, CADA VEZ QUE LLAME A TRAER_EMBARQUE ESTE PROCESO SE EJECUTA.
            eliminar_fila_embarque_pendientes();
            counter = res.count;
            
            var split = res.codigo;
            var A = "";
            var B = "";
            var C = "";
            var D = "";
            var S = "";
            var J = "";
            var G = "";
            if (split == 'A_0,B_0,C_0,D_0,S_0,J_0,G_0') {

                swal.fire({
                    type: 'error',
                    title: "ERROR, FACTURA NO EXISTE O YA HA SIDO CERRADA",
                    confirmButtonText: "CERRAR"
                });

                $('#txt_nro_fact').val('');
                $('#total_a').val('0');
                $('#total_b').val('0');
                $('#total_c').val('0');
                $('#total_d').val('0');
                $('#total_s').val('0');
                $('#total_j').val('0');
                $('#total_g').val('0');

                colorear_blanco();

            } else {

                var arr = split.split(',');
                var i = 0;
                for (i = 0; i < arr.length; i++)
                {
                    A = arr[0];
                    B = arr[1];
                    C = arr[2];
                    D = arr[3];
                    S = arr[4];
                    J = arr[5];
                    G = arr[6];
                }
                $('#total_a').val(A.substring(2));
                $('#total_b').val(B.substring(2));
                $('#total_c').val(C.substring(2));
                $('#total_d').val(D.substring(2));
                $('#total_s').val(S.substring(2));
                $('#total_j').val(J.substring(2));
                $('#total_g').val(G.substring(2));
                $('#total_factura_carros').val(res.total);
                colorear();


            }
            
            
            
            
            
            cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    }) ;
   
}

function validar_factura(numero) {

    if (numero == "") {
    } else {
        $.get(ruta_consultas_emb + 'select_facturas.jsp', {numero: numero}, function (res) {
         
            var split = res.codigo;
            var A = "";
            var B = "";
            var C = "";
            var D = "";
            var S = "";
            var J = "";
            var G = "";
            if (split == 'A_0,B_0,C_0,D_0,S_0,J_0,G_0') {

                swal.fire({
                    type: 'error',
                    title: "ERROR, FACTURA NO EXISTE O YA HA SIDO CERRADA",
                    confirmButtonText: "CERRAR"
                });

                $('#txt_nro_fact').val('');
                $('#total_a').val('0');
                $('#total_b').val('0');
                $('#total_c').val('0');
                $('#total_d').val('0');
                $('#total_s').val('0');
                $('#total_j').val('0');
                $('#total_g').val('0');

                colorear_blanco();

            } else {

                var arr = split.split(',');
                var i = 0;
                for (i = 0; i < arr.length; i++)
                {
                    A = arr[0];
                    B = arr[1];
                    C = arr[2];
                    D = arr[3];
                    S = arr[4];
                    J = arr[5];
                    G = arr[6];
                }
                $('#total_a').val(A.substring(2));
                $('#total_b').val(B.substring(2));
                $('#total_c').val(C.substring(2));
                $('#total_d').val(D.substring(2));
                $('#total_s').val(S.substring(2));
                $('#total_j').val(J.substring(2));
                $('#total_g').val(G.substring(2));
                $('#total_factura_carros').val(res.total);
                colorear();


            }

        });

    }

}



function cargar_grilla(cod_lote, tipo, nro_carrito, item_codigo, cantidad, fecha_puesta, estado, identificador)
{
    var contador = 0;
    var table = $('#myTable').DataTable();
    var data = table.rows({selected: true}).data();
    for (var i = 0; i < data.length; i++)
    {
        if (data[i][8] == identificador)
        {
            contador++;
        }
    }
    if (contador == 0)
    {
       // registrar_pendientes(cod_lote, tipo, nro_carrito, item_codigo, cantidad, fecha_puesta, estado, identificador);
        
        var newData = [cod_lote, tipo, nro_carrito, item_codigo, cantidad, fecha_puesta, '<a class="btn btn-danger font-weight-bold remove"   > <i class="fa fa-trash-o fa-lg"></i> Eliminar</a>',
            estado, identificador, counter];

        var rowNode = table.row.add(newData).order([9, 'desc']).draw(false).node();
        $(rowNode).find('td').eq(1).addClass('font-weight-bold');//AGREGAR CLASES AL LA CELDA POSICION 1
        $(rowNode).find('td').eq(2).addClass('font-weight-bold');
        $(rowNode).find('td').eq(4).addClass('font-weight-bold');
        $(rowNode).find('td').eq(5).addClass('font-weight-bold');
        $(rowNode).find('td').eq(6).addClass('font-weight-bold');
        $(rowNode).find('td').eq(0).addClass('ocultar font-weight-bold');
        $(rowNode).find('td').eq(3).addClass('ocultar font-weight-bold');
        $(rowNode).find('td').eq(7).addClass('ocultar font-weight-bold');
        $(rowNode).find('td').eq(8).addClass('ocultar font-weight-bold');
        $(rowNode).attr('id', 'row' + identificador);//AGREGA ID AL <tr> FILA.
        $(".ocultar").hide();
        calculos_cantidades_grilla();// VUELVE A RECALCULAR LAS CANTIDADES, UNA VEZ INGRESADA LA FILA.
        counter++;// CONTADOR GLOBAL, PARA EL ORDER BY PREPEND. 
    } else {
        swal.fire({
            type: 'error',
            title: "CODIGO DUPLICADO",
            confirmButtonText: "CERRAR"
        });
    }
}

function validar_embarque(datos_grilla) {
    if ($('#cbox_chofer').val() == "-" || $('#calendario_embarque').val() == "" || $('#cbox_camion').val() == "-" || datos_grilla.length == 0) {
        aviso_error();
    } else {
        confirmar_registro(datos_grilla);
    }
}

function registrar_embarque() {

    var total_a_grilla = ($('#tipo_cja').val() * 360) + ($('#tipo_ca').val() * 4320);
    var total_b_grilla = ($('#tipo_cjb').val() * 360) + ($('#tipo_cb').val() * 4320);
    var total_c_grilla = ($('#tipo_cjc').val() * 360) + ($('#tipo_cc').val() * 4320);
    var total_d_grilla = ($('#tipo_cjd').val() * 360) + ($('#tipo_cd').val() * 4320);
    var total_s_grilla = ($('#tipo_cjs').val() * 360) + ($('#tipo_cs').val() * 4320);
    var total_j_grilla = ($('#tipo_cjj').val() * 360) + ($('#tipo_cj').val() * 4320);
    var total_g_grilla = ($('#tipo_cjg').val() * 180) + ($('#tipo_cg').val() * 2160);

    var fac_a = $('#total_a').val();
    var fac_b = $('#total_b').val();
    var fac_c = $('#total_c').val();
    var fac_d = $('#total_d').val();
    var fac_s = $('#total_s').val();
    var fac_j = $('#total_j').val();
    var fac_g = $('#total_g').val();

    var total_carros = parseInt($('#tipo_ca').val()) + parseInt($('#tipo_cb').val()) + parseInt($('#tipo_cc').val()) + parseInt($('#tipo_cd').val()) + parseInt($('#tipo_cs').val()) + parseInt($('#tipo_cj').val()) + parseInt($('#tipo_cg').val());
    var total_cajones = (parseInt($('#tipo_cja').val()) + parseInt($('#tipo_cjb').val()) + parseInt($('#tipo_cjc').val()) + parseInt($('#tipo_cjd').val()) + parseInt($('#tipo_cjs').val()) + parseInt($('#tipo_cjj').val()) + parseInt($('#tipo_cjg').val())) / 12;
    var total_carros_factura = $('#total_factura_carros').val();


    if (parseInt(total_carros_factura) === parseInt(total_carros) + parseInt(total_cajones))
    {
        if (total_a_grilla > fac_a)
        {
            aviso_cantidad_mayor('A', (fac_a / 360));
        } else if (total_b_grilla > fac_b)
        {
            aviso_cantidad_mayor('B', (fac_b / 360));
        } else if (total_c_grilla > fac_c)
        {
            aviso_cantidad_mayor('C', (fac_c / 360));
        } else if (total_d_grilla > fac_d)
        {
            aviso_cantidad_mayor('D', (fac_d / 360));
        } else if (total_s_grilla > fac_s)
        {
            aviso_cantidad_mayor('S', (fac_s / 360));
        } else if (total_j_grilla > fac_j)
        {
            aviso_cantidad_mayor('J', (fac_j / 360));
        } else if (total_g_grilla > fac_g)
        {
            aviso_cantidad_mayor('G', (fac_g / 360));
        } else {

            var valores = '';
            var tipos = '';
            var table = $('#myTable').DataTable();
            var data = table.rows({selected: true}).data();
            var newarray = [];
            var newarray_tipo = [];
            for (var i = 0; i < data.length; i++)
            {
                newarray.push(data[i][0] + "&" + data[i][2] + "&" + data[i][4] + "&" + data[i][3] + "&" + data[i][7] + "&" + data[i][8] + "&" + data[i][5]);
                if (tipos.includes(data[i][3])) {
                } else {
                    newarray_tipo.push(data[i][3]);
                    tipos = newarray_tipo.join();
                }
            }
            valores = newarray.join();
            // $('#resultado').val(valores);
            $('#tipo_grilla').val(tipos);
            validar_embarque(valores);
        }
    } else if (parseInt(total_carros_factura) < parseInt(total_carros) + parseInt(total_cajones)) {
        swal.fire({
            type: 'error',
            title: "ERROR, CANTIDAD EXCEDIDA",
            confirmButtonText: "CERRAR"
        });
    } else if (parseInt(total_carros_factura) > (parseInt(total_carros) + parseInt(total_cajones))) {
        swal.fire({
            type: 'error',
            title: "ERROR, CARROS FALTANTES, FAVOR VERIFICAR",
            confirmButtonText: "CERRAR"
        });
    }
} /// FIN DEL FUNCTION.

function colorear() {
    var inputVal = document.getElementById("txt_nro_fact");
    inputVal.style.backgroundColor = "#68FF33";
    $('#div_embarque_carga').show();
}

function colorear_blanco() {
    var inputVal = document.getElementById("txt_nro_fact");
    inputVal.style.backgroundColor = "#ffffff";
}

function calculos_cantidades_grilla() {
    var total_tipoC = 0;
    var total_tipoA = 0;
    var total_tipoB = 0;
    var total_tipoD = 0;
    var total_tipoS = 0;
    var total_tipoG = 0;
    var total_tipoJ = 0;

    var total_tipoCC = 0;
    var total_tipoCA = 0;
    var total_tipoCB = 0;
    var total_tipoCD = 0;
    var total_tipoCS = 0;
    var total_tipoCG = 0;
    var total_tipoCJ = 0;

    var total_tipoCJC = 0;
    var total_tipoCJA = 0;
    var total_tipoCJB = 0;
    var total_tipoCJD = 0;
    var total_tipoCJS = 0;
    var total_tipoCJG = 0;
    var total_tipoCJJ = 0;

    $('#tipo_a').val('0');
    $('#tipo_b').val('0');
    $('#tipo_c').val('0');
    $('#tipo_d').val('0');
    $('#tipo_s').val('0');
    $('#tipo_j').val('0');
    $('#tipo_g').val('0');

    $('#tipo_ca').val('0');
    $('#tipo_cb').val('0');
    $('#tipo_cc').val('0');
    $('#tipo_cd').val('0');
    $('#tipo_cs').val('0');
    $('#tipo_cj').val('0');
    $('#tipo_cg').val('0');

    $('#tipo_cja').val('0');
    $('#tipo_cjb').val('0');
    $('#tipo_cjc').val('0');
    $('#tipo_cjd').val('0');
    $('#tipo_cjs').val('0');
    $('#tipo_cjj').val('0');
    $('#tipo_cjg').val('0');
    var table = $('#myTable').DataTable();//OBTENEMOS LOS DATOS QUE SE HAN CARGADO EN LA MEMORIA DEL DATATABLE.
    var data = table.rows({selected: true}).data();
    for (var i = 0; i < data.length; i++) {
        // obtenemos los valores de la cantidad y importe
        var cantidad_tipoC = parseFloat(data[i][4]);
        var cantidad_tipoA = parseFloat(data[i][4]);
        var cantidad_tipoB = parseFloat(data[i][4]);
        var cantidad_tipoG = parseFloat(data[i][4]);
        var cantidad_tipoD = parseFloat(data[i][4]);
        var cantidad_tipoS = parseFloat(data[i][4]);
        var cantidad_tipoJ = parseFloat(data[i][4]);
        var tipo = parseFloat(data[i][3]);
        var cantidad_tipoCC = parseFloat(data[i][4]);
        var cantidad_tipoCA = parseFloat(data[i][4]);
        var cantidad_tipoCB = parseFloat(data[i][4]);
        var cantidad_tipoCD = parseFloat(data[i][4]);
        var cantidad_tipoCS = parseFloat(data[i][4]);
        var cantidad_tipoCJ = parseFloat(data[i][4]);
        var cantidad_tipoCG = parseFloat(data[i][4]);
        var tipo_carro = parseFloat(data[i][3]);
        var cantidad_tipoCJC = parseFloat(data[i][4]);
        var cantidad_tipoCJA = parseFloat(data[i][4]);
        var cantidad_tipoCJB = parseFloat(data[i][4]);
        var cantidad_tipoCJD = parseFloat(data[i][4]);
        var cantidad_tipoCJS = parseFloat(data[i][4]);
        var cantidad_tipoCJJ = parseFloat(data[i][4]);
        var cantidad_tipoCJG = parseFloat(data[i][4]);
        var tipo_cajon = parseFloat(data[i][3]);

        //BUSCA Y CALCULA CANTIDADES EN CARROS.
        if (tipo_carro == '1' && cantidad_tipoCG == "2160") {
            total_tipoCG += cantidad_tipoCG;
            $('#tipo_cg').val(parseInt(total_tipoCG) / 2160);
        }
        if (tipo_carro == '2' && cantidad_tipoCJ == "4320") {
            total_tipoCJ += cantidad_tipoCJ;
            $('#tipo_cj').val(parseInt(total_tipoCJ) / 4320);
        }
        if (tipo_carro == '3' && cantidad_tipoCS == "4320") {
            total_tipoCS += cantidad_tipoCS;
            $('#tipo_cs').val(parseInt(total_tipoCS) / 4320);
        }
        if (tipo_carro == '4' && cantidad_tipoCA == "4320") {
            total_tipoCA += cantidad_tipoCA;
            $('#tipo_ca').val(parseInt(total_tipoCA) / 4320);
        }
        if (tipo_carro == '5' && cantidad_tipoCB == "4320") {
            total_tipoCB += cantidad_tipoCB;
            $('#tipo_cb').val(parseInt(total_tipoCB) / 4320);
        }
        if (tipo_carro == '6' && cantidad_tipoCC == "4320") {
            total_tipoCC += cantidad_tipoCC;
            $('#tipo_cc').val(parseInt(total_tipoCC) / 4320);
        }
        if (tipo_carro == '7' && cantidad_tipoCD == "4320") {
            total_tipoCD += cantidad_tipoCD;
            $('#tipo_cd').val(parseInt(total_tipoCD) / 4320);
        }
        //COMPARACIONES EN CAJONES  
        if (tipo_cajon == '1' && cantidad_tipoCJG != "2160") {
            total_tipoCJG += cantidad_tipoCJG;
            $('#tipo_cjg').val(parseInt(total_tipoCJG) / 180);
        }
        if (tipo_cajon == '2' && cantidad_tipoCJJ != "4320") {
            total_tipoCJJ += cantidad_tipoCJJ;
            $('#tipo_cjj').val(parseInt(total_tipoCJJ) / 360);
        }
        if (tipo_cajon == '3' && cantidad_tipoCJS != "4320") {
            total_tipoCJS += cantidad_tipoCJS;
            $('#tipo_cjs').val(parseInt(total_tipoCJS) / 360);
        }
        if (tipo_cajon == '4' && cantidad_tipoCJA != "4320") {
            total_tipoCJA += cantidad_tipoCJA;
            $('#tipo_cja').val(parseInt(total_tipoCJA) / 360);
        }
        if (tipo_cajon == '5' && cantidad_tipoCJB != "4320") {
            total_tipoCJB += cantidad_tipoCJB;
            $('#tipo_cjb').val(parseInt(total_tipoCJB) / 360);
        }
        if (tipo_cajon == '6' && cantidad_tipoCJC != "4320") {
            total_tipoCJC += cantidad_tipoCJC;
            $('#tipo_cjc').val(parseInt(total_tipoCJC) / 360);
        }
        if (tipo_cajon == '7' && cantidad_tipoCJD != "4320") {
            total_tipoCJD += cantidad_tipoCJD;
            $('#tipo_cjd').val(parseInt(total_tipoCJD) / 360);
        }
        //CALCULA CANTIDADES DE TODOS LOS LOTES INGRESADOS, PARA OBTENER EL TOTAL EN CAJONES Y EL TOTAL EN CARROS    
        if (tipo == '1') {
            total_tipoG += cantidad_tipoG;
            $('#tipo_g').val(parseInt(total_tipoG) / 180);
        }
        if (tipo == '2') {
            total_tipoJ += cantidad_tipoJ;
            $('#tipo_j').val(parseInt(total_tipoJ) / 360);
        }
        if (tipo == '3') {
            total_tipoS += cantidad_tipoS;
            $('#tipo_s').val(parseInt(total_tipoS) / 360);
        }
        if (tipo == '4') {
            total_tipoA += cantidad_tipoA;
            $('#tipo_a').val(parseInt(total_tipoA) / 360);
        }
        if (tipo == '5') {
            total_tipoB += cantidad_tipoB;
            $('#tipo_b').val(parseInt(total_tipoB) / 360);
        }
        if (tipo == '6') {
            total_tipoC += cantidad_tipoC;
            $('#tipo_c').val(parseInt(total_tipoC) / 360);
        }
        if (tipo == '7') {
            total_tipoD += cantidad_tipoD;
            $('#tipo_d').val(parseInt(total_tipoD) / 360);
        }
    } // FIN DEL FOR EACH
    var total = 0;
    total = parseInt(total_tipoA) + parseInt(total_tipoB) + parseInt(total_tipoC) + parseInt(total_tipoD) + parseInt(total_tipoS) + parseInt(total_tipoJ) + parseInt(total_tipoG * 2);
    $('#total_cajones').val(total / 360);
    $('#total_carros').val(parseInt(total) / 4320);
}

function factura_togle() {
    $('#chkToggle2').change(function () {
        if ($(this).prop("checked") == true) {
            $('#txt_nro_fact').show();
            $('#txt_nro_fact').val('');
        } else {
            $('#txt_nro_fact').hide();
            $('#txt_nro_fact').val('');
        }
    });
}


function teclado_formateado() {
    $('#txt_nro_fact').inputmask("[9][9]9999999", {
        numericInput: true,
        "placeholder": "0",
        showMaskOnHover: false,
        greedy: false
    });
}
 
function cargar_datos_key() {
    if (event.keyCode == 13 || event.which == 13) {
        traer_control_embarque($('#txt_lote').val(), $('#calendario_embarque').val());
    }
}

function enviar_pdf(numero)
{
    var url = "http://192.168.125.20:8086/Embarque/reportes/Reporte_embarque.jsp?numero=" + numero;
    window.open(url);
}
        