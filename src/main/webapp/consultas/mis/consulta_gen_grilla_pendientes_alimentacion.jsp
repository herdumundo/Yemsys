<%-- 
    Document   : informe_factura
    Created on : 05/03/2020, 11:04:47 AM
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
 <%@page contentType="application/json; charset=utf-8" %>
 
		
<%      
    JSONObject ob = new JSONObject();
    JSONObject ob2 = new JSONObject();
    String tab_cabecera="<div class='container'> Total: <span id='total'></span><table id='example' class='table' ><thead><td>Fecha puesta</td><td>Codigo</td><td>Cantidad</td><td>Origen</td><td>Tipo huevo</td><td>Motivo</td></thead><tbody>";
    String tab_final="</tbody></table>";
    String tab_filas="";
    JSONArray jarray = new JSONArray();         
    JSONArray jarray2 = new JSONArray();         

    try {

            controles.connectarBD();
                     
            Statement stmt = clases.controles.connect.createStatement();
             ob = new JSONObject();
            ResultSet rs = stmt.executeQuery(" select convert(date,fecha_puesta) as fecha_puesta, cod_carrito,cantidad,origen,tipo_huevo,desFallaZona  "
                    + "from  v_mae_ptc_pendientes_alimentacion  order by  fecha_puesta asc");

            while (rs.next()) 
            {
                jarray = new JSONArray();    
                jarray.put(rs.getString("fecha_puesta"));  
                jarray.put(rs.getString("cod_carrito"));  
                jarray.put(rs.getString("cantidad"));  
                jarray.put(rs.getString("origen"));  
                jarray.put(rs.getString("tipo_huevo"));  
                jarray.put(rs.getString("desFallaZona"));  
                jarray2.put(jarray);  
            }
            
            ob2.put("data",jarray);
            rs.close();
            ob2.put("data",jarray2);
        } catch (Exception e) {
            String error=e.getMessage();
        }
    finally {
            clases.controles.DesconnectarBD();
            out.print(ob2);
       }
       
%>

