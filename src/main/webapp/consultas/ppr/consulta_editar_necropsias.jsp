<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : csanchez
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="clases.controles"%>

<%      String fecha = request.getParameter("fecha");
    String id_necrop_score = request.getParameter("necrop_id");

    DecimalFormat df = new DecimalFormat("0.00");
    DecimalFormat formatea = new DecimalFormat("###,###.##");

    String lote_id = "";
    String edad_sem = "";
    String miles = "";
    String grilla_html = "";
    String cabecera = "  "
            + "<thead class='informe bg-navy'>"
            + " <tr >"
            + "<th  class='text-center'>Ave nro.</th>"
            + "<th  class='text-center'>P.H.M.</th>"
            + "<th  class='text-center'>Enter.</th>"
            + "<th  class='text-center'>Molleja</th>"
            + "<th  class='text-center'>Hígado</th>"
            + "<th  class='text-center'></th>"
            + " </tr>"
            + "  </thead>"
            + " <tbody  >";

    try {
        controles.connectarBD();
        JSONObject objet = new JSONObject();
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connect.prepareStatement(" select  pnecsco_nec,pnecsco_ave,pnecsco_score,pnecsco_itm,pnecsco_id "
                + " from ppr_necropsias_score where pnecsco_nec='" + id_necrop_score + "' order by pnecsco_ave asc,pnecsco_itm asc ");
        ResultSet rs2 = pt.executeQuery();

        PreparedStatement pt2 = clases.controles.connect.prepareStatement(" SELECT DISTINCT b.pnec_lote  idlote, b.pnec_fecha fecha,c.lote_name lote, "
                + "c.lote_aviario aviario,e.dl_edadsems "
                + "FROM ppr_necropsias_files a inner join ppr_necropsias b on a.pnecfile_nec=b.pnec_id "
                + "inner join ppr_lotes c on c.lote_id=b.pnec_lote  "
                + " inner join ppr_necropsias_score d on d.pnecsco_nec=a.pnecfile_nec "
                + "inner join ppr_datolotes e on e.dl_lote=b.pnec_lote "
                + "where b.pnec_fecha = '" + fecha + "'  and d.pnecsco_nec='" + id_necrop_score + "' and e.dl_fecha='" + fecha + "'");
        ResultSet rs3 = pt2.executeQuery();

        while (rs3.next()) {
            edad_sem = rs3.getString("dl_edadsems");
        }

        while (rs2.next()) {    //phm enteritis molleja higado

            if (rs2.getString("pnecsco_itm").startsWith("1")) {
                grilla_html = grilla_html
                        + "<tr  class='tablagrilla'><td  align='center'style= 'dislay: none;'  pnec-items=" + rs2.getString("pnecsco_ave") + " ;>" + rs2.getString("pnecsco_ave") + "</td>"
                        + "<td  contenteditable='true'   id-score=" + rs2.getString("pnecsco_id") + " style='background-color: #ffddb8' align='center' style= 'dislay: none;' value-data=" + rs2.getString("pnecsco_score") + " >  "
                        + rs2.getString("pnecsco_score") + "</td>";

            }
            if (rs2.getString("pnecsco_itm").startsWith("2")) {
                grilla_html = grilla_html
                        + "<td  contenteditable='true' id-score=" + rs2.getString("pnecsco_id") + " style='background-color: #ffddb8' align='center' style= 'dislay: none;' value-data=" + rs2.getString("pnecsco_score") + ">  "
                        + rs2.getString("pnecsco_score") + "   </td>";

            }
            if (rs2.getString("pnecsco_itm").startsWith("3")) {
                grilla_html = grilla_html
                        + "<td   contenteditable='true' id-score=" + rs2.getString("pnecsco_id") + " style='background-color: #ffddb8' align='center' style= 'dislay: none;' value-data=" + rs2.getString("pnecsco_score") + ">  "
                        + rs2.getString("pnecsco_score") + "   </td>";

            }
            if (rs2.getString("pnecsco_itm").startsWith("4")) {
                grilla_html = grilla_html
                        + "<td   contenteditable='true' id-score=" + rs2.getString("pnecsco_id") + " style='background-color: #ffddb8' align='center' style= 'dislay: none;' value-data=" + rs2.getString("pnecsco_score") + ">  "
                        + rs2.getString("pnecsco_score") + "   </td>"
                        + "<td><button class='bg-navy' onclick='consulta_necropsias_imagen_ppr(" + id_necrop_score + "," + rs2.getString("pnecsco_ave") + ");'>ver archivos</button></td> "
                        + "</tr>";
            }

            lote_id = rs2.getString("pnecsco_score");

        }
        objet.put("grilla_a", miles + cabecera + grilla_html
                + "</tbody> "
                + "<tfoot>"
                + "<td colspan='6' style='padding-top:10px;'>"
                + "<button  id='btn_agre_ave' name='btn_agre_ave' class=' bg-navy' onclick='ppr_necropsias_form_nuevafila()'>agregar ave</button>"
                + "<input type='hidden' value=" + id_necrop_score + " id='necrop-id'>"
                + "<input type='hidden' value='1'  id='1lastsco'>"
                + "<input type='date' hidden value=" + fecha + "  id='fecha_necro'>"
                + "</td>"
                + "</tfoot>"
        );
        clases.controles.DesconnectarBD();
        objet.put("fecha", lote_id);
        objet.put("edad", edad_sem);

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
