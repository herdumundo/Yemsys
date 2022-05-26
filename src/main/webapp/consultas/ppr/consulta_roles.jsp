<%-- 
    Document   : consulta_roles
    Created on : 15-dic-2021, 7:49:43
    Author     : aespinola
--%>


<%@page import="clases.controles"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="application/json; charset=utf-8" %>
 <%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<% 
    clases.controles.connectarBD();
    String html="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
     
        Statement  stm= clases.controles.connect.createStatement();
        ResultSet rs2 = stm.executeQuery ("select * from tab_mae_ppr_roles");
        while(rs2.next())
        {
            html=html+"<OPTION  VALUE='"+ rs2.getString(1)+"'>"+ rs2.getString(2)+"</OPTION>";
        }
        clases.controles.DesconnectarBDsession();             
        ob.put("cbox_roles","<OPTION value='' selected='selected'>SELECCIONE ROL</OPTION>"+html);
        controles.DesconnectarBD();
        out.print(ob);  
%>