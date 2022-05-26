<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : csanchez
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>

<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /><%
    String mes_mort = request.getParameter("mes_mort");
    String ano_mort = request.getParameter("ano_mort");
    String day="01";


 
 
    String lote_id = "";
    String lote_name = "";
    String saldo_aves = "";
    String lote_fnac = "";
    String fecha_80_sems = "";
    String merma = "";
    String edad_actual = "";
    String mort_80_sems = "";
    String miles = "";

    
    String grilla_html = "";
    String cabecera = "  "
            
            + " <table id='datosmorlote' class='tablagrilla table table-bordered compact ocultar'>"
            + "<thead >"
            + " <tr >"
            + "<th class='text-center bg-navy card-header' width='70'>ID </th>"
            + "<th class='text-center bg-navy card-header' width='150'>Lote</th>"
            + "<th class='text-center bg-navy card-header' width='150'>Fecha nac.</th>"
            + "<th class='text-center bg-navy card-header' width='150'>Saldo inic.</th>"
            + "<th class='text-center bg-navy card-header  width='150''>Fecha 80 sem.</th>"
            + "<th class='text-center bg-navy card-header  width='150''>Edad actual</th>"
            + "<th class='text-center bg-navy card-header  width='150''>Merma 80 sem.</th>"
            + "<th class='text-center bg-navy card-header  width='150''>Mort.% 80sem.</th>"
            + "</tr>"
            + "</thead>"
            + "</center>"
            + "<tbody >";
     clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

    try {
         JSONObject objet = new JSONObject();
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connectSesion.prepareStatement("exec stp_mae_ppr_select_mortandad_80_sems  @ano='"+ano_mort+"',@mes='"+mes_mort+"',@day='"+day+"'");
        ResultSet rs2 = pt.executeQuery();
        while (rs2.next()) {
            miles = miles+ "<script>"
            +"const decimal = numeral($(.'si')).format('0,0');"
            +"</script>";

            grilla_html = grilla_html + "<tr class='tablagrilla'><td class='tablagrilla cero' style= 'text-align:center; color:" + rs2.getString("color") + "';>"
                    + rs2.getString("lote_id") + " </td> <td class='tablagrilla cero '    style= 'text-align:center; color:" + rs2.getString("color") + "';>  "
                    + rs2.getString("lote_name") +'(' +rs2.getString("lote_aviario") +')' + "  </td><td class='tablagrilla cero'   style= 'text-align:center; color:" + rs2.getString("color") + "';> " 
                    + rs2.getString("lote_fnac") + "  </td><td class='tablagrilla cero '  style= 'text-align:center; color:" + rs2.getString("color") + "';>  "
                    + rs2.getString("saldo_aves") + "  </td><td class='tablagrilla cero'  style= 'text-align:center; color:" + rs2.getString("color") + "';>  " 
                    + rs2.getString("fecha_80_sems") + " </td><td class='tablagrilla cero'style= 'text-align:center; color:" + rs2.getString("color") + "' ;>  " 
                    + rs2.getString("edad_actual") +  "  </td><td class='tablagrilla cero' style= 'text-align:center; color:" + rs2.getString("color") + "';>  " 
                    + rs2.getString("merma") + "  </td><td class='tablagrilla cero'       style= 'text-align:center; color:" + rs2.getString("color") + "';>  "
                    + rs2.getString("mort_80_sems") + '%' + "  </td></tr>";
                                                                                                                                                                                                   
            lote_id = rs2.getString("lote_id");
            lote_name = rs2.getString("lote_name");
            saldo_aves = rs2.getString("saldo_aves");
            lote_fnac = rs2.getString("lote_fnac");
            fecha_80_sems = rs2.getString("fecha_80_sems");
            merma = rs2.getString("merma");
            edad_actual = rs2.getString("edad_actual");
         

        }
        clases.controles.DesconnectarBDsession();             
        objet.put("grilla_80_sems", miles+cabecera + grilla_html + "</tbody></body>" );
        objet.put("lote_id", lote_id);
        objet.put("lote_name", lote_name);
        objet.put("saldo_aves", saldo_aves);
        objet.put("lote_fnac", lote_fnac);
        objet.put("fecha_80_sems", fecha_80_sems);
        objet.put("merma", merma);
        objet.put("edad_actual", edad_actual);
        objet.put("grilla", grilla_html);
        objet.put("grillacabecera", cabecera);
   

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
