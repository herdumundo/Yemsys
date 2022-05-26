<%@page import="clases.controles"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
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
 
  
      String  nombre= request.getParameter("nombre");
       String pass = request.getParameter("pass");
      String  usuario = request.getParameter("usuario");
      String  clasificadora = request.getParameter("clasificadora");
      String  rol= request.getParameter("select_rol");
        
 
       
        String mensaje="";
        String tipo_registro="";
        controles.VerificarConexion();

    fuente.setConexion(clases.controles.connectSesion);
         
             try{
                clases.controles.connectSesion.setAutoCommit(false);

                 CallableStatement call;
       
         call = clases.controles.connectSesion.prepareCall("{call stp_mae_ppr_insert_usuarios(?,?,?,?,?,?,?)}");
        
            call.setString           (1, usuario);
            call.setString           (2, pass);
            call.setString           (3, clasificadora);
            call.setString           (4, nombre);
            call.setInt              (5, Integer.parseInt(rol) );
     
            
            call.registerOutParameter(6, java.sql.Types.VARCHAR);
            call.registerOutParameter(7, java.sql.Types.VARCHAR);
            call.execute();
            
             mensaje=call.getString(7);
             tipo_registro=call.getString(6);
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
    
     String mens=ex.getMessage();
  }
 finally {
            clases.controles.DesconnectarBDsession();
     obje.put("mensaje",mensaje );
     obje.put("tipo_registro",tipo_registro );
        out.print(obje);
 }
%>
