 <%-- 
    Document   : contenedor_registro_reprocesos
    Created on : 15-dic-2021, 9:51:44
    Author     : hvelazquez
--%>
 <%@include  file="../../chequearsesion.jsp" %>
 <div id="contenedor_boton"> </div>
 
 <br> 
 
       
 
   <div class="form-group">
       
       <input type="hidden" id="id">
            <div class="input-group">
                <input type="number" placeholder="LOTE" name="txt_lote" id="txt_lote" class="form-control" onkeypress="cargar_datos_key_reproceso_alimentacion();"/>
                 
            
            <span class="input-group-addon">-</span>
            <input type="button" value="INGRESAR" name="btn_ingresar" id="btn_ingresar" onclick="consulta_lotes_reproceso_alimentacion($('#txt_lote').val());" class="form-control btn btn-dark"/>

 
                
               
          </div>
          </div>
     
     <a id="id_cantidad">Cantidad</a>
 <table id="grilla_transfer" data-row-style="rowStyle" data-toggle="table"  class="table table-striped table-bordered" data-click-to-select="true">
    <thead>
      <tr>
     
    <th>ID</th>
    <th>CARRO</th>
    <th>CANTIDAD</th>
    <th>PLANCHAS</th>
    <th>UNIDADES</th>
    <th>FECHAPUESTA</th>
     <th>TIPO</th>
     <th>TIPO FALLA</th>
     <th>ORIGEN</th>
     <th>ACCION</th>
       </tr>
     </thead>
     <tbody>
         
     </tbody>
  </table>      
 
 
 
 