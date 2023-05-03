
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
    String trBalanceados = "";
    String trNutrientes = "";
    String cabeceraBalanceados = "";
    String cabeceraNutrientes = "";
    DecimalFormat formatea = new DecimalFormat("###,###.##");
    try {

        String id = request.getParameter("id_pedido");
        String ids = request.getParameter("ids");
        String cod_formulas = request.getParameter("cod_formulas");
        String cod_formula = request.getParameter("cod_formula");

        ResultSet rsBalanceados, rsNutriente;
        Statement stBalanceados = connection.createStatement();
        Statement stNutrientes = connection.createStatement();
        int cantidad_nueva = 0;
        int cantidad_actual = 0;

        rsBalanceados = stBalanceados.executeQuery("  exec  [mae_bal_pry3_nuevo] @id_array='" + ids + "', @id='" + id + "', @formula_array='" + cod_formulas + "' , @formula='" + cod_formula + "' ");
        rsNutriente = stNutrientes.executeQuery("select * from mae_bal_mtp_det_solicitud_nutrientes where id_cab=" + id);

        cabeceraBalanceados = " <table id='tb_formulacion_det'  class=' table-bordered compact display' style='width:100%' >"
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
                + " <th class='text-right' style='color: #fff; background: black;' >Dosis nueva</th>      "
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
        int tonelada = 0;
        String mes;
        String dias;
        while (rsBalanceados.next()) {
            class_color = rsBalanceados.getString("cantidad_nueva").replace(".", ",");

            double numero = Double.parseDouble(rsBalanceados.getString("abastecimiento_nuevo"));
            double parteDecimal = numero % 1; // Lo que sobra de dividir al número entre 1
            double parteEntera = numero - parteDecimal; // Le quitamos la parte decimal usando una resta
            double parteD = parteDecimal * 30;

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

            class_color_abas = (formato_mes + ' ' + formato_dia);

            if (rsBalanceados.getInt("costo_nuevo") < rsBalanceados.getInt("costo_actual")) {
                class_color = "<h5><span class='badge badge-primary right'>" + rsBalanceados.getString("cantidad_nueva").replace(".", ",") + "</span></h5> ";
            } else if (rsBalanceados.getInt("costo_nuevo") > rsBalanceados.getInt("costo_actual")) {

                class_color = "<h5><span class='badge badge-danger right'>" + rsBalanceados.getString("cantidad_nueva").replace(".", ",") + "</span></h5> ";
            }

            if (rsBalanceados.getInt("abastecimiento_nuevo") < 1) {
                class_color_abas = "<h5><span class='badge badge-danger right'>" + formato_dia.replace(".", ",") + "</span></h5> ";
            }

            trBalanceados = trBalanceados
                    + "<tr > "
                    + "<td   style=\"font-weight:bold\" > " + rsBalanceados.getString("descripcion") + "</td>"
                    + "<td  class='text-right'  style=\"font-weight:bold\">  " + formatea.format(rsBalanceados.getInt("costo")) + "</td>"
                    + "<td class='text-right' style=\"font-weight:bold\">  " + rsBalanceados.getFloat("toneladas_proyectadas") + "</td>"
                    + "<td class='text-right ' style=\"font-weight:bold\">  " + formatea.format(rsBalanceados.getFloat("stock")) + "</td>"
                    + "<td class='text-right td_negro' style=\"font-weight:bold\"> <h5><span class='badge badge-dark right'>" + rsBalanceados.getString("cantidad_actual").replace(".", ",") + "</span></h5>   </td>"
                    + "<td class='text-right td_gris'  style=\"font-weight:bold\">  " + class_color + "</td>"
                    + "<td class='text-right td_negro' style=\"font-weight:bold \"> <h5><span class='badge badge-dark right'>" + formatea.format(rsBalanceados.getFloat("consumo_mensual_actual_formula")) + "</span></h5>   </td>"
                    + "<td class='  text-right td_negro' style=\"font-weight:bold \"> <h5><span class='badge badge-dark right'>" + rsBalanceados.getString("abastecimiento_actual").replace(".", ",") + "</span></h5>   </td>"
                    + "<td class='text-amarilloOscuro_bal td_gris' style=\"font-weight:bold\">  " + formatea.format(rsBalanceados.getFloat("consumo_mensual_nuevo_formula")) + "</td>"
                    + "<td class='text-right  ' style=\"font-weight:bold\">  " + class_color_abas + "  </td>"
                    + "<td class='text-right' style=\"font-weight:bold\">  " + rsBalanceados.getString("estado_monto") + "</td>"
                    + "</tr>";

            cantidad_nueva = cantidad_nueva + rsBalanceados.getInt("costo_nuevo");
            cantidad_actual = cantidad_actual + rsBalanceados.getInt("costo_actual");
            tonelada = rsBalanceados.getInt("toneladas_proyectadas");
            puntualOmensual = rsBalanceados.getString("desc_indef_puntual");
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

        cabeceraNutrientes = " <table id='tb_nutriente'  class=' table-bordered compact display' style='width:100%' >"
                + "<thead>"
                + "<th class='text-center' style='color: #fff; background: black;' colspan='11'>PEDIDO NRO. " + id + "</td>"
                + "</tr>"
                + "<tr>"
                + " <th  style='color: #fff; background: black;' >NRO.</th>      "
                + " <th  style='color: #fff; background:  black;' >VITAMINA</th>      "
                + " <th  style='color: #fff; background: black;' >Unidad de Medida</th>       "
               + " <th  class='text-center' style='color: #fff; background: black;' >ACTUAL</th>      "
                + " <th  class='text-center' style='color: #fff; background: black;' >ANTERIOR</th>      "
                + " <th  style='color: #fff; background: black;' >VARIACION</th>       "
                + " </thead> "
                + " <tbody >";
        while (rsNutriente.next()) {
            String colorCeldaNutriente = "";
           

              if (rsNutriente.getFloat("actual") < rsNutriente.getFloat("nuevo")) {
                colorCeldaNutriente = "<h5><span class='badge badge-danger right'>" + rsNutriente.getString("nuevo").replace(".", ",") + "</span></h5> ";

            
            } else if (rsNutriente.getFloat("actual") > rsNutriente.getFloat("nuevo")) {

                colorCeldaNutriente = "<h5><span class='badge badge-primary right'>" + rsNutriente.getString("nuevo").replace(".", ",") + "</span></h5> ";
            }
            else {
                         colorCeldaNutriente =  rsNutriente.getString("nuevo")  ;

             }

            
            trNutrientes = trNutrientes
                    + "<tr > "
                    + "<td  style=\"font-weight:bold\" > " + rsNutriente.getString("id_nutriente") + "</td>"
                    + "<td  style=\"font-weight:bold\">  " + rsNutriente.getString("desc_nutriente") + "</td>"
                    + "<td style=\"font-weight:bold\" > " + rsNutriente.getString("unidad_de_medida") + "</td>"
                    + "<td class='text-center' style=\"font-weight:bold\">  " +colorCeldaNutriente+ "</td>"
                    + "<td  class='text-center' style=\"font-weight:bold\">  " + rsNutriente.getString("actual") + "</td>"
                    
                    + "<td style=\"font-weight:bold\"  id=\"resnutriente"+ rsNutriente.getString("id_nutriente") +"\" > " + (rsNutriente.getDouble("nuevo") +  rsNutriente.getDouble ("actual")) + "</td>"
                    + "</tr>";

        }

        ob.put("grillaNutrientes", cabeceraNutrientes + trNutrientes + "</tbody> ");

        ob.put("grillaBalanceado", cabeceraBalanceados + trBalanceados + "</tbody> "
                + "<tfoot>  "
                + "<tr  > "
                + "<td  colspan='8'></td> "
                + "<td class=' text-right' style='font-weight: bold; background: rgb(0, 0, 0);color: #fff;'   > " + td_actual + "</td> "
                + "<td  class=' text-right' style='font-weight: bold; background: rgb(0, 0, 0);color: #fff;'   > " + td_nuevo + "</td> "
                + "<td  class=' text-right' style='font-weight: bold; background: rgb(0, 0, 0);color: #fff;' > " + td_diferencia + "</td> "
                + " </tr> "
                + "</tfoot> </table>");

        rsBalanceados.close();
        rsNutriente.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }


%> 