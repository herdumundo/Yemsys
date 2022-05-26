<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>

 <%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
  <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>



<%     
    String area       = (String) sesionOk .getAttribute("clasificadora");
    String fecha     = request.getParameter("fecha_puesta");

    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String grilla_html="";
    String cabecera=" <table id='tb_liberados_recogidas' class='table table-striped table-bordered table-hover' style='width:100%'>"
            + "<thead>"
           
            + " <th  style='color: #fff; background: black;' >Fecha de puesta</th>      "
            + " <th style='color: #fff; background: black;' >Cantidad</th> </tr>"
            + " </thead> "
            + " <tbody >";
     ResultSet rs;
     rs = fuente.obtenerDato("select  convert(varchar,fecha_puesta,103)as fp,* from mae_ptc_pendientes_recogidas "
             + "where  YEAR(fecha_puesta)=  YEAR('"+fecha+"-01')and month(fecha_puesta)= month('"+fecha+"-01') "
             + "and clasificadora='"+area+"' and estado='2' order by fecha_puesta ");
       while(rs.next())
        {
            
              
           grilla_html=grilla_html+
           "<tr   >"
                   + "<td   >"+rs.getString("fp")+"</td>"
                   + "<td  > "+ String.format("%,d", rs.getInt("cantidad"))+" </td>"                                                                                  
            + " </tr>";
         }
       
        clases.controles.DesconnectarBD();
        ob.put("grilla",cabecera+grilla_html+"</tbody></table>");
        out.print(ob);  %>
        
         