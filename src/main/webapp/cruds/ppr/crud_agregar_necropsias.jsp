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
        
        String fecha;
        String lote_aviario;
        
      
  
        fecha= request.getParameter("fecha");
        lote_aviario = request.getParameter("lote");
        
        
 
       
        String mensaje="";
        String tipo_registro="";
        controles.VerificarConexion();
        
        fuente.setConexion(clases.controles.connectSesion);
         
             try{
                clases.controles.connectSesion.setAutoCommit(false);

                 CallableStatement call;
       
         call = clases.controles.connectSesion.prepareCall("{call stp_mae_ppr_insert_necropsias (?,?,?,?)}");
        
            call.setString           (1, fecha);
            call.setString           (2, lote_aviario);
            call.registerOutParameter(3, java.sql.Types.VARCHAR);
            call.registerOutParameter(4, java.sql.Types.VARCHAR);
            call.execute();
            
            tipo_registro = call.getString(3);
            mensaje = call.getString(4);
            
            
  if (tipo_registro == "1") {
            clases.controles.connectSesion.rollback();

        } else {
            //clases.controles.connectSesion.rollback(); 
            clases.controles.connectSesion.commit();

        }
    } catch (Exception ex) {

    } finally {
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        clases.controles.connectSesion.close();
        out.print(obje);
    }
%>
