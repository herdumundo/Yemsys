<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="../../../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../../cruds/conexion.jsp" %>
<%    StringBuilder tabla = new StringBuilder();
    String id = request.getParameter("idPadron");
    String option="";
    try {
        PreparedStatement pst = connection.prepareStatement("select  * from v_ppr_escenarioPrincipal");
        ResultSet rs = pst.executeQuery();
        tabla.append("<table id='grillaEscenarioCab' class='table table-striped table-condensed compact hover dataTable'>");
        tabla.append("<thead>");
        tabla.append("<tr>");
        // Añadir el encabezado que abarca todas las columnas y centrarlo
        tabla.append("<th colspan='7' style='text-align: center;'>Escenarios</th>");
        tabla.append("</tr>");
        tabla.append("<tr>");
        tabla.append("<th>Codigo</th>");
        tabla.append("<th>Escenario</th>");
        tabla.append("<th>Periodo</th>");
        tabla.append("<th>Calculo de Mortandad</th>");
        tabla.append("<th>Calculo de Produccion</th>");
        tabla.append("<th>Accion</th>");
        tabla.append("</tr>");
        tabla.append("</thead>");
        tabla.append("<tbody>");

        while (rs.next()) {
        
     
            tabla.append("<tr>");
            tabla.append("<td>").append(rs.getString("escenario_id")).append("</td>");
            tabla.append("<td>").append(rs.getString("escenario_nombre")).append("</td>");
            tabla.append("<td>").append(rs.getString("periodo")).append("</td>");
            tabla.append("<td>").append(rs.getString("calculo_mortandad")).append("</td>");
            tabla.append("<td>").append(rs.getString("calculo_produccion")).append("</td>");
            tabla.append("<td>").append("<button class='btn btn-outline-info btn-xs' onclick=\"ir_grillaEscenariosById_ppr(" + rs.getString("escenario_id") + ",'"+rs.getString("escenario_nombre")+"')\" ><i class='fa fa-eye'></i> ver</button>").append("<button class='btn btn-outline-primary btn-xs' onclick='clonarEscenarioPpr("+rs.getString("escenario_id")+")' ><i class='fa fa-files-o'></i> Duplicar</button>").append("</td>");
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
