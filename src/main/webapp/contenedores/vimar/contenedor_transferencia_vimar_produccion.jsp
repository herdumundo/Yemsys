<%-- 
    Document   : contenedor_transferencia_vimar
    Created on : 16-ago-2023, 8:53:36
    Author     : hvelazquez
--%>

<%-- 
   Document   : contenedor_registro_reprocesos
   Created on : 15-dic-2021, 9:51:44
   Author     : hvelazquez
--%>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 

<%    
    String version = "";
    String version_desc = "";
    PreparedStatement ps, ps2, ps3, ps4;
    ResultSet rsOrigen, rsDestino, rsCliente, rsReporte;
    Statement st = connection.createStatement();
    Statement st2 = connection.createStatement();
    Statement st3 = connection.createStatement();
    Statement st4 = connection.createStatement();
  
    
    rsOrigen = st.executeQuery("select WhsCode,WhsName from vimar.dbo.OWHS"); 
    
    
    rsDestino = st2.executeQuery("select WhsCode,WhsName from vimar.dbo.OWHS");
    
    
    rsCliente = st3.executeQuery("select cardName,CardCode,Address from  zz_prueba_GrupoMaehara.dbo.v_ocrd where CardCode<>'' order by 2  asc");
    
    
    rsReporte = st4.executeQuery("select idtransferencia, fecha_contabilizacion, origen, destino, CardCode,CardName, Address, ItemCode, ItemName, loteLargo, loteCorto, BarCode, Quantity, observacion, observacion_detalle from vim_transferencia_produccion with(nolock)");
%>

<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>', 'VERSION: <%=version%>', '<%=version_desc%>')">
    <label ><%=version%></label> 
</div>
</head>
<div class="col-lg-20 ">
    <div class="position-relative p-3 bg-navy"  >
        <div class="ribbon-wrapper">
            <div class="ribbon bg-warning">
                VIM
            </div>
        </div>
        <center><b>TRANSFERENCIA VIMAR</b></center>
    </div>
</div>

ORIGEN
<select class="form-control" id="origen_OWHS" >
    <%while(rsOrigen.next()){%>
        <option codigo="<%=rsOrigen.getString("WhsCode")%>" descripcion="<%=rsOrigen.getString("WhsName")%>" ><%=rsOrigen.getString("WhsName")%></option>  
      <%  }%>
</select>
 
DESTINO
 <select class="form-control" id="destino_OWHS" >
    <%while(rsDestino.next()){%>
        <option codigo="<%=rsDestino.getString("WhsCode")%>" descripcion="<%=rsDestino.getString("WhsName")%>" ><%=rsDestino.getString("WhsName")%></option>  
      <%  }%>
</select>

CLIENTE
<select class="form-control" id="cliente_ocrd" >
    <%while(rsCliente.next()){%>
        <option cardName="<%=rsCliente.getString("cardName")%>" codigo="<%=rsCliente.getString("CardCode")%>" descripcion="<%=rsCliente.getString("Address")%>"><%=rsCliente.getString("Address")%></option>  
      <%  }%>    
</select> 


<%-- OPTION 2 
<select class="form-control" id="option2" >
    
</select> --%>

<%-- TEXTO
<input type="text" placeholder="Aquí va el texto" id="txt_json" class="form-control" required>
INGRESE NRO DE CI:
<input type="number" placeholder="Nro. de cédula" id="nro_ci" class="form-control" required>
<input type="button" value="Transferir" onclick="duplicarText()" class="form-control">
<input type="button" value="Registrar" onclick="insertarDatos()" class="form-control">
<input type="button" value="Actualizar Datos" onclick="actualizarDatosVimar()" class="form-control"> --%>


INGRESE COD. BARRA:
<input type="text" placeholder="Ingrese código de barra" id="cod_barra_consulta" class="form-control" onkeypress="return consultaCodigoBarraKey()()">
<input type="hidden" placeholder="ItemName" id="item_name" class="form-control" >
<input type="hidden" placeholder="ItemCode" id="item_code" class="form-control" >
<input type="hidden" placeholder="LoteLargo" id="lote_largo" class="form-control" >
<input type="hidden" placeholder="Lote" id="lote" class="form-control" >
<input type="hidden" placeholder="LoteCorto" id="lote_corto" class="form-control" >
<input type="hidden" placeholder="CódigoBarra" id="cod_barra" class="form-control" >
<input type="text" placeholder="Stock" id="onhand" class="form-control" readonly>
<input type="number" placeholder="Ingrese cantidad" id="cantidad" class="form-control" min="1">
<input type="text" placeholder="Observación" id="observacion" class="form-control" >
<input type="text" placeholder="Detalle observación" id="detalle_observacion" class="form-control" >

<input type="button" id="btnInsertarLoteTransferencia" value="Agregar a grilla" onclick="InsertarLoteTransferencia()" class="form-control">


<table class="table" id="tb_transferencia">
            <thead>
            <th>cod. origen</th>
            <th>cod. destino</th>
            <th>cod. cliente</th>
            <th>Cliente</th>
            <th>Dirección</th>
            <th>Item Code</th>
            <th>Item Name</th>
            <th>Lote Largo</th>
            <th>Lote</th>
            <th>Lote Corto</th>
            <th>cod. barra</th>
            <th>Stock</th>
            <th>Cantidad</th>
            <th>Observación</th>
            <th>Detalle Obs.</th>
            <th>Eliminar registro</th>
            
          
                
            </thead>
            <tbody >
                  
             </tbody>
</table>

<input type="button" value="Registrar Transferencia" onclick="registrarTransferencia()" class="form-control">

 
<!--<input type="button" value="Pruebas" onclick="pruebasTransferencia()" class="form-control">-->
