<%-- 
    Document   : contenedor_transferencia_vimar
    Created on : 16-ago-2023, 8:53:36
    Author     : hvelazquez
--%>

<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    
    String version = "";
    String version_desc = "";
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
    Statement st = connection.createStatement();
    Statement st2 = connection.createStatement();
    rs = st.executeQuery("SELECT  [id]  ,[descripcion]  ,[id_estado]  ,[tipo] FROM [vim_motivos]"); 
    rs2 = st2.executeQuery("SELECT  [id]  ,[descripcion]  ,[id_estado]  ,[tipo] FROM [vim_motivos]"); 
%>
<style>
     tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                VIM
            </div>
        </div>
        <center><b>TRANSFERENCIA VIMAR</b></center>
    </div>
</div> 
ORIGEN
<select class="form-control" id="selectOrigen" >
    <%while(rs.next()){%>
        <option codigo="<%=rs.getString("id")%>" descripcion="<%=rs.getString("descripcion")%>" ><%=rs.getString("descripcion")%></option>  
      <%  }%>
</select>
 

DESTINO
 <select class="form-control" id="selectDestino" >
    <%while(rs2.next()){%>
        <option codigo="<%=rs2.getString("id")%>" descripcion="<%=rs2.getString("descripcion")%>" ><%=rs2.getString("descripcion")%></option>  
      <%  }%>
</select>

OPTION
<select class="form-control" id="selectDestino2" >
    
</select>

OPTION 2 
<select class="form-control" id="option2" >
    
</select>

TEXTO
<input type="text" placeholder="Aquí va el texto" id="txt_json" class="form-control" required>
INGRESE NRO DE CI:
<input type="number" placeholder="Nro. de cédula" id="nro_ci" class="form-control" required>
<input type="button" value="Transferir" onclick="duplicarText()" class="form-control">
<input type="button" value="Registrar" onclick="insertarDatos()" class="form-control">
<input type="button" value="Actualizar Datos" onclick="actualizarDatosVimar()" class="form-control">


DATOS DE PERSONA
<input type="text" placeholder="Código persona" id="codigo_persona" class="form-control" >
<input type="text" placeholder="Número de cédula" id="nro_ci_consulta" class="form-control" onkeypress="return obtenerPersonaKey()()">
<input type="text" placeholder="Nombre" id="nombre_persona" class="form-control" >
<input type="text" placeholder="Apellido" id="apellido_persona" class="form-control" >
<input type="text" placeholder="Teléfono" id="telefono_persona" class="form-control" >
<input type="text" placeholder="Ciudad" id="ciudad_persona" class="form-control" >
<input type="text" placeholder="Edad" id="edad_persona" class="form-control" >

<input type="button" value="Ingresar a grilla" onclick="add_filas_usuarios_vimar()" class="form-control">


<table class="table" id="tb_usuarios">
            <thead>
            <th>ID</th>
            <th>CEDULA</th>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>TELEFONO</th>
            <th>CIUDAD</th>
            <th>EDAD</th>
            <th>ACCIÓN</th>
                
            </thead>
            <tbody >
                  
             </tbody>
</table>
 
