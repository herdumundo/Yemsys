<%-- 
    Document   : crud_restablecer_pass
    Created on : 8-ene-2022, 9:39:38
    Author     : aespinola
--%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>

<%    
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();

    String id_usuario       = request.getParameter("txt_id_reset");

    String mensaje="";
       try 
    {

                CallableStatement  call;   
                call = clases.controles.connectSesion.prepareCall("{call  stp_mae_ppr_restablecer_pass (?,?,? )}");
                call .setInt(1,  Integer.parseInt(id_usuario) );
                call.setString(2, "123");
                call.registerOutParameter(3, java.sql.Types.VARCHAR);
                call.execute(); 
              
                mensaje= call.getString(3);
            
         } catch (Exception ex) {
    
           }
           finally {  
            clases.controles.DesconnectarBDsession();
           ob.put("mensaje", mensaje);
                       out.print(ob);
                   }
            %>