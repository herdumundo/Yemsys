<%-- 
    Document   : consulta_gen_grilla_detalle_menu
    Created on : Feb 2, 2024, 4:40:43 PM
    Author     : jbernal
--%>

<%@page import="java.sql.ResultSet"%>
<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%    JSONObject ob = new JSONObject();
    String grilla = "";
    String cabecera = "";

    try {
        String desde = request.getParameter("fechaDesde");
        String hasta = request.getParameter("fechaHasta");

        ResultSet rs;
        Statement st = connection.createStatement();
        rs = st.executeQuery("SELECT ci_emp, empleado, SUM(Anotados) AS anotados, SUM(Confirmados) AS confirmados,"
                + " (SUM(Anotados) + SUM(Confirmados)) AS Total FROM (SELECT a.ci_emp, b.empleado, CASE WHEN"
                + " a.estado = 'A' THEN COUNT(*) ELSE 0 END AS Anotados, CASE WHEN a.estado = 'C' THEN COUNT(*) ELSE 0 END AS Confirmados"
                + " FROM rrhh_registros_dia_menu a INNER JOIN rrhh_empleados b ON a.ci_emp = b.ci_empleado WHERE CONVERT(DATE, fecha"
                + ") BETWEEN CONVERT(DATE, '" + desde + "') AND CONVERT(DATE, '" + hasta + "') GROUP BY a.ci_emp, b.empleado, a.estado) t GROUP BY ci_emp, empleado;");

        cabecera = " <table id='tb_informe_anotados' class='display responsive nowrap' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th>CI</th>"
                + " <th>NOMBRE</th>"
                + " <th>ANOTADOS</th>"
                + " <th>CONFIRMADOS</th>"
                + " <th>TOTAL</th>"
                + "</tr>"
                + " </thead> "
                + " <tbody >";

        while (rs.next()) {
            grilla = grilla
                    + "<tr id='" + rs.getString("ci_emp") + "'>"
                    + "<td>" + rs.getString("ci_emp") + "</td>"
                    + "<td>" + rs.getString("empleado") + "</td>"
                    + "<td>" + rs.getString("anotados") + "</td>"
                    + "<td>" + rs.getString("confirmados") + "</td>"
                    + "<td>" + rs.getString("Total") + "</td>"
                    + "</tr>";
        }

        ob.put("grilla", cabecera + grilla + "</tbody></table>");

        rs.close();
    } catch (SQLException e) {
        ob.put("grilla", e.toString());

    } finally {
        connection.close();
        out.print(ob);
    }
%>