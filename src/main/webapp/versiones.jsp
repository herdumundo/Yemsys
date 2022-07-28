<%-- 
    Document   : versiones
    Created on : 30-may-2022, 16:41:50
    Author     : hvelazquez
--%>

<%
    String contenedores_embarque_informe_factura = "0094-PAN-27062022-A";
    String desc_contenedores_embarque_informe_factura = "0094-PAN-27062022-A";

    String contenedores_logistica_pedidos_pendientes = "0001-REP-15032022-A";
    String desc_contenedores_logistica_pedidos_pendientes = "0001-REP-15032022-A";

   
    
    
    
    String contenedores_embarque_contenedor_reporte_embarque = "0002-REP-15032022-A";
    String desc_contenedores_embarque_contenedor_reporte_embarque = "0002-REP-15032022-A";

    String contenedores_embarque_registro_embarque = "0003-REP-15032022-A";

    String contenedores_logistica_contenedor_pedidos = "0070-PAN-09042022-A";
    String desc_contenedores_logistica_contenedor_pedidos = "SE AGREGO COLUMNA RESERVAS PARA PEDIDOS Y BOTON DE REFRESCAR PEDIDO POR CAMION";

    String contenedores_logistica_contenedor_pedidos_generados_menu = "0074-PAN-08042022-A";
    String desc_contenedores_logistica_contenedor_pedidos_generados_menu = " &0071-PAN-09042022-A: EN MODIFICACION SE AGREGO COLUMNA PARA RESERVAS.&0074-PAN-08042022-A: SE AGREGÓ LA OPCIÓN DE MODIFICAR EL CAMION DEL PEDIDO.";

    String contenedores_logistica_contenedor_pedidos_facturar = "0100-PAN-15072022-A";
    String desc_contenedores_logistica_contenedor_pedidos_facturar = "&0075-PAN-08042022-A: SE AGREGO LA ASIGNACION DE NRO DE FACTURA AUTOMATICA AL PEDIDO, AL GENERAR LA FACTURA EN SAP"+
                                                                     "&0100-PAN-15072022-A: SE AGREGO EL BOTÓN DE COPIAR GRILLA, PARA LA SIMPLIFICACION Y AGILIZACION DEL PEGADO AL SISTEMA SAP  ";

    String contenedores_logistica_contenedor_pedidos_generados_cyo =        "0093-PAN-23062022-A";
    String desc_contenedores_logistica_contenedor_pedidos_generados_cyo =   "0093-PAN-23062022-A:SE AGREGÓ LA DESCARGA EN PDF DEL PEDIDO.";
    
    
    String contenedores_logistica_contenedor_reporte = "0008-REP-15032022-A";

    String contenedores_ppr_vista_informe_aviarios_dinamico = "0009-REP-15032022-A";
    String contenedores_ppr_vista_informe_aviarios = "0010-REP-15032022-A";
    String contenedores_ppr_vista_grilla_contadores_de_huevos = "0011-REP-15032022-A";
    String contenedores_ppr_vista_mortandad_lotes = "0012-REP-15032022-A";
    String contenedores_ppr_vista_informe_consumo_balanceado_bloque = "0013-REP-15032022-A";
    String contenedores_ppr_vista_vista_mortandad_80_sems = "0014-REP-15032022-A";
    String contenedores_ppr_vista_datos_contadores = "0015-REP-15032022-A";
    String contenedores_ppr_vista_contadores_huevos = "0016-REP-15032022-A";
    String contenedores_ppr_vista_registro_de_datos_diarios_A = "0017-REP-15032022-A";

    String contenedores_mis_contenedor_registro = "0090-PAN-17042022-A";
    String desc_contenedores_mis_contenedor_registro = "&" + contenedores_mis_contenedor_registro + ": SE AGREGO LOS MINUTOS A LA HORA DE CLASIFICACION, Y LOS AVIARIOS INVOLUCRADOS.";

    String contenedores_mis_contenedor_carro_mesa = "0019-REP-15032022-A";
    String contenedores_mis_contenedor_informe = "0020-REP-15032022-A";
    String contenedores_mis_contenedor_eliminar = "0021-REP-15032022-A";

    String contenedores_mis_contenedor_registro_transferencias_reprocesos = "0088-PAN-10052022-A";
    String desc_contenedores_mis_contenedor_registro_transferencias_reprocesos = "&0088-PAN-10052022-A: SE AGREGO LA OPCION (HUEVO EN POLVO) COMO DESTINO.";

    String contenedores_mis_contenedor_transferencia_subproducto = "0091-PAN-07062022-A";
    String desc_contenedores_mis_contenedor_transferencia_subproducto = "&0087-PAN-10052022-A: SE AGREGO LA OPCION (HUEVO EN POLVO ) COMO DESTINO.&"+
                                                                        "&0091-PAN-07062022-A: SE AGREGÓ TRANSFERENCIAS DE HUEVOS ROTOS";

    String contenedores_mis_contenedor_informe_pendientes_alimentacion = "0089-PAN-15042022-A";
    String desc_contenedores_mis_contenedor_informe_pendientes_alimentacion = "&0089-PAN-15042022-A: SE AGREGO TOTAL DE HUEVOS PENDIENTES A ALIMENTAR";

    String contenedores_mis_contenedor_registro_tradicional = "0025-REP-15032022-A";

    String contenedores_vista_permisos = "0026-REP-15032022-A";
    String contenedores_ppr_vista_registrar_usuario = "0027-REP-15032022-A";
    
    
    String grilla_ppr_grilla_usuarios = "0028-REP-15032022-A";
    
    
    String contenedores_ppr_vista_registrar_roles = "0029-REP-15032022-A";
    String grilla_ppr_grilla_rol = "0030-REP-15032022-A";

    String contenedores_ptc_contenedor_registro = "0031-REP-15032022-A";
    String contenedores_ptc_contenedor_registro_retenido = "0032-REP-15032022-A";
    String contenedores_ptc_contenedor_registro_alimentados = "0033-REP-15032022-A";
    String contenedores_ptc_contenedor_registro_SC = "0034-REP-15032022-A";
    String contenedores_ptc_contenedor_registro_pendientes_recogidas = "0035-REP-15032022-A";
    String contenedores_ptc_contenedor_transformacion_pallet_carro = "0036-REP-15032022-A";
    String contenedores_ptc_contenedor_movimientos = "0037-REP-15032022-A";
    String contenedores_ptc_contenedor_disposicion = "0038-REP-15032022-A";
    String contenedores_ptc_contenedor_fecha_involucrada = "0039-REP-15032022-A";
    String contenedores_ptc_contenedor_eliminar = "0040-REP-15032022-A";
    String contenedores_ptc_contenedor_informe = "0041-REP-15032022-A";

    String contenedores_ptc_transferencia_almacenamiento = "0081-PAN-03052022-A";
    String desc_contenedores_ptc_transferencia_almacenamiento = "SE AGREGO LA OPCION  HUEVO EN POLVO  COMO DESTINO.";

    String contenedores_ptc_transferencia_procesar = "0082-PAN-04052022-A";
    String desc_contenedores_ptc_transferencia_procesar = "SE AGREGO LA OPCION  HUEVO EN POLVO  COMO DESTINO.";

    String contenedores_ptc_contenedor_transferencia_SC = "0044-REP-15032022-A";
    String grillas_ptc_grilla_motivo_retencion = "0045-REP-15032022-A";
    String contenedores_ptc_contenedor_empacadora = "0046-REP-15032022-A";
    String contenedores_logistica_contenedor_pedidos_x = "0004-REP-15032022-A";

    String contenedores_ptc_contenedor_reporte_carros = "0047-REP-15032022-A";
    String contenedores_ptc_contenedor_reporte_mixtos_variable = "0048-REP-15032022-A";
    String contenedores_ptc_contenedor_reporte_clasificados = "0049-REP-15032022-A";
    String contenedores_ptc_contenedor_info_ptc_excel = "0050-REP-15032022-A";
    String contenedores_ptc_contenedor_reporte_transferencia = "0069-REP-21032022-A";
    String contenedores_ptc_contenedor_informe_huevo_recibido = "0052-REP-15032022-A";
    String contenedores_ptc_contenedor_reporte_huevos_sc = "0053-REP-15032022-A";
    String contenedores_mis_contenedor_pdf_reproceso = "0054-REP-15032022-A";
    String contenedores_mis_contenedor_reporte_rotos = "0055-REP-15032022-A";
    String contenedores_mis_contenedor_pdf_transferencia_reproceso = "0056-REP-15032022-A";
    String contenedores_mis_contenedor_pdf_reproceso_tradicional = "0057-REP-15032022-A";
    String contenedores_logistica_contenedor_pedidos_x2 = "0004-REP-15032022-A";
    String contenedores_ptc_contenedor_reporte_reprocesados = "0058-REP-15032022-A";

    String contenedores_ptc_contenedor_registro_reprocesos_lista = "0076-PAN-20042022-A";
    String desc_contenedores_ptc_contenedor_registro_reprocesos_lista = "SE AGREGO LA OPCION DE LA APERTURA DE MULTIPLES ALIMENTACIONES POR CLASIFICADORA.";

    String contenedores_ptc_contenedor_registro_liberados_viejos = "0060-REP-15032022-A";
    String contenedores_ptc_contenedor_registro_retenido_costeados = "0061-REP-15032022-A";
    String contenedores_ptc_contenedor_reemplazo_motivos = "0062-REP-15032022-A";
    String contenedores_ptc_contenedor_reporte_retenidos_historico = "0063-REP-15032022-A";
    String contenedores_ptc_contenedor_cambio_fp = "0064-REP-15032022-A";
    String contenedores_ptc_contenedor_cambio_nro_ptc = "0065-REP-15032022-A";
    String contenedores_ptc_contenedor_transformacion_PTC = "0066-REP-15032022-A";
    String contenedores_mis_contenedor_registro_tipo_reproceso = "0067-REP-15032022-A";

    String grillas_ptc_grilla_pendiente_liberacion = "0068-REP-15032022-A";

    String contenedores_ptc_informe_kpi_dinamico = "0069-REP-09042022-A";
    String DESC_contenedores_ptc_informe_kpi_dinamico = "Nuevo";

    String contenedores_ptc_stock_cyo = "0084-PAN-09052022-A";
    String desc_contenedores_ptc_stock_cyo = "&0084-PAN-09052022-A: SE HA REALIZADO LA VISUALIZACION DE LOTES POR CLASIFICADORAS, EL USUARIO VISUALIZARA SOLO EL STOCK DE SU AREA.";

    String contenedores_stok_vimar_directorio = "0073-PAN-03052022-A";
    String desc_contenedores_stok_vimar_directorio = "&0073-PAN-03052022-A: SE AGREGARON EN LAS CABECERAS DE LAS COLUMNAS, LA CANTIDAD TOTAL , Y CANTIDADES TOTALES POR CLASIFICADORAS.";

    String contenedores_subproducto_tradicional = "0077-PAN-20042022-A ";
    String desc_contenedores_subproducto_tradicional = " ";

    String contenedores_eliminar_subproducto_tradicional = " 0078-PAN-20042022-A";
    String desc_contenedores_eliminar_subproducto_tradicional = " ";

    String contenedores_alimentacion_hp = " 0079-PAN-01062022-A";
    String desc_contenedores_alimentacion_hp = " ";

    String contenedores_informes_alimentados_hp = "0080-PAN-01062022-A";
    String desc_contenedores_informes_alimentados_hp = " ";

    String contenedores_mortandad_mensual = "0085-PAN-20032022-A";
    String desc_contenedores_mortandad_mensual = " ";

    String contenedores_registro_necropsia = "0086-PAN-03042022-A";
    String desc_contenedores_registro_necropsia = " ";

    String contenedores_bal_solicitudad_cambio_formula = "0092-PAN-09062022-A";
    String desc_contenedores_bal_solicitudad_cambio_formula = " ";


    String contenedores_bal_pendiente_aprobacion = "0095-PAN-29062022-A";
    String desc_contenedores_bal_pendiente_aprobacion = " ";

String contenedores_bal_pendiente_aprobacion_gerencia = "0096-PAN-09062022-A";
    String desc_contenedores_bal_pendiente_aprobacion_gerencia = " ";

    String contenedores_bal_formula_procesar = "0097-PAN-09062022-A";
    String desc_contenedores_bal_formula_procesar = " ";


    String contenedores_bal_informe = "0098-PAN-30062022-A";
    String desc_contenedores_bal_informe = " ";


    String contenedores_bal_pendientes_creados_usuario = "0099-PAN-30062022-A";
    String desc_contenedores_bal_pendientes_creados_usuario = " ";
%>