<%-- 
    Document   : crud_agregar_usuario_pendientes
    Created on : 28-dic-2021, 7:35:53
    Author     : aespinola
--%>

<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.Statement"%>
<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /> 

 
<%
    JSONObject obje = new JSONObject();
        obje = new JSONObject();
        
        String nombre;
        nombre= request.getParameter("peticionn");
        String mensaje="";
        String tipo_registro="";
        
        controles.VerificarConexion();
        fuente.setConexion(clases.controles.connectSesion);
    try{
         CallableStatement call;
             
            call = clases.controles.connectSesion.prepareCall("{call stp_mae_ppr_insert_usuario_reset(?,?,?)}");
               
            call.setString(1, nombre);
            call.registerOutParameter(2, java.sql.Types.VARCHAR);
            call.registerOutParameter(3, java.sql.Types.VARCHAR);
            call.execute();
            
             mensaje=call.getString(3);
             tipo_registro=call.getString(2);
          
 } catch (Exception ex) {
    
  }
 finally {
            clases.controles.DesconnectarBDsession();
     obje.put("mensaje",mensaje );
     obje.put("tipo_registro",tipo_registro );
        out.print(obje);
 }
%>
