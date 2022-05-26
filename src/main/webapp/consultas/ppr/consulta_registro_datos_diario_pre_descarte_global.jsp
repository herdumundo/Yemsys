<%-- 
    Document   : consulta_registro_datos_diario
    Created on : 21/02/2022, 08:48:31
    Author     : csanchez
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
    String unidades = "";
    String total_unidades = "";
    String prodporcen = "";
    String kg = "";
    String gr_ave = "";

    //Pre descarte global
    Integer saldo_ant_total = 0;
    Integer saldo_total = 0;
    Integer kg_total = 0;
    Integer venta_total = 0;

    String cabecera = "  "
            + "    <div  style='width: 100% !important  margin-left: 60%';' class='h_d2 text-center'>"
            + "<table class=' table-bordered tablagrilla compact-cs'>"
            + " <thead>"
            + " <tr>"
            + "     <th width='70' rowspan='2' class='text-center bg-navy'>Aviario</th>"
            + "     <th width='80' rowspan='2' class='text-center bg-navy'>Lote</th>"
            + "     <th colspan='8' class='text-center bg-navy'>Aves</th>"
            + "     <th colspan='4' class='text-center bg-navy'>Huevos</th>"
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
            //+ "     <th class='text-center bg-navy' width='70'>Cartones</th>"
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

            grilla_html_pre_descarte_global = grilla_html_pre_descarte_global + "<tr class='tablagrilla'><td class='tablagrilla' style= 'text-align:center;'>"
                    + " " + rs.getString("aviario") + " </td> <td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("lote_name") + "  </td>"
                    + "<td class='tablagrilla cero tdc' style= 'text-align:center;color:' ;> " + rs.getString("saldo_ant") + "  </td>"
                    + "<td contenteditable='true' id='dl_muertos'    id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero' style= 'text-align:center;background-color: #fdff94'>" + rs.getString("muer") + "  </td>"
                    + "<td contenteditable='true' id='dl_transferin' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero' style= 'text-align:center;color:;background-color: #fdff94'> " + rs.getString("ing") + "  </td>"
                    + "<td contenteditable='true' id='dl_transferout' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero si' style= 'text-align:center;background-color: #fdff94';> " + rs.getString("salida") + " </td>"
                    + "<td contenteditable='true' id='dl_ajuste'   id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center;background-color: #fdff94';>  " + rs.getString("sub") + "  </td>"
                    + "<td contenteditable='true' id='dl_venta'  id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center ;background-color: #fdff94';>  " + rs.getString("ventas") + "  </td>"
                    + "<td contenteditable='true' id='dl_ajuste' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center;background-color: #fdff94';>  " + rs.getString("ajuste") + "  </td>"
                    + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("saldo") + "  </td>"
                    + "<td contenteditable='true' id='dl_hcarton1' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center;background-color: #fdff94';>  " + rs.getString("carton") + "  </td>"
                   // + "<td contenteditable='true' id='' class='tablagrilla cero ' style= 'text-align:center;background-color: #fdff94';>  " + rs.getString("carton") + "  </td>"
                    + "<td contenteditable='true' id='dl_huevos' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center;background-color: #fdff94';>  " + rs.getString("unidades") + "  </td>"
                    + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("total_unidades") + "  </td>"
                    + "<td class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("prodporcen") + "  </td>"
                    + "<td contenteditable='true' id='dl_balkg' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center;background-color: #fdff94';>  " + rs.getString("kg") + "  </td>"
                    + "<td contenteditable='true' id='dl_balave' id_datos='"+rs.getString("id_datos")+"' class='tablagrilla cero ' style= 'text-align:center';>  " + rs.getString("gr_ave") + "  </td></tr>";
            saldo_ant_total = (saldo_ant_total) + (rs.getInt("saldo_ant"));
            saldo_total = (saldo_total) + (rs.getInt("saldo"));
            kg_total = (kg_total) + (rs.getInt("kg"));
            venta_total=venta_total+(rs.getInt("ventas"));
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
            carton = rs.getString("carton");
            unidades = rs.getString("unidades");
            total_unidades = rs.getString("total_unidades");
            total_unidades = rs.getString("prodporcen");
            total_unidades = rs.getString("kg");
            total_unidades = rs.getString("gr_ave");

        }
        obje.put("grilla_datos_diarios_pre_descarte_global", cabecera + grilla_html_pre_descarte_global + "</tbody><tfoot class='total'><tr>"
                + "  <td class='text-left bg-gray' colspan='2'>TOTAL</td>"
                + " <td class='text-center bg-gray'>" + saldo_ant_total + "</td>"
                + " <td class='text-center bg-gray'></td>"
                + " <td class='text-center bg-gray'></td>"
                + " <td class='text-center bg-gray'></td>"
                + " <td class='text-center bg-gray'></td>"
                + " <td class='text-center bg-gray'>" + venta_total + "</td>" 
                + " <td class='text-center bg-gray'></td>"
                + " <td class='text-center bg-gray'>" + saldo_total + "</td>"
                + " <td class='text-center bg-gray'></td>"
                + "<td class='text-center bg-gray'></td>"
                + "<td class='text-center bg-gray'></td>"
                + "<td class='text-center bg-gray'></td>"
                + "<td class='text-center bg-gray'></td>"
                + "<td class='text-center bg-gray'>" + kg_total + "</td>"
                + " <td class='text-center bg-gray'></td>"
                + " </tr>"
                + "</tfoot></body></div>");
       

    } catch (Exception e) {
        String error = e.getMessage();
    } finally {
        clases.controles.DesconnectarBD();
        out.print(obje);
        

    }
%>
