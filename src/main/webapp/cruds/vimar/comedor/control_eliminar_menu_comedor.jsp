<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%@page import="org.json.JSONObject"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    JSONObject responseJSON = new JSONObject();
    String id = request.getParameter("id");

    try {
        String call = "{call vim_rrhh_eliminar_menu(?, ?, ?)}";
        CallableStatement callableStatement = connection.prepareCall(call);
        callableStatement.setString(1, id);
        callableStatement.registerOutParameter(2, Types.INTEGER);
        callableStatement.registerOutParameter(3, Types.VARCHAR);
        callableStatement.execute();

        int tipo = callableStatement.getInt(2);
        String mensaje = callableStatement.getString(3);

        responseJSON.put("tipo", tipo);
        responseJSON.put("msg", mensaje);
    } catch (SQLException e) {
        responseJSON.put("tipo", 0);
        responseJSON.put("msg", "Error de SQL: " + e.getMessage());
    } finally {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            responseJSON.put("tipo", 0);
            responseJSON.put("msg", "Error de SQL: " + e.getMessage());
        }
    }

    out.print(responseJSON);
%>
