<%-- 
    Document   : crud_modificar_permisos
    Created on : 27/12/2021, 10:24:22
    Author     : csanchez
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>

<%    
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();

    String txt_id_permisos            = request.getParameter("txt_id_permisos");
    String select_rol_permisos        = request.getParameter("select_rol_permisos");
    String select_modulo_permisos      = request.getParameter("select_modulo_permisos");
    String select_estado_modulo_permisos   = request.getParameter("select_estado_modulo_permisos");
    
    String mensaje      ="";
    String tipo_respuesta="";    
    try 
    { 
        
        CallableStatement  call;   
                call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_update_permisos](?,?,?,?,?,?)}");
                call .setInt(1,    Integer.parseInt(txt_id_permisos) );
                call .setString(2, select_rol_permisos);
                call .setString(3, select_modulo_permisos);
                call .setString(4, select_estado_modulo_permisos);
               
        
                call.registerOutParameter(5, java.sql.Types.VARCHAR);
                call.registerOutParameter(6, java.sql.Types.VARCHAR);
                call.execute(); 
                tipo_respuesta=call.getString(5);
                mensaje=call.getString(6);
               
               
                if (tipo_respuesta=="1")
                {
                    clases.controles.connectSesion.rollback();
                   
                }   
                else  
                {
                     //clases.controles.connectSesion.rollback(); 
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
