<%-- 
    Document   : consulta_gen_grilla_detalle_menu
    Created on : Feb 2, 2024, 4:40:43 PM
    Author     : jbernal
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
    String grilla = "";
    String cabecera = "";

    try {
        String desde = request.getParameter("fechaDesde");
        String hasta = request.getParameter("fechaHasta");

        ResultSet rs;
        Statement st = connection.createStatement();
        rs = st.executeQuery("SELECT CONVERT(VARCHAR, b.U_NRO_SOL_NC) AS id, a.fecha, a.itemcode, a.item_name, a.cantidad AS cant_recuperada,"
                + " (a.total - a.cantidad) AS cant_desechos, a.total, a.sucursal, a.repartidor"
                + " FROM GrupoMaehara.dbo.recuperados_averiados a"
                + " LEFT OUTER JOIN vimar.dbo.ORDN b ON a.nro_registro_sap = b.docnum"
                + " WHERE a.fecha BETWEEN CONVERT(DATE, '" + desde + "')"
                + " AND CONVERT(DATE, '" + hasta + "')"
                + " AND a.nro_registro_sap NOT"
                + " IN (SELECT docnum FROM vimar.dbo.ORDN WHERE CANCELED = 'Y' AND DocDate BETWEEN CONVERT(DATE, '" + desde + "')"
                + " AND CONVERT(DATE, '" + hasta + "'));");

        cabecera = " <table id='tb_informe_recuperados' class='display responsive nowrap' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th>id</th>"
                + " <th>fecha</th>"
                + " <th>itemcode</th>"
                + " <th>item_name</th>"
                + " <th>cant_recuperada</th>"
                + " <th>cant_desechos</th>"
                + " <th>total</th>"
                + " <th>sucursal</th>"
                + " <th>repartidor</th>"
                + "</tr>"
                + " </thead> "
                + " <tbody >";

        while (rs.next()) {
            grilla = grilla
                    + "<tr id='" + rs.getString("id") + "'>"
                    + "<td>" + rs.getString("id") + "</td>"
                    + "<td>" + rs.getString("fecha") + "</td>"
                    + "<td>" + rs.getString("itemcode") + "</td>"
                    + "<td>" + rs.getString("item_name") + "</td>"
                    + "<td>" + rs.getString("cant_recuperada") + "</td>"
                    + "<td>" + rs.getString("cant_desechos") + "</td>"
                    + "<td>" + rs.getString("total") + "</td>"
                    + "<td>" + rs.getString("sucursal") + "</td>"
                    + "<td>" + rs.getString("repartidor") + "</td>"
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