<%-- 
    Document   : crud_modificar_rol
    Created on : 21-dic-2021, 13:52:16
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

    String id            = request.getParameter("txt_id_rol");
    String descri        = request.getParameter("txt_decri_rol");
    String estado      = request.getParameter("select_estado_roles");
  
    
    String mensaje      ="";
    String tipo_respuesta="";    
    try 
        
    { 
                clases.controles.connectSesion.setAutoCommit(false);

         CallableStatement  call;   
                call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_update_rol](?,?,?,?,?)}");
                call .setInt(1,    Integer.parseInt(id) );
                call .setString(2, descri);
                call .setString(3, estado);
               
                call.registerOutParameter(4, java.sql.Types.VARCHAR);
                call.registerOutParameter(5, java.sql.Types.VARCHAR);
                call.execute(); 
                tipo_respuesta=call.getString(4);
                mensaje=call.getString(5);
               
                 if (tipo_respuesta=="1")
                {
                    clases.controles.connectSesion.rollback();
                   
                }   
                else  
                {
                   //   clases.controles.connectSesion.rollback(); 
                   clases.controles.connectSesion.commit();
                  
                }    
               
           
         } catch (Exception e){
    
  }
     finally{         
 clases.controles.DesconnectarBDsession();
 ob.put("mensaje", mensaje);
                ob.put("tipo_respuesta", tipo_respuesta);
                 out.print(ob); 
            }
           %>