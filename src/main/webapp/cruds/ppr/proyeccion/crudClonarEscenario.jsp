<%-- 
    Document   : consulta_max
    Created on : 26/01/2022, 16:40:32
    Author     : aespinola
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%
    String idEscenario   = request.getParameter("id");
    String nombreEscenario   = request.getParameter("nombreEscenario");
 
    int tipo_respuesta = 0;
    String mensaje = "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();

   try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call ppr_pry_copiar_escenario(?,?,?,?)}");
        callableStatement.setInt(1, Integer.parseInt(idEscenario));
        callableStatement.setString(2, nombreEscenario);
         
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        if (tipo_respuesta == 0) 
        {
            connection.rollback();
        } 
        else 
        {
          connection.commit();
            //  connection.rollback();
        }
    } catch (Exception e) 
    {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        connection.rollback();
    } finally {

        connection.close();
        out.print(ob);
    }
%>
