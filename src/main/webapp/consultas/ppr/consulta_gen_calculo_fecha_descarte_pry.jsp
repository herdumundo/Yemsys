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
        String dias_descarte     = request.getParameter("dia_descarte");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery("select "
                + "                 dateadd(day,"+dias_descarte+" ,convert(date,'"+fecha_nacimiento+"'))            as fecha_descarte,"
                + "                CEILING(convert(numeric(10,2),("+dias_descarte+" ))/convert(numeric(10,2),(7)))  as semanas_descarte");
        while (rs_GM.next()) 
        {
            ob.put("fecha_descarte", rs_GM.getString("fecha_descarte"));
            ob.put("semana_descarte", rs_GM.getString("semanas_descarte")); 
        }
        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

