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
    PreparedStatement ps;
    ResultSet rsReporte;
    Statement st = connection.createStatement();

    rsReporte = st.executeQuery("select idtransferencia, fecha_contabilizacion, origen, destino, CardCode,CardName, Address, ItemCode, ItemName, loteLargo, loteCorto, BarCode, Quantity, observacion, observacion_detalle from vim_transferencia_produccion with(nolock)");
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
        <center><b>INFORME AVERIADOS VIMAR</b></center>
    </div>
</div>

<label for="fecha">Ingrese fecha:</label>

<input type="text" class="datepicker" id="fecha" name="fecha">

<button id="btnInforme" class="btn btn-danger" style="width: 100%; display: block;" onclick="generarInformeAveriados()">Informe Averiados</button>

<div id="informe_transferencia_averiados">

</div>





