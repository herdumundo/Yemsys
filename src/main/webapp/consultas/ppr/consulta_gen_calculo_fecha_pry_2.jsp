<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
    String option = "";
    try {
        String fecha_nacimiento = request.getParameter("fecha_nacimiento");
        String fecha_produccion = request.getParameter("fecha_produccion");
        String fecha_predescarte = request.getParameter("fecha_predescarte");
        String dias_predescarte="";
        String dias_produccion="";
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery("SELECT DATEDIFF(DAY,convert(date,'"+fecha_nacimiento+"'),convert(date,'"+fecha_produccion+"')) as dias_produccion,"
                + "                     DATEDIFF(DAY,convert(date,'"+fecha_nacimiento+"'),convert(date,'"+fecha_predescarte+"')) as dias_predescarte  ");
   
        while (rs_GM.next()) 
        {
            dias_produccion=rs_GM.getString("dias_produccion");
            dias_predescarte=rs_GM.getString("dias_predescarte");
        }
        
     
        ob.put("dias_produccion", dias_produccion);
        ob.put("dias_predescarte", dias_predescarte);

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

