<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    
    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
     try 
     {
        String fecha = request.getParameter("fecha");

        ResultSet rs;
        Statement st = connection.createStatement(); 
        rs = st.executeQuery("SELECT idtransferencia, CONVERT(VARCHAR(10), fecha_contabilizacion, 103)"
                + " AS fecha_formateada, origen, destino, CardCode,    CardName,    Address,    "
                + "ItemCode,    ItemName,    loteLargo,    loteCorto,    BarCode,    Quantity"
                + ",    observacion,    observacion_detalle FROM"
                + "   vim_transferencia_produccion with(nolock)WHERE CONVERT(VARCHAR(10), "
                + "fecha_contabilizacion, 103) = '"+fecha+"'and estado='C'");        
         

        cabecera = " <table id='tb_informe_transfer' class='table' style='width:100%'>"
                + "<thead>"
                + "<tr>"
                 + "   <th>Id. transf</th>"
                   + " <th>Fecha</th>"
                   + " <th>Origen</th>"
                   + " <th>Destino</th>"
                   + " <th>Card Code</th>"
                   + " <th>Card Name</th>"
                   + " <th>Dirección</th>"
                   + " <th>Item Code</th>"
                   + " <th>Item Name</th>"
                   + " <th>Lote Largo</th>"
                   + " <th>Lote Corto</th>"
                   + " <th>Cod. barra </th>"
                   + " <th>Cantidad</th>"
                   + " <th>Observación</th>"
                   + " <th>Det. Obs.</th>"
                + "</tr>"
             
                + " </thead> "
                + " <tbody >";
        while (rs.next()) 
        {
            grilla_html = grilla_html
                    + "<tr >"
                    +"<td>"+rs.getString("idtransferencia")+"</td>" 
                    +"<td>"+rs.getString("fecha_formateada")+"</td>" 
                    +"<td>"+rs.getString("origen")+"</td>" 
                    +"<td>"+rs.getString("destino")+"</td>"
                    +"<td>"+rs.getString("CardCode")+"</td>" 
                    +"<td>"+rs.getString("CardName")+"</td>" 
                    +"<td>"+rs.getString("ItemCode")+"</td>" 
                    +"<td>"+rs.getString("ItemName")+"</td>"
                    +"<td>"+rs.getString("ItemName")+"</td>"
                    +"<td>"+rs.getString("loteLargo")+"</td>"
                    +"<td>"+rs.getString("loteCorto")+"</td>"
                    +"<td>"+rs.getString("BarCode")+"</td>"
                    +"<td>"+rs.getString("Quantity")+"</td>"
                    +"<td>"+rs.getString("observacion")+"</td>"
                    +"<td>"+rs.getString("observacion_detalle")+"</td>"
                    + "</tr>";
            
        } 
         
         ob.put("grilla",cabecera + grilla_html + "</tbody></table>"    );
         
        rs.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());  
    } finally {
        connection.close();
        out.print(ob ); 
    }
%>


 