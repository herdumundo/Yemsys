         <% 
     String version=clases.versiones.contenedores_mis_contenedor_pdf_reproceso;
     
   %> 
      <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION:  <%=version%>')" >
    <label neme="label_contenido" id="label_contenido" > <%=version%></label>  
</div>
</head> 


<form id="formulario_reporte_reproceso" name="formulario_reporte_reproceso" action="cruds/mis/control_reporte_reproceso.jsp" target="_blank">
   <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>REPORTES REPROCESOS Y SUBPRODUCTOS</b></center>
</div>
   </div>  <br>  
   
     
    <div class="input-append">  
    <a>FECHA DE CLASIFICACION</a>  
        
    <input id="calendario_reporte_reproceso" name="calendario_reporte_reproceso" class="datepicker" required="true"  />
    
    
    </div> 
    
    <br> 
        <select class="form-control" name="cbox_reproceso_pdf" id="cbox_reproceso_pdf">
            <OPTION selected disabled>Seleccione reproceso o subproducto</OPTION>
            <OPTION VALUE="RP">REPROCESO</OPTION>
            <OPTION VALUE="PI">SUBPRODUCTO</OPTION>
        </select>   
    <br> 
      
        <select class="form-control" name="cbox_categoria_reproceso_pdf" id="cbox_categoria_reproceso_pdf">
                <OPTION selected disabled>Seleccione categoría</OPTION>
                <OPTION VALUE="FCO">FCO</OPTION>
                <OPTION VALUE="LDO">LDO</OPTION>
        </select> 
            <br>    <br> 
         <input   class="form-control btn bg-navy" type="submit" value="Generar reporte"> 
        
          
      </form> 
