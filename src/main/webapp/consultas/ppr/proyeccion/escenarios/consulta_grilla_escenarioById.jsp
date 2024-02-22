<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="../../../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../../cruds/conexion.jsp" %>
<%    StringBuilder tabla = new StringBuilder();
    StringBuilder tablaLotes = new StringBuilder();
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    JSONObject ob = new JSONObject();
    String option = "";
    String option2 = "";
    String optionCalculoProduccion = "";
    String optionPadronProduccion = "";

    try {

        PreparedStatement pstLotes = connection.prepareStatement("select * from ppr_pry_lotes where escenario_id='" + id + "'");
        ResultSet rsLotes = pstLotes.executeQuery();

        PreparedStatement pst = connection.prepareStatement("select isnull(p_parametro_general,0) as p_parametro_general,isnull(m_parametro_general,0) as m_parametro_general,p_padron_id,m_padron_id ,escenario_id,raza_name,escenario_nombre,periodo,calculo_mortandad,padron_mortandad, ISNULL(m_recria,0) as m_recria, ISNULL(m_produccion_primaria,0) as m_produccion_primaria , ISNULL(m_pre_descarte,0) as m_pre_descarte , ISNULL(calculo_produccion,0) as calculo_produccion , ISNULL(padron_produccion,0) as padron_produccion, ISNULL(p_recria,0) as p_recria, ISNULL(p_produccion_primaria,0) as p_produccion_primaria, ISNULL(p_pre_descarte,0) as p_pre_descarte,cantidad_venta from v_ppr_escenario_det  where escenario_id=" + id + " ");
        ResultSet rs = pst.executeQuery();
        tabla.append("<table id='grillaEscenarioById' class='tabla tabla-con-borde table-striped table-condensed compact hover dataTable'>");
        tabla.append("<thead>");
        tabla.append("<tr>");
        // Añadir el encabezado que abarca todas las columnas y centrarlo
        tabla.append("<th colspan='16' style='text-align: center;'>" + nombre + "</th>");
        tabla.append("</tr>");
        tabla.append("<tr>");
        tabla.append("<th>Nro. Escenario</th>");
        tabla.append("<th>Raza</th>");
        tabla.append("<th>Periodo</th>");
        tabla.append("<th class='anchoGrilla'>Calculo Mortandad</th>");
        tabla.append("<th class='anchoGrilla' >Padron Mortandad</th>");
        tabla.append("<th>Parametro General</th>");
        tabla.append("<th>Mortandad Recria</th>");
        tabla.append("<th>Mortandad Produccion Primaria</th>");
        tabla.append("<th>Mortandad Pre descarte</th>");
        tabla.append("<th class='anchoGrilla'>Calculo Produccion</th>");
        tabla.append("<th class='anchoGrilla' >Padron Produccion</th>");
        tabla.append("<th>Parametro General</th>");
        tabla.append("<th>Produccion Recria</th>");
        tabla.append("<th>Produccion Produccion Primaria</th>");
        tabla.append("<th>Produccion Pre descarte</th>");
        tabla.append("<th>Cantidad de Ventas</th>");
        tabla.append("</tr>");
        tabla.append("</thead>");
        tabla.append("<tbody>");

        while (rs.next()) {
            String idPadronMortandad = rs.getString("m_padron_id");
            String idPadronProductividad = rs.getString("p_padron_id");

            if (idPadronMortandad == null) {
                idPadronMortandad = "1";
            }
            if (idPadronProductividad == null) {
                idPadronProductividad = "1";
            }

            PreparedStatement pstCalculoMortandad = connection.prepareStatement(" select * from ppr_tipo_calculo  ORDER BY CASE WHEN id = " + rs.getString("calculo_mortandad") + " THEN 0 ELSE 1 END, id");
            ResultSet rsCalculoMortandad = pstCalculoMortandad.executeQuery();

            PreparedStatement pstPadronMortandad = connection.prepareStatement(" select * from ppr_padrones   ORDER BY CASE WHEN padron_id = " + idPadronMortandad + "  THEN 0 ELSE 1 END, padron_id    ");
            ResultSet rsPadronMortandad = pstPadronMortandad.executeQuery();

            PreparedStatement pstCalculoProduccion = connection.prepareStatement(" select * from ppr_tipo_calculo  ORDER BY CASE WHEN id = " + rs.getString("calculo_produccion") + " THEN 0 ELSE 1 END, id ");
            ResultSet rsCalculoProduccion = pstCalculoProduccion.executeQuery();

            PreparedStatement pstPadronProduccion = connection.prepareStatement(" select * from ppr_padrones ORDER BY CASE WHEN padron_id = " + idPadronProductividad + "  THEN 0 ELSE 1 END, padron_id ");
            ResultSet rsPadronProduccion = pstPadronProduccion.executeQuery();

            while (rsCalculoMortandad.next()) {
                option = option + "<option value='" + rsCalculoMortandad.getString("id") + "'>" + rsCalculoMortandad.getString("descripcion") + "</option>";
            }

            while (rsPadronMortandad.next()) {
                option2 = option2 + "<option value='" + rsPadronMortandad.getString("padron_id") + "'>" + rsPadronMortandad.getString("padron_nombre") + "</option>";
            }

            while (rsCalculoProduccion.next()) {
                optionCalculoProduccion = optionCalculoProduccion + "<option value='" + rsCalculoProduccion.getString("id") + "'>" + rsCalculoProduccion.getString("descripcion") + "</option>";
            }

            while (rsPadronProduccion.next()) {
                optionPadronProduccion = optionPadronProduccion + "<option value='" + rsPadronProduccion.getString("padron_id") + "'>" + rsPadronProduccion.getString("padron_nombre") + "</option>";
            }

            tabla.append("<tr>");
            tabla.append("<td>").append("<input type='text'readonly id='idEscenario" + rs.getString("escenario_id") + "' value='" + rs.getString("escenario_id") + "'>").append("</td>");
            tabla.append("<td  class=\"single_line2\"   >").append(rs.getString("raza_name")).append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append(rs.getString("periodo")).append("</td>");

            tabla.append("<td   class=\"single_line2 anchoGrilla\"  >").append("<select  id='calculoMortandad" + rs.getString("escenario_id") + "' class='form-control'>" + option + "</select>").append("</td>");
            tabla.append("<td   class=\"single_line2 anchoGrilla\"  >").append("<select  id='padronMortandad" + rs.getString("escenario_id") + "' class='form-control'>" + option2 + "</select>").append("</td>");

            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='mpg" + rs.getString("escenario_id") + "'  value='" + rs.getString("m_parametro_general") + "'>").append("</td>");

            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='pmr" + rs.getString("escenario_id") + "' value='" + rs.getString("m_recria") + "'>").append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='pmp" + rs.getString("escenario_id") + "' value='" + rs.getString("m_produccion_primaria") + "'>").append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='pmpred" + rs.getString("escenario_id") + "' value='" + rs.getString("m_pre_descarte") + "'>").append("</td>");

            tabla.append("<td   class=\"single_line2 anchoGrilla\"  >").append("<select id='calculoProduccion" + rs.getString("escenario_id") + "' class='form-control'>" + optionCalculoProduccion + "</select>").append("</td>");
            tabla.append("<td   class=\"single_line2 anchoGrilla\"  >").append("<select id='padronProduccion" + rs.getString("escenario_id") + "' class='form-control'>" + optionPadronProduccion + "</select>").append("</td>");

            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='ppg" + rs.getString("escenario_id") + "' value='" + rs.getString("p_parametro_general") + "'>").append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='ppr" + rs.getString("escenario_id") + "' value='" + rs.getString("p_recria") + "'>").append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='ppp" + rs.getString("escenario_id") + "' value='" + rs.getString("p_produccion_primaria") + "'>").append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<input type='text' id='ppredp" + rs.getString("escenario_id") + "' value='" + rs.getString("p_pre_descarte") + "'>").append("</td>");
            tabla.append("<td   class=\"single_line2\"  >").append("<input type='number' id='pprVenta" + rs.getString("escenario_id") + "' value='"+rs.getInt("cantidad_venta")+"'>").append("</td>");
            tabla.append("</tr>");
            tabla.append("</tbody>");
            tabla.append("</table> <input type=\"button\" class=\"btn bg-warning\" value=\"Actualizar datos\" onclick=\"registrarCambiosEscenario("
                    + "$('#idEscenario" + rs.getString("escenario_id") + "').val(),"
                    + "$('#calculoMortandad" + rs.getString("escenario_id") + "').val(), "
                    + "$('#padronMortandad" + rs.getString("escenario_id") + "').val(), "
                    + "$('#mpg" + rs.getString("escenario_id") + "').val(),"
                    + "$('#pmr" + rs.getString("escenario_id") + "').val(), "
                    + "$('#pmp" + rs.getString("escenario_id") + "').val(),"
                    + "$('#pmpred" + rs.getString("escenario_id") + "').val(), "
                    + "$('#calculoProduccion" + rs.getString("escenario_id") + "').val(), "
                    + "$('#padronProduccion" + rs.getString("escenario_id") + "').val(), "
                    + "$('#ppg" + rs.getString("escenario_id") + "').val(), "
                    + "$('#ppr" + rs.getString("escenario_id") + "').val(), "
                    + "$('#ppp" + rs.getString("escenario_id") + "').val(), "
                    + "$('#ppredp" + rs.getString("escenario_id") + "').val(),"
                    + "$('#pprVenta" + rs.getString("escenario_id") + "').val()"
                    + ")\">");

        }

        tablaLotes.append("<br><table  style=\"width: 100%\" class='table-bordered compact'>");
        tablaLotes.append("<thead class='bg-navy'>");
        tablaLotes.append("<tr>");
        tablaLotes.append("<th colspan='7' style='text-align: center;'><input type='button' value='Nuevo Lote' class='form-control btn bg-navy' onclick='abrir_crear_lote_proyeccion_ppr()'></th>");
        tablaLotes.append("</tr>");
        tablaLotes.append("<tr>");
        tablaLotes.append("<th>Lote</th>");
        tablaLotes.append("<th>Aviario</th>");
        tablaLotes.append("<th>Cantidad Aves</th>");
        tablaLotes.append("<th>Edad a produccion(Dias)</th>");
        tablaLotes.append("<th>Edad a produccion(Semanas)</th>");
        tablaLotes.append("<th>Edad a Pre-descarte(Dias)</th>");
        tablaLotes.append("<th>Edad a Pre-descarte(Semanas)</th>");
        tablaLotes.append("</tr>");
        tablaLotes.append("</thead>");
        tablaLotes.append("<tbody>");

        while (rsLotes.next()) {
            tablaLotes.append("<tr>");
            tablaLotes.append("<td>").append(rsLotes.getString("lote")).append("</td>");
            tablaLotes.append("<td>").append(rsLotes.getString("aviario")).append("</td>");
            tablaLotes.append("<td>").append(rsLotes.getString("cantidad_aves")).append("</td>");
            tablaLotes.append("<td>").append(rsLotes.getString("edad_produccion_dias")).append("</td>");
            tablaLotes.append("<td>").append(rsLotes.getString("edad_produccion_semanas")).append("</td>");
            tablaLotes.append("<td>").append(rsLotes.getString("edad_descarte_dias")).append("</td>");
            tablaLotes.append("<td>").append(rsLotes.getString("edad_descarte_semanas")).append("</td>");
            tablaLotes.append("</tr>");
        }
        tablaLotes.append("</tbody>");
        tablaLotes.append("</table>");

        rsLotes.close();
        pstLotes.close();

        rs.close();
        pst.close();
    } catch (SQLException e) {
        // Manejo de excepciones (opcional)
        ob.put("grilla", e.toString());
    }

    ob.put("grilla", tabla.toString());
    ob.put("grillaLotes", tablaLotes.toString());
    out.println(ob);
%>
