<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    if (sesion == true) {

        String lote = request.getParameter("txt_lote_crear_pred");
        String cantidad = request.getParameter("txt_cant_aves_crear_pred");
        String obse = request.getParameter("comentario_pred");
        String fecha_descarte = request.getParameter("txt_fecha_salida_pred");
        String semana_descarte = request.getParameter("txt_eddad_semanas_salida_pred");
        String dia_descarte = request.getParameter("txt_eddad_dias_salida_pred");
         

        int tipo_respuesta = 0;
        String mensaje = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();

        try {
            connection.setAutoCommit(false);
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_descarte_lote_crear](?,?,?,?,?,?,?,?)}");
            callableStatement.setString(1, lote);
            callableStatement.setString(2, cantidad);
            callableStatement.setString(3, obse);
            callableStatement.setString(4, fecha_descarte);
            callableStatement.setString(5, semana_descarte);
            callableStatement.setString(6, dia_descarte);
             

            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();
            tipo_respuesta = callableStatement.getInt("estado_registro");
            mensaje = callableStatement.getString("mensaje");

            ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", tipo_respuesta);
            if (tipo_respuesta == 0) {
                connection.rollback();
            } else {
                connection.commit();
            }

        } catch (Exception e) {
            ob.put("mensaje", e.getMessage());
            ob.put("tipo_respuesta", 0);
            connection.rollback();
        } finally {

            connection.close();
            out.print(ob);
        }
    }
%> 