<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%  String version = contenedores_bal_solicitudad_cambio_formula;
    String version_desc = desc_contenedores_bal_solicitudad_cambio_formula;
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
  
%>

 
<form   method="post"  id="formulario" >


 