<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %><% 
    ResultSet rs, rs2;
   PreparedStatement  pst,pst2;
    pst = connection.prepareStatement("  select * from v_mae_log_lista_modificar order by 1 asc ");
        rs = pst.executeQuery();

    String version = contenedores_logistica_contenedor_pedidos_generados_menu;
    String version_desc = desc_contenedores_logistica_contenedor_pedidos_generados_menu;

    try {


%>      

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', 'DESCRIPCION:<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head>    
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                LOG
            </div>
        </div>
        <center><b>MODIFICACION Y ANULACIÓN DE PEDIDOS</b></center>
    </div>
</div>  <br>              <table class="table table-striped">  
    <thead>
        <tr> 
            <th>NRO PEDIDO</th> 
            <th>FECHA</th> 
            <th>CAMION</th> 
            <th>CHOFER</th> 
            <th>ESTADO</th> 
            <th>AREAS INVOLUCRADAS</th> 
            <th>ACCION</th> 
           
        </tr> 
    </thead>
    <tbody>
        <% while (rs.next()) {%>
        <tr>
            <td><%=rs.getString("id")%></td>
            <td><%=rs.getString("fecha_registro")%></td>
            <td><%=rs.getString("camion")%></td>
            <td><%=rs.getString("nombre_chofer")%></td>
            <td><%=rs.getString("estado")%></td>
            <td><%=rs.getString("areas")%></td>
            <td>
                <button class="btn btn-xs bg-navy"   title="Editar pedido"><i class="fa fa-edit" onclick="ir_pedido_modificar_logistica(2,<%=rs.getString("id")%>,<%=rs.getString("cod_camion")%>,<%=rs.getString("id_chofer")%>)"></i></button>
             
                 <button class="btn btn-xs bg-warning"   title="Cambiar camión"><i class="fa fa-truck" onclick="cambiar_camion_log(<%=rs.getString("cod_camion")%>,<%=rs.getString("id")%>,<%=rs.getString("U_capacidad")%>);" class="form-control btn-dark"data-toggle="modal" data-target=".modal_camion" ></i></button>
                 <button class="btn btn-xs bg-danger"   title="Anular pedido"><i class="fa fa-trash-o" onclick="anular_pedido(<%=rs.getString("id")%>)"></i></button>
              
         </tr>                             
        <% }
        %>
    </tbody>

</table>



<div class="modal fade  modal_camion" id="modal_cambio_camion" tabindex="-1" role="dialog"   aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
    <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">×</span>
    </button>
    <div class="modal-dialog modal-xl" role="document">
        <div class="col-lg-20 ">
            <div class="position-relative p-3 bg-navy"  >
                
                <center><h1>Cambio de camión </h1></center>
            </div>
        </div>
        <div class="modal-content">
            <div class="modal-body"  >
                <h4><a>Seleccione el nuevo camión</a></h4>
                <input type="hidden" id="id_camion_cambio"> 
                <input type="hidden" id="id_pedido_cambio"> 
                
                <select id="select_camion" class="form-control bg-navy ">
                    
                </select>
            </div> 


            <div class="modal-footer">
                <input type="button" class="btn bg-navy" value="Cambiar camión" onclick=" crud_cambiar_camion($('#id_camion_cambio').val(),$('#id_pedido_cambio').val(),$('#select_camion').val());" > 
            </div>
        </div>
    </div>
</div>   
<%
    } catch (Exception e) {
    } finally {
        connection.close();

    }
%>