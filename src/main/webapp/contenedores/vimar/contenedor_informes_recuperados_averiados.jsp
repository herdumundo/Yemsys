<%-- 
    Document   : contenedor_transferencia_vimar
    Created on : 16-ago-2023, 8:53:36
    Author     : hvelazquez
--%>

<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    String version = "";
    String version_desc = "";
%>

<head>
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                VIM
            </div>
        </div>
        <center><b>INFORME RECUPERADOS AVERIADOS VIMAR</b></center>
    </div>
</div>

<label for="fecha">FECHA DESDE:</label>

<input type="text" class="datepicker form-control" id="fecha_desde" name="fechaDesde">

<label for="fecha">FECHA HASTA:</label>

<input type="text" class="datepicker form-control" id="fecha_hasta" name="fechaHasta">

<br>

<button id="btnInforme" class="btn btn-primary" style="width: 100%; display: block;" onclick="informeRecuperadosAveriados()">INFORME RECUPERADOS</button>

<br>


<div id="informe_recuperados_averiados">

</div>





