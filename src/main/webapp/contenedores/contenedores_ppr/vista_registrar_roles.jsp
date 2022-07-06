<%-- 
    Document   : vista_registrar_usuario
    Created on : 29-dic-2021, 12:05:34
    Author     : aespinola
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <%@include  file="../../versiones.jsp" %>

     <% 
     String version= contenedores_ppr_vista_registrar_roles;
 
    %> 
       <head>
     
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>

    </head>
    <body>
      
     
         <div    class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto">
      </ul>
    </div>
    
       <div id="response">
            </div>
            <div class="position-relative p-3 bg-navy"  >
             <div class="ribbon-wrapper">
             <div  class="ribbon bg-warning">
                 <small>SEGURIDAD</small>
             </div>
             </div>
               <center><b>CREAR NUEVO ROL</b></center>   
               </div>
            <form id="form_add_user" method="post" class="form-control bg-navy" style=" height: 200px; ">
               
                 
                 <br>
                <strong ><a>DESCRIPCION</a></strong>
                
                <input class="form-control" style="width: 100%"  "type="text" placeholder="INGRESE DESCRIPCION ROL"  autocomplete="off"  required    name="descripcion" id="descripcion">            
                 
                 
             
               
		
                 <div class="modal-footer align-right " >
                     <input  class="btn bg-white"  type="button" onclick="registrar_roles_ppr()"     id="btn_add_usuario_rol" value="REGISTRAR" >
                    
                    <input  class="btn bg-white"  type="button"  onclick="cancelar_usuarios_ppr()"   value="CANCELAR" >
                     
                    
                </div>
            </form>
        
    </body>
</html>
