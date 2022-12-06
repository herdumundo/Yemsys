<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
 <%@ page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>

<%  try 
    {
         String area = (String) sesionOk.getAttribute("area");
        String clasificadora = (String) sesionOk.getAttribute("clasificadora");
        String carro = request.getParameter("id");
        String factura = request.getParameter("factura");
        String nro_fac = factura.substring(factura.length() - 7);

        String verificador_SAP = "0";
        JSONObject ob = new JSONObject();
        JSONArray jarray = new JSONArray();
        
       Statement   stmt1 = connection.createStatement();
        ResultSet rs_lote = stmt1.executeQuery(" exec [mae_cch_select_lotes_disponibles_embarque_test]  @area_cch='" + area + "',"
                + "@cod_carrito='" + carro + "',@nro_factura='" + factura + "'");

        while (rs_lote.next()) {
            ob = new JSONObject();
            verificador_SAP = rs_lote.getString("tipo_huevo");
            ob.put("item_codigo", rs_lote.getString("tipo_huevo"));
            ob.put("tipo", rs_lote.getString("nombre_tipo"));
            ob.put("nro_carrito", rs_lote.getString("cod_carrito"));
            ob.put("cod_lote", rs_lote.getString("cod_lote"));
            ob.put("cantidad", rs_lote.getString("cantidad"));
            ob.put("fecha_puesta", rs_lote.getString("fecha_puesta"));
            ob.put("estado", rs_lote.getString("estado"));
            ob.put("estado_liberacion", rs_lote.getString("estado_liberacion"));
        
            
            
            ob.put("identificador_lote", rs_lote.getString("cod_interno"));
            ob.put("mensaje", "1");
            ob.put("tipo_mensaje", "1");

            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call pa_embarque_pendientes( ?, ?, ?, ?, ? ,?,?,?,?,?,?)}");
            callableStatement.setString(1, clasificadora);
            callableStatement.setString(2, rs_lote.getString("nombre_tipo"));
            callableStatement.setInt(3, rs_lote.getInt("cantidad"));
            callableStatement.setInt(4, rs_lote.getInt("tipo_huevo"));
            callableStatement.setString(5, rs_lote.getString("cod_lote"));
            callableStatement.setInt(6, rs_lote.getInt("cod_carrito"));
            callableStatement.setString(7, nro_fac);
            callableStatement.setString(8, rs_lote.getString("fecha_puesta"));
            callableStatement.setString(9, rs_lote.getString("estado"));
            callableStatement.setInt(10, rs_lote.getInt("cod_interno"));

            callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
            callableStatement.execute();
            Integer mensajeads = callableStatement.getInt("mensaje");

            jarray.put(ob);
        }

        if (verificador_SAP.equals("0")) {
            ob.put("item_codigo", "0");
            ob.put("tipo", "0");
            ob.put("nro_carrito", "0");
            ob.put("cod_lote", "0");
            ob.put("cantidad", "0");
            ob.put("fecha_puesta", "0");
            ob.put("estado", "0");
            ob.put("estado_liberacion", "0");
            ob.put("identificador_lote", "0");
            ob.put("tipo_mensaje", "0");
            ob.put("cod_interno", "0");
            ob.put("mensaje", "1");
        }

        out.print(jarray);
    } catch (Exception e) {
        JSONObject ob = new JSONObject();
        JSONArray jarray = new JSONArray();
        ob = new JSONObject();
        ob.put("tipo_mensaje", "0");
        ob.put("item_codigo", "0");
        ob.put("tipo", "0");
        ob.put("nro_carrito", "0");
        ob.put("cod_lote", "0");
        ob.put("cantidad", "0");
        ob.put("fecha_puesta", "0");
        ob.put("estado", "0");
        ob.put("estado_liberacion", "0");
        ob.put("identificador_lote", "0");
        ob.put("mensaje", "0");
        ob.put("tipo_mensaje", "0");
        out.print(jarray);
    } finally {
        connection.close();
    }
%>