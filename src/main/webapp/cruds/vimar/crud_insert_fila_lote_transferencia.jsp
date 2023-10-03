<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../chequearsesion.jsp" %>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../cruds/conexion.jsp" %> 
<%
// Creación del objeto JSON que se utilizará para la respuesta    
JSONObject responseJSON =   new JSONObject();
// Obteniendo el valor del parámetro "CardCode" de la solicitud
String card_code                    =   request.getParameter("CardCode");
String card_name                    =   request.getParameter("CardName");
String address_tra                  =   request.getParameter("Address");
String observacion_tra              =   request.getParameter("observacion");
String item_code                    =   request.getParameter("ItemCode");
String bar_code                     =   request.getParameter("BarCode");
String item_name                    =   request.getParameter("ItemName");
String quantity_tra                 =   request.getParameter("Quantity");
String origen_tra                   =   request.getParameter("origen");
String destino_tra                  =   request.getParameter("destino");
String lote_tra                     =   request.getParameter("lote");
String observacion_detalle_tra      =   request.getParameter("observacion_detalle");
String lote_largo                   =   request.getParameter("loteLargo");
String lote_corto                   =   request.getParameter("loteCorto");
String id_usu                       = (String) sesionOk.getAttribute("id_usuario");
String userName                     = (String) sesionOk.getAttribute("nombre_usuario");


    
    try {
            //llamamos al procedimiento de almacenado con la cantidad parametros que le vamos a pasar    
            String call = "{call stp_insert_transferencia_vimar(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            CallableStatement callableStatement = connection.prepareCall(call);
            //sub clase que llama el PDA( nro de argumento, variable a la que agregamos los valores)
            callableStatement.setString(1, card_code);
            callableStatement.setString(2, card_name);
            callableStatement.setString(3, address_tra);
            callableStatement.setString(4, observacion_tra);
            callableStatement.setString(5, item_code);
            callableStatement.setString(6, bar_code);
            callableStatement.setString(7, item_name);
            callableStatement.setString(8, quantity_tra);
            callableStatement.setString(9, origen_tra);
            callableStatement.setString(10, destino_tra);
            callableStatement.setString(11, lote_tra);
            callableStatement.setString(12, observacion_detalle_tra);
            callableStatement.setString(13, id_usu);
            callableStatement.setString(14, userName);
            callableStatement.setString(15, lote_largo);
            callableStatement.setString(16, lote_corto);
            
            // Registro de parámetros de salida
            callableStatement.registerOutParameter(17, Types.VARCHAR);
            callableStatement.registerOutParameter(18, Types.INTEGER);
            // Ejecución del procedimiento almacenado
            callableStatement.execute();
            
            // Obtención de resultados del procedimiento almacenado
            String mensaje = callableStatement.getString(17);
            int tipo = callableStatement.getInt(18);
            // Configuración de la respuesta JSON
                responseJSON.put("tipo", tipo);
                responseJSON.put("msg", mensaje);  // Mensaje de éxito
    } catch (SQLException e) {
            // Manejo de excepciones SQL y configuración de la respuesta JSON en caso de error
                responseJSON.put("tipo", 0);
                responseJSON.put("msg", "Error de SQL: " + e.getMessage());  // Mensaje de error SQL
            }
            // Envío de la respuesta JSON al cliente
            out.print(responseJSON);
%> 

