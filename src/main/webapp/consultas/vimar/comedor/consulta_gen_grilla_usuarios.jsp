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

        ResultSet rs;
        Statement st = connection.createStatement();
        rs = st.executeQuery("select id,ci,empleado,area from rrhh_empleados where estado='A'");

        cabecera = " <table id='tb_gen_usuarios' class='display responsive nowrap' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th>NRO</th>"
                + " <th>CI</th>"
                + " <th>NOMBRE</th>"
                + " <th>ÁREA</th>"
                + " <th>ACCIÓN</th>"
                + "</tr>"
                + " </thead> "
                + " <tbody >";

        while (rs.next()) {
            grilla = grilla
                    + "<tr id='" + rs.getString("id") + "'>"
                    + "<td>" + rs.getString("id") + "</td>"
                    + "<td>" + rs.getString("ci") + "</td>"
                    + "<td>" + rs.getString("empleado") + "</td>"
                    + "<td>" + rs.getString("area") + "</td>"
                    + "<td>" + "<input type='button' class='btn btn-danger' value='ELIMINAR' onclick=\"eliminar_usuario('" + rs.getString("id") + "','" + rs.getString("empleado") + "')\"/>" + "</td>" 
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