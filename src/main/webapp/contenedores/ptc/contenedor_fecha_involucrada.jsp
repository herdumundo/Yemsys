<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../chequearsesion.jsp" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>


 <% 
     String version=clases.versiones.contenedores_ptc_contenedor_fecha_involucrada;

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
    <center><b>REGISTROS DE FECHAS INVOLUCRADAS</b></center>
</div>
   </div>  <br>        
            <label for="calendario_correccion"><b>FECHA DE PUESTA</b></label>
            <input id="calendario_correccion"  class="datepicker" type="text" onchange="traer_detalle_fecha_involucrada($('#calendario_correccion').val());filtro_eliminar(); visible_div_eliminar()"   />
      
         <div id="div_id_involucrada"   class="input-append">
        
        </div>      
   
         <form id="formulario_correccion" method="POST" >  
        <div class="modal fade" id="cuadro1" tabindex="1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-footer">
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center" id="div_titulo">
                        CORRECIONES   
                        </div> 
                        <br> 
                    </div>
                    <div class="modal-footer">
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center">
                            <label  >FECHA INVOLUCRADA:</label>
                            <input id="txt_fecha_involucradas" name="txt_fecha_involucradas" autocomplete="off"  type="text" placeholder="FECHAS INVOLUCRADAS" required="required"/>
                        </div> 
                    </div>
                    <div class="modal-footer">
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center">
                            <input type="hidden" id="cantidad_huevos" name="cantidad_huevos"  value="0" > 
                            <input  id="txt_cod_lote" name="txt_cod_lote"  type="hidden" >
                            <input type="hidden" id="cod_interno" name="cod_interno"   > 
                        </div>  
                    </div>  

                    <div class="modal-footer">
                        <h5 class="modal-title" id="exampleModalLabel"></h5>
                        <div class="form-control-range text-center">
                            <input type="submit" class="btn btn-primary " id="btn_insertar_correccion"  value="REGISTRAR" name="btn_insertar_correccion"  > 

                        </div>  
                    </div>   
                </div>
            </div> 
        </div>     
    </form>
 
 <div id="mensaje_correccion"> </div>
 