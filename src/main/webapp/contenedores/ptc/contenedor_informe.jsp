<!DOCTYPE html>
 <%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%    String usuario = (String) sesionOk.getAttribute("usuario");
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    sesionOk.setAttribute("area", clasificadora);
    String user_name = (String) sesionOk.getAttribute("nombre_usuario");
%>
     

   <% 
     String version= contenedores_ptc_contenedor_informe;

       %> 
  <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')" >
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
    <center><b>VISUALIZACIÓN DE REGISTROS POR FECHA DE CLASIFICACIÓN </b></center>
</div>
   </div>  <br>       

<div class="form-group">
    <div class="input-group">
        <b>Fecha de clasificación</b>
        <input id="calendario_informe"   class="datepicker" type="text"   width="276"    />


        <span class="input-group-addon">-</span>
        <div class="input-append">  
            <select class="form-control" name="estado" id="estado"  >
                <OPTION selected value=""  >Estado liberacion</OPTION>

                <OPTION VALUE="L">Liberado</OPTION> 
                <OPTION VALUE="R">Retenido</OPTION> 


            </select>             </div>

        <span class="input-group-addon">-</span>


        </select>   <span class="input-group-addon">-</span>

        <!--<input type="button" value="BUSCAR" onclick="grilla_cantidad_liberacion($('#calendario_informe').val()); principal_grilla($('#calendario_informe').val(),$('#estado').val(),$('#tipo_huevo').val());grilla_cajones();grilla_carritos();filtro()" class="form-control btn-primary">
        !-->

        <input type="button" value="BUSCAR" onclick="buscar_lotes_visualizacion();" class="form-control btn-primary">
    </div>
</div>




<div  id="cabecera_informe">



</div> 

<br>   

<div id="div_tabla_general">

</div>





<form id="formulario_editar" method="post"> 
    <div class="modal fade" id="modal_obs" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">AGREGAR COMENTARIO</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden"  id="id_lote"    >
                    <a>MODIFICAR COMENTARIO</a>
                    <input type="text" placeholder="INGRESAR COMENTARIO" id="txt_comentario"> <br>
                    <a>MODIFICAR LIBERADO POR</a>

                    <input type="text" placeholder="LIBERADO POR" id="txt_liberado">
                </div>
                <br><br><br>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button"  onclick="modificar_visualizacion($('#id_lote').val(), $('#txt_comentario').val(), $('#txt_liberado').val())" data-dismiss="modal" >Registrar </button>
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>

                </div>
            </div>
        </div>
    </div>
</form>
