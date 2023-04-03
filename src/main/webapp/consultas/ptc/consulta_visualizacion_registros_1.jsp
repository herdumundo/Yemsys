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
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%
        String Token = (String) sesionOk.getAttribute("Token");
        String responseString="";
    try {
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpGet httpget = new HttpGet("http://localhost:8000/lotesGrilla");
        httpget.addHeader("Authorization", "Bearer " + Token);
        HttpResponse responses = httpClient.execute(httpget);
        
            responseString = EntityUtils.toString(responses.getEntity());
            JSONArray jsonArray = new JSONArray(responseString);
         for (int i = 0; i < jsonArray.length(); i++) {
             String surname = jsonArray.getJSONObject(i).getString("cod_lote");
            String carro = jsonArray.getJSONObject(i).getString("cod_carrito");
          }
         
            


        } catch (Exception e) 
        {
                String err=e.getMessage();
    }
    finally{
        out.print(responseString);
    } 
%>
