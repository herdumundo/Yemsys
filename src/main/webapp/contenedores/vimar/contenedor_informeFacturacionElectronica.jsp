<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%     String version = contenedores_vimar_facturacionElectronica;
%>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')">
    <label ><%=version%> </label> 
</div>
</head>     
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                VIM
            </div>
        </div>
        <center><b>INFORME DE FACTURACION ELECTRONICA VIMAR</b></center>
    </div>
</div>  <br>           

<form method="post" id="formulario"  >
    <b>Fecha inicio</b>
    <input id="fechaInicio"   class="datepicker" type="text"   width="276"    />

    <b>Fecha final</b>
    <input id="fechaFinal"   class="datepicker" type="text"   width="276" onchange="vimarConsultarFacturasElectronicas()"   />
 

    <table id="myTable"   data-row-style="rowStyle" class="table display" data-toggle="table" data-click-to-select="true" >
        <thead>
            <tr >
                <th>Accion</th>
                <th>Nro_Interno_SAP</th>
                <th>Tipo_de_Obeto_SAP</th>
                <th>Tipo_de_Documento</th>
                <th>DocNum</th>
                <th>Fecha_de_Documento</th>
                <th>Punto_de_Establecimiento</th>
                <th>Punto_de_Emision</th>
                <th>Folio</th>
                <th>Timbrado</th>
                <th>Numero_de_comprobante</th>
                <th>Serie</th>
                <th>Codigo_de_Cliente</th>
                <th>Nombre_de_Cliente</th>
                <th>Direccion</th>
                <th>RUC</th>
                <th>Vendedor</th>
                <th>Cancelado_en_SAP</th>
                <th>ID_SSC</th>
                <th>CDC</th>
                <th>Estado</th>
                <th>Observacion</th>
                <th>Insercion</th>
                <th>Actualizacion</th>
                <th>Origen</th>
                <th>Archivo_XML</th>
                <th>DocDate</th>
            </tr>
        </thead>
        <tbody>
        </tbody>


    </table> 
</form> 
