<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@page import="java.text.DecimalFormat"%>
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
 
        ps = connection.prepareStatement(" SELECT DISTINCT T0.[U_retiradopor]  collate database_default   as U_retiradopor             FROM    IGE1 T0    union all    select nombre  as U_retiradopor from 	  itkv_personales  ");// 3
        rs = ps.executeQuery();

        ps2 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName],  T0.[DimCode] , T0.[U_CodAnt], T0.[U_Comen] FROM    OPRC T0 WHERE T0.[DimCode] = 4 ");// 3
        rs2 = ps2.executeQuery();

        ps3 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] = 3 ");// UBICACION
        rs3 = ps3.executeQuery();

        ps4 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] = 2 ");// RUBRO
        rs4 = ps4.executeQuery();

        ps5 = connection.prepareStatement(" SELECT T0.[PrcCode], T0.[PrcName], T0.[U_CodAnt], T0.[U_Comen]  FROM    OPRC T0 WHERE T0.[DimCode] =  1");// ACTIVIDAD
        rs5 = ps5.executeQuery();
        
        ps6 = connection.prepareStatement(" SELECT T0.[WhsCode], T0.[WhsName]                               FROM    OWHS T0 WHERE T0.[WhsCode]  like 'TAN%%'OR  T0.[WhsCode]  = 'DEP_GEN'OR  T0.[WhsCode]  like '%DEP_TAL%' ");// ACTIVIDAD
        rs6 = ps6.executeQuery();
 

        ps7 = connection.prepareStatement("select max(lt_fin) as fin from itkv_salida1 WHERE ID_boca='DEP_TAL' ");// ACTIVIDAD
        rs7 = ps7.executeQuery();
  
        String lt_fin="";
        
        while (rs7.next()){
            lt_fin= rs7.getString("fin") ;
        }
%>
<style>
    tr:hover {color:#ffffff ; background-color: #001940;}
</style>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" >
      <a href="manuales/Consumo_combustible.pdf" target="_blank">Manual de usuario</a>
</div>
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
<input type="checkbox"  class="checkbox"  data-toggle="toggle" data-on="MAEHARA"   data-off="MAEHARA" id="check"    data-onstyle="danger" data-offstyle="success">
<input id="band"       value="MAEHARA"  type="hidden"/>
               
    <br>
    <strong ><a>Responsable</a></strong>
    
    <select class="form-control selectpicker"data-live-search="true"  id="retirado_por_select" onchange="insert_valor_responsable_combo_itkv()">
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
        
    <strong ><a>Activo</a></strong>
    <select class="form-control selectpicker"data-live-search="true" id="activo_select" onchange="insert_valor_responsable_combo_itkv()">
        <%  while (rs2.next()) {%>
        <option value="<%=rs2.getString("PrcCODE")%>" desc="<%=rs2.getString("PrcName")%>" >
            <%=rs2.getString("PrcName")%>
        </option>    
        <% }%>
        <option value="OTROS">OTROS</option>    
    </select> 
    <input type="text" class="form-control "  code="AC-0000" value="ACTIVO GENÉRICO"    placeholder="INGRESE NOMBRE" required id="activo" style="display: none">
      
      
    <div  style="display: none">   
         <strong ><a>Tipo combustible</a></strong>
    <select class="form-control"    id="tipo_combus">
       
        <option value="COMB-0014" desc="Gasoil comun" >
            Gasoil comun
        </option>    
      
    </select>  
   

</div>
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



    <strong ><a>Km/Ho</a></strong>
    <input type="text" class="form-control autoNumeric" placeholder="Ingrese Km/Ho" required id="km_ho">
    <br>
    <br>
    <br>
    <strong ><a>Boca de expendio</a></strong>
    <select class="form-control" id="boca" onchange="get_ultimo_litro_boca_combustible_itkv()">
        <%  while (rs6.next()) 
        {%>
        <option value="<%=rs6.getString("WhsCode")%>" desc="<%=rs6.getString("WhsName")%>" > 
            <%=rs6.getString("WhsName")%>
        </option>    
        <% }%>
    </select>                   
    <strong ><a>Litros inicio</a></strong>
    <input type="text" class="form-control autoNumeric" value="<%=lt_fin%>" placeholder="Ingrese litros inicio"   required id="lt_inicio" onchange="calcular_litros_itkv()">
    <strong ><a>Litros final</a></strong>
    <input type="text" class="form-control autoNumeric" placeholder="Ingrese litros final"   required id="lt_fin" onchange="calcular_litros_itkv()">
    <strong ><a>Litros cargados</a></strong>
    <input type="text" class="form-control autoNumeric" placeholder="Ingrese litros cargados" readonly="true" required id="lt_total">


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