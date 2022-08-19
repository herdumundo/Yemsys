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
        
        rs_GM = st.executeQuery("select "
                + "     fecha,id_camion,fecha_puesta,area,tipo,cantidad,t1.descripcion as estado,"
                + "  tipo_huevo, isnull(estado_descripcion,'CREADO POR LOGISTICA') AS log,usuario,t0.estado as id_estado ,t0.cod_carrito"
                + " from "
                + " mae_log_preembarque_reserva t0 inner join mae_log_ptc_estados t1 on t0.estado=t1.id "
                + " where id_pedido ="+id+" ");

        cabecera = " <table id='tb_grilla_det'  class=' table-bordered compact display' style='width:100%' >"
                + "<thead>"
                + "     <tr> "
                + "         <th colspan='11' class='text-center'   style='color: black; background: yellow;' >Nro. pedido "+id+"</th>   "
                + "     </tr> "
                + "     <tr>"
                + "         <th class='text-center' style='color: black; background: yellow;' >Fecha                          </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >   Camión    </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' > Fecha puesta     </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >Clasificadora   </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >Tipo huevo  </th>   " 
                + "         <th class='text-center' style='color: black; background: yellow;' >Tipo  </th>   " 
                + "         <th class='text-center' style='color: black; background: yellow;' >Cantidad     </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >Carro     </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >Estado pedido      </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >Log      </th>   "
                + "         <th class='text-center' style='color: black; background: yellow;' >Usuario         </th>   "
                + "     </tr>"
                + "</thead> "
                + "<tbody >";
        String color_letra="";
         while (rs_GM.next()) {
           
             if(rs_GM.getInt("id_estado")==6){
               color_letra="color:red;";  
             }
             else{
               color_letra="color:black;";  
             }
            grilla_html = grilla_html
                    + " <tr>   "
                    + "     <td class='text-center'    style=\"font-weight:bold;\"  > " + rs_GM.getString("fecha") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("id_camion") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("fecha_puesta") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("area") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("tipo_huevo") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("tipo") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("cantidad") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("cod_carrito") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold;"+color_letra+"\" > " + rs_GM.getString("estado") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("log") + "</td>"
                    + "     <td class='text-center'    style=\"font-weight:bold\" > " + rs_GM.getString("usuario") + "</td>"
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