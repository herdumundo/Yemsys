<% 
     String version=clases.versiones.contenedores_logistica_contenedor_reporte;
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
LOG
</div>
</div>
    <center><b>REPORTES DE PEDIDOS GENERADOS</b></center>
</div>
   </div>  <br>  
 <a style='color: #000; background: white; font-weight: bold; '> Tipo de reporte</a>
<select id="cbox_tipo" class="bg-navy" style='color: #fff; background: white; font-weight: bold; ' onchange="filtro_reporte_pedidos_log($('#cbox_tipo').val())">
    <option value="7">GENERADOS</option>
    <option value="1">PENDIENTES FACTURACION</option>
    <option value="2">PENDIENTES A EMBARCAR</option>
    <option value="5">EMBARCADOS</option>
    
</select>

<br><br>
<div id="contenedor_fechas">
<a style='color: #000; background: white; font-weight: bold; ' >Fecha desde</a>
<input type="text" class="datepicker" style='color: #000; background: white; font-weight: bold; ' id="desde" >
<br><br>
<a style='color: #000; background: white; font-weight: bold; ' >Fecha hasta</a>
<input type="text"  class="datepicker"  style='color: #000; background: white; font-weight: bold; '  id="hasta" ><!-- comment -->
</div>
<br><br><br><br>
<input type="button" class="bg-navy form-control"  style='color: #ffffff; background: white; font-weight: bold; ' value="BUSCAR" onclick="buscar_reporte_pedidos_log()">


<div id="div_grilla">
    
    
</div>