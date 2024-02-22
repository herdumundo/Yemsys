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
        <center><b>REGISTRO SEMANAL</b></center>
    </div>
</div>

<body>
<label for="fecha">Fecha:</label>

<input value="<%=fecha_actual%>"  type="text" class="datepicker form-control" id="fechaRegistro" name="fecha">

<select class='form-control' id='menuDiario' name='menu'>
    <option value="-" selected="selected">SELECCIONAR MENÚ</option>
    <% while (rs.next()) {%>
    <option value="<%=rs.getString("id_menu")%> - <%=rs.getString("menu")%>"><%=rs.getString("menu")%></option>
    <%  }%>
</select>

<button id="btnRegistroSemanal" class="form-control btn btn-primary" style="width: 100%; display: block;" onclick="cargar_datos()">Ingresar</button>
<br>
<button id="btnRegistroSemanalRegistro" class="form-control btn btn-danger" style="width: 100%; display: block;" onclick="confirmar_registro_menu()">Registrar</button>
<br>

<table id="tb_registro_semanal" class='table display'>
    <thead>
        <tr>

        <th>FECHA</th>
        <th>CODIGO</th>
        <th>MENU</th>
        <th>ACCION</th>
        </tr>
    </thead>
    <tbody></tbody>
</table>


<div id="divRegistroSemanal">

</div>

</body>
</html>
