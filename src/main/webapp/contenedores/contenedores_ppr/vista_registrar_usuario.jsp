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
<%@include  file="../../versiones.jsp" %>

<!DOCTYPE html>
 <%   //conexion
    //listar datos de tabla rol para registro de usuario
   PreparedStatement ps,ps2;
   ResultSet rs,rs2;
   clases.controles.VerificarConexion();
  
   try {
           
   ps=clases.controles.connectSesion .prepareStatement("select * from mae_yemsys_roles");
   rs=ps.executeQuery();
   ps2=clases.controles.connectSesion .prepareStatement("select * from mae_yemsys_areas");
   rs2=ps2.executeQuery();
   
     String version= contenedores_ppr_vista_registrar_usuario;
  
   %>
<html>
     
    <body>
      
      <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>
     
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
               <center><b>CREAR NUEVO USUARIO</b></center>   
               </div>
            <form id="form_add_user" method="post" class="form-control bg-navy" style=" height: 550px">
               
                 
                 <br>
                <strong ><a>NOMBRE</a></strong>
                
                <input class="form-control" style="width: 100%"  "type="text" placeholder="INGRESE NOMBRE"  autocomplete="off"  required    name="nombre" id="nombre">            
                 
                  
                 <strong ><a>USUARIO</a></strong>
               
                <input class="form-control" style="width: 100%"  "type="text" placeholder="INGRESE USUARIO"  autocomplete="off"  required    id="usuario" name="usuario" >            
                
                 <strong ><a>CONTRASEÑA</a></strong>
                
                  <input class="form-control" style="width: 100%"  "type="text" placeholder="INGRESE CONTRASEÑA"  autocomplete="off"  required    name="pass" id="pass">            
                 
              
                    <strong ><a>AREA</a></strong>
               
                <select class="form-control" id="clasificadora" name="clasificadora" >
                    <%
                    while(rs2.next()){
                    %>
                <option value="<%=rs2.getString("area")%>"><%=rs2.getString("descripcion")%></option>
                 <%} %>
                </select>
                <strong ><a>TIPO DE ACCESO AL SISTEMA(ROL)</a></strong>
                 
                <select class="form-control" id="select_rol" name="select_rol" >
                    <%
                    while(rs.next()){
                    %>
                <option value="<%=rs.getString("id")%>"><%=rs.getString("descripcion")%></option>
                 <%} %>
                </select>
                
		
                 <div class="modal-footer align-right " >
                    <input  class="btn bg-white"  type="button"   onclick="registrar_usuario_ppr()"    id="btn_add_usuario" value="REGISTRAR" >
                    
                    <input  class="btn bg-white"  type="button"  onclick="cancelar_usuarios_ppr()"   value="CANCELAR" >
                     
                    
                </div>
            </form>
        
    </body>
</html>
<%
    
       } catch (Exception e) {
       }
       finally{
        clases.controles.DesconnectarBDsession();
}
%>