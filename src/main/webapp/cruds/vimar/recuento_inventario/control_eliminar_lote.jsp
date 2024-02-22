<%@page import="org.apache.http.client.config.RequestConfig"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.client.methods.HttpGet"%> 
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
 <%@include file="../../../cruds/conexion.jsp" %>
<%  
    
    if (sesion == true) {
    
 
    String lote = request.getParameter("lote");
    String itemCode = request.getParameter("itemCode");
    String ubicacion = request.getParameter("ubicacion");
    int tipo_respuesta = 1;
    int tipo = 1;
    String mensaje = "";
    try {

        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call [vim_prod_recuento_eliminar_lote](?,?,?,?,?,?,?,? )}");
        callableStatement.setString(1, lote);
        callableStatement.setInt(2, 0);
        callableStatement.setInt(3, 0);
        callableStatement.setString(4, ubicacion);
        callableStatement.setString(5, itemCode);
        callableStatement.setString(6, "LOTE MANUAL");
        callableStatement.registerOutParameter("tipo", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();

        tipo = callableStatement.getInt("tipo");
        mensaje = callableStatement.getString("mensaje");
        tipo_respuesta = tipo_respuesta * tipo;
        if (tipo_respuesta == 0) {
            connection.rollback();
        } else {
            connection.commit();
        }
    } catch (Exception e) {
        connection.rollback();
        mensaje = e.toString();
    } finally {
        connection.close();
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        ob.put("tipo", tipo_respuesta);
        ob.put("mensaje", mensaje);
        out.print(ob);
    }
    
    }
%>  