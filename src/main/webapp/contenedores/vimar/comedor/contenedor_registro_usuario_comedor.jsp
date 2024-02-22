<%-- 
    Document   : contenedor_registro_menu_diario
    Created on : Jan 18, 2024, 9:39:27 AM
    Author     : jbernal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../../cruds/conexion.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<%  String version = "";
    String version_desc = "";
    String fecha_actual = "";
    ResultSet rs, rsFechaActual;
    Statement st = connection.createStatement();
    Statement st1 = connection.createStatement();
    rs = st.executeQuery("select id_menu,LTRIM(menu) as menu from rrhh_menu where estado='A' order by LTRIM(menu)");
    rsFechaActual = st1.executeQuery("select convert(varchar,getdate(),103) as fecha_actual");
    while (rsFechaActual.next()) {
        fecha_actual = rsFechaActual.getString("fecha_actual");
    }
%>
<html>
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
        <center><b>REGISTRAR USUARIO COMEDOR</b></center>
    </div>
</div>

<body>
    <br>
    INGRESE NOMBRE Y APELLIDO:
    <input type="text" class="form-control" id="txt_nombre" placeholder="INGRESE NOMBRE Y APELLIDO">
    <br>
    INGRESE CI:
    <input type="number" class="form-control" id="txt_nro" min="1">
    <br>
    SELECCIONE ÁREA:
    <select class="form-control" id="txt_area">
        <option>PRODUCCION</option>
        <option>COMERCIAL</option>
        <option>LOGISTICA</option>
        <option>RECURSOS HUMANOS</option>
        <option>REPARTIDOR</option>
    </select>
    <br>
    <input type="button" class="form-control btn btn-primary" value="REGISTRAR" onclick='confirmar_registro_usuario();'>

</body>
</html>
