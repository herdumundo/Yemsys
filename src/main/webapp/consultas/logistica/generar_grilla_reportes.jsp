<%-- 
    Document   : generar_grilla_preembarque
    Created on : 16-sep-2021, 8:37:03
    Author     : hvelazquez
--%>
<%@page import="org.json.JSONArray"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@page contentType="application/json; charset=utf-8" %>
<%     
    String estado            = request.getParameter("estado");
    String fecha_desde            = request.getParameter("fecha_desde");
    String fecha_hasta            = request.getParameter("fecha_hasta");
    String grilla_html="";
    String cabecera="";
    ResultSet rs;
    PreparedStatement  pst;
    String between_fechas=" convert(date,a.fecha_registro) between '"+fecha_desde+"' and '"+fecha_hasta+"' and";
    if(estado.equals("1")||estado.equals("2"))
    {
        between_fechas="";//SE VACIA EL STRING, PORQUE EL ESTADO 1 Y 2 NO NECESITAN FILTROS POR FECHAS.
    }
    try 
        {
            String query="";
            cabecera=     "<table id='tb_reportes' class='table-bordered compact display dataTable no-footer' style='width:100%'>"
                + "<thead>"
                + "     <tr>" 
                + "         <th style='color: #fff; background: black;'>NRO PEDIDO  </th>"
                + "         <th style='color: #fff; background: black;'>NRO GLOBAL  </th>"
                 + "         <th style='color: #fff; background: black;'>FECHA PEDIDO</th>"
                + "         <th style='color: #fff; background: black;'>CANTIDAD    </th>"
                + "         <th style='color: #fff; background: black;'>CAMION      </th>"
                + "         <th style='color: #fff; background: black;'>FACTURA     </th>"
                + "         <th style='color: #fff; background: black;'>CHOFER      </th>"
                + "         <th style='color: #fff; background: green;'>ESTADO      </th>"
                + "         <th style='color: #fff; background: green;'>ACCIONES   </th>"
                + "     </tr>"
                + "</thead> <tbody >";

            query ="    select "
                + "         A.id,FORMAT (a.fecha_registro, 'dd/MM/yyyy HH:mm') as fecha_registro,concat(b.code,'-',b.name) as camion ,A.cantidad ,C.Name AS chofer,"
                + "         A.estado,   d.descripcion as desc_estado,NRO_FACTURA,A.nro_pedido_global,A.orden_pedido                         "
                + "     from "
                + "         mae_log_ptc_cab_pedidos             A                         "
                + "         INNER JOIN maehara.dbo.[@CAMIONES]  b   ON A.id_camion  =b.Code collate database_default 					  "
                + "         INNER JOIN maehara.dbo.[@CHOFERES]  C   ON A.id_chofer  =C.Code collate database_default"
                + "         INNER JOIN mae_log_ptc_estados      d   ON A.estado     =d.id "
                + "     where "
                + "        "+between_fechas+" estado   in ("+estado+") ";

            pst = connection.prepareStatement(query);
            rs = pst.executeQuery();
            while(rs.next())
            {   
                grilla_html=grilla_html+
                        "   <tr>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(1)+"                    </td>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString("nro_pedido_global")+"                    </td>"
                         + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >    "+rs.getString(2)+"                     </td>"                                                                                  
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '  >     "+rs.getString(4)+"                    </td>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(3)+"                    </td>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString("nro_factura")+"        </td>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(5)+"                    </td>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(7)+"                    </td>"
                        + "     <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >"
                        + "         <button onclick=\"window.open('cruds/logistica/control_reporte_pedidos.jsp?id_rep="+rs.getString(1)+"')\" title=\"Reporte pedido individual \"  class=\"btn request-callback\" ><i class=\"fa fa-file\"></i>  </button>"
                        + "         <button onclick=\"window.open('cruds/logistica/control_reporte_pedidos_global.jsp?id="+rs.getString("nro_pedido_global")+"')\" title=\"Reporte pedido global \" class=\"btn request-callback\" > <i class=\"fa  fa-files-o\"></i>  </button>"
                        + "         <button onclick=\"editar_nro_global_pedido_log("+rs.getString(1)+","+rs.getString("nro_pedido_global")+")\" title=\"Editar nro. global \" class=\"btn request-callback\" > <i class=\"fa  fa-pencil\"></i>  </button>"
                        + "     </td>"
                        +"  </tr>";
            }

            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("grilla",cabecera+grilla_html+"</tbody></table></div>");
            out.print(ob);
        } 
        catch (Exception e) 
        {
            String error=e.getMessage();
        }
        finally
        {
            connection.close();
        }
%>