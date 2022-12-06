<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>
 <%@page import="org.json.JSONObject"%> 
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<%@include file="../cruds/conexion.jsp" %>

<%  
    JSONObject ob = new JSONObject();
    try 
    {
        String html = "";
        ResultSet rs2, rs3;
        Statement stmt1 = connection.createStatement();
        Statement stmt2 = connection.createStatement();

        rs2 = stmt1.executeQuery("select * from mae_yemsys_modulos where id_estado=1 order by orden asc ");// 1 ES IGUAL A ACTIVO.

        String group = "";
        String option = "";
        String select = "";
        ob = new JSONObject();    
        while (rs2.next()) 
        {
            group = "";
            option = "";
            group = group + "<optgroup  id='" + rs2.getString("id") + "' label='" + rs2.getString("descripcion") + "'>";// EL FINAL DEL UL Y EL LI VAN ABAJO, LUEGO DE CARGAR EL SUBMENU

            rs3 = stmt2.executeQuery("  select * from  mae_yemsys_det_modulos where    id_modulos=" + rs2.getString("id") + "");

            while (rs3.next()) {
                option = option + "<option  class='text-center  ' value='" + rs3.getString("id") + "'>" + rs3.getString("descripcion") + "</option>";
            }
             select = select + group + option + " </optgroup>";
        }
         
        ob.put("select", select);

      

    } catch (Exception e) 
    {
    } finally {
        out.print(ob);
        connection.close();
    }
%> 