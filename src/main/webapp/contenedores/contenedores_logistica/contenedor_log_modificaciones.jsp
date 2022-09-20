<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>

<%
    String version =  contenedores_log_logModificaciones;
    String pdf =  pdf_contenedores_log_logModificaciones;
    

%>  
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>','','<%=pdf%>',true)">
    <label ><%=version%></label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                LOG
            </div>
        </div>
        <center><b>LOG DE MODIFICACIONES</b></center>
    </div>
</div>   
  


 
<table>
    <thead>
    <th>Fecha desde</th>
    <th>Fecha hasta</th>
    </thead>
    <tbody>
        <tr>
            <td> <input type="text" class="datepicker" style='color: #000; background: white; font-weight: bold; ' id="desde" ></td>
            <td><input type="text"  class="datepicker"  style='color: #000; background: white; font-weight: bold; '  id="hasta" ></td>
        </tr>
         <tr>
             <td colspan="2"><input type="button" class="bg-navy form-control"  style='color: #ffffff; background: white; font-weight: bold; ' value="BUSCAR" onclick="gen_cab_log_modificaciones_log()"></td>
         </tr>
    </tbody>
</table>
    

<div id="div_grilla">


</div>

<div id="div_grilla2">


</div>







 <div class="container my-4">
     
        <!-- Modal -->
        <div class="modal fade right" id="exampleModalPreview" tabindex="-1" role="dialog" aria-labelledby="exampleModalPreviewLabel" aria-hidden="true">
            <div class="modal-dialog-full-width modal-dialog momodel modal-fluid" role="document">
                <div class="modal-content-full-width modal-content ">
                    <div class=" modal-header-full-width   modal-header text-center">
                       <b>0004-PAN-01032022-A</b>  <button type="button" class="close " data-dismiss="modal" aria-label="Close">
                            <span style="font-size: 1.3em;" aria-hidden="true">&times;</span>
                        </button>
                       

                    </div>
                    <div class="modal-body">
                         
                        <div id="contenido_grillas"   class="table-responsive"  >

                        </div>  
                        <div id="contenido_grillas_mixto"   class="table-responsive">

                        </div>  
                    </div>
                    <div class="modal-footer-full-width  modal-footer">
                        <button type="button" class="btn btn-danger btn-md btn-rounded" data-dismiss="modal">Cerrar</button>
                     </div>
                </div>
            </div>
        </div>
    </div>