 <!DOCTYPE html>
 <%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%    
      String clasificadora = (String) sesionOk.getAttribute("clasificadora");
      sesionOk.setAttribute("area",clasificadora);
 %>
    
  <% 
     String version=clases.versiones.contenedores_mis_contenedor_informe;
     
    %> 
 <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label ><%=version%></label>  
</div>
</head>
 
 
 <div class="input-append">  
        
    <div class="container-fluid">
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>VISUALIZACIÓN DE INFORMES REGISTRADOS</b></center>
</div>
   </div>  <br>      
   
   
 
        <a>Fecha de clasificación</a>
        <input id="calendario_informe" class="datepicker" width="276"    />
        
        <input type="button" class="form-control bg-navy"value="Buscar" onclick="principal_mis()">
    </div> 
   <br>   
 <div  id="div_grilla"  >
         </div>  
      
       

     