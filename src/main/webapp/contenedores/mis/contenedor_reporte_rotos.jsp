<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
    
      <% 
     String version=contenedores_mis_contenedor_reporte_rotos;

      %>

 <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
</head>  
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>REPORTES DE ROTOS</b></center>
</div>
   </div>  <br>
 
<form id="formulario_reporte_rotos" name="formulario_reporte_rotos" action="cruds/mis/control_reporte_rotos.jsp"  target="_blank">
    
      
    <div class="input-append">  
        <b>Fecha de clasificacion</b>
        <input id="calendario_reporte_rotos" name="calendario_reporte_rotos"  class="datepicker" width="276" required="true"  />
    
    
    </div> 
    <br>    <br> 
         <input   class=" form-control btn bg-navy" type="submit" value="Generar reporte"> 
        
          
      </form> 
   