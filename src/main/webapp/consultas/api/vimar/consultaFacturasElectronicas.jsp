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
    JSONArray jsonArray = new JSONArray();
    JSONObject jo = new JSONObject();

    try {
        String desde = request.getParameter("inicio");
        String hasta = request.getParameter("fin");
        
        // Create an instance of HttpClient
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost requests = new HttpPost("http://localhost:8000/vimar/facturacionElectronica");
        JSONObject requestBody = new JSONObject();
        requestBody.put("fechaDesde", desde);
        requestBody.put("fechaHasta", hasta);
        StringEntity params = new StringEntity(requestBody.toString());
        requests.addHeader("content-type", "application/json");
        requests.setEntity(params);
        
        
        HttpResponse responses = httpClient.execute(requests);
        
        responseString = EntityUtils.toString(responses.getEntity());
        jsonArray = new JSONArray(responseString);

    } catch (Exception e) {

    } finally {

        out.print(jsonArray);
    }
%>
