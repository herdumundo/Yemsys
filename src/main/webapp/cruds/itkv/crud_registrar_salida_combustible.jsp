<%@page import="org.omg.CORBA.INTERNAL"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    if (sesion == true) {

        String responsable          = request.getParameter("responsable");
        String id_usuario           = (String) sesionOk.getAttribute("id_usuario");
        String id_activo            = request.getParameter("id_activo");
        String desc_activo          = request.getParameter("desc_activo");
        String id_ubicacion         = request.getParameter("id_ubicacion");
        String desc_ubicacion       = request.getParameter("desc_ubicacion");
        String id_rubro             = request.getParameter("id_rubro");
        String desc_rubro           = request.getParameter("desc_rubro");
        String id_actividad         = request.getParameter("id_actividad");
        String desc_actividad       = request.getParameter("desc_actividad");
        String id_boca              = request.getParameter("id_boca");
        String desc_boca            = request.getParameter("desc_boca");
        String id_tipo_combustible  = request.getParameter("id_tipo_combustible");
        String tipo_combustible     = request.getParameter("tipo_combustible");
        String km_ho                = request.getParameter("km_ho");
        String lt_inicio            = request.getParameter("lt_inicio");
        String lt_fin               = request.getParameter("lt_fin");
        String lt_total             = request.getParameter("lt_total");  
        
        
        
       
        int tipo_respuesta = 0;
        String mensaje = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
                connection.setAutoCommit(false);
        try {
            if (Integer.parseInt(lt_inicio) > Integer.parseInt(lt_fin)) {
                ob.put("mensaje", "LITROS INICIO NO DEBE SER MAYOR A LITROS FINAL.");
                ob.put("tipo_respuesta", 0);
                
            } 
              
            else  if (Integer.parseInt(lt_inicio)==Integer.parseInt(lt_fin)) {
                ob.put("mensaje", "LITROS INICIO NO DEBE SER IGUAL A LITROS FINAL.");
                ob.put("tipo_respuesta", 0);
                
            }
            else {

                CallableStatement callableStatement = null;
                callableStatement = connection.prepareCall("{call [stp_itkv_salida1] (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                callableStatement.setString(1, responsable);
                callableStatement.setInt(2, Integer.parseInt(id_usuario));
                callableStatement.setString(3, id_activo);
                callableStatement.setString(4, desc_activo);
                callableStatement.setString(5, id_ubicacion);
                callableStatement.setString(6, desc_ubicacion);
                callableStatement.setString(7, id_rubro);
                callableStatement.setString(8, desc_rubro);
                callableStatement.setString(9, id_actividad);
                callableStatement.setString(10, desc_actividad);
                callableStatement.setString(11, km_ho);
                callableStatement.setString(12, id_boca);
                callableStatement.setString(13, desc_boca);
                callableStatement.setInt(14, Integer.parseInt(lt_inicio));
                callableStatement.setInt(15, Integer.parseInt(lt_fin));
                callableStatement.setInt(16, Integer.parseInt(lt_total));
                callableStatement.setString(17, id_tipo_combustible);
                callableStatement.setString(18, tipo_combustible);

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