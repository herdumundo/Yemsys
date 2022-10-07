 <%@page import="org.json.JSONObject"%> 
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
 
 <%  
    String area =  (String) sesionOk.getAttribute("area_gm");
     String version =  contenedores_logistica_contenedor_pedidos_generados_cyo;
     String version_desc = desc_contenedores_logistica_contenedor_pedidos_generados_cyo;
     String estado=""; 
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
        <center><b>PENDIENTES A EMBARCAR</b></center>
    </div>
</div>  <br>    

<%
    ResultSet rs, rs2, rs3, rs4;
    Statement st = connection.createStatement();
    Statement st2 = connection.createStatement();
    Statement st3 = connection.createStatement();
    Statement st4 = connection.createStatement();

    if (area.equals("A")) {
        area = "CCHA";
    } else if (area.equals("B")) {
        area = "CCHB";
    } else if (area.equals("H")) {
        area = "CCHH";
    } else if (area.equals("O")) {
        area = "LAVADOS";
    } else if (area.equals("C")) {
        area = "CYO";
    }
    rs = st.executeQuery(" select * from v_mae_log_pendientes_embarque where clasificadora='"+area+"' and estado in (1,2)"); %>


<script>
    $(function () {
        $("#accordion").accordion({

            heightStyle: "content"

        });
    });
</script>
    <%
        try {
            int i = 0;
            while (rs.next()) {
                String id = rs.getString("id");
                String id_chofer = rs.getString("id_chofer");
                String id_camion = rs.getString("id_camion");
                estado = rs.getString("estado");
                
                String contenido_cab = "Pedido nro. " + rs.getString("id") + "  Fecha registro: " + rs.getString("fecha_registro") + "  Camion:" + rs.getString("camion") + " TOTAL CARROS:" + rs.getString("cantidad");%> 

<div id="accordion" >

        <div class="row">
            <div class="col-12">

                <div class="card">
                    <div class="card-header bg-navy">
                        <h3 class="card-title"><%=contenido_cab%> </h3>
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



                        <table class="  table "  style='width:10%'>
                            <thead>
                                <tr class="bg-navy">  
                                    <th  > FECHA DE PUESTA</th>  
                                    <th   >TIPO</th>    
                                    <th  >CANTIDAD</th> 
                                </tr>
                            </thead>    
                            <tbody>
                                <%
                                    rs2 = st2.executeQuery("select sum(cantidad ) as cantidad,clasificadora,tipo_huevo,CONVERT(VARCHAR,fecha_puesta,103) as fecha_puesta "
                                            + " from mae_log_ptc_det_pedidos2 "
                                            + " where id_cab=" + id + "  and u_medida='ENTERO' AND   clasificadora='" + area + "' "
                                            + " group by clasificadora,tipo_huevo,fecha_puesta ");

                                    while (rs2.next()) 
                                    {%>             
                                <tr> 
                                    <td><%=rs2.getString("fecha_puesta")%></td>
                                    <td><%=rs2.getString("tipo_huevo")%></td>
                                    <td><%=rs2.getString("cantidad")%></td>
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>


                        </table> 

                        <%
                            int comprobar_mixto = 0;
                            rs4 = st3.executeQuery("  SELECT clasificadora ,carrito as carro ,  stuff(( select   ','+  [tipo_huevo] + ':'+convert(varchar,[cantidad])    "
                                    + " from mae_log_ptc_det_mixtos_pedidos with (nolock)  where carro =  carrito for XML path('') ),1,1,'')as cajones  "
                                    + "FROM  (  select clasificadora,carro as carrito,tipo_huevo,cantidad from mae_log_ptc_det_mixtos_pedidos where id_cab= " + id + "  and clasificadora='" + area + "' and estado in (1,2)  )  T  "
                                    + "  group by clasificadora ,carrito");

                            while (rs4.next()) {

                                comprobar_mixto++;
                            }
                            if (comprobar_mixto > 0) {
                        %>        
                        <table class="  table table-striped" style='width:10%'>
                            <thead>
                                <tr class="bg-danger">  
                                    <th > CARRO</th>  
                                    <th  >CAJONES</th>    
                                </tr>
                            </thead>    
                            <tbody>
                                <%
                                    rs3 = st4.executeQuery("  SELECT clasificadora ,carrito as carro ,  stuff(( select   ','+  [tipo_huevo] + ':'+convert(varchar,[cantidad])    "
                                            + " from mae_log_ptc_det_mixtos_pedidos with (nolock)  where ESTADO in (1,2)  AND carro =  carrito for XML path('') ),1,1,'')as cajones  "
                                            + "FROM  (  select clasificadora,carro as carrito,tipo_huevo,cantidad "
                                            + "         from mae_log_ptc_det_mixtos_pedidos where id_cab= " + id + "   and clasificadora='" + area + "'  and estado in (1,2)  "
                                            + ")  T  "
                                            + "  group by clasificadora ,carrito");

                                    while (rs3.next()) {%>             
                                <tr> 
                                    <td><%=rs3.getString("carro")%></td>
                                    <td><%=rs3.getString("cajones")%></td>
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>


                        </table>        
                        <% }%>



                    </div>
                           
                        <div class="card-footer"  >
                            <%
                            if(estado.equals("2"))
                            { 
                                
                             %> 
                                <input type="button"  value="MODIFICAR PEDIDO" class="btn form-control bg-navy" onclick="ir_pedido_cyo(<%=id%>,<%=id_chofer%>,<%=id_camion%>)" >
                             <%    }
                            %> 
                        </div>

                </div>

            </div>
        </div> 
                            <form action="cruds/logistica/control_reporte_pedidos_cyo.jsp"  target="_blank">

                        <input type="submit" class="form-control bg-navy" value="IR A REPORTE">
                                <input type="hidden" name="id_rep" value="<%=id%>">
                            </form>   
     </div>
               
          
    
    <%
            i++;
        }

        if (i == 0) {
    %>
    <div class="alert alert-danger alert-dismissible" role="alert">
        <div class="alert-icon">
            <i class="far fa-fw fa-bell"></i>
        </div>
        <div class="alert-message">
            <center><strong>NO SE ENCONTRARON PEDIDOS PENDIENTES</strong>  </center>
        </div>
    </div>
    <%
            }
        } catch (Exception e) {
            out.print(e.getMessage());
        } finally {
            connection.close();
        }
    %>







