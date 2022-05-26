<%@page import="java.sql.Statement"%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%
   // String version = clases.versiones.contenedores_logistica_pedidos_pendientes;
    clases.controles.connectarBD();
 int i = 0;
%>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version(' ', 'VERSION:  ')">
    <label ></label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                LOG
            </div>
        </div>
        <center><b>ESTADO DE PEDIDOS</b></center>
    </div>
</div>  <br>  
 <table    id="tabla_pedidos" class="table table-striped" style="width:100%">

        <thead>
            <tr>
                <th>
                Nro.
                </th>
                <th>
                Fecha creación.
                </th>
                <th  >
                Factura
                </th>
                 <th  >
                Chofer
                </th>
                 <th  >
                Camión
                </th>
                 <th  >
                Capacidad
                </th>
                 <th>
                Estado
                </th>
                <th>
                Ultimo movimiento
                </th>
            </tr>
        </thead>
 <tbody >
     <%
          Statement   stmt1 = clases.controles.connect.createStatement();
        ResultSet rs;
        rs = stmt1.executeQuery("  select id,fecha_registro,nro_factura,chofer,camion,cantidad,estado,ultima_fecha from v_mae_log_estados_pedidos  where id_estado in (1,2,3)"); 
        while(rs.next()){ %>
        <tr>  
            <td ><%=rs.getString(1)%></td> 
            <td ><%=rs.getString(2)%></td> 
            <td ><%=rs.getString(3)%></td> 
            <td ><%=rs.getString(4)%></td> 
            <td ><%=rs.getString(5)%></td> 
            <td ><%=rs.getString(6)%></td> 
            <td ><%=rs.getString(7)%></td> 
            <td ><%=rs.getString(8)%></td> 
          </tr> <%
             i++;
                }%>  
        </tbody>  
  </table>