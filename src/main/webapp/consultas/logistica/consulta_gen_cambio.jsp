
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
    <%
         
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        clases.variables.logistica++;
        ob.put("cambio",clases.variables.logistica);
        out.print(ob);
    %>