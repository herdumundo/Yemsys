<%@page import="org.json.JSONObject"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
 <%@include  file="../../cruds/conexion.jsp" %>  
    <%
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
         PreparedStatement  pst3;
        ResultSet rs3;
        pst3 = connection.prepareStatement("select * from mae_log_numeracion_pedido");
        rs3 = pst3.executeQuery();
        while(rs3.next())
        {
            ob.put("numeracion",rs3.getString("numero"));
        }  
        connection.close();
        out.print(ob);
    %>