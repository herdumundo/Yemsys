<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />

<%@include  file="../../chequearsesion.jsp" %>


<%    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

    String aviario = request.getParameter("aviario");
    String fecha1 = request.getParameter("fecha1");
    String fecha2 = request.getParameter("fecha2");
    String fila1 = request.getParameter("fila1");
    String fecha = "";
    String cantidad = "";
    String grilla_html = "";
    String cabecera = "  "
            + " <table   class='divinforme table table-bordered table-responsive order-column' style='width:18%;height:550px'>"
            + "<thead>"
            + " <tr>"
            + " <th class='bg-navy card-header'>Fecha</th>"
            + "<th class='bg-navy card-header'>Huevos</th>"
            + "</tr>"
            + "</thead> <tbody >";
    try {
        JSONObject objet = new JSONObject();
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connectSesion.prepareStatement("select fecha, cant from ppr_contador where fecha BETWEEN '" + fecha1 + "'and '" + fecha2 + "'and aviario='" + aviario + "'and fila='" + fila1 + "'");
        ResultSet rs2 = pt.executeQuery();
        while (rs2.next()) {

            grilla_html = grilla_html + "<tr><td style= 'text-align:center;'>"
                    + " " + rs2.getString("fecha") + " </td> <td style= 'text-align:center';>  " + rs2.getString("cant") + "  </td></tr>";
            fecha = rs2.getString("fecha");
            cantidad = rs2.getString("cant");
        }
        clases.controles.DesconnectarBDsession();             
        objet.put("grillas", cabecera + grilla_html + "</tbody></table>");
        objet.put("fecha", fecha);
        objet.put("cantidad", cantidad);
        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>

