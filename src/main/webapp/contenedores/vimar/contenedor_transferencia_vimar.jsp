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
<input type="text" placeholder="Ingrese nro lote" id="txt_lote" class="form-control" >
<input type="text" placeholder="Ingrese cantidad" id="txt_cantidad" class="form-control" >

<input type="button" value="Ingresar a grilla" onclick="obtenerLote()" class="form-control" >


<table class="table ">
            <thead>
            <th>Nro.</th>
            <th>Fecha de registro</th>
            <th>Solicitud modificacion</th>
              
            </thead>
            <tbody>
                 <tr>
                     <td>1</td>
                    <td>2</td>
                    
                    <td><input type="button" value="Quitar de la fila" class="bg-navy"  > </td>
                </tr>
             </tbody>
        </table>
 
         