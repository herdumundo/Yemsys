<%-- 
    Document   : consultaTransferenciasCancelaciones
    Created on : 20-mar-2023, 15:04:51
    Author     : hvelazquez
--%>

<%@page import="org.apache.http.entity.StringEntity"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="java.sql.Date"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.net.URL"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.impl.client.HttpClientBuilder"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.json.JSONObject"%>
<%@include  file="../../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%    String responseString = "";
    int tipoMensaje = 0;
    String mensaje = "";
    JSONObject ob = new JSONObject();
    JSONObject jsonArray = new JSONObject();
    try {
        String id       = request.getParameter("id");
        String origen   = request.getParameter("origen");
        String usuario  = (String) sesionOk.getAttribute("nombre_usuario");

        // Create an instance of HttpClient
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost requests = new HttpPost("http://localhost:8000/maehara/ptcCrearCancelacionTransferenciaLotes");
        requests.addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRvcyI6W3siY29kX3VzdWFyaW8iOjEwMTYsInVzdWFyaW8iOiJodmVsYXpxdWV6IiwicGFzc3dvcmQiOiIyMDJjYjk2MmFjNTkwNzViOTY0YjA3MTUyZDIzNGI3MCIsImNsYXNpZmljYWRvcmEiOiJCIiwicm9sIjoiVSIsIm5vbWJyZSI6IkhFUk5BTiBWRUxBWlFVRVoiLCJpZF9yb2wiOjE2LCJpZF9lc3RhZG8iOjEsImNsYXZlIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAifV0sImlhdCI6MTY3OTQxMTQ4OH0.PfanV5CimVr7LpuhoOvxwHnm8yMqTDO6Ff8PQbaTcBY");
        JSONObject requestBody = new JSONObject();
        requestBody.put("id", id);
        requestBody.put("origen", origen);
        requestBody.put("usuario", usuario);

        StringEntity params = new StringEntity(requestBody.toString());
        requests.addHeader("content-type", "application/json");
        requests.setEntity(params);

        // Execute the request and get the response
        HttpResponse responses = httpClient.execute(requests);
        int statusCode = responses.getStatusLine().getStatusCode();
        if(statusCode==200){ // EL statusCode es igual a 200, significa que se está recibiendo datos SQL. Si es error 500, esa fecha no fueron encontrados registros.
        responseString = EntityUtils.toString(responses.getEntity());
        jsonArray = new JSONObject(responseString);
        }

        for (int i = 0; i < jsonArray.length(); i++) 
        { 
            tipoMensaje = jsonArray.getInt("estado_registro") ;
            mensaje     = jsonArray .getString("mensaje") ;
        }             

    } catch (Exception e) 
    {
        String error=e.toString();
    } finally {
        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipoMensaje);
        out.print(ob);
    }
%>
