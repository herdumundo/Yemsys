
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<!DOCTYPE html>
<% 
     try {

    String  rol = (String) sesionOk.getAttribute("rol");
    String  sector = (String) sesionOk.getAttribute("sector");
    String area = (String) sesionOk.getAttribute("clasificadora");
    String version = grilla_ppr_grilla_usuarios;
    String version_desc = "" ;
    Statement st1,st2,st3,st4;
    ResultSet rs,rs2,rs3,rs4;
  %> 
<html>
    <head>

    <label  ><b></b></label> 
    <div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
         onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')">
        <label neme="label_contenido" id="label_contenido"><%=version%></label>  
    </div>

</head>
<%  

 
        String  queryUsuarios = "    select * from v_mae_yemsys_usuarios    ";
        String  queryRol="select * from mae_yemsys_roles";
        String  queryAreas="select * from mae_yemsys_areas  ";
        if (rol.equals("U")) {
            queryUsuarios = "select * from v_mae_yemsys_usuarios  where sector ='"+sector+"' and rol='U' ";
            queryRol = "select * from mae_yemsys_roles  where AREA ='"+sector+"'  ";
            queryAreas="select * from mae_yemsys_areas WHERE sector='"+sector+"'";
        }
        st1=connection.createStatement();
        st2=connection.createStatement();
        st3=connection.createStatement();
        st4=connection.createStatement();
        rs = st1.executeQuery(queryUsuarios);
        rs2 = st2.executeQuery(queryRol);
        rs3 = st3.executeQuery(queryAreas);
        rs4 = st4.executeQuery("select * from tab_mae_ppr_estados where id in (1,2)");
 %>
<body>
    <div    class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
        </ul>
    </div>
    <div id="response">
    </div>
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div  class="ribbon bg-warning">
                <small>SEGURIDAD</small>
            </div>
        </div>
        <center><b>USUARIOS REGISTRADOS</b></center>   
    </div>
    <table   id="tabla_usuarios" class="table table-bordered" style="width:100% "  >
        <thead class="text-center">
            <tr >
                <th class="bg-navy">ID</th>
                <th class="bg-navy">USUARIO</th>
                <th class="bg-navy">NOMBRE</th>
                <th class="bg-navy">AREA</th>
                <th class="bg-navy">ROL</th>
                <th class="bg-navy">ESTADO</th>
                <th class="bg-navy">EDITAR</th>
                <th class="bg-navy">RESTABLECER CONTRASEÑA</th>
            </tr>
        </thead>
        <tbody id="tbodys">
            <%
                while (rs.next()) {
            %>
            <tr >
                <td ><%=rs.getInt("cod_usuario")%></td>
                <td ><%=rs.getString("usuario")%></td>
                <td ><%=rs.getString("nombre")%></td>
                <td ><%=rs.getString("descri_area")%> </td>
                <td ><%=rs.getString("desc_rol")%></td>
                <td ><%=rs.getString("estado")%></td>
                <td> 

                    <div class="text-center"  >
                        <div  class="btn bg-navy" type="button"   class="btn btn-primary btnEditar" 
                              value="Editar" onclick="edit_usuario_ppr('<%=rs.getInt("cod_usuario")%>',
                                                    '<%=rs.getString("usuario")%>',
                                                    '<%=rs.getString("nombre")%>',
                                                    '<%=rs.getString("area")%>',
                                                    '<%=rs.getString("id_rol")%>',
                                                    '<%=rs.getString("id_estado")%>')"  ><i class="fas fa-edit" >

                            </i>
                        </div>
                    </div></td>
                </td>
                <td> 
                    <div class="btn bg-dark"onclick="modalresetearpass_ppr('<%=rs.getInt("cod_usuario")%>', '<%=rs.getString("usuario")%>')">
                        <i class="fas fa-key"  >    </i>  
                    </div>              



                </td>
            </tr>
            <%} %>
        </tbody>
    </table>


 
    <div class="modal fade" id="modal_upd_user" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-black">
                    <h5 class="modal-title" id="exampleModalLabel">EDITAR USUARIO</h5>
                    <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body bg-navy"   >  
                    <form id="form_upd_user" action="POST"  style=" height: 400px">
                        <input hidden="true" class="form-control text-left " type="text" style="width: 100%" disabled="true" id="txt_id"    name="txt_id">
                        <br>
                        <strong><a>NOMBRE</a></strong> 
                        <input class="form-control text-left " style="width: 100%" type="text"   id="txt_nombre"    name="txt_nombre"      required >
                        <strong><a>USUARIO</a></strong>
                        <input class="form-control text-left " type="text"  style="width: 100%" id="txt_usuario"    name="txt_usuario" required >
                        <strong><a>AREA</a></strong>

                        <select class="form-control text-left " id="txt_clasificadora" name="txt_clasificadora" required >
                            <%
                                while (rs3.next()) {
                            %>
                            <option  value="<%=rs3.getString("area")%>"><%=rs3.getString("descripcion")%></option>
                            <%}%>
                        </select>

                        <strong><a>ROL</a></strong>
                        <select class="form-control text-left " id="select_rol2" name="select_rol2" required >
                            <%
                                while (rs2.next()) {
                            %>
                            <option  value="<%=rs2.getString("id")%>"><%=rs2.getString("descripcion")%></option>
                            <%}%>
                        </select>
                        <strong><a>ESTADO</a></strong>
                        <select class="form-control text-left " id="select_estado" name="select_estado" required >
                            <%
                                while (rs4.next()) {
                            %>
                            <option  value="<%=rs4.getString("id")%>"><%=rs4.getString("descripcion")%></option>
                            <%}%>
                        </select>

                        <div class="modal-footer align-right">
                            <input  class="btn bg-white"  type="button"  onclick="modificar_usuario_ppr()"  id="btn_apd_usuario" value="ACEPTAR" >
                            <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="CANCELAR" >            
                        </div>
                    </form>   
                </div>
            </div>
        </div>
    </div>

    




    <div class="modal fade" id="modal_restablecer_pass" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-black">
                    <h5 class="modal-title" id="exampleModalLabel">RESTABLECIMIENTO DE CONTRASEÑA</h5>
                    <button class="close" type="button" style="font-weight: bold;color:black;" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>

                <div class="modal-body bg-dark">  
                    <form id="form_restablecer_pass" action="POST"   style=" height: 400px">

                        <strong><a>ID</a><br></strong> 
                        <input style="width: 100%" type="text" disabled="true"  id="txt_id_reset" name="txt_id_reset" required class="form-control text-left">
                        <br>
                        <strong><a>USUARIO</a><br></strong> 
                        <input style="width: 100%" type="text" disabled="true"  id="txt_usuario_p" name="txt_usuario_p" class="form-control text-left">
                        <br>
                        <a>CONTRASEÑA</a>
                        <br>
                        <input style="width: 100%" type="text" class="form-control text-left" disabled="true" value=" POR DEFECTO 123" id="passr" name="passr"  >
                        <hr>
                        <div class="modal-footer align-right"  >
                            <input  class="btn bg-white"  type="button"     onclick="restablecer_pass_usuario_ppr()()" value="REGISTRAR" >
                            <input  class="btn bg-white"  type="button"  data-dismiss="modal"    value="CANCELAR" >
                        </div>
                    </form>            

                </div>
            </div>
        </div>
    </div>    
</body>
</html>

<%

    } catch (Exception e) {
        out.print(e.getMessage());
    } finally {
        connection.close();
    }
%>
