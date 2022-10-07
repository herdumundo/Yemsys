<%@page import="org.json.JSONObject"%> 
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    
    JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
    try {
        
        String id = request.getParameter("id");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        
        rs_GM = st.executeQuery("       select  "
                            +"      	   	t0.cantidad as Stock,"
                            +"      		case  when  t1.cantidad is null then 0 "
                            +"      		when t1.cantidad=0 then 1"
                            +"      		else  t1.cantidad  end as  cargado,	"	 
                            +"      		t0.fecha_puesta,"
                            +"      		case when t0.tipo_huevo='-' then 'MIXTO' ELSE t0.tipo_huevo END AS tipo_huevo,"
                            +"                  clasificadora,t0.cod_clasificacion,t0.tipo,t0.cod_carrito  "
                            +"          from "
                            +"                  v_mae_log_historico_pedidos_log	t0  "
                            +"      		left outer  join	mae_log_preembarque_reserva		t1 "
                            +"      		on	t0.id_pedido	=t1.id_pedido	"
                            +"      		and t0.tipo_huevo	=t1.tipo_huevo"
                            +"      		and t0.cod_carrito	=t1.cod_carrito"
                            +"      		and t0.fecha_puesta	=t1.fecha_puesta"
                            + "                 and t0.tipo			=t1.tipo	"				  
                            + "                 and t0.clasificadora=t1.area	"
                            + "                 and (estado_descripcion is null or estado_descripcion='MODIFICADO POR LOGISTICA')"
                            + "         where "
                            + "                 t0.id_pedido="+id+"	   "
                            + "                 and t0.cantidad>0 order by clasificadora ");

      
        
        
        cabecera = " <table id='tb_grilla_det'  class=' table-bordered compact display' style='width:100%' >"
                + "<thead>"
                + "     <tr> "
                + "         <th colspan='11' class='text-center'   style='color: #fff; background: green;' >Nro. pedido "+id+"  <button class='btn btn-xs bg-yellow' onclick='ir_pedido_log_vizualizacion_log("+id+")' data-toggle='modal' data-target='#exampleModalPreview' title='Visualizar modificaciones'><i class='fa fa-eye'  ></i></button></th>   "
                + "     </tr> "
                + "     <tr>"
                + "         <th class='text-center' style='color: #fff; background: green;' >Fecha puesta                         </th>   "
                + "         <th class='text-center' style='color: #fff; background: green;' > Categoria      </th>   "
                + "         <th class='text-center' style='color: #fff; background: green;' >   Tipo huevo   </th>   "
                + "         <th class='text-center' style='color: #fff; background: green;' >Tipo   </th>   "
                + "         <th class='text-center' style='color: #fff; background: green;' >Stock  </th>   " 
                + "         <th class='text-center' style='color: #fff; background: green;' >Cargado  </th>   " 
                + "         <th class='text-center' style='color: #fff; background: green;' >Clasificadora     </th>   "
                + "         <th class='text-center' style='color: #fff; background: green;' >Cod carrito     </th>   "
                + "     </tr>"
                + "</thead> "
                + "<tbody >";
        String td="";
         while (rs_GM.next()) {
             td=rs_GM.getString("cargado");
             String tipo_huevo=rs_GM.getString("tipo_huevo");
           if( rs_GM.getInt("cargado")>0&& !tipo_huevo.equals("MIXTO") ){
               td=" <h6><span class='badge badge-dark right'>" + rs_GM.getString("cargado") + "</span></h6> ";
           }
           else  if( rs_GM.getInt("cargado")>0&&tipo_huevo.equals("MIXTO"))
               {
               td=" <h6><span class='badge badge-danger right'>" + rs_GM.getString("cargado") + "</span></h6> ";
           }
            
            grilla_html = grilla_html
                    + " <tr>   "
                    + "     <td class='text-center'    style=\"font-weight:bold;\"  > " + rs_GM.getString("fecha_puesta") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("cod_clasificacion") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > Tipo " + rs_GM.getString("tipo_huevo") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("tipo") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("stock") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold;\" >"+td+"</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("clasificadora") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("cod_carrito") + "</td>"
                    + " </tr>";

           
        } 
 
        ob.put("grilla", cabecera + grilla_html+ "</tbody></table>");

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }


%> 