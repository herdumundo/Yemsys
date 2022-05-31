<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
 <%-- 
    Document   : contenedor_registro_reprocesos
    Created on : 15-dic-2021, 9:51:44
    Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%
     String titulo_reproceso    = (String) sesionOk.getAttribute("titulo_reproceso");
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    clases.controles.VerificarConexion();
        Statement stmt = clases.controles.connectSesion.createStatement();
        ResultSet rs = stmt.executeQuery(" select id, fecha_registro,estado, nombre, mae_ptc_alimentacion.clasificadora   "
                + " from mae_ptc_alimentacion inner join usuarios on mae_ptc_alimentacion.usuario=usuarios.usuario "
                + " where mae_ptc_alimentacion.clasificadora='"+clasificadora+"' and estado<>'C' ");
       
%> 
      
     <% 
     String version= contenedores_ptc_contenedor_registro_reprocesos_lista;
     String version_desc= desc_contenedores_ptc_contenedor_registro_reprocesos_lista;

       %>
    <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>','<%=version_desc%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
</head> 
 <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b><%=titulo_reproceso%></b></center>
</div>
   </div>  <br>       
   
   
    <div id="contenedor_reprocesos"> 
<br><br><input type='button' value='Ir inicio de reproceso'  style='font-weight: bold;color:black;' class='form-control bg-success' onclick='ir_registro_reprocesos_ptc(0);' > 
<table id="grilla_transfer" data-row-style="rowStyle" data-toggle="table"  class="table table-striped table-bordered" data-click-to-select="true">
            <thead>
                <tr>

                    <th>NRO</th>
                    <th>USUARIO</th>
                    <th>FECHA INICIO</th>
                    <th>IR</th>
                </tr>
            </thead>
            <tbody>
                <%
                while(rs.next())
                {
                %>  <tr>
                        <td><%=rs.getString("id")%></td>
                        <td><%=rs.getString("nombre")%></td>
                        <td><%=rs.getString("fecha_registro")%></td>
                        <td><div class="text-center">
                        <div class="btn form-control bg-navy" type="button" value="Editar" onclick="ir_registro_reprocesos_ptc(<%=rs.getString("id")%>);"><i class="fas fa-edit">

                           </i>
                         </div>
                    </div></td>
                    </tr> <%
                }
                %> 
            </tbody>
        </table>      
 
    </div>
   
    <%
        clases.controles.DesconnectarBDsession();
%>
                

 
 
 