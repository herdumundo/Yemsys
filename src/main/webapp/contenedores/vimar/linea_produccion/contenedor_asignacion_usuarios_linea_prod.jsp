<%-- 
    Document   : contenedor_asignacion_usuarios_linea_prod
    Created on : 08-ene-2023, 8:53:36
    Author     : jbernal
--%>
<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 

<%  JSONObject ob = new JSONObject();
    String version = "";
    String version_desc = "";
    String grilla_html = "";
    PreparedStatement ps;
    ResultSet rsUsuarios;
    Statement st = connection.createStatement();

    rsUsuarios = st.executeQuery("select distinct T1.cod_usuario, T1.nombre,"
            + " isnull(T2.linea, 'No asignado') as linea "
            + "from usuarios T1 "
            + "left outer join "
            + "vim_yemsys_usuario_linea T2 on T1.cod_usuario=T2.idUsuario"
            + " where T1.clasificadora='L'");
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
        <center><b>ASIGNACIÓN DE USUARIOS - LINEA DE PRODUCCIÓN</b></center>
    </div>
</div>

<div id="div_grilla_asignacion">



</div>
 

<div class="modal fade" id="miModal" tabindex="1" role="dialog">
    <input type="hidden" value="" id="idUsu" >
    <input type="hidden" value="" id="nombreUsu">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="h5modal"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L1')">L1</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L2')">L2</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L3')">L3</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L4')">L4</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L5')">L5</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L6')">L6</a>
                    <a href="#" class="list-group-item list-group-item-action" onclick="seleccionarOpcion('L7')">L7</a>
                </div>
            </div>
        </div>
    </div> 
</div>

<!--<div class="container">
  <button type="button" class="btn btn-primary" onclick="showAlert()">Mostrar alerta</button>
</div>-->
