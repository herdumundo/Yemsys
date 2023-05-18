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
<%    
    String version = contenedores_bal_informe_creado_por_usuario;
    String version_desc = desc_bal_informe_creado_por_usuario;
    
%> 
<head>   
<label><b></b></label> 
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
        <center><b>BUSQUEDA DE PEDIDOS REALIZADOS POR USUARIO </b></center>
    </div>
</div> 
  
<div class="input-append">

       <table>
    <thead>
    <tr><th>Fecha desde</th>
    <th>Fecha hasta</th>
    </tr></thead>
    <tbody>
        <tr>
            <td> 
                <input id="desde" name="desde" class="datepicker "   >          
            </td>
            <td>
                <input id="hasta" name="hasta" class="datepicker "    >           
            </td>
        </tr>
         <tr>
             <td colspan="2">
                    <input type="button" class="form-control bg-navy" value="Buscar" onclick="consulta_informes_pedidos_creados_por_usuario_bal($('#desde').val(),$('#hasta').val())" ></td>             </td>
         </tr>
    </tbody>
</table>     
           
           
</div>      



<div id="div_grilla2">
    
    
</div>

 <div id="div_grilla"  >
                
            </div>

 <div   id="divGrillaNutrientes">
                
            </div>