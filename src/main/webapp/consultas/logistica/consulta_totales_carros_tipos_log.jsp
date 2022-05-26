<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@page import="java.sql.Statement"%>
<%@page import="netscape.javascript.JSObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
 <%@page contentType="application/json; charset=utf-8" %>

<%          JSONObject ob = new JSONObject();

      try {
        clases.controles.connectarBD();
        Statement stmt1 = clases.controles.connect.createStatement();
        ResultSet rs2 = stmt1.executeQuery(" select * from mae_log_cabecera_totales_pedidos ");
        JSONObject ob4 = new JSONObject();
        JSONArray ob5 = new JSONArray();
        while (rs2.next()) {
            ob4 = new JSONObject();
            ob4.put("tipo_huevo", rs2.getString("tipo_huevo"));
            ob4.put("cantidad", rs2.getInt("cantidad"));
            ob4.put("identificador", rs2.getInt("identificador"));
            ob5.put(ob4);
        }
        ob = new JSONObject();
        ob.put("totales", ob5);
        
    } catch (Exception e) 
    {
        String asdasd=e.getMessage();
    }
    finally {
         out.print(ob);
        clases.controles.DesconnectarBD();
    }
%>