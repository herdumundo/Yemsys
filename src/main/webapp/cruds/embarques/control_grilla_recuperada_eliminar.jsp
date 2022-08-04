<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%    
          if (sesion == true) {
  
     String numero_factura = request.getParameter("nro_factura");
    String area = (String) sesionOk.getAttribute("area_gm");
    int id = Integer.parseInt(request.getParameter("id"));
    int mensaje = 0;
    try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call pa_embarque_pendientes_eliminar(?,?,?,?)}");
        callableStatement.setString(1, area);
        callableStatement.setInt(2, Integer.parseInt(numero_factura.substring(numero_factura.length() - 7)));
        callableStatement.setInt(3, id);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
        callableStatement.execute();
        mensaje = callableStatement.getInt("mensaje");
        connection.commit();
    } catch (Exception e) {
        connection.rollback();

    } finally {
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        connection.close();
        out.print(ob);
    }}
%>  