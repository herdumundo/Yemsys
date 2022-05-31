<%-- 
    Document   : vista_registro_contador_huevo
    Created on : 26-ene-2022, 13:37:16
    Author     : aespinola

--%>


 

  <div style="width: 100%;  text-align: left" >
      <div class="box-body" id="datos">       
      
    
          <div class="box box-solid box-default">
      <div class="box-body">
    
   <div>
       
       <p>Fecha:  <span id="fecha" class="text-blue">  </span> 
       | Aviario: <span id="aviario" class="text-blue"></span>
       | Lote:    <span id="lote" class="text-blue"></span> 
       | Edad:    <span id="edad" class="text-blue"></span></p>
   </div>
  <table bgcolor="#800000" id="datosnecropsiasregistrados" class="table table-bordered" style="width:100%"  ></table>

  </div>
      </div> 
      </div>
 
      
        <div  class="modal fade" id="modal_imagen" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" >
        <div class="modal-dialog modal-xl"  role="document">
            
            <div class="modal-content">
                <div  >
                 
                
                 
                </div>
                
                <div  class="slideshow-container" style="width: 100%;" class="text-center">
                <div class="box-header">
                    <button class="close" type="button" style="font-weight: bold;color:black;" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">×</span></button>
                    <h4 class="text-center">ARCHIVOS CARGADOS</h4>
                </div>
    <div id="demo" class="carousel slide carousel-inner" data-ride="carousel"  >

     <!-- Indicators -->
     <ul class="carousel-indicators" id="ul_contenido_imagenes">
        
     </ul>
     <!-- The slideshow -->
        <div id="ave_nro"></div> 
        <div  class="text-center" class="carousel-inner" id="contenedor_imagenes"  >
            
          
        </div>
           <!-- Left and right controls -->
        <a class="carousel-control-prev" href="#demo" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </a>
        <a class="carousel-control-next" href="#demo" data-slide="next">
            <span class="carousel-control-next-icon"></span>
        </a>
</div>
 </div>   
                      
             
                  
            </div>
        </div>
    </div> 
</div>

  
 
<div class="container" id="contenido_carga_imagen" >

</div>

 


