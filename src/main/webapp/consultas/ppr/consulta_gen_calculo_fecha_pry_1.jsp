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
<%    
    JSONObject ob = new JSONObject();
     try 
     {
        String fecha_nacimiento = request.getParameter("fecha_nacimiento");
        String dias_produccion = request.getParameter("dias_produccion");
        String dias_predescarte = request.getParameter("dias_predescarte");
        
         
        
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery("select dateadd(day,"+dias_produccion+" ,convert(date,'"+fecha_nacimiento+"')) as fecha_produccion,"
                + "                     dateadd(day,"+dias_predescarte+" ,convert(date,'"+fecha_nacimiento+"'))  as fecha_predescarte");
        String fecha_produccion="";
        String fecha_predescarte="";
        while (rs_GM.next()) 
        {
            fecha_produccion=rs_GM.getString("fecha_produccion");
            fecha_predescarte=rs_GM.getString("fecha_predescarte");
        }
        int semanas_produccion=Integer.parseInt(dias_produccion)/7;
        int semanas_predescarte=Integer.parseInt(dias_predescarte)/7;
        
        
         
        
        ob.put("fecha_produccion", fecha_produccion);
        ob.put("fecha_predescarte", fecha_predescarte);
        ob.put("semanas_produccion", semanas_produccion);
        ob.put("semanas_predescarte", semanas_predescarte);
        
        
        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

