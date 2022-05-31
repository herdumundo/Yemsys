<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../versiones.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%
    String version = contenedores_logistica_contenedor_pedidos_facturar;
    String version_desc = desc_contenedores_logistica_contenedor_pedidos_facturar;
%>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>','<%=version_desc%>')">
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
        <center><b>PENDIENTES A FACTURAR</b></center>
    </div>
</div>  <br>      
<%
    clases.controles.connectarBD();
    try {

        fuente.setConexion(clases.controles.connect);
        ResultSet rs, rs2;
        rs = fuente.obtenerDato(" select "
                + "    a.id,FORMAT (a.fecha_registro, 'dd/MM/yyyy hh:mm') as fecha_registro,"
                + "    concat(b.code,'-',b.name) as camion ,a.cantidad,c.name as chofer"
                + "                from mae_log_ptc_cab_pedidos a "
                + "                inner join maehara.dbo.[@CAMIONES] b    on a.id_camion=b.Code collate database_default and a.estado IN (1) "
                + "                inner join maehara.dbo.[@CHOFERES] c on a.id_chofer=c.Code  collate database_default"); %>
 <div id="accordion" >
    <%
        int i = 0;
        while (rs.next()) 
        {
            String id = rs.getString("id"); %> 
    <br> 
    <div>

        <div class="row">
            <div class="col-12">

                <div class="card">
                    <div class="card-header bg-success">
                        <h3 class="card-title">  Pedido nro: <%=rs.getString("id")%>  </h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body" style="display: block;">

                        <table class="table border">
                            <thead>
                            <th class="bg-black">Fecha</th>
                            <th class="bg-black">Camión</th>
                            <th class="bg-black">Chofer</th>
                            <th class="bg-black">Total</th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%=rs.getString("fecha_registro")%></td>
                                    <td><%=rs.getString("camion")%></td>
                                    <td><%=rs.getString("chofer")%></td>
                                    <td><%=rs.getString("cantidad")%></td>

                                </tr>  
                            </tbody>
                        </table>


                        <table class="table">
                            <thead>
                                <tr>  
                                    <th  class="bg-navy" >Número de artículo</th>  
                                    <th  class="bg-navy">Descripcion del articulo</th>    
                                    <th class="bg-navy">Almacén</th> 
                                    <th class="bg-navy" background: black;'>Cantidad</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    
                                    rs2 = fuente.obtenerDato(" exec [mae_log_pendientes_facturar] @id=" + id + " ");
                                    int total=0;
                                    while (rs2.next()) {%>             
                                <tr> 
                                    <td><%=rs2.getString("tipo_huevo")%></td>
                                    <td><%=rs2.getString("itemName")%></td>
                                    <td><%=rs2.getString("clasificadora")%></td>
                                    <td><%=rs2.getString("cantidad")%></td>
                                </tr>
                                <%
                                  total=total+ rs2.getInt("cantidad"); }
                                %>

                            </tbody>
                        </table>
                    </div>

                    <div class="card-footer" >
                        <a>TOTAL <%=total%></a>
                    </div>

                </div>

            </div>
        </div> 
    </div> 
    <% i++; total=0; }
    if (i == 0) { %>
    <br>
    <button type="button" class="btn btn-danger btn-block btn-lg"><i class="fa fa-bell"></i>NO SE ENCONTRARON PEDIDOS PENDIENTES</button><!-- comment -->
    <% }  %>
</div> 
<%  } catch (Exception e) {
        String as = e.getMessage();
    } finally {
        clases.controles.DesconnectarBD();
    }
%>