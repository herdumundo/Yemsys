<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<% 
        if (sesion == true) {
    String itemcode =                         request.getParameter("itemcode");
 
    
    
    int tipo_respuesta = 0;
    String mensaje = "";
    String estado= "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
         
 try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call mae_bal_gestionar_mtp(?,?,?,?)}");
        callableStatement.setString(1,itemcode);
        
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("estado", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");
        estado = callableStatement.getString("estado");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        ob.put("estado", estado);
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
