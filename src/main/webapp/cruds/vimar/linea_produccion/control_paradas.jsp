 
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%  
    String linea = (String) sesionOk.getAttribute("clasificadora");
    String usuario = (String) sesionOk.getAttribute("id_usuario");

    String nro_produccion = request.getParameter("cbox_op");
    String tipo_parada = request.getParameter("tipo_parada");
    String motivo_parada = request.getParameter("txt_motivo");
    String[] partes;
    String presentacion = "";
    int nro_prod = 0;
     int tipo_respuesta = 0;
    String mensaje = "";
    try {
      if (tipo_parada.equals("INICIO")) {

        partes = nro_produccion.toString().split("-");
        nro_prod = Integer.parseInt(partes[0].trim());
        presentacion = partes[1].trim();
    }
 
        if (tipo_parada.equals("INICIO")) {
            connection.setAutoCommit(false);
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call vim_prod_parada_lineas_inicio(?,?,?,?,?,?,?)}");
            callableStatement.setString(1, motivo_parada);
            callableStatement.setString(2, usuario);
            callableStatement.setInt(3, nro_prod);
            callableStatement.setString(4, linea);
            callableStatement.setString(5, presentacion);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();

            tipo_respuesta = callableStatement.getInt("mensaje");
            mensaje = callableStatement.getString("detalle_mensaje");

            if (tipo_respuesta == 0) {
                connection.rollback();
            } else {
                //cn.rollback();
                connection.commit();
            }
        } else {
            //int nro_prod_fin= Integer.parseInt(request.getParameter("combo_op_fin")); //SE COLOCA AQUI, PORQUE GENERA CONFLICTO SI EL TIPO DE PARADA ES INICIO.
            String nro_prod_fin = request.getParameter("combo_op_fin"); //SE COLOCA AQUI, PORQUE GENERA CONFLICTO SI EL TIPO DE PARADA ES INICIO.

            connection.setAutoCommit(false);
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call vim_prod_parada_lineas_fin(?,?,?)}");
            callableStatement.setInt(1, Integer.parseInt(nro_prod_fin));
            callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();
            tipo_respuesta = callableStatement.getInt("mensaje");
            mensaje = callableStatement.getString("detalle_mensaje");
            if (tipo_respuesta == 0) {
                connection.rollback();
            } else {
                 connection.commit();

            }
        }

    } catch (Exception e) {
        connection.rollback();
        mensaje = e.toString();
        tipo_respuesta = 0;
    }
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    ob.put("tipo", tipo_respuesta);
    ob.put("mensaje", mensaje);
    out.print(ob);%>  