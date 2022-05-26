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
        
        
      
         String saldo_ant= "";
         String sems = "";
         String id_datos="";
         String edad_dias="";
        
  
        id_datos   = request.getParameter("id_datos");
        saldo_ant  = request.getParameter("saldo_ant");
        sems       = request.getParameter("sems");
        edad_dias  = request.getParameter("edad_dias");
   
  
       
        String mensaje="";
        String tipo_registro="";
        controles.VerificarConexion();
        
        fuente.setConexion(clases.controles.connectSesion);
         
             try{
                clases.controles.connectSesion.setAutoCommit(false);

                 CallableStatement call;
       
         call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_update_saldo] (?,?,?,?,?,?)}");
        
         call.setString            (1, id_datos);
         call.setString            (2, edad_dias);
         call.setString            (3, sems);
         call.setString            (4, saldo_ant);
         call.registerOutParameter (5, java.sql.Types.VARCHAR);
         call.registerOutParameter (6, java.sql.Types.VARCHAR);
         call.execute();
            
            tipo_registro = call.getString(5);
            mensaje = call.getString(6);
            
            
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
