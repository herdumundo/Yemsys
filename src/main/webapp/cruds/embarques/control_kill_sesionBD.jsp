<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
 <%@ page contentType="application/json; charset=utf-8" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
    <% 
    
    clases.controles.VerificarConexion();
    fuente. setConexion(clases.controles.connectSesion);  
 
    int tipo            =0;
    String mensaje="";
         
        try 
        { 
            clases.controles.connectSesion.setAutoCommit(false);
            CallableStatement  callableStatement=null;   
            callableStatement = clases.controles.connectSesion.prepareCall("{call [cerrar_sesiones] (?) }");
            callableStatement .setString(1,        ""  );
            callableStatement.execute();
           
            clases.controles.connectSesion.commit();
        } 
        catch (Exception e) 
        {
                clases.controles.connectSesion.rollback();
                mensaje=e.toString();
                tipo=0;
        }
        finally
        {
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("tipo", tipo);  
            ob.put("mensaje", mensaje);
            out.print(ob); 
            clases.controles.DesconnectarBDsession();
        }

         %>  
   
 
