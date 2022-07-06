<%-- 
    Document   : consulta_registro_datos_diario
    Created on : 21/02/2022, 08:48:31
    Author     : aespinola
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="clases.controles"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%
    String fecha1 = request.getParameter("idfechad");

    String grilla_html_pre_descarte_global = "";
    String aviario = "";
    String lote_name = "";
    String saldo_ant = "";
    String muer = "";
    String ing = "";
    String salida = "";
    String sub = "";
    String ventas = "";
    String ajuste = "";
    String saldo = "";
    String carton = "";
    String carton2 = "";
    String unidades = "";
    String total_unidades = "";
    String prodporcen = "";
    String kg = "";
    String gr_ave = "";
    String vacio = "";
    String ver_fal = "";
    String color = "";
    String no = "";
    String desactivar="";
    Integer saldo_ant_total = 0;
    Integer dl_muertos_total = 0;
    Integer saldo_total = 0;
    Integer dl_ingreso_total = 0;
    Integer dl_salida_total = 0;
    Integer dl_elimi_total = 0;
    Integer dl_ventas_total = 0;
    Integer dl_ajuste_total = 0;
    Integer dl_carton1_total = 0;
    Integer dl_carton2_total = 0;
    Integer dl_unidades = 0;
    Integer dl_uni_total = 0;
    Integer kg_total = 0;
    Integer venta_total = 0;
    Integer calculo = 0;
    String cabecera = "  "
            + "    <div  style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
            + " <thead>"
            + " <tr>"
            + "     <th width='80' rowspan='2' class='text-center bg-navy'>Aviario</th>"
            + "     <th width='80' rowspan='2' class='text-center bg-navy'>Lote</th>"
            + "     <th colspan='8' class='text-center bg-navy'>Aves</th>"
            + "     <th colspan='5' class='text-center bg-navy'>Huevos</th>"
            + "     <th colspan='2' class='text-center bg-navy'>Balanceados</th>"
            + " </tr>"
            + " <tr>"
            + "     <th class='text-center bg-navy' width='80'>Saldo ant.</th>"
            + "     <th class='text-center bg-navy' width='65'>Mue.</th>"
            + "     <th class='text-center bg-navy' class='text-center bg-navy' width='60'>T.Ing.</th>"
            + "     <th class='text-center bg-navy' width='65'>T.Sal.</th>"
            + "     <th class='text-center bg-navy' width='65'>Sub.</th>"
            + "     <th class='text-center bg-navy' width='65'>Ven.</th>"
            + "     <th class='text-center bg-navy' width='65'>Aju.</th>"
            + "     <th class='text-center bg-navy' width='85'>Saldo</th>"
            + "     <th class='text-center bg-navy' width='85'>Cartones</th>"
            + "     <th class='text-center bg-navy' width='70'>Cartones</th>"
            + "     <th class='text-center bg-navy' width=80'>Unidades</th>"
            + "     <th class='text-center bg-navy' width=100' class='text-center'>Total Unid.</th>"
            + "     <th class='text-center bg-navy' width='70'>% Product.</th>"
            + "     <th class='text-center bg-navy' width='80'>Total Kg.</th>"
            + "     <th class='text-center bg-navy' width='80'>gr/ave</th>"
            + " </tr>"
            + " </thead>"
            + " <tbody>";

    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    controles.connectarBD();

    try {

        PreparedStatement pt = clases.controles.connect.prepareStatement("execute stp_mae_ppr_select_datos_pre_descarte_C @fecha_desde='" + fecha1 + "'");
        ResultSet rs = pt.executeQuery();

        while (rs.next()) {
            calculo = calculo + 1;
            if (rs.getString("lote_name").startsWith("---")) {
                vacio = "<img src='img/img_aldo/agegat.jpg' onclick='modal_agregar_lote_ppr(\"" + rs.getString("aviario") + "\")' "
                        + "data-toggle='modal' alt='' width='15' height='15'/> ";
                ver_fal = "false";
                color = "";
                desactivar="";
              

            } else {
                vacio = "";
                ver_fal = "true";
                color = "#fdff94";
               desactivar="<img src='img/img_aldo/botón-rojo.jpg' "
                       + "onclick='modal_desactivar_lote_ppr(\"" + rs.getString("aviario") + "\","+rs.getString("lote_id")+",\""+rs.getString("ultimo_registro")+"\")' "
                       + "data-toggle='modal' alt='' width='20' height='20'/> ";
            }

            grilla_html_pre_descarte_global = grilla_html_pre_descarte_global + ""
                    + "<tr class='tablagrilla'>"
                    + "<td id='" + rs.getString("aviario") + "'  id_datos='" + rs.getString("id_datos") + "' saldo='" + rs.getString("saldo_ant") + "'"
                    + "class='tablagrilla' style= 'text-align:center;'> " + rs.getString("aviario") + " </td> "
                    + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote_name") + "" + vacio + ""+desactivar+" </td>"
                    + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("saldo_ant") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_muertos'     class='tablagrilla cero'  id='re"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "'> " + rs.getString("muer") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_transferin'  class='tablagrilla cero'  id='su"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "'> " + rs.getString("ing") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_transferout'class='tablagrilla cero si'id='r2"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "';>" + rs.getString("salida") + " </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_elim'      class='tablagrilla cero '   id='r3"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "';>" + rs.getString("sub") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_venta'       class='tablagrilla cero ' id='r4"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center ;background-color: " + color +"';>" + rs.getString("ventas") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_ajuste'      class='tablagrilla cero ' id='r5"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "';>" + rs.getString("ajuste") + "  </td>"
                    + "<td  class='tablagrilla cero ' id='total"+calculo+"' style= 'text-align:center';>" + rs.getString("saldo") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_hcarton1' class='tablagrilla cero '     id='c1"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "';>" + rs.getString("carton1") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' muer='dl_hcarton2' class='tablagrilla cero '     id='c2"+calculo+"' idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "';>" + rs.getString("carton2") + "  </td>"
                    + "<td avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "'  muer='dl_huevos'  class='tablagrilla cero '      id='u"+calculo+"'  idcalculo='"+calculo+"'  style= 'text-align:center;background-color: " + color + "';>" + rs.getString("unidades") + "  </td>"
                    + "<td class='tablagrilla cero ' id='t"+calculo+"' style= 'text-align:center';>" + rs.getString("total_unidades") + "  </td>"
                    + "<td class='tablagrilla cero ' id='p"+calculo+"' style= 'text-align:center';>  " + rs.getString("prodporcen") + " % </td>" 
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' contenteditable='" + ver_fal + "' idcalculo='" + calculo + "' muer='dl_balkg' class='tablagrilla cero ' style= 'text-align:center;background-color: " + color + "';>  " + rs.getString("kg") + "  </td>"
                    + "<td  avi='" + rs.getString("aviario") + "' lote='" + rs.getString("lote_id") + "' muer='dl_balave' id='a" + calculo + "'  class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("gr_ave") + " % </td></tr>";
            saldo_ant_total = (saldo_ant_total) + (rs.getInt("saldo_ant"));
            dl_muertos_total = (dl_muertos_total) + (rs.getInt("muer"));
            dl_ingreso_total=dl_ingreso_total+(rs.getInt("ing"));
            dl_salida_total=dl_salida_total+(rs.getInt("salida"));
            dl_elimi_total=dl_elimi_total+(rs.getInt("sub"));
            saldo_total = (saldo_total) + (rs.getInt("saldo"));
            dl_ajuste_total = (dl_ajuste_total) + (rs.getInt("ajuste"));
            kg_total = (kg_total) + (rs.getInt("kg"));
            dl_ventas_total = dl_ventas_total + (rs.getInt("ventas"));
            dl_carton1_total = dl_carton1_total + (rs.getInt("carton1"));
            dl_carton2_total = dl_carton2_total + (rs.getInt("carton2"));
            dl_unidades = dl_unidades + (rs.getInt("unidades"));
            dl_uni_total = dl_uni_total + (rs.getInt("total_unidades"));
            aviario = rs.getString("aviario");
            lote_name = rs.getString("lote_name");
            saldo_ant = rs.getString("saldo_ant");
            muer = rs.getString("muer");
            ing = rs.getString("ing");
            salida = rs.getString("salida");
            ventas = rs.getString("ventas");
            ajuste = rs.getString("ajuste");
            sub = rs.getString("sub");
            saldo = rs.getString("saldo");
            carton = rs.getString("carton1");
            carton2 = rs.getString("carton2");
            unidades = rs.getString("unidades");
            total_unidades = rs.getString("total_unidades");
            total_unidades = rs.getString("prodporcen");
            total_unidades = rs.getString("kg");
            total_unidades = rs.getString("gr_ave");

        }
        obje.put("grilla_datos_diarios_pre_descarte_global", cabecera + grilla_html_pre_descarte_global + "</tbody><tfoot class='total'><tr>"
                + "  <td class='text-left bg-gray' colspan='2'>TOTAL</td>"
                + " <td class='text-center bg-gray'>"+saldo_ant_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_muertos_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_ingreso_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_salida_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_elimi_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_ventas_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_ajuste_total+"</td>"
                + " <td class='text-center bg-gray'>"+saldo_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_carton1_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_carton2_total+"</td>"
                + " <td class='text-center bg-gray'>"+dl_unidades+"</td>"
                + " <td class='text-center bg-gray'>"+dl_uni_total+"</td>"
                + " <td class='text-center bg-gray'></td>"
                + " <td class='text-center bg-gray'>" + kg_total + "</td>"
                + " <td class='text-center bg-gray'></td>"
                + " </tr>"
                + " </tfoot></body></div>");

    } catch (Exception e) {
        String error = e.getMessage();
    } finally {
        clases.controles.DesconnectarBD();
        out.print(obje);
        

    }
%>
