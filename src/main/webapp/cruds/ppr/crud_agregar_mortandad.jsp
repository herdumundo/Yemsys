<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@include  file="../../cruds/conexion.jsp" %>

<%
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    String fecha = request.getParameter("fecha");
    String lote = request.getParameter("lote");
    String fila = request.getParameter("fila");
    String cantidad = request.getParameter("cantidad");
    String aviario = request.getParameter("aviario");
    String suma = request.getParameter("sum");
    String mensaje = "";
    String tipo_registro = "";

    try {
   
        CallableStatement  callableStatement=null;    
        callableStatement = connection.prepareCall("{call [stp_mae_ppr_insert_mortandad](?,?,?,?,?,?,?,?)}");
        
        callableStatement .setString(1, fecha   );
        callableStatement .setString(2, lote  );
        callableStatement .setString(3, fila );
        callableStatement .setString(4, cantidad );
        callableStatement .setString(5, aviario );
        callableStatement .setString(6, suma );
        callableStatement.registerOutParameter("tipo", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute(); 
        tipo_registro = callableStatement.getString("tipo");
        mensaje= callableStatement.getString("mensaje");
        
    } catch (Exception ex) {
        String error = ex.getMessage();

    } finally {
        connection.close();
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);

        out.print(obje);
    }
%>
