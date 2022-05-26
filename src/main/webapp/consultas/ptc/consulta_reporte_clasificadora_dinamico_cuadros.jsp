
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<%    String fecha_desde_ptc = request.getParameter("fecha_desde_cla");
    String fecha_hasta_ptc = request.getParameter("fecha_hasta_cla");
    String tipo_grafico_ptc = request.getParameter("tipo_grafico_cla");
    String[] array_clasificadora_ptc = request.getParameterValues("clasif_cla");
    String[] array_categoria_ptc = request.getParameterValues("categorias2_cla");
    String serial3 = request.getParameter("serial2");
    String grilla_html = "";
    String cabecera = "  "
            + " <table id='datoscyo" + serial3 + "'  class='divinforme table table-bordered table-responsive order-column datoscyo' style='width:100%;height:40%'>"
            + "<thead>"
            + " <tr>"
            + " <th style='width:80%;height:40%' class='bg-navy card-header'>FECHA</th>"
            + "<th style='width:80%;height:40%' class='bg-navy card-header'>CLASIFICADORA</th>"
            + "<th style='width:80%;height:40%' class='bg-navy card-header'>PTC</th>"
            + "<th style='width:80%;height:40%' class='bg-navy card-header'>REPROCESO</th>"
            + "<th style='width:80%;height:40%' class='bg-navy card-header'>SUBPRODUCTO</th>"
            + "<th style='width:80%;height:40%' class='bg-navy card-header'>ROTOS</th>"
            + "<th style='width:80%;height:40%' class='bg-warning card-header'>PTC(%)</th>"
            + "<th style='width:80%;height:40%' class='bg-warning card-header'>REPROCESO(%)</th>"
            + "<th style='width:80%;height:40%' class='bg-warning card-header'>SUBPRODUCTO(%)</th>"
            + "<th style='width:80%;height:40%' class='bg-warning card-header'>ROTOS(%)</th>"
            + "</tr>"
            + "</thead> <tbody >";

    String clasificadora = "";
    boolean ptc = true;
    boolean rp = true;
    boolean pi = true;
    boolean r = true;

    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject charts_clasificadora = new JSONObject();

    try {

        for (int i = 0; i < array_clasificadora_ptc.length; i++) {
            if (array_clasificadora_ptc.length > 0) {
                if (i == 0) {
                    clasificadora = "'" + array_clasificadora_ptc[i] + "'";
                } else {
                    clasificadora = clasificadora + ",'" + array_clasificadora_ptc[i] + "'";
                }
            }
        }
        for (int i = 0; i < array_categoria_ptc.length; i++) {
            if (array_categoria_ptc[i].equals("ptcc")) {
                ptc = false;
            } else if (array_categoria_ptc[i].equals("rpp")) {
                rp = false;
            } else if (array_categoria_ptc[i].equals("pii")) {
                pi = false;
            } else if (array_categoria_ptc[i].equals("rr")) {
                r = false;
            }

        }

        String query = "select CASE WHEN clasificadora_origen='A' THEN 'CCHA' WHEN clasificadora_origen='B' THEN 'CCHB' WHEN clasificadora_origen='H' "
                + "THEN 'CCHH' WHEN clasificadora_origen='O' THEN 'LAVADOS' ELSE 'M' END AS ALIAS, FORMAT(fecha,'dd-MM') fecha,"
                + "por_PTC,por_RP,por_pi,por_ROTOS,clasificadora_origen from "
                + " v_mae_ptc_indicadores where clasificadora_origen in (" + clasificadora + ") and FECHA between '" + fecha_desde_ptc + "' and '" + fecha_hasta_ptc + "' order by fecha asc";

        PreparedStatement pt = clases.controles.connectSesion.prepareStatement(query);
        ResultSet rs = pt.executeQuery();

        JSONObject DataScale = new JSONObject();

        JSONObject contenidoData, dataOptions, data,
                Dataptc, Datapi, Datar, DataD, TitleD, ticksD, TitleA,
                Datarp,
                DataA, DataB, DataC,
                ticksA, ticksB,
                ticksC, TitleB,
                TitleC, ContenidoTitle,
                DataTitle, ContenidoPoint, DataPoint,
                Category = new JSONObject();

        JSONArray categories, Dataset, contenido_subcategorias,
                contenido_rp, contenido_ptc, contenido_r,
                contenido_pi,
                dataArray = new JSONArray();

        while (rs.next()) // va a recorrer 22 veces
        {
            String clasificadora2 = (clasificadora);

            Dataptc = new JSONObject();

            Dataptc.put("label", "PTC");
            Dataptc.put("type", tipo_grafico_ptc);
            Dataptc.put("yAxisID", "C");
            Dataptc.put("backgroundColor", "rgba(99, 255, 132)");
            Dataptc.put("borderColor", "rgba(99, 255, 132)");
            Dataptc.put("borderWidth", 2);
            Dataptc.put("hidden", ptc);

            Datarp = new JSONObject();

            Datarp.put("label", "REPROCESO");
            Datarp.put("type", tipo_grafico_ptc);
            Datarp.put("yAxisID", "B");
            Datarp.put("backgroundColor", "#ffcc00");
            Datarp.put("borderColor", "#ffcc00");
            Datarp.put("borderWidth", 2);
            Datarp.put("hidden", rp);

            Datapi = new JSONObject();

            Datapi.put("label", "SUBPRODUCTOS");
            Datapi.put("yAxisID", "A");
            Datapi.put("backgroundColor", "rgb(132, 132, 132)");
            Datapi.put("borderColor", "rgb(132, 132, 132)");
            Datapi.put("borderWidth", 2);
            Datapi.put("type", tipo_grafico_ptc);
            Datapi.put("hidden", pi);

            Datar = new JSONObject();

            Datar.put("label", "ROTOS");
            Datar.put("yAxisID", "D");
            Datar.put("backgroundColor", "rgb(255, 0, 186)");
            Datar.put("borderColor", "rgb(255, 0, 186)");
            Datar.put("borderWidth", 2);
            Datar.put("type", tipo_grafico_ptc);
            Datar.put("hidden", r);

            DataA = new JSONObject();
            DataA.put("type", "linear");
            DataA.put("display", true);
            DataA.put("position", "left");
            DataA.put("suggestedMin", 0);
            DataA.put("suggestedMax", 100);

            TitleA = new JSONObject();
            TitleA.put("display", true);
            TitleA.put("text", "SUBPRODUCTO");
            DataA.put("title", TitleA);
            ticksA = new JSONObject();
            ticksA.put("stepSize", 10);
            DataA.put("ticks", ticksA);

            DataB = new JSONObject();
            DataB.put("type", "linear");
            DataB.put("display", true);
            DataB.put("position ", "right");
            DataB.put("suggestedMin", 0);
            DataB.put("suggestedMax", 100);

            TitleB = new JSONObject();
            TitleB.put("display", true);
            TitleB.put("text", "REPROCESO");
            DataB.put("title", TitleB);
            ticksB = new JSONObject();
            ticksB.put("stepSize", 5);
            DataB.put("ticks", ticksB);

            DataC = new JSONObject();
            DataC.put("type", "linear");
            DataC.put("display", true);
            DataC.put("position", "right");
            DataC.put("suggestedMin", 0);
            DataC.put("suggestedMax", 100);

            TitleC = new JSONObject();
            TitleC.put("display", true);
            TitleC.put("text", "PTC");
            DataC.put("title", TitleC);
            ticksC = new JSONObject();
            ticksC.put("stepSize", 20);
            DataC.put("ticks", ticksC);

            DataD = new JSONObject();
            DataD.put("type", "linear");
            DataD.put("display", true);
            DataD.put("position", "right");
            DataD.put("suggestedMin", 0);
            DataD.put("suggestedMax", 15);
            TitleD = new JSONObject();
            TitleD.put("display", true);
            TitleD.put("text", "ROTOS");
            DataD.put("title", TitleD);
            ticksD = new JSONObject();
            ticksD.put("stepSize", 0.5);
            DataD.put("ticks", ticksD);

            ContenidoTitle = new JSONObject();
            ContenidoTitle.put("diplay", true);
            ContenidoTitle.put("text", clasificadora2);

            DataTitle = new JSONObject();
            DataTitle.put("title", ContenidoTitle);

            ContenidoPoint = new JSONObject();
            ContenidoPoint.put("radius", 0);

            DataPoint = new JSONObject();
            DataPoint.put("point", ContenidoPoint);

            contenido_subcategorias = new JSONArray();
            contenido_rp = new JSONArray();
            contenido_ptc = new JSONArray();
            contenido_pi = new JSONArray();
            contenido_r = new JSONArray();
            while (rs.next()) {
                // este recorre la cantidad de registros que hay en ese mes y en ese aviario

                contenido_subcategorias.put(rs.getString("fecha") + " " + rs.getString("alias"));
                contenido_ptc.put(rs.getString("por_PTC"));
                contenido_rp.put(rs.getString("por_RP"));
                contenido_pi.put(rs.getString("por_pi"));
                contenido_r.put(rs.getString("por_ROTOS"));

            } ////FIN DEL RECORRIDO LARGO

            categories = new JSONArray();
            categories.put(Category);

            Dataptc.put("data", contenido_ptc);
            Datarp.put("data", contenido_rp);
            Datapi.put("data", contenido_pi);
            Datar.put("data", contenido_r);

            Dataset = new JSONArray();
            Dataset.put(Dataptc);
            Dataset.put(Datarp);
            Dataset.put(Datapi);
            Dataset.put(Datar);
            contenidoData = new JSONObject();
            data = new JSONObject();

            contenidoData.put("labels", contenido_subcategorias);
            contenidoData.put("datasets", Dataset);

            DataScale.put("A", DataA);
            DataScale.put("B", DataB);
            DataScale.put("C", DataC);
            DataScale.put("D", DataD);

            data.put("data", contenidoData);

            data.put("type", tipo_grafico_ptc);
            dataOptions = new JSONObject();
            dataOptions.put("scales", DataScale);
            dataOptions.put("plugins", DataTitle);
            dataOptions.put("elements", DataPoint);

            data.put("options", dataOptions);

            dataArray.put(data);

        }
        DecimalFormat formatea = new DecimalFormat("###,###.##");

        PreparedStatement pt2 = clases.controles.connectSesion.prepareStatement("select CASE WHEN clasificadora_origen='A' THEN 'CCHA' WHEN clasificadora_origen='B' THEN 'CCHB' WHEN clasificadora_origen='H' "
                + "THEN 'CCHH' WHEN clasificadora_origen='O' THEN 'LAVADOS' ELSE 'M' END AS ALIAS, FORMAT(fecha,'dd-MM')fecha,r,rp,ptc,pi,"
                + "por_PTC,por_RP,por_pi,por_ROTOS,clasificadora_origen "
                + "from v_mae_ptc_indicadores where clasificadora_origen   in(" + clasificadora + "  ) "
                + " and FECHA between '" + fecha_desde_ptc + "' and '" + fecha_hasta_ptc + "' order by fecha asc ");//CONSULTA DE GRILLA
        ResultSet rs2 = pt2.executeQuery();
        while (rs2.next()) {

            grilla_html = grilla_html + 
                    "<tr>"
                    + "<td style= 'text-align:center;'>"+ rs2.getString("fecha") + " </td> "
                    + "<td style= 'text-align:center';>  " + rs2.getString("ALIAS") + "  </td>"
                    + "<td style= 'text-align:center';>  " + formatea.format(rs2.getInt("ptc")) + "  </td>"
                    + "<td style= 'text-align:center';>  " + formatea.format(rs2.getInt("rp")) + "  </td>"
                    + "<td style= 'text-align:center';>  " + formatea.format(rs2.getInt("pi")) + "  </td>"
                    + "<td style= 'text-align:center';>  " + formatea.format(rs2.getInt("r")) + "  </td>"
                    + "<td style= 'text-align:center';>  " + rs2.getString("por_PTC") + "%" + "  </td>"
                    + "<td style= 'text-align:center';>  " + rs2.getString("por_RP") + "%" + "  </td>"
                    + "<td style= 'text-align:center';>  " + rs2.getString("por_pi") + "%" + "  </td>"
                    + "<td style= 'text-align:center';>  " + rs2.getString("por_ROTOS") + "%" + "  </td>"
                    + "</tr>";

            clasificadora = rs2.getString("clasificadora_origen");
        }

        charts_clasificadora.put("charts_clasificadora", dataArray);
        charts_clasificadora.put("totales", dataArray);
        charts_clasificadora.put("grillas", cabecera + grilla_html + "</tbody></table>");

    } catch (Exception e) {

        String me = e.getMessage();
    } finally {
        clases.controles.DesconnectarBDsession();
        out.print(charts_clasificadora);
    }

%>

