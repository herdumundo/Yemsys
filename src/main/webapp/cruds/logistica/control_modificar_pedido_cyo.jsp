<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="logistica.datos_pedidos_modificar"%>
<%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    if (sesion == true) {

        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        String json = request.getParameter("json");
        String id_pedido = request.getParameter("id_pedido");
        String mensaje_pedido = request.getParameter("mensaje");
        String area = (String) sesionOk.getAttribute("area_nuevo");
        String id_usuario = (String) sesionOk.getAttribute("id_usuario");
        String usuario = (String) sesionOk.getAttribute("user_name");
        
        
        String mensaje = "";
        int tipo_respuesta = 0;

        try {

            ObjectMapper mapper = new ObjectMapper();
            datos_pedidos_modificar[] pp1 = mapper.readValue(json, datos_pedidos_modificar[].class);

            SQLServerDataTable DataTableGrilla = new SQLServerDataTable();
            DataTableGrilla.addColumnMetadata("fecha_puesta", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("area", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("tipo", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("tipo_huevo", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("cantidad", java.sql.Types.INTEGER);
            DataTableGrilla.addColumnMetadata("categoria", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("cod_carrito", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("u_medida", java.sql.Types.VARCHAR);
            DataTableGrilla.addColumnMetadata("id_pedido", java.sql.Types.INTEGER);
            DataTableGrilla.addColumnMetadata("id_camion", java.sql.Types.INTEGER);

            for (datos_pedidos_modificar lotes : pp1) {
                DataTableGrilla.addRow(
                        lotes.fecha_puesta,
                        lotes.area,
                        lotes.tipo,
                        lotes.tipo_huevo,
                        lotes.cantidad,
                        lotes.categoria,
                        lotes.cod_carrito,
                        lotes.u_medida,
                        lotes.id_pedido,
                        lotes.id_camion
                );
            }

            connection.setAutoCommit(false);
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [mae_log_ptc_pedidos_modificar_cyo2](?,?,?,?,?,?,?,?)}");
            callableStatement.setObject(1, DataTableGrilla);
            callableStatement.setInt(2, Integer.parseInt(id_pedido));
            callableStatement.setInt(3, Integer.parseInt(id_usuario));
            callableStatement.setString(4, area);
            callableStatement.setString(5, usuario);
            callableStatement.setString(6, mensaje_pedido);

            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();
            tipo_respuesta = callableStatement.getInt("estado_registro");
            mensaje = callableStatement.getString("mensaje");
            if (tipo_respuesta == 0) {
                connection.rollback();
            } else {
                connection.commit();
                //  connection.rollback();
            }
        } catch (Exception e) {
            mensaje = e.toString();
            tipo_respuesta = 0;
        } finally {
            ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", tipo_respuesta);
            out.print(ob);
            connection.close();
        }
    }
%>