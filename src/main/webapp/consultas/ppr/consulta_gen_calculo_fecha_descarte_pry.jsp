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
        String fecha_nacimiento     = request.getParameter("fecha_nacimiento");
        String fecha_descarte        = request.getParameter("fecha_descarte");
    //    String fecha_descarte2        = request.getParameter("fecha_descarte");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery("select "
                 + "                CEILING(convert(numeric(10,2),(DATEDIFF(DAY, '"+fecha_nacimiento +"' , '"+fecha_descarte +"')))/convert(numeric(10,2),(7)))  as semanas_descarte");
        while (rs_GM.next()) 
        {
             ob.put("semana_salida","Semana: "+ rs_GM.getString("semanas_descarte")); 
        }
        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

