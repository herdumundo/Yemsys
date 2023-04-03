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
    String cabecera = "";
    JSONObject ob = new JSONObject();
    JSONArray jsonArray = new JSONArray();
    try {
        String id = request.getParameter("id");
        // Create an instance of HttpClient
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost requests = new HttpPost("http://localhost:8000/maehara/ptcDetalleLotesCancelacionTransferencia");
        requests.addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRvcyI6W3siY29kX3VzdWFyaW8iOjEwMTYsInVzdWFyaW8iOiJodmVsYXpxdWV6IiwicGFzc3dvcmQiOiIyMDJjYjk2MmFjNTkwNzViOTY0YjA3MTUyZDIzNGI3MCIsImNsYXNpZmljYWRvcmEiOiJCIiwicm9sIjoiVSIsIm5vbWJyZSI6IkhFUk5BTiBWRUxBWlFVRVoiLCJpZF9yb2wiOjE2LCJpZF9lc3RhZG8iOjEsImNsYXZlIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAifV0sImlhdCI6MTY3OTQxMTQ4OH0.PfanV5CimVr7LpuhoOvxwHnm8yMqTDO6Ff8PQbaTcBY");
        JSONObject requestBody = new JSONObject();
        requestBody.put("idCab", id);

        StringEntity params = new StringEntity(requestBody.toString());
        requests.addHeader("content-type", "application/json");
        requests.setEntity(params);

        // Execute the request and get the response
        HttpResponse responses = httpClient.execute(requests);
        int statusCode = responses.getStatusLine().getStatusCode();
        if(statusCode==200){ // EL statusCode es igual a 200, significa que se está recibiendo datos SQL. Si es error 500, esa fecha no fueron encontrados registros.
        responseString = EntityUtils.toString(responses.getEntity());
        jsonArray = new JSONArray(responseString);
        }
        cabecera = " <table id='grillaLotesTransferencias' class=' table-bordered compact display' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >Nro carro</th>      "
                + " <th  style='color: #fff; background: black;' >Fecha puesta</th>      "
                + " <th  style='color: #fff; background: black;' >Tipo huevo</th>      "
                + " <th  style='color: #fff; background: black;' >Cantidad</th>      " 
                + " </thead> "
                + " <tbody >";

        for (int i = 0; i < jsonArray.length(); i++) 
        {
            tr = tr
                    + "<tr > "
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("cod_carrito") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("fecha_puesta") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("tipo_huevo") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getInt("cantidad") + "</td>"
                    + "</tr>";
        }

    } catch (Exception e) {

    } finally {
        ob.put("grilla", cabecera + tr + "</tbody></table>");
        out.print(ob);
    }
%>
