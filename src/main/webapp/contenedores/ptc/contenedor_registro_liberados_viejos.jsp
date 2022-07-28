<%@include  file="../../consultas/consulta_gen_options.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../versiones.jsp" %>
      <%
     
     String version= contenedores_ptc_contenedor_reemplazo_motivos;

       %>
 <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx"
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')">
    <label ><%=version%></label> 
</div>
</head>
<div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>REGISTROS DE CARROS LIBERADOS COSTEADOS</b></center>
</div>
   </div>  <br>       
         
    <form method="post"   id="formulario">
      
        <div class="form-group">
            <div class="input-group">
                <div class="form-groupss " >
                    <label class="form-control-placeholder"><b>Fecha de clasificación inicial</b></label>
                    <input style="font-weight: bold;" id="calendario_registro" name="calendario_registro"  class="datepicker" required   value="<%=fecha_hora%>"  onchange=" $('#fecha_clas_final').val($('#calendario_registro').val());validar_fechaInicial_fechaFinal();"/>
                </div>
                <input type="checkbox"  class="checkbox"  data-toggle="toggle" data-on="BORROSO SI"     data-off="BORROSO NO"   id="chkToggle2"             data-onstyle="success" data-offstyle="warning">
                <input type="checkbox"  class="checkbox"  data-toggle="toggle" data-on="ESPECIAL SI"    data-off="ESPECIAL NO"  id="chkToggle_especial"     data-onstyle="primary" data-offstyle="danger">
                <input type="checkbox"  class="checkbox"  data-toggle="toggle" data-on="CEPILLADO SI"   data-off="CEPILLADO NO" id="chkToggle_cepillado"    data-onstyle="primary" data-offstyle="danger">
 
                <input id="codigo_especial"     name="codigo_especial"   value="NO"  type="hidden"/>
                <input id="codigo_borroso"      name="codigo_borroso"    value="NO"  type="hidden"/>
                <input id="codigo_cepillado"    name="codigo_cepillado"  value="NO"  type="hidden" />
            </div>
        </div>
        <br>
        <div id="boxColor_red">
            <br>
            <div class="input-group">
                <label class="form-control-placeholder"><b>   FECHAS INVOLUCRADAS</b></label>
                <input id="txt_fecha_involucrada" name="txt_fecha_involucrada" autocomplete="off"  type="text" placeholder="FECHAS INVOLUCRADAS (OPCIONAL)"/>
            </div>
              <br>
        </div>  
        <br>
        <div class="input-append">  
            <div class="form-groupss " >
                <label class="form-control-placeholder"><b>TIPO MAPLES</b></label>
                <select style="font-weight: bold;" class="form-control" name="tipo_maples" id="tipo_maples" required>
                    <OPTION style="font-weight: bold;" VALUE="IM">TIPO IM</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="IIM">TIPO IIM</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="IIH">TIPO IIH</OPTION>
                </select>  
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <select style   ="font-weight: bold;" class="form-control" name="tipo_huevo" id="tipo_huevo" onchange="cargar_unidad_medida_PTC('tipo_huevo','unidad_medida');consulta_empacadora()" required>
                    <OPTION style="font-weight: bold;" selected disabled>Seleccione tipo de huevo</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="1">G</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="2">J</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="3">S</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="4">A</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="5">B</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="6">C</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="7">4TA</OPTION>
                </select>  
                <span class="input-group-addon">-</span>
                <div class="input-append">  
                    <div class="form-groupss ">
                        <label class="form-control-placeholder"><b>Fecha de puesta</b></label>
                        <input style="font-weight: bold;" id="fecha_puesta" name="fecha_puesta" class="datepicker"   width="276" value="<%=fecha_hora%>" placeholder="Fecha puesta"  required="true"/>
                    </div>
                </div>
            </div> 
        </div>
        <div class="form-group">
            <div class="input-group">
                <input style="font-weight: bold;" name="cod_carrito" id="cod_carrito" type="number" autocomplete="off" required class="form-control" placeholder="Codigo carrito,Mesa,Pallet" onkeyup="contar()" onKeyPress="return soloNumeros(event)" required>
                <span class="input-group-addon">-</span>
                <select  style="font-weight: bold;" class="form-control" name="unidad_medida" id="unidad_medida" required="true" onchange="limpiar_cantidad_retenido()" > </select>
            </div>  
        </div>
        <br>
        <div class="input-append">  
            <div class="form-groupss " >
                <label class="form-control-placeholder"><b>   SELECCIONE NRO DE EMPACADORA</b></label>
                <div id="div_empacadora"> 
                    <div id="combo" class="form-group">                 
                        <select  name="nro_empacadora"  id="nro_empacadora" class="form-control"  multiple="multiple" required >
                    
                        </select>
                    </div>
                </div>  
            </div>  
        </div>
        <div class="input-group">
            <label class="form-control-placeholder"><b>   Cantidad</b></label>
            <select  name="txt_cantidad"  id="txt_cantidad" class="form-control"    required >
                <option selected disabled >SELECCIONE CANTIDAD</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
                <option value="7">7</option>
                <option value="8">8</option>
                <option value="9">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
            </select>
        </div>
        <br>
        <div id="boxColor">  
            <br>
            <div class="input-group">
                <label class="form-control-placeholder"><b>   Hora inicio</b></label>
                <input type="text" data-field="time"  autocomplete="off"  placeholder="HORA DE INICIO"  name="hora_desde" id="hora_desde" required onchange="validar_fechaInicial_fechaFinal();">
                <div class="dtBox"id="dtBox_inicio">
                </div>
            </div>
            <br>
             <div class="input-group">
                <label class="form-control-placeholder"><b>   Fecha final de clasificacion</b></label>
                <input type="text" id="fecha_clas_final"  name="fecha_clas_final" class="datepicker" placeholder="FECHA FINAL " value="<%=fecha_hora%>" onchange="validar_fechaInicial_fechaFinal()" required >
            </div>
            <br>
            <div class="input-group">
                <label class="form-control-placeholder"><b>   Hora final</b></label>
                <input type="text" data-field="time"  autocomplete="off"   placeholder="HORA DE FINALIZACION" name="hora_hasta" id="hora_hasta" required onchange="validar_fechaInicial_fechaFinal();">
                <div class="dtBox" id="dtBox_final">
                </div>
            </div>
             <br>
                <div class="input-group" id="div_aviarios">
                <input type="checkbox"  class="checkbox"  data-toggle="toggle" data-on="NO APLICA"     data-off="APLICA"   id="chkToggle_aviario"             data-onstyle="success" data-offstyle="warning">

                    <label class="form-control-placeholder"><b>Aviarios disponibles segun horario</b></label>
                    <select  name="cbox_aviarios"  id="cbox_aviarios" class="form-control"  multiple="multiple" required >
                    
                    </select>
                
                </div>
                <br>
            </div>
             <br>
         <br>
        <div class="input-group">
            <label class="form-control-placeholder"><b>   Tipo de aviario</b></label>
                <select style="font-weight: bold;" class="form-control" required="true" name="tipo_aviario" id="tipo_aviario">
                    <OPTION style="font-weight: bold;"  VALUE="M">M</OPTION> 
                    <OPTION style="font-weight: bold;"  VALUE="T">T</OPTION>
                </select>  
        </div>  
        <br>
        <div class="input-group">
            <label class="form-control-placeholder"><b>   Tipo de almacenamiento</b></label>
            <select style="font-weight: bold;" class="form-control" name="tipo_almacenamiento" id="tipo_almacenamiento" required="true"  >
                <OPTION style="font-weight: bold;" VALUE="C">C</OPTION> 
                <OPTION style="font-weight: bold;" VALUE="P">P</OPTION>
                <OPTION style="font-weight: bold;" VALUE="M">M</OPTION>
            </select>
        </div>
        <br>
        <div class="form-group" id="div_responsable_liberado">
            <div class="input-group">
                <label class="form-control-placeholder"><b>   Responsable</b></label>
                <input name="txt_responsable" style="text-transform: uppercase;font-weight: bold;" autocomplete="off" id="txt_responsable" required="true"type="text"   placeholder="Responsable">
            </div>  
            <span class="input-group-addon">-</span>
            <div class="input-group">
                <label class="form-control-placeholder"><b>   Liberado por</b></label>
                <input name="txt_liberado"  style="text-transform: uppercase;font-weight: bold;" id="txt_liberado" autocomplete="off" required="true" type="text"   placeholder="Liberado por.">
            </div>  
        </div>  
        <div class="input-group">
            <label class="form-control-placeholder"><b>   Comentario</b></label>
            <input name="txt_obs"    style="text-transform: uppercase;font-weight: bold;" id="txt_obs" type="text" autocomplete="off" class="text-negro"     placeholder="Comentario">
        </div>   
        <br> 
        <input name="text_resultado" style="display: none"  id="text_resultado" type="text"   lass="form-control">
        <input type="submit" value="Registrar" id="btn_registrar" name="btn_registrar"  class="form-control btn btn-primary  " style="height:70px"   />
        <br><br> 
    </form> 