<%-- 
    Document   : informe_factura
    Created on : 05/03/2020, 11:04:47 AM
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    
    JSONObject ob2 = new JSONObject();
    JSONArray jarray = new JSONArray();
    JSONArray jarray2 = new JSONArray();
    String area = (String) sesionOk.getAttribute("clasificadora");
    try {
        controles.connectarBD();
        String query = "select "
                + "convert(date,fecha_puesta) as fecha_puesta, "
                + "cod_carrito,cantidad,origen,tipo_huevo,"
                + "desFallaZona  "
                + "from  v_mae_ptc_pendientes_alimentacion  order by  fecha_puesta asc";
        if (area.equals("HP")) {
            query = " select "
                    + "convert(date,fecha_puesta) as fecha_puesta,"
                    + "cod_carrito,"
                    + "cantidad,"
                    + "clasificadora_origen as origen, "
                    + "tipo_huevo,"
                    + "desFallaZona "
                    + " from lotes a left outer join fallas b on a.zona_falla=b.codigo where clasificadora_actual='HP' and fecha_alimentacion is null ";
        }
        Statement stmt = clases.controles.connect.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            jarray = new JSONArray();
            jarray.put(rs.getString("fecha_puesta"));
            jarray.put(rs.getString("cod_carrito"));
            jarray.put(rs.getString("cantidad"));
            jarray.put(rs.getString("origen"));
            jarray.put(rs.getString("tipo_huevo"));
            jarray.put(rs.getString("desFallaZona"));
            jarray2.put(jarray);
        }
        ob2.put("data", jarray2);
    } catch (Exception e) {
        String error = e.getMessage();
    } finally {
        clases.controles.DesconnectarBD();
        out.print(ob2);
    }
%>

