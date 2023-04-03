var ruta_contenedores_ptc = "./contenedores/ptc/",
        ruta_controles_ptc = "./cruds/ptc/",
        ruta_grillas_ptc = "./grillas/ptc/",
        ruta_consultas_ptc = "./consultas/ptc/";
function comprobar_clasificadora() {
    var e = $("#clasificadora_menu").val();
    ("O" != e && "C" != e) || ($("#div_aviarios").hide(), $("#cbox_aviarios").removeAttr("required"));
}
function ir_transferencia_menu() {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_transferencia.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_transferencia(e) {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + e + ".jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $.get(ruta_consultas_ptc + "consulta_fecha.jsp", function (e) {
                        $("#fecha").val(e.fecha);
                    }),
                    $("#contenedor_principal").show(),
                    cerrar_load(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy");
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_agregar_motivo_retencion() {
    window.location.hash = "ptcMotivoRetencion";
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_motivo_retencion.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    $("#chkToggle2").bootstrapToggle(),
                    $("#chkToggle_especial").bootstrapToggle(),
                    cargar_toggles(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    inicializar_unidad_medida_PTC(),
                    $("#grilla_lotes_liberacion").DataTable({scrollX: true, pageLength: 100, language: {sUrl: "js/Spanish.txt"}}),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_modificacion_lotes_ptc() {
    
    window.location.hash = "panelModifLotes";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_reemplazo_motivos.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), ir_grilla_retenidos_panel(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_reporte_historico_lotes_ptc() {
    window.location.hash = "panelReporteHist";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_reporte_retenidos_historico.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_configuracion_empacadora() {
    window.location.hash = "ptcConfiguracionEmp";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_empacadora.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), ir_grilla_empacadoras(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_cambio_fp_ptc() {
    window.location.hash = "panelCambioFp";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_cambio_fp.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_cambio_nro_ptc() {
    window.location.hash = "panelCambioNro";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_cambio_nro_ptc.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_transformacion_ptc() {
    window.location.hash = "panelTransformacionCarro";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_transformacion_PTC.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_transformacion_pallet_carro() {
    window.location.hash = "ptcTransformacionPallet";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_transformacion_pallet_carro.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_grilla_retenidos_panel() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_retenidos_panel.jsp",
        beforeSend: function () {
            cargar_load();
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#div_grilla").html(e), $("#grilla_lotes_motivos").DataTable({scrollX: !0, pageLength: 100, language: {sUrl: "js/Spanish.txt"}}), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_reportes_varios() {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_menu_reporte.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html(""), $("#contenido").html(""), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenido").html(e), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_liberados_viejo() {
    window.location.hash = "panelLiberadosViejos";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro_liberados_viejos.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) 
        {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    $(".checkbox").bootstrapToggle(),
                    $(".dtBox").DateTimePicker(),
                    cargar_toggles(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    inicializar_unidad_medida_PTC(),
                    (document.getElementById("boxColor").style.backgroundColor = "lightblue"),
                    (document.getElementById("boxColor_red").style.backgroundColor = "green"),
                    $("#formulario").on("submit", function (e) 
            {
                e.preventDefault(), 
                        procesar_PTC("control_registro_costeado"),
                e.stopPropagation();
            }),
                    $("#txt_fecha_involucrada").multiDatesPicker({dateFormat: "yy/mm/dd"}),
                    comprobar_clasificadora(),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_registro_carros_alimentados() {
    window.location.hash = "pprRegistroCarros";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro_alimentados.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    $(".checkbox").bootstrapToggle(),
                    $(".dtBox").DateTimePicker(),
                    cargar_toggles(),
                    cargar_estilo_calendario_insert("yyyy/mm/dd"),
                    inicializar_unidad_medida_PTC(),
                    (document.getElementById("boxColor").style.backgroundColor = "lightblue"),
                    (document.getElementById("boxColor_red").style.backgroundColor = "green"),
                    (document.getElementById("contenedor_alimentacion").style.backgroundColor = "red"),
                    $("#formulario").on("submit", function (e) {
                e.preventDefault(), procesar_carro_alimentado(), e.stopPropagation();
            }),
                    $("#txt_fecha_involucrada").multiDatesPicker({dateFormat: "yy/mm/dd"}),
                    comprobar_clasificadora(),
                    cerrar_load(),
                    $(document).on("click", ".borrar", function (e) {
                e.preventDefault(), $(this).closest("tr").remove();
            });
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_registro_reprocesos_lista_ptc() {
    window.location.hash = "cyoRegistroReproc";
    $.ajax({
        type: "POST",
       // url: ruta_contenedores_ptc + "contenedor_registro_reprocesos.jsp",
        url: ruta_contenedores_ptc + "contenedor_registro_reprocesos_lista.jsp",
        beforeSend: function () {
            cargar_load(),
            $("#contenedor_principal").html("");
        },
        success: function (e) {
              $("#contenedor_principal").html(e), 
                $("#contenedor_principal").show(), 
                cerrar_load();
                //generar_boton_reproceso_ptc();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}

function ir_registro_reprocesos_ptc(id) {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro_reprocesos.jsp?id="+id,
        beforeSend: function () 
        {
            cargar_load(),
            $("#contenedor_principal").html("");
        },
        success: function (e) 
        {
            $("#contenedor_principal").html(e), 
            $("#contenedor_principal").show(), 
            $("#id").val(id), 
            
            cerrar_load();
            generar_boton_reproceso_ptc(id);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}


function generar_boton_reproceso_ptc(id) {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ptc + "generar_btn_reprocesar.jsp?id="+id,
        beforeSend: function () {},
        success: function (e) {
            $("#contenedor_boton").html(e.boton);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function registrar_reproceso_ptc(e) {
    var t = "DESEA INICIAR LA ALIMENTACION?",
            o = "",
            r = 1;
    if (2 == e) 
    {
        t = "DESEA FINALIZAR LA ALIMENTACION?";
        var a = document.querySelectorAll("#grilla_transfer tbody tr");
        (jsonObj = []),
                (r = 0),
                a.forEach(function (e) {
                    var t = e.querySelectorAll("td");
                    (item = {}), (item.cod_interno = t[0].textContent), (item.cod_carrito = t[1].textContent), 
                    (item.cantidad = t[2].textContent), (item.tipo_huevo = t[6].textContent), jsonObj.push(item), 
                    r++;
                }),
                (o = JSON.stringify(jsonObj));
    }
    r >= 1
            ? Swal.fire({title: t, type: "warning", showCancelButton: !0, confirmButtonColor: "#3085d6", cancelButtonColor: "#d33", 
                confirmButtonText: "REGISTRAR", cancelButtonText: "CANCELAR"}).then((t) => {
        t.value &&
                $.ajax({
                    type: "POST",
                    url: ruta_controles_ptc + "control_aper_cierre_reproceso.jsp",
                    data: {registro: e, jsonObj: o,id_cab:$("#id").val()},
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                             
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (e) {
                        1 == e.tipo_respuesta
                                ? (
                                        swal.fire({type: "success", title: e.mensaje, confirmButtonText: "CERRAR"}),generar_boton_reproceso_ptc(e.id_cab),$("#id").val(e.id_cab)
                                   )
                                : 2 == e.tipo_respuesta
                                ? (swal.fire({type: "success", title: e.mensaje, confirmButtonText: "CERRAR"}), ir_registro_reprocesos_lista_ptc())
                                : swal.fire({type: "error", title: e.mensaje, confirmButtonText: "CERRAR"});
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });
    })
            : swal.fire({type: "error", title: "ERROR, NO SE INGRESARON DATOS.", confirmButtonText: "CERRAR"});
}
function agregar_fila_alimentacion_ptc(e, t) {
    0 == e.length || 0 == t.length
            ? alert("DEBE LLENAR TODOS LOS CAMPOS REQUERIDOS")
            : ($("#grilla_reposicion")
                    .find("tbody")
                    .append("<tr><td>" + e + "</td><td>" + t + "</td><td><input type='button' value='Eliminar' class='borrar'></td></tr>"),
                    $("#txt_cantidad_reposicion").val(""),
                    $("#txt_fp_reposicion").val(""));
}
function registrar_lotes_con_alimentacion() {
    var e,
            t,
            o = 0,
            r = "";
    document.querySelectorAll("#grilla_reposicion tbody tr").forEach(function (a) {
        var n = a.querySelectorAll("td");
        (t = parseInt(n[0].textContent)), (e = n[1].textContent), (r = 0 == o ? t + "&" + e : r + "," + t + "&" + e), o++;
    }),
            $("#txt_lotes_reposicionados").val(r);
}
function traer_registro_lib() {
    window.location.hash = "ptcRegistroLib";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    $(".checkbox").bootstrapToggle(),
                     //$(".dtBox").DateTimePicker(),
                    formato_hora_input();
                    cargar_toggles(),
                    cargar_estilo_calendario_insert("yyyy/mm/dd"),
                    inicializar_unidad_medida_PTC(),
                    (document.getElementById("boxColor").style.backgroundColor = "lightblue"),
                    (document.getElementById("boxColor_red").style.backgroundColor = "green"),
                    $("#formulario").on("submit", function (e) {
                e.preventDefault(), procesar_PTC("control_registro"), e.stopPropagation();
            }),
                    $("#txt_fecha_involucrada").multiDatesPicker({dateFormat: "yy/mm/dd"}),
                    comprobar_clasificadora(),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_registro_retenido() {
    window.location.hash = "ptcRegistroRetenido";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro_retenido.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    $(".checkbox").bootstrapToggle(),
                    formato_hora_input();
                    (document.getElementById("boxColor").style.backgroundColor = "lightblue"),
                    (document.getElementById("boxColor_red").style.backgroundColor = "green"),
                    cargar_toggles(),
                    cargar_estilo_calendario_insert("yyyy/mm/dd"),
                    $("#formulario").on("submit", function (e) {
                e.preventDefault(), procesar_PTC("control_retenidos"), e.stopPropagation();
            }),
                    $("#txt_fecha_involucrada").multiDatesPicker({dateFormat: "yy/mm/dd"}),
                    comprobar_clasificadora(),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_registro_SC() {
    window.location.hash = "ptcRegistroSC";
    cargar_load(),
            $.ajax({
                type: "POST",
                url: ruta_contenedores_ptc + "contenedor_registro_SC.jsp",
                beforeSend: function () {
                    $("#contenedor_principal").html("");
                },
                success: function (e) {
                    $("#div_cargar_menu").hide(),
                            $("#contenedor_principal").html(e),
                            $("#contenedor_principal").show(),
                            $(".checkbox").bootstrapToggle(),
                            formato_hora_input();
                            (document.getElementById("boxColor").style.backgroundColor = "lightblue"),
                            (document.getElementById("boxColor_red").style.backgroundColor = "green"),
                            cargar_toggles(),
                            cargar_estilo_calendario_insert("yyyy/mm/dd"),
                            $("#formulario").on("submit", function (e) {
                        e.preventDefault(), procesar_sc(), e.stopPropagation();
                    }),
                            $("#txt_fecha_involucrada").multiDatesPicker({dateFormat: "yy/mm/dd"}),
                            comprobar_clasificadora(),
                            $("#chkToggletiporeco").change(function () {
                        1 == $(this).prop("checked") ? $("#tipo_reco").val("MANUAL") : $("#tipo_reco").val("MAQUINA");
                    }),
                            cerrar_load();
                },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
            });
}
function traer_registro_retenido_costeado() {
    window.location.hash = "panelRegistroRetenidos";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro_retenido_costeados.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    $(".checkbox").bootstrapToggle(),
                    $(".dtBox").DateTimePicker(),
                    (document.getElementById("boxColor").style.backgroundColor = "lightblue"),
                    cargar_toggles(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    $("#formulario").on("submit", function (e) {
                e.preventDefault(), procesar_PTC("control_retenidos_costeados"), e.stopPropagation();
            }),
                    comprobar_clasificadora(),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
 function validar_fechaInicial_fechaFinal ()
    {
         $('#cbox_aviarios').html('');  
        var fecha_clasificacion_inicial=$('#calendario_registro').val();
        var fecha_clasificacion_final=$('#fecha_clas_final').val();
        var hora_inicial=$('#hora_desde').val();
        var hora_final=$('#hora_hasta').val();
     /*   var date_inicial=new Date(fecha_clasificacion_inicial+' '+hora_inicial+':00') ;
        var date_final=new Date(fecha_clasificacion_final+' '+hora_final+':00') ; 
       */
        var date_inicial_consulta= fecha_clasificacion_inicial+' '+hora_inicial+':59.000';
        var date_final_consulta= fecha_clasificacion_final+' '+hora_final+':00.000';
        
     var date_inicial=new Date(date_inicial_consulta) ;
        var date_final=new Date(date_final_consulta) ; 
       
   
        
        if(fecha_clasificacion_inicial.length>0&&fecha_clasificacion_final.length>0&&hora_inicial.length>0&&hora_final.length>0)
        {
            if(date_inicial>date_final)
            {
               swal.fire({
                        type: 'error',
                        title: "FECHA DE CLASIFICACION INICIAL NO PUEDE SER MAYOR A LA FINAL.!!!",
                        confirmButtonText: "CERRAR"
                        });  
                $('#fecha_clas_final').val('');
               
            }
            else 
            {
                 $.get(ruta_consultas_ptc+'consulta_aviarios_hora.jsp',{fecha_inicio:date_inicial_consulta,fecha_final:date_final_consulta},function(res)
                {
                  $('#cbox_aviarios').html(res.aviarios);  
                }); 
            }
        }
    }

function ir_movimiento() {
    window.location.hash = "ptcMovimiento";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_movimientos.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    filtrar_grilla_retenido(),
                    get_checkbox_selected_movimientos(),
                    $(".dtBox").DateTimePicker(),
                    $("#boxColor").css("background-color", "lightblue"),
                    $("#tabla_lotes").dataTable({scrollX: !0}),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_retenido_fecha_puesta() {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_retenidos_puesta.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), filtrar_grilla_retenido(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_fecha_involucrada() {
    window.location.hash = "ptcFechaInvolucrada";
    $.get(ruta_contenedores_ptc + "contenedor_fecha_involucrada.jsp", function (e) {
        $("#contenedor_principal").html(e),
                $("#contenedor_principal").show(),
                $("#contenido").hide(),
                $("#contenido_password").hide(),
                $("#contenido_reporte").hide(),
                $("#contenido_visualizar").hide(),
                $("#contenido_retenido").hide(),
                cargar_estilo_calendario_insert("dd/mm/yyyy"),
                $("#txt_fecha_involucradas").multiDatesPicker({dateFormat: "yy/mm/dd"}),
                $("#formulario_correccion").on("submit", function (e) {
            e.preventDefault(), registrar_fecha_involucradas(), e.stopPropagation();
        });
    });
}
function traer_eliminar() {
    window.location.hash = "ptcEliminar";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_eliminar.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), elminar_fila(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_informe() {
    window.location.hash = "ptcInfome";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_informe.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_insert() {
    $.get(ruta_controles_ptc + "lotes_control.jsp", function (e) {
        $("#contenedor_principal").html(e);
    }),
            $("#contenido").hide(),
            $("#contenedor_principal").show();
}
function traer_control() {
    $.get(ruta_controles_ptc + "control_registro.jsp", function (e) {
        $("#contenedor_principal").html(e);
    }),
            $("#contenedor_principal").show(),
            $("#contenido").hide();
}
function traer_contendor_cambiar_pass_jsp() {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_password.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_contendor_pdf_jsp() {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_pdf.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), $("#calendario").datepicker(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_carro_mesa() {
    //window.location.hash = "ptcCarroMesa";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_carro_mesa.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), $("#calendario_mesa").datepicker(), filtrar_grilla_carromesa(), elminar_fila(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_contendor_pdf_reproceso() {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_pdf_reproceso.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), $("#calendario_reporte_reproceso").datepicker(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_grilla_retenido() {
    window.location.hash = "ptcGrillaRetenido";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_disposicion.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_reporte_lotes() {
    window.location.hash = "ptcReporteLotes";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_reporte_carros.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    $(".dtBox").DateTimePicker(),
                    $(".selectpicker").selectpicker(),
                    $(".checkbox").bootstrapToggle(),
                    $("#check_tipo_calendario").change(function () {
                1 == $(this).prop("checked") ? $("#tipo_calendario").val("INVOLUCRADA") : $("#tipo_calendario").val("PUESTA");
            }),
                    $("#check_filtro_aviario").change(function () {
                1 == $(this).prop("checked") ? ($("#filtro_aviario").val("SI"), $("#boxColor").hide(), $("#div_aviarios").show()) : ($("#filtro_aviario").val("NO"), $("#boxColor").show(), $("#div_aviarios").hide());
            }),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_reporte_mixtos_historial() {
    window.location.hash = "ptcReporteMixtos";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_reporte_mixtos_variable.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    $(".selectpicker").selectpicker(),
                    $(".checkbox").bootstrapToggle(),
                    $("#check_filtro_aviario").change(function () {
                1 == $(this).prop("checked")
                        ? ($("#filtro_aviario").val("SI"), $("#boxColor").hide(), $("#div_aviarios").show(), $("#div_filtro_carro").hide(), $("#cod_carrito").val("0")())
                        : ($("#filtro_aviario").val("NO"), $("#boxColor").show(), $("#div_aviarios").hide(), $("#div_filtro_carro").show(), $("#cod_carrito").val("0")());
            }),
                    $("#check_filtro_carro").change(function () {
                1 == $(this).prop("checked") ? $("#div_carrito").show() : ($("#div_carrito").hide(), $("#cod_carrito").val("0")());
            }),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_reporte_ptc_excel() {
    window.location.hash = "ptcReporteExcel";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_info_ptc_excel.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(), $("#contenedor_principal").html(e), $("#contenedor_principal").show(), cargar_estilo_calendario_insert("dd/mm/yyyy"), ir_reporte_excel_ptc(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_grilla_transferencia(e, t) {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "acordeon_transferencia.jsp",
        data: {fecha: e, tipo: t,tipo_reporte: $('#tipo_reporte').val()},
        beforeSend: function () {
            cargar_load(), $("#div_cargar").show();
        },
        success: function (e) {
            $("#div_grilla_tipo_transferencia").html(e), $("#div_cargar").hide(), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function traer_pendiente_liberacion_ptc() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_pendiente_liberacion.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    $("#grilla_lotes_liberacion").DataTable({scrollX: !0, paging: !1, ordering: !1, info: !0, language: {sUrl: "js/Spanish.txt"}}),
                    cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function buscar_aviarios_disponibles() {
    var e = $("#calendario_registro").val(),
            t = $("#fecha_clas_final").val(),
            o = $("#hora_desde").val(),
            r = $("#hora_hasta").val(),
            a = e + " " + o + ":00.000",
            n = t + " " + r + ":59.000";
    e.length > 0 &&
            t.length > 0 &&
            o.length > 0 &&
            r.length > 0 &&
            $.get(ruta_consultas_ptc + "eliminar_control.jsp", {fecha_inicio: a, fecha_final: n}, function (e) {
                $("#cbox_aviarios").html(e.aviarios);
            });
}
function traer_control_eliminar(e, t) {
    $.get(ruta_controles_ptc + "eliminar_control.jsp", {id: e, cod_lote: t}, function (e) {
        Eliminar_fila_grilla_eliminar(t), traer_detalle_eliminar($("#calendario_eliminar").val()), swal.fire({type: "error", title: "REGISTRO ELIMINADO ", confirmButtonText: "CERRAR"});
    });
}
function traer_grilla_reproceso() {
    $.get(ruta_grillas_ptc + "grilla_reproceso.jsp", function (e) {
        $("#contenedor_grilla_reproceso").html(e);
    });
}
function inicializar_unidad_medida_PTC() {
    (medida = $("#unidad_medida")), (tipo_huevo = $("#tipo_huevo")), tipo_huevo.change(cargar_unidad_medida_PTC);
}
function cargar_unidad_medida_PTC(e, t) {
    var o;
    (o =
            "1" === $("#" + e).val()
            ? "<OPTION style='font-weight: bold;' VALUE='180'>CAJON GIGANTE</OPTION>"
            : "<OPTION style='font-weight: bold;' VALUE='' selected >SELECCIONE UNIDAD DE MEDIDA</OPTION>\n            <OPTION style='font-weight: bold;' VALUE='4320'>CARRITO NORMAL</OPTION>\n            <OPTION style='font-weight: bold;' VALUE='360'>CAJON</OPTION>"),
            $("#" + t).html(o);
}
function parpadeo(e, t, o) {
    "0" == e ? (endAnimation(), $("#texto_global").html("<font color='black'><center><b>FECHA DE PUESTA MAS VIEJA, " + o + " </b></center></font>"), $("#notificacion").hide(!0)) : initAnimation(t, o);
}
function initAnimation(e, t) {
    (document.getElementById("div_pendiente").className = " card border-left-success shadow h-100 py-2 animacion"),
            $("#texto").html("<font color='black'><b>TIENE PENDIENTES DE LIBERACION, CON FECHA DE PUESTA MAS VIEJA, " + e + " </b></font>"),
            $("#texto_global").html("<font color='black'><center><b>FECHA DE PUESTA MAS VIEJA, " + t + " </b></center></font>"),
            $("#notificacion").show(!0);
}
function endAnimation() {
    (document.getElementById("div_pendiente").className = ""), (document.getElementById("div_principal_pendiente").className = "ocultar_div");
}
function ir_grilla_transformacion_pallet_carro() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_transformacion_pallet_carro.jsp",
        data: {fecha_puesta: $("#fecha_puesta").val()},
        beforeSend: function () {
            cargar_load();
        },
        success: function (e) {
            $("#contenido_grilla_transformacion_pallet_carro").html(e), $("#example").DataTable({scrollX: !0, pageLength: 100, language: {sUrl: "js/Spanish.txt"}}), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_grilla_transformacion_carro() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_transformacion_carro.jsp",
        data: {fecha_puesta: $("#fecha_puesta").val()},
        beforeSend: function () {
            cargar_load();
        },
        success: function (e) {
            $("#contenido_grilla_transformacion_carro").html(e), $("#example").DataTable({scrollX: !0, pageLength: 100, language: {sUrl: "js/Spanish.txt"}}), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_grilla_cambio_fp_ptc() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_ptc_cambio_fp.jsp",
        data: {fecha_puesta: $("#fecha_puesta").val()},
        beforeSend: function () {
            cargar_load();
        },
        success: function (e) {
            $("#contenido_grilla_cambio_fp").html(e), $("#example").DataTable({scrollX: !0, pageLength: 100, language: {sUrl: "js/Spanish.txt"}}), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function ir_grilla_cambio_nro_ptc() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_ptc_cambio_nro_ptc.jsp",
        data: {fecha_puesta: $("#fecha_puesta").val()},
        beforeSend: function () {
            cargar_load();
        },
        success: function (e) {
            $("#contenido_grilla_cambio_fp").html(e), $("#example").DataTable({scrollX: !0, pageLength: 100, language: {sUrl: "js/Spanish.txt"}}), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function registro_transformacion_pallet_carro(e, t, o) {
    Swal.fire({
        title: "TRANSFORMACION DE PALLET A CARRO",
        type: "warning",
        html: " <a><strong>PALLET NRO" + t + "</strong> \n                    </a><br><br><a>INGRESE EL NUMERO DE CARRO</a> \n                    <input type='number' class='form-control' id='txt_nro_carro' placeholder='INGRESE NRO'/>",
        showCancelButton: !0,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "REGISTRAR",
        cancelButtonText: "CANCELAR",
    }).then((t) => {
        if (t.value) {
            var r;
            r = "N" == o ? ruta_controles_ptc + "control_tranformacion_pallet_ptc.jsp" : "http://192.168.6.162/ws/ptc_upd.aspx";
            var a = $("#txt_nro_carro").val();
            a.length < 6
                    ? Swal.fire({title: "ERROR, DEBE INGRESAR UN NUMERO DE CARRO VALIDO.", type: "error", animation: !0, customClass: {popup: "animated tada"}})
                    : $.ajax({
                        type: "POST",
                        url: r,
                        data: {id: e, cod_carrito: a},
                        beforeSend: function () {
                            Swal.fire({
                                title: "PROCESANDO!",
                                html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                                allowOutsideClick: !1,
                                 willOpen: () => {
                    Swal.showLoading()
                }
               
                            });
                        },
                        success: function (e) {
                            aviso_transformacion(e.tipo, e.mensaje);
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
function liberar_retenidos_mensaje(e, t, o, r, a) {
    var n;
    (n =
            "7" == o || "6" == o
            ? "<form id='form_liberar'> <a>INGRESE EL RESPONSABLE</a>\n                \n<input type='hidden'   id='id_carro' name='id_carro' value='" +
            t +
            "-" +
            r +
            "-" +
            a +
            "-" +
            o +
            "' /> \n                \n<input type='hidden'   id='estado_requerido' name='estado_requerido' value='L' /> \n                <input type='text' class='form-control ' id='responsable' name='responsable' placeholder='RESPONSABLE' required/> \n                <br> <a>FECHA DE ALIMENTACION</a> \n                <input type='date' style='font-weight: bold;' min='2020-11-20' max='2030-12-25' id='fecha_alimentacion' name='fecha_alimentacion' placeholder='INGRESE FECHA' class='form-control '  required/><br><br>\n                <input type='submit'  value='LIBERAR' class='form-control bg-success btn color_letra'>\n                </form>"
            : "<form id='form_liberar'> <a>INGRESE EL RESPONSABLE</a>\n                \n<input type='hidden'   id='id_carro' name='id_carro' value='" +
            t +
            "-" +
            r +
            "-" +
            a +
            "-" +
            o +
            "' /> \n                \n<input type='hidden'   id='estado_requerido' name='estado_requerido' value='L' /> \n                <input type='text' class='form-control ' id='responsable' name='responsable' placeholder='RESPONSABLE' required/> \n                <input type='hidden' value='' id='fecha_alimentacion' name='fecha_alimentacion' >\n                 <input type='submit'  value='LIBERAR' class='form-control bg-success btn color_letra'>\n                </form>"),
            Swal.fire({title: "LIBERACION DE LOTE NRO." + e, type: "warning", html: n, showCancelButton: !1, showConfirmButton: !1}),
            cargar_estilo_calendario_insert("dd/mm/yyyy"),
            control_retenidos_pendientes(t, $("#res").val(), o, r, a);
}
function control_retenidos_pendientes(e, t, o, r, a) {
    $("#form_liberar").submit(function (e) {
        e.preventDefault(),
                $.ajax({
                    type: "POST",
                    url: ruta_controles_ptc + "control_movimientos.jsp",
                    data: $("#form_liberar").serialize(),
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (e) {
                        "1" == e.tipo_mensaje
                                ? (swal.fire({type: "success", title: e.mensaje, confirmButtonText: "CERRAR"}),
                                        $(this).addClass("selected"),
                                        $("#grilla_lotes_liberacion")
                                        .DataTable()
                                        .row("#" + r)
                                        .remove()
                                        .draw(!1),
                                        $("#grilla_lotes_liberacion").dataTable().fnDestroy(),
                                        $("#grilla_lotes_liberacion").DataTable({scrollX: !0, paging: !1, ordering: !1, info: !0, language: {sUrl: "js/Spanish.txt"}}))
                                : swal.fire({type: "error", title: e.mensaje, confirmButtonText: "CERRAR"}),
                                notificacion();
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                }),
                e.stoppropagation();
    });
}
function registro_transformacion_ptc(e, t, o, r, a, n, i) {
    var c, l;
    "N" == o
            ? ((l = ruta_controles_ptc + "control_transformacion_ptc.jsp"),
                    (c =
                            "<select style='font-weight: bold;' class='form-control' name='tipo_huevo' id='tipo_huevo'> <OPTION value='A'>TIPO A</OPTION> <OPTION value='B'>TIPO B</OPTION>   <OPTION value='C'>TIPO C</OPTION> <OPTION value='D'>TIPO 4TA</OPTION> <OPTION value='S'>TIPO SUPER</OPTION> <OPTION value='J'>TIPO JUMBO</OPTION> <OPTION value='G'>TIPO G</OPTION></select>"))
            : ((c =
                    "<select style='font-weight: bold;' class='form-control' name='tipo_huevo' id='tipo_huevo'> <OPTION value='4'>TIPO A</OPTION> <OPTION value='5'>TIPO B</OPTION>   <OPTION value='6'>TIPO C</OPTION> <OPTION value='7'>TIPO 4TA</OPTION> <OPTION value='3'>TIPO SUPER</OPTION> <OPTION value='2'>TIPO JUMBO</OPTION> <OPTION value='1'>TIPO G</OPTION><OPTION value='8'>TIPO SUBPRODUCTO</OPTION></select>"),
                    (l = "http://192.168.6.162/ws/control_transformar_ptc.aspx")),
            Swal.fire({
                title: "TRANSFORMACION DE TIPO DE HUEVO",
                type: "warning",
                html: " <a><strong>PTC NRO " + t + "</strong> </a><br><br><a>SELECCIONE EL TIPO DE HUEVO</a> " + c,
                showCancelButton: !0,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "REGISTRAR",
                cancelButtonText: "CANCELAR",
            }).then((t) => {
        t.value &&
                $.ajax({
                    type: "POST",
                    url: l,
                    data: {cod_interno: e, fecha_puesta: a, cantidad: r, itemcode: $("#tipo_huevo").val(), itemcode_origen: n, clasificadora: i},
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (e) {
                        aviso_transformacion(e.tipo, e.mensaje);
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });
    });
}
function registro_cambio_fp_ptc(e, t) {
    Swal.fire({
        title: "CAMBIO DE FECHA DE PUESTA DEL LOTE",
        type: "warning",
        html: "</a><br><br><a>INGRESE LA FECHA DE PUESTA</a> <input type='text' class='datepicker' id='txt_fecha' placeholder='INGRESE FECHA DE PUESTA'/><br><br><br><br>",
        showCancelButton: !0,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "REGISTRAR",
        cancelButtonText: "CANCELAR",
    }).then((o) => {
        if (o.value) {
            var r;
            r = "N" == t ? ruta_controles_ptc + "control_cambio_fp_ptc.jsp" : "http://192.168.6.162/ws/ptc_upd_fp.aspx";
            var a = $("#txt_fecha").val();
            0 == a.length
                    ? Swal.fire({title: "ERROR, DEBE INGRESAR LA FECHA DE PUESTA.", type: "error", animation: !0, customClass: {popup: "animated tada"}})
                    : $.ajax({
                        type: "POST",
                        url: r,
                        data: {id: e, fecha_puesta: a},
                        beforeSend: function () {
                            Swal.fire({
                                title: "PROCESANDO!",
                                html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                                allowOutsideClick: !1,
                                 willOpen: () => {
                    Swal.showLoading()
                }
               
                            });
                        },
                        success: function (e) {
                            aviso_transformacion(e.tipo, e.mensaje);
                        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                    });
        }
    }),
            cargar_estilo_calendario_insert("dd/mm/yyyy");
}
function registro_cambio_nro_ptc(e, t) {
    Swal.fire({
        title: "CAMBIO DE NRO DEL LOTE",
        type: "warning",
        html: "</a><br><br><a>INGRESE EL NUEVO NUMERO DE CARRO</a> <input type='number' class='form-control' id='nro_carrito' placeholder='INGRESE NRO DE CARRO'/><br><br><br><br>",
        showCancelButton: !0,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "REGISTRAR",
        cancelButtonText: "CANCELAR",
    }).then((o) => {
        if (o.value) {
            var r;
            r = "N" == t ? ruta_controles_ptc + "control_cambio_nro_ptc.jsp" : "http://192.168.6.162/ws/ptc_upd_nro_carrito.aspx";
            var a = $("#nro_carrito").val();
            a.length < 6 || a.length > 6
                    ? Swal.fire({title: "ERROR, CODIGO DE CARRO INGRESADO INVALIDO.", type: "error", animation: !0, customClass: {popup: "animated tada"}})
                    : $.ajax({
                        type: "POST",
                        url: r,
                        data: {id: e, cod_carrito: a},
                        beforeSend: function () {
                            Swal.fire({
                                title: "PROCESANDO!",
                                html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                                allowOutsideClick: !1,
                                 willOpen: () => {
                    Swal.showLoading()
                }
               
                            });
                        },
                        success: function (e) {
                            aviso_transformacion_PTC(e.tipo, e.mensaje);
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
function aviso_transformacion(e, t) {
    0 == e ? (swal.fire({type: "success", title: "TRANSFORMACION REALIZADA CON EXITO.", confirmButtonText: "CERRAR"}), $("contenedor_principal").html("")) : swal.fire({type: "error", html: t, confirmButtonText: "CERRAR"});
}
function aviso_transformacion_PTC(e, t) {
    0 == e ? (swal.fire({type: "success", title: "TRANSFORMACION REALIZADA CON EXITO.", confirmButtonText: "CERRAR"}), ir_grilla_transformacion_carro()) : swal.fire({type: "error", html: t, confirmButtonText: "CERRAR"});
}
function cuadro_empacadoras() {
    Swal.fire({
        title: "ACTIVAR EMPACADORA",
        html:
                "<a>SELECCIONE EMPACADORA</a><br><select style='font-weight: bold;' class='form-control' name='empacadora' id='empacadora'  > <OPTION style='font-weight: bold;' VALUE='0'>0</OPTION> <OPTION style='font-weight: bold;' VALUE='1'>1</OPTION> <OPTION style='font-weight: bold;' VALUE='2'>2</OPTION><OPTION style='font-weight: bold;' VALUE='3'>3</OPTION><OPTION style='font-weight: bold;' VALUE='4'>4</OPTION><OPTION style='font-weight: bold;' VALUE='5'>5</OPTION><OPTION style='font-weight: bold;' VALUE='6'>6</OPTION><OPTION style='font-weight: bold;' VALUE='7'>7</OPTION><OPTION style='font-weight: bold;' VALUE='8'>8</OPTION><OPTION style='font-weight: bold;' VALUE='9'>9</OPTION><OPTION style='font-weight: bold;' VALUE='10'>10</OPTION><OPTION style='font-weight: bold;' VALUE='11'>11</OPTION><OPTION style='font-weight: bold;' VALUE='12'>12</OPTION></select> <br><a>SELECCIONE TIPO DE HUEVO</a><br><select style='font-weight: bold;' class='form-control' name='tipo_huevo' id='tipo_huevo'  > <OPTION style='font-weight: bold;' VALUE='G'>G</OPTION><OPTION style='font-weight: bold;' VALUE='J'>J</OPTION><OPTION style='font-weight: bold;' VALUE='S'>S</OPTION><OPTION style='font-weight: bold;' VALUE='A'>A</OPTION><OPTION style='font-weight: bold;' VALUE='B'>B</OPTION><OPTION style='font-weight: bold;' VALUE='C'>C</OPTION><OPTION style='font-weight: bold;' VALUE='D'>4TA</OPTION></select> ",
        showCancelButton: !0,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "ACTIVAR",
        cancelButtonText: "CANCELAR",
    }).then((e) => {
        e.value &&
                $.ajax({
                    type: "POST",
                    url: ruta_controles_ptc + "control_empacadora.jsp",
                    data: {empacadora: $("#empacadora").val(), tipo_huevo: $("#tipo_huevo").val()},
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "ESPERE<strong></strong>...",
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (e) {
                        Swal.close(), 0 == e.tipo_respuesta ? (swal.fire({type: "success", title: e.mensaje, confirmButtonText: "CERRAR"}), ir_grilla_empacadoras()) : swal.fire({type: "error", html: e.mensaje, confirmButtonText: "CERRAR"});
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });
    });
}
function ir_grilla_empacadoras() {
    $.ajax({
        type: "POST",
        url: ruta_grillas_ptc + "grilla_empacadora.jsp",
        beforeSend: function () {
            cargar_load();
        },
        success: function (e) {
            $("#div_tabla").html(e), cerrar_load();
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function consulta_empacadora() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ptc + "grilla_option_empacadoras.jsp",
        data: {tipo_huevo: $("#tipo_huevo option:selected").text()},
        beforeSend: function () {},
        success: function (e) {
            $("#nro_empacadora").empty(), $("#nro_empacadora").append(e.mensaje);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function consulta_empacadora_retenido() {
    $.ajax({
        type: "POST",
        url: ruta_consultas_ptc + "grilla_option_empacadoras.jsp",
        data: {tipo_huevo: $("#tipo_huevo_retenido option:selected").text()},
        beforeSend: function () {},
        success: function (e) {
            $("#nro_empacadora").empty(), $("#nro_empacadora").append(e.mensaje);
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function cerrar_empacadora(e) {
    Swal.fire({title: "EMPACADORA", type: "warning", text: "DESEA CERRAR LA EMPACADORA", showCancelButton: !0, confirmButtonColor: "#3085d6", cancelButtonColor: "#d33", confirmButtonText: "ACEPTAR", cancelButtonText: "CANCELAR"}).then(
            (t) => {
        t.value &&
                $.ajax({
                    type: "POST",
                    url: ruta_controles_ptc + "control_cerrar_empacadora.jsp",
                    data: {id: e},
                    beforeSend: function () {},
                    success: function (e) {
                        Swal.close(),
                                0 == e.tipo_respuesta ? (swal.fire({type: "success", title: e.mensaje, confirmButtonText: "CERRAR"}), ir_grilla_empacadoras()) : swal.fire({type: "error", html: e.mensaje, confirmButtonText: "CERRAR"});
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });
    }
    );
}
function habilitar_boton_registrar() {
    $("#tipo_almacenamiento").change(function () {
        $("#btn_registrar").removeAttr("disabled");
    });
}
function cargar_toggles() {
    $("#chkToggle2").change(function () {
        1 == $(this).prop("checked") ? $("#codigo_borroso").val("SI") : $("#codigo_borroso").val("NO");
    }),
            $("#chkToggle_especial").change(function () {
        1 == $(this).prop("checked") ? $("#codigo_especial").val("SI") : $("#codigo_especial").val("NO");
    }),
            $("#chkToggle_recogida").change(function () {
        1 == $(this).prop("checked")
                ? ($("#codigo_reposicion").val("SI"), $("#txt_lotes_reposicionados").val(""), $("#btn_huevos_recogidas").show(), $("#grilla_reposicion tbody").empty())
                : ($("#txt_lotes_reposicionados").val(""), $("#codigo_reposicion").val("NO"), $("#btn_huevos_recogidas").hide(), $("#grilla_reposicion tbody").empty());
    }),
            $("#chkToggle_cepillado").change(function () {
        1 == $(this).prop("checked") ? $("#codigo_cepillado").val("SI") : $("#codigo_cepillado").val("NO");
    }),
            $("#chkToggle_aviario").change(function () {
        $("#fecha_puesta").val(""), 1 == $(this).prop("checked") ? $("#cbox_aviarios").removeAttr("required") : $("#cbox_aviarios").prop("required", "required");
    });
}
function filtro_eliminar() {
    $("#buscar_eliminar").on("keyup", function () {
        var e = $(this).val().toLowerCase();
        $("#grilla_eliminar tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(e) > -1);
        });
    });
}
function traer_detalle_eliminar(e) {
    $.get(ruta_grillas_ptc + "grilla_eliminar.jsp", {fecha: e}, function (e) {
        $("#id_div").html(e), $("#grilla_eliminar").DataTable({language: {sUrl: "js/Spanish.txt"}});
    });
}
function traer_detalle_fecha_involucrada(e) {
    $.get(ruta_grillas_ptc + "grilla_fecha_involucrada.jsp", {fecha: e}, function (e) {
        $("#div_id_involucrada").html(e), $("#grilla_involucrada").DataTable({language: {sUrl: "js/Spanish.txt"}});
    });
}
function visible_div_eliminar() {
    document.getElementById("div_eliminar").style.display = "block";
}
function filtrar_grilla_retenido() {
    $("#buscar_retenido").on("keyup", function () {
        var e = $(this).val().toLowerCase();
        $("#tabla_retenido tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(e) > -1);
        });
    });
}
function setear_grilla() {
    var e = $('[name="checks[]"]:checked')
            .map(function () {
                return this.value;
            })
            .get()
            .join(",");
    $("#resultado_seleccionado").val(e);
    var t = $("#estado_requerido").val(),
            o = $("#resultado_seleccionado").val(),
            r = $("#liberado_por").val(),
            a = $("#estado_liberacion").val(),
            n = $("#motivo_retencion").val(),
            i = $("#disposicion").val();
    "" === o
            ? (swal({title: "ERROR, SELECCIONE LOTE!!!", text: "", timer: 2e3, showConfirmButton: !1}), $.preloader.stop())
            : ("L" === t && ("" === r ? swal({title: "ERROR, COMPLETE TODOS LOS DATOS!!!", text: "", timer: 2e3, showConfirmButton: !1}) : (imprimir(), enviar_datos_retenidos2())),
                    "R" === t && (null === a || null === n || null === i ? (swal({title: "ERROR, COMPLETE TODOS LOS DATOS!!!", text: "", timer: 2e3, showConfirmButton: !1}), $.preloader.stop()) : (imprimir(), enviar_datos_retenidos2())));
}
function validar_seleccion() {
    "" == $("#resultado_seleccionado").val() && alert("DEBE SELECCIONAR AL MENOS UN LOTE");
}
function buscar_lotes_movimientos() {
    if ("" == $("#desde").val() || "" == $("#hasta").val() || "" == $("#calendario_retenido").val())
        alert("ERROR COMPLETAR DATOS");
    else {
        var e = $("#estado_requerido").val();
        "R" === e || "Z" === e
                ? ($("#estado_liberacion").prop("required", "required"),
                        $("#motivo_retencion").prop("required", "required"),
                        $("#disposicion").prop("required", "required"),
                        $("#liberado_por").removeAttr("required"),
                        $("#combo_retenido").show(),
                        $("#liberado_por").hide())
                : "L" === e &&
                ($("#liberado_por").show(),
                        $("#liberado_por").prop("required", "required"),
                        $("#motivo_retencion").removeAttr("required"),
                        $("#motivo_retencion").removeAttr("required"),
                        $("#disposicion").removeAttr("required"),
                        $("#combo_retenido").hide()),
                $("#tabla_lotes").DataTable({
            scrollX: !0,
            scrollY: "500px",
            bPaginate: !1,
            destroy: !0,
            language: {sUrl: "js/Spanish.txt"},
            ajax: {
                url: ruta_grillas_ptc + "grilla_lotes_movimiento.jsp",
                data: {fecha_retenido: $("#calendario_retenido").val(), inicio_retenido: $("#desde").val(), fin_retenido: $("#hasta").val(), combo_estado_retenido: $("#estado_requerido").val(), tipo: $("#tipo").val()},
            },
            columnDefs: [
                {
                    targets: 0,
                    checkboxes: {selectRow: !0},
                    render: function (e, t, o, r) {
                        return '<input type="checkbox" value="' + e + '" class="dt-checkboxes" autocomplete="off">';
                    },
                },
                {targets: [1, 2, 6, 7, 8], className: "ocultar "},
                {targets: [3, 4, 5, 9, 10, 11, 12, 13], className: "bolded"},
            ],
            select: {style: "multi"},
            order: [[1, "asc"]],
            rowCallback: function (e, t, o) {
                "L" == t[5] ? $("td", e).css("background-color", "Green") : "R." == t[5] ? $("td", e).css("background-color", "cyan") : $("td", e).css("background-color", "red");
            },
            initComplete: function (e, t) {
                $(".ocultar").hide();
            },
        });
    }
}
function get_checkbox_selected_movimientos() {
    $("#frm_movimiento").on("submit", function (e) {
        e.preventDefault();
        for (var t = document.getElementById("tabla_lotes").getElementsByClassName("dt-checkboxes"), o = "", r = 0, a = 0; a < t.length; a++) {
            var n = t[a].parentNode.parentNode;
            t[a].checked &&
                    (0 == r
                            ? ((o += n.cells[2].innerHTML), (o += "-" + n.cells[1].innerHTML), (o += "-" + n.cells[6].innerHTML), (o += "-" + n.cells[7].innerHTML), r++)
                            : ((o += ","), (o += n.cells[2].innerHTML), (o += "-" + n.cells[1].innerHTML), (o += "-" + n.cells[6].innerHTML), (o += "-" + n.cells[7].innerHTML), r++));
        }
        0 == o.length
                ? Swal.fire({type: "error", title: "ATENCION!", html: "DEBE SELECCIONAR ALGUN LOTE."})
                : Swal.fire({
                    title: "DESEAR PROCESAR EL CAMBIO DE LIBERACION?",
                    type: "warning",
                    showCancelButton: !0,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "ACEPTAR!",
                    cancelButtonText : "CANCELAR!",
                }).then((e) => {
            e.value &&
                    $.ajax({
                        type: "POST",
                        url: ruta_controles_ptc + "control_movimientos.jsp",
                        data: {
                            id_carro: o,
                            estado_requerido: $("#estado_requerido").val(),
                            disposicion: $("#disposicion").val(),
                            estado_liberacion: $("#estado_liberacion").val(),
                            motivo_retencion: $("#motivo_retencion option:selected")
                                    .toArray()
                                    .map((e) => e.text)
                                    .join(),
                            responsable: $("#liberado_por").val(),
                        },
                        beforeSend: function () {
                            Swal.fire({
                                title: "PROCESANDO!",
                                html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                                allowOutsideClick: !1,
                                 willOpen: () => {
                    Swal.showLoading()
                }
               
                            });
                        },
                        success: function (e) {
                            "1" == e.tipo_mensaje ? (Swal.fire({type: "success", title: "ATENCION!", text: e.mensaje}), $("#contenedor_principal").html("")) : Swal.fire({type: "error", title: "ATENCION!", html: e.mensaje});
                        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                    });
        }),
                e.stopPropagation();
    });
}
function ir_reporte_excel_ptc() {
    $(document).on("click", ".btn_buscar_excel", function () {
        $("#form_excel").on("submit", function (e) {
            e.preventDefault(),
                    $.get(ruta_grillas_ptc + "grilla_ptc_excel.jsp", {calendario_informe: $("#calendario_ptc_excel").val(), estado: $("#estado").val()}, function (e) {
                        var t;
                        $("#ptc_excel").html(e),
                                (t = "E" == $("#estado").val() ? "FORMULARIO REGISTROS ELIMINADOS DE HUEVOS CLASIFICADOS FRESCOS Y LAVADOS FECHA DE PUESTA" : "FORMULARIO HUEVOS CLASIFICADOS FRESCOS Y LAVADOS FECHA DE PUESTA"),
                                $("#example tfoot th").each(function (e) {
                            var t = $("#example thead th").eq($(this).index()).text();
                            $(this).html('<input type="text" placeholder="' + t + '" data-index="' + e + '" />');
                        });
                        var o = $("#example").DataTable({
                            scrollY: "500px",
                            scrollX: !0,
                            dom: "Bfrtip",
                            pageLength: 100,
                            language: {
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
                                buttons: {copyTitle: "DATOS COPIADOS", copySuccess: {_: "%d FILAS COPIADAS"}},
                            },
                            buttons: [
                                {extend: "copyHtml5", text: "COPIAR GRILLA", exportOptions: {columns: [0, ":visible"]}},
                                {extend: "excelHtml5", title: t + $("#calendario_ptc_excel").val(), text: "EXCEL", exportOptions: {columns: ":visible"}},
                                {
                                    extend: "pdfHtml5",
                                    text: "PDF",
                                    title: t + "\n        FECHA DE PUESTA:" + $("#calendario_ptc_excel").val(),
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
                            keys: {clipboard: !1},
                        });
                        $(o.table().container()).on("keyup", "tfoot input", function () {
                            o.column($(this).data("index")).search(this.value).draw();
                        });
                    }),
                    e.stopimmediatepropagation();
        });
    });
}
function exportar_excel_ptc(e) {
    var t = document.getElementById("mobiles").outerHTML,
            o = "data:application/vnd.ms-excel," + escape(t);
    return e.setAttribute("href", o), e.setAttribute("download", "REPORTE PTC.xls"), !1;
}
function registrar_fecha_involucradas() {
    $.ajax({
        type: "POST",
        url: ruta_controles_ptc + "control_correccion.jsp",
        data: $("#formulario_correccion").serialize(),
        beforeSend: function () {
            Swal.fire({
                title: "PROCESANDO!",
                html: "<strong>ESPERE</strong>...",
                            showCancelButton: false,
                            showConfirmButton: false,
                allowOutsideClick: !1,
                 willOpen: () => {
                    Swal.showLoading()
                }
               
            });
        },
        success: function (e) {
            1 == e.tipo_respuesta ? (Swal.fire({type: "success", title: "ATENCION!", text: e.mensaje}), $("#cuadro1").modal("toggle")) : Swal.fire({type: "error", title: "ATENCION!", text: e.mensaje});
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function remover_required_reporte_ptc() {
    $("#cbox_estado").removeAttr("required"),
            $("#calendario_reporte_carros").removeAttr("required"),
            $("#calendario_reporte_clasificacion").removeAttr("required"),
            $("#cbox_estado").removeAttr("required"),
            $("#tipo_huevo").removeAttr("required"),
            $("#desde").removeAttr("required"),
            $("#hasta").removeAttr("required"),
            $("#hasta").removeAttr("required"),
            $("#txt_fecha_involucrada_rep").prop("required", !0);
}
function add_required_reporte_ptc() {
    $("#cuadro1").modal("toggle"),
            $("#txt_fecha_involucrada_rep").val(""),
            $("#cbox_estado").prop("required", !0),
            $("#calendario_reporte_carros").prop("required", !0),
            $("#calendario_reporte_clasificacion").prop("required", !0),
            $("#cbox_estado").prop("required", !0),
            $("#tipo_huevo").prop("required", !0),
            $("#desde").prop("required", !0),
            $("#hasta").prop("required", !0),
            $("#txt_fecha_involucrada_rep").removeAttr("required");
}
function consulta_huevos_recibidos(e) {
    var t = "0",
            o = "0",
            r = "0",
            a = "0",
            n = "0",
            i = "0",
            c = "0",
            l = "0",
            s = "0",
            d = "0",
            _ = "0",
            p = "0",
            u = "0",
            f = "0",
            m = "0",
            g = "0",
            h = "0",
            O = "0",
            b = "0",
            E = "0",
            S = "0",
            C = "0",
            y = "0",
            T = "0",
            v = "0",
            I = "0",
            A = "0",
            x = "0",
            P = "0",
            R = "0";
    cargar_load(),
            $.ajax({
                type: "POST",
                url: ruta_consultas_ptc + "consulta_huevos_recibidos.jsp",
                data: {fecha: e},
                beforeSend: function () {
                    $("#div_cargar").show();
                },
                success: function (e) {
                    $("#div_cargar").hide(),
                            $.each(e.cantidades_clasificadoras, function (e, n) {
                                switch (n.Clasificadora) {
                                    case "CCHA":
                                        t = n.Cantidad;
                                        break;
                                    case "CCHB":
                                        o = n.Cantidad;
                                        break;
                                    case "CCHH":
                                        r = n.Cantidad;
                                        break;
                                    case "LAVADOS":
                                        a = n.Cantidad;
                                }
                            }),
                            $.each(e.cantidades_tipo, function (e, t) {
                                switch (t.clasificadora) {
                                    case "CCHA":
                                        switch (t.tipo) {
                                            case "REPROCESOS":
                                                p = t.Cantidad;
                                                break;
                                            case "SUBPRODUCTOS":
                                                m = t.Cantidad;
                                                break;
                                            case "ROTOS":
                                                f = t.Cantidad;
                                                break;
                                            case "PTC":
                                                n = t.Cantidad;
                                                break;
                                            case "SIN CLASIFICAR":
                                                i = t.Cantidad;
                                                break;
                                            case "PENDIENTE RECOGIDA":
                                                s = t.Cantidad;
                                                break;
                                            case "PTC LAVADOS":
                                                S = t.Cantidad;
                                                break;
                                            case "PTC RETENIDOS":
                                                T = t.Cantidad;
                                        }
                                        break;
                                    case "CCHB":
                                        switch (t.tipo) {
                                            case "REPROCESOS":
                                                O = t.Cantidad;
                                                break;
                                            case "SUBPRODUCTOS":
                                                E = t.Cantidad;
                                                break;
                                            case "ROTOS":
                                                b = t.Cantidad;
                                                break;
                                            case "PTC":
                                                h = t.Cantidad;
                                                break;
                                            case "SIN CLASIFICAR":
                                                c = t.Cantidad;
                                                break;
                                            case "PENDIENTE RECOGIDA":
                                                _ = t.Cantidad;
                                                break;
                                            case "PTC LAVADOS":
                                                C = t.Cantidad;
                                                break;
                                            case "PTC RETENIDOS":
                                                v = t.Cantidad;
                                        }
                                        break;
                                    case "CCHH":
                                        switch (t.tipo) {
                                            case "REPROCESOS":
                                                x = t.Cantidad;
                                                break;
                                            case "SUBPRODUCTOS":
                                                R = t.Cantidad;
                                                break;
                                            case "ROTOS":
                                                P = t.Cantidad;
                                                break;
                                            case "PTC":
                                                A = t.Cantidad;
                                                break;
                                            case "SIN CLASIFICAR":
                                                l = t.Cantidad;
                                                break;
                                            case "PENDIENTE RECOGIDA":
                                                d = t.Cantidad;
                                                break;
                                            case "PTC LAVADOS":
                                                y = t.Cantidad;
                                                break;
                                            case "PTC RETENIDOS":
                                                I = t.Cantidad;
                                        }
                                        break;
                                    case "LAVADOS":
                                        u = t.Cantidad;
                                        break;
                                    case "SUBPRODUCTOS":
                                        g = t.Cantidad;
                                }
                            }),
                            huevos_recibidos_grafico(t, o, r, p, m, f, n, O, E, b, h, x, R, P, A, u, a, g, i, c, l, s, _, d, S, C, y, T, v, I);
                },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
            });
}
function ir_reporte_generico(e) {
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + e + ".jsp",
        beforeSend: function () {
            cargar_load(),
                    $("#contenedor_principal").html("");
        },
        success: function (e) {
            $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    cerrar_load(),
                    $(function () {
                        $(".accordion-titulo").click(function (e) {
                            e.preventDefault();
                            var t = $(this).next(".accordion-content");
                            "none" == t.css("display") ? (t.slideDown(250), $(this).addClass("open")) : (t.slideUp(250), $(this).removeClass("open"));
                        });
                    });
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function huevos_recibidos_grafico(e, t, o, r, a, n, i, c, l, s, d, _, p, u, f, m, g, h, O, b, E, S, C, y, T, v, I, A, x, P) {
    var R = parseFloat(parseInt(e) + parseInt(t) + parseInt(o) + parseInt(g) + parseInt(h)),
            w = parseFloat(parseInt(r) + parseInt(a) + parseInt(n) + parseInt(i) + parseInt(O) + parseInt(S) + parseInt(A) + parseInt(T)),
            N = parseFloat(parseInt(c) + parseInt(l) + parseInt(s) + parseInt(d) + parseInt(b) + parseInt(C) + parseInt(x) + parseInt(v)),
            L = parseFloat(parseInt(_) + parseInt(p) + parseInt(u) + parseInt(f) + parseInt(E) + parseInt(y) + parseInt(P) + parseInt(I)),
            D = {
                Clasificadoras: [
                    {
                        click: function (e) {
                            ((k = new CanvasJS.Chart("chartContainer", B)).options.data = D[e.dataPoint.name]), (k.options.title = {text: e.dataPoint.name}), k.render(), $("#backButton").removeClass("invisible");
                        },
                        type: "column",
                        showInLegend: !0,
                        legendMarkerColor: "grey",
                        legendText: "Totales recibidos: " + R.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."),
                        indexLabel: "{y}",
                        indexLabelFontColor: "#000000",
                        indexLabelPlacement: "inside",
                        fontSize: 16,
                        fontColor: "black",
                        fontWeight: "bold",
                        padding: 5,
                        indexLabelFontWeight: "bold",
                        toolTipContent: "<a  {name}> {label}</a><hr/>Total: {y}",
                        dataPoints: [
                            {y: parseInt(e), name: "Clasificadora A", label: "Clasificadora A", color: "green"},
                            {y: parseInt(t), name: "Clasificadora B", label: "Clasificadora B", color: "#ff0d11"},
                            {y: parseInt(o), name: "Clasificadora H", label: "Clasificadora H", color: "#ffff00"},
                            {y: parseInt(g), name: "Lavados", label: "Lavados", color: "pink"},
                            {y: parseInt(h), name: "Subproductos", label: "Subproductos", color: "cyan"},
                        ],
                    },
                ],
                "Clasificadora A": [
                    {
                        color: "#000000",
                        name: "Clasificadora A",
                        type: "column",
                        indexLabelFontColor: "#000000",
                        indexLabelFontWeight: "bold",
                        legendText: "Totales recibidos: " + w.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."),
                        type: "column",
                        showInLegend: !0,
                        indexLabelPlacement: "inside",
                        legendMarkerColor: "black",
                        indexLabel: "{y}",
                        type: "column",
                        toolTipContent: "<a  {name}> {label}</a><hr/>Total: {y}",
                        dataPoints: [
                            {y: parseInt(i), label: "PTC", color: "green"},
                            {y: parseInt(T), label: "RETENIDO LAVADOS", color: "green"},
                            {y: parseInt(A), label: "PTC RETENIDOS", color: "red"},
                            {y: parseInt(r), label: "REPROCESO", color: "yellow"},
                            {y: parseInt(a), label: "SUBPRODUCTOS", color: "#3a7df2"},
                            {y: parseInt(n), label: "ROTOS", color: "red"},
                            {y: parseInt(O), label: "HUEVOS SIN CLASIFICAR", color: "gray"},
                            {y: parseInt(S), label: "PENDIENTE RECOGIDA", color: "#47ff3d"},
                        ],
                    },
                ],
                "Clasificadora B": [
                    {
                        color: "#E7823A",
                        name: "Clasificadora B",
                        type: "column",
                        indexLabelFontWeight: "bold",
                        showInLegend: !0,
                        legendText: "Totales recibidos: " + N.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."),
                        type: "column",
                        showInLegend: !0,
                        legendMarkerColor: "grey",
                        indexLabel: "{y}",
                        indexLabelFontColor: "#000000",
                        indexLabelPlacement: "inside",
                        toolTipContent: "<a  {name}> {label}</a><hr/>Total: {y}",
                        dataPoints: [
                            {y: parseInt(d), label: "PTC", color: "green"},
                            {y: parseInt(v), label: "RETENIDO LAVADOS", color: "green"},
                            {y: parseInt(x), label: "PTC RETENIDOS", color: "red"},
                            {y: parseInt(c), label: "REPROCESO", color: "yellow"},
                            {y: parseInt(l), label: "SUBPRODUCTOS", color: "#3a7df2"},
                            {y: parseInt(s), label: "ROTOS", color: "red"},
                            {y: parseInt(b), label: "HUEVOS SIN CLASIFICAR", color: "gray"},
                            {y: parseInt(C), label: "PENDIENTE RECOGIDA", color: "#47ff3d"},
                        ],
                    },
                ],
                "Clasificadora H": [
                    {
                        color: "#E7823A",
                        name: "Clasificadora H",
                        type: "column",
                        showInLegend: !0,
                        indexLabelFontWeight: "bold",
                        type: "column",
                        showInLegend: !0,
                        legendMarkerColor: "grey",
                        legendText: "Totales recibidos: " + L.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."),
                        indexLabel: "{y}",
                        indexLabelFontColor: "#000000",
                        indexLabelPlacement: "inside",
                        toolTipContent: "<a  {name}> {label}</a><hr/>Total: {y}",
                        dataPoints: [
                            {y: parseInt(f), label: "PTC", color: "green"},
                            {y: parseInt(I), label: "RETENIDO LAVADOS", color: "green"},
                            {y: parseInt(P), label: "PTC RETENIDOS", color: "red"},
                            {y: parseInt(_), label: "REPROCESO", color: "yellow"},
                            {y: parseInt(p), label: "SUBPRODUCTOS", color: "#3a7df2"},
                            {y: parseInt(u), label: "ROTOS", color: "red"},
                            {y: parseInt(E), label: "HUEVOS SIN CLASIFICAR", color: "gray"},
                            {y: parseInt(y), label: "PENDIENTE RECOGIDA", color: "#47ff3d"},
                        ],
                    },
                ],
                Lavados: [
                    {
                        color: "#E7823A",
                        name: "Lavados",
                        type: "column",
                        showInLegend: !0,
                        indexLabelFontWeight: "bold",
                        type: "column",
                        showInLegend: !0,
                        legendMarkerColor: "grey",
                        legendText: "Totales recibidos: " + m.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."),
                        indexLabel: "{y}",
                        indexLabelFontColor: "#000000",
                        indexLabelPlacement: "inside",
                        toolTipContent: "<a  {name}> {label}</a><hr/>Total: {y}",
                        dataPoints: [{y: parseInt(m), label: "TRADICIONAL REPROCESO", color: "yellow"}],
                    },
                ],
                Subproductos: [
                    {
                        color: "#E7823A",
                        name: "Subproductos",
                        type: "column",
                        showInLegend: !0,
                        indexLabelFontWeight: "bold",
                        type: "column",
                        showInLegend: !0,
                        legendMarkerColor: "grey",
                        legendText: "Totales recibidos: " + h.toString().replace(/\B(?=(\d{3})+(?!\d))/g, "."),
                        indexLabel: "{y}",
                        indexLabelFontColor: "#000000",
                        indexLabelPlacement: "inside",
                        toolTipContent: "<a  {name}> {label}</a><hr/>Total: {y}",
                        dataPoints: [{y: parseInt(h), label: "SUBPRODUCTOS TRADICIONAL", color: "#3a7df2"}],
                    },
                ],
            },
            j = {
                animationEnabled: !0,
                theme: "dark",
                title: {text: "Huevos Recibidos Maehara"},
                subtitles: [{text: "Clic en cualquier columna para visualizar detalle.", backgroundColor: "#fff58c", fontSize: 16, fontColor: "black", padding: 5}],
                legend: {
                    fontFamily: "calibri",
                    fontSize: 14,
                    itemTextFormatter: function (e) {
                        return e.dataPoint.name + ": WEQE" + Math.round((e.dataPoint.y / 883e3) * 100) + "%";
                    },
                },
                data: [],
            },
            B = {
                animationEnabled: !0,
                theme: "dark",
                axisX: {labelFontColor: "#717171", lineColor: "#080101", tickColor: "#a2a2a2"},
                axisY: {gridThickness: 0, includeZero: !1, labelFontColor: "#717171", lineColor: "#080101", tickColor: "#a2a2a2", lineThickness: 1},
                data: [],
            },
            k = new CanvasJS.Chart("chartContainer", j);
    (k.options.data = D.Clasificadoras),
            k.render(),
            $("#backButton").click(function () {
        $(this).toggleClass("invisible"), ((k = new CanvasJS.Chart("chartContainer", j)).options.data = D.Clasificadoras), k.render();
    }),
            cerrar_load(),
            $("#btn_buscar").show();
}
function ir_pendientes_recogidas() {
    window.location.hash = "ptcPendientesRecogida";
    $.ajax({
        type: "POST",
        url: ruta_contenedores_ptc + "contenedor_registro_pendientes_recogidas.jsp",
        beforeSend: function () {
            cargar_load(), $("#contenedor_principal").html("");
        },
        success: function (e) {
            cerrar_load(),
                    $("#div_cargar_menu").hide(),
                    $("#contenedor_principal").html(e),
                    $("#contenedor_principal").show(),
                    cargar_estilo_calendario_insert("dd/mm/yyyy"),
                    $("#formulario").on("submit", function (e) {
                e.preventDefault(), registrar_pendientes_recogidas(), e.stopPropagation();
            });
        },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
    });
}
function registrar_pendientes_recogidas() {
    "" == $("#fecha_puesta").val()
            ? swal.fire({type: "error", title: "INGRESE FECHA DE PUESTA", confirmButtonText: "CERRAR"})
            : Swal.fire({
                title: "CONFIRMACION",
                text: "DESEA REGISTRAR LOS DATOS?",
                type: "warning",
                showCancelButton: !0,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "SI, REGISTRAR!",
                cancelButtonText : "NO, CANCELAR!",
            }).then((e) => {
        e.value &&
                $.ajax({
                    type: "POST",
                    url: ruta_controles_ptc + "control_registro_pendientes_recogidas.jsp",
                    data: $("#formulario").serialize(),
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "ESPERE<strong></strong>...",
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (e) {
                        aviso_registro_general(e.tipo_respuesta, e.mensaje, "registroRecogida");
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });
    });
}
function liberar_recogida(e, t, o) {
    Swal.fire({title: "CONFIRMACION", text: t, type: "warning", showCancelButton: !0, confirmButtonColor: "#3085d6", cancelButtonColor: "#d33", confirmButtonText: "ACEPTAR!", cancelButtonText: "CANCELAR!"}).then((t) => {
        t.value &&
                $.ajax({
                    type: "POST",
                    url: ruta_controles_ptc + "control_liberar_pendientes_recogidas.jsp",
                    data: {id: e, estado: o},
                    beforeSend: function () {
                        Swal.fire({
                            title: "PROCESANDO!",
                            html: "ESPERE<strong></strong>...",
                            allowOutsideClick: !1,
                             willOpen: () => {
                    Swal.showLoading()
                }
               
                        });
                    },
                    success: function (e) {
                        aviso_registro_general(e.tipo_respuesta, e.mensaje, "registroRecogida");
                    },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
                });
    });
}
function grilla_recogidas_liberadas() {
    swal.fire({
        html:
                "<a>LISTADO DE HUEVOS LIBERADOS EN RECOGIDAS</a><br><br><br>\n                <input type='text' value='INGRESE MES' class='form-control from_date' id='txt_mes' name='txt_name' >\n                <br></hr> <div id='contenido_grilla_liberadas' ></div>",
        showConfirmButton: !1,
    }),
            $(".from_date").pickadate({today: "Ok", format: "yyyy-mm", formatSubmit: "yyyy-mm-dd", hiddenPrefix: "prefix__", hiddenSuffix: "__suffix", selectYears: !0, selectMonths: !0}),
            $(document).on("change", "#txt_mes", function () {
        $.ajax({
            type: "POST",
            url: ruta_consultas_ptc + "generar_grilla_reco_liberados.jsp",
            data: {fecha_puesta: $("#txt_mes").val()},
            beforeSend: function () {
                cargar_load();
            },
            success: function (e) {
                $("#contenido_grilla_liberadas").html(e.grilla), cerrar_load();
            },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         }
        });
    });
}
function huevos_sc_liberar() {
    swal.fire({
        html:
                "<div style='display:none' class='alert alert-danger alert-dismissible fade show' role='alert' id='div_alerta'> \n          </div> \n        <a>LISTADO DE HUEVOS PENDIENTES DE ALIMENTACION</a><br><br><a>FECHA DE ALIMENTACION</a> \n                <input type='text' placeholder='INGRESE FECHA DE ALIMENTACION' class='form-control datepicker' id='txt_fecha' name='txt_fecha' >\n                <br><input type='button' value='LIBERAR' class='form-control' id='btnLiberar' name='btnLiberar' >\n                 <br></hr> <div id='contenido_grilla_liberadas' ></div> ",
        showConfirmButton: !1,
    }),
            cargar_estilo_calendario_insert("dd/mm/yyyy"),
            $.ajax({
                type: "POST",
                url: ruta_consultas_ptc + "generar_grilla_sc_liberar.jsp",
                data: {fecha_puesta: $("#txt_mes").val()},
                beforeSend: function () {
                    cargar_load();
                },
                success: function (e) {
                    $("#contenido_grilla_liberadas").html(e.grilla),
                            cerrar_load(),
                            $(".checkBoxChecked").on("click", function () {
                        var e = $(this).find(".Aps_checkbox");
                        e.prop("checked", !e.prop("checked"));
                    }),
                            $("#box_reproceso").on("click", function () {
                        var e = $("#box_reproceso").prop("checked");
                        $("#contenido_grilla_liberadas").find("input:checkbox").prop("checked", e);
                    }),
                            $("#btnLiberar").on("click", function () {
                        var e = $('[name="checks[]"]:checked')
                                .map(function () {
                                    return this.value;
                                })
                                .get()
                                .join(",");
                        0 == e.length
                                ? ($("#div_alerta").show(),
                                        $("#div_alerta").html("<strong><center>DEBE SELECCIONAR LOTES.</center></strong>   "),
                                        $("#div_alerta")
                                        .fadeTo(1e4, 5e3)
                                        .slideUp(5e3, function () {
                                            $("#div_alerta").slideUp(5e3);
                                        }))
                                : 0 == $("#txt_fecha").val().length
                                ? ($("#div_alerta").show(),
                                        $("#div_alerta").html("<strong><center>DEBE INGRESAR LA FECHA DE ALIMENTACION.</center>"),
                                        $("#div_alerta")
                                        .fadeTo(1e4, 5e3)
                                        .slideUp(5e3, function () {
                                            $("#div_alerta").slideUp(5e3);
                                        }))
                                : $.ajax({
                                    type: "POST",
                                    url: ruta_controles_ptc + "control_liberar_sc.jsp",
                                    data: {fecha_alimentacion: $("#txt_fecha").val(), contenido: e},
                                    beforeSend: function () {
                                        Swal.fire({
                                            title: "PROCESANDO!",
                                            html: "ESPERE<strong></strong>...",
                                            allowOutsideClick: !1,
                                             willOpen: () => {
                    Swal.showLoading()
                }
               
                                        });
                                    },
                                    success: function (e) {
                                        aviso_registro_general(e.tipo_respuesta, e.mensaje, "LiberacionSC");
                                    },
                                });
                    });
                },
         error: function(XMLHttpRequest, textStatus, errorThrown) {
             if(XMLHttpRequest.status==404 || XMLHttpRequest.status==500){
                  location.reload();
             }
         },
            });
}
function aviso_registro_general(e, t, o) {
    "1" == e
            ? (swal.fire({type: "success", text: t, confirmButtonText: "CERRAR"}), "registroRecogida" == o ? ir_pendientes_recogidas() : "LiberacionSC" == o || ("ptc_alimentacion" == o && ir_registro_carros_alimentados()))
            : swal.fire({type: "error", html: t, confirmButtonText: "CERRAR"});
}
