<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>
<%@page import="java.sql.Statement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<%@include file="../cruds/conexion.jsp" %>

<%  try 
    {
        String html = "";
        ResultSet rs2, rs3;
        Statement stmt1 = connection.createStatement();
        Statement stmt2 = connection.createStatement();

        rs2 = stmt1.executeQuery("select * from mae_yemsys_modulos where id_estado=1 ");// 1 ES IGUAL A ACTIVO.

        String group = "";
        String option = "";
        String select = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        while (rs2.next()) {
            group = "";
            option = "";
            group = group + "<optgroup  label='" + rs2.getString("descripcion") + "'  >";// EL FINAL DEL UL Y EL LI VAN ABAJO, LUEGO DE CARGAR EL SUBMENU

            rs3 = stmt2.executeQuery("  select * from  mae_yemsys_det_modulos where    id_modulos=" + rs2.getString("id") + " ");

            while (rs3.next()) {
                option = option + "<option onclick='alert(" + rs3.getString("id") + ")' class='text-center  ' value='" + rs3.getString("id") + "'>" + rs3.getString("descripcion") + "</option>";
            }
            rs3.close();
            select = select + group + option + " </optgroup>";
        }
        rs2.close();
        ob.put("select", select);

        out.print(ob);

    } catch (Exception e) {
    } finally {
        connection.close();
    }
%> 