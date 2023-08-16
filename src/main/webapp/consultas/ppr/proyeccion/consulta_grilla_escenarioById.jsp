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
    String      nombre   = request.getParameter("nombre");
        JSONObject ob = new JSONObject();
        String option="";
        String option2="";
    
    try {
        PreparedStatement pst = connection.prepareStatement("select * from v_ppr_escenario_det  where escenario_id="+id+" ");
        ResultSet rs = pst.executeQuery();
        tabla.append("<table id='grillaPadronById' class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable'>");
        tabla.append("<thead>");
        tabla.append("<tr>");
        // Añadir el encabezado que abarca todas las columnas y centrarlo
        tabla.append("<th colspan='7' style='text-align: center;'>"+nombre+"</th>");
        tabla.append("</tr>");
        tabla.append("<tr>");
        tabla.append("<th>Nro. Escenario</th>");
        tabla.append("<th>Raza</th>");
        tabla.append("<th>Periodo</th>");
        tabla.append("<th>Calculo Mortandad</th>");
        tabla.append("<th>Padron Mortandad</th>");
        tabla.append("<th>Parametro General</th>");
        tabla.append("<th>Mortandad Recria</th>");
        tabla.append("<th>Mortandad Produccion Primaria</th>");
        tabla.append("<th>Mortandad Pre descarte</th>");
        tabla.append("<th>Calculo Produccion</th>");
        tabla.append("<th>Parametro General</th>");
        tabla.append("<th>Padron Produccion</th>");
        tabla.append("<th>Mortandad Recria</th>");
        tabla.append("<th>Mortandad Produccion Primaria</th>");
        tabla.append("<th>Mortandad Pre descarte</th>");
        tabla.append("</tr>");
        tabla.append("</thead>");
        tabla.append("<tbody>");

        while (rs.next()) {
            PreparedStatement pst2 = connection.prepareStatement(" select * from ppr_tipo_calculo ");
            ResultSet rs2 = pst2.executeQuery();
            while (rs2.next()) {
                option=option+"<option value='"+rs2.getString("id")+"'>"+rs2.getString("descripcion")+"</option>";
                }
            PreparedStatement pst3 = connection.prepareStatement(" select * from ppr_padrones ");
            ResultSet rs3 = pst3.executeQuery();
            while (rs3.next()) {
                option2=option2+"<option value='"+rs3.getString("padron_id")+"'>"+rs3.getString("padron_nombre")+"</option>";
                }

            tabla.append("<tr>");
            tabla.append("<td>").append(rs.getString("escenario_id"))                                                               .append("</td>");
            tabla.append("<td  class=\"single_line2\"   >").append(rs.getString("raza_name"))                .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("periodo"))                 .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<select class='form-control'>"+option+"</select>")       .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<select class='form-control'>"+option2+"</select>")        .append("</td>");
            tabla.append("<td   class=\"single_line2\" contenteditable=\"true\" >").append("N/A")                                   .append("</td>");
            tabla.append("<td   class=\"single_line2\" contenteditable=\"true\" >").append(rs.getString("m_recria"))                .append("</td>");
            tabla.append("<td   class=\"single_line2\" contenteditable=\"true\" >").append(rs.getString("m_produccion_primaria"))   .append("</td>");
            tabla.append("<td   class=\"single_line2\" contenteditable=\"true\" >").append(rs.getString("m_pre_descarte"))          .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("calculo_produccion"))      .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("N/A")                                   .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("padron_produccion"))       .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("p_recria"))                .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("p_produccion_primaria"))   .append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("p_pre_descarte"))          .append("</td>");
            tabla.append("</tr>");
        }
        tabla.append("</tbody>");
        tabla.append("</table> <input type=\"button\" class=\"btn bg-warning\" value=\"Actualizar datos\" onclick=\"registrarCambiosPadron("+id+")\">");
        rs.close();
        pst.close();
    } catch (SQLException e) {
        // Manejo de excepciones (opcional)
        ob.put("grilla", e.toString()); 
    }

    ob.put("grilla", tabla.toString());
    out.println(ob);
%>
