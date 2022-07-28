<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>


 <% 
     String version= contenedores_ptc_contenedor_cambio_fp;

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
PTC
</div>
</div>
    <center><b>TRANSFORMACION FECHA DE PUESTA</b></center>
</div>
   </div>  <br>       
     
<form id="formulario_pallet_carro" name="formulario_pallet_carro"  >
 
    <div class="input-append">  
        <a>FECHA DE PUESTA</a>
        <input id="fecha_puesta" name="fecha_puesta" class="datepicker" type="text"  width="276" required="true"  />
    
    
    </div> 
    <br>
    
    <input type="button" value="BUSCAR LOTES" class="form-control bg-warning" onclick="ir_grilla_cambio_fp_ptc();" >
     
    <br>
    
    <div id="contenido_grilla_cambio_fp">
    
        
    </div>
    
      </form> 
   
