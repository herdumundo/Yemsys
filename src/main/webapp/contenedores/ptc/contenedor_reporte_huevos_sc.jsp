<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%    
      String clasificadora = (String) sesionOk.getAttribute("clasificadora");
      sesionOk.setAttribute("area",clasificadora);
 
     String version= contenedores_ptc_contenedor_reporte_huevos_sc;

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
    <center><b>REPORTE DE HUEVOS SIN CLASIFICAR</b></center>
</div>
   </div>  <br>    
   
   
  <form action="cruds/ptc/control_reporte.jsp" target="_blank">  
<b>FECHA DE PUESTA</b>
       <input id="fecha" name="fecha"   class="datepicker" type="text"   width="276"    />
              <input  id="archivo" name="archivo"  type="hidden"   value="huevos_SC"   />

        <br>
        
             
       <br>
       <input type="submit"  value="GENERAR REPORTE"   class="form-control bg-navy">
    
        
   </form>    
   
   
           
