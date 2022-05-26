<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%         clases.controles.connectarBD();
    String numero_factura = request.getParameter("nro_factura");
    String area = (String) sesionOk.getAttribute("area_gm");
    int id = Integer.parseInt(request.getParameter("id"));
    int mensaje = 0;
    try {
        clases.controles.connect.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = clases.controles.connect.prepareCall("{call pa_embarque_pendientes_eliminar(?,?,?,?)}");
        callableStatement.setString(1, area);
        callableStatement.setInt(2, Integer.parseInt(numero_factura.substring(numero_factura.length() - 7)));
        callableStatement.setInt(3, id);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
        callableStatement.execute();
        mensaje = callableStatement.getInt("mensaje");
        clases.controles.connect.commit();
    } catch (Exception e) {
        clases.controles.connect.rollback();

    } finally {
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        clases.controles.DesconnectarBD();
        out.print(ob);
    }
%>  