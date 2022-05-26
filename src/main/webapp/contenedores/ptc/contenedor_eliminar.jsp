 <%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <%@include  file="../../chequearsesion.jsp" %>
<%    
    String usuario = (String) sesionOk.getAttribute("usuario");
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    String user_name = (String) sesionOk.getAttribute("nombre_usuario");

%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
       <% 
     String version=clases.versiones.contenedores_ptc_contenedor_eliminar;

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
    <center><b>ELIMINACIÓN DE REGISTROS</b></center>
</div>
   </div>  <br>             
 
     <div class="container-fluid">
        
         <a>Fecha de puesta</a>
         <input    id="text_id_eliminar" name="text_id_eliminar" type="text" style="display: none" >
       
       
     <div class="input-append">  
         <input id="calendario_eliminar"  class="datepicker" type="text"  />
  </div>     <br>
          <button   class=" form-control btn btn-primary " onclick="traer_detalle_eliminar($('#calendario_eliminar').val());filtro_eliminar(); visible_div_eliminar()">BUSCAR</button> 
    <br>   <br>   
       
        <div   id="id_div">
         
           
         
        </div>  
        </div>      
        </div>
        
        
        
        
      