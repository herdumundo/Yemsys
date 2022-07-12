<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>

<%    
     JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String id_usuario       = (String) sesionOk.getAttribute("id_usuario");
    String id_camion        = request.getParameter("id_camion");
    String cantidad_total   = request.getParameter("cantidad_total");
    String array_pedido     = request.getParameter("contenido");
    String id_chofer     = request.getParameter("id_chofer");
    String id_pedido     = request.getParameter("id_pedido");
    String carros_excedentes="";

    String mensaje="";
    int tipo_respuesta=0;    
    try 
    {
        connection.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
        callableStatement = connection.prepareCall("{call [mae_log_ptc_pedidos_editar_2](?,?,?,?,?,?,?,?,?)}");
        callableStatement .setInt(      1,      Integer.parseInt(cantidad_total) );
        callableStatement .setString(   2,      id_camion  );
        callableStatement .setInt(      3,      Integer.parseInt(id_usuario) );
        callableStatement .setString(   4,      array_pedido );
        callableStatement .setString(   5,      id_pedido );
        callableStatement .setString(   6,      id_chofer );
 
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("carros_excedentes", java.sql.Types.VARCHAR);

        callableStatement.execute(); 
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje= callableStatement.getString("mensaje");
        carros_excedentes= callableStatement.getString("carros_excedentes");

        if (tipo_respuesta==0)
        {
            connection.rollback(); 
        }   
        else  
        {
            connection.commit();
        }
             ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", tipo_respuesta);
            ob.put("carros_excedentes", carros_excedentes);
    } 
    catch (Exception e) 
    {           
        ob.put("mensaje", e.toString());
        ob.put("tipo_respuesta", "0");
          ob.put("carros_excedentes", carros_excedentes);
    }
    finally{
        connection.close();
          out.print(ob);
    }
 %>