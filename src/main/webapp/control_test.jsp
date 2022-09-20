<%-- 
    Document   : control
    Created on : 05-sep-2022, 15:24:23
    Author     : hvelazquez
--%>

  <%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@ page contentType="application/json; charset=utf-8" %>
 <%
            StringBuilder sb = new StringBuilder();  
            URL url = new URL("http://localhost:8087/api/promotoras/");//your url i.e fetch data from .
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            String mensaje_error="";
            JSONArray jsonObj=null; 
            
            String token="eyJhbGciOiJIUzI1NiJ9.eyJ1c3VhcmlvIjoiSEVSTkFOIiwiZXhwIjoxNjYzMTA1NjgxLCJpYXQiOjE2NjMxMDI2ODF9.X2GZyO4ouixiTYKMySmeIMtQ2EnOJjmxc9jEJ_g4axk";
            int tipo_respuesta=0;
            String output="";
     try {
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization",  token);
            conn.setRequestProperty("Accept", "application/json");
            if (conn.getResponseCode() != 200) 
            {
                tipo_respuesta=  conn.getResponseCode();
               // mensaje_error=conn.getResponseMessage();
            }
            
            InputStreamReader in = new InputStreamReader(conn.getInputStream());
            BufferedReader br = new BufferedReader(in);
 
            while ((output = br.readLine()) != null) 
            {   
                sb.append(output + "\n");  
            }
            tipo_respuesta=202;
             
           
            jsonObj = new  JSONArray(sb.toString() );
            conn.disconnect();
        } 
        catch (Exception e) 
        {
          mensaje_error=e.getMessage();
        }
        finally
        {
            JSONObject ob = new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("contenido", jsonObj);
            ob.put("mensaje", mensaje_error);
            out.print(ob);
        }
 %>