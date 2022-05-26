<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
 <%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>

<%    
    clases.controles.connectarBD();
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String id_camion        = request.getParameter("id_camion");
    String id_camion_nuevo        = request.getParameter("id_camion_nuevo");
    String id_pedido   = request.getParameter("id_pedido");
  
     
    
   
     String mensaje="";
     int tipo_respuesta=0;    
    try 
    { 
        clases.controles.connect.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
        callableStatement = clases.controles.connect.prepareCall("{call [mae_log_cambio_camion](?,?,?,?,?)}");
        
        callableStatement .setInt(1,        Integer.parseInt(id_pedido) );
        callableStatement .setInt(2,        Integer.parseInt(id_camion)   );
        callableStatement .setInt(3,        Integer.parseInt(id_camion_nuevo)   );
      

        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute(); 
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje= callableStatement.getString("mensaje");
          if (tipo_respuesta==0)
        {
            clases.controles.connect.rollback(); 
        }   
        else  
        {
 
          clases.controles.connect.commit();
        }
    } 
    catch (Exception e) 
    {           
        mensaje=e.toString();
        tipo_respuesta=0;
 
    }
    finally
    {   clases.controles.DesconnectarBD();
        ob.put("mensaje", mensaje);
       
        out.print(ob); 
    }
   %>