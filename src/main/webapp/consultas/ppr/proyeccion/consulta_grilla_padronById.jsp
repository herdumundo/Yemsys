<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="../../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%
    StringBuilder tabla = new StringBuilder();
    String      id   = request.getParameter("id");
    String      nombrePadron   = request.getParameter("nombrePadron");
    
    
    try {
        PreparedStatement pst = connection.prepareStatement("select * from ppr_padrones_det where padron_id="+id+" ");
        ResultSet rs = pst.executeQuery();
        tabla.append("<table id='grillaPadronById' class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable'>");
        tabla.append("<thead>");
        tabla.append("<tr>");
        // Añadir el encabezado que abarca todas las columnas y centrarlo
        tabla.append("<th colspan='7' style='text-align: center;'>"+nombrePadron+"</th>");
        tabla.append("</tr>");
        tabla.append("<tr>");
        tabla.append("<th>Edad</th>");
        tabla.append("<th>Viabilidad</th>");
        tabla.append("<th>Productividad</th>");
        tabla.append("<th>Mortandad diaria</th>");
        tabla.append("</tr>");
        tabla.append("</thead>");
        tabla.append("<tbody>");

        while (rs.next()) {
       
            tabla.append("<tr>");
            tabla.append("<td>").append(rs.getString("edad")).append("</td>");
            tabla.append("<td  class=\"single_line2\"  contenteditable=\"true\">").append(rs.getString("viabilidad")).append("</td>");
            tabla.append("<td   class=\"single_line2\"  contenteditable=\"true\">").append(rs.getString("productividad")).append("</td>");
            tabla.append("<td   class=\"single_line2\"  contenteditable=\"true\">").append(rs.getString("mortandad_diaria")).append("</td>");
            tabla.append("</tr>");
        }
        tabla.append("</tbody>");
        tabla.append("</table> <input type=\"button\" class=\"btn bg-warning\" value=\"Actualizar datos\" onclick=\"registrarCambiosPadron("+id+")\">");
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
