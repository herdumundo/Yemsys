<%-- 
    Document   : consulta_aviarios_hora
    Created on : 08/03/2021, 03:16:05 PM
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
   String id= request.getParameter("id");
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String boton_registro=""; 
    int activo=0;
        clases.controles.VerificarConexion();
        Statement stmt = clases.controles.connectSesion.createStatement();
        ResultSet rs = stmt.executeQuery(" select * from mae_ptc_alimentacion where clasificadora='"+clasificadora+"' and estado<>'C' and id="+id+" ");
        while(rs.next())
        {
          activo=1;
        }
        
        if(activo==0){
            boton_registro=" <br><br><input type='button' value='Iniciar reproceso'  style='font-weight: bold;color:black;' class='form-control bg-success' onclick='registrar_reproceso_ptc(1);' >";
        }
        else{
            boton_registro="<br><br> <input type='button' value='Finalizar reproceso'  style='font-weight: bold;color:black;'  class='form-control bg-danger' onclick='registrar_reproceso_ptc(2);'>";
        }
        clases.controles.DesconnectarBDsession();
        ob.put("boton",boton_registro);
        out.print(ob);
       %> 