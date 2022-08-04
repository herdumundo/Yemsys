<%@page import="org.json.JSONObject"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%     
    if (sesion == true) 
    {

        String id = request.getParameter("id");
        String clasificadora = request.getParameter("clasificadora");
        String descripcion = request.getParameter("descripcion");
        String tipo_reproceso = request.getParameter("tipo_reproceso");
        int tipo_mensaje = 0;
        String mensaje = "";
        String mensaje_impresion = "";

        try {
            CallableStatement callableStatement = null;
            String call_detalle = "{call  pa_editar_tipo_reproceso ( ?, ?,?,?,?   )}";
            callableStatement = connection.prepareCall(call_detalle);
            callableStatement.setInt(1, Integer.parseInt(id));
            callableStatement.setString(2, (clasificadora));
            callableStatement.setString(3, (descripcion));
            callableStatement.setString(4, (tipo_reproceso));

            callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);

            callableStatement.execute();
            tipo_mensaje = callableStatement.getInt("mensaje");

            mensaje = "REGISTRO MODIFICADO CON EXITO";
            mensaje_impresion = "success";

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