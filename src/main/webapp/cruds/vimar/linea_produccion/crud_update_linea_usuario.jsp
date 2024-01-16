<%-- 
    Document   : crud_update_linea_usuario
    Created on : Jan 9, 2024, 10:33:11 AM
    Author     : jbernal
--%>

<%@page import="java.sql.Types"%>
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
JSONObject ob = new JSONObject();
String id                = request.getParameter("idUsuario");
String linea             = request.getParameter("linea");

try {
    String call = "{call vim_stp_linea_usuario(?,?,?,?)}";
    CallableStatement callableStatement = connection.prepareCall (call);
    callableStatement.setString(1, id);
    callableStatement.setString(2, linea);
    callableStatement.registerOutParameter(3, Types.VARCHAR);
    callableStatement.registerOutParameter(4, Types.INTEGER);
    
    callableStatement.execute();
    
    String mensaje = callableStatement.getString(3);
    int tipo = callableStatement.getInt(4);
        ob.put("tipo", tipo);
        ob.put("msg", mensaje);
}
catch (SQLException e){
        ob.put("tipo", 1);
        ob.put("msg", 1);
}
out.print(ob);

%>

