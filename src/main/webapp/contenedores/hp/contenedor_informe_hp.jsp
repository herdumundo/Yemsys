<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../chequearsesion.jsp" %>
<%    String titulo = request.getParameter("titulo");
   String version=clases.versiones.contenedores_informes_alimentados_hp;
        String version_desc=clases.versiones.desc_contenedores_informes_alimentados_hp;
     %> 

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>','<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                HP
            </div>
        </div>
        <center><b>INFORME DE ALIMENTADOS</b></center>
    </div>
</div> 
    
<div id="contenedor_boton"> </div>

<br> 

<div class="form-group">
    <div class="input-group">
        <input type="text" placeholder="INGRESE FECHA DE ALIMENTACION" name="txt_fecha" id="txt_fecha" class="form-control datepicker"  />
      
        <span class="input-group-addon">-</span>
        <input type="button" value="BUSCAR" onclick="consulta_grilla_hp_alimentacion($('#txt_fecha').val());" class="form-control btn btn-dark"/>
    </div>
</div>

 


<div id="div_grilla">
    
    
</div>    



