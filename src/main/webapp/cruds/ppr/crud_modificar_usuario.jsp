<%-- 
    Document   : crud_modificar_usuario
    Created on : 16-dic-2021, 15:46:44
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

     String id            = request.getParameter("txt_id");
    String nombre        = request.getParameter("txt_nombre");
    String usuario      = request.getParameter("txt_usuario");
    String clasificadora   = request.getParameter("txt_clasificadora");
    String select_rolm     = request.getParameter("select_rol2");
    String select_estado     = request.getParameter("select_estado");
    String mensaje      ="";
    String tipo_respuesta="";    
    try 
    { 
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement  call;   
                call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_update_usuario](?,?,?,?,?,?,?,?)}");
                call .setInt(1,    Integer.parseInt(id) );
                call .setString(2, nombre);
                call .setString(3, usuario);
                call .setString(4, clasificadora);
                call .setString(5, select_rolm);
                call .setString(6, select_estado);
        
                call.registerOutParameter(7, java.sql.Types.VARCHAR);
                call.registerOutParameter(8, java.sql.Types.VARCHAR);
                call.execute(); 
                tipo_respuesta=call.getString(7);
                mensaje=call.getString(8);
               
                 if (tipo_respuesta=="1")
                {
                    clases.controles.connectSesion.rollback();
                   
                }   
                else  
                {
                     //clasess.controles.connectSesion.rollback(); 
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