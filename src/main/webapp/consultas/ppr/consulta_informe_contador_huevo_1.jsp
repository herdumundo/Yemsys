<%-- 
    Document   : consulta_mortandad_lotes
    Created on : 03/02/2022, 13:22:50
    Author     : aespinola
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Locale"%>

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
    String fecha = request.getParameter("fecha");
    String aviario = request.getParameter("aviario");
    String lote = request.getParameter("lote");
    Date fecha_parameter=Date.valueOf(fecha);
   
DecimalFormat formatea = new DecimalFormat("###,###.##");
DecimalFormat formatea2 = new DecimalFormat("########");
     String cant="";
     String dl_edaddias="";
     String dl_edadsems ="";
     String pad_productividad="";
     String max_cant="";
     String min_cant="";
     String prome_huevo="";
     String productividad="";
     String dif_productividad="";
     String color="";
     
     String fila1="";
     String fila2="";
     String fila3="";
     String fila4="";
     String fila5="";
     String fila61="";
     
     String fila1_color="";
     String fila2_color="";
     String fila3_color="";
     String fila4_color="";
     String fila5_color="";
     String fila6_color="";
     
     String fila1_blink="";
     String fila2_blink="";
     String fila3_blink="";
     String fila4_blink="";
     String fila5_blink="";
     String fila6_blink="";
   
    String lote_id = "";
    int suma_columna1 = 0;
    int suma_columna2 = 0;
    int suma_columna3 = 0;
    int suma_columna4 = 0;
    int total_columna = 0;
    
    int total_piso1 = 0;
    int total_piso2 = 0;
    int total_piso3 = 0;
    int total_piso4 = 0;
    int total_piso5 = 0;
    int total_piso6 = 0;
    
    int fila_11= 0;
    int fila_12= 0;
    int fila_21= 0;
    int fila_22= 0;
    int fila_31= 0;
    int fila_32= 0;
    int fila_41= 0;
    int fila_42= 0;
    
    int promedio_periodo_huevo=0;
    int sum_periodo_huevo=0;
    String total_huevos_acum = "";
    String total_prome_acum = "";
    String periodo_fecha = "";
    String periodo_fecha_mas_1 = "";;
    
   int total_mortandad_acum = 0;
   int total_mortandad_acum_prome = 0;
   
   int total_mortandad_global = 0;
   int total_mortandad_prom_global= 0;
    
    
    int promedio_columna = 0;
    String saldo_aves = "";
    String lote_fnac = "";
    String fecha_80_sems = "";
    String merma = "";
    String edad_actual = "";
    String mort_80_sems = "";
    String miles = "";
     int total_piso=0;
     int total=0;
     int id_fila=0;
     int id_fila_total=0;
     int promedio_piso=0;
    String  grilla_html2="";
    String  grilla_html3="";
    String grilla_html = "";
    String    grilla_html_suma="";
    String grilla_html_periodo = "";
    String grilla_mortandad_periodo = "";
    String grilla_mortandad_global = "";
    
    String cabecera_mas = "  "
          + " <div class='col-12'>"
           + "<div class='card'>"
         
           + "   <center> "
           + "  <div   class='card-body'>"
           + "<table id='datosmorlote' class='table-bordered compact' border='1' cellspacing='0' cellpadding='0'>"
           +" <tbody  <tbody class='tablagrilla'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
               
                + "<th rowspan='2' width='50'>Total<br>Piso</th>"
                + "<th rowspan='2' width='100'></th>"
             
                + " </tr>"
                + "  </thead>"; 
    String cabecera = "  "
         
         
           + "   <center> "
           + "  <div   class='card-body'>"
           + "<table style='width:1030px' id='datosmorlote' class='table-bordered compact' border='1' cellspacing='0' cellpadding='0'>"
           +" <tbody  <tbody class='tablagrilla'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
                +"<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>1</th>"
                + "<th rowspan='2' width='70'>Columna<br>1</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>2</th>"
                + "<th rowspan='2' width='70'>Columna<br>2</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>3</th>"
                + "<th rowspan='2' width='70'>Columna<br>3</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>4</th>"
                + "<th rowspan='2' width='70'>Columna<br>4</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='60'>Total<br>Piso</th>"
                + "<th rowspan='2' width='100'></th>"
               
             
                + " </tr>"
                + "  </thead>";  
    
     String cabecera2 = "  "
          + " <div class='col-12'>"
           + "<div class='card'>"
         
           + "   <center> "
           + "  <div   class='card-body'>"
           + "<table id='datosmorlote' class='table-bordered compact' border='1' cellspacing='0' cellpadding='0'>"
           +" <tbody  <tbody class='tablagrilla'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
            
                + "<th rowspan='2' width='50'>Total<br>Piso</th>"
                + "<th rowspan='6' width='100'></th>"
             
              
                
           + " </tr>"
          
            + "  </thead>"; 
       String cabecera_periodo = "  "
          + " <div class='col-12'>"
           + "<div class='card'>"
         
           + "   <center> "
           + "  <div   class='card-body'>"
           + "<table style='width:1030px' id='datosmorlote' class='table-bordered compact'>"
           +" <tbody  <tbody class='tablagrilla'>"
           + "<thead class='informe bg-navy'>"
           + " <tr >"
                +"<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>1</th>"
                + "<th rowspan='2' width='70'>Columna<br>1</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>2</th>"
                + "<th rowspan='2' width='70'>Columna<br>2</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>3</th>"
                + "<th rowspan='2' width='70'>Columna<br>3</th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='40'></th>"
                + "<th rowspan='2' width='70'>Columna<br>4</th>"
                + "<th rowspan='2' width='70'>Columna<br>4</th>"
                + "<th width='40'></th>"
                
                + " </tr>"
                + "  </thead>";   
  
   
      
                  
    try {
        
        JSONObject objet  = new JSONObject();
        objet  = new JSONObject();
      clases.controles.VerificarConexion();
         PreparedStatement pt=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_huevos_diario]  @fecha='"+fecha+"',@aviario='"+aviario+"'");
        ResultSet rs2 = pt.executeQuery();
        PreparedStatement ptt=clases.controles.connectSesion.prepareStatement("exec stp_mae_ppr_select_huevos_acumulado_periodo @fecha='"+fecha+"',@aviario='"+aviario+"'");
        ResultSet rs3 = ptt.executeQuery();
        PreparedStatement pttt=clases.controles.connectSesion.prepareStatement("exec stp_mae_ppr_select_mortandad_acumulado_periodo @fecha='"+fecha+"',@aviario='"+aviario+"'");
        ResultSet rs4 = pttt.executeQuery();
        PreparedStatement ptttt=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_mortandad_global] @aviario='"+aviario+"',@lote='"+lote+"'");
        ResultSet rs5 = ptttt.executeQuery();
        
        PreparedStatement ptttTT=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_huevo_contador_balance_diario] @aviario ='"+aviario+"',@fecha='"+fecha+"'");
        ResultSet rs6 = ptttTT.executeQuery();
        
        PreparedStatement ptttTTt=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_huevos_diario_sum] @fecha='"+fecha+"', @aviario ='"+aviario+"'");
        ResultSet rs7 = ptttTTt.executeQuery();
        
        PreparedStatement pt8=clases.controles.connectSesion.prepareStatement("exec [stp_mae_ppr_select_huevos_periodo_sum] @fecha='"+fecha+"', @aviario ='"+aviario+"'");
        ResultSet rs8 = pt8.executeQuery();
     
               
        while (rs2.next()) {
            
             if(rs2.getString("fila").startsWith("11")){
                grilla_html = grilla_html 
                        
                    +"<tr class='tablagrilla'>"  
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + " align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + " align='center'  class='"+rs2.getString("parpadeo")+"'  style= 'dislay: none; "
                    + "color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>";
                       suma_columna1 =  suma_columna1+rs2.getInt("cant");
                     }    
                  if(rs2.getString("fila").startsWith("12")){
                   grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + " align='center' class='"+rs2.getString("parpadeo")+"' style= 'dislay:  none; "
                    + " color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                           + "align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>";
                    suma_columna1= suma_columna1+rs2.getInt("cant");
                    }  
                  if(rs2.getString("fila").startsWith("21")){
                    grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center' class='"+rs2.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>";
                    suma_columna2 =  suma_columna2+rs2.getInt("cant");
                    } 
                  if(rs2.getString("fila").startsWith("22")){
                    grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + " align='center' class='"+rs2.getString("parpadeo")+"' style= 'dislay: none;  "
                    + "color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + " align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>";
                    suma_columna2= suma_columna2+rs2.getInt("cant");
                    }
                   if(rs2.getString("fila").startsWith("31")){
                    grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + "align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + "align='center' class='"+rs2.getString("parpadeo")+"'  style= 'dislay: none; "
                    + "color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>";
                    suma_columna3 =  suma_columna3+rs2.getInt("cant");
                    }
                   if(rs2.getString("fila").startsWith("32")){
                    grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")'"
                    + " align='center' class='"+rs2.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>";
                    suma_columna3= suma_columna3+rs2.getInt("cant");
                    }
                   if(rs2.getString("fila").startsWith("41")){
                    grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center' class='"+rs2.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>";
                    suma_columna4 =  suma_columna4+rs2.getInt("cant");
                    }
                    if(rs2.getString("fila").startsWith("42")){
                    grilla_html = grilla_html 
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center' class='"+rs2.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs2.getString("color")+"';>"+ rs2.getString("cant") +"</td>"
                    + "<td onclick='grafico_fila_contador_huevo_fila_ppr("+ rs2.getString("fila")+")' "
                    + "align='center'style= 'dislay: none; ';>"+ rs2.getString("fila") + "</td>"
                    + "<td id='"+ id_fila+ "' align='center'style= 'dislay: none; color:white;';></td>";
                    // + "<td id='"+ id_fila_total+ "'  rowspan='6' align='center'style= 'dislay: none; ';></td>";
                    suma_columna4 =  suma_columna4+rs2.getInt("cant");
                    }
                      
                    
                     
                    
                    total_piso1=total_piso1+rs2.getInt("cant");
                    total=total+rs2.getInt("cant");
                    total_piso=total_piso+rs2.getInt("cant");
                    promedio_piso=Math.round(total/6);
                    promedio_columna=total/4;
                    id_fila=id_fila+1;
                    id_fila_total=id_fila_total+2;
                   }
                 {                                                                                                          
                     grilla_html = grilla_html + "<td  rowspan='17' align='center'style= 'dislay: none; ';><b>Total: "+(formatea.format(total_piso1))+"<br>Promedio:<br>"+(formatea.format(promedio_piso)) +"</td>";}
                    
               
                  
                  objet.put("grilla_contador",cabecera+   grilla_html  + 
                 
                 //"<td align='center' > Total:"+total+"<br>Prom:<br>"+promedio_piso+"</td>"
                 "</tr><tr> <td align='center'   style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna1))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna1))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna2))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna2))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna3))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna3))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna4))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';><b>"+(formatea.format(suma_columna4))+"</td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';></td>"
                 + "<td align='center'  style= 'dislay: none;';></td></tr>"
                 +"<td align='center' ></td>"                                                 
                  + "<td  colspan='14' align='center'style= 'dislay: none; ';><b>Total: "+(formatea.format(total_piso1))+"  | Promedio columna: "+(formatea.format(promedio_columna))+"</td>"
                 + "</tbody>  </table>  </div></center>" );
                
            
        //objet.put("grilla_contador1",cabecera +grilla_html2  +"</tbody>  </table>  </div></center></div>  </div>");
       // objet.put("grilla_contador2", cabecera  +grilla_html3  +"</tbody>  </table>  </div></center></div>  </div>");
        objet.put("fila", lote_id);
        objet.put("fila", saldo_aves);
        objet.put("fila", lote_fnac);
        objet.put("fila", fecha_80_sems);
        objet.put("fila", merma);
        objet.put("fila", edad_actual);
        objet.put("fila", grilla_html);
        objet.put("fila", cabecera);
            
             while (rs3.next()){
            
             if(rs3.getString("fila").startsWith("11")){
                grilla_html_periodo = grilla_html_periodo 
                    +"<tr class='tablagrilla'>"
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>";
                     }  
              if(rs3.getString("fila").startsWith("12")){
               
                    grilla_html_periodo = grilla_html_periodo
                    
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>"
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>";
                     } 
               if(rs3.getString("fila").startsWith("21")){
               
                    grilla_html_periodo = grilla_html_periodo
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>";
                     } 
                if(rs3.getString("fila").startsWith("22")){
               
                    grilla_html_periodo = grilla_html_periodo
                    
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>"
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>";
                     } 
                 if(rs3.getString("fila").startsWith("31")){
               
                    grilla_html_periodo = grilla_html_periodo
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"'  style= 'dislay: none;  "
                    + "color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>";
                     } 
                  if(rs3.getString("fila").startsWith("32")){
               
                    grilla_html_periodo = grilla_html_periodo
                  
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none;  "
                    + "color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>"
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>";
                     } 
                  if(rs3.getString("fila").startsWith("41")){
                    grilla_html_periodo = grilla_html_periodo
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none;  "
                    + "color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>";
                     } 
                    if(rs3.getString("fila").startsWith("42")){
               
                    grilla_html_periodo = grilla_html_periodo
                    
                    + "<td align='center' class='"+rs3.getString("parpadeo")+"' style= 'dislay: none; "
                    + " color:white; background-color:"+rs3.getString("color")+"';>"+ rs3.getString("cant") +"</td>"
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs3.getString("fila") + "</td>";
                     } 
                    
                     periodo_fecha=rs3.getString("fecha_inicio");
                     periodo_fecha_mas_1=rs3.getString("fecha_fin");
                 
                     }
                  
                    
                    
                    objet.put("grilla_contador_periodo", miles+cabecera_periodo   + grilla_html_periodo  +
                       "</tbody>  </table>  </div></center></div>  </div>" );
                    objet.put("grilla_cabecera2", miles+cabecera2   + 
                       "</tbody>  </table>  </div></center></div>  </div>" );
                   
                    objet.put("periodo_fecha",periodo_fecha+" / "+periodo_fecha_mas_1);
                   
                  
               while (rs4.next()){
            
              if(rs4.getString("fila").startsWith("11")){
                grilla_mortandad_periodo = grilla_mortandad_periodo 
                    +"<tr class='tablagrilla'>"                                                                                                                 
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>";
                     }    
                  if(rs4.getString("fila").startsWith("12")){
                   grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style='dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>"
                    ;
                    }  
                  if(rs4.getString("fila").startsWith("21")){
                    grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>";
                    } 
                  if(rs4.getString("fila").startsWith("22")){
                    grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>"
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"'  style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>";
                    }
                   if(rs4.getString("fila").startsWith("31")){
                    grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>";
                    }
                   if(rs4.getString("fila").startsWith("32")){
                    grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>";
                    }
                   if(rs4.getString("fila").startsWith("41")){
                    grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>";
                    }
                    if(rs4.getString("fila").startsWith("42")){
                    grilla_mortandad_periodo = grilla_mortandad_periodo 
                    + "<td align='center' class='"+rs4.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs4.getString("color")+"';>"+ rs4.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs4.getString("fila") + "</td>"
                   
                    ;
                    }
                     //total mortandad acumulados
                    total_mortandad_acum=total_mortandad_acum+rs4.getInt("cant");
                     }
                   //total promedio aculmulado periodo
                   total_mortandad_acum_prome=total_mortandad_acum/48;
                  objet.put("grilla_mortandad_periodo", cabecera_periodo   + grilla_mortandad_periodo  +
                       "</tr></tbody>  </table>  </div></center></div>  </div>" );
                  
                  objet.put("prom_mor_fila",total_mortandad_acum_prome);
                  objet.put("total_mortandad_acum",total_mortandad_acum);
                  
                while (rs5.next()){
            
             if(rs5.getString("fila").startsWith("11")){
                grilla_mortandad_global = grilla_mortandad_global 
                    +"<tr class='tablagrilla'>"
                    + "<td  align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"'  style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>";
                     }    
                  if(rs5.getString("fila").startsWith("12")){
                   grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>"
                    ;
                    }  
                  if(rs5.getString("fila").startsWith("21")){
                    grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>";
                    } 
                  if(rs5.getString("fila").startsWith("22")){
                    grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>";
                    }
                   if(rs5.getString("fila").startsWith("31")){
                    grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>";
                    }
                   if(rs5.getString("fila").startsWith("32")){
                    grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+" ';>"+ rs5.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>";
                    }
                   if(rs5.getString("fila").startsWith("41")){
                    grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>"
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>";
                    }
                    if(rs5.getString("fila").startsWith("42")){
                    grilla_mortandad_global = grilla_mortandad_global 
                    + "<td align='center' class='"+rs5.getString("parpadeo")+"' style= 'dislay: none;  color:white; background-color:"+rs5.getString("color")+"';>"+ rs5.getString("cant") +"</td>"
                    + "<td align='center'style= 'dislay: none; ';>"+ rs5.getString("fila") + "</td>";
                    
                    }
                    //total mortandad global
                    total_mortandad_global=total_mortandad_global+rs5.getInt("cant");
                     }
                   //total promedio fila aculmulado global
                   total_mortandad_prom_global=total_mortandad_global/48;
                  objet.put("grilla_mortandad_global", cabecera_periodo   + grilla_mortandad_global  +
                       "</tr></tbody>  </table>  </div></center></div>  </div>" );
                  objet.put("total_mortandad_prom_global",total_mortandad_prom_global);
                  objet.put("total_mortandad_global",total_mortandad_global);
                
                  while(rs6.next()) {  
                cant=rs6.getString("cant");
                dl_edaddias=rs6.getString("dl_edaddias");
                dl_edadsems=rs6.getString("dl_edadsems");
                pad_productividad=rs6.getString("pad_productividad");
                max_cant=rs6.getString("max_cant");
                min_cant=rs6.getString("min_cant");
                prome_huevo=rs6.getString("prome_huevo");
                productividad=rs6.getString("productividad");
                dif_productividad=rs6.getString("dif_productividad");
                color=rs6.getString("color");
                  }
               objet.put("cant",cant );
               objet.put("dl_edaddias",dl_edaddias+"dias"+"("+dl_edadsems+" sems"+")");
               objet.put("dl_edadsems",dl_edadsems );
               objet.put("pad_productividad",pad_productividad);
               objet.put("max_cant",max_cant);
               objet.put("min_cant",min_cant );
               objet.put("prome_huevo",prome_huevo);
               objet.put("productividad",productividad );
               objet.put("dif_productividad",dif_productividad);
               objet.put("color",color);
               
                while(rs7.next()) {  
                fila1=rs7.getString("fila1");
                fila2=rs7.getString("fila2");
                fila3=rs7.getString("fila3");
                fila4=rs7.getString("fila4");
                fila5=rs7.getString("fila5");
                fila61=rs7.getString("fila6");
                
                fila1_color=rs7.getString("fila1_color");
                fila2_color=rs7.getString("fila2_color");
                fila3_color=rs7.getString("fila3_color");
                fila4_color=rs7.getString("fila4_color");
                fila5_color=rs7.getString("fila5_color");
                fila6_color=rs7.getString("fila6_color");
                
                fila1_blink=rs7.getString("fila1_blink");
                fila2_blink=rs7.getString("fila2_blink");
                fila3_blink=rs7.getString("fila3_blink");
                fila4_blink=rs7.getString("fila4_blink");
                fila5_blink=rs7.getString("fila5_blink");
                fila6_blink=rs7.getString("fila6_blink");
                  }
                
                while(rs8.next()) {  
                total_huevos_acum=rs8.getString("cant");
                total_prome_acum=rs8.getString("promedio");
                }
               objet.put("fila1",fila1);
               objet.put("fila2",fila2);
               objet.put("fila3",fila3);
               objet.put("fila4",fila4);
               objet.put("fila5",fila5);
               objet.put("fila6",fila61);
               
               objet.put("fila1_color",fila1_color);
               objet.put("fila2_color",fila2_color);
               objet.put("fila3_color",fila3_color);
               objet.put("fila4_color",fila4_color);
               objet.put("fila5_color",fila5_color);
               objet.put("fila6_color",fila6_color);
               
               objet.put("fila1_blink",fila1_blink);
               objet.put("fila2_blink",fila2_blink);
               objet.put("fila3_blink",fila3_blink);
               objet.put("fila4_blink",fila4_blink);
               objet.put("fila5_blink",fila5_blink);
               objet.put("fila6_blink",fila6_blink);
               
               objet.put("total_piso1",total_piso1);
               objet.put("promedio_piso",promedio_piso);
               
               objet.put("total_huevos_acum",total_huevos_acum);
               objet.put("total_prome_acum",total_prome_acum);
        clases.controles.DesconnectarBDsession();             
        out.print(objet);
        
    } catch (Exception e) {
        String asda = e.getMessage();
    }

%>
