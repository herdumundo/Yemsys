<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%    if (sesion == true) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        String area = (String) sesionOk.getAttribute("area_gm");
        String area_cch = (String) sesionOk.getAttribute("area");
        int tipo = 0;
        String mensaje = "";

        try {
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [mae_cch_embarque_insertar_lotes_disponibles](?,?,?)}");
            callableStatement.setString(1, area_cch);
            callableStatement.setString(2, area);

            callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
            callableStatement.execute();
            tipo = callableStatement.getInt("mensaje");
            mensaje = "LOTES SINCRONIZADOS CON EXITO.";
        } catch (Exception e) {
            mensaje = e.toString();
            tipo = 0;
        } finally {
            connection.close();
            JSONObject ob = new JSONObject();
            ob = new JSONObject();
            ob.put("tipo", tipo);
            ob.put("mensaje", mensaje);
            out.print(ob);
        }
    }
%>  


