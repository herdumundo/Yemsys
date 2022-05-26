<style>
.black {
	 
	border: 1px solid #000;
}
</style>
 <% 
     String version=clases.versiones.contenedores_ppr_vista_informe_aviarios;
 
 %> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"> <%=version%></label> 
</div>
</head>
<div id="cargaraviarios">
    
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PPR
</div>
</div>
    <center><b>RESUMEN DE BLOQUES</b></center>
</div>
   </div>  <br>

 
    <form id="formaviario">
     <div class="divinforme  "   >
        
        <div style=" background-color: #0066cc;" class="bg-navy form-control " role="alert">
                <strong style="color: white;" ><center>Bloque: Mecanizados A.</center></strong> 
        </div>
        <div  id="divA" class="black"></div>
         <div  id="divA2" class="black"></div>
        <br>
        <div style=" background-color: #0066cc;" class="bg-navy form-control" role="alert">
                <strong style="color: white;" ><center>Bloque: Mecanizados H.</center></strong> 
        </div>            
        <div id="divH" class="black"></div>
    </div>
    
    <div class="divinforme2"   >
        <div style=" background-color: #0066cc;" class="bg-navy form-control" role="alert">
            <strong style="color: white;" ><center>Bloque: Mecanizados B.</center></strong> 
        </div>            
        <div id="divB" class="black"></div>
            
    </div>
        
        
        
        
</form>

    <div  class="modal fade" id="modal_reportere" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-xl"  role="document">
            <div class="modal-content">
                <div  >
                 
                
                 
                </div>
                
                
                <div   style="width: 100%" id="cargarzoom" class="modal-body"> 
                        
                    </div>
                      
             
                  
            </div>
        </div>
    </div> 
      
</div>

