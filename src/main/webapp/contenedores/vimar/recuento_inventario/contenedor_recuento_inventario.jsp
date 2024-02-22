<%-- 
    Document   : contenedor_desechos
    Created on : 16-ene-2024, 16:19:28
    Author     : hvelazquez
--%>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@include  file="../../../versiones.jsp" %>

<%    String version = contenedores_vim_recuento;
    String version_desc =desc_contenedores_vim_recuento;
        String pdf = pdf_vim_recuento;
    //   String queryUbicacion="select  distinct b.WhsCode,b.WhsName  from vimar.dbo.oibt a inner join vimar.dbo.OWHS b on a.WhsCode=b.WhsCode ";
    String queryUbicacion = "select  *  from vimar.dbo.OWHS ";

    PreparedStatement ps;
    ResultSet rs;
    StringBuilder options = new StringBuilder();
    ps = connection.prepareStatement(queryUbicacion);
    rs = ps.executeQuery();
    options.append("<option class='text-center' value=''> </option>");
    while (rs.next()) {
        options.append("<option class='text-center' value='").append(rs.getString("WhsCode")).append("'>").append(rs.getString("WhsName")).append("</option>");
    }
%>
<head>
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>','<%=pdf%>',true)">
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
        <center><b>RECUENTO DE INVENTARIO</b></center>
    </div>
</div>
   <style>
        h1 {
            color: Green;
        }
 
        div.scroll {
            margin: 4px, 4px;
            padding: 4px;
             width: 100%;
            overflow: auto;
            white-space: nowrap;
        }
    </style>
<div id="grupo_itemCodeCargados" class="btn-group btn-group-toggle scroll" data-toggle="buttons">
                    
</div>

<input type="button" value="Finalizar Inventario" class="form-control bg-navy" onclick="registrarRecuentoInventario()">
<select class=" selectpicker form-control bg-warning "    data-selected-text-format="count" data-live-search="true" name="ubicacion" id="ubicacion"  required="true" onchange="irGrillaRecuentoInventarioVimar()" >
    <%=options.toString()%>
</select> 

<div id="divGrupos">

</div>