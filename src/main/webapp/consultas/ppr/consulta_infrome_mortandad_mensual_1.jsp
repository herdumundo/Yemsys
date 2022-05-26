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

 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /><%
    String mes_mort = request.getParameter("mes_mort");
    String ano_mort = request.getParameter("ano_mort");
    String day="01";

 DecimalFormat df = new DecimalFormat("0.00");
 DecimalFormat formatea = new DecimalFormat("###,###.##");
    double prome_golbal= 0;
    double suma_mortandad = 0;
    double suma_por_mort = 0;
    double suma_aves_prom= 0;
    double porce_mort= 0;
    double propor_muertes_porcen= 0;
    double propor_aves_saldo= 0;
    int    promedio_aves= 0;
    int    mortandad=0;
    String lote_id = "";
    String lote_name = "";
    String saldo_aves = "";
    String lote_fnac = "";
    String fecha_80_sems = "";
    String merma = "";
    String edad_actual = "";
    String mort_80_sems = "";
    String miles = "";
    
    String grilla_html_h="";
    String grilla_html_b="";
    String grilla_html = "";
    String cabecera = "  "
           + "  <div style='width: 100% 'class='col-12'>"
           + "<div class='card'>"
           + " <div > <button class='informe bg-navy' disabled='true'  >RESUMEN MORTANDAD DEL MES </button>  </div>"
           + "   <center> "
           + "  <div   class='card-body  '>"
           + "<table id='datosmorlote' class='table-bordered compact' style='width: 100% '>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
                + "<th  width='200'>Bloque</th>"
                + "<th  width='200'>Muertos(*1)</th>"
                + "<th  width='200'>% Mortandad(*2)</th>"
                + "<th  width='200'>Prop.muertos(*3)</th>"
                + "<th  width='200'>Saldo aves promedio(*4)</th>"
                + "<th  width='200'>Prop. Aves Saldo(*5)</th>"
           + " </tr>"
           + "  </thead>"
           + " <tbody  >" ;   
   
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    try {
         JSONObject objet = new JSONObject();                            
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_mortandad_mensual] @ano='"+ano_mort+"',@mes='"+mes_mort+"'");
        ResultSet rs2 = pt.executeQuery();
        
        while (rs2.next()) {
            porce_mort=rs2.getDouble("porcentaje_mor");
            propor_muertes_porcen=rs2.getDouble("propor_muertes_porcen");
            propor_aves_saldo=rs2.getDouble("propor_aves_saldo");
            mortandad=rs2.getInt("mortandad");
            promedio_aves=rs2.getInt("promedio_aves") ;
            
             grilla_html = grilla_html + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>Bloque "
            +"'"+ rs2.getString("bloque") +"'"+"       </td> <td align='center' style= 'dislay: none; ';>  "
            + (formatea.format(mortandad))+ "    </td><td align='center'  style= 'dislay: none; ';> "
            + (df.format(porce_mort)) +" %</td><td align='center'  style= 'dislay: none; ';>  "
            + (df.format(propor_muertes_porcen))  +" %</td><td align='center'  style= 'dislay: none; ';>  "
            + (formatea.format(promedio_aves))+ "    </td><td align='center'  style= 'dislay: none; ';> " 
            + (df.format(propor_aves_saldo)) + "   % </td><td align='center'  style= 'dislay: none; ';> " 
            + "</tr>";
             
             suma_mortandad= suma_mortandad+rs2.getInt("mortandad");
             suma_aves_prom= suma_aves_prom+rs2.getInt("promedio_aves");
             suma_por_mort= suma_por_mort+rs2.getInt("porcentaje_mor");
             prome_golbal=(suma_mortandad/suma_aves_prom)*100;
        
            lote_id = rs2.getString("bloque");
            lote_name = rs2.getString("mortandad");
            saldo_aves = rs2.getString("porcentaje_mor");
            lote_fnac = rs2.getString("propor_muertes_porcen");
            fecha_80_sems = rs2.getString("promedio_aves");
            merma = rs2.getString("propor_aves_saldo");

        }
        
              
        objet.put("grilla_a", miles+cabecera + grilla_html 
         + "<tr>"
         +"<td align='center' HEIGHT='40'  style= 'dislay: none; ';></td>"
         +"<td align='center'  style= 'dislay: none; ';><b>"+(formatea.format(suma_mortandad))+"</td>"
         +"<td align='center'  style= 'dislay: none; ';><b>"+(df.format(prome_golbal))+" %</td>"
         +"<td align='center'  style= 'dislay: none; ';> </td>"
         +"<td align='center'  style= 'dislay: none; ';><b>"+(formatea.format(suma_aves_prom))+"</td>"
         +"<td align='center'  style= 'dislay: none; ';> </td>"
         + "</tr>"
         + "</tbody>  </table>  </div></center></div>  </div>" );

        objet.put("bloque", lote_id);
        objet.put("mortandad", lote_name);
        objet.put("porcentaje_mor", saldo_aves);
        objet.put("propor_muertes_porcen", lote_fnac);
        objet.put("promedio_aves", fecha_80_sems);
        objet.put("propor_aves_saldo", merma);
        
   

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
