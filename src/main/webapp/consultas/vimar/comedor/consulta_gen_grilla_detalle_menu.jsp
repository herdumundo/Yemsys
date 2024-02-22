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
        String fechaDesde = request.getParameter("fechaDesde");
        String fechaHasta = request.getParameter("fechaHasta");

        ResultSet rs;
        Statement st = connection.createStatement();
        rs = st.executeQuery(" select convert(varchar,a.fecha,103) as fecha, upper(format(a.fecha,'dddd')) as dia, "
                + " b.menu,a.id from rrhh_menu_diario a inner join rrhh_menu b on a.idmenu=b.id_menu "
                + " where  a.fecha between '" + fechaDesde + "' and  '" + fechaHasta + "' order by a.fecha ");

        cabecera = " <table id='tb_informe_menu' class='display responsive nowrap' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th>FECHA</th>"
                + " <th>DÍA</th>"
                + " <th>MENÜ</th>"
                + " <th>ACCIÓN</th>"
                + "</tr>"
                + " </thead> "
                + " <tbody >";

        while (rs.next()) {
            grilla = grilla
                    + "<tr id='" + rs.getString("id") + "'>"
                    + "<td>" + rs.getString("fecha") + "</td>"
                    + "<td>" + rs.getString("dia") + "</td>"
                    + "<td>" + rs.getString("menu") + "</td>"
                    + "<td>" + "<input type='button' class='btn btn-danger' value='Eliminar' onclick=\"confirmar_delete('" + rs.getString("id") + "','"+rs.getString("menu")+"', '" + rs.getString("dia") + "')\"/>" + "</td>" 
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