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
        ResultSet rs_GM,rs_GM2;
                String dias_predescarte="";
        String dias_produccion="";
        Statement st = connection.createStatement();
        Statement st2 = connection.createStatement();
        rs_GM = st.executeQuery("  select dateadd(day,117,convert(date,'"+fecha_nacimiento+"')) as fecha_produccion,dateadd(day,594,convert(date,'"+fecha_nacimiento+"'))"
                + " as fecha_predescarte");
        String fecha_produccion="";
        String fecha_predescarte="";
        while (rs_GM.next()) 
        {
            fecha_produccion=rs_GM.getString("fecha_produccion");
            fecha_predescarte=rs_GM.getString("fecha_predescarte");
        }
        
        
        
         rs_GM2 = st2.executeQuery("SELECT DATEDIFF(DAY,convert(date,'"+fecha_nacimiento+"'),convert(date,'"+fecha_produccion+"')) as dias_produccion,"
                + "                     DATEDIFF(DAY,convert(date,'"+fecha_nacimiento+"'),convert(date,'"+fecha_predescarte+"')) as dias_predescarte  ");
   
        while (rs_GM2.next()) 
        {
            dias_produccion=rs_GM2.getString("dias_produccion");
            dias_predescarte=rs_GM2.getString("dias_predescarte");
        }
        
        
        ob.put("fecha_produccion", fecha_produccion);
        ob.put("fecha_predescarte", fecha_predescarte);
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

