<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%  // Creación del objeto JSON que se utilizará para la respuesta    
    JSONObject responseJSON = new JSONObject();
    String valores = request.getParameter("contenedor");
    String[] valores_array = valores.split(",");
    String contenedor_principal = "";
    String codigo = "";
    String fecha = "";

    connection.setAutoCommit(false);

    try {
        for (int i = 0; i < valores_array.length; i++) {
            contenedor_principal = valores_array[i];

            String[] sub_valores_array = contenedor_principal.split("-");
            fecha = sub_valores_array[0];
            codigo = sub_valores_array[1];

            String call = "{call vim_insert_menu_semanal(?, ?, ?, ?)}";
            CallableStatement callableStatement = connection.prepareCall(call);
            callableStatement.setString(1, fecha);
            callableStatement.setString(2, codigo);
            // Registro de parámetros de salida
            callableStatement.registerOutParameter(3, Types.VARCHAR); // mensaje
            callableStatement.registerOutParameter(4, Types.INTEGER); // tipo  
            callableStatement.execute();
            // Obtención de resultados del procedimiento almacenado
            String mensaje = callableStatement.getString(3);
            int tipo = callableStatement.getInt(4);

            // Configuración de la respuesta JSON
            responseJSON.put("msg", mensaje);
            responseJSON.put("tipo", tipo);

        }

        connection.commit();
    } catch (SQLException e) {
        // Manejo de excepciones SQL y configuración de la respuesta JSON en caso de error
        responseJSON.put("tipo", 0);
        responseJSON.put("msg", "Error de SQL: " + e.getMessage());  // Mensaje de error SQL
        connection.rollback();
    } finally {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            // Manejo de excepciones SQL y configuración de la respuesta JSON en caso de error
            responseJSON.put("tipo", 0);
            responseJSON.put("msg", "Error de SQL: " + e.getMessage());  // Mensaje de error SQL
        }
    }

    out.print(responseJSON);
%>
