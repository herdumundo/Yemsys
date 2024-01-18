<%-- 
    Document   : contenedor_informe_desechos
    Created on : Jan 17, 2024, 11:30:42 AM
    Author     : jbernal
--%>
<%@include  file="../../../cruds/conexion.jsp" %>



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
        <center><b>INFORME DESECHOS</b></center>
    </div>
</div>

<label for="fecha">Ingrese fecha:</label>

<input type="text" class="datepicker" id="fechaDesechos" name="fecha">

<button id="btnInformeDesechos" class="form-control btn btn-success" style="width: 100%; display: block;" onclick="generarInformeDesechos()">Generar Informe Desechos</button>

<div id="informe_desechos">

</div>






