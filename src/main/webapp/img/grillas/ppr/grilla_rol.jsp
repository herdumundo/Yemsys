

<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

  <head>
     
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('0030-REP-01032022-A','VERSION: 0030-REP-01032022-A')">
    <label neme="label_contenido" id="label_contenido">0030-PAN-01032022-A</label>  
</div>

    </head>


<%   
    //listar datos de tabla
    clases.controles.VerificarConexion();
     PreparedStatement ps=clases.controles.connectSesion.prepareStatement("	  select a.id as id_rol,a.descripcion ,a.id_estado,b.descripcion as desc_estado from mae_yemsys_roles a  inner join tab_mae_ppr_estados b on a.id_estado=b.id ");
    ResultSet rs=ps.executeQuery();
    
    PreparedStatement ps2=clases.controles.connectSesion.prepareStatement("select * from tab_mae_ppr_estados where id in (1,2)");
    ResultSet rs2=ps2.executeQuery();
    
   

%>


    <div class="collapse navbar-collapse" id="navbarResponsive">
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
               <center><b>ROLES REGISTRADOS</b></center>   
      </div> 
    <table  id="tabla_roles" class="table table-bordered" style="width:100%"  >
        <thead class="text-center">
            <tr >
                <th class="bg-navy">ID</th>
                <th class="bg-navy" >ROL USUARIO</th>
                <th class="bg-navy" >ESTADO</th>
                <th class="bg-navy"  >ACCIONES</th>
            </tr>
        </thead>
        <tbody id="tbodys">
            <%               while (rs.next()) {
            %>
            <tr >
                <td ><%=rs.getInt("id_rol")%></td>
                <td ><%=rs.getString("descripcion")%></td>
                <td ><%=rs.getString("desc_estado")%> </td>
                <td > 
                    <div class="text-center"  >
                        <div  class="btn bg-navy" type="button"   class="btn btn-primary btnEditar" 
                                    value="Editar" onclick="edit_rol_ppr('<%=rs.getInt("id_rol")%>',
                                                           '<%=rs.getString("descripcion")%>',
                                                           '<%=rs.getString("id_estado")%>')"  ><i class="fas fa-edit" >

                           </i>
                         </div>
                    </div></td>
            </tr>
            <%}%>
        </tbody>
    </table>
        
         <div class="modal fade" id="modal_upd_rol" tabindex="-1"  role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-black">
                    <h5 class="modal-title" id="exampleModalLabel">EDITAR ROL </h5>
                    <button class="close" type="button"  class="position-relative p-3 bg-navy"  data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                    <div class="modal-body bg-navy"   >  
                         <form id="form_upd_user" action="POST"  style=" height: 250px">
                             <input hidden="true" class="form-control text-left " type="text" style="width: 100%" disabled="true" id="txt_id_rol"    name="txt_id_rol">
                        <br>
                        <strong><a>Descripcion</a></strong> 
                        <input class="form-control text-left " style="width: 100%" type="text"   id="txt_decri_rol"    name="txt_decri_rol"      required >
                        <strong><a>Estado</a></strong>
                        <select class="form-control text-left " id="select_estado_roles" name="select_estado_roles" required>
                            <%
                                while (rs2.next()) {
                            %>
                            <option  value="<%=rs2.getString("id")%>"><%=rs2.getString("descripcion")%></option>
                            <%}%>
                        </select>
                        
                         
                        <div class="modal-footer align-right">
                         <input class="btn bg-white"   type="button" onclick="modificar_rol_ppr()"    id="btn_apd_roles" value="ACEPTAR" >
                         <input  class="btn bg-white"  type="button"   data-dismiss="modal"   value="CANCELAR" >            
                        </div>
                        </form>   
                    </div>
            </div>
        </div>
    </div>    

</body>
</html>
