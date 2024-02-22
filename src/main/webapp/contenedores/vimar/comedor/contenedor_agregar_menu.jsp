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
        <center><b>AGREGAR MENÚ</b></center>
    </div>
</div>

<body>
    <form method="post"   id="formulario " name="formulario ">
        <div class="form-group">



            <input type="text" id="txt_menu" name="txt_menu"  class="form-control" placeholder="INGRESAR NOMBRE DEL MENU" onkeyup="var start = this.selectionStart;  var end = this.selectionEnd;  this.value = this.value.toUpperCase();  this.setSelectionRange(start, end);"/>


        </div>

        <div class="form-group"> 



            <input  type="button" value="REGISTRAR" id="btn_registrar" name="btn_registrar" onclick="validar_menu();" class="form-control btn btn-danger example2" />

        </div>



    </form><br>

    <div id="contn"></div>

</body>
</html>
