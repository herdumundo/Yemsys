<%-- 
    Document   : consulta_cargar_aviario_fecha
    Created on : 07/03/2022, 15:08:27
    Author     : csanchez
--%>

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
        String avia= request.getParameter("avia") ;
        String grilla_html="";
        String aviario = "";
        String lote = "";
        String dias = "";
        String sems = "";
        String saldoini = "";
        String saldoant = "";
        String muer = "";
        String via = "";
        String cant= "";
        String kg = "";
        String calcico = "";
        String tmin = "";
        String tmax = "";
        String onclick="";
        String cabecera = "  "
            + "    <div style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
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

               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.mín.</th>"
               + "                    <th class='text-center bg-navy tablagrilla' width='60'>T.máx.</th>"
                + "                    </tr>"
                + "                    </thead>"
                + "                    <tbody>";

    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    //PreparedStatement pt=con.prepareStatement("select case  when  fila % 2 =0 then 'green' else 'red' end as color, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
     //PreparedStatement pt=con.prepareStatement("select idusuario,nombreusuario from tab_mae_ppr_log");
    //PreparedStatement pt=con.prepareStatement("select '#ff0000' as min1, '#e10000' as min2,'#e10000' as min3, '#007d3c' as prom, '#007d50' as prom1 , '#007d97' as prom2, '#007dff' as prom3, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("execute stp_mae_ppr_select_datos_diarios  @fecha_desde='"+fecha1+"'");
    ResultSet rs=pt.executeQuery();
    ArrayList Fila = new ArrayList();
    
    //ArrayList fe1 = new ArrayList();
   // ArrayList fe2 = new ArrayList();
            while(rs.next()) {
                
                grilla_html = grilla_html + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                + " " + rs.getString("aviario") + " </td> "
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote") + "  </td>"
                        + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("dias") +"  </td>"
                        + "<td class='tablagrilla cero " + rs.getString("colorsem") + "' style= 'text-align:center;color:" + rs.getString("colorl") + "'>  " + rs.getString("sems") + "  </td>"
                        + "<td class='tablagrilla cero si' style= 'text-align:center';>  " + rs.getString("saldoini2") + " </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldoant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("muer") + "  </td>"
                        + "<td onclick='dd_mec2_ppr(),carga_grilla_registro_datos_diarios_B_ppr();' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("mor") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TI") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("TS") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("AJ") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("VE") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldo") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("via") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("cant") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("pro") +'%'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("kg") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("gramo_ave") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("calcico") + "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("tmin") +'°'+'C'+ "  </td>"
                        + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("tmax") +'°'+'C'+ "  </td></tr>";
                
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
               
              }
    clases.controles.DesconnectarBDsession();   
    obje.put("grilla_datos_diarios",cabecera + grilla_html + "</tbody></body></div>" );
    obje.put("tmin",tmin );
    obje.put("fecha1",fecha1 );
    obje.put("avia",avia );
    out.print(obje); 
 %>