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
        {       pst2 = connection.prepareStatement("  select *,convert(varchar,fecha_entrada,103) as entrada_form,convert(varchar,fecha_salida,103) as salida_form "
                + "from v_mae_ppr_lotes_ventas	where fecha='"+fecha_ultima+"' and cantidad_aves>0 ORDER BY fecha_entrada ASC ");
                rs2 = pst2.executeQuery(); 
              while (rs2.next()) 
              {
                /* if(venta_sobrante>0)
                {
                   if(String.valueOf(venta_sobrante)!=String.valueOf(venta) )
                    {
                      venta=venta_sobrante;
                    }  
                }*/
                  
                  CallableStatement callableStatement = null;
                  callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_refrescar_barra_lote_descarte_bak] (?,?,?,?,?,?,?)}");
                  callableStatement.setInt      (1,   rs2.getInt("id"));
                  callableStatement.setInt      (2,   venta );
                  callableStatement.setString   (3,   fecha_ultima);
                  callableStatement.setInt      (4,   venta_sobrante);

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