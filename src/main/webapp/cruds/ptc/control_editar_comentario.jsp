<%-- 
    Document   : control_editar_comentario
    Created on : 22/05/2019, 10:38:11 AM
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONObject"%>
<%@page import="clases.controles"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
 
    <%
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        clases.controles.VerificarConexion();
           
        String cod_lote= request.getParameter("lote") ;
        String comentario= request.getParameter("comentario") ;
        String liberado_por= request.getParameter("liberado_por") ;
        PreparedStatement ps2 = controles.connectSesion.prepareStatement("update  lotes set comentario='"+comentario+"',liberado_por='"+liberado_por+"' where cod_interno='"+cod_lote+"'");
        ps2.executeUpdate(); 
        ob.put("mensaje", "MODIFICADO CON EXITO.");
        out.print(ob);
         %>
         