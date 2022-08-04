<%@page import="org.json.JSONObject"%> 
<%@include  file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>

<%     
    if (sesion == true) 
    {
        String id = request.getParameter("id");
        int tipo_mensaje = 0;
        String mensaje = "";
        String mensaje_impresion = "";

        try {
            CallableStatement callableStatement = null;
            String call_detalle = "{call  pa_eliminar_tipo_reproceso ( ?, ?   )}";
            callableStatement = connection.prepareCall(call_detalle);
            callableStatement.setInt(1, Integer.parseInt(id));
            callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
            callableStatement.execute();
            tipo_mensaje = callableStatement.getInt("mensaje");

            mensaje = "REGISTRO ELIMINADO";
            mensaje_impresion = "error";

        } catch (Exception e) {
            tipo_mensaje = 1;
            mensaje = e.toString();
            mensaje_impresion = "error";
        }
        finally
        {
            connection.close();
            JSONObject ob = new JSONObject();
            ob = new JSONObject();
            ob.put("mensaje", mensaje);
            ob.put("tipo_mensaje", tipo_mensaje);
            ob.put("mensaje_impresion", mensaje_impresion);
            out.print(ob); 
        }
    }
%>     