    <%-- 
    Document   : contenedor_encolamiento_mtp
    Created on : 05-may-2023, 7:21:28
    Author     : jalvarez
--%>


<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    
    String version = contenedores_bal_informe;
    String version_desc = desc_contenedores_bal_informe;
    
    PreparedStatement ps, ps2;
    ResultSet rs, rs2; 

    try{
     ps=connection.prepareStatement("Select * From maehara.dbo.OITM  with (nolock) WHERE  ItmsGrpCod='106' AND OnHand>0");
        rs= ps.executeQuery();
        
    
%> 
<head>   
<label><b></b></label> 
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
        <center><b>Encolamiento MTP </b></center>
    </div>
</div> 
  
<div class="input-append">

       <table>
 
    <tbody>
     <tr>
         <td width="100%"><center><label>FORMULA</label></center>
                    <select class="form-control" id="select_formula" name="select_formula" onchange="ir_grilla_encolamientoMTP()">
                        <option class="text-center celda_editable" value="-">SELECCIONE FORMULA</option> 
                        <%
                            while (rs.next()) {%>
                        <option class="text-center"  descripcion="<%=rs.getString("itemName")%>" value="<%=rs.getString("itemCode")%>"><%=rs.getString("itemName")%></option> <%
                     }%>   
                    </select>     </td>
 
            </tr> 
    </tbody>
</table>     
           
           
</div>      



<div id="div_grilla2">
    
    
</div>

 <div id="div_grilla"  >
                
            </div>
 <div id="divGrillaNutrientes"  >
                
            </div>
 <%
                        } catch (Exception e) {

                        } finally {
                            connection.close();
                        }%>