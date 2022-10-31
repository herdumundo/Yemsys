<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    if (sesion == true) 
    {
        String id_cab           = request.getParameter("id_cab");
        String id               = request.getParameter("id");
        String fecha_barra      = request.getParameter("fecha");
         

        int tipo_respuesta      = 0;
        String mensaje          = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
   
   
        
 try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_refrescar_barra_lote] (?,?,?,?)}");
        callableStatement.setInt    (1, Integer.parseInt(id_cab));
        callableStatement.setString (2, fecha_barra);
        
        
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
    } }
%> 