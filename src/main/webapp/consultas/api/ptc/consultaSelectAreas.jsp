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
    String tr = "";
    String contenedor = "";
    JSONObject ob = new JSONObject();
    try {
        String origen = request.getParameter("origen");
        String destino = request.getParameter("destino");
        // Create an instance of HttpClient
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost requests = new HttpPost("http://localhost:8000/maehara/ptcAreas");
        requests.addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRvcyI6W3siY29kX3VzdWFyaW8iOjEwMTYsInVzdWFyaW8iOiJodmVsYXpxdWV6IiwicGFzc3dvcmQiOiIyMDJjYjk2MmFjNTkwNzViOTY0YjA3MTUyZDIzNGI3MCIsImNsYXNpZmljYWRvcmEiOiJCIiwicm9sIjoiVSIsIm5vbWJyZSI6IkhFUk5BTiBWRUxBWlFVRVoiLCJpZF9yb2wiOjE2LCJpZF9lc3RhZG8iOjEsImNsYXZlIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAifV0sImlhdCI6MTY3OTQxMTQ4OH0.PfanV5CimVr7LpuhoOvxwHnm8yMqTDO6Ff8PQbaTcBY");
     
        HttpResponse responses = httpClient.execute(requests);
        responseString = EntityUtils.toString(responses.getEntity());
        JSONArray jsonArray = new JSONArray(responseString);
        
        for (int i = 0; i < jsonArray.length(); i++) 
        {
            String JsonArea=jsonArray.getJSONObject(i).getString("descripcion2");
            if(!JsonArea.equals(origen)){
                if(  !JsonArea.equals(destino)){
            contenedor=contenedor+ "<option value='"+jsonArray.getJSONObject(i).getString("area") +"'>"+jsonArray.getJSONObject(i).getString("descripcion2") +"</option>";
                }
            }
        }

    } catch (Exception e) { 

    } finally {

        ob.put("lista", contenedor);

        out.print(ob);
    }
%>
