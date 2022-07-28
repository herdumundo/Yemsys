<%-- 
    Document   : transferencia_lotes
    Created on : 26/05/2020, 07:55:33 AM
    Author     : hvelazquez
--%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../consultas/consulta_gen_options.jsp" %>
 <% 
    String area =(String) sesionOk.getAttribute("clasificadora");
    String version= contenedores_ptc_transferencia_procesar;
    String version_desc= desc_contenedores_ptc_transferencia_procesar;
 %>
    <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>','<%=version_desc%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
</head>
 <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>REGISTRO DE TRANSFERENCIAS PARA PROCESAR</b></center>
</div>
   </div>  <br>    
   
   
   
<div class="form-group">
    <script>
        $('#<%=area%>').hide();
    </script>
    
    
    <a> <b>FECHA DE TRANSFERENCIA</b></a> 
            
      <input style="font-weight: bold;" id="fecha" name="fecha"  class="datepicker"    value=""   />
      <br><br>
         <div class="input-group">
             <select class="form-control" name="cbox_destino" id="cbox_destino">
                <option    value=""       disabled="disabled"    selected="selected">DESTINO </option>
                <option    id="A" value="A"  >CCHA </option>
                <option    id="B" value="B"  >CCHB </option>
                <option    id="H" value="H"  >CCHH </option>
                <option    id="O" value="O"  >LAVADO </option>
                <option    id="C" value="C"  >CYO </option>
                <option    id="HP" value="HP"  >HUEVO EN POLVO </option>
             </select>
      
             </div> </div>
                <select style=" font-weight: bold" class="form-control" name="cbox_chofer" id="cbox_chofer">
                <option style=" font-weight: bold" value="-" selected="selected" >  CHOFER </option>
                    <%=option_choferes%>
                </select>  
                <span class="input-group-addon">-</span>
                <select class="form-control" name="cbox_camion" id="cbox_camion">
                    <option style=" font-weight: bold" selected="selected"  value="-" >  CAMION </option>
                     <%=option_camiones%>
                </select>
           <br>
           <br>
           <div class="form-group">
            <div class="input-group">
                <input type="number" placeholder="LOTE" name="txt_lote" id="txt_lote" class="form-control" onkeypress="cargar_datos_key_trans_procesar();"/>
                 
            <span class="input-group-addon">-</span>
            <input type="button" value="INGRESAR" name="btn_ingresar" id="btn_ingresar" onclick="consulta_lotes_procesar($('#txt_lote').val());" class="form-control btn btn-primary"/>

 
                
               
          </div>
          </div>
        <div id="div_cargar" class="text-center" style="display: none">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
           <input  type="button" value="REGISTRAR" id="btn_registrar" name="btn_registrar" onclick="validar_transferencia_procesar_PTC();" class="form-control btn btn-danger example2" />
                
 
    <div id="carros_div">

    <a style=" font-weight: bold" > EN CARROS</a>
    <table  id="tabla_carros"   data-row-style="rowStyle"   data-toggle="table" data-click-to-select="true">
            <thead>
                <tr>
                    <th style=" font-weight: bold">TIPO A</th>
                    <th style=" font-weight: bold">TIPO B</th>
                    <th style=" font-weight: bold">TIPO C</th>
                    <th style=" font-weight: bold">TIPO D</th>
                    <th style=" font-weight: bold">TIPO J</th>
                    <th style=" font-weight: bold">TIPO S</th>
                    <th style=" font-weight: bold">TIPO G</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td> <input type="text" style=" font-weight: bold"  name="tipo_ca" id="tipo_ca" value="0"   class="form-control" readonly /></td>
                    <td> <input type="text" style=" font-weight: bold"  name="tipo_cb" id="tipo_cb" value="0" class="form-control" readonly  /></td>
                    <td> <input type="text" style=" font-weight: bold"  name="tipo_cc" id="tipo_cc" value="0"   class="form-control" readonly /></td>
                    <td> <input type="text" style=" font-weight: bold" name="tipo_cd" id="tipo_cd" value="0"  class="form-control"readonly /></td>
                    <td> <input type="text"style=" font-weight: bold"  name="tipo_cj" id="tipo_cj" value="0"  class="form-control" readonly  /></td>
                    <td> <input type="text" style=" font-weight: bold" name="tipo_cs" id="tipo_cs" value="0"  class="form-control" readonly/></td>
                    <td> <input type="text" style=" font-weight: bold" name="tipo_cg" id="tipo_cg" value="0"  class="form-control" readonly /></td>
                </tr>
            </tbody>
    </table>
    </div> 
        <br>
              
      
<div   class="row" id="divid"  >
        <div class="col-md-12">
        <div class="panel panel-primary">
        <div class="panel-heading" > </div>
         <table id="grilla_transfer" data-row-style="rowStyle" data-toggle="table"  class="  table-responsive" data-click-to-select="true">
    <thead>
      <tr>
    <th class="ocultar">ID</th>
    <th class="ocultar">COD_LOTE</th>
    <th>CARRO</th>
    <th>CANTIDAD</th>
    <th>TIPO</th>
    <th>FECHA PUESTA</th>
    <th>ESTADO LIBERACION</th>
    <th>MOTIVO</th>
    <th>ACCION</th>
    <th>ESTADO COSTEO</th>
      </tr>
     </thead>
     <tbody>
         
     </tbody>
  </table>                      
       </div> </div> </div> 
    
 

