<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../consultas/consulta_gen_options.jsp" %>

<% 
    String area =(String) sesionOk.getAttribute("clasificadora");
    String version= contenedores_ptc_contenedor_transferencia_SC;
%> 
  
  
  <script>
        $('#<%=area%>').hide();
    </script>
    
  <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')" >
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
    <center><b>REGISTRO DE TRANSFERENCIAS SIN CLASIFICAR</b></center>
</div>
   </div>  <br>    
   
   <span class="input-group-addon">Destino</span>
      <select class="form-control" name="cbox_destino" id="cbox_destino" required>
                 <option    value=""       disabled="disabled"    selected="selected">DESTINO </option>
                 <option    id="A" value="A"  >CCHA </option>
                 <option    id="B" value="B"  >CCHB </option>
                 <option    id="H" value="H"  >CCHH </option>
                 <option    id="O" value="O"  >LAVADO </option>
                 <option    id="C" value="C"  >CYO </option>
                 
             </select>
       <br>
       <span class="input-group-addon">Chofer</span>
                <select style=" font-weight: bold" class="form-control" name="cbox_chofer" id="cbox_chofer" required> 
                 <option    value=""       disabled="disabled"    selected="selected">CHOFER </option>
                <%=option_choferes%>
                </select>  
                <br>
                <span class="input-group-addon">Camion</span>
                <select class="form-control" name="cbox_camion" id="cbox_camion" required>
                    <option    value=""       disabled="disabled"    selected="selected">CAMION </option>
                    <%=option_camiones%>
                </select>
           <br>
           <br>
           
           <div class="form-group">
            <div class="input-group">
                <input type="number" placeholder="LOTE" name="txt_lote" id="txt_lote" class="form-control" onkeypress="cargar_datos_key_trans_sc();"/>
                 
            <span class="input-group-addon">-</span>
            <input type="button" value="INGRESAR" name="btn_ingresar" id="btn_ingresar" onclick="consulta_lotes_transferencias_SC($('#txt_lote').val());" class="form-control btn btn-primary"/>

            </div>
          </div>
         
            <input  type="button" value="REGISTRAR" id="btn_registrar" name="btn_registrar" onclick="  enviar_datos_transferencia_sc();"  class="form-control btn btn-danger" />
                
        <br>
        <div   class="row" id="divid"  >
            <div class="col-md-12">
                <div class="panel panel-primary">
                <div class="panel-heading" > </div>
                    <table id="grilla_transfer" data-row-style="rowStyle" data-toggle="table"  class=" table table-responsive" data-click-to-select="true">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>NRO.</th>
                                <th>CANTIDAD</th>
                                <th>PLANCHAS</th>
                                <th>UNIDADES</th>
                                <th>FECHA PUESTA</th>
                                <th>DETALLE</th>
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>                      
                </div> 
            </div> 
        </div> 
    
 