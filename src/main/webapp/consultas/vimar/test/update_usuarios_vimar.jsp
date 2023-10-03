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
String ci_update      = request.getParameter("cedulaUpdate");
String nombre_update  = request.getParameter("nombreUpdate");
String apellido_update= request.getParameter("apellidoUpdate");
String telefono_update= request.getParameter("telefonoUpdate");
String ciudad_update  = request.getParameter("ciudadUpdate");
String edad_update    = request.getParameter("edadUpdate");

try {
    String call = "{call updatePersonaPrueba(?,?,?,?,?,?,?,?)}";
    CallableStatement callableStatement = connection.prepareCall (call);
    callableStatement.setString(1, ci_update);
    callableStatement.setString(2, nombre_update);
    callableStatement.setString(3, apellido_update);
    callableStatement.setString(4, telefono_update);
    callableStatement.setString(5, ciudad_update);
    callableStatement.setString(6, edad_update);
    callableStatement.registerOutParameter(7, Types.VARCHAR);
    callableStatement.registerOutParameter(8, Types.INTEGER);
    
    callableStatement.execute();
    
    String mensaje = callableStatement.getString(7);
    int tipo = callableStatement.getInt(8);
        updateJSON.put("tipo", tipo);
        updateJSON.put("msg", mensaje);
}
catch (SQLException e){
        updateJSON.put("tipo", 2);
        updateJSON.put("msg", 2);
}
out.print(updateJSON);

%>
