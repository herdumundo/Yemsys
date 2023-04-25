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
        String fecha = request.getParameter("fecha");
        // Create an instance of HttpClient
        HttpClient httpClient = HttpClientBuilder.create().build();
        HttpPost requests = new HttpPost("http://localhost:8000/maehara/ptcCancelacionTransferencia");
        requests.addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRvcyI6W3siY29kX3VzdWFyaW8iOjEwMTYsInVzdWFyaW8iOiJodmVsYXpxdWV6IiwicGFzc3dvcmQiOiIyMDJjYjk2MmFjNTkwNzViOTY0YjA3MTUyZDIzNGI3MCIsImNsYXNpZmljYWRvcmEiOiJCIiwicm9sIjoiVSIsIm5vbWJyZSI6IkhFUk5BTiBWRUxBWlFVRVoiLCJpZF9yb2wiOjE2LCJpZF9lc3RhZG8iOjEsImNsYXZlIjoiMjAyY2I5NjJhYzU5MDc1Yjk2NGIwNzE1MmQyMzRiNzAifV0sImlhdCI6MTY3OTQxMTQ4OH0.PfanV5CimVr7LpuhoOvxwHnm8yMqTDO6Ff8PQbaTcBY");
        JSONObject requestBody = new JSONObject();
        requestBody.put("fecha", fecha);

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
        cabecera = " <table id='grilla_transferencias' class=' table-bordered compact display' style='width:100%'>"
                + "<thead>"
                + ""
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >Nro</th>      "
                + " <th  style='color: #fff; background: black;' >Fecha creación</th>      "
                + " <th  style='color: #fff; background: black;' >Origen</th>      "
                + " <th  style='color: #fff; background: black;' >Destino</th>      "
                + " <th  style='color: #fff; background: black;' >Creado por</th>      "
                + " <th  style='color: #fff; background: black;' >Chofer</th>      "
                + " <th  style='color: #fff; background: black;' >Camión</th>      "
                + " <th  style='color: #fff; background: black;' >Cancelado por</th>      "
                + " <th  style='color: #fff; background: black;' >Fecha de cancelacion</th>      "
                + " <th  style='color: #fff; background: black;' >Acción</th>      "
                + " </thead> "
                + " <tbody >";

        for (int i = 0; i < jsonArray.length(); i++) 
        {
            int id = jsonArray.getJSONObject(i).getInt("id");
            String origen = jsonArray.getJSONObject(i).getString("origen");
            String origenRes = jsonArray.getJSONObject(i).getString("origenRes");
            String destino = jsonArray.getJSONObject(i).getString("destino");
           
            String filaAccion = "   <div class='btn btn-xs bg-yellow' onclick=\"visualizar_lotes_cancelacion_transferencias_ptc("+id+")\"        title='Visualizar lotes'><i class='fa fa-eye'  ></i></div>"
                    +"   <div class='btn btn-xs bg-red' onclick=\"cancelar_transferencias_ptc(" + id + ",'" + origen + "','" + destino + "','" + origenRes + "')\"        title='Cancelar transferencia'><i class='fa fa-times'  ></i></div>"
                    + "             <div class='btn btn-xs bg-green'  onclick=\"reprocesar_transferencias_ptc(" + id + ",'" + origen + "','" + destino + "')\"      title='Reprocesar transferencia'><i class='fa fa-clipboard  '  ></i></div>";
            if (jsonArray.getJSONObject(i).getString("reprocesado").equals("SI")) {
                filaAccion = " <div class='btn btn-xs bg-yellow'    title='Cancelar transferencia'><i class='fa fa-times '  ></i></div>"
                        + "         <div class='btn btn-xs bg-green'   onclick=\"reprocesar_transferencias_ptc(" + id + ",'" + origen + "','" + destino + "')\"    title='Reprocesar transferencia'><i class='fa fa-clipboard  '  ></i></div>";
            }

            tr = tr
                    + "<tr > "
                    + "<td style=\"font-weight:bold\" > " + id + "</td>"
                    + "<td style=\"font-weight:bold\" > " + jsonArray.getJSONObject(i).getString("fecha") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + origen + "</td>"
                    + "<td style=\"font-weight:bold\">  " + destino + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("usuario") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("nombre_chofer") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("camion") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("usuario_cancelacion") + "</td>"
                    + "<td style=\"font-weight:bold\">  " + jsonArray.getJSONObject(i).getString("fecha_cancelacion") + "</td>"
                    + "<td class='text-center'    style=\"font-weight:bold\" >" + filaAccion + "</td>"
                    + "</tr>";
        }

    } catch (Exception e) 
    {
        String error= e.getMessage();
    } finally {
        ob.put("grilla", cabecera + tr + "</tbody></table>");
        out.print(ob);
    }
%>
