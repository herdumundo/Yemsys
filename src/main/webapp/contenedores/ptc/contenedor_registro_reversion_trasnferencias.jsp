<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
 <%   
    String version= contenedores_ptc_reversion_transferencias;
    String pdf=pdf_contenedores_ptc_reversion_transferencias;
%>
    <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>','','<%=pdf%>',true)">
    <label ><%=version%> </label> 
</div>
</head>     
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>REVERSION DE TRANSFERENCIAS PTC</b></center>
</div>
   </div>  <br>           
   
   <form method="post" id="formulario"  >
        <b>Fecha de transferencia</b>
        <input id="calendario"   class="datepicker" type="text"   width="276" onchange="consultar_transferencias_reversiones_ptc()"   />

        <div id="divContenedor">
            
        </div>
 </form> 
          