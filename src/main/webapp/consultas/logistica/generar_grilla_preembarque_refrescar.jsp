<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%> 
<%@ page session="true" %>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %> 
<%   
    String id_camion = request.getParameter("id_camion");
    Statement st,st2,st3,st4,st5,st6,st7;
    ResultSet rs, rs2, rs3, rs5,rsRef, rsHora,rs7;
    st = connection.createStatement();
    st2 = connection.createStatement();
    st3 = connection.createStatement();
    st4 = connection.createStatement();
    st5 = connection.createStatement();
    st6 = connection.createStatement();
    st7 = connection.createStatement();
    
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    JSONArray ob3 = new JSONArray();
    ob3 = new JSONArray();
    JSONObject ob4 = new JSONObject();
    JSONArray ob5 = new JSONArray();
    JSONArray ob_mixtos = new JSONArray();
    ob_mixtos = new JSONArray();
    String cabecera = "";
    String grilla_html = "";
    String fecha_consulta = "";

    try {

        cabecera = "   "
                + "<table id='tb_preembarque' class='compact' style='width: 20%;'>"
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

        rsRef   = st6.executeQuery("    exec mae_log_stock_pedidos_maehara_3    @tipo=1,  @id_pedido=0 "); //REFRESCA TODO EL STOCK PARA VISUALIZAR EN PANTALLA DE PEDIDO.

        
        
        
        rsHora = st.executeQuery(" select getdate() as fecha_consulta ");
        while (rsHora.next()) {
            fecha_consulta = rsHora.getString("fecha_consulta");
        }

       
        rs = st2.executeQuery("exec mae_log_select_reserva_camion @id_camion=" + id_camion + "  ");

        while (rs.next()) {
            grilla_html = grilla_html + rs.getString("tr");
        }

        rs2 = st3.executeQuery("      select  id_camion from mae_log_preembarque_reserva where estado=1  group by id_camion ");

        while (rs2.next()) {
            ob3.put(rs2.getString("id_camion"));
        }

        rs3 = st4.executeQuery("   select case tipo_huevo when 'A' THEN 1 when 'B' THEN 2 when 'C' THEN 3 when 'D' THEN 4 when 'S' THEN 5 when 'J' THEN 6 when 'M' then 7 END AS tipo_id,cantidad "
                + "  from mae_log_cabecera_totales where id_camion=" + id_camion + " and id_estado=1");

        while (rs3.next()) {
            ob4 = new JSONObject();

            ob4.put("cantidad", rs3.getString("cantidad"));
            ob4.put("id", rs3.getString("tipo_id"));
            ob5.put(ob4);
        }

        rs5 = st5.executeQuery("      select cod_carrito from mae_log_preembarque_reserva where estado=1 and cod_carrito<>0 and id_camion=" + id_camion + "");

        while (rs5.next()) {
            ob_mixtos.put(rs5.getString("cod_carrito"));
        }

 
         ob.put("grilla", cabecera + grilla_html + "</tbody></table>");
        ob.put("select", ob3);
        ob.put("totales_cabecera", ob5);
        ob.put("mixtos_seleccionados", ob_mixtos);
        ob.put("fecha_consulta", fecha_consulta);
         out.print(ob);
    } catch (Exception e) 
    {
        ob.put("grilla",e.getMessage());
        ob.put("select", e.getMessage());
        ob.put("totales_cabecera", e.getMessage());
        ob.put("mixtos_seleccionados", e.getMessage());
        ob.put("fecha_consulta", e.getMessage());
         out.print(ob);
    } finally {
      
        connection.close();
    }
%> 