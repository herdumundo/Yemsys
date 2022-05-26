<%-- 
    Document   : consulta_aviarios_hora
    Created on : 08/03/2021, 03:16:05 PM
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%
     String fecha = request.getParameter("fecha");
   
    JSONObject ob = new JSONObject();
    JSONObject ob_detalle = new JSONObject();
    JSONObject obarr = new JSONObject();
    JSONArray jarray = new JSONArray();         
    JSONArray jarray_det = new JSONArray();         
    ob=new JSONObject();
    String contenedor=""; 
    
            clases.controles.connectarBD();   
            Statement stmt = clases.controles.connect.createStatement();
        ResultSet rs = stmt.executeQuery("   select * from [v_mae_ptc_huevos_recibidos_sin_detalle] where fecha_puesta ='"+fecha+"' ");
        while(rs.next())
        {
             ob=new JSONObject();
          
            ob.put("Clasificadora",rs.getString("clasificadora"));
            ob.put("Cantidad",rs.getString("cantidad"));
            
            
            jarray.put(ob);  
            
        }
        
        
        ResultSet rss = stmt.executeQuery(" SELECT "
                + "                         case clasificadora_origen when 'A' then 'CCHA' WHEN 'B' THEN 'CCHB' WHEN 'H' THEN 'CCHH' WHEN 'SUBPRODUCTOS'"
                + " THEN 'SUBPRODUCTOS' ELSE clasificadora_origen END AS CLASIFICADORA,clasificadora_origen,cantidad,tipo "
                + " FROM [v_mae_ptc_huevos_recibidos_dia] "
                + " WHERE FECHA_PUESTA='"+fecha+"' and clasificadora_origen not in ('o') ORDER BY 2 ");
        while(rss.next())
        {
            ob_detalle=new JSONObject();
            ob_detalle.put("clasificadora",rss.getString("clasificadora"));
            ob_detalle.put("Cantidad",rss.getString("cantidad"));
            ob_detalle.put("tipo",rss.getString("tipo"));
           
            
            jarray_det.put(ob_detalle);  
        }
        
        
        obarr.put("cantidades_clasificadoras", jarray); 
        
        obarr.put("cantidades_tipo", jarray_det); 
         
        controles .DesconnectarBD();
         out.print(obarr); 
        %> 