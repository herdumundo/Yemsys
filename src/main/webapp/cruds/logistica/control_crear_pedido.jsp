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
<%@page contentType="application/json; charset=utf-8" %>

<%    
    clases.controles.connectarBD();
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    String id_camion = request.getParameter("id_camion");
    String id_chofer = request.getParameter("id_chofer");
    String cantidad_total = request.getParameter("cantidad_total");

    String obs = request.getParameter("obs");
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    String mensaje = "";
    int tipo_respuesta = 0;
    try {

        clases.controles.connect.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = clases.controles.connect.prepareCall("{call [mae_log_ptc_pedidos_crear](?,?,?,?,?,?,?)}");
        callableStatement.setInt(1, Integer.parseInt(cantidad_total));
        callableStatement.setInt(2, Integer.parseInt(id_camion));
        callableStatement.setInt(3, Integer.parseInt(id_usuario));
        callableStatement.setString(4, id_chofer);
        callableStatement.setString(5, obs);

        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");
        if (tipo_respuesta == 0) {
            clases.controles.connect.rollback();
        } else {
            //  clases.controles.connect.rollback(); 

            clases.controles.connect.commit();
        }

    } catch (Exception e) {
        mensaje = e.toString();
        tipo_respuesta = 0;
    } finally {
        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        out.print(ob);
        clases.controles.DesconnectarBD();
    }
%>