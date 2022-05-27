<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../chequearsesion.jsp" %>
<%    String titulo = request.getParameter("titulo");
   String version=clases.versiones.contenedores_alimentacion_hp;
        String version_desc=clases.versiones.desc_contenedores_alimentacion_hp;
     %> 

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>','<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head><!-- comment --><div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                HP
            </div>
        </div>
        <center><b>ALIMENTACION PARA HUEVO EN POLVO</b></center>
    </div>
</div> 
    
<div id="contenedor_boton"> </div>

<br> 

<div class="form-group">
    <div class="input-group">
        <input type="number" placeholder="LOTE" name="txt_lote" id="txt_lote" class="form-control" onkeypress="cargar_datos_key_hp_alimentacion();"/>
        <span class="input-group-addon">-</span>
        <input type="button" value="INGRESAR" name="btn_ingresar" id="btn_ingresar" onclick="consulta_lotes_reproceso_alimentacion($('#txt_lote').val());" class="form-control btn btn-dark"/>
    </div>
</div>

    <input type="button" value="REGISTRAR"  onclick="enviar_datos_alimentacion_hp();" class="form-control btn bg-navy"/>



<a id="id_cantidad">Cantidad</a>

<table id="grilla_transfer" data-row-style="rowStyle" data-toggle="table"  class="table table-striped table-bordered" data-click-to-select="true">
    <thead>
        <tr>
            <th>ID</th>
            <th>CARRO</th>
            <th>CANTIDAD</th>
            <th>PLANCHAS</th>
            <th>UNIDADES</th>
            <th>FECHAPUESTA</th>
            <th>TIPO</th>
            <th>TIPO FALLA</th>
            <th>ORIGEN</th>
            <th>ACCION</th>
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>      



