<%-- 
    Document   : crud_agregar_modulos
    Created on : 14/12/2021, 11:20:03
    Author     : csanchez
--%>

<%@page import="clases.controles"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
 
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /> 
<%
        JSONObject obje = new JSONObject();
        obje = new JSONObject();
        
        String select_rol_per;
        String select_modulos;

        select_rol_per= request.getParameter("select_rol_per");
        select_modulos= request.getParameter("select_modulos");
        String mensaje="";
        controles.VerificarConexion();
        fuente.setConexion(clases.controles.connectSesion);
       
    try{
        CallableStatement call;
        call = clases.controles.connectSesion.prepareCall("{call stp_mae_ppr_insert_permisos(?,?,?)}");
        call.setString(1, select_rol_per);
        call.setString(2, select_modulos);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.execute(); 
        mensaje=call.getString(3);
        
        } catch (Exception ex) {
     }
 finally {
            clases.controles.DesconnectarBDsession();
     obje.put("mensaje",mensaje );
   
        out.print(obje);
 }
%>

