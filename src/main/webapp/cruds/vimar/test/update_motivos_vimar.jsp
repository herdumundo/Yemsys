<%-- 
    Document   : update_usuarios_vimar
    Created on : 21-ago-2023, 8:33:31
    Author     : jbernal
--%>

<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%
JSONObject updateJSON = new JSONObject();
String id                 = request.getParameter("id");
String motivo             = request.getParameter("motivoModal");

try {
    String call = "{call stp_editar_motivo_vimar(?,?,?,?)}";
    CallableStatement callableStatement = connection.prepareCall (call);
    callableStatement.setString(1, id);
    callableStatement.setString(2, motivo);
    callableStatement.registerOutParameter(3, Types.VARCHAR);
    callableStatement.registerOutParameter(4, Types.INTEGER);
    
    callableStatement.execute();
    
    String mensaje = callableStatement.getString(3);
    int tipo = callableStatement.getInt(4);
        updateJSON.put("tipo", tipo);
        updateJSON.put("msg", mensaje);
}
catch (SQLException e){
        updateJSON.put("tipo", 1);
        updateJSON.put("msg", 1);
}
out.print(updateJSON);

%>
