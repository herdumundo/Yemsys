<%-- 
    Document   : consulta_datos_contadores_huevos
    Created on : 12/02/2022, 08:22:01
    Author     : csanchez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
       clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

        String mes= request.getParameter("mescon") ;
        String ano= request.getParameter("anocon") ;
        String aviario= request.getParameter("avicon") ;
        String grilla_html="";
        String fecha="";
        String edad="";
        String henday="";
        String padron="";
        String color3 = "";
        String diferencia="";
        String notas="";
            String datatable = "<script>"
            + "$(document).ready( function () {"
            + "$('#datoscon').DataTable({"
            +"'order': [[ 6, 'desc' ]],"
            + "'aLengthMenu': [[-1], ['All']],"
            + "'bPaginate': false,"
            + "'bInfo': false,"
            +"language: {"
            +"'search': 'Buscar:'"
            +"}"
            + "});"
            + "});"
            + "</script>";
        String cabecera = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>REGISTROS DE CONTADORES DE HUEVOS AVIARIO " + aviario + " </h5>"
            + "</div>"
            + " <table id='datoscon' class='tablagrilla table table-bordered compact ocultar'style='width:auto' >"
            + "<thead>"
            + " <tr>"
            + " <th width='80' class=' tablagrilla bg-navy card-header'>Fecha</th>"
            + "<th width='120' class=' tablagrilla bg-navy card-header'>Edad(sems)</th>"
            + "<th width='120' class='tablagrilla bg-navy card-header'>Henday</th>"
            + "<th width='120' class='tablagrilla bg-navy card-header'>Padrón</th>"
            + "<th width='120' class='tablagrilla bg-navy card-header'>Diferencia</th>"
            + "<th style='width:1000px' class='tablagrilla bg-navy card-header'>Notas</th>"
            + "</tr>"
            + "</thead>"
            + "</center>"
            + "<tbody >";
        try {
     JSONObject objet = new JSONObject();
    objet = new JSONObject();
    //PreparedStatement pt=con.prepareStatement("select case  when  fila % 2 =0 then 'green' else 'red' end as color, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
     //PreparedStatement pt=con.prepareStatement("select idusuario,nombreusuario from tab_mae_ppr_log");
    //PreparedStatement pt=con.prepareStatement("select '#ff0000' as min1, '#e10000' as min2,'#e10000' as min3, '#007d3c' as prom, '#007d50' as prom1 , '#007d97' as prom2, '#007dff' as prom3, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("exec stp_mae_ppr_datos_contador_huevos  @mes='"+mes+"',@ano='"+ano+"',@aviario='"+aviario+"'");
    ResultSet rs=pt.executeQuery();
    ArrayList Fila = new ArrayList();

            while(rs.next()) {
                
                grilla_html = grilla_html + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                    + " " + rs.getString("fecha") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("edad") + "  </td><td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("henday") +'%'+"  </td><td class='tablagrilla cero' style= 'text-align:center;color:'>  " + rs.getString("padron") +'%'+ "  </td><td class='tablagrilla cero si " + rs.getString("fcolor") + "' style= 'text-align:center';>  " + rs.getString("diferencia") +'%'+ " </td><td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("notas") + "  </td></tr>";
                        fecha=rs.getString("fecha");
                        edad=rs.getString("edad");
                        henday=rs.getString("henday");
                        padron=rs.getString("padron");
                        diferencia=rs.getString("diferencia");
                        color3 = rs.getString("fcolor");
                        notas = rs.getString("notas");
        }
        clases.controles.DesconnectarBDsession();             
        objet.put("grilladato", cabecera + grilla_html + "</tbody></body></div>" + datatable);
        objet.put("fecha", fecha);
        objet.put("edad", edad);
        objet.put("henday", henday);
        objet.put("padron", padron);
        objet.put("diferencia", diferencia);
        objet.put("colorc", color3);

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>