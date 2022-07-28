<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<% 
            if (sesion == true) {

     JSONObject ob = new JSONObject();
    ob = new JSONObject();
    String id_camion = request.getParameter("id_camion");
    String id_chofer = request.getParameter("id_chofer");
    String cantidad_total = request.getParameter("cantidad_total");
    String id_pedido = request.getParameter("id_pedido");

    String obs = request.getParameter("obs");
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    String mensaje = "";
    int tipo_respuesta = 0;
    try 
    {

        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [mae_log_ptc_pedidos_modificar](?,?,?,?,?,?,?,?)}");
        callableStatement.setInt(1, Integer.parseInt(cantidad_total));
        callableStatement.setInt(2, Integer.parseInt(id_camion));
        callableStatement.setInt(3, Integer.parseInt(id_usuario));
        callableStatement.setString(4, id_chofer);
        callableStatement.setString(5, obs);
        callableStatement.setInt(6, Integer.parseInt(id_pedido));

        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");
        if (tipo_respuesta == 0) {
            connection.rollback();
        } else {
            //  clases.controles.connect.rollback(); 

            connection.commit();
        }

    } catch (Exception e) 
    {
        mensaje = e.toString();
        tipo_respuesta = 0;
    } 
    finally 
    {
        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        out.print(ob);
        connection.close();
    }}
%>