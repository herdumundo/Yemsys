<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@ page session="true" %>
<%@include  file="../../../versiones.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%       
    String version = "Test";
    String desc_version = "Test";
  

%>

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block " href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', 'DESCRIPCION:<%=desc_version%>')">
    <label ><%=version%> </label>  
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                PPR
            </div>
        </div>
        <center><b>CREACION DE NUEVA RAZA</b></center>
    </div>
</div>      
 

<input type="button" value="Crear raza" class="bg-navy form-control" onclick="cuadroCrearRaza()" >
<div id="div_grilla_pry">
    

</div>
 