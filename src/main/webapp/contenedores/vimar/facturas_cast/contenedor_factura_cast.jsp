<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@include file="../../../cruds/conexion.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    try {
        Statement st = connection.createStatement();
        ResultSet rs_repartidor = st.executeQuery("select u_codigocast,slpname from vimar.dbo.oslp");
%>

<a  style=" color:black ;font-weight: bold;"><b>FECHA DE FACTURACION</b></a>
<input type="text" id="txt_fecha" class="datepicker" style="color:black ; font-weight: bold;" placeholder="SELECCIONE FECHA">

<select  id="cbox_repartidor"   name="cbox_repartidor" class="select"  placeholder="SELECCIONAR REPARTIDOR" required="true">
    <option value="">SELECCIONAR REPARTIDOR</option>
    <%
        while (rs_repartidor.next()) {
    %><option style=" color:black ;font-weight: bold;" value="<%=rs_repartidor.getString(1)%>"><%=rs_repartidor.getString(2)%></option><%
            }
            connection.close();
        } catch (Exception e) {

        }
    %>
</select>
<a href="#" class=" bg-gradient-primary btn btn-primary btn-icon-split" onclick="grilla_facturados($('#cbox_repartidor').val(), $('#txt_fecha').val())">
    <span class="icon text-white-50">
        <i class="fas fa-search"></i>
    </span>
    <span class="text"><b> BUSCAR</b></span>
</a> 
<div class="spinner" style="display:none" id="loading2">
    <div class="rect1"></div>
    <div class="rect2"></div>  <div class="rect3"></div>
    <div class="rect4"></div>
    <div class="rect5"></div>
</div>
<div  id="contenedor_grilla_productos" ></div>

<div class="content">
    <div class="left">
        <a  style=" color:black ;font-weight: bold;"><b>FACTURAS SAP</b></a>
        <div id="div_grilla_sap">
        </div>
    </div> 
    <div class="right">
        <a  style=" color:black ;font-weight: bold;"><b>FACTURAS CAST  </b></a>
        <div id="div_grilla_repar">
        </div>
    </div>  
</div>  
