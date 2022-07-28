<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
 
   <% 
     String version= contenedores_ptc_contenedor_empacadora;

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
    <center><b>APERTURA Y CIERRE DE EMPACADORAS</b></center>
</div>
   </div>  <br>           
    <form method="post"   id="formulario">
      
        <input type="button" name="btn_buscar" id="btn_buscar" value="ACTIVAR EMPACADORA" class="form-control btn-warning" onclick="cuadro_empacadoras()"> 
        
    </form>


<div id="div_tabla">
    
    
</div>
      
            
            
  
 

   
      
    
     
        
        
        
 