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
    String cabecera = "";
    String cabecera2 = "";
    DecimalFormat formatea = new DecimalFormat("###,###.##");

    try {
        String id = request.getParameter("id");
        String cod_formula = request.getParameter("cod_formula");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        int cantidad_nueva = 0;
        int cantidad_actual = 0;
        rs_GM = st.executeQuery("  exec  [mae_bal_pry] @id=" + id + ", @formula='" + cod_formula + "' ");

        cabecera = " <table id='tb_formulacion'  class=' table-bordered compact' style='width:100%' >"
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
        int tonelada = 0;
        while (rs_GM.next()) {
            class_color = "text-right";
            class_color_abas = "text-right";

            if (rs_GM.getInt("costo_nuevo") < rs_GM.getInt("costo_actual")) {
                class_color = "text-down_bal";
            } else if (rs_GM.getInt("costo_nuevo") > rs_GM.getInt("costo_actual")) {
                class_color = "text-rojo_bal";
            }

            if (rs_GM.getInt("abastecimiento_nuevo") < 1) {
                class_color_abas = "text-rojo_bal";
            }

            grilla_html = grilla_html
                    + "<tr > "
                    + "<td   style=\"font-weight:bold\" > " + rs_GM.getString("descripcion") + "</td>"
                    + "<td  class='text-right'  style=\"font-weight:bold\">  " + formatea.format(rs_GM.getInt("costo")) + "</td>"
                    + "<td class='text-right' style=\"font-weight:bold\">  " + rs_GM.getFloat("toneladas_proyectadas") + "</td>"
                    + "<td class='text-right ' style=\"font-weight:bold\">  " + formatea.format(rs_GM.getFloat("stock")) + "</td>"
                    + "<td class='text-amarillo_bal' style=\"font-weight:bold\">  " + rs_GM.getString("cantidad_actual").replace(".", ",") + "</td>"
                    + "<td class='" + class_color + "' style=\"font-weight:bold\">  " + rs_GM.getString("cantidad_nueva").replace(".", ",") + "</td>"
                    + "<td class='  text-amarillo_bal' style=\"font-weight:bold \">  " + formatea.format(rs_GM.getFloat("consumo_mensual_actual_formula")) + "</td>"
                    + "<td class='  text-amarillo_bal' style=\"font-weight:bold \">  " + rs_GM.getString("abastecimiento_actual").replace(".", ",") + "  </td>"
                    + "<td class='text-amarilloOscuro_bal' style=\"font-weight:bold\">  " + formatea.format(rs_GM.getFloat("consumo_mensual_nuevo_formula")) + "</td>"
                    + "<td class='" + class_color_abas + "' style=\"font-weight:bold\">  " + rs_GM.getString("abastecimiento_nuevo").replace(".", ",") + "  </td>"
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

        String td_actual = "<i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i> Total costo actual(Gs/Kg)  : " + formatea.format(cantidad_actual / 1000);
        String td_nuevo = "<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i> Total costo nuevo(Gs/Kg)  :" + formatea.format(cantidad_nueva / 1000);
        String td_diferencia = "Disminución " + puntualOmensual + " : " + formatea.format((diferencia * tonelada)*1000) + "<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i>";
        if (cantidad_nueva > cantidad_actual) {
            td_actual = "<i class='nav-icon fas fa-arrow-circle-down text-blue' aria-hidden='true'></i> Total costo actual(Gs/Kg) : " + formatea.format(cantidad_actual / 1000);
            td_nuevo = "<i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i> Total costo nuevo(Gs/Kg)  :" + formatea.format(cantidad_nueva / 1000);
            //    td_diferencia= "Incremento  "+puntualOmensual +" : "+formatea.format(((cantidad_actual-cantidad_nueva)/1000)*tonelada)+" <i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i>" ;
            td_diferencia = "Incremento  " + puntualOmensual + " : " + formatea.format((diferencia * tonelada)*1000) + " <i class='nav-icon fas fa-arrow-circle-up text-red' aria-hidden='true'></i>";
        }

        ob.put("grilla", cabecera + grilla_html + "</tbody> "
                + "<tfoot>  "
                + "<tr class='bg-navy' > "
                + "<td></td> "
                + "<td></td> "
                + "<td style=\"font-weight:bold\"  class=' text-right'  > </td> "
                //   + "<td  >   </td> "
                + "<td  >   </td> "
                + "<td  >   </td> "
                + "<td></td> "
                + "<td></td> "
                // + "<td></td> "
                + "<td></td> "
                + "<td class=' text-right'  style=\"font-weight:bold\" > " + td_actual + "</td> "
                + "<td class=' text-right' style=\"font-weight:bold\" > " + td_nuevo + "</td> "
                + "<td  class=' text-right' style=\"font-weight:bold\" > " + td_diferencia + "</td> "
                + " </tr> </tfoot> </table>");
        ob.put("grilla_total", cabecera2 + grilla_html2 + "</tbody></table>");

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }


%> 