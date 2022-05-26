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
    
     String  grilla_html_h="";
    String  grilla_html_b="";
    String grilla_html = "";
    String cabecera = "  "
           + "  <div class='col-12'>"
           + "<div class='card'>"
           + " <div > <button class='informe bg-navy' disabled='true'  >BLOQUE Mecanizados A</button>  </div>"
           + "   <center> "
           + "  <div   class='card-body  '>"
           + "<table id='datosmorlote' class='table-bordered compact'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
           + "<th rowspan='2' width='70'>Aviario</th>"
                + "<th rowspan='2' width='120'>Lote</th>"
                + " <th rowspan='2' width='80'>Edad<br>prom.</th>"
                + " <th rowspan='2' width='120'>Saldo aves Acum.</th>"
                + " <th colspan='5'>Consumo de Balanceado</th>"
                + " <th rowspan='2'></th>"
            + " </tr>"
            + " <tr>"
                + "<th width='100'>Kg Total</th>"
                + "<th width='100'>gr/ave</th>"
                + "<th width='100'>gr/ave Pad.</th>"
                + "<th width='100'>Diferencia</th>"
                + "<th width='100'>% Difer.</th>"
            + " </tr>"
            + "  </thead>"
            + " <tbody  >" ;   
     String cabecera_b = "  "
        
           + "  <div class='col-12'>"
           + "<div class='card'>"
           + " <div > <button class='informe bg-navy' disabled='true'  >BLOQUE Mecanizados B</button>  </div>"
           + "   <center> "
           + "  <div   class='card-body  '>"
           + "<table id='datosmorlote' class='table-bordered compact'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
           + "<th rowspan='2' width='70'>Aviario</th>"
                + "<th rowspan='2' width='120'>Lote</th>"
                + " <th rowspan='2' width='80'>Edad<br>prom.</th>"
                + " <th rowspan='2' width='120'>Saldo aves Acum.</th>"
                + " <th colspan='5'>Consumo de Balanceado</th>"
                + " <th rowspan='2'></th>"
            + " </tr>"
            + " <tr>"
                + "<th width='100'>Kg Total</th>"
                + "<th width='100'>gr/ave</th>"
                + "<th width='100'>gr/ave Pad.</th>"
                + "<th width='100'>Diferencia</th>"
                + "<th width='100'>% Difer.</th>"
            + " </tr>"
            + "  </thead>"
            + " <tbody  >" ; 
        String cabecera_h = "  "
        
           + "  <div class='col-12'>"
           + "<div class='card'>"
           + " <div > <button class='informe bg-navy' disabled='true'  >BLOQUE Mecanizados H</button>  </div>"
           + "   <center> "
           + "  <div   class='card-body  '>"
           + "<table id='datosmorlote' class='table-bordered compact'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
           + "<th rowspan='2' width='70'>Aviario</th>"
                + "<th rowspan='2' width='120'>Lote</th>"
                + " <th rowspan='2' width='80'>Edad<br>prom.</th>"
                + " <th rowspan='2' width='120'>Saldo aves Acum.</th>"
                + " <th colspan='5'>Consumo de Balanceado</th>"
                + " <th rowspan='2'></th>"
            + " </tr>"
            + " <tr>"
                + "<th width='100'>Kg Total</th>"
                + "<th width='100'>gr/ave</th>"
                + "<th width='100'>gr/ave Pad.</th>"
                + "<th width='100'>Diferencia</th>"
                + "<th width='100'>% Difer.</th>"
            + " </tr>"
            + "  </thead>"
            + " <tbody  >" ; 
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    try {
         JSONObject objet = new JSONObject();
        objet = new JSONObject();
        PreparedStatement pt = clases.controles.connectSesion.prepareStatement("exec stp_mae_ppr_select_balanceados_bloque @ano='"+ano_mort+"',@mes='"+mes_mort+"'");
        ResultSet rs2 = pt.executeQuery();
        
        while (rs2.next()) {
             if(rs2.getString("aviario").startsWith("A")){
                grilla_html = grilla_html + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"
                    + rs2.getString("aviario") + "       </td> <td align='center' style= 'dislay: none; ';>  "
                    + rs2.getString("lote_nombre") + "    </td><td align='center'  style= 'dislay: none; ';> " 
                    + rs2.getString("edad_semanas") +" </td><td align='center'  style= 'dislay: none; ';>  "
                    + rs2.getString("aves_acumulado") + "  </td><td align='center'  style= 'dislay: none;';>  " 
                    + rs2.getString("balanceado") + "   </td><td align='center'  style= 'dislay: none; background-color:"+rs2.getString("color_gramo")  +"' ;>  " 
                    + rs2.getString("gramo_ave") +  "    </td><td align='center'  style= 'dislay: none;  ';>  " 
                    + rs2.getString("balan_pad") + "     </td><td align='center'  style= 'dislay: none; background-color:"+rs2.getString("color_diferencia")  +" ';>  "
                    + rs2.getString("diferencia") + "     </td><td align='center'  style= 'dislay: none;background-color:"+rs2.getString("color_porcentaje")  +"';>  "
                    + rs2.getString("diferencia_porcen") + '%'+"</td></tr>";
                
      
                 }    
                if(rs2.getString("aviario").startsWith("B")){
                grilla_html_b = grilla_html_b + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"
                    + rs2.getString("aviario") + "       </td> <td align='center' style= 'dislay: none; ';>  "
                    + rs2.getString("lote_nombre") + "    </td><td align='center'  style= 'dislay: none; ';> " 
                    + rs2.getString("edad_semanas") +" </td><td align='center'  style= 'dislay: none; ';>  "
                    + rs2.getString("aves_acumulado") + "  </td><td align='center'  style= 'dislay: none;';>  " 
                    + rs2.getString("balanceado") + "   </td><td align='center'  style= 'dislay: none; background-color:"+rs2.getString("color_gramo")  +"' ;>  " 
                    + rs2.getString("gramo_ave") +  "    </td><td align='center'  style= 'dislay: none;  ';>  " 
                    + rs2.getString("balan_pad") + "     </td><td align='center'  style= 'dislay: none; background-color:"+rs2.getString("color_diferencia")  +" ';>  "
                    + rs2.getString("diferencia") + "     </td><td align='center'  style= 'dislay: none;background-color:"+rs2.getString("color_porcentaje")  +"';>  "
                    + rs2.getString("diferencia_porcen") + '%'+"</td></tr>";
                
      
                 }
                if(rs2.getString("aviario").startsWith("H")){
                grilla_html_h = grilla_html_h + "<tr class='tablagrilla'><td align='center'style= 'dislay: none; ';>"
                    + rs2.getString("aviario") + "       </td> <td align='center' style= 'dislay: none; ';>  "
                    + rs2.getString("lote_nombre") + "    </td><td align='center'  style= 'dislay: none; ';> " 
                    + rs2.getString("edad_semanas") +" </td><td align='center'  style= 'dislay: none; ';>  "
                    + rs2.getString("aves_acumulado") + "  </td><td align='center'  style= 'dislay: none;';>  " 
                    + rs2.getString("balanceado") + "   </td><td align='center'  style= 'dislay: none; background-color:"+rs2.getString("color_gramo")  +"' ;>  " 
                    + rs2.getString("gramo_ave") +  "    </td><td align='center'  style= 'dislay: none;  ';>  " 
                    + rs2.getString("balan_pad") + "     </td><td align='center'  style= 'dislay: none; background-color:"+rs2.getString("color_diferencia")  +" ';>  "
                    + rs2.getString("diferencia") + "     </td><td align='center'  style= 'dislay: none;background-color:"+rs2.getString("color_porcentaje")  +"';>  "
                    + rs2.getString("diferencia_porcen") + '%'+"</td></tr>";
                
      
                 }
              
               
            lote_id = rs2.getString("aviario");
            lote_name = rs2.getString("balanceado");
            saldo_aves = rs2.getString("aves_acumulado");
            lote_fnac = rs2.getString("edad_semanas");
            fecha_80_sems = rs2.getString("lote_nombre");
            merma = rs2.getString("balan_pad");
            edad_actual = rs2.getString("gramo_ave");
         

        }
        
        objet.put("grilla_a", miles+cabecera + grilla_html + "</tbody>  </table>  </div></center></div>  </div>" );
        objet.put("grilla_b", miles+cabecera_b + grilla_html_b + "</tbody>  </table> </div></center></div>  </div>" );
        objet.put("grilla_h", miles+cabecera_h + grilla_html_h + "</tbody>  </table> </div></center></div>  </div>" );
        objet.put("aviario", lote_id);
        objet.put("balanceado", lote_name);
        objet.put("aves_acumulado", saldo_aves);
        objet.put("edad_semanas", lote_fnac);
        objet.put("lote_nombre", fecha_80_sems);
        objet.put("balan_pad", merma);
        objet.put("gramo_ave", edad_actual);
        objet.put("grilla", grilla_html);
        objet.put("grillacabecera", cabecera);
   

        out.print(objet);
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
