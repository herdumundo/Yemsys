<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    PreparedStatement ps, ps2, ps3, ps4, ps5, ps6;
    ResultSet rs, rs2, rs3, rs4, rs5, rs6;
    try {
        ps = connection.prepareStatement(" SELECT DISTINCT T0.[U_retiradopor] as U_retiradopor FROM  A0_ITKV.dbo.IGE1 T0");// 3
        rs = ps.executeQuery();

        ps2 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen] FROM A0_ITKV.dbo.OPRC T0 WHERE T0.[DimCode] = 4 ");// 3
        rs2 = ps2.executeQuery();

        ps3 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen] FROM A0_ITKV.dbo.OPRC T0 WHERE T0.[DimCode] = 3 ");// UBICACION
        rs3 = ps3.executeQuery();

        ps4 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen] FROM A0_ITKV.dbo.OPRC T0 WHERE T0.[DimCode] = 2 ");// RUBRO
        rs4 = ps4.executeQuery();

        ps5 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen] FROM A0_ITKV.dbo.OPRC T0 WHERE T0.[DimCode] =  1");// ACTIVIDAD
        rs5 = ps5.executeQuery();
        
        ps6 = connection.prepareStatement(" SELECT T0.[WhsCode], T0.[WhsName] FROM A0_ITKV.dbo.OWHS T0 WHERE T0.[WhsCode]  like 'TAN%%'OR  T0.[WhsCode]  = 'DEP_GEN'OR  T0.[WhsCode]  = 'DEP_TAL' ");// ACTIVIDAD
        rs6 = ps6.executeQuery();
 

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
        <center><b>REGISTRO DE CONSUMO DE COMBUSTIBLE</b></center>
    </div>
</div> 

<form id="form_add_consumo" method="post" class="  bg-black"  >


    <br>
    <strong ><a>Responsable</a></strong>
    <select class="form-control" id="retirado_por">
        <%  while (rs.next()) {%>
        <option><%=rs.getString("U_retiradopor")%></option>    
        <% }%>

    </select>
    <strong ><a>Activo</a></strong>
    <select class="form-control selectpicker"data-live-search="true" id="activo">
        <%  while (rs2.next()) {%>
        <option value="<%=rs2.getString("PrcCODE")%>" desc="<%=rs2.getString("PrcName")%>" >
            <%=rs2.getString("PrcName")%>
        </option>    
        <% }%>
    </select> 
    <div  style="display: none">    <strong><a>Ubicacion</a></strong>
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
</div>


    <strong ><a>Km/Ho</a></strong>
    <input type="number" class="form-control" placeholder="Ingrese Km/Ho" required id="km_ho">
    <br>
    <br>
    <br>
    <strong ><a>Boca de expendio</a></strong>
    <select class="form-control" id="boca">
        <%  while (rs6.next()) 
        {%>
        <option value="<%=rs6.getString("WhsCode")%>" desc="<%=rs6.getString("WhsName")%>" > 
            <%=rs6.getString("WhsName")%>
        </option>    
        <% }%>
    </select>                   
    <strong ><a>Litros inicio</a></strong>
    <input type="number" class="form-control" placeholder="Ingrese litros inicio" required id="lt_inicio" onchange="calcular_litros_itkv()">
    <strong ><a>Litros final</a></strong>
    <input type="number" class="form-control" placeholder="Ingrese litros final"  required id="lt_fin" onchange="calcular_litros_itkv()">
    <strong ><a>Litros cargados</a></strong>
    <input type="number" class="form-control" placeholder="Ingrese litros cargados" readonly="true" required id="lt_total">


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