<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../consultas/ptc/consulta_gen_options_disposicion.jsp" %>
<%    String version = contenedores_ptc_contenedor_disposicion;

%> 
<head>  
<label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                PTC
            </div>
        </div>
        <center><b>CAMBIO DE DISPOSICIÓN Y LIBERACION DE REPROCESADOS</b></center>
    </div>
</div>  <br>              

<form id="formulario_reproceso" method="post" >
    <select  name="tipo" required   id="tipo" class="form-control"   >
        <OPTION selected disabled>SELECCIONAR FILTRO POR FECHA DE PUESTA O CLASIFICACION</OPTION>
        <option value="P">FECHA DE PUESTA</option>
        <option value="C">FECHA DE CLASIFICACION</option>
    </select>
    <div class="form-group">
        <a>INGRESAR FECHA</a>   
        <div class="input-group">

            <input id="calendario_reproceso" name="calendario_reproceso" type="text" class="datepicker"  width="276"   />

            <span class="input-group-addon">-</span>
            Disposicion actual
            <select class="form-control" required="true" name="disposicion" id="disposicion"  onchange="accion_combo_ptc();">
                <OPTION selected disabled>Disposición actual</OPTION>
                    <%=option_disposicion%>  
            </select> 
        </div> 
    </div>

    <br>
    <br>


    <div id="div_disposicion"  style="display: none;">
        Cambio de disposicion

        <select class="form-control" required="true" name="disposicion_insert" id="disposicion_insert" onchange="funcion_disposicion();">
            <OPTION selected disabled>Cambio de disposicion</OPTION>
                <%=option_disposicion%>  

        </select>  
    </div>

    <div id="div_fecha_ali" style="display: none;">

        <br>

        Fecha de alimentacion
        <input id="calendario_alimentacion" name="calendario_alimentacion" class="datepicker" type="text"  width="276"/>
        <br>
        <br>
        <input type="text"  id="txt_lib" name="txt_lib" placeholder="LIBERADO POR" class="form-control">
        <br>  

        <br>
        <input type="text"  id="txt_nro_mesa" name="txt_nro_mesa" placeholder="OBSERVACION" class="form-control">
        <br>

        <input type="text" name="caja_check" style="display: none"  id="caja_check"  >
        <br>

    </div>


    <div id="div_registro" style="display: none">
        <input type="button" class="form-control bg-primary "style="font-weight: bold;color:black;" value="REGISTRAR" onclick=" Enviar_datos_cambio_disposicion_lib();">
    </div>
    <div id="contenedor_grilla_reproceso" >

    </div>

</form>


