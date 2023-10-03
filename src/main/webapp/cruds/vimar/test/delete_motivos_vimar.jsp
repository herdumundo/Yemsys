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
JSONObject deleteJSON = new JSONObject();
String id = request.getParameter("id");


try {
    String call = "{call stp_eliminar_motivo_vimar(?,?,?)}";
    CallableStatement callableStatement = connection.prepareCall (call);
    callableStatement.setString(1, id);
    callableStatement.registerOutParameter(2, Types.VARCHAR);
    callableStatement.registerOutParameter(3, Types.INTEGER);
    
    callableStatement.execute();
    
    String mensaje = callableStatement.getString(2);
    int tipo = callableStatement.getInt(3);
        deleteJSON.put("tipo", tipo);
        deleteJSON.put("msg", mensaje);
}
catch (SQLException e){
        deleteJSON.put("tipo", 1);
        deleteJSON.put("msg", 1);
}
out.print(deleteJSON);

%>
