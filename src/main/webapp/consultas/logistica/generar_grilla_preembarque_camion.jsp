<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page session="true" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>
<%
    String id_camion = request.getParameter("id_camion");
    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
    try {

        ResultSet rs, rs2, rs3, rs5, rs_c ;
        String grilla_html = "";

        String cabecera = "   "
                + "<table id='tb_preembarque'  class='display compact'   >"
                + "<thead>"
                + " <tr >"
                + " <th rowspan='1'     style='color: #fff; background:     black;' ><b> </b></th>  "
                + " <th rowspan='1'     style='color: #fff; background:     brown;font-weight:bold'  ><b></b></th>  "
                + " <th colspan='15' class='text-center'    id='th_ccha' style='color: #fff; background: black;'     ><b>    <a id='td_ccha'>CCHA TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='15' class='text-center'    id='th_cchb'  style='color: #fff; background: green;'     ><b>    <a id='td_cchb'>CCHB TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='15' class='text-center'    id='th_cchh' style='color: #fff; background: black;'     ><b>    <a id='td_cchh'>CCHH TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='12' class='text-center'     id='th_ovo'  style='color: #fff; background: green;'     ><b>    <a id='td_ovo'>LAVADOS TOTAL CARGADOS:0 </a></b></th>   "
                + " <th colspan='15' class='text-center'    id='th_cyo'  style='color: #fff; background: black;'     ><b>    <a id='td_cyo'>CYO TOTAL CARGADOS:0     </a></b></th>   "
                + "</tr>"
                + " <tr>"
                + " <th       style='color: #fff; background:     black;'   > Fecha puesta  </th>     "
                + " <th     style='color: #fff; background:     brown;font-weight:bold' >  Tipo  </th>       "
                + " <th  style='color: #fff; background: black;' >LIB   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: green;' >LIB   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>LDO    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>LIB    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>   <th  style='color: #fff; background: green;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   <th  style='color: #fff; background: black;'>Res</th>"
                + "</tr>"
                + "</thead> <tbody >";
        rs = fuente.obtenerDato("exec mae_log_select_reserva_camion @id_camion=" + id_camion + "  ");

        while (rs.next()) {
            grilla_html = grilla_html + rs.getString("tr");
        }

        rs2 = fuente.obtenerDato("      select id_camion from mae_log_preembarque_reserva where estado=1  group by id_camion ");

        JSONArray ob3 = new JSONArray();
        ob3 = new JSONArray();
        while (rs2.next()) {
            ob3.put(rs2.getString("id_camion"));
        }

        rs3 = fuente.obtenerDato("   select case tipo_huevo when 'A' THEN 1 when 'B' THEN 2 when 'C' THEN 3 when 'D' THEN 4 when 'S' THEN 5 when 'J' THEN 6 when 'M' then 7 END AS tipo_id,cantidad "
                + "  from mae_log_cabecera_totales where id_camion=" + id_camion + " and id_estado=1");
        JSONObject ob4 = new JSONObject();
        JSONArray ob5 = new JSONArray();
        while (rs3.next()) {
            ob4 = new JSONObject();

            ob4.put("cantidad", rs3.getString("cantidad"));
            ob4.put("id", rs3.getString("tipo_id"));
            ob5.put(ob4);
        }

        rs5 = fuente.obtenerDato("      select cod_carrito from mae_log_preembarque_reserva where estado=1 and cod_carrito<>0 and id_camion=" + id_camion + "");

        JSONArray ob_mixtos = new JSONArray();
        ob_mixtos = new JSONArray();
        while (rs5.next()) {
            ob_mixtos.put(rs5.getString("cod_carrito"));
        }
        
        
          rs_c = fuente.obtenerDato("select CASE cantidad  WHEN 0 THEN count(*)  ELSE  sum(cantidad) end as cantidad, case tipo_huevo when '-' then 'M' else tipo_huevo end as tipo_huevo"
                  + " from mae_log_preembarque_reserva where estado in (1)   group by tipo_huevo,cantidad");
        JSONObject ob_carros_total_camion = new JSONObject();
        JSONArray ob_carros_total_camion_Arr = new JSONArray();
        ob_carros_total_camion = new JSONObject();
        while (rs_c.next()) 
        {
            ob_carros_total_camion = new JSONObject();
            ob_carros_total_camion.put("cantidad",rs_c.getString("cantidad"));
            ob_carros_total_camion.put("tipo_huevo","txt_tipo_"+rs_c.getString("tipo_huevo")+"t");
            ob_carros_total_camion_Arr.put(ob_carros_total_camion);

        }

        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        ob.put("grilla", cabecera + grilla_html + "</tbody></table>");
        ob.put("select", ob3);
        ob.put("totales_cabecera", ob5);
        ob.put("mixtos_seleccionados", ob_mixtos);
        ob.put("carros_camiones", ob_carros_total_camion_Arr);

        out.print(ob);
    } catch (Exception e) {
    } finally {
        clases.controles.DesconnectarBD();
    }
%> 