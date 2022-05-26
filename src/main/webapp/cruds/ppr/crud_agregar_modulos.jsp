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
        
        String descripcion;

        descripcion= request.getParameter("descripcion");
        String mensaje="";
        String tipo_registro=""; 
        controles.VerificarConexion();
        fuente.setConexion(clases.controles.connectSesion);
        

    try{
        clases.controles.connectSesion.setAutoCommit(false);

        CallableStatement call;
        call = clases.controles.connectSesion.prepareCall("{call stp_mae_ppr_insert_modulos(?,?,?)}");
        call.setString(1, descripcion);
        call.registerOutParameter(2, java.sql.Types.VARCHAR);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.execute(); 
        tipo_registro=call.getString(2);
        mensaje=call.getString(3);
       
        
          if (tipo_registro=="1")
                {
                    clases.controles.connectSesion.rollback();
                   
                }   
                else  
                {
                     //clases.controles.connectSesion.rollback(); 
                    clases.controles.connectSesion.commit();
                  
                } 

    } catch (Exception ex) {
     }
 finally {
            clases.controles.DesconnectarBDsession();
     obje.put("mensaje",mensaje );
     obje.put("tipo_registro",tipo_registro );
        out.print(obje);
 }
%>

