
     <% 
     String version=clases.versiones.contenedores_mis_contenedor_pdf_transferencia_reproceso;
 
 %> 
  <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
</head> 

<input type="hidden" id="tipo" name="tipo" value="RP">
  
    <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>REPORTES DE TRANSFERENCIAS DE REPROCESOS Y SUBPRODUCTOS</b></center>
</div>
    </div>  <br><!-- comment -->
     
     
     <div class="input-append">  
        <a>FECHA DE REGISTRO</a>
        <input id="calendario_informe" name="calendario_informe" class="datepicker"  width="276" required="true"  />
     </div> 
    
    <br> 
        
    
   <a>SELECCIONAR TIPO DE REPORTE</a>
    <select class="form-control" name="tipo_reporte" id="tipo_reporte"  >
            <OPTION VALUE="1">REALIZADAS</OPTION> 
            <OPTION VALUE="2">RECIBIDAS</OPTION> 
    </select>             
          
    <a>SELECCIONAR TIPO DE TRANSFERENCIA</a>
    <select class="form-control" name="estado" id="estado"  >
            <OPTION VALUE="RP">REPROCESO</OPTION> 
            <OPTION VALUE="SP">SUBPRODUCTOS</OPTION> 
    </select>             
       <br>
       <input type="button" value="BUSCAR" onclick="ir_grilla_transferencia_reporte($('#calendario_informe').val(),$('#estado').val())" class="form-control bg-navy">
    
      
        
    <div id="div_grilla_tipo_transferencia"> </div>
           
