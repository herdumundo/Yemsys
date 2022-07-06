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
    String version = contenedores_bal_informe;
    String version_desc = desc_contenedores_bal_informe;
    
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
        <center><b>HISTORIAL DE PEDIDOS REALIZADOS</b></center>
    </div>
</div> 
  
<div class="input-append">

           <br><br> 
           <table> 
           <tr>
                <td><label>INGRESAR FECHA DESDE</label>
                <input id="desde" name="desde" class="datepicker "   > </td>
                <td><label>INGRESAR FECHA HASTA</label>
                <input id="hasta" name="hasta" class="datepicker "    ></td> 
                <td> 
                    <input type="button" class="form-control bg-navy" value="Buscar" onclick="ir_informes_formulas_procesar_bal2($('#desde').val(),$('#hasta').val())" ></td> 
            </tr>
            </table>
</div>      



<div id="div_grilla">
    
    
</div>

 <div id="div_grilla2" class="bg-navy">
                
            </div>