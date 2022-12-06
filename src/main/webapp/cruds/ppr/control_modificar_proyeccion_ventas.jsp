<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    if (sesion == true) 
    {
        String fecha_ultima     = request.getParameter("fecha");
        int venta               = Integer.parseInt(request.getParameter("venta"));
        int id                  = 274;
        int venta_sobrante      = 0;
        int tipo_respuesta      = 0;
        String mensaje          = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        PreparedStatement pst2  ;
        ResultSet rs2 ;         
        connection.setAutoCommit(false);
        try 
        {     /*  pst2 = connection.prepareStatement("  select  id,fecha_entrada,aviario   "
                        + " from v_mae_ppr_lotes_ventas  where MONTH(fecha)=MONTH('"+fecha_ultima+"' ) "
                        + " and year(fecha)=year('"+fecha_ultima+"' ) and  fecha>='"+fecha_ultima+"' "
                        + " and cantidad_aves>0 group by id,fecha_entrada,aviario ORDER BY fecha_entrada ASC  ");
        */
        pst2 = connection.prepareStatement(" select  id,fecha_entrada,aviario   from v_mae_ppr_lotes_ventas "
                + "WHERE fecha>'"+fecha_ultima+"'		 	"
                + "group by id,fecha_entrada,aviario ORDER BY fecha_entrada ASC ");
         
         int contador=1; 
                rs2 = pst2.executeQuery(); 
              while (rs2.next()) 
              {
                  CallableStatement callableStatement = null;
                  callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_refrescar_barra_lote_descarte_bak] (?,?,?,?,?,?,?,?)}");
                  callableStatement.setInt      (1,   rs2.getInt("id"));
                  callableStatement.setInt      (2,   venta );
                  callableStatement.setString   (3,   fecha_ultima);
                  callableStatement.setInt      (4,   venta_sobrante);
                  callableStatement.setInt      (5,   contador);

                  callableStatement.registerOutParameter("estado_registro",   java.sql.Types.INTEGER);
                  callableStatement.registerOutParameter("mensaje",           java.sql.Types.VARCHAR);
                  callableStatement.registerOutParameter("venta_sobrante",    java.sql.Types.VARCHAR);
                  callableStatement.registerOutParameter("fecha_ultima",      java.sql.Types.DATE);
                  
                  
                  callableStatement.execute();

                  tipo_respuesta  = callableStatement.getInt("estado_registro");
                  mensaje         = callableStatement.getString("mensaje");
                  fecha_ultima    = callableStatement.getString("fecha_ultima");//2024-05-08
                  venta_sobrante  = callableStatement.getInt("venta_sobrante");//2305

                  ob.put("mensaje", mensaje);
                  ob.put("tipo_respuesta", tipo_respuesta);
                  contador++; 
              }
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