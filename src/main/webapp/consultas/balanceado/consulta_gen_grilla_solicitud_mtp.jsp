
<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String grilla_html2 = "";
    String grilla_html3 = "";
    String cabecera = "";
    String cabecera2 = "";
    String cabecera3 = "";
    DecimalFormat formatea = new DecimalFormat("###,###.##");

    try {

        String id = request.getParameter("id_pedido");
        String ids = request.getParameter("ids");
        String cod_formulas = request.getParameter("cod_formulas");
        String cod_formula = request.getParameter("cod_formula");

        ResultSet rs_GM;
        Statement st = connection.createStatement();
        int cantidad_nueva = 0;
        int cantidad_actual = 0;
        rs_GM = st.executeQuery("  exec  [mae_bal_pry3_nuevo] @id_array='" + ids + "', @id='" + id + "', @formula_array='" + cod_formulas + "' , @formula='" + cod_formula + "' ");

        cabecera = " <table id='tb_formulacion_det'  class=' table-bordered compact display' style='width:100%' >"
                + "<thead>"
                + "<tr >"
                + "<th class='text-center' style='color: #fff; background: black;' colspan='11'>PEDIDO NRO. " + id + "</td>"
                + "</tr>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >Ingrediente</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Costo unitario</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Tonelada</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Stock SAP</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Dosis actual</th>      "
                //      + " <th class='text-right' style='color: #fff; background: black;' >Costo((Dosis x costo uni) </th>      " 

                + " <th class='text-right' style='color: #fff; background: black;' >Dosis nueva</th>      "
                //    + " <th class='text-right' style='color: #fff; background: black;' >Costo((Dosis x costo uni))</th>      "

                + " <th class='text-right' style='color: #fff; background: black;' >Consumo mensual actual(Dosis X Tonelada)</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Abastecimiento meses total formulas</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Consumo mensual nuevo (Dosis X Tonelada)</th>      "
                + " <th class='text-right' style='color: #fff; background: black;' >Abastecimiento meses total formulas</th>      "
                + " <th class='text-right'  style='color: #fff; background: black;' >Estado</th>      "
                + " </thead> "
                + " <tbody >";
        String class_color = "";
        String puntualOmensual = "";
        String class_color_abas = "text-right";
        String entera;
        int tonelada = 0;
        String mes;
        String dias;
        while (rs_GM.next()) {
            class_color = rs_GM.getString("cantidad_nueva").replace(".", ",");

            //rs_GM.getString("abastecimiento_nuevo")
            double numero = Double.parseDouble(rs_GM.getString("abastecimiento_nuevo"));
            System.out.printf("El número originalmente es: %f\n", numero);
            double parteDecimal = numero % 1; // Lo que sobra de dividir al número entre 1
            double parteEntera = numero - parteDecimal; // Le quitamos la parte decimal usando una resta
            //System.out.printf("Parte entera: %f. Parte decimal: %f\n", parteEntera, parteDecimal);

            double parteD = parteDecimal * 30;

            //class_color_abas= parteEntera;
            mes = String.valueOf(Math.round(parteEntera));
            dias = String.valueOf(Math.round(parteD));
            String formato_mes = "";
            String formato_dia = "";
            if (mes.equals("0")) {
                formato_mes = "";
            } else if (mes.equals("1")) {
                formato_mes = mes + " Mes";
            } else {
                formato_mes = mes + " Meses";
            }

            if (dias.equals("0")) {
                formato_dia = "0 Dias";
            } else if (dias.equals("1")) {
                formato_dia = dias + " Día";
            } else {
                formato_dia = dias + " Días";
            }

            String finals = "";

            //
            //String formato_mes="";
            //String union=formato_mes+formato_dia  ;
            // class_color_abas= union;
            class_color_abas = (formato_mes + ' ' + formato_dia);

            if (rs_GM.getInt("costo_nuevo") < rs_GM.getInt("costo_actual")) {
                // class_color = "text-down_bal";
                class_color = "<h5><span class='badge badge-primary right'>" + rs_GM.getString("cantidad_nueva").replace(".", ",") + "</span></h5> ";
            } else if (rs_GM.getInt("costo_nuevo") > rs_GM.getInt("costo_actual")) {

                // class_color = "text-rojo_bal";
                class_color = "<h5><span class='badge badge-danger right'>" + rs_GM.getString("cantidad_nueva").replace(".", ",") + "</span></h5> ";

            }

            if (rs_GM.getInt("abastecimiento_nuevo") < 1) {

                class_color_abas = "<h5><span class='badge badge-danger right'>" + formato_dia.replace(".", ",") + "</span></h5> ";

            }

            grilla_html = grilla_html
                    + "<tr > "
                    + "<td   style=\"font-weight:bold\" > " + rs_GM.getString("descripcion") + "</td>"
                    + "<td  class='text-right'  style=\"font-weight:bold\">  " + formatea.format(rs_GM.getInt("costo")) + "</td>"
                    + "<td class='text-right' style=\"font-weight:bold\">  " + rs_GM.getFloat("toneladas_proyectadas") + "</td>"
                    + "<td class='text-right ' style=\"font-weight:bold\">  " + formatea.format(rs_GM.getFloat("stock")) + "</td>"
                    + "<td class='text-right td_negro' style=\"font-weight:bold\"> <h5><span class='badge badge-dark right'>" + rs_GM.getString("cantidad_actual").replace(".", ",") + "</span></h5>   </td>"
                    + "<td class='text-right td_gris'  style=\"font-weight:bold\">  " + class_color + "</td>"
                    + "<td class='text-right td_negro' style=\"font-weight:bold \"> <h5><span class='badge badge-dark right'>" + formatea.format(rs_GM.getFloat("consumo_mensual_actual_formula")) + "</span></h5>   </td>"
                    + "<td class='  text-right td_negro' style=\"font-weight:bold \"> <h5><span class='badge badge-dark right'>" + rs_GM.getString("abastecimiento_actual").replace(".", ",") + "</span></h5>   </td>"
                    + "<td class='text-amarilloOscuro_bal td_gris' style=\"font-weight:bold\">  " + formatea.format(rs_GM.getFloat("consumo_mensual_nuevo_formula")) + "</td>"
                    + "<td class='text-right  ' style=\"font-weight:bold\">  " + class_color_abas + "  </td>"
                    + "<td class='text-right' style=\"font-weight:bold\">  " + rs_GM.getString("estado_monto") + "</td>"
                    + "</tr>";

            cantidad_nueva = cantidad_nueva + rs_GM.getInt("costo_nuevo");
            cantidad_actual = cantidad_actual + rs_GM.getInt("costo_actual");
            tonelada = rs_GM.getInt("toneladas_proyectadas");
            puntualOmensual = rs_GM.getString("desc_indef_puntual");
        }

        int costo_actual = cantidad_actual / 1000;
        int costo_nuevo = cantidad_nueva / 1000;
        int diferencia = costo_actual - costo_nuevo;
        if (diferencia < 0) {
            diferencia = diferencia * -1;
        }
        String td_actual = "<i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i> Total costo actual(Gs/Kg)  : " + formatea.format(cantidad_actual / 1000);
        String td_nuevo = "<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i> Total costo nuevo(Gs/Kg)  :" + formatea.format(cantidad_nueva / 1000);
        String td_diferencia = "Disminución " + puntualOmensual + " : " + formatea.format((diferencia * tonelada) * 1000) + "<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i>";
        if (cantidad_nueva > cantidad_actual) {
            td_actual = "<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i> Total costo actual(Gs/Kg) : " + formatea.format(cantidad_actual / 1000);
            td_nuevo = "<i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i> Total costo nuevo(Gs/Kg)  :" + formatea.format(cantidad_nueva / 1000);
            td_diferencia = "Incremento  " + puntualOmensual + " : " + formatea.format((diferencia * tonelada) * 1000) + " <i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i>";
        }

        ob.put("grilla", cabecera + grilla_html + "</tbody> "
                + "<tfoot>  "
                + "<tr  > "
                + "<td  colspan='8'></td> "
                + "<td class=' text-right' style='font-weight: bold; background: rgb(0, 0, 0);color: #fff;'   > " + td_actual + "</td> "
                + "<td  class=' text-right' style='font-weight: bold; background: rgb(0, 0, 0);color: #fff;'   > " + td_nuevo + "</td> "
                + "<td  class=' text-right' style='font-weight: bold; background: rgb(0, 0, 0);color: #fff;' > " + td_diferencia + "</td> "
                + " </tr> "
                + "</tfoot> </table>");

        ResultSet rs_GM1;
        Statement st1 = connection.createStatement();

        rs_GM1 = st1.executeQuery("select * from mae_bal_mtp_det_solicitud_nutrientes where id_cab=" + id);

        cabecera3 = " <table id='tb_nutriente'  class=' table-bordered compact display' style='width:100%' >"
                + "<thead>"
                + "<th class='text-center' style='color: #fff; background: black;' colspan='11'>PEDIDO NRO. " + id + "</td>"
                + "</tr>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >NRO.</th>      "
                + " <th  style='color: #fff; background:  black;' >VITAMINA</th>      "
                + " <th  class='text-center' style='color: #fff; background: black;' >ANTERIOR</th>      "
                + " <th  class='text-center' style='color: #fff; background: black;' >ACTUAL</th>      "
                + " </thead> "
                + " <tbody >";
        while (rs_GM1.next()) {
            grilla_html3 = grilla_html3
                    + "<tr > "
                    
                    + "<td  style=\"font-weight:bold\" > " + rs_GM1.getString("id_nutriente") + "</td>"
                    + "<td  style=\"font-weight:bold\">  " + rs_GM1.getString("desc_nutriente") + "</td>"
                    + "<td  class='text-center' style=\"font-weight:bold\">  " + rs_GM1.getString("actual") + "</td>"
                    + "<td class='text-center' style=\"font-weight:bold\">  " + rs_GM1.getString("nuevo") + "</td>"
                    + "</tr>";

        }

        ob.put("grilla_total", cabecera2 + grilla_html2 + "</tbody></table>");

        ob.put("grilla3", cabecera3 + grilla_html3 + "</tbody> ");

        rs_GM.close();
        rs_GM1.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }


%> 