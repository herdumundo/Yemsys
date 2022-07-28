<%@include  file="../../versiones.jsp" %>



  <% 
     String version= contenedores_mis_contenedor_pdf_reproceso_tradicional;
      
      %> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label ><%=version%></label>  
</div>
</head>
    <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>REPORTES AVIARIOS TRADICIONALES SUBPRODUCTOS.</b></center>
</div>
    </div>  <br><!-- comment -->
     
    <form id="formulario_reporte_reproceso" name="formulario_reporte_reproceso" action="cruds/mis/control_reporte_reproceso_tradicional.jsp" target="_blank">
         <input type="hidden" id="tipo" name="tipo" value="RP">

     <div class="input-append">  
        <a>FECHA DE RECEPCIÓN</a>
        <input id="calendario_reporte_reproceso" name="calendario_reporte_reproceso" class="datepicker" width="276" required="true"  />
     </div> 
    
    <br> 
        
    
         <input   class=" form-control btn btn-success " style="font-weight: bold;color:black;"type="submit" value="Generar reporte"> 
        
          
      </form> 
   