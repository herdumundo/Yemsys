
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
    <%
    String variable_cambio            = request.getParameter("variable_cambio");
        int verificador=0;
        if(Integer.parseInt(variable_cambio)!=clases.variables.logistica  )     {
             verificador= 1;
         }  
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
         ob.put("verificador",verificador);
        out.print(ob);
    %>