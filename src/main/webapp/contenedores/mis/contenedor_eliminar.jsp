<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
    <% 
     String version=contenedores_mis_contenedor_eliminar;
    
    %> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version(' <%=version%>','VERSION: <%=version%>')">
    <label > <%=version%></label>  
</div>
</head>
<div class="container-fluid">
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>ELIMINACIÓN DE REGISTROS</b></center>
</div>
   </div>  <br>         
         <input   style="display: none"id="text_id_eliminar" name="text_id_eliminar" type="text" >
       
       
     <div class="input-append">  
         <a>Fecha de clasificación</a>
         <input id="calendario_eliminar"  class="datepicker"  width="276" />
  </div>  
         <button   class="btn bg-navy "  onclick="traer_detalle_eliminar_mis($('#calendario_eliminar').val());">BUSCAR</button> 
    <br>
        <div id="div_eliminar"  >
            
        
        </div>   
    
    
    
        </div>
        
        
        
        
      