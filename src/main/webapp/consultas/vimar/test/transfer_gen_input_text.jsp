<%-- 
    Document   : transfer_gen_input_text
    Created on : 18-ago-2023, 9:10:37
    Author     : jbernal
--%>
 
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../cruds/conexion.jsp" %> 
<%
JSONObject responseJSON = new JSONObject();
String cedulaPersona = request.getParameter("numeroCedula");

 
    // Aquí puedes realizar cualquier procesamiento adicional si lo necesitas
    
    // Crear un objeto JSON con los valores
    JSONObject jsonData = new JSONObject();
    
    jsonData.put("data1", cedulaPersona);
    jsonData.put("data2", cedulaPersona);
    jsonData.put("data3", cedulaPersona);
    jsonData.put("data4", cedulaPersona);
    jsonData.put("data5", cedulaPersona);
    jsonData.put("data6", cedulaPersona);
    jsonData.put("data7", cedulaPersona);

 
out.print(jsonData);
%> 
