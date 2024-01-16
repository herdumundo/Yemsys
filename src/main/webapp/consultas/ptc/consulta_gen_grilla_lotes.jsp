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
    String cabecera = "";
    try {
        String fechaDesde = request.getParameter("fechaDesde");
        String fechaHasta = request.getParameter("fechaHasta");

        ResultSet rs;
        Statement st = connection.createStatement();
        rs = st.executeQuery("SELECT TOP (1000) [cod_interno]"
                + ",[fecha_registro]"
                + ",[fecha_modificacion]"
                + ",[fecha]"
                + ",[fecha_puesta]"
                + ",[cod_carrito]"
                + ",[tipo_huevo]"
                + ",[cod_clasificacion]"
                + ",[hora_clasificacion]"
                + ",[cod_lote]"
                + ",[resp_clasificacion]"
                + ",[resp_control_calidad]"
                + ",[usuario_upd]"
                + ",[u_medida]"
                + ",[cantidad]"
                + ",[clasificadora]"
                + ",[clasificadora_actual]"
                + ",[empacadora]"
                + ",[aviario]"
                + ",[tipo_almacenamiento]"
                + ",[liberado_por]"
                + ",[comentario]"
                + ",[zona_falla]"
                + ",[cod_cambio]"
                + ",[codigo_borroso]"
                + ",[tipo_maples]"
                + ",[codigo_especial]"
                + ",[fecha_vieja]"
                + ",[estado_liberacion]"
                + ",[estado]"
                + ",[codigo_cepillado]"
                + ",[hora_inicio]"
                + ",[hora_fin]"
                + ",[clasificadora_origen]"
                + ",[alimentado]"
                + ",[tipo_recogida]"
                + ",[fecha_alimentacion]"
                + ",[fecha_involucrada]"
                + ",[aviarios_involucrados]"
                + ",[fecha_embarque]"
                + "FROM[GrupoMaehara].[dbo].[lotes] "
                + "WHERE CONVERT(date,fecha_registro) BETWEEN '"+fechaDesde+"' AND '"+fechaHasta+"'");        
         

        cabecera = " <table id='tb_informe_lotes' data-row-style=\"rowStyle\" class=\"display\" data-toggle=\"table\" data-click-to-select=\"true\">"
                + "<thead>"
                + "<tr>"
                + " <th>cod_interno</th>"
                + " <th>fecha_registro</th>"
                + " <th>fecha_modificacion</th>"
                + " <th>fecha</th>"
                + " <th>fecha_puesta</th>"
                + " <th>cod_carrito</th>"
                + " <th>tipo_huevo</th>"
                + " <th>cod_clasificacion</th>"
                + " <th>hora_clasificacion</th>"
                + " <th>cod_lote</th>"
                + " <th>resp_clasificacion</th>"
                + " <th>resp_control_calidad</th>"
                + " <th>usuario_upd</th>"
                + " <th>u_medida</th>"
                + " <th>cantidad</th>"
                + " <th>clasificadora</th>"
                + " <th>clasificadora_actual</th>"
                + " <th>empacadora</th>"
                + " <th>aviario</th>"
                + " <th>tipo_almacenamiento</th>"
                + " <th>liberado_por</th>"
                + " <th>comentario</th>"
                + " <th>zona_falla</th>"
                + " <th>cod_cambio</th>"
                + " <th>codigo_borroso</th>"
                + " <th>tipo_maples</th>"
                + " <th>codigo_especial</th>"
                + " <th>fecha_vieja</th>"
                + " <th>estado_liberacion</th>"
                + " <th>estado</th>"
                + " <th>codigo_cepillado</th>"
                + " <th>hora_inicio</th>"
                + " <th>hora_fin</th>"
                + " <th>clasificadora_origen</th>"
                + " <th>alimentado</th>"
                + " <th>tipo_recogida</th>"
                + " <th>fecha_alimentacion</th>"
                + " <th>fecha_involucrada</th>"
                + " <th>aviarios_involucrados</th>"
                + " <th>fecha_embarque</th>"
                + "</tr>"
                + " </thead> "
                + " <tbody >";
        while (rs.next()) {
            grilla_html = grilla_html
                    + "<tr >"
                    + "<td>" + rs.getString("cod_interno") + "</td>"
                    + "<td>" + rs.getString("fecha_registro") + "</td>"
                    + "<td>" + rs.getString("fecha_modificacion") + "</td>"
                    + "<td>" + rs.getString("fecha") + "</td>"
                    + "<td>" + rs.getString("fecha_puesta") + "</td>"
                    + "<td>" + rs.getString("cod_carrito") + "</td>"
                    + "<td>" + rs.getString("tipo_huevo") + "</td>"
                    + "<td>" + rs.getString("cod_clasificacion") + "</td>"
                    + "<td>" + rs.getString("hora_clasificacion") + "</td>"
                    + "<td>" + rs.getString("cod_lote") + "</td>"
                    + "<td>" + rs.getString("resp_clasificacion") + "</td>"
                    + "<td>" + rs.getString("resp_control_calidad") + "</td>"
                    + "<td>" + rs.getString("usuario_upd") + "</td>"
                    + "<td>" + rs.getString("u_medida") + "</td>"
                    + "<td>" + rs.getString("cantidad") + "</td>"
                    + "<td>" + rs.getString("clasificadora") + "</td>"
                    + "<td>" + rs.getString("clasificadora_actual") + "</td>"
                    + "<td>" + rs.getString("empacadora") + "</td>"
                    + "<td>" + rs.getString("aviario") + "</td>"
                    + "<td>" + rs.getString("tipo_almacenamiento") + "</td>"
                    + "<td>" + rs.getString("liberado_por") + "</td>"
                    + "<td>" + rs.getString("comentario") + "</td>"
                    + "<td>" + rs.getString("zona_falla") + "</td>"
                    + "<td>" + rs.getString("cod_cambio") + "</td>"
                    + "<td>" + rs.getString("codigo_borroso") + "</td>"
                    + "<td>" + rs.getString("tipo_maples") + "</td>"
                    + "<td>" + rs.getString("codigo_especial") + "</td>"
                    + "<td>" + rs.getString("fecha_vieja") + "</td>"
                    + "<td>" + rs.getString("estado_liberacion") + "</td>"
                    + "<td>" + rs.getString("estado") + "</td>"
                    + "<td>" + rs.getString("codigo_cepillado") + "</td>"
                    + "<td>" + rs.getString("hora_inicio") + "</td>"
                    + "<td>" + rs.getString("hora_fin") + "</td>"
                    + "<td>" + rs.getString("clasificadora_origen") + "</td>"
                    + "<td>" + rs.getString("alimentado") + "</td>"
                    + "<td>" + rs.getString("tipo_recogida") + "</td>"
                    + "<td>" + rs.getString("fecha_alimentacion") + "</td>"
                    + "<td>" + rs.getString("fecha_involucrada") + "</td>"
                    + "<td>" + rs.getString("aviarios_involucrados") + "</td>"
                    + "<td>" + rs.getString("fecha_embarque") + "</td>"
                    + "</tr>";

        }

        ob.put("grilla", cabecera + grilla_html + "</tbody></table>");

        rs.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());
    } finally {
        connection.close();
        out.print(ob);
    }
%>


