<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../chequearsesion.jsp" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%
// Creación del objeto JSON que se utilizará para la respuesta
JSONObject responseJSON = new JSONObject();
// Obteniendo el valor del parámetro "BarCode" de la solicitud
String bar_code = request.getParameter("BarCode");

try {
    // Llamamos al procedimiento almacenado con la cantidad de parámetros que le vamos a pasar
    String call = "{call stp_delete_transferencia_vimar(?, ?, ?)}";
    CallableStatement callableStatement = connection.prepareCall(call);
    // Subclase que establece los parámetros del procedimiento almacenado
    callableStatement.setString(1, bar_code);
    
    // Registro de parámetros de salida
    callableStatement.registerOutParameter(2, Types.VARCHAR);
    callableStatement.registerOutParameter(3, Types.INTEGER);
    
    // Ejecución del procedimiento almacenado
    callableStatement.execute();
    
    // Obtención de resultados del procedimiento almacenado
    String mensaje = callableStatement.getString(2);
    int tipo = callableStatement.getInt(3);
    
    // Configuración de la respuesta JSON
    responseJSON.put("tipo", tipo);
    responseJSON.put("msg", mensaje);  // Mensaje de éxito
    
} catch (SQLException e) {
    // Manejo de excepciones SQL y configuración de la respuesta JSON en caso de error
    responseJSON.put("tipo", 2);
    responseJSON.put("msg", "Error de SQL: " + e.getMessage());  // Mensaje de error SQL
}

// Envío de la respuesta JSON al cliente
out.print(responseJSON);
%>

