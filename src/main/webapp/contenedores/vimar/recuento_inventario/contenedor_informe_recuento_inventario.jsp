<%-- 
    Document   : contenedor_desechos
    Created on : 16-ene-2024, 16:19:28
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@include  file="../../../versiones.jsp" %>

<%    
    String version = contenedores_vim_recuento_informe ;
    String version_desc = desc_contenedores_vim_recuento_informe;
        String pdf = pdf_vim_recuento_informe;
%>
<head>
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>','<%=pdf%>',true)">
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
        <center><b>INFORME RECUENTO DE INVENTARIO</b></center>
    </div>
</div>
    <label for="fecha">Ingrese fecha:</label>

<input type="text" class="datepicker" id="fecha" name="fecha">

<button id="btnInforme" class="btn btn-danger" style="width: 100%; display: block;" onclick="generarInformeRecuentoInventarioVimarCabecera()">Buscar</button>

<div id="div_grilla">

</div>

<div id="div_grilla_detalle">

</div>
 