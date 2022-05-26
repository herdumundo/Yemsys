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
           
            + " <th  style='color: #fff; background: black;' >CARRO</th>      "
            + " <th style='color: #fff; background: black;' >INICIO</th>  "
            + " <th style='color: #fff; background: black;' >FIN</th>  "
            + " <th style='color: #fff; background: black;' >CANTIDAD</th> "
            + " <th style='color: #fff; background: black;' >PUESTA</th> "
            + " <th style='color: #fff; background: black;' > <input type='checkbox' id='box_reproceso'> </th> "
             + "</tr>"
            + " </thead> "
            + " <tbody >";
     ResultSet rs;
     rs = fuente.obtenerDato("select  cod_interno,cod_carrito,SUBSTRING( convert(varchar, hora_inicio,108),1,5) as inicio, "
             + "SUBSTRING( convert(varchar, hora_fin,108),1,5) as fin,cantidad,convert(varchar,fecha_puesta,103) as fecha_puesta, fecha_puesta as fp "
             + "from "
             + "    lotes "
             + "    where   "
             + "    tipo_huevo='SC' and clasificadora_actual='"+area+"' "
                     + "and cod_interno not in (select cod_interno from mae_ptc_alimentacion_sc) and estado not in ('E') order by fp desc ");
       while(rs.next())
        {
            
              
           grilla_html=grilla_html+
           "<tr  > "
                       

                   + "<td   >   " +rs.getString("cod_carrito")+"</td>"
                   + "<td   >"+rs.getString("inicio")+"</td>"
                   + "<td   >"+rs.getString("fin")+"</td>"
                   + "<td  > "+ String.format("%,d", rs.getInt("cantidad"))+" </td>" 
                                      + "<td   >"+rs.getString("fecha_puesta")+"</td>"

                   + "<td  > <input name='checks[]' class='checkbox' type='checkbox' value='"+rs.getString("cod_interno")+"'/></td>"                                                                                  
            + " </tr>";
         }
       
        clases.controles.DesconnectarBD();
        ob.put("grilla",cabecera+grilla_html+"</tbody></table>");
        out.print(ob);  %>
        
         