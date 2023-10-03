<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../cruds/conexion.jsp" %> 
<%    
JSONObject ob = new JSONObject();
    String option = "";
    try {
     //   String father = request.getParameter("father");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery( " SELECT  [id]  ,[descripcion]  ,[id_estado]  ,[tipo] FROM [vim_motivos]");

        while (rs_GM.next()) 
        {
            option = option + "<option   > " + rs_GM.getString("descripcion") + " </option> ";
        }
        
     
        ob.put("select", option);

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

