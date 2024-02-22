<%-- 
    Document   : contenedor_asignacion_usuarios_linea_prod
    Created on : 08-ene-2023, 8:53:36
    Author     : jbernal
--%>
<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 

<%
    String version = "";
    String version_desc = "";
    
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
        <center><b>ELIMINAR USUARIO</b></center>
    </div>
</div>

<div id="div_grilla_eliminar_usuario">



</div>
 


