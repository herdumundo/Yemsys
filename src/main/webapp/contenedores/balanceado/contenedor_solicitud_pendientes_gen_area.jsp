<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@page import="clases.controles"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    
    String version = contenedores_bal_pendientes_creados_usuario;
    String version_desc = desc_contenedores_bal_pendientes_creados_usuario;
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
    String area = (String) sesionOk.getAttribute("area_gm");

    try {
        ps = connection.prepareStatement("  select *,b.descripcion as desc_estado,"
                + " case when  toneladas_proyectada='' then 'INDEFINIDO' ELSE   toneladas_proyectada end as toneladas_desc"
                + " from mae_bal_mtp_cab_solicitud a inner join mae_bal_estados b on a.estado=b.id and a.estado IN (1,2,4,5)");
        
                                                                                                                    /*
                                                                                                                    1	PENDIENTE APROBACION JEFE DE BALANCEADO
                                                                                                                    2	PENDIENTE DE APROBACION GERENTE INDUSTRIAL
                                                                                                                    3	PENDIENTE A PROCESAR SAP
                                                                                                                    4	PENDIENTE VERIFICACION USUARIO
                                                                                                                    5	REVISION GERENCIA
                                                                                                                    6	PROCESADO SAP
                                                                                                                     */
        rs = ps.executeQuery();
        int verifi=0;
%>
<style>
 

    tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                BAL
            </div>
        </div>
        <center><b>SOLICITUDES PENDIENTES DE APROBACION POR AREA</b></center>
    </div>
</div> 
 

 
        <table  class=' table-bordered compact' style='width:100%'>
            <thead>
            <th>Nro.</th>
            <th>Fecha de registro</th>
            <th>Solicitud modificacion</th>
            <th>Formula</th>
            <th>Recomendado por</th>
            <th>Motivo</th>
            <th>Usuario</th>
            <th>Toneladas</th>
            <th>Estado</th>
            <th>Verificaci?n</th>
             
            </thead>
            <tbody>
                <% while (rs.next()){ %>
                <tr>
                    <td><%=rs.getString("id")%></td>
                    <td><%=rs.getString("fecha_registro")%></td>
                    <td><%=rs.getString("fecha_modificacion")%></td>
                    <td><%=rs.getString("formula")%></td>
                    <td><%=rs.getString("recomendado")%></td>
                    <td><%=rs.getString("motivo")%></td>
                    <td><%=rs.getString("usuario")%></td>
                    <td><%=rs.getString("toneladas_desc")%></td>
                    <td><%=rs.getString("desc_estado")%></td>
                    <td><%=rs.getString("revision")%></td>
                    <td><input type="button" value="Detalle" class="bg-navy" onclick="modal_detalle_formulacion_bal(<%=rs.getString("id")%>,'<%=rs.getString("cod_formula")%>','<%=rs.getString("formula")%>')"> </td>
                    <td><form action="cruds/balanceado/control_reporte_pedidos_bal.jsp" target="blank"><input type="submit" value="Reporte" class="bg-warning"> <input type="hidden" id="id" name="id" value="<%=rs.getString("id")%>"></form> </td>
                    <% if(rs.getString("desc_estado").equals("PENDIENTE VERIFICACION USUARIO")){%>
                    <td><input type="button" value="Editar"    class="bg-black" onclick="editar_solicitud_bal(<%=rs.getString("id")%>,1)"> </td> <><!-- 1= ESTADO PARA QUE VUELVA A ESTADO PENDIENTE DE APROBACION JEFE BALANCEADO -->
                     <% }%>
                
                </tr>
                  <%verifi++; } %>
            </tbody>
        </table>
            
            <%
             if(verifi==0)
             {
            %>   
          <div class="alert alert-danger alert-dismissible" role="alert">
        <div class="alert-icon">
            <i class="far fa-fw fa-bell" aria-hidden="true"></i>
        </div>
        <div class="alert-message">
            <center><strong>NO SE ENCONTRARON PEDIDOS PENDIENTES</strong>  </center>
        </div>
    </div>
            <%   
            }%>


            <div id="div_grilla">
                
            </div>
            <div id="div_grilla2" class="bg-navy">
                
            </div>

<%
    } catch (Exception e) {

    } finally {
        connection.close();
    }%>