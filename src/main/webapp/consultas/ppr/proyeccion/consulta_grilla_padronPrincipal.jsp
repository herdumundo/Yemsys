<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="../../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%    StringBuilder tabla = new StringBuilder();
    String id = request.getParameter("idPadron");
    try {
        PreparedStatement pst = connection.prepareStatement("select t1.padron_id,t1.padron_nombre,t2.raza_name from ppr_padrones t1 inner join ppr_razas t2 on t1.raza_id=t2.raza_id ");
        ResultSet rs = pst.executeQuery();
        tabla.append("<table id='grillaPadronCab' class='table table-striped table-condensed compact hover dataTable'>");
        tabla.append("<thead>");
        tabla.append("<tr>");
        // Añadir el encabezado que abarca todas las columnas y centrarlo
        tabla.append("<th colspan='7' style='text-align: center;'>Padron</th>");
        tabla.append("</tr>");
        tabla.append("<tr>");
        tabla.append("<th>Id</th>");
        tabla.append("<th>Padron Nombre</th>");
        tabla.append("<th>Raza</th>");
        tabla.append("<th>Accion</th>");
        tabla.append("</tr>");
        tabla.append("</thead>");
        tabla.append("<tbody>");

        while (rs.next()) {

            tabla.append("<tr>");
            tabla.append("<td>").append(rs.getString("padron_id")).append("</td>");
            tabla.append("<td>").append(rs.getString("padron_nombre")).append("</td>");
            tabla.append("<td>").append(rs.getString("raza_name")).append("</td>");
            tabla.append("<td>").append("<button class='btn btn-outline-info btn-xs' onclick=\"ir_grillaPadronesById_ppr(" + rs.getString("padron_id") + ",'"+rs.getString("padron_nombre")+"')\" ><i class='fa fa-eye'></i> ver</button>").append("<button class='btn btn-outline-primary btn-xs' onclick='clonarPadronPpr("+rs.getString("padron_id")+")' ><i class='fa fa-files-o'></i> Duplicar</button>").append("</td>");
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
