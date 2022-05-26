   <% 
     String version=clases.versiones.contenedores_ptc_contenedor_reporte_mixtos_variable;

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
PTC
</div>
</div>
    <center><b>REGISTRO DE TRANSFORMACION DE PALLET A CARRO</b></center>
</div>
   </div>  <br>    
   <form id="formulario_pallet_carro" name="formulario_pallet_carro"  >
 
    <div class="input-append">  
        <a>FECHA DE PUESTA</a>
        <input id="fecha_puesta" name="fecha_puesta" class="datepicker" type="text"  width="276" required="true" onchange="ir_grilla_transformacion_pallet_carro();"/>
    
    
    </div> 
     
    
    <div id="contenido_grilla_transformacion_pallet_carro">
    
        
    </div>
    
      </form> 
   
