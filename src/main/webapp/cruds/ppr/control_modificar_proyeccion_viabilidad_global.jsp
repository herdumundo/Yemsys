<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%  
    if (sesion == true) 
    {
        String fecha       = request.getParameter("fecha_proyeccion_principal");

        int tipo_respuesta      = 0;
        String mensaje          = "";
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
    PreparedStatement pst,pst2  ;
    ResultSet rs,rs2 ;
    
   /* pst = connection.prepareStatement(" select * from ppr_pry_cab WHERE  ubicacion='PPR'");
    rs = pst.executeQuery(); 
    */
    pst2 = connection.prepareStatement(" select * from ppr_pry_cab ");
    rs2 = pst2.executeQuery(); 
 try {
        connection.setAutoCommit(false);
    
         while (rs2.next()) 
        {
            
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_refrescar_barra_lote_descarte] (?,?,?,?,?)}");
            callableStatement.setInt    (1, rs2.getInt("id") );
            callableStatement.setString (2, fecha);
            callableStatement.setString (3, rs2.getString("ubicacion") );
            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();
            tipo_respuesta = callableStatement.getInt("estado_registro");
            mensaje = callableStatement.getString("mensaje");
 
        }
         
         
         
        
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [stp_mae_ppr_proyeccion_actualizar_fecha_viabilidad] (?,?,?)}");
            callableStatement.setString (1, fecha);

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
    } finally 
    {
        connection.close();
        out.print(ob);
    } }
%> 