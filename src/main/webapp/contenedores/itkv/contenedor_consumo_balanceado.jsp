65<%-- 
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
 
        ps3 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] = 3 ");// UBICACION
        rs3 = ps3.executeQuery();

        ps4 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] = 2 	 AND [PrcName] LIKE '%HACIENDA%' ");// RUBRO
        rs4 = ps4.executeQuery();

        ps5 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] =  1");// ACTIVIDAD
        rs5 = ps5.executeQuery();
    

        ps7 = connection.prepareStatement("SELECT ItemCode , ItemName  , ItmsGrpCod 	 , OnHand , InvntryUom     FROM   oitm	where ItemCode like '%BAL%' or ItemCode like '%GRAN%'");// ACTIVIDAD
        rs7 = ps7.executeQuery();
  
    
%>
<style>
    tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" >
      <a href="manuales/Consumo_balanceados.pdf" target="_blank">Manual de usuario</a>
</div></head><!-- comment -->
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                ITKV
            </div>
        </div>
        <center><b>REGISTRO DE CONSUMO BALANCEADOS</b></center>
    </div>
</div> 

<form id="form_add_consumo" method="post" >


    <br>
    <strong ><a>Responsable</a></strong>
    
    <select class="form-control selectpicker" id="retirado_por_select" onchange="insert_valor_responsable_combo_itkv()"  data-live-search="true">
    <option value="">Seleccione</option>    
        <%  while (rs.next()) {%>
        <option><%=rs.getString("U_retiradopor")%></option>    
        <% }%>
        <option>OTROS</option>    
    </select>
     <input type="text" class="form-control " placeholder="INGRESE NOMBRE" value=""   id="retirado_por" style="display: none">
        
    <strong><a>Ubicacion</a></strong>
    <select class="form-control selectpicker " data-live-search="true" id="ubicacion">
        <%  while (rs3.next()) 
        {%>
        <option value="<%=rs3.getString("PrcCODE")%>" desc="<%=rs3.getString("PrcName")%>" > 
            <%=rs3.getString("PrcName")%>
        </option>    
        <% }%>
    </select> 

    <strong ><a>Rubro</a></strong>
    <select class="form-control" id="rubro">
        <%  while (rs4.next()) {%>
        <option value="<%=rs4.getString("PrcCODE")%>" desc="<%=rs4.getString("PrcName")%>"><%=rs4.getString("PrcName")%></option>    
        <% }%>
    </select> 

    <strong ><a>Actividad</a></strong>
    <select class="form-control" id="actividad">
        <%  while (rs5.next()) {%>
        <option value="<%=rs5.getString("PrcCODE")%>" desc="<%=rs5.getString("PrcName")%>"><%=rs5.getString("PrcName")%></option>    
        <% }%>
    </select> 
    
    
    
  

    
    <table   class="table table-striped table-bordered"  >
            <thead>
                <tr>
                    <th >  <strong ><a>Balanceado</a></strong>
    <select class="form-control selectpicker" data-live-search="true"  id="item">
        <%  while (rs7.next()) {%>
        <option value="<%=rs7.getString("itemcode")%>" desc="<%=rs7.getString("itemname")%>"><%=rs7.getString("itemname")%></option>    
        <% }%>
    </select></th>
    <th><input type="number"  class=" form-control"  id="cantidad" placeholder="Ingrese cantidad"></th>
    <th> <input type="button" value="Agregar item" class=" form-control  bg-navy" onclick="cargar_grilla_salida_repuesto();"></th>
                  </tr>
            </thead>
            
        </table>    
    
    
    
    
<table id="tabla" class="table table-striped table-bordered"  style='width:100%' >
            <thead>
                <tr>
                    <th >CODIGO</th>
                    <th>ARTICULO</th>
                    <th>CANTIDAD</th>
                    <th>ACCION</th>
                 </tr>
            </thead>
            <tbody id="tbody_tabla">

            </tbody>
        </table>    

    <div class="modal-footer align-right " >
        <input  class="btn bg-danger"  type="submit"   value="REGISTRAR" >
         
 

    </div>
</form>















<%
    } catch (Exception e) {
        out.print(e.getMessage());
    } finally {
        connection.close();
    }%>