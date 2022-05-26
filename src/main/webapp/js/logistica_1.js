var ruta_contenedores = "./contenedores/contenedores_logistica/";
var cruds = "./cruds/logistica/";
var ruta_grillas = "./grillas/logistica/";
var ruta_consultas = "./consultas/logistica/";

var direccion = "1";
var contador_mixto_pedido_log_ccha = 0;
var contador_mixto_pedido_log_cyo = 0;
var contador_mixto_pedido_log_cchb = 0;
var contador_mixto_pedido_log_cchh = 0;
var contador_mixto_pedido_log_lavado = 0;
var array_mixto_pedidos = "";
var cantidad_total_ccha = 0;
var cantidad_total_cchb = 0;
var cantidad_total_cchh = 0;
var cantidad_total_ovo = 0;
var cantidad_total = 0;
var elem = document.documentElement;
var pantalla = "SI";

var cont_filtro = 0; // SE USA PARA QUE AL USAR EL FILTRO DE DATATABLE, PUEDA CALCULAR LAS CELDAS.


function openFullscreen() {

    if (pantalla == "SI")
    {
        if (elem.requestFullscreen) {
            elem.requestFullscreen();
        } else if (elem.webkitRequestFullscreen) { /* Safari */
            elem.webkitRequestFullscreen();
        } else if (elem.msRequestFullscreen) { /* IE11 */
            elem.msRequestFullscreen();
        }
        pantalla = "NO";
    } else if (pantalla == "NO")
    {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.webkitExitFullscreen) { /* Safari */
            document.webkitExitFullscreen();
        } else if (document.msExitFullscreen) { /* IE11 */
            document.msExitFullscreen();
        }
        pantalla = "SI";
    }
}



function generar_grilla_pedido(tipo, codigo)
{
    cont_filtro = 0; //INICIALIZA A 0 PARA EL FILTRO DE DATATABLE EN FUNCION SOLO NUMEROS TD

    var pagina = "";
    var area = "";//este sirve solo para enviar para que clasificadora es
    if (tipo == 1 || tipo == 4)
    {
        pagina = "generar_grilla_preembarque.jsp";
    } 
    else if (tipo == 2)
    {
        pagina = "generar_grilla_preembarque_editar_log.jsp?id=" + codigo;
    } 
    else if (tipo == 3)
    {
        pagina = "generar_grilla_preembarque_cyo.jsp?id=" + codigo;
    }
    else if (tipo == 5)
    {
        pagina = "generar_grilla_preembarque_cajones.jsp";
    }
    $.ajax({
        type: "POST",
        url: ruta_consultas + pagina,
        beforeSend: function ()
        {
            cargar_load("Cargando")
        },
        success: function (res)
        {
            //TIPO 1 ES IGUAL A GENERACION DE PEDIDO
            //TIPO 2 ES IGUAL A FACTURACION
            //TIPO 3 ES IGUAL A CYO
            //FIRT ES EL DIV EN DONDE SE ALMACENA LA GRILLA DE CARROS ENTERO, EL SECOND ALMACENA LOS CARROS MIXTOS.
            $("#contenido_grillas").html(res.grilla + " " + res.grilla_mixto);

            $("#tb_preembarque_mixto").DataTable(
                    {
                        responsive: true,
                        scrollY: "547px",
                        scrollX: "500px",
                        paging: false,
                        "language":
                                {
                                    "sUrl": "js/Spanish.txt"
                                }
                    }

            );
  

            if (tipo == 1 || tipo == 2)
            {
                var columns = $("#tb_preembarque > tbody > tr:first > td").length;
                var ccha = 0;// 3 al 13
                var cchb = 0;//14 al 23
                var cchh = 0;//24 al 33
                var ovo = 0; //34 al 42
                var cyo = 0;//43 al 52
                for (var i = 3; i <= columns; )
                {
                    if ($("#tb_preembarque > tbody > tr > td:nth-child(" + i + ")").filter(function () {
                        return $(this).text() != 0;
                    }).length == 0)
                    {
                        var ing = 1 + i;
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + i + "), #tb_preembarque > thead > tr > th:nth-child(" + i + ")").hide();
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + ing + "), #tb_preembarque > thead > tr > th:nth-child(" + ing + ")").hide();

                        if (i >= 3 && i < 13) {
                            ccha = ccha + 2;
                        }
                        if (i >= 13 && i < 23) {
                            cchb = cchb + 2;
                        }
                        if (i >= 23 && i < 33) {
                            cchh = cchh + 2;
                        }
                        if (i >= 33 && i < 41) {
                            ovo = ovo + 2;
                        }
                        if (i >= 41 && i < 51) {
                            cyo = cyo + 2;
                        }
                        $("#th_ccha").show();
                        $("#th_cchb").show();
                        $("#th_cchh").show();
                        $("#th_ovo").show();
                        $("#th_cyo").show();

                    }
                    i = i + 2;
                }
                $("#th_ccha").attr('colspan', 10 - ccha);
                $("#th_cchb").attr('colspan', 10 - cchb);
                $("#th_cchh").attr('colspan', 10 - cchh);
                $("#th_ovo").attr('colspan', 8 - ovo);
                $("#th_cyo").attr('colspan', 10 - cyo);

                if (10 - ccha == 0) {
                    $("#th_ccha").hide();
                }
                if (10 - cchb == 0) {
                    $("#th_cchb").hide();
                }
                if (10 - cchh == 0) {
                    $("#th_cchh").hide();
                }
                if (8 - ovo == 0) {
                    $("#th_ovo").hide();
                }
                if (10 - cyo == 0) {
                    $("#th_cyo").hide();
                }
                $("#btn_directorio_actualizar").remove();
            }
            if (tipo == 4 || tipo == 5 ) 
            {
                if(tipo==4)
                {
                    $("#btn_directorio_actualizar").remove();
                }
                $("#btn_logistica_actualizar").remove();
                $("#div_pedido").hide();
                $("#div_2").hide();
                var columnsc = $("#tb_preembarque > tbody > tr:first > td").length;

                var cchac = 0;// 3 al 13
                var cchbc = 0;//14 al 23
                var cchhc = 0;//24 al 33
                var ovoc = 0; //34 al 42
                var cyoc = 0;//43 al 52
                for (var i = 3; i <= columnsc; )
                {
                    if ($("#tb_preembarque > tbody > tr > td:nth-child(" + i + ")").filter(function () {
                        return $(this).text() != 0;
                    }).length == 0)
                    {
                        $("#tb_preembarque > tbody > tr > td:nth-child(" + i + "), #tb_preembarque > thead > tr > th:nth-child(" + i + ")").hide();

                        if (i >= 3 && i < 13) {
                            cchac = cchac + 1;
                        }
                        if (i >= 13 && i < 23) {
                            cchbc = cchbc + 1;
                        }
                        if (i >= 23 && i < 33) {
                            cchhc = cchhc + 1;
                        }
                        if (i >= 33 && i < 41) {
                            ovoc = ovoc + 1;
                        }
                        if (i >= 41 && i < 51) {
                            cyoc = cyoc + 1;
                        }
                        $("#th_ccha").show();
                        $("#th_cchb").show();
                        $("#th_cchh").show();
                        $("#th_ovo").show();
                        $("#th_cyo").show();

                    }
                    i++;
                }
                $("#th_ccha").attr('colspan', 10 - cchac);
                $("#th_cchb").attr('colspan', (10 - cchbc));
                $("#th_cchh").attr('colspan', (10 - cchhc));
                $("#th_ovo").attr('colspan', (8 - ovoc));
                $("#th_cyo").attr('colspan', (10 - cyoc));

                if (10 - cchac == 0) {
                    $("#th_ccha").hide();
                }
                if (10 - cchbc == 0) {
                    $("#th_cchb").hide();
                }
                if (10 - cchhc == 0) {
                    $("#th_cchh").hide();
                }
                if (8 - ovoc == 0) {
                    $("#th_ovo").hide();
                }
                if (10 - cyoc == 0) {
                    $("#th_cyo").hide();
                }

            }


            seleccionar_todo_input();
            //   if(tipo!=3)
            // {
             $("#tb_preembarque").DataTable(
                    {   
                        scrollY: "547px",
                        scrollX: "500px",
                        responsive: true,
                        scrollCollapse: true,
                        
                        paging: false,
                        fixedColumns:
                                {
                                    leftColumns: 2
                                },

                        "language":
                                {
                                    "sUrl": "js/Spanish.txt"
                                },
                   
                    });
             
            $("#btn_atras").show();
            solo_numeros_td();//LAS CELDAS SOLO PERMITIRAN NUMEROS. 

            if (tipo == 2 || tipo == 3)//CASO DE PEDIDOS QUE SE EDITARAN, YA SEA EN FACTURACION O EN CYO
            {
                var arr = res.cod_camion.split("_");
                var codigo_camion = arr[1];
                var capacidad = arr[0];
                $("#" + res.cod_camion).attr({"selected": true});//SELECCIONA PARA PRIMERA OPCION
                $("#" + res.cod_chofer).attr({"selected": true});//SELECCIONA PARA PRIMERA OPCION
                $('#txt_obs').val(res.obs); //AQUI TRAE SOLO LOS TIPOS DE HUEVOS.


                if (tipo == 2)// 
                {
                    $('#txt_disponibilidad').val(capacidad);
                } else if (tipo == 3)
                {
                    $('#txt_disponibilidad').val(res.cantidad_area);  //AQUI SE OBTIENE SOLO LA CANTIDAD DE DICHA AREA, NO EL TOTAL DE TODAS LAS AREAS.
                    $('#validacion_cantidades').val(res.validacion_cantidades); //AQUI TRAE LOS TIPOS DE HUEVOS CON SUS CANTIDADES
                    $('#validacion_tipos').val(res.validacion_tipos); //AQUI TRAE SOLO LOS TIPOS DE HUEVOS.


                    document.getElementById('txt_obs').disabled = true;// SE DENIEGA LA SELECCION DEL CAMION.
                    document.getElementById('cbox_camion').disabled = true;// SE DENIEGA LA SELECCION DEL CAMION.
                    document.getElementById('cbox_chofer').disabled = true;// SE DENIEGA LA SELECCION DEL CHOFER.


                    area = res.area;// SE RECUPERA EL AREA
                }
                if (res.carros_mixtos.length > 0)//ESTE PROCESO, NO DEBE ENTRAR AL GENERAR EL PEDIDO, YA QUE EL JSON NO CONTIENE ESTE VALOR.
                {
                    var array_carros = res.carros_mixtos.split(",");
                    for (i = 0; i < array_carros.length; i++)
                    {
                        $("#" + array_carros[i]).removeClass('btn-dark ').addClass(' btn-primary  bg1 ');
                        $("#" + array_carros[i]).html("SELECCIONADO");
                    }
                    contar_mixtos_seleccionados();
                }
                $('#id_pedido').val(res.id_pedido);// SE RECIBE EL ID DEL PEDIDO PARA USARLO.

            }


            if (tipo == 2 || tipo == 1)
            {
                $("td").focus(function ()// ACCION PARA QUE AL HACER CLIC EN CELDA, SELECCIONE TODO EL VALOR
                {
                    var range = document.createRange();
                    range.selectNodeContents(this);
                    var sel = window.getSelection();
                    sel.removeAllRanges();
                    sel.addRange(range);

                });
                $("td").keyup(function ()// ACION PARA QUE AL TIPEAR EJECUTE LA ACCION.
                {
                    obtener_valores_celda('1');

                });

                if (tipo == 2) { //SI ES PEDIDO GENERADO, ENTONCES EL CLIC DE GENERAR PEDIDO, HARA OTRA COSA.
                    $('#btn_generar').click(function () {
                        obtener_valores_celda('2', 'EDITAR');
                    });
                } else if (tipo == 1) {
                    $('#btn_generar').click(function () {
                        obtener_valores_celda('2', 'REGISTRO');
                    });
                }
                obtener_valores_celda('1');//EN ESTA CASO, REALIZARA VERIFICACIONES CUANDO ES 1, Y NO EJECUTARA EL REGISTRO.
            } else if (tipo == 3)
            {
                $("td").focus(function ()
                {
                    var range = document.createRange();
                    range.selectNodeContents(this);
                    var sel = window.getSelection();
                    sel.removeAllRanges();
                    sel.addRange(range);
                });

                $("td").keyup(function ()// ACION PARA QUE AL TIPEAR EJECUTE LA ACCION.
                {
                    calculo_cantidades_grilla_cyo(1, "CHEQUEO", area);
                });

                calculo_cantidades_grilla_cyo(1, "CHEQUEO", area);// CUANDO ES 1 CASO OMISO AL REGISTRO

                $('#btn_generar').click(function () {
                    calculo_cantidades_grilla_cyo(2, "EDITARCYO", area);// CUANDO EL TIPO ES DOS, SIGNIFICA QUE SE EJECUTARA EL REGISTRO
                });
            }




            cargar_cantidades_ingresadas_editar(tipo);
                
            cerrar_load();

        },
        error: function (error)
        {
            generar_grilla_pedido(tipo, codigo);
        }

    });

}

function obtener_valores_celda(tipo, generacion_pedido)
{
    var filas = document.querySelectorAll("#tb_preembarque tbody tr");
    var verificar_excedido_td = 1;

    var ccha_lib;
    var ccha_cant_lib;
    var ccha_acep;
    var ccha_cant_acep;
    var ccha_invo;
    var ccha_cant_invo;
    var ccha_ldo;
    var ccha_cant_ldo;
    var ccha_pal;
    var ccha_cant_pal;

    var cchb_cant_lib;
    var cchb_cant_acep;
    var cchb_cant_invo;
    var cchb_cant_ldo;
    var cchb_lib;
    var cchb_acep;
    var cchb_invo;
    var cchb_ldo;
    var cchb_pal;
    var cchb_cant_pal;


    var cchh_cant_lib;
    var cchh_cant_acep;
    var cchh_cant_invo;
    var cchh_cant_ldo;
    var cchh_lib;
    var cchh_acep;
    var cchh_invo;
    var cchh_ldo;
    var cchh_pal;
    var cchh_cant_pal;

    var ovo_cant_lib;
    var ovo_cant_acep;
    var ovo_cant_invo;
    var ovo_lib;
    var ovo_acep;
    var ovo_invo;
    var ovo_pal;
    var ovo_cant_pal;

    var cyo_lib;
    var cyo_cant_lib;
    var cyo_acep;
    var cyo_cant_acep;
    var cyo_invo;
    var cyo_cant_invo;
    var cyo_ldo;
    var cyo_cant_ldo;
    var cyo_pal;
    var cyo_cant_pal;


    cantidad_total_ccha = 0;
    cantidad_total_cchb = 0;
    cantidad_total_cchh = 0;
    cantidad_total_ovo = 0;
    cantidad_total_cyo = 0;
    var c = 0;
    var valores = '';
    var cantidad_excedida = 0;
    var tipoA = 0;
    var tipoB = 0;
    var tipoC = 0;
    var tipoD = 0;
    var tipoS = 0;
    var tipoJ = 0;
    cantidad_total = 0;
    filas.forEach(function (e)
    {
        var columnas = e.querySelectorAll("td");

        fecha_puesta = columnas[0].textContent.trim();
        tipo_huevo = columnas[1].textContent.trim();

        ccha_lib = parseInt(columnas[2].textContent);
        ccha_cant_lib = columnas[3].textContent.trim();
        ccha_acep = parseInt(columnas[4].textContent);
        ccha_cant_acep = columnas[5].textContent.trim();
        ccha_invo = parseInt(columnas[6].textContent);
        ccha_cant_invo = columnas[7].textContent.trim();
        ccha_ldo = parseInt(columnas[8].textContent);
        ccha_cant_ldo = columnas[9].textContent.trim();
        ccha_pal = parseInt(columnas[10].textContent);
        ccha_cant_pal = columnas[11].textContent.trim();




        cchb_lib = parseInt(columnas[12].textContent);
        cchb_cant_lib = columnas[13].textContent.trim();
        cchb_acep = parseInt(columnas[14].textContent);
        cchb_cant_acep = columnas[15].textContent.trim();
        cchb_invo = parseInt(columnas[16].textContent);
        cchb_cant_invo = columnas[17].textContent.trim();
        cchb_ldo = parseInt(columnas[18].textContent);
        cchb_cant_ldo = columnas[19].textContent.trim();
        cchb_pal = parseInt(columnas[20].textContent);
        cchb_cant_pal = columnas[21].textContent.trim();

        cchh_lib = parseInt(columnas[22].textContent);
        cchh_cant_lib = columnas[23].textContent.trim();
        cchh_acep = parseInt(columnas[24].textContent);
        cchh_cant_acep = columnas[25].textContent.trim();
        cchh_invo = parseInt(columnas[26].textContent);
        cchh_cant_invo = columnas[27].textContent.trim();
        cchh_ldo = parseInt(columnas[28].textContent);
        cchh_cant_ldo = columnas[29].textContent.trim();
        cchh_pal = parseInt(columnas[30].textContent);
        cchh_cant_pal = columnas[31].textContent.trim();

        ovo_lib = parseInt(columnas[32].textContent);
        ovo_cant_lib = columnas[33].textContent.trim();
        ovo_acep = parseInt(columnas[34].textContent);
        ovo_cant_acep = columnas[35].textContent.trim();
        ovo_invo = parseInt(columnas[36].textContent);
        ovo_cant_invo = columnas[37].textContent.trim();
        ovo_pal = parseInt(columnas[38].textContent);
        ovo_cant_pal = columnas[39].textContent.trim();

        cyo_lib = parseInt(columnas[40].textContent);
        cyo_cant_lib = columnas[41].textContent.trim();
        cyo_acep = parseInt(columnas[42].textContent);
        cyo_cant_acep = columnas[43].textContent.trim();
        cyo_invo = parseInt(columnas[44].textContent);
        cyo_cant_invo = columnas[45].textContent.trim();
        cyo_ldo = parseInt(columnas[46].textContent);
        cyo_cant_ldo = columnas[47].textContent.trim();
        cyo_pal = parseInt(columnas[48].textContent);
        cyo_cant_pal = columnas[49].textContent.trim();


        if (String(ccha_cant_lib) === "") {
            ccha_cant_lib = "0";
        }
        if (String(ccha_cant_acep) === "") {
            ccha_cant_acep = "0";
        }
        if (String(ccha_cant_invo) === "") {
            ccha_cant_invo = "0";
        }
        if (String(ccha_cant_ldo) === "") {
            ccha_cant_ldo = "0";
        }
        if (String(ccha_cant_pal) === "") {
            ccha_cant_pal = "0";
        }

        if (String(cchb_cant_lib) === "") {
            cchb_cant_lib = "0";
        }
        if (String(cchb_cant_acep) === "") {
            cchb_cant_acep = "0";
        }
        if (String(cchb_cant_invo) === "") {
            cchb_cant_invo = "0";
        }
        if (String(cchb_cant_ldo) === "") {
            cchb_cant_ldo = "0";
        }
        if (String(cchb_cant_pal) === "") {
            cchb_cant_pal = "0";
        }


        if (String(cchh_cant_lib) === "") {
            cchh_cant_lib = "0";
        }
        if (String(cchh_cant_acep) === "") {
            cchh_cant_acep = "0";
        }
        if (String(cchh_cant_invo) === "") {
            cchh_cant_invo = "0";
        }
        if (String(cchh_cant_ldo) === "") {
            cchh_cant_ldo = "0";
        }
        if (String(cchh_cant_pal) === "") {
            cchh_cant_pal = "0";
        }

        if (String(ovo_cant_lib) === "") {
            ovo_cant_lib = "0";
        }
        if (String(ovo_cant_acep) === "") {
            ovo_cant_acep = "0";
        }
        if (String(ovo_cant_invo) === "") {
            ovo_cant_invo = "0";
        }

        if (String(ovo_cant_pal) === "") {
            ovo_cant_pal = "0";
        }

        if (String(cyo_cant_lib) === "") {
            cyo_cant_lib = "0";
        }
        if (String(cyo_cant_acep) === "") {
            cyo_cant_acep = "0";
        }
        if (String(cyo_cant_invo) === "") {
            cyo_cant_invo = "0";
        }
        if (String(cyo_cant_ldo) === "") {
            cyo_cant_ldo = "0";
        }
        if (String(cyo_cant_pal) === "") {
            cyo_cant_pal = "0";
        }
        var totales_areas = parseInt(ccha_cant_lib) + parseInt(ccha_cant_acep) +
                parseInt(ccha_cant_invo) + parseInt(ccha_cant_ldo) +
                parseInt(ccha_cant_pal) +
                parseInt(cchb_cant_lib) + parseInt(cchb_cant_acep) +
                parseInt(cchb_cant_invo) + parseInt(cchb_cant_ldo) +
                parseInt(cchb_cant_pal) +
                parseInt(cchh_cant_lib) + parseInt(cchh_cant_acep) +
                parseInt(cchh_cant_invo) + parseInt(cchh_cant_ldo) +
                parseInt(cchh_cant_pal) +
                parseInt(ovo_cant_lib) + parseInt(ovo_cant_acep) +
                parseInt(ovo_cant_invo) + parseInt(ovo_cant_pal) +
                parseInt(cyo_cant_lib) + parseInt(cyo_cant_acep) +
                parseInt(cyo_cant_invo) + parseInt(cyo_cant_ldo) +
                parseInt(cyo_cant_pal);

        switch (tipo_huevo.trim())
        {
            case "A":
                tipoA = parseInt(tipoA) + parseInt(totales_areas);
                break;
            case "B":
                tipoB = parseInt(tipoB) + parseInt(totales_areas);
                ;
                break;
            case "C":
                tipoC = parseInt(tipoC) + parseInt(totales_areas);
                break;
            case "D":
                tipoD = parseInt(tipoD) + parseInt(totales_areas);
                ;
                break;
            case "S":
                tipoS = parseInt(tipoS) + parseInt(totales_areas);
                ;
                break;
            case "J":
                tipoJ = parseInt(tipoJ) + parseInt(totales_areas);
                ;
                break;
        }

        if (ccha_cant_lib > 0 && ccha_cant_lib <= ccha_lib) {
            columnas[3].style.backgroundColor = 'blue';
        } else if (ccha_lib > 0 && ccha_cant_lib == 0) {
            columnas[3].style.backgroundColor = 'black';
        } else if (ccha_lib < ccha_cant_lib) {
            columnas[3].style.backgroundColor = 'red';
        }

        if (ccha_cant_acep > 0 && ccha_cant_acep <= ccha_acep) {
            columnas[5].style.backgroundColor = 'blue';
        } else if (ccha_acep > 0 && ccha_cant_acep == 0) {
            columnas[5].style.backgroundColor = 'black';
        } else if (ccha_acep < ccha_cant_acep) {
            columnas[5].style.backgroundColor = 'red';
        }

        if (ccha_cant_invo > 0 && ccha_cant_invo <= ccha_invo) {
            columnas[7].style.backgroundColor = 'blue';
        } else if (ccha_invo > 0 && ccha_cant_invo == 0) {
            columnas[7].style.backgroundColor = 'black';
        } else if (ccha_invo < ccha_cant_invo) {
            columnas[7].style.backgroundColor = 'red';
        }

        if (ccha_cant_ldo > 0 && ccha_cant_ldo <= ccha_ldo) {
            columnas[9].style.backgroundColor = 'blue';
        } else if (ccha_ldo > 0 && ccha_cant_ldo == 0) {
            columnas[9].style.backgroundColor = 'black';
        } else if (ccha_ldo < ccha_cant_ldo) {
            columnas[9].style.backgroundColor = 'red';
        }

        if (ccha_cant_pal > 0 && ccha_cant_pal <= ccha_pal) {
            columnas[11].style.backgroundColor = 'blue';
        } else if (ccha_pal > 0 && ccha_cant_pal == 0) {
            columnas[11].style.backgroundColor = 'black';
        } else if (ccha_pal < ccha_cant_pal) {
            columnas[11].style.backgroundColor = 'red';
        }

        /////////////////////////////////////       

        if (cchb_cant_lib > 0 && cchb_cant_lib <= cchb_lib) {
            columnas[13].style.backgroundColor = 'blue';
        } else if (cchb_lib > 0 && cchb_cant_lib == 0) {
            columnas[13].style.backgroundColor = 'green';
        } else if (cchb_lib < cchb_cant_lib) {
            columnas[13].style.backgroundColor = 'red';
        }

        if (cchb_cant_acep > 0 && cchb_cant_acep <= cchb_acep) {
            columnas[15].style.backgroundColor = 'blue';
        } else if (cchb_acep > 0 && cchb_cant_acep == 0) {
            columnas[15].style.backgroundColor = 'green';
        } else if (cchb_acep < cchb_cant_acep) {
            columnas[15].style.backgroundColor = 'red';
        }

        if (cchb_cant_invo > 0 && cchb_cant_invo <= cchb_invo) {
            columnas[17].style.backgroundColor = 'blue';
        } else if (cchb_invo > 0 && cchb_cant_invo == 0) {
            columnas[17].style.backgroundColor = 'green';
        } else if (cchb_invo < cchb_cant_invo) {
            columnas[17].style.backgroundColor = 'red';
        }

        if (cchb_cant_ldo > 0 && cchb_cant_ldo <= cchb_ldo) {
            columnas[19].style.backgroundColor = 'blue';
        } else if (cchb_ldo > 0 && cchb_cant_ldo == 0) {
            columnas[19].style.backgroundColor = 'green';
        } else if (cchb_ldo < cchb_cant_ldo) {
            columnas[19].style.backgroundColor = 'red';
        }

        if (cchb_cant_pal > 0 && cchb_cant_pal <= cchb_pal) {
            columnas[21].style.backgroundColor = 'blue';
        } else if (cchb_pal > 0 && cchb_cant_pal == 0) {
            columnas[21].style.backgroundColor = 'green';
        } else if (cchb_pal < cchb_cant_pal) {
            columnas[21].style.backgroundColor = 'red';
        }


        //////////////////////

        if (cchh_cant_lib > 0 && cchh_cant_lib <= cchh_lib) {
            columnas[23].style.backgroundColor = 'blue';
        } else if (cchh_lib > 0 && cchh_cant_lib == 0) {
            columnas[23].style.backgroundColor = 'black';
        } else if (cchh_lib < cchh_cant_lib) {
            columnas[23].style.backgroundColor = 'red';
        }
        if (cchh_cant_acep > 0 && cchh_cant_acep <= cchh_acep) {
            columnas[25].style.backgroundColor = 'blue';
        } else if (cchh_acep > 0 && cchh_cant_acep == 0) {
            columnas[25].style.backgroundColor = 'black';
        } else if (cchh_acep < cchh_cant_acep) {
            columnas[25].style.backgroundColor = 'red';
        }
        if (cchh_cant_invo > 0 && cchh_cant_invo <= cchh_invo) {
            columnas[27].style.backgroundColor = 'blue';
        } else if (cchh_invo > 0 && cchh_cant_invo == 0) {
            columnas[27].style.backgroundColor = 'black';
        } else if (cchh_invo < cchh_cant_invo) {
            columnas[27].style.backgroundColor = 'red';
        }




        if (cchh_cant_ldo > 0 && cchh_cant_ldo <= cchh_ldo) {
            columnas[29].style.backgroundColor = 'blue';
        } else if (cchh_ldo > 0 && cchh_cant_ldo == 0) {
            columnas[29].style.backgroundColor = 'black';
        } else if (cchh_ldo < cchh_cant_ldo) {
            columnas[29].style.backgroundColor = 'red';
        }

        if (cchh_cant_pal > 0 && cchh_cant_pal <= cchh_pal) {
            columnas[31].style.backgroundColor = 'blue';
        } else if (cchh_pal > 0 && cchh_cant_pal == 0) {
            columnas[31].style.backgroundColor = 'black';
        } else if (cchh_pal < cchh_cant_pal) {
            columnas[31].style.backgroundColor = 'red';
        }

        ///////////////////////////////////////       
        if (ovo_cant_lib > 0 && ovo_cant_lib <= ovo_lib) {
            columnas[33].style.backgroundColor = 'blue';
        } else if (ovo_lib > 0 && ovo_cant_lib == 0) {
            columnas[33].style.backgroundColor = 'green';
        } else if (ovo_lib < ovo_cant_lib) {
            columnas[33].style.backgroundColor = 'red';
        }

        if (ovo_cant_acep > 0 && ovo_cant_acep <= ovo_acep) {
            columnas[35].style.backgroundColor = 'blue';
        } else if (ovo_acep > 0 && ovo_cant_acep == 0) {
            columnas[35].style.backgroundColor = 'green';
        } else if (ovo_acep < ovo_cant_acep) {
            columnas[35].style.backgroundColor = 'red';
        }

        if (ovo_cant_invo > 0 && ovo_cant_invo <= ovo_invo) {
            columnas[37].style.backgroundColor = 'blue';
        } else if (ovo_invo > 0 && ovo_cant_invo == 0) {
            columnas[37].style.backgroundColor = 'green';
        } else if (ovo_invo < ovo_cant_invo) {
            columnas[37].style.backgroundColor = 'red';
        }
        if (ovo_cant_pal > 0 && ovo_cant_pal <= ovo_pal) {
            columnas[39].style.backgroundColor = 'blue';
        } else if (ovo_pal > 0 && ovo_cant_pal == 0) {
            columnas[39].style.backgroundColor = 'green';
        } else if (ovo_pal < ovo_cant_pal) {
            columnas[39].style.backgroundColor = 'red';
        }
        //////////////////////////////////////////////////////////////////////////////////////////           

        if (cyo_cant_lib > 0 && cyo_cant_lib <= cyo_lib) {
            columnas[41].style.backgroundColor = 'blue';
        } else if (cyo_lib > 0 && cyo_cant_lib == 0) {
            columnas[41].style.backgroundColor = 'black';
        } else if (cyo_lib < cyo_cant_lib) {
            columnas[41].style.backgroundColor = 'red';
        }

        if (cyo_cant_acep > 0 && cyo_cant_acep <= cyo_acep) {
            columnas[43].style.backgroundColor = 'blue';
        } else if (cyo_acep > 0 && cyo_cant_acep == 0) {
            columnas[43].style.backgroundColor = 'black';
        } else if (cyo_acep < cyo_cant_acep) {
            columnas[43].style.backgroundColor = 'red';
        }
        if (cyo_cant_invo > 0 && cyo_cant_invo <= cyo_invo) {
            columnas[45].style.backgroundColor = 'blue';
        } else if (cyo_invo > 0 && cyo_cant_invo == 0) {
            columnas[45].style.backgroundColor = 'black';
        } else if (cyo_invo < cyo_cant_invo) {
            columnas[45].style.backgroundColor = 'red';
        }

        if (cyo_cant_ldo > 0 && cyo_cant_ldo <= cyo_ldo) {
            columnas[47].style.backgroundColor = 'blue';
        } else if (cyo_ldo > 0 && cyo_cant_ldo == 0) {
            columnas[47].style.backgroundColor = 'black';
        } else if (cyo_ldo < cyo_cant_ldo) {
            columnas[47].style.backgroundColor = 'red';
        }

        if (cyo_cant_pal > 0 && cyo_cant_pal <= cyo_pal) {
            columnas[49].style.backgroundColor = 'blue';
        } else if (cyo_pal > 0 && ovo_cant_pal == 0) {
            columnas[49].style.backgroundColor = 'green';
        } else if (cyo_pal < ovo_cant_pal) {
            columnas[49].style.backgroundColor = 'red';
        }





        if (tipo == "2")
        {
            if (ccha_lib < ccha_cant_lib)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ccha_acep < ccha_cant_acep)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ccha_invo < ccha_cant_invo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ccha_ldo < ccha_cant_ldo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ccha_pal < ccha_cant_pal)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchb_lib < cchb_cant_lib)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchb_acep < cchb_cant_acep)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchb_invo < cchb_cant_invo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchb_ldo < cchb_cant_ldo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchb_pal < cchb_cant_pal)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchh_lib < cchh_cant_lib)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchh_acep < cchh_cant_acep)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchh_invo < cchh_cant_invo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchh_ldo < cchh_cant_ldo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cchh_pal < cchh_cant_pal)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ovo_lib < ovo_cant_lib)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ovo_acep < ovo_cant_acep)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ovo_invo < ovo_cant_invo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (ovo_pal < ovo_cant_pal)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            }
            /////////////////////////////////////////////////////

            else if (cyo_lib < cyo_cant_lib)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cyo_acep < cyo_cant_acep)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cyo_invo < cyo_cant_invo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cyo_ldo < cyo_cant_ldo)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            } else if (cyo_pal < cyo_cant_pal)
            {
                verificar_excedido_td = verificar_excedido_td * 0;
            }
            ///HACER MULTIPLICAR POR CERO, Y DESPUES FUERA DEL EACH, HACER UNA COMPARACION GLOBAL NOMAS YA.
        }

        cantidad_total = cantidad_total +
                parseInt(ccha_cant_lib) + parseInt(ccha_cant_acep) + parseInt(ccha_cant_invo) + parseInt(ccha_cant_ldo) + parseInt(ccha_cant_pal) +
                parseInt(cchb_cant_lib) + parseInt(cchb_cant_acep) + parseInt(cchb_cant_invo) + parseInt(cchb_cant_ldo) + parseInt(cchb_cant_pal) +
                parseInt(cchh_cant_lib) + parseInt(cchh_cant_acep) + parseInt(cchh_cant_invo) + parseInt(cchh_cant_ldo) + parseInt(cchh_cant_pal) +
                parseInt(ovo_cant_lib) + parseInt(ovo_cant_acep) + parseInt(ovo_cant_invo) + parseInt(ovo_cant_pal) +
                parseInt(cyo_cant_lib) + parseInt(cyo_cant_acep) + parseInt(cyo_cant_invo) + parseInt(cyo_cant_ldo) + parseInt(cyo_cant_pal);

        cantidad_total_ccha = cantidad_total_ccha + parseInt(ccha_cant_lib) + parseInt(ccha_cant_acep) + parseInt(ccha_cant_invo) + parseInt(ccha_cant_ldo) + parseInt(ccha_cant_pal);
        cantidad_total_cchb = cantidad_total_cchb + parseInt(cchb_cant_lib) + parseInt(cchb_cant_acep) + parseInt(cchb_cant_invo) + parseInt(cchb_cant_ldo) + parseInt(cchb_cant_pal);
        cantidad_total_cchh = cantidad_total_cchh + parseInt(cchh_cant_lib) + parseInt(cchh_cant_acep) + parseInt(cchh_cant_invo) + parseInt(cchh_cant_ldo) + parseInt(cchh_cant_pal);
        cantidad_total_ovo = cantidad_total_ovo + parseInt(ovo_cant_lib) + parseInt(ovo_cant_acep) + parseInt(ovo_cant_invo) + parseInt(ovo_cant_pal);
        cantidad_total_cyo = cantidad_total_cyo + parseInt(cyo_cant_lib) + parseInt(cyo_cant_acep) + parseInt(cyo_cant_invo) + parseInt(cyo_cant_ldo) + parseInt(cyo_cant_pal);
        if (ccha_cant_lib > 0)
        {
            if (ccha_cant_lib > ccha_lib) {
                cantidad_excedida++;
            }//FECHAPUESTA_TIPOHUEVO_CLASIFICADORA_TIPOLOTE_CANTIDAD_CARRITO_UMEDIDA
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHA&LIB&' + ccha_cant_lib + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ccha_cant_acep > 0)
        {
            if (ccha_cant_acep > ccha_acep) {
                cantidad_excedida++;
            }



            arr = fecha_puesta + '&' + tipo_huevo + '&CCHA&ACEP&' + ccha_cant_acep + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ccha_cant_invo > 0)
        {
            if (ccha_cant_invo > ccha_invo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHA&INVO&' + ccha_cant_invo + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ccha_cant_ldo > 0)
        {
            if (ccha_cant_ldo > ccha_ldo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHA&LDO&' + ccha_cant_ldo + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ccha_cant_pal > 0)
        {
            if (ccha_cant_pal > ccha_pal)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHA&PAL&' + ccha_cant_pal + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }


        if (cchb_cant_lib > 0)
        {
            if (cchb_cant_lib > cchb_lib)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHB&LIB&' + cchb_cant_lib + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchb_cant_acep > 0)
        {
            if (cchb_cant_acep > cchb_acep)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHB&ACEP&' + cchb_cant_acep + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchb_cant_invo > 0)
        {
            if (cchb_cant_invo > cchb_invo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHB&INVO&' + cchb_cant_invo + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchb_cant_ldo > 0)
        {
            if (cchb_cant_ldo > cchb_ldo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHB&LDO&' + cchb_cant_ldo + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }

        if (cchb_cant_pal > 0)
        {
            if (cchb_cant_pal > cchb_pal)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHB&PAL&' + cchb_cant_pal + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }

        if (cchh_cant_lib > 0)
        {
            if (cchh_cant_lib > cchh_lib)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHH&LIB&' + cchh_cant_lib + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchh_cant_acep > 0)
        {
            if (cchh_cant_acep > cchh_acep)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHH&ACEP&' + cchh_cant_acep + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchh_cant_invo > 0)
        {
            if (cchh_cant_invo > cchh_invo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHH&INVO&' + cchh_cant_invo + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchh_cant_ldo > 0)
        {
            if (cchh_cant_ldo > cchh_ldo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHH&LDO&' + cchh_cant_ldo + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cchh_cant_pal > 0)
        {
            if (cchh_cant_pal > cchh_pal)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CCHH&PAL&' + cchh_cant_pal + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ovo_cant_lib > 0)
        {
            if (ovo_cant_lib > ovo_lib)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&OVO&LIB&' + ovo_cant_lib + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ovo_cant_acep > 0)
        {
            if (ovo_cant_acep > ovo_acep)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&OVO&ACEP&' + ovo_cant_acep + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (ovo_cant_invo > 0)
        {
            if (ovo_cant_invo > ovo_invo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&OVO&INVO&' + ovo_cant_invo + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }

        if (ovo_cant_pal > 0)
        {
            if (ovo_cant_pal > ovo_pal)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&OVO&PAL&' + ovo_cant_pal + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        /////////////////////////////////////////////////////////////////////////////////////


        if (cyo_cant_lib > 0)
        {
            if (cyo_cant_lib > cyo_lib) {
                cantidad_excedida++;
            }//FECHAPUESTA_TIPOHUEVO_CLASIFICADORA_TIPOLOTE_CANTIDAD_CARRITO_UMEDIDA
            arr = fecha_puesta + '&' + tipo_huevo + '&CYO&LIB&' + cyo_cant_lib + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cyo_cant_acep > 0)
        {
            if (cyo_cant_acep > cyo_acep) {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CYO&ACEP&' + cyo_cant_acep + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cyo_cant_invo > 0)
        {
            if (cyo_cant_invo > cyo_invo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CYO&INVO&' + cyo_cant_invo + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cyo_cant_ldo > 0)
        {
            if (cyo_cant_ldo > cyo_ldo)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CYO&LDO&' + cyo_cant_ldo + "&0&ENTERO&LDO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }
        if (cyo_cant_pal > 0)
        {
            if (cyo_cant_pal > cyo_pal)
            {
                cantidad_excedida++;
            }
            arr = fecha_puesta + '&' + tipo_huevo + '&CYO&PAL&' + cyo_cant_pal + "&0&ENTERO&FCO";
            if (c == 0)
            {
                valores = arr;
            } else
            {
                valores = valores + ',' + arr;
            }
            c++;
        }


    });

    $('#txt_cargados').val(parseInt(cantidad_total) + parseInt(contador_mixto_pedido_log_ccha) + parseInt(contador_mixto_pedido_log_cchb) + parseInt(contador_mixto_pedido_log_cchh) + parseInt(contador_mixto_pedido_log_lavado) + parseInt(contador_mixto_pedido_log_cyo));
    $('#txt_restantes').val(parseInt($('#txt_cargados').val()) - parseInt($('#txt_disponibilidad').val()));


    calculo_mixto_enteros_pedidos();//AQUI SE REALIZA LA SUMA DE TODOS LOS SELECCIONADOS
    sumar_tipos_huevos(tipoA, tipoB, tipoC, tipoD, tipoS, tipoJ);


    if (tipo == '2') //TIPO 2 ES PARA REALIZAR EL REGISTRO.
    {
        if (verificar_excedido_td == 0) {
            aviso_generico(2, "cantidad no puede se mayor a la disponible")
        } else
        {
            if (parseInt($('#txt_disponibilidad').val()) < cantidad_total)
            {
                aviso_generico(2, "CANTIDAD SUPERADA");
            } else if (cantidad_total == 0)
            {
                aviso_generico(2, "DEBE INGRESAR CARROS")
            } else if (parseInt($('#txt_tipo_a').val()) != parseInt($('#txt_tipo_ac').val()) || parseInt($('#txt_tipo_b').val()) != parseInt($('#txt_tipo_bc').val())
                    || parseInt($('#txt_tipo_c').val()) != parseInt($('#txt_tipo_cc').val()) || parseInt($('#txt_tipo_d').val()) != parseInt($('#txt_tipo_dc').val())
                    || parseInt($('#txt_tipo_s').val()) != parseInt($('#txt_tipo_sc').val()) || parseInt($('#txt_tipo_j').val()) != parseInt($('#txt_tipo_jc').val())
                    || parseInt($('#txt_tipo_mixto').val()) != parseInt($('#txt_tipo_mixtoc').val()))
            {
                aviso_generico(2, "CANTIDADES DE TIPOS DE HUEVOS NO COINCIDEN CON LO SOLICITADO");
            } else if (parseInt($('#txt_disponibilidad').val()) == 0)
            {
                aviso_generico(2, "DEBE SELECCIONAR EL CAMION")

            } else if ($('#cbox_chofer').val() == "-")
            {
                aviso_generico(2, "DEBE SELECCIONAR EL CHOFER")
            } else if (parseInt($('#txt_disponibilidad').val()) > parseInt($('#txt_cargados').val()))
            {
                aviso_generico(2, "DEBE COMPLETAR LA CAPACIDAD DEL CAMION")
            } else
            {
                var arr = $('#cbox_camion').val().split("_");
                var codigo_camion = arr[1];

                if (generacion_pedido == 'EDITAR')
                {
                    registrar_pedido(codigo_camion, $('#txt_disponibilidad').val(), valores, 'DESEA MODIFICAR EL PEDIDO?', 'control_editar_pedido.jsp');
                } else
                {
                    registrar_pedido(codigo_camion, $('#txt_disponibilidad').val(), valores, 'DESEA GENERAR EL PEDIDO?', 'control_crear_pedido.jsp');
                }
            }
        }
    }

}

function separar_codigo_camion()
{
    var arr = $('#cbox_camion').val().split("_");
    var cantidad_camion = arr[0];

    $('#txt_disponibilidad').val(cantidad_camion);
}

function celda_editable_selectElement(el)
{
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
}

function aviso_generico(tipo, mensaje, formulario, celdas)
{
    if (tipo == "1") {
        swal.fire({
            type: 'success',
            text: mensaje,
            confirmButtonText: "CERRAR"
        });

        if (formulario == 'PEDIDOS') {
            $("#contenedor_principal").html("")
        } else if (formulario == 'ANULAR')
        {
            ir_pagina('contenedor_pedidos_generados_menu.jsp');
        } else if (formulario == 'FACTURA')
        {
            ir_pagina('contenedor_pedidos_facturar.jsp');
        }
    } else {
        swal.fire({
            type: 'error',
            html: mensaje,
            confirmButtonText: "CERRAR"
        });

        if (formulario == 'PEDIDOS') {
            actualizar_celdas(celdas);
        } else if (formulario == 'EDITAR') {
            actualizar_celdas(celdas);
        }


    }



}

function seleccionar_mixtos(cod_carrito)
{
    if ($("#" + cod_carrito).html() == "SELECCIONE")
    {
        $("#" + cod_carrito).removeClass('btn-dark ').addClass(' btn-primary  bg1 ')
        $("#" + cod_carrito).html("SELECCIONADO");
    } else
    {
        $("#" + cod_carrito).removeClass(' btn-primary bg1').addClass('btn-dark ')
        $("#" + cod_carrito).html("SELECCIONE");
    }

    contar_mixtos_seleccionados();

    var mixto_cargado = $('#txt_tipo_mixtoc').val();
    var mixto_ingresado = $('#txt_tipo_mixto').val();
    if (parseInt(mixto_cargado) > parseInt(mixto_ingresado))
    {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'red';
    } else if (parseInt(mixto_cargado) == parseInt(mixto_ingresado)) {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'black';
    } else
    {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'green';
    }
}

function contar_mixtos_seleccionados()
{
    contador_mixto_pedido_log = 0;
    var filas_pre = document.querySelectorAll("#tb_preembarque_mixto tbody tr");
    var verificar_excedido_td = 1;
    var carro = "";
    var boton = "";
    var area = "";
    var contenido_mixto = "";
    array_mixto_pedidos = "";
    var cantidad = 0;
    //SE INICIALIZAN LAS VARIABLES
    contador_mixto_pedido_log_ccha = 0;
    contador_mixto_pedido_log_cchb = 0;
    contador_mixto_pedido_log_cchh = 0;
    contador_mixto_pedido_log_lavado = 0;
    contador_mixto_pedido_log_cyo = 0;

    filas_pre.forEach(function (e)
    {
        var columnas_pre = e.querySelectorAll("td");
        carro = columnas_pre[0].textContent;
        area = columnas_pre[1].textContent;
        puesta = columnas_pre[2].textContent;
        boton = columnas_pre[4].textContent;

        if (boton.length == 15)//ES SELECCIONADO
        {
            cantidad++;
            if (cantidad == 1)
            {
                array_mixto_pedidos = puesta + "&-&" + area + "&LIB&0&" + carro + "&MIXTO&FCO";
            } else
            {
                array_mixto_pedidos = array_mixto_pedidos + "," + puesta + "&-&" + area + "&LIB&0&" + carro + "&MIXTO&FCO";
            }
            contador_mixto_pedido_log++;
            //       FECHAPUESTA_TIPOHUEVO_CLASIFICADORA_TIPOLOTE_CANTIDAD_CARRITO_UMEDIDA
            switch (area)
            {
                case "CCHA":
                    contador_mixto_pedido_log_ccha++;
                    break;
                case "CCHB":
                    contador_mixto_pedido_log_cchb++;
                    break;
                case "CCHH":
                    contador_mixto_pedido_log_cchh++;
                    break;
                case "CYO":
                    contador_mixto_pedido_log_cyo++;
                    break;
                default :
                    contador_mixto_pedido_log_lavado++;
                    break;
            }
        }
    });
    calculo_mixto_enteros_pedidos();
}

function calculo_mixto_enteros_pedidos()
{
    $('#td_ccha').html('CCHA  TOTAL CARGADOS:' + (parseInt(contador_mixto_pedido_log_ccha) + parseInt(cantidad_total_ccha)));
    $('#td_cchb').html('CCHB  TOTAL CARGADOS:' + (parseInt(contador_mixto_pedido_log_cchb) + parseInt(cantidad_total_cchb)));
    $('#td_cchh').html('CCHH  TOTAL CARGADOS:' + (parseInt(contador_mixto_pedido_log_cchh) + parseInt(cantidad_total_cchh)));
    $('#td_ovo').html('LAVADOS  TOTAL CARGADOS:' + (parseInt(contador_mixto_pedido_log_lavado) + parseInt(cantidad_total_ovo)));
    $('#td_cyo').html('DEPOSITO CYO TOTAL CARGADOS:' + (parseInt(contador_mixto_pedido_log_cyo) + parseInt(cantidad_total_cyo)));
    $('#txt_cargados').val(parseInt(cantidad_total) + parseInt(contador_mixto_pedido_log_ccha) + parseInt(contador_mixto_pedido_log_cchb) + parseInt(contador_mixto_pedido_log_cchh) + parseInt(contador_mixto_pedido_log_lavado) + parseInt(contador_mixto_pedido_log_cyo));


    var total_mixto_entero = parseInt(cantidad_total) + parseInt(contador_mixto_pedido_log_ccha) + parseInt(contador_mixto_pedido_log_cchb) + parseInt(contador_mixto_pedido_log_cchh) + parseInt(contador_mixto_pedido_log_lavado) + parseInt(contador_mixto_pedido_log_cyo);

    $('#txt_tipo_mixtoc').val(parseInt(contador_mixto_pedido_log_ccha) + parseInt(contador_mixto_pedido_log_cchb) + parseInt(contador_mixto_pedido_log_cchh) + parseInt(contador_mixto_pedido_log_lavado) + parseInt(contador_mixto_pedido_log_cyo));//TEXTO DEL INGRESADOR DE CANTIDADES TOTALES

    $('#txt_restantes').val(parseInt($('#txt_cargados').val()) - parseInt($('#txt_disponibilidad').val()));
    $('#txt_tipo_mixtof').val(parseInt($('#txt_tipo_mixto').val()) - parseInt($('#txt_tipo_mixtoc').val()));//TEXTO DEL INGRESADOR DE CANTIDADES TOTALES

    if (parseInt($('#txt_disponibilidad').val()) < total_mixto_entero)
    {
        $('#txt_cargados').css('background-color', 'red');
    } else if (parseInt($('#txt_disponibilidad').val()) == total_mixto_entero)
    {
        $('#txt_cargados').css('background-color', 'yellow');
    } else
    {
        $('#txt_cargados').css('background-color', 'green');
    }
}

function calculo_mixto_enteros_pedidos_cyo(area)
{
    $('#td_ccha').html(area + ' TOTAL CARGADOS:' + (parseInt(contador_mixto_pedido_log_ccha) + parseInt(cantidad_total_ccha)));

    $('#txt_cargados').val(parseInt(cantidad_total) + parseInt(contador_mixto_pedido_log_ccha));

    var total_mixto_entero = parseInt(cantidad_total) + parseInt(contador_mixto_pedido_log_ccha) + parseInt(contador_mixto_pedido_log_cchb) + parseInt(contador_mixto_pedido_log_cchh) + parseInt(contador_mixto_pedido_log_lavado);

    if (parseInt($('#txt_disponibilidad').val()) < total_mixto_entero)
    {
        $('#txt_cargados').css('background-color', 'red');
    } else if (parseInt($('#txt_disponibilidad').val()) == total_mixto_entero)
    {
        $('#txt_cargados').css('background-color', 'yellow');
    } else
    {
        $('#txt_cargados').css('background-color', 'green');
    }
}


function registrar_pedido(id_camion, cantidad_total, contenido, mensaje, pagina)
{
    var contenido_mixto = "";
    if (array_mixto_pedidos.length > 0)
    {
        contenido_mixto = "," + array_mixto_pedidos;
    }

    Swal.fire({

        title: 'CONFIRMACION',
        text: mensaje,
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: cruds + pagina,
                data: ({id_camion: id_camion, cantidad_total: cantidad_total, contenido: contenido + contenido_mixto, id_pedido: $('#id_pedido').val(), id_chofer: $('#cbox_chofer').val(), obs: $('#txt_obs').val()}),
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
                            }, 1000);
                        }
                    });
                },
                success: function (res)
                {
                    aviso_generico(res.tipo_respuesta, res.mensaje, 'PEDIDOS', res.carros_excedentes);
                }
                ,
                error: function (error)
                {
                    swal.fire({
                        type: 'error',
                        html: 'Ha ocurrido un error, intente de nuevo.',
                        confirmButtonText: "CERRAR"
                    });
                }
            });


        }
    });
}

function registrar_pedido_cyo(contenido, area)
{
    var contenido_mixto = "";
    if (array_mixto_pedidos.length > 0)
    {
        contenido_mixto = "," + array_mixto_pedidos;
    }

    Swal.fire({

        title: 'CONFIRMACION',
        text: 'DESEA MODIFICAR EL PEDIDO?',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: cruds + "control_editar_pedido_cyo.jsp",
                data: ({contenido: contenido, id_pedido: $('#id_pedido').val(), area: area}),
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
                            }, 1000);
                        }
                    });
                },
                success: function (res)
                {
                    aviso_generico(res.tipo_respuesta, res.mensaje, 'PEDIDOS');
                }
            });


        }
    });
}
function anular_pedido(id)
{
    Swal.fire({
        title: 'CONFIRMACION',
        text: "DESEA ANULAR EL PEDIDO?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'SI!',
        cancelButtonText: 'NO!'}).then((result) =>
    {
        if (result.value)
        {
            $.ajax({
                type: "POST",
                url: cruds + 'control_anular_pedido.jsp',
                data: ({id: id}),
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
                            }, 1000);
                        }
                    });
                },
                success: function (res)
                {
                    aviso_generico(res.tipo_respuesta, res.mensaje, 'ANULAR')

                }
            });


        }
    });
}

function reset_cero_variables()
{
    contador_mixto_pedido_log_ccha = 0;
    contador_mixto_pedido_log_cchb = 0;
    contador_mixto_pedido_log_cchh = 0;
    contador_mixto_pedido_log_lavado = 0;
    array_mixto_pedidos = "";
    cantidad_total_ccha = 0;
    cantidad_total_cchb = 0;
    cantidad_total_cchh = 0;
    cantidad_total_ovo = 0;
    cantidad_total = 0;
}

function registrar_factura(id)
{
    var html;
    html = "   <form id='form_cuadro_facturas'>   \n\
                        <div id='combo' class='form - group'> <a></a>\n\
                            <select  name = 'cbox_factura' id='cbox_factura' class='form - control'    required>\n\
                            </select ><br><br>\n\
                        </div > \n\
                         <br><br><br><input type='submit' style='font-weight:bold'  value='REGISTRAR' class='form-control bg-success btn color_letra' >  \n\
                    </form> ";
    Swal.fire({
        title: 'Registrar factura al pedido',
        // text: "",
        type: 'warning',
        html: html,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        showCancelButton: false,
        showConfirmButton: false
    });

    $.get(ruta_consultas + 'consulta_option_facturas.jsp', function (res)
    {
        $("#cbox_factura").html(res.mensaje);
        $('#form_cuadro_facturas').on('submit', function (e)
        {
            e.preventDefault();
            $.ajax({
                type: "POST",
                url: cruds + 'control_confirmar_factura.jsp',
                data: $("#form_cuadro_facturas").serialize() + "&id=" + id,
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
                            }, 1000);
                        }
                    });
                },
                success: function (res)
                {
                    aviso_generico(res.tipo_respuesta, res.mensaje, 'FACTURA');
                }
            });
            e.stopPropagation();
        });
    });
}

function actualizar_celdas(celdas) {
    var split_celdas = celdas.split("&");
    var split_valores = "";
    for (i = 0; i < split_celdas.length; i++)
    {
        split_valores = split_celdas[i].split(",");
        for (c = 0; c < split_valores.length; c++)
        {
            $('.' + split_valores[0].trim()).html(split_valores[1]);
        }
    }
    obtener_valores_celda('1');

}


function cargar_cantidades() {

    $.ajax({
        type: "POST",
        url: ruta_consultas + 'test_carga.jsp',
        data: ({

            A: $('#txt_tipo_a').val(), B: $('#txt_tipo_b').val(), C: $('#txt_tipo_c').val(), D: $('#txt_tipo_d').val(), S: $('#txt_tipo_s').val(), J: $('#txt_tipo_j').val(),
            AC: $('#txt_tipo_ac').val(), BC: $('#txt_tipo_bc').val(), CC: $('#txt_tipo_cc').val(), DC: $('#txt_tipo_dc').val(), SC: $('#txt_tipo_sc').val(), JC: $('#txt_tipo_jc').val()

        }),
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            $('#txt_tipo_a').val(res.A);
            $('#txt_tipo_b').val(res.B);
            $('#txt_tipo_c').val(res.C);
            $('#txt_tipo_d').val(res.D);
            $('#txt_tipo_s').val(res.S);
            $('#txt_tipo_j').val(res.J);

            $('#txt_tipo_ac').val(res.AC);
            $('#txt_tipo_bc').val(res.BC);
            $('#txt_tipo_cc').val(res.CC);
            $('#txt_tipo_dc').val(res.DC);
            $('#txt_tipo_sc').val(res.SC);
            $('#txt_tipo_jc').val(res.JC);

        }
    });
}

function consultar_cantidades() {

    $.ajax({
        type: "POST",
        url: ruta_consultas + 'test.jsp',
        //  data:({A:$('#txt_tipo_a').val(),B:$('#txt_tipo_b').val(),C:$('#txt_tipo_c').val(),D:$('#txt_tipo_d').val(),S:$('#txt_tipo_s').val(),J:$('#txt_tipo_j').val()}),  
        beforeSend: function ()
        {
        },
        success: function (res)
        {
            $('#txt_tipo_a').val(res.A);
            $('#txt_tipo_b').val(res.B);
            $('#txt_tipo_c').val(res.C);
            $('#txt_tipo_d').val(res.D);
            $('#txt_tipo_s').val(res.S);
            $('#txt_tipo_j').val(res.J);

            $('#txt_tipo_ac').val(res.AC);
            $('#txt_tipo_bc').val(res.BC);
            $('#txt_tipo_cc').val(res.CC);
            $('#txt_tipo_dc').val(res.DC);
            $('#txt_tipo_sc').val(res.SC);
            $('#txt_tipo_jc').val(res.JC);
            $('#txt_tipo_ac').bind('DOMSubtreeModified', function () {
                console.log('changed');
            });

        }
    });
}

function sumar_tipos_huevos(tipoA, tipoB, tipoC, tipoD, tipoS, tipoJ) {

    $('#txt_tipo_ac').val(tipoA);
    $('#txt_tipo_bc').val(tipoB);
    $('#txt_tipo_cc').val(tipoC);
    $('#txt_tipo_dc').val(tipoD);
    $('#txt_tipo_sc').val(tipoS);
    $('#txt_tipo_jc').val(tipoJ);

    var A = $('#txt_tipo_a').val();
    var B = $('#txt_tipo_b').val();
    var C = $('#txt_tipo_c').val();
    var D = $('#txt_tipo_d').val();
    var S = $('#txt_tipo_s').val();
    var J = $('#txt_tipo_j').val();

    $('#txt_tipo_af').val((parseInt(A) - parseInt(tipoA)));
    $('#txt_tipo_bf').val((parseInt(B) - parseInt(tipoB)));
    $('#txt_tipo_cf').val((parseInt(C) - parseInt(tipoC)));
    $('#txt_tipo_df').val((parseInt(D) - parseInt(tipoD)));
    $('#txt_tipo_sf').val((parseInt(S) - parseInt(tipoS)));
    $('#txt_tipo_jf').val((parseInt(J) - parseInt(tipoJ)));

    var ac = tipoA;
    var bc = tipoB;
    var cc = tipoC;
    var dc = tipoD;
    var sc = tipoS;
    var jc = tipoJ;

    if (parseInt(ac) > parseInt(A))
    {
        document.getElementById('txt_tipo_ac').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_ac').style.color = 'white';
    } else if (parseInt(ac) == parseInt(A)) {
        document.getElementById('txt_tipo_ac').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_ac').style.color = 'white';

    } else
    {
        $("#txt_tipo_ac").attr('style', 'background-color:green');
        // document.getElementById('txt_tipo_ac').style.backgroundColor = 'green';        
    }
    if (parseInt(bc) > parseInt(B))
    {
        document.getElementById('txt_tipo_bc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_bc').style.color = 'white';

    } else if (parseInt(bc) == parseInt(B)) {
        document.getElementById('txt_tipo_bc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_bc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_bc').style.backgroundColor = 'green';
    }
    if (parseInt(cc) > parseInt(C))
    {
        document.getElementById('txt_tipo_cc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_cc').style.color = 'white';

    } else if (parseInt(cc) == parseInt(C)) {
        document.getElementById('txt_tipo_cc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_cc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_cc').style.backgroundColor = 'green';
    }
    if (parseInt(dc) > parseInt(D))
    {
        document.getElementById('txt_tipo_dc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_dc').style.color = 'white';
    } else if (parseInt(dc) == parseInt(D)) {
        document.getElementById('txt_tipo_dc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_dc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_dc').style.backgroundColor = 'green';
    }
    if (parseInt(sc) > parseInt(S))
    {
        document.getElementById('txt_tipo_sc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_sc').style.color = 'white';
    } else if (parseInt(sc) == parseInt(S)) {
        document.getElementById('txt_tipo_sc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_sc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_sc').style.backgroundColor = 'green';
    }
    if (parseInt(jc) > parseInt(J))
    {
        document.getElementById('txt_tipo_jc').style.backgroundColor = 'red';
        document.getElementById('txt_tipo_jc').style.color = 'white';
    } else if (parseInt(jc) == parseInt(J)) {
        document.getElementById('txt_tipo_jc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_jc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_jc').style.backgroundColor = 'green';
    }

    var mixto_cargado = $('#txt_tipo_mixtoc').val();
    var mixto_ingresado = $('#txt_tipo_mixto').val();

    if (parseInt(mixto_cargado) > parseInt(mixto_ingresado))
    {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'red';
    } else if (parseInt(mixto_cargado) == parseInt(mixto_ingresado)) {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'black';
        document.getElementById('txt_tipo_mixtoc').style.color = 'white';
    } else
    {
        document.getElementById('txt_tipo_mixtoc').style.backgroundColor = 'green';
    }


}

function seleccionar_todo_input()
{
    $("input").blur(function ()
    {
        if ($(this).attr("data-selected-all"))
        {
            $(this).removeAttr("data-selected-all");
        }
    });

    $("input").click(function ()
    {
        if (!$(this).attr("data-selected-all")) {
            try {
                $(this).selectionStart = 0;
                $(this).selectionEnd = $(this).value.length + 1;
                //add atribute allowing normal selecting post focus
                $(this).attr("data-selected-all", true);
            } catch (err) {
                $(this).select();
                //add atribute allowing normal selecting post focus
                $(this).attr("data-selected-all", true);
            }
        }
    });
}

function cargar_cantidades_ingresadas_editar(tipo)
{
    if (tipo == 2)
    {
        $('#txt_tipo_a').val($('#txt_tipo_ac').val());
        $('#txt_tipo_b').val($('#txt_tipo_bc').val());
        $('#txt_tipo_c').val($('#txt_tipo_cc').val());
        $('#txt_tipo_d').val($('#txt_tipo_dc').val());
        $('#txt_tipo_s').val($('#txt_tipo_sc').val());
        $('#txt_tipo_j').val($('#txt_tipo_jc').val());
        $('#txt_tipo_mixto').val($('#txt_tipo_mixtoc').val());
    }

}




function filtro_reporte(tipo) {
    switch (tipo)
    {
        case "7":
            $("#contenedor_fechas").show();
            break;
        case "1":
            $("#contenedor_fechas").hide();
            break;
        case "2":
            $("#contenedor_fechas").hide();
            break;
        case "5":
            $("#contenedor_fechas").show();
            break;

    }

}

function buscar_reporte() {


    $.ajax({
        type: "POST",
        url: ruta_consultas + 'generar_grilla_reportes.jsp',
        data: ({estado: $('#cbox_tipo').val(), fecha_desde: $('#desde').val(), fecha_hasta: $('#hasta').val()}),
        beforeSend: function ()
        {
            cargar_load("Consultando..");
            $('#div_grilla').html("");
        },
        success: function (res)
        {
            $('#div_grilla').html(res.grilla);
            cerrar_load();
        },
        error: function (error)
        {
            cerrar_load();
        }
    });

}


function solo_numeros_td() {

    $(".single_line").keydown(function (e)
    {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 || ((e.keyCode == 65 || e.keyCode == 86 || e.keyCode == 67) && (e.ctrlKey === true || e.metaKey === true)) || (e.keyCode >= 35 && e.keyCode <= 40))
        {
            return;
        }
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105))
        {
            e.preventDefault();
        }
        if (cont_filtro == 0) {
            $('input[type=search]').addClass('celdas');
            $(".celdas").keyup(function (event) // AL BUSCADOR DEL DATATABLE LE HAGO QUE AL TIPEAR CALCULE DE VUELTA TODAS LAS CELDAS
            {
                obtener_valores_celda('1');
            });
        }

        cont_filtro++;
    });
}
    
    
