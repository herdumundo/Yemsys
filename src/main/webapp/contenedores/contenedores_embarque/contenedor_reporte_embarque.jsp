   <% 
     String version=clases.versiones.contenedores_embarque_contenedor_reporte_embarque;
     
 %>  
  <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" 
     data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label ><%=version%></label> 
</div>
</head>
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
EMBARQUE
</div>
</div>
    <center><b>REPORTE DE EMBARQUES GENERADOS</b></center>
</div>
   </div>  <br>    
     
<br><br>
<a>INGRESAR FECHA DE EMBARQUE</a>
 <input  style=" font-weight: bold"class="datepicker"   type="text" id="calendario_embarque" name="calendario_embarque">              
 <br> 
 <br> 

 <input  style=" font-weight: bold"class="form-control bg-navy"   type="button"  value="BUSCAR" onclick="filtrar_listado_embarque($('#calendario_embarque').val());">              






<br>
<br>

<div id="contenedor_embarque_lista"> </div>