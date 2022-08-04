<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../consultas/ptc/consulta_gen_options_disposicion.jsp" %> 
<%    String version = contenedores_ptc_contenedor_reemplazo_motivos;
%>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')">
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
        <center><b>MODIFICACIÓN DE MOTIVO DE RETENCION, ESTADO DEL PRODUCTO Y DISPOSICIÓN</b></center>
    </div>
</div>  <br>       



<div id="div_grilla"></div>

 
<div class="modal fade" id="modal_liberar"      tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form method="post"   id="form_motivo_retencion">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" id="div_header">

                </div>
                <div class="modal-body">
                    <input type="hidden" id="cod_lote" name="cod_lote">
                    <input type="hidden" id="cod_interno"name="cod_interno">
                    <div id="div_calendario"  >  
                        <a>SELECCIONAR MOTIVO DE RETENCION</a>
                        <select style="font-weight: bold;" class="form-control"  multiple="multiple" name="motivo_retencion"  id="motivo_retencion" required="true" >
                            <%=option_motivo_retencion%>  
                        </select> 
                    </div>
                </div>
                <button class="btn btn-secondary" type="button" id="btn_motivo" onclick="reemplazar_motivo_retencion()" >REEMPLAZAR MOTIVO DE RETENCION</button><!-- control_reemplazar_motivo_retencion.jsp -->
                <div id="div_cargar" class="text-center" style="display: none">
                    <div class="spinner-border" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div> <br>
                <button class="btn btn-danger" type="button" id="btn_cancelar" data-dismiss="modal">CANCELAR</button>
            </div>
        </div>
    </form>
</div>



<form method="post"   id="form_estado_producto">

    <div class="modal fade " id="modal_estado_producto"      tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" id="div_header_estado">

                </div>
                <div class="modal-body">
                    <input type="hidden" id="cod_lote_estado" name="cod_lote_estado">
                    <input type="hidden" id="cod_interno_estado"name="cod_interno_estado">

                    <div id="div_calendario"  >  
                        <a>SELECCIONAR ESTADO DEL PRODUCTO</a>
                        <select style="font-weight: bold;" class="form-control" required="true" name="estado_producto" id="estado_producto">
                            <OPTION style="font-weight: bold;" selected disabled>Estado de liberación</OPTION>
                            <OPTION style="font-weight: bold;" VALUE="NC">NO CONFORME</OPTION> 
                            <OPTION style="font-weight: bold;"VALUE="PNC">POTENCIALMENTE NO CONFORME</OPTION>
                            <OPTION style="font-weight: bold;" VALUE="PNC-NC">POTENCIALMENTE NO CONFORME - NO CONFORME</OPTION>
                        </select>   



                    </div>
                </div>
                <button class="btn btn-secondary" type="button" id="btn_producto" onclick="reemplazar_estado_producto()" >REEMPLAZAR ESTADO DEL PRODUCTO</button> <!--control_reemplazar_estado_producto.jsp -->
                <div id="div_cargar_estado" class="text-center" style="display: none">
                    <div class="spinner-border" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div> <br>
                <button class="btn btn-danger" type="button" id="btn_cancelar" data-dismiss="modal">CANCELAR</button>

            </div>
        </div>

    </div>

</form>




<form method="post"   id="form_disposicion">

    <div class="modal fade " id="modal_disposicion"      tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" id="div_header_disposicion">

                </div>
                <div class="modal-body">
                    <input type="hidden" id="cod_lote_disposicion" name="cod_lote_disposicion">
                    <input type="hidden" id="cod_interno_disposicion"name="cod_interno_disposicion">

                    <div id="div_calendario"  >  
                        <a>SELECCIONAR DISPOSICION</a>
                        <select style="font-weight: bold;" class="form-control" required="true" name="disposicion_select" id="disposicion_select">
                            <%=option_disposicion%>  
                        </select>   



                    </div>
                </div>
                <button class="btn btn-secondary" type="button" id="btn_disposicion" onclick="reemplazar_disposicion()" >REEMPLAZAR DISPOSICION</button> <!--contenedor_reemplazo_disposicion.jsp -->
                <div id="div_cargar_disposicion" class="text-center" style="display: none">
                    <div class="spinner-border" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div> <br>
                <button class="btn btn-danger" type="button" id="btn_cancelar_disposicion" data-dismiss="modal">CANCELAR</button>

            </div>
        </div>

    </div>

</form>

