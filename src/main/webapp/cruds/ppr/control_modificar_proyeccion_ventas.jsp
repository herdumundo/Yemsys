<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    if (sesion == true) 
    {
        String fecha       = request.getParameter("fecha");
        String venta       = request.getParameter("venta");
        int id              = 274;

        int tipo_respuesta      = 0;
        String mensaje          = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
   
  try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_refrescar_barra_lote_descarte_bak] (?,?,?,?,?)}");
        callableStatement.setInt        (1, id);
        callableStatement.setInt        (2, Integer.parseInt(venta));
        callableStatement.setString     (3, fecha);

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
    } finally 
    {
        connection.close();
        out.print(ob);
    } 
    
    }
%> 