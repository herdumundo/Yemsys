<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../../chequearsesion.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    if (sesion == true) {
     
    String lote                     = request.getParameter("txt_lote_crear");
    String aviario                  = request.getParameter("select_aviario_crear");
    String raza                     = request.getParameter("select_raza_crear");
    String fechaA                   = request.getParameter("txt_fecha_nacA_crear");
    String fechaB                   = request.getParameter("txt_fecha_nacB_crear");
    String cantidad                 = request.getParameter("txt_cant_aves_crear");
    String capacidad                = request.getParameter("txt_capacidad_crear");
    String comentario               = request.getParameter("comentario");
    String edad_dias_produccion     = request.getParameter("txt_eddad_dias_prod_crear");
    String edad_semanas_produccion  = request.getParameter("txt_eddad_sems_prod_crear");
    String fecha_produccion         = request.getParameter("txt_fecha_produccion_crear");
    
    String edad_dias_predescarte    = request.getParameter("txt_eddad_dias_pred_crear");
    String edad_semanas_predescarte = request.getParameter("txt_eddad_sems_pred_crear");
    String fecha_predescarte        = request.getParameter("txt_fecha_predescarte_crear");
    String idEscenarioLote        = request.getParameter("idEscenarioLote");
    
     int tipo_respuesta = 0;
    String mensaje = "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
         
 try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_escenario_lote_crear](?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            callableStatement.setString(    1,  lote);
            callableStatement.setString(    2,  aviario);
            callableStatement.setString(    3,  fechaA);
            callableStatement.setString(    4,  fechaB);
            callableStatement.setInt(       5,  Integer.parseInt(cantidad) );
            callableStatement.setString(    6,  comentario);
            callableStatement.setString(    7,  edad_dias_produccion);
            callableStatement.setString(    8,  edad_semanas_produccion);
            callableStatement.setString(    9,  fecha_produccion);
            callableStatement.setString(    10, edad_dias_predescarte);
            callableStatement.setString(    11, edad_semanas_predescarte);
            callableStatement.setString(    12, fecha_predescarte);
            callableStatement.setString(    13, raza);
            callableStatement.setInt(       14, Integer.parseInt(capacidad));
            callableStatement.setString(    15, idEscenarioLote);

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
    }}
%> 