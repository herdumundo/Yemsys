<%-- 
    Document   : consulta_maquinas
    Created on : 06/04/2021, 04:59:22 PM
    Author     : hvelazquez
--%>

 <%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>


<%    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);  
    String id_rol = request.getParameter("cbox_rol");
 
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
    ResultSet rs,rs2;
     rs2 = fuente.obtenerDato(" SELECT   stuff(( select ','+  CONVERT(VARCHAR,id_opcion)   from mae_ot_det_roles with (nolock) where id_rol = "+id_rol+" for XML path('') ),1,1,'')as roles");
       if(rs2.next())
        {
            html=rs2.getString("roles");
        }
        clases.controles.DesconnectarBDsession();             
        ob.put("selected",html);
        out.print(ob);  %>
 