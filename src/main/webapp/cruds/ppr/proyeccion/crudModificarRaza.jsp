
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%    if (sesion == true) {

        String mensaje ="";
        int tipo_respuesta = 1;
        try {
            String id = request.getParameter("id");
            String raza = request.getParameter("raza"); 
            String tipo = request.getParameter("tipo"); 
            

            connection.setAutoCommit(false);
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [stp_mae_ppr_raza](?,?,?,?,?)}");
            callableStatement.setInt(1, Integer.parseInt(id));
            callableStatement.setString(2, raza);
            callableStatement.setString(3, tipo);
            
            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();

            tipo_respuesta = callableStatement.getInt("estado_registro");
             mensaje = callableStatement.getString("mensaje");
            if (tipo_respuesta == 0) {
                connection.rollback();
            } else {
                connection.commit();
                
            }

        } catch (Exception e) {
            connection.rollback();
            //   mensaje = e.toString();
        } finally {
            connection.close();
            JSONObject ob = new JSONObject();
            ob = new JSONObject();
            ob.put("tipo_respuesta", tipo_respuesta);
            ob.put("mensaje", mensaje);
            out.print(ob);
        }
    }
%>  