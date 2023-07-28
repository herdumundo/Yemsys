<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="../../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%
    StringBuilder tabla = new StringBuilder();
    DecimalFormat formatea = new DecimalFormat("###,###.##");

    try {
        PreparedStatement pst = connection.prepareStatement("SELECT id, aviario, lote, cantidad_aves,case when ubicacion='PRED' then fecha_predescarte else fecha_produccion end as fecha_produccion, case when ubicacion='PRED' then fecha_salida_predescarte else fecha_predescarte end as fecha_predescarte, ubicacion FROM ppr_pry_cab");
        ResultSet rs = pst.executeQuery();
        tabla.append("<table id='grillaLotesTotalPry' class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable'>");
        tabla.append("<thead>");
        tabla.append("<tr>");
        // Añadir el encabezado que abarca todas las columnas y centrarlo
        tabla.append("<th colspan='7' style='text-align: center;'>Total de lotes creados</th>");
        tabla.append("</tr>");
        tabla.append("<tr>");
        tabla.append("<th>Id lote</th>");
        tabla.append("<th>Aviario</th>");
        tabla.append("<th>Lote</th>");
        tabla.append("<th>Aves</th>");
        tabla.append("<th>Entrada</th>");
        tabla.append("<th>Salida</th>");
        tabla.append("<th>Ubicación</th>");
        tabla.append("</tr>");
        tabla.append("</thead>");
        tabla.append("<tbody>");

        while (rs.next()) {
            String ubicacion = rs.getString("ubicacion");
            String clonClass = ubicacion.equals("PRED") ? "badge-danger" : "badge-success";
            String clon = String.format("<h7><span class='badge %s right'>%s</span></h7>", clonClass, ubicacion);
            tabla.append("<tr>");
            tabla.append("<td>").append(rs.getString("id")).append("</td>");
            tabla.append("<td>").append(rs.getString("aviario")).append("</td>");
            tabla.append("<td>").append(rs.getString("lote")).append("</td>");
            tabla.append("<td>").append(formatea.format(rs.getInt("cantidad_aves"))).append("</td>");
            tabla.append("<td>").append(rs.getString("fecha_produccion")).append("</td>");
            tabla.append("<td>").append(rs.getString("fecha_predescarte")).append("</td>");
            tabla.append("<td>").append(clon).append("</td>");
            tabla.append("</tr>");
        }
        tabla.append("</tbody>");
        tabla.append("</table>");
        rs.close();
        pst.close();
    } catch (SQLException e) {
        // Manejo de excepciones (opcional)
        e.printStackTrace();
    }

    JSONObject ob = new JSONObject();
    ob.put("grilla", tabla.toString());
    out.println(ob);
%>
