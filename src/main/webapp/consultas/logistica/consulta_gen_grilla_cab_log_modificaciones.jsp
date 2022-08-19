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
        
        String desde = request.getParameter("fecha_desde");
        String hasta = request.getParameter("fecha_hasta");
         
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        
        rs_GM = st.executeQuery("   select                                                                                                  "
                + "                     t0.id,t0.fecha_registro,id_camion,cantidad,nombre,                                                  "   
                + "                     t2.descripcion as estado,nro_factura,t3.Name,t4.areas                                               "
                + "                 from                                                                                                    "
                + "                     mae_log_ptc_cab_pedidos                     t0                                                      "
                + "                     inner join usuarios                         t1 on t0.id_usuario=t1.cod_usuario                      "
                + "                     inner join mae_log_ptc_estados              t2 on t0.estado=t2.id                                   "
                + "                     inner join maehara.dbo.[@CHOFERES]          t3 on t0.id_chofer collate database_default =t3.Code    "
                + "                     inner join v_mae_log_areas_concat_pedidos   t4 on t0.id=t4.id_cab                                   " 
                + "                 where                                                                                                   "
                + "                     convert(date,t0.fecha_registro) between '"+desde+"' and '"+hasta+"'");

        cabecera = " <table id='tb_grilla_cab'  class=' table-bordered compact display' style='width:100%' >"
                + "<thead>"
                + "     <tr>"
                + "         <th class='text-center'   style='color: #fff; background: black;' >Nro.                          </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Fecha       </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Areas       </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Camión      </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Capacidad   </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Creado por  </th>   " 
                + "         <th class='text-center' style='color: #fff; background: black;' >Factura     </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Chofer      </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Estado      </th>   "
                + "         <th class='text-center' style='color: #fff; background: black;' >Ver         </th>   "
                + "     </tr>"
                + "</thead> "
                + "<tbody >";
         while (rs_GM.next()) {
           
            grilla_html = grilla_html
                    + " <tr> "
                    + "     <td id='"+rs_GM.getString("id") +"' class='text-center colorear'    style=\"font-weight:bold\" > " + rs_GM.getString("id") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("fecha_registro") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("areas") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("id_camion") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("cantidad") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("nombre") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("nro_factura") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("name") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("estado") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" >"
                    + "     <button class='btn btn-xs bg-yellow' onclick=\"gen_det_log_modificaciones_log(" + rs_GM.getString("id") + "   ,'consulta_gen_grilla_det_log_modificaciones.jsp')\"  title='Visualizar modificaciones'><i class='fa fa-eye'  ></i></button>"
                    + "     <button class='btn btn-xs bg-green' onclick=\"gen_det_log_modificaciones_log(" + rs_GM.getString("id") + ",'consulta_gen_grilla_det_log_pedidos.jsp')\"  title='Visualizar pedido original'><i class='fa fa-clipboard  '  ></i></button>"
                    + "</td>"
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