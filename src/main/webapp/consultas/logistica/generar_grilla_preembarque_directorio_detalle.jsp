<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%> 
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%> 
<%@ page session="true" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    try {

        ResultSet rs;
        Statement st = connection.createStatement();
        String tr = "";

        rs = st.executeQuery(" select * from v_mae_log_dir_detalle_pedidos order by 1 asc ");

        JSONObject ob = new JSONObject();
        ob = new JSONObject();

        String cabecera =  " <table  border='1' id='tbDetalle'  class='compact hover '   >"
                + "<thead>" 
                + "<th  style='color: #fff;'class='bg-navy'>Pedido</th>      "
                + "<th style='color: #fff;' class='bg-navy' >Area</th>"
                + "<th style='color: #fff; ' class='bg-navy' >Cantidad</th>"
                + "<th style='color: #fff; ' class='bg-navy' >Tipo</th>"
                + "<th style='color: #fff; ' class='bg-navy' >Nro. factura</th>"
                + "<th style='color: #fff; ' class='bg-navy' >Embarque</th>"
                + "</tr>"
                + "</thead> <tbody > ";

        while (rs.next()) {
            tr = tr
                    + "<tr>"
                    + "<td  >" + rs.getString("id_pedido") + "</td>"
                    + "<td   >" + rs.getString("area") + "</td>"
                    + "<td   >" + rs.getString("cantidad") + "</td>"
                    + "<td   >" + rs.getString("tipo_huevo") + "</td>"
                    + "<td   >" + rs.getString("nro_factura") + "</td>"
                    + "<td   >" + rs.getString("fecha_hora") + "</td>"
                    + "</tr>";
        }

        ob.put("grilla", cabecera + tr + "</tbody></table>");

        out.print(ob);
    } catch (Exception e) {
        String men = e.toString();
    } finally {
        connection.close();
    }
%> 