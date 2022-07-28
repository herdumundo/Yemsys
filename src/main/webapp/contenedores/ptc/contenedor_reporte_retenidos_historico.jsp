<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<% 
     String version= contenedores_ptc_contenedor_reporte_retenidos_historico;

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
    <center><b>REPORTE DE RETENIDOS HISTORICOS</b></center>
</div>
   </div>  <br>    
    
     
<form id="formulario_reporte_reproceso" name="formulario_reporte_reproceso" action="cruds/ptc/control_reporte_historico_retenido.jsp" target="_blank">
 
    <div class="input-append">  
        <a>FECHA DE PUESTA</a>
        <input id="fecha_puesta" name="fecha_puesta" class="datepicker" type="text"  width="276" required="true"  />
    
    
    </div> 
    
    
  
  
      
      
         <br> 
         
         <a >TIPO DE HUEVO</a> 
           <select class="form-control" name="tipo_huevo" id="tipo_huevo" > 
            <OPTION VALUE="T" selected  >TODOS</OPTION>
            <OPTION   VALUE="A">A</OPTION>
            <OPTION   VALUE="B">B</OPTION>   
            <OPTION   VALUE="C">C</OPTION>
            <OPTION   VALUE="D">D</OPTION>
            <OPTION   VALUE="S">S</OPTION>   
            <OPTION   VALUE="J">J</OPTION>
            <OPTION   VALUE="G">G</OPTION>
             </select> 
      
              
             
             
              <br>  <br> 
             <input   class="btn  btn-success form-control" type="submit"    value="Generar reporte"> 
        
          
      </form> 
   
