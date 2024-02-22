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
        rs = st.executeQuery("select * from  rrhh_menu where estado='A'");

        cabecera = " <table id='tb_gen_menu' class='display responsive nowrap' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th>NRO</th>"
                + " <th>MENÚ</th>"
                + " <th>ACCIÓN</th>"
                + "</tr>"
                + " </thead> "
                + " <tbody >";

        while (rs.next()) {
            grilla = grilla
                    + "<tr id='" + rs.getString("id_menu") + "'>"
                    + "<td>" + rs.getString("id_menu") + "</td>"
                    + "<td>" + rs.getString("menu") + "</td>"
                    + "<td>" + "<input type='button' class='btn btn-danger' value='ELIMINAR' onclick=\"eliminar_menu('" + rs.getString("id_menu") + "','" + rs.getString("menu") + "')\"/>" + "</td>" 
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