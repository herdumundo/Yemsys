<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@page contentType="application/json; charset=utf-8" %>
<%   
    if (sesion == true) 
    {
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String id_pedido    = request.getParameter("id_pedido");
        String nro_global   = request.getParameter("nro_global_nuevo");
        String mensaje="";
        int tipo_respuesta=0;    
        try 
        {
            connection.setAutoCommit(false);
            CallableStatement  callableStatement=null;   
            callableStatement = connection.prepareCall("{call [mae_log_ptc_pedidos_editar_nro_global](?,?,?,?)}");
            callableStatement .setInt(  1,  Integer.parseInt(id_pedido));
            callableStatement .setInt(  2,  Integer.parseInt(nro_global));

            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute(); 
            tipo_respuesta = callableStatement.getInt("estado_registro");
            mensaje= callableStatement.getString("mensaje");
            if (tipo_respuesta==0)
            {
                connection.rollback(); 
            }   
            else  
            {
                connection.commit();
            }
                ob.put("mensaje", mensaje);
                ob.put("tipo_respuesta", tipo_respuesta);
        } 
        catch (Exception e) 
        {           
            ob.put("mensaje", e.toString());
            ob.put("tipo_respuesta", "0");
        }
        finally
        {
            connection.close();
            out.print(ob); 
        }
   }%>