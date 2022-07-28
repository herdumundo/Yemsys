<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@include  file="../../consultas/consulta_gen_options.jsp" %>
 
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>TRANSFORMACIÓN CARRO A MESA</b></center>
</div>
   </div>  <br>       <form method="post" id="formulario_carro_mesa">
     <br> <br>
            <div class="input-append">  
            <span class="input-group-addon">Fecha de clasificación</span>
            <input id="calendario_mesa" name="calendario_mesa" data-format="dd/mm/yyyy"  width="276"  value="<%=fecha_hora%>"   />
           
           <br>
            </div> 
            
            <input type="button" class="form-control"  value="Buscar" onclick="traer_grilla_carromesa($('#calendario_mesa').val())" >
 
    
    
            <div id="div_grilla_carromesa">
                <br>
                  <div   class="row">
            <div class="col-md-12">
                <div class="panel panel-primary">
                    
                    <input class="form-control" id="buscar_carromesa" type="text" placeholder="Buscar">
                        <table  id="tabla_carromesa" data-row-style="rowStyle" class="table"data-toggle="table" data-click-to-select="true">
              
              
                        </table>
                </div> 
            </div> 
          </div> 
                
                
            </div>
    
    
      <div class="modal fade" id="modal_carromesa" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static"   data-keyboard="false">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
           <div >
                <a>INGRESAR NUMERO DE MESA AL CARRO NRO:</a><input type="button"  id="carro_numero_mesacarro" name="carro_numero_mesacarro" >   
                <br>       <br>       
                <input type="text" class=" form-control" style="display: none"   id="codigo_carro" name="codigo_carro" required > 
             </div>
             <div >
                  <input type="text" class=" form-control" placeholder="Codigo de mesa" id="codigo_mesa" name="codigo_mesa" required>
                 <br>       
            </div>
             <div >
                 <button type="button" id="boton_reg" class=" form-control btn btn-primary" onclick="validar_carro_mesa();">Registrar </button>
           </div><br><br>
          
           
        
 
                  <div > 
            <button class="form-control btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
           
         </div>
        </div>
      </div>
    </div>
    
    
</form>
   <%
        
%>
      