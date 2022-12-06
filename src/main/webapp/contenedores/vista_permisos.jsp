<%-- 
    Document   : vista_permisos
    Created on : 28/12/2021, 09:34:53
    Author     : csanchez
--%>
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include  file="../versiones.jsp" %>
<%@include  file="../chequearsesion.jsp" %>
<%@include  file="../cruds/conexion.jsp" %> 
<%
    String version =  contenedores_vista_permisos;

%>
<head>
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>')">
    <label neme="label_contenido" id="label_contenido"><%=version%></label>  
</div>
</head>
<%   
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
    try 
    {
        ps = connection.prepareStatement("select * from mae_yemsys_roles ");
        rs = ps.executeQuery();
        
%>
<div class="text-center">
    <form    id="form_add_permisos"  type="post" >

        <div > <button class="informe bg-navy" disabled="true" " >PERMISOS DE USUARIOS </button>  </div>
        <br>
        <center>
            <label class="">Roles</label>
        </center>
        <center>  <select  class="btn btn-sm  bg-navy "   name="data.select[c]" id="roles" required="true" onchange="obtener_permisos_habilitados_roles()" >

                <option class="text-center" value="">Seleccione rol</option>
                <%
                    while (rs.next()) {

                %><option class="text-center" value="<%=rs.getString("id")%>"><%=rs.getString("descripcion")%></option> <%
                            }
                %>             
            </select>  </center><!-- comment -->

        <center>
            <label class="">Permisos</label>
        </center><!-- comment -->
        <center>
            <select class=" selectpicker "  multiple data-selected-text-format="count" data-live-search="true" name="permisos" id="permisos"  required="true"  >


            </select> 
            <input type="submit"   class="btn btn-sm  bg-navy "      value="REGISTRAR" >

        </center>

    </form></div>


<%
    } catch (Exception e) {
        out.print(e.getMessage());
    } finally {
        connection.close();
    }
%>