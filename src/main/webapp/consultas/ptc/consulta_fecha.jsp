
<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%
        clases.controles.connectarBD();   

        Connection cn = clases.controles.connect;
	fuente.setConexion(cn);
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contenedor=""; 
         ResultSet rs = fuente.obtenerDato("SELECT convert(varchar,getdate(),103) as fecha ");
       while(rs.next()){
           
           contenedor=rs.getString("fecha");
       }
        
        cn.close();
        controles .DesconnectarBD();
        ob.put("fecha",contenedor);
        out.print(ob);
       %>