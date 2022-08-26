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
<%@ page session="true" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%     
    clases.controles.connectarBD();
    fuente.setConexion(clases.controles.connect);
    String id            = request.getParameter("id");
    String estado            = request.getParameter("estado");
    String fecha_desde            = request.getParameter("fecha_desde");
    String fecha_hasta            = request.getParameter("fecha_hasta");
    
      int i=0;
    String grilla_html="";
     String cabecera="";
     
     

   
     try {
            
      
     ResultSet rs;
 
     String query="";
     
     if(estado.equals("7")){
        query =" select a.id,FORMAT (a.fecha_registro, 'dd/MM/yyyy HH:mm') as fecha_registro,concat(b.code,'-',b.name) as camion ,a.cantidad ,C.Name AS chofer  ,a.estado,d.descripcion as desc_estado,NRO_FACTURA                          "
            + "from mae_log_ptc_cab_pedidos a                         "
            + "inner join maehara.dbo.[@CAMIONES] b    on a.id_camion=b.Code collate database_default and estado   in (1,2,3,4)					  "
            + " inner join maehara.dbo.[@CHOFERES] C ON A.id_chofer =C.Code collate database_default"
                + " INNER JOIN mae_log_ptc_estados d on a.estado=d.id "
                
            + " where convert(date,a.fecha_registro) between '"+fecha_desde+"' and '"+fecha_hasta+"' ";
    
        cabecera=     "<table id='tb_reportes' class='table table-bordered table-hover' style='width:100%'>"
            + "<thead>"
             
            + " <tr>" 
            + " <th  style='color: #fff; background: black;' >NRO PEDIDO</th>  "
                + " <th style='color: #fff; background: black;' >FECHA PEDIDO</th>"
            + " <th  style='color: #fff; background: black;'>CANTIDAD</th>     "
                + " <th style='color: #fff; background: black;' >CAMION</th>"
            + " <th  style='color: #fff; background: black;'>FACTURA</th>      "
            + " <th  style='color: #fff; background: black;'>CHOFER</th>      "
                + "<th  style='color: #fff; background: green;'>ESTADO</th> "
                + " <th  style='color: #fff; background: green;'>IR</th>       "
            + " </tr>"
            + "</thead> <tbody >";
     
     
     }
     else if (estado.equals("5")) {
         query =" select a.id,FORMAT (a.fecha_registro, 'dd/MM/yyyy HH:mm') as fecha_registro,concat(b.code,'-',b.name) as camion ,a.cantidad ,C.Name AS chofer  ,a.estado  ,NRO_FACTURA                         "
            + "from mae_log_ptc_cab_pedidos a                         "
            + "inner join maehara.dbo.[@CAMIONES] b    on a.id_camion=b.Code collate database_default and estado    in ("+estado+"  )					  "
            + " inner join maehara.dbo.[@CHOFERES] C ON A.id_chofer =C.Code collate database_default"
                 + " where convert(date,a.fecha_registro) between '"+fecha_desde+"' and '"+fecha_hasta+"' ";
         
          cabecera=     "<table id='tb_reportes' class='table table-bordered table-hover' style='width:100%'>"
            + "<thead>"
             
            + " <tr>" 
            + " <th  style='color: #fff; background: black;' >NRO PEDIDO</th>   "
                  + "<th style='color: #fff; background: black;' >FECHA PEDIDO</th>"
            + " <th  style='color: #fff; background: black;'>CANTIDAD</th>      "
                  + "<th style='color: #fff; background: black;' >CAMION</th>"
            + " <th  style='color: #fff; background: black;'>FACTURA</th>      "
            + " <th  style='color: #fff; background: black;'>CHOFER</th>        "
                  + "<th  style='color: #fff; background: green;'>IR</th>       "
            + " </tr>"
            + "</thead> <tbody >";
     }
     else {
           query =" select a.id,FORMAT (a.fecha_registro, 'dd/MM/yyyy HH:mm') as fecha_registro,concat(b.code,'-',b.name) as camion ,a.cantidad ,C.Name AS chofer  ,a.estado ,NRO_FACTURA                          "
            + "from mae_log_ptc_cab_pedidos a                         "
            + "inner join maehara.dbo.[@CAMIONES] b    on a.id_camion=b.Code collate database_default and estado   in ("+estado+"  )					  "
            + " inner join maehara.dbo.[@CHOFERES] C ON A.id_chofer =C.Code collate database_default";
           
            cabecera=     "<table id='tb_reportes' class='table table-bordered table-hover' style='width:100%'>"
            + "<thead>"
             
            + " <tr>" 
            + " <th  style='color: #fff; background: black;' >NRO PEDIDO</th>   "
                    + "<th style='color: #fff; background: black;' >FECHA PEDIDO</th>"
            + " <th  style='color: #fff; background: black;'>CANTIDAD</th>     "
                    + " <th style='color: #fff; background: black;' >CAMION</th>"
            + " <th  style='color: #fff; background: black;'>FACTURA</th>      "
            + " <th  style='color: #fff; background: black;'>CHOFER</th>       "
                    + " <th  style='color: #fff; background: green;'>IR</th>       "
            + " </tr>"
            + "</thead> <tbody >";
     }
     
     
     
    rs= fuente.obtenerDato( query);
   if(estado.equals("7")){
        while(rs.next())
    {   grilla_html=grilla_html+
            "<tr   >"
                   + "  <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(1)+"       </td>"
                   + "  <td     class='text-center ' style='color: #000; background: white; font-weight: bold; '   >    "+rs.getString(2)+"       </td>"                                                                                  
                   + "  <td     class='text-center'   style='color: #000; background: white; font-weight: bold; '  >     "+rs.getString(4)+"       </td>"
                   + "  <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(3)+"       </td>  "
                   + "  <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString("nro_factura")+"       </td>  "
            + "         <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(5)+"     </td>"
            + "         <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(7)+"     </td>"
            + "         <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   > "
            + "<form action='cruds/logistica/control_reporte_pedidos.jsp' target='_blank' >  "
            + "<input type='hidden' value='"+rs.getString(1)+"' name='id_rep'><input type='hidden' value='"+rs.getString(6)+"' name='estado_rep'>  "
            + "<input type='submit' value='GENERAR REPORTE' class='form-control  bg-success' style='color: #000; background: white; font-weight: bold; '>   <li class='fa-file-pdf-o'></li></b>"
            + " </form>   </td>"
              +   " </tr>";
           
    }
   }
   else {
          while(rs.next())
    {
        
  
       grilla_html=grilla_html+
            "<tr   >"
                   + "  <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(1)+"       </td>"
                   + "  <td     class='text-center ' style='color: #000; background: white; font-weight: bold; '   >    "+rs.getString(2)+"       </td>"                                                                                  
                   + "  <td     class='text-center'   style='color: #000; background: white; font-weight: bold; '  >     "+rs.getString(4)+"       </td>"
                   + "  <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(3)+"       </td>  "
                   + "  <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString("nro_factura")+"       </td>  "
            + "         <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   >     "+rs.getString(5)+"     </td>"
            + "         <td     class='text-center'  style='color: #000; background: white; font-weight: bold; '   > "
            + "<form action='crud/control_reporte_reportes.jsp' target='_blank' >  "
            + "<input type='hidden' value='"+rs.getString(1)+"' name='id_rep'><input type='hidden' value='"+rs.getString(6)+"' name='estado_rep'>  "
            + "<input type='submit' value='GENERAR REPORTE' class='form-control  bg-success' style='color: #000; background: white; font-weight: bold; '>   </b> </form>   </td>"
              +   " </tr>";
      }
   }
    
    
   
    
        clases.controles.DesconnectarBD();
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
 
        ob.put("grilla",cabecera+grilla_html+"</tbody></table></div>");
       
        out.print(ob);
          } catch (Exception e) {
              String error=e.getMessage();
        }
%>