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
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    
    
          if (sesion == true) {

        
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    String id_camion = request.getParameter("id_camion");
    String fecha_puesta = request.getParameter("fecha_puesta");
    String area = request.getParameter("area");
    String tipo = request.getParameter("tipo");
    String tipo_carro = request.getParameter("tipo_carro");
    String tipo_huevo = request.getParameter("tipo_huevo");
    String cantidad = request.getParameter("cantidad");
    String categoria = request.getParameter("categoria");
    String cod_carrito = request.getParameter("cod_carrito");
    String tipo_pedido = request.getParameter("tipo_pedido");//CREAR O MODIFICAR PEDIDO
    String id_pedido = request.getParameter("id_pedido");//CREAR O MODIFICAR PEDIDO
    String usuario = (String) sesionOk.getAttribute("user_name");
    if (id_pedido.equals("") || id_pedido == null) {
        id_pedido = "0";
    }

    String carros_excedentes = "";
    String mensaje = "";
    int tipo_respuesta = 0;
    try {
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [mae_log_insert_reserva](?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

        callableStatement.setInt(1, Integer.parseInt(id_camion));
        callableStatement.setString(2, fecha_puesta);
        callableStatement.setString(3, area);
        callableStatement.setString(4, tipo);
        callableStatement.setString(5, tipo_huevo);
        callableStatement.setString(6, cantidad);
        callableStatement.setString(7, categoria);
        callableStatement.setString(8, tipo_carro);
        callableStatement.setString(9, cod_carrito);
        callableStatement.setString(10, tipo_pedido);
        callableStatement.setInt(11, Integer.parseInt(id_pedido));
        callableStatement.setString(12, usuario);
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");
      /*  if (tipo_respuesta == 0) {
         //   clases.controles.connect.rollback();
        } else {
            //  clases.controles.connect.rollback(); 

            clases.controles.connect.commit();
        }*/
    } catch (Exception e) {
        mensaje = e.toString();
        tipo_respuesta = 0;
        carros_excedentes = "";

    } finally {
        connection.close();
        ob.put("mensaje", mensaje);
        ob.put("carro_reserva", cod_carrito);
        ob.put("tipo_respuesta", tipo_respuesta);
        ob.put("carros_excedentes", carros_excedentes);
        out.print(ob);
    }
    
 }
%>