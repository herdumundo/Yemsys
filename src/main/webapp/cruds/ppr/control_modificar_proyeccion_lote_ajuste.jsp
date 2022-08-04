<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    if (sesion == true) 
    {
        String id               = request.getParameter("id");
        String fecha_ajuste     = request.getParameter("fecha_ajuste");
        String saldo_nuevo      = request.getParameter("saldo_nuevo");
        String saldo_viejo      = request.getParameter("saldo_viejo");
        String dia_ajuste       = request.getParameter("dia_ajuste");
        String semana_ajuste    = request.getParameter("semana_ajuste");
        String comentario       = request.getParameter("comentario");
        String usuario = (String) sesionOk.getAttribute("nombre_usuario");

        int tipo_respuesta      = 0;
        String mensaje          = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
   
        
        
 try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_ajuste] (?,?,?,?,?,?,?,?,?,?)}");
        callableStatement.setInt(1, Integer.parseInt(id));
        callableStatement.setString(2, fecha_ajuste);
        callableStatement.setString(3, saldo_nuevo);
        callableStatement.setString(4, saldo_viejo);
        callableStatement.setString(5, dia_ajuste);
        callableStatement.setString(6, semana_ajuste); 
        callableStatement.setString(7, comentario); 
        callableStatement.setString(8, usuario); 
        
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        if (tipo_respuesta == 0) 
        {
            connection.rollback();
        } 
        else 
        {
          connection.commit();
         }
    } catch (Exception e) 
    {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        connection.rollback();
    } finally {

        connection.close();
        out.print(ob);
    }}
%> 