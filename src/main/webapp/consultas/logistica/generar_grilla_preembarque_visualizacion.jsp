<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %> 
<%@page contentType="application/json; charset=utf-8" %>

<%    
     String id_pedido = request.getParameter("id");

    try {

        ResultSet rs, rs2 ;
        Statement st, st2 ;
        st = connection.createStatement();
        st2 = connection.createStatement();
         String grilla_html = "";
         String grilla_html2 = "";

        String cabecera = "   "
                + "<table id='tb_preembarque'  class='  compact' style='width: 20%;'>"
                + "<thead>"
                + " <tr >"
                + " <th rowspan='1'     style='color: #fff; background:     black;' ><b> </b></th>  "
                + " <th rowspan='1'     style='color: #fff; background:     brown;font-weight:bold'  ><b></b></th>  "
                + " <th colspan='10' class='text-center'    id='th_ccha' style='color: #fff; background: black;'     ><b>    <a id='td_ccha'>CCHA TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='10' class='text-center'    id='th_cchb'  style='color: #fff; background: green;'     ><b>    <a id='td_cchb'>CCHB TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='10' class='text-center'    id='th_cchh' style='color: #fff; background: black;'     ><b>    <a id='td_cchh'>CCHH TOTAL CARGADOS:0   </a></b></th>   "
                + " <th colspan='8' class='text-center'     id='th_ovo'  style='color: #fff; background: green;'     ><b>    <a id='td_ovo'>LAVADOS TOTAL CARGADOS:0 </a></b></th>   "
                + " <th colspan='10' class='text-center'    id='th_cyo'  style='color: #fff; background: black;'     ><b>    <a id='td_cyo'>CYO TOTAL CARGADOS:0     </a></b></th>   "
                + "</tr>"
                + " <tr>"
                + " <th       style='color: #fff; background:     black;'   > Fecha puesta  </th>     "
                + " <th     style='color: #fff; background:     brown;font-weight:bold' >  Tipo  </th>       "
                + " <th  style='color: #fff; background: black;' >LIB   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;' >LIB   </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>LDO    </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>LIB    </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>Acep   </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>Invo   </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: green;'>Pal    </th>      <th  style='color: #fff; background: green;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>LIB    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Acep   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Invo   </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>LDO    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + " <th  style='color: #fff; background: black;'>Pal    </th>      <th  style='color: #fff; background: black;'>Cant</th>   "
                + "</tr>"
                + "</thead> <tbody >";
          
        String cabecera_mixto = "<div id='second'  style='width:50%'  '> "
                + " <table id='tb_preembarque_mixto' class='display compact' >"
                + "<thead>"
                + " <tr>"
                + "<th colspan='6'  style='color: #fff; background: black;'  class='text-center'  ><b>CARROS MIXTOS</b></th>  </tr>"
                + "<tr>"
                + "<th  style='color: #fff; background: black;'>CARRO</th>      "
                + "<th style='color: #fff; background: green;' >AREA</th>"
                + "<th style='color: #fff; background: green;' >PUESTA</th>"
                + "<th style='color: #fff; background: green;' >ACCION</th>"
                + "</tr>"
                + "</thead> <tbody > ";
        
        
        rs = st.executeQuery("exec mae_log_select_reserva_camion_modificacion_visualizacion  @id_pedido=" + id_pedido + "  ");

        
        
        while (rs.next()) {
            grilla_html = grilla_html + rs.getString("tr");
        }
 

      

        
    String query2="  "
                + " select "
                + "     *, case when estado<>'-' then 'SELECCIONADO' ELSE 'N/A' END AS estado_boton "
                + " from "
                + "(	"
                + "     select t0.*,isnull(t1.fecha_puesta,'-') AS estado "
                + "     from "
                + "(    "
		+ "     select "
		+ "         t1.fecha_puesta, clasificadora,cod_clasificacion,"
 		+ "         T1.cod_carrito"
		+ " 	from "
		+ " 		mae_log_ptc_cab_pedidos_historico t0 "
		+ " 		inner join mae_log_ptc_det_pedidos_historico t1 on t0.id=t1.id_cab  "
		+ " 		and cod_carrito<>0"
		+ " 	where "
		+ "         id_pedido="+id_pedido+"	 "
		+ " 	) t0 left outer join ("
		+ " 	select  "
		+ "         FORMAT (convert(date,t1.fecha_puesta), 'dd/MM/yyyy') as fecha_puesta ,area as clasificadora , "
		+ "         categoria as cod_clasificacion,"
 		+ "         T1.cod_carrito"
		+ " 	from "
		+ "         v_mae_log_historico_pedidos_log	t0  "
		+ "         INNER  join	mae_log_preembarque_reserva		t1 on	t0.id_pedido	=t1.id_pedido	"
		+ "         and t0.tipo_huevo	=t1.tipo_huevo"
		+ "         and t0.cod_carrito	=t1.cod_carrito"
		+ "         and t0.fecha_puesta	=t1.fecha_puesta"
		+ "         and t0.tipo			=t1.tipo				"	  
		+ "         and t0.clasificadora=t1.area	"
		+ " 	where "
		+ "         t0.id_pedido="+id_pedido +" "
 		+ "         and  t0.tipo_huevo  ='-'   ) t1	 "
		+ "         on t0.clasificadora=t1.clasificadora"
		+ "         and t0.fecha_puesta=t1.fecha_puesta"
		+ "         and t0.cod_clasificacion=t1.cod_clasificacion"
		+ "         and t0.cod_carrito=t1.cod_carrito"
 		+ " 	   ) t0";
  
        rs2 = st2.executeQuery(query2);
        while (rs2.next()) 
        {
            String boton="<div style='font-weight:bold' class='btn btn-dark btn-sm' >SELECCIONE</div>   ";
            
            if(rs2.getString("estado_boton").equals("SELECCIONADO")){
                boton="<div style='font-weight:bold' class='btn btn-danger btn-sm' >SELECCIONADO</div>   ";
            }
                grilla_html2 = grilla_html2
                        + "<tr>"
                        + "<td style='font-weight:bold' >" + rs2.getString("cod_carrito") + "</td>"
                        + "<td style='font-weight:bold'  >" + rs2.getString("clasificadora")  + "</td>"
                        + "<td style='font-weight:bold'  >" + rs2.getString("fecha_puesta")  + "</td>"
                        + "<td>"+boton+"</td> "
                        + "</tr>";
        }
        JSONObject ob = new JSONObject();
        ob = new JSONObject();
        ob.put("grilla", cabecera + grilla_html + "</tbody></table>");
        ob.put("grilla_mixto", cabecera_mixto + grilla_html2 + "</tbody></table>");
   
        out.print(ob);
    } catch (Exception e) {
        String as = e.getMessage();
    } finally {
        connection.close();
    }
%> 