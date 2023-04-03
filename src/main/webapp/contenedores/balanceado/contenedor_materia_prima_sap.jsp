<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@page import="clases.controles"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%      String version = contenedores_balMaeharaMateriaPrimaSAP;
        String version_desc = desc_balMaeharaMateriaPrimaSAP;
        String pdf =  pdf_balMaeharaMateriaPrimaSAP;

        
        
    PreparedStatement ps, ps2;
    ResultSet rs, rs2;
    try {
        ps = connection.prepareStatement("SELECT * FROM v_mae_bal_mtp_estados order by itemName");
        rs = ps.executeQuery();
        int verifi = 0;
%>
<html>
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
                BAL
            </div>
        </div>
        
        <center><b>Materia Prima Disponibles en SAP</b></center>
    </div>
</div> 



<table id="tablaMTP" class=' table table-bordered' style='width:100%'>
    <thead class="text-center">
    
    <th class="bg-navy">Nro</th>
    <th class="bg-navy">Nombre</th>
    <th class="bg-navy">Estado</th>



</thead>
<tbody id="tbody" >
    <% while (rs.next()) {%>
    <tr>
        <td class="text-center" ><%=rs.getString("itemcode")%></td>
        <td><%=rs.getString("ItemName")%></td>

        <%
            String estado = rs.getString("estado");
            if (estado.equals("ACTIVAR")) {
        %>
        <td class="text-center"> <input type="button"  id="btn_mtp<%=rs.getString("itemcode")%>" value=Activar class="bg-success" onclick="activa_desactivar_mtp_bal('<%=rs.getString("itemcode")%>')"></td>
        <%--<td><input type="button" value="Detalle" class="bg-navy" onclick="modal_detalle_formulacion_bal(<%=rs.getString("id")%>,'<%=rs.getString("cod_formula")%>','<%=rs.getString("formula")%>')"></td>--%>
        <%
        } else {
        %>
         <td class="text-center"> <input type="button"  id="btn_mtp<%=rs.getString("itemcode")%>" value=DESACTIVAR class="bg-danger" onclick="activa_desactivar_mtp_bal('<%=rs.getString("itemcode")%>')"></td>

        <%
            }

        %>


    </tr>
       <%                } %>
</tbody>
</table>
</html>

 



<%
    } catch (Exception e) {

    } finally {
        connection.close();
    }%>


