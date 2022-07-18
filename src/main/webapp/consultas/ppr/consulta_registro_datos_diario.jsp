<%-- 
    Document   : consulta_registro_datos_diario
    Created on : 21/02/2022, 08:48:31
    Author     : aespinola
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
        String fecha1= request.getParameter("idfechad") ;
        String grilla_html="";
        String modal_dasactivar_lote="";
        String grilla_htmlb="";
        String grilla_htmlh="";
        String grilla_html_descarte2="";
        String grilla_html_descarte="";
        String grilla_html_pre_descarte="";
        String aviario = "";
        String lote = "";
        String dias = "";
        String sems = "";
        String vacio = "";
        String onclick = "";
        Integer semana80 =0;
        Integer semsresult = 0;
        String saldoini = "";
        String saldoant = "";
        String muer = "";
        String via = "";
        String cant= "";
        String kg = "";
        String calcico = "";
        String tmin = "";
        String tmax = "";
        String click="";
        String coltempmin="";
        String coltempmax="";
        String arrow="";
        String arrow_pro="";
        String arrow_gramo_ave="";
        String color_gramo="";
        String sems85="";
        String transferin = "";
        String transferout= "";
        String ventas = "";
        String  ajuste = "";
        
        String lotename = "";
        
        String gramo_ave = "";
        String pro = "";
        //A
        Integer saldo_ant_total=0;
        Integer muer_total=0;
        Integer ti_total=0;
        Integer ts_total=0;
        Integer su_total=0;
        Integer aj_total=0;
        Integer ve_total=0;
        Integer saldo_total=0;
        Integer unidad_total=0;
        Integer kg_total=0;
        Integer calcico_total=0;
        
        //B
        Integer saldo_ant_totalb=0;
        Integer muer_totalb=0;
        Integer ti_totalb=0;
        Integer ts_totalb=0;
        Integer su_totalb=0;
        Integer aj_totalb=0;
        Integer ve_totalb=0;
        Integer saldo_totalb=0;
        Integer unidad_totalb=0;
        Integer kg_totalb=0;
        Integer calcico_totalb=0;
        
        //H
        Integer saldo_ant_totalh=0;
        Integer muer_totalh=0;
        Integer ti_totalh=0;
        Integer ts_totalh=0;
        Integer su_totalh=0;
        Integer aj_totalh=0;
        Integer ve_totalh=0;
        Integer saldo_totalh=0;
        Integer unidad_totalh=0;
        Integer kg_totalh=0;
        Integer calcico_totalh=0;
        
        //H3
        Integer saldo_ant_totalh3=0;
        Integer muer_totalh3=0;
        Integer ti_totalh3=0;
        Integer ts_totalh3=0;
        Integer su_totalh3=0;
        Integer aj_totalh3=0;
        Integer ve_totalh3=0;
        Integer saldo_totalh3=0;
        Integer unidad_totalh3=0;
        Integer kg_totalh3=0;
        Integer total_predescarte=0;
        Integer total_muertos_predescarte=0;
        String div_total_predescarte="";
        Integer calcico_totalh3=0;
        
        String cabecera_pre_descarte = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Pre-Descarte Convencionales</h5>"
            + "</div>"
                + "<br>"
               ;
        
        String cabecera = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados A</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='70'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
                + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";
        String cabecerab = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados B</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
               + "                    </tr>"
               + "                    </thead>"
               + "                    <tbody>";
        String cabecerah = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados H</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
                + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";
        String cabecera_descarte = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
                + "<br>"
                + "<br>"
            + "<div style='width: 100% !important;' class='card-header bg-navy'>"
            + "    <h5 class='text-center'>Mecanizados Descarte</h5>"
            + "</div>"
                + "<br>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
               + "                 <tr>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='50'>Aviario</th>"
               + "                     <th rowspan='2' class='text-center bg-navy tablagrilla' width='70'>Lote</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Edad</th>"
               + "                     <th colspan='11' class='text-center bg-navy tablagrilla'>Aves</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Huevos</th>"
               + "                     <th colspan='3' class='text-center bg-navy tablagrilla'>Balanceados</th>"
               + "                     <th colspan='2' class='text-center bg-navy tablagrilla'>Temp. Int.</th>"
               + "                 </tr>"
               + "                 <tr>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>días</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='40'>sems.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ini.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>muer.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>% mort.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TI</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>TS</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>SU</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>AJ</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>VE</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='50'>%Viab.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Unid.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>% Prod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Kg.</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla' width='60'>Calcico</th>"
                + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";

    clases.controles.connectarBD();
    JSONObject obje = new JSONObject();

 DecimalFormat formatea = new DecimalFormat("###,###.##");
    try {

    PreparedStatement pt=clases.controles.connect.prepareStatement("execute stp_mae_ppr_select_datos_diarios_descarte_h  @fecha_desde='"+fecha1+"'");
    ResultSet rs=pt.executeQuery();
    ArrayList Fila = new ArrayList();
   
    
    
            while(rs.next()) {
                
              semana80=Integer.parseInt(rs.getString("sems"));
             if(semana80>85){
                 sems85="<img src='img/img_aldo/botón-rojo.jpg' onclick='modal_desactivar_lote_ppr(\"" + rs.getString("onclick") + "\","+rs.getString("lote_id")+",\""+rs.getString("ultimo_registro")+"\")' "
                         + "data-toggle='modal' alt='' width='20' height='20'/> ";
            }else{  
                 sems85="";
              }
              
             if(rs.getString("lote").startsWith("---")){
                 vacio="<img src='img/img_aldo/agegat.jpg' onclick='modal_agregar_lote_ppr(\"" + rs.getString("aviario") + "\")' "
                         + "data-toggle='modal' alt='' width='15' height='15'/> ";
            }else{  
                 vacio="";
              }
              if(rs.getString("lote").startsWith("---")){
                 click=" ";
            }else{  
                 click="carga_aviario_fecha_ppr(\"" + rs.getString("onclick") + "\","+rs.getString("id_datos")+")";
              }
                
                if(rs.getString("aviario").startsWith("A")){
                grilla_html = grilla_html + "<tr  class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs.getString("aviario") + " </td>"
                        + " <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "" + sems85 + " " + vacio + "     </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + " </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoini2")) + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='" +click+ "'"
                        + " class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldo12")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("cant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro")  +'%'+ " <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("kg")) + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td>"
                        + "<td><input type='text' hidden value="+rs.getString("id_datos")+"  id='id_datos'>  </td>"
                        + "</tr>";
                saldo_ant_total=(saldo_ant_total)+Integer.parseInt(rs.getString("saldoant"));
                muer_total=(muer_total)+Integer.parseInt(rs.getString("muer"));
                ti_total=(ti_total)+Integer.parseInt(rs.getString("ti"));
                ts_total=(ts_total)+Integer.parseInt(rs.getString("ts"));
                su_total=(su_total)+Integer.parseInt(rs.getString("ti"));
                aj_total=(aj_total)+Integer.parseInt(rs.getString("aj"));
                ve_total=(ve_total)+Integer.parseInt(rs.getString("ve"));
                saldo_total=(saldo_total)+Integer.parseInt(rs.getString("saldo12"));
                unidad_total=(unidad_total)+Integer.parseInt(rs.getString("cant"));
                kg_total=(kg_total)+Integer.parseInt(rs.getString("kg"));
                calcico_total=(calcico_total)+Integer.parseInt(rs.getString("calcico"));

         
                }
                if(rs.getString("aviario").startsWith("B")){
                grilla_htmlb = grilla_htmlb + "<tr  class='tablagrilla'>"
                        + "<td class='tablagrilla' style= 'text-align:center;'>"+ " " + rs.getString("aviario") + " </td> "
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "" + sems85 + " " + vacio + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoini2")) + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='" +click+ "'"
                        + " class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td  style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td  style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td  style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldo12")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("cant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +" <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("kg")) + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td>"
                        + "</tr>";
                saldo_ant_totalb=(saldo_ant_totalb)+Integer.parseInt(rs.getString("saldoant"));
                muer_totalb=(muer_totalb)+Integer.parseInt(rs.getString("muer"));
                ti_totalb=(ti_totalb)+Integer.parseInt(rs.getString("ti"));
                ts_totalb=(ts_totalb)+Integer.parseInt(rs.getString("ts"));
                su_totalb=(su_totalb)+Integer.parseInt(rs.getString("ti"));
                aj_totalb=(aj_totalb)+Integer.parseInt(rs.getString("aj"));
                ve_totalb=(ve_totalb)+Integer.parseInt(rs.getString("ve"));
                saldo_totalb=(saldo_totalb)+Integer.parseInt(rs.getString("saldoant"));
                unidad_totalb=(unidad_totalb)+Integer.parseInt(rs.getString("cant"));
                kg_totalb=(kg_totalb)+Integer.parseInt(rs.getString("kg"));
                calcico_totalb=(calcico_totalb)+Integer.parseInt(rs.getString("calcico"));
                } 
               
                if(rs.getString("aviario").startsWith("H2")){
                grilla_htmlh = grilla_htmlh + "<tr   class='tablagrilla'>"
                        + "<td class='tablagrilla' style= 'text-align:center;'>"+ " " + rs.getString("aviario") + " </td> "
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "" + sems85 + " " + vacio + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoini2")) + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td  onclick='" +click+ "'"
                        + "class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldo12")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("cant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +" <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("kg")) + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td>"
                        + "</tr>";
                saldo_ant_totalh=(saldo_ant_totalh)+Integer.parseInt(rs.getString("saldoant"));
                muer_totalh=(muer_totalh)+Integer.parseInt(rs.getString("muer"));
                ti_totalh=(ti_totalh)+Integer.parseInt(rs.getString("ti"));
                ts_totalh=(ts_totalh)+Integer.parseInt(rs.getString("ts"));
                su_totalh=(su_totalh)+Integer.parseInt(rs.getString("ti"));
                aj_totalh=(aj_totalh)+Integer.parseInt(rs.getString("aj"));
                ve_totalh=(ve_totalh)+Integer.parseInt(rs.getString("ve"));
                saldo_totalh3=(saldo_totalh3)+Integer.parseInt(rs.getString("saldoant"));
                unidad_totalh=(unidad_totalh)+Integer.parseInt(rs.getString("cant"));
                kg_totalh=(kg_totalh)+Integer.parseInt(rs.getString("kg"));
                calcico_totalh=(calcico_totalh)+Integer.parseInt(rs.getString("calcico"));
                
                }   if(rs.getString("aviario").startsWith("H1")){
                grilla_htmlh = grilla_htmlh + "<tr   class='tablagrilla'>"
                        + "<td class='tablagrilla' style= 'text-align:center;'>"+ " " + rs.getString("aviario") + " </td> "
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "" + sems85 + "" + vacio + "   </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoini2")) + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='" +click+ "''"
                        + "class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldo12")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("cant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +" <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("kg")) + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td>"
                        + "</tr>";
              
                
                } 
                
                if(rs.getString("aviario").startsWith("H3")){
                grilla_html_descarte = grilla_html_descarte + "<tr   class='tablagrilla'>"
                        + "<td class='tablagrilla' style= 'text-align:center;'>"+ " " + rs.getString("aviario") + " </td> "
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + " " + sems85 + "" + vacio + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoini2")) + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldoant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") +" <i class='" + rs.getString("arrow") +"'></i> </td>"
                        + "<td onclick='" +click+ "' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("saldo12")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("cant")) + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +" <i class='" + rs.getString("arrow_pro") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + formatea.format(rs.getInt("kg")) + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorgramo") +" ' style= 'text-align:center';>  " + rs.getString("gramo_ave") +" <i class='" + rs.getString("arrow_gramo_ave") +"'></i> </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp2") + "' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colortemp") + "' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td>"
                        + "</tr>";
                saldo_ant_totalh3=(saldo_ant_totalh3)+Integer.parseInt(rs.getString("saldoant"));
                muer_totalh3=(muer_totalh3)+Integer.parseInt(rs.getString("muer"));
                ti_totalh3=(ti_totalh3)+Integer.parseInt(rs.getString("ti"));
                ts_totalh3=(ts_totalh3)+Integer.parseInt(rs.getString("ts"));
                su_totalh3=(su_totalh3)+Integer.parseInt(rs.getString("ti"));
                aj_totalh3=(aj_totalh3)+Integer.parseInt(rs.getString("aj"));
                ve_totalh3=(ve_totalh3)+Integer.parseInt(rs.getString("ve"));
                saldo_totalh3=(saldo_totalh3)+Integer.parseInt(rs.getString("saldo12"));
                unidad_totalh3=(unidad_totalh3)+Integer.parseInt(rs.getString("cant"));
                kg_totalh3=(kg_totalh3)+Integer.parseInt(rs.getString("kg"));
                calcico_totalh3=(calcico_totalh3)+Integer.parseInt(rs.getString("calcico"));
                } 
                
        aviario = rs.getString("aviario");
        lote = rs.getString("lote");
        dias = rs.getString("dias");
        sems = rs.getString("sems");
        saldoini = rs.getString("saldoini2");
        saldoant = rs.getString("saldoant");
        muer = rs.getString("muer");
        via = rs.getString("via");
        cant= rs.getString("cant");
        kg = rs.getString("kg");
        calcico = rs.getString("calcico");
        tmin = rs.getString("tmin");
        tmax = rs.getString("tmax");
        onclick = rs.getString("onclick");
        coltempmin = rs.getString("colortemp");
        coltempmax = rs.getString("colortemp2");
        arrow = rs.getString("arrow");
        arrow_pro = rs.getString("arrow_pro");
        color_gramo = rs.getString("colorgramo");
        arrow_gramo_ave = rs.getString("arrow_gramo_ave");
               
              }
            

        PreparedStatement pt4=clases.controles.connect.prepareStatement("execute [stp_mae_ppr_select_datos_diarios_pre_descarte] @fecha_desde='"+fecha1+"'");
    ResultSet rs4=pt4.executeQuery();

            while(rs4.next()) {
                
                grilla_html_pre_descarte = grilla_html_pre_descarte + "<table class=' table-bordered tablagrilla compact-cs'>"
               + "             <thead>"
                + "<tr>"
                + "        <th class='bg-warning' colspan='14'>Lote: " + rs4.getString("lote_name") + "</th>"
                + "    </tr>"
               + "                 <tr>    "
               + "                     <th class='text-center bg-navy tablagrilla'width='92' height='10'>Edad (d)</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Edad (s)</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Saldo ant.</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Muertos</th>"
               + "                      <th class='text-center bg-navy tablagrilla'width='92'height='10'>T.I.</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>T.S.</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Ventas</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Subprod.</th>"

               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Ajustes</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Saldo</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Balanceados</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>gr/ave</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>Huevos</th>"
               + "                     <th class='text-center bg-navy tablagrilla'width='92'height='10'>% Prod.</th>"
               + "                  </tr>   "
               + "                </thead>     "
                        + "                <br>     "
               + "                <tbody>     "
                        + "<tr onclick='dd_mec2_pre_des_convencionales_ppr(\"" + fecha1 + "\" )' class='tablagrilla'>"
                        + "<td  class='tablagrilla' style= 'text-align:center;'>" + rs4.getString("edaddias") + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("edadsems")+ "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center';>"+ rs4.getString("saldoant")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("muertos")+"</td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>" + rs4.getString("transferin")+" </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("transferout")+"  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("cant")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("ventas")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("ajuste")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("saldoaves")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("kg")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("gramo_ave")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("cant")+"</td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs4.getString("pro")+"</td>"
                        + "</tr>";
  

                
                
        dias       = rs4.getString("edaddias");
        sems       = rs4.getString("edadsems");
        saldoant   = rs4.getString("saldoant");
        muer       = rs4.getString("muertos");
        transferin = rs4.getString("transferin");
        transferout= rs4.getString("transferout");
        ventas     = rs4.getString("ventas");
        ajuste     = rs4.getString("ajuste");
        saldoini   = rs4.getString("saldoaves");
        lotename   = rs4.getString("lote_name");
        kg         = rs4.getString("kg");
        gramo_ave  = rs4.getString("gramo_ave");
        pro        = rs4.getString("pro");
        total_predescarte=(total_predescarte)+Integer.parseInt(rs4.getString("saldoaves"));
        total_muertos_predescarte=(total_muertos_predescarte)+Integer.parseInt(rs4.getString("muertos"));
        div_total_predescarte="<div  class='box-footer'><br><br><h4>Saldo total de aves Pre-Descarte: "+total_predescarte+"</h4><h5>Total muertos: "+total_muertos_predescarte+"</h5></div>";
              }      

    obje.put("grilla_datos_diarios",cabecera + grilla_html + "</tbody><tfoot class='total'>"
                           + "<tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_ant_total)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(muer_total)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ti_total)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ts_total)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(su_total)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(aj_total)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ve_total)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_total)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+formatea.format(unidad_total)+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+formatea.format(kg_total)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(calcico_total)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div></div>" );

    obje.put("grilla_datos_diariosb",cabecerab + grilla_htmlb + "</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_ant_totalb)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(muer_totalb)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ti_totalb)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ts_totalb)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(su_totalb)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(aj_totalb)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ve_totalb)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_totalb)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+formatea.format(unidad_totalb)+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+formatea.format(kg_totalb)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(calcico_totalb)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div>" );
    obje.put("grilla_datos_diariosh",cabecerah + grilla_htmlh + "</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_ant_totalh)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(muer_totalh)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ti_totalh)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ts_totalh)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(su_totalh)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(aj_totalh)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ve_totalh)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_totalh)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+formatea.format(unidad_totalh)+"</td>"
                            +"<td class='text-center bg-gray'></td>"
                            +"<td class='text-center bg-gray'>"+formatea.format(kg_totalh)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(calcico_totalh)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div>" );
    obje.put("grilla_datos_diarios_descarte",cabecera_descarte + grilla_html_descarte +"</tbody><tfoot class='total'><tr>"
                          +"  <td class='text-left bg-gray' colspan='5'>TOTAL</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_ant_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(muer_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ti_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ts_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(su_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(aj_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(ve_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(saldo_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +"<td class='text-center bg-gray'>"+formatea.format(unidad_totalh3)+"</td>"
                           +"<td class='text-center bg-gray'></td>"
                           +"<td class='text-center bg-gray'>"+formatea.format(kg_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'>"+formatea.format(calcico_totalh3)+"</td>"
                           +" <td class='text-center bg-gray'></td>"
                           +" <td class='text-center bg-gray'></td>"
                       +" </tr>"
                    +"</tfoot></body></div>" );
    obje.put("grilla_datos_diarios_pre_descarte",cabecera_pre_descarte + grilla_html_pre_descarte + "</tbody></body></div>" );
    obje.put("tmin",tmin );
    obje.put("aviario",aviario );
    obje.put("fecha1",fecha1 );
    obje.put("div_total_predescarte",div_total_predescarte );
    
        } catch (Exception e) {
        }
    finally{
    out.print(obje); 
    clases.controles.DesconnectarBD();
    }
 %>
