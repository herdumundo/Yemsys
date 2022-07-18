<%-- 
    Document   : vista_registro_contador_huevo
    Created on : 26-ene-2022, 13:37:16
    Author     : aespinola
--%>
<script>
    var today = new Date();
    var dd = today.getDate(1);
    var mm = today.getMonth(1) + 1;
    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd
    }
    if (mm < 10) {
        mm = '0' + mm
    }

    today = yyyy + '-' + mm + '-' + dd;
    document.getElementById("fecha_naci").setAttribute("max", today);
    document.getElementById("fecha_pedido").setAttribute("max", today);

    function setInputDate(_id) {
        var _dat = document.querySelector(_id);
        var hoy = new Date(),
                d = hoy.getDate(),
                m = hoy.getMonth() + 1,
                y = hoy.getFullYear(),
                data;

        if (d < 10) {
            d = "0" + d;
        }
        ;
        if (m < 10) {
            m = "0" + m;
        }
        ;

        data = y + "-" + m + "-" + d;
        console.log(data);
        _dat.value = data;
    }
    ;


    setInputDate("#fecha_naci");
    setInputDate("#fecha_pedido");
    

</script>
<%@include  file="../../versiones.jsp" %>
<%    String version = contenedores_registro_necropsia;

%> 
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>   

<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                PPR
            </div>
        </div>
        <center><b>REGISTRO LOTES</b></center>
    </div>
</div>  <br> 


<div class="card m-4">

    <section class="content" id="contenido">
        <div class="text-center">


            <br>
            <div id="boton_nuevo_registro"style="margin-bottom:15px;" class=" tablagrilla input-group-append ocultar">

                <button class=" bg-navy"  onclick="modal_lotes_ppr()" >REGISTRAR NUEVO LOTE</button>
            </div>
            <center>
                <br>
                <div id="tabla_a"  style="width: 100% " class=" tablagrilla input-group-append ocultar"></div>
            </center>
            <center>
                <br>
                <div id="tabla_b" style="width: 100% "  class=" tablagrilla input-group-append ocultar_div_editar"></div>
            </center><!-- v -->
            <center>
                <br>
                <div id="tabla_h" class=" tablagrilla input-group-append "></div>
            </center>


        </div>


    </section>
</div>
<div class="modal fade" id="ppr_lote_form" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="ppr-necro-form" name="ppr-necro-form" autocomplete="off" class="form form-horizontal">
                <div class="modal-header bg-navy">
                    <h class="modal-title">REGISTRO NUEVO LOTE</h>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="row mt-3">
                            <div class="col-12 col-md-5">
                                <div class="form-group">
                                    <H5> <label class="form-control-placeholder">Nombre lote</label></H5>
                                    <input  type="text" id="nombrelote"  name="nombrelote" class="tablagrilla form-control" required="">
                                    <input  type="hidden" id="idlote"  name="idlote" class="tablagrilla form-control" required="">
                                </div>
                            </div>
                            <div class="col-12 col-md-5">
                                <div class="form-group">
                                    <H5> <label class="form-control-placeholder">Lote cantidad pedido</label></H5>
                                    <input  type="text" id="lote_pedido" name="lote_pedido" class="tablagrilla form-control" required>
                                </div>
                            </div>
                            <div class="col-12 col-md-5">
                                <div class="form-group">
                                    <H5> <label class="form-control-placeholder">Lote raza</label></H5>
                                    <input  type="text" id="raza_lote" step="1 name="raza_lote" min="2014-10-01" class="tablagrilla form-control" required="">
                                </div>
                            </div>
                              <div class="col-12 col-md-5">
                                <div class="form-group">
                                    <H5> <label class="form-control-placeholder">Fecha lote pedido</label></H5>
                                    <input  type="date" id="fecha_pedido"  name="fecha_pedido" min="2014-10-01" class="tablagrilla form-control text-center"  required="">
                                </div>
                            </div>
                            <div class="col-12 col-md-5">
                                <div class="form-group">
                                    <H5> <label class="form-control-placeholder">Fecha lote nacimiento</label></H5>
                                    <input  type="date" id="fecha_naci"  name="fecha_naci" min="2014-10-01" class="tablagrilla form-control text-center"  required="">
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="cambio" type="button"  class="bg-navy ">Registrar</button>
                    <button type="button" class="bg-navy" data-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>




</div>
<div  id="ppr_necro_editar" class="modal"  tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">


    <div class="modal-content-full-width modal-content ">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                <span aria-hidden="true">×</span>
            </button>
        </div>
        <div class="modal-body">


        </div>
        <div class="modal-footer">
            <button type="button" class="btn bg-navy btn-md btn-rounded" data-dismiss="modal">Cerrar</button>
        </div>
    </div>

</div>






















