<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@page import="itkv.itkv_datos"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.jfree.data.general.Dataset"%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    PreparedStatement ps, ps2, ps3, ps4, ps5, ps6,ps7;
    ResultSet rs, rs2, rs3, rs4, rs5, rs6,rs7;
    try {
        ps = connection.prepareStatement(" SELECT DISTINCT T0.[U_retiradopor] as U_retiradopor              FROM    IGE1 T0");// 3
        rs = ps.executeQuery();

       
        ps6 = connection.prepareStatement(" SELECT T0.[WhsCode], T0.[WhsName]                               FROM    OWHS T0 WHERE T0.[WhsCode]  like 'TAN%%'OR  T0.[WhsCode]  = 'DEP_GEN'OR  T0.[WhsCode]  = 'DEP_TAL' ");// ACTIVIDAD
        rs6 = ps6.executeQuery();
 

        ps7 = connection.prepareStatement(" SELECT T0.[WhsCode], T0.[WhsName]                               FROM    OWHS T0 WHERE T0.[WhsCode]  like 'TAN%%'OR  T0.[WhsCode]  = 'DEP_GEN'OR  T0.[WhsCode]  = 'DEP_TAL'  ");// ACTIVIDAD
        rs7 = ps7.executeQuery();
  
    
%>
<style>
    tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 

</head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                ITKV
            </div>
        </div>
        <center><b>REGISTRO TRASLADO DE COMBUSTIBLE</b></center>
    </div>
</div> 

<form id="form_add_consumo" method="post" class="  bg-black"  >


    <br>
    <strong ><a>Responsable</a></strong>
    <select class="form-control" id="retirado_por_select" required onchange="insert_valor_responsable_combo_itkv()">
    <option value="">Seleccione</option>    
        <%  while (rs.next()) {%>
        <option><%=rs.getString("U_retiradopor")%></option>    
        <% }%>
        <option>OTROS</option>    
    </select>
        <input type="text" class="form-control " placeholder="INGRESE NOMBRE" value="" required id="retirado_por" style="display: none">
     <div style="display: none">   
    <strong ><a>Tipo combustible</a></strong>
    <select class="form-control"    id="tipo_combus">
       
        <option value="COMB-0014" desc="Gasoil comun" >
            Gasoil comun
        </option>    
      
    </select>    
        
      </div>  
     
    <strong ><a>Boca de expendio origen</a></strong>
    <select class="form-control" id="boca">
        <%  while (rs6.next()) 
        {%>
        <option value="<%=rs6.getString("WhsCode")%>" desc="<%=rs6.getString("WhsName")%>" > 
            <%=rs6.getString("WhsName")%>
        </option>    
        <% }%>
    </select>                   
    <strong ><a>Litros inicio</a></strong>
    <input type="text" class="form-control autoNumeric" placeholder="Ingrese litros inicio" value="0" required id="lt_inicio" onchange="calcular_litros_itkv()">
    <strong ><a>Litros final</a></strong>
    <input type="text" class="form-control autoNumeric" placeholder="Ingrese litros final"  value="0" required id="lt_fin" onchange="calcular_litros_itkv()">
    <strong ><a>Litros cargados</a></strong>
    <input type="number" class="form-control" placeholder="Ingrese litros cargados" readonly="true" required id="lt_total">
    
      <strong ><a>Boca de expendio destino</a></strong>
    <select class="form-control" id="boca_destino">
        <%  while (rs7.next()) 
        {%>
        <option value="<%=rs7.getString("WhsCode")%>" desc="<%=rs7.getString("WhsName")%>" > 
            <%=rs7.getString("WhsName")%>
        </option>    
        <% }%>
    </select>   
    
    
    
    
    
    

    <div class="modal-footer align-right " >
        <input  class="btn bg-white"  type="submit"   value="REGISTRAR" >
         
 

    </div>
</form>















<%
    } catch (Exception e) {
        out.print(e.getMessage());
    } finally {
        connection.close();
    }%>