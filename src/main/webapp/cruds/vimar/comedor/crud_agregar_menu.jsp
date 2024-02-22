<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>


<%
// Creación del objeto JSON que se utilizará para la respuesta    
JSONObject responseJSON =   new JSONObject();
// Obteniendo el valor del parámetro "CardCode" de la solicitud
String menu   =   request.getParameter("txt_menu");


    
    try {
            //llamamos al procedimiento de almacenado con la cantidad parametros que le vamos a pasar    
            String call = "{call vim_insert_nuevo_menu(?, ?, ?)}";
            CallableStatement callableStatement = connection.prepareCall(call);
            //sub clase que llama el PDA( nro de argumento, variable a la que agregamos los valores)
            callableStatement.setString(1, menu);
            
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
                responseJSON.put("tipo", 0);
                responseJSON.put("msg", "Error de SQL: " + e.getMessage());  // Mensaje de error SQL
            }
            // Envío de la respuesta JSON al cliente
            out.print(responseJSON);
%> 

