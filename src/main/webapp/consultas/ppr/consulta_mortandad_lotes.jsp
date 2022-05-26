<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : csanchez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /><%
    String meslote = request.getParameter("meslote");
    String anolote = request.getParameter("anolote");
    String id = "";
    String lote = "";
    String edad_dias = "";
    String edad_mes = "";
    String saldo_inicial = "";
    String muertos = "";
    String porcentaje = "";
    String color = "";
    String fcolor = "";
    String miles = "";
    String datatable = "<script>"
            + "$(document).ready( function () {"
            + "$('#datosmorlote').DataTable({"
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
    String grilla_html = "";
    String cabecera = "  "
            + "    <div style='width: 100% !important class='text-center'>"
            + "<div class='h_dtext-center' style='width: 100% !important;'>"
            + "</div>"
            + " <table id='datosmorlote' class='tablagrilla table table-bordered compact ocultar' style='width:auto'>"
            + "<thead>"
            + " <tr>"
            + " <th class=' tablagrilla bg-navy card-header'>ID Lote</th>"
            + "<th class=' tablagrilla bg-navy card-header'>Lote</th>"
            + "<th class='tablagrilla bg-navy card-header'>Edad prom./dias</th>"
            + "<th class='tablagrilla bg-navy card-header'>Edad prom./mes</th>"
            + "<th class='tablagrilla bg-navy card-header'>Saldo inicial</th>"
            + "<th class='tablagrilla bg-navy card-header'>Muertos</th>"
            + "<th class='tablagrilla bg-navy card-header'>% Mort.</th>"
            + "</tr>"
            + "</thead>"
            + "</center>"
            + "<tbody >";
   clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    try {


        JSONObject objet = new JSONObject();
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connectSesion.prepareStatement("exec stp_mae_ppr_select_mortandad_lote @mes='" + meslote + "',@ano='" + anolote + "'");
        ResultSet rs2 = pt.executeQuery();
        while (rs2.next()) {
            miles = miles+ "<script>"
            +"$('#idtd').val() = numeral($('" + saldo_inicial + "')).format('0,0');"
            +"</script>";

            grilla_html = grilla_html + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                    + " " + rs2.getString("IDLote") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs2.getString("Lote") + "  </td><td class='tablagrilla cero " + rs2.getString("color") + " tdc' style= 'text-align:center;color:" + rs2.getString("fcolor") + "' ;> " + rs2.getString("Edadpromdias") + "  </td><td class='tablagrilla " + rs2.getString("color") + " cero' style= 'text-align:center;color:" + rs2.getString("fcolor") + "'>  " + rs2.getString("Edadpromsem") + "  </td><td onchange='format(this)' id='idtd' class='tablagrilla cero si' style= 'text-align:center';>  " + rs2.getString("Saldoinicial") + " </td><td class='tablagrilla cero' style= 'text-align:center';>  " + rs2.getString("Muertos") + "  </td><td class='tablagrilla cero' style= 'text-align:center';>  " + rs2.getString("mort") + '%' + "  </td></tr>";

            id = rs2.getString("IDLote");
            lote = rs2.getString("Lote");
            edad_dias = rs2.getString("Edadpromdias");
            edad_mes = rs2.getString("Edadpromsem");
            saldo_inicial = rs2.getString("Saldoinicial");
            muertos = rs2.getString("Muertos");
            porcentaje = rs2.getString("mort");
            color = rs2.getString("color");
            fcolor = rs2.getString("fcolor");

        }
        clases.controles.DesconnectarBDsession();             
        objet.put("grillalote", miles+cabecera + grilla_html + "</tbody></body></div>" + datatable);
        objet.put("id", id);
        objet.put("lote", lote);
        objet.put("edad_dias", edad_dias);
        objet.put("edad_mes", edad_mes);
        objet.put("saldo_inicial", saldo_inicial);
        objet.put("muertos", muertos);
        objet.put("porcentaje", porcentaje);
        objet.put("grilla", grilla_html);
        objet.put("grillacabecera", cabecera);
        objet.put("color2", color);
        objet.put("fcolor", fcolor);

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
