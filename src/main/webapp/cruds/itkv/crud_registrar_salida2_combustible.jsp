<%@page import="org.omg.CORBA.INTERNAL"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    if (sesion == true) {

        String responsable                  = request.getParameter("responsable");
        String id_usuario                   = (String) sesionOk.getAttribute("id_usuario");
        String id_boca                      = request.getParameter("id_boca");
        String desc_boca                    = request.getParameter("desc_boca");
        String id_tipo_combustible          = request.getParameter("id_tipo_combustible");
        String tipo_combustible             = request.getParameter("tipo_combustible");
        String id_boca_destino  = request.getParameter("id_boca_destino");
        String desc_boca_destino     = request.getParameter("desc_boca_destino");
        String lt_inicio                    = request.getParameter("lt_inicio");
        String lt_fin                       = request.getParameter("lt_fin");
        String lt_total                     = request.getParameter("lt_total");  
        
        
        
       
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
            
             else  if (id_boca.equals(id_boca_destino) ) {
                ob.put("mensaje", "BOCA ORIGEN NO DEBE SER IGUAL AL DESTINO");
                ob.put("tipo_respuesta", 0);
                
            }
            else {

                CallableStatement callableStatement = null;
                callableStatement = connection.prepareCall("{call [stp_itkv_salida2] (?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                callableStatement.setString (1, responsable);
                callableStatement.setInt    (2, Integer.parseInt(id_usuario));
                callableStatement.setString (3, id_boca);
                callableStatement.setString (4, desc_boca);
                callableStatement.setInt    (5, Integer.parseInt(lt_inicio));
                callableStatement.setInt    (6, Integer.parseInt(lt_fin));
                callableStatement.setInt    (7, Integer.parseInt(lt_total));
                callableStatement.setString (8, id_tipo_combustible);
                callableStatement.setString (9, tipo_combustible);
                callableStatement.setString (10, id_boca_destino);
                callableStatement.setString (11, desc_boca_destino);

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