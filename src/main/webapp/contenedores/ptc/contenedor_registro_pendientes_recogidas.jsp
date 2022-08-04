<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    String version = contenedores_ptc_contenedor_registro_pendientes_recogidas;
    Statement stmt;
    ResultSet rs;
    stmt = connection.createStatement();
    rs = stmt.executeQuery(" select convert(varchar,fecha_puesta,103) as fp,* from  mae_ptc_pendientes_recogidas where clasificadora='" + clasificadora + "' and estado='1'");
%>
<head>  
<label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')" >
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
        <center><b>REGISTRO DE HUEVOS PENDIENTES DE RECOGIDAS</b></center>
    </div>
</div>  <br>       


<form id="formulario" action="post">
    <div class="form-control bg-warning" style="font-weight: bold;color:black;" onclick="grilla_recogidas_liberadas()" ><center>Huevos pendientes de recogidas</center></div>
    <a>Fecha puesta</a>
    <input type="text" id="fecha_puesta" name="fecha_puesta" placeholder="Ingrese fecha de puesta" class="form-control  datepicker" required>
    <br>
    <a>Cantidad</a>

    <input type="number" class="form-control" id="txt_cantidad" name="txt_cantidad" placeholder="Ingrese cantidad" required>
    <br>
    <input type="submit" class="form-control btn-primary" value="Registrar"  >

    <div id="grilla_recogida">

        <table id="grilla_eliminar" class="table table-striped table-bordered" style="width:100%">
            <thead>

            <th>
                Fecha de puesta
            </th>
            <th>
                Cantidad
            </th>
            <th>
                Liberar
            </th> 
            <th>
                Eliminar
            </th> 
            </thead>
            <tbody id="grilla_liberar">
                <%
                while (rs.next()) {%>  
                <tr id="<%=rs.getString("id")%>">  
                    <td> <b><%=rs.getString("fp")%>  </b></td>
                    <td> <b><%=String.format("%,d", rs.getInt("cantidad"))%></b></td>

                    <td> <i class="fas fa-cart-plus fa-2x text-warning  " onclick="liberar_recogida('<%=rs.getString("id")%>', 'DESEA LIBERAR LOS PENDIENTES?', '2')" ></i>
                    <td> <i class="fas fa-trash fa-2x text-danger  " onclick="liberar_recogida('<%=rs.getString("id")%>', 'DESEA ELIMINAR EL REGISTRO?', '5')" ></i>
                    </td>  
                    <%}

                        clases.controles.DesconnectarBD();
                    %>   
                </tr> 
            </tbody>   
        </table>   
    </div>
</form>   