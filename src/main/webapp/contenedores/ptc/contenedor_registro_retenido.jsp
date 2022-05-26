 <%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
      <%   
        ResultSet rs,rs2,rs3; 
        String fecha_clasificacion="";
         clases.controles.connectarBD();   
       try{
        
        Statement stmt = clases.controles.connect.createStatement();
         
        rs =stmt.executeQuery( "SELECT  convert(varchar,getdate(),111) as fecha,REPLACE(CONVERT(VARCHAR(10),  convert(varchar,getdate(),103), 5),'/','') ");
        while(rs.next()){          
            fecha_clasificacion=rs.getString(1);
        }  
     
     String version=clases.versiones.contenedores_ptc_contenedor_registro_retenido;

       %>  
 <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')" >
    <label neme="label_contenido" id="label_contenido" value="0031-REP-01032022-A"><%=version%></label>  
</div>
</head>
       <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>REGISTRO DE CARROS RETENIDOS</b></center>
</div>
   </div>  <br>       
    <form method="post" id="formulario"  >
        <div class="form-group">
            <div class="input-group">
                <div class="form-groupss " >
                    <b>Fecha de clasificación inicial</b>
                    <input style="font-weight: bold;" id="calendario_registro" name="calendario_registro"  class="datepicker"    value="<%=fecha_clasificacion%>"  onchange=" $('#fecha_clas_final').val($('#calendario_registro').val());validar_fechaInicial_fechaFinal();"  />
                </div>
                <input type="checkbox"  data-toggle="toggle"    data-on="BORROSO SI"    data-off="BORROSO NO"   id="chkToggle2"             data-onstyle="success" data-offstyle="warning"  class="checkbox">
                <input type="checkbox"  data-toggle="toggle"    data-on="ESPECIAL SI"   data-off="ESPECIAL NO"  id="chkToggle_especial"     data-onstyle="primary" data-offstyle="danger"   class="checkbox">
                <input type="checkbox"  data-toggle="toggle"    data-on="CEPILLADO SI"  data-off="CEPILLADO NO" id="chkToggle_cepillado"    data-onstyle="primary" data-offstyle="danger"   class="checkbox">
                <input id="codigo_especial"     name="codigo_especial"   value="NO" type="hidden"   />
                <input id="codigo_borroso"      name="codigo_borroso"    value="NO" type="hidden" />
                <input id="codigo_cepillado"    name="codigo_cepillado"  value="NO" type="hidden" />
            </div>
        </div>
        <br>
        <div id="boxColor_red">
            <br>
            <div class="input-group">
                <b>   FECHAS INVOLUCRADAS</b></label>
                <input id="txt_fecha_involucrada" name="txt_fecha_involucrada" autocomplete="off"  type="text" placeholder="FECHAS INVOLUCRADAS (OPCIONAL)"/>
            </div>
              <br>
        </div>  
        <br>        
        TIPO MAPLES
        <select style="font-weight: bold;" class="form-control" name="tipo_maples" id="tipo_maples">
            <OPTION VALUE="IM">TIPO IM</OPTION>
            <OPTION VALUE="IIM">TIPO IIM</OPTION>
            <OPTION VALUE="IIH">TIPO IIH</OPTION>
        </select>
        <br>
            
        <div class="form-group">
            <div class="input-group">
                <select style="font-weight: bold;" class="form-control" name="tipo_huevo_retenido" id="tipo_huevo_retenido" required="true"  onchange="cargar_unidad_medida_PTC('tipo_huevo_retenido','unidad_medida_retenido');consulta_empacadora_retenido();">
                    <OPTION selected disabled>Seleccione tipo de huevo</OPTION>
                    <OPTION VALUE="1">G</OPTION>
                    <OPTION VALUE="2">J</OPTION>
                    <OPTION VALUE="3">S</OPTION>
                    <OPTION VALUE="4">A</OPTION>
                    <OPTION VALUE="5">B</OPTION>
                    <OPTION VALUE="6">C</OPTION>
                    <OPTION VALUE="7">4TA</OPTION>
                </select>   
                <span class="input-group-addon">-</span>
                <div class="input-append">  
                    <input style="font-weight: bold;" id="fecha_puesta" class="datepicker" name="fecha_puesta"   width="276" value="<%=fecha_clasificacion%>" placeholder="Fecha puesta" required="" />
                </div>
          
                <span class="input-group-addon">-</span>
            </div>
        </div>
            <br>
        <div class="form-group">
            <div class="input-group">
                <input style="font-weight: bold;" name="cod_carrito" id="cod_carrito" type="number" autocomplete="off" required class="form-control" placeholder="Codigo carrito,Mesa,Pallet" onkeyup="contar()" onKeyPress="return soloNumeros(event)" >
                <span class="input-group-addon">-</span>
                <div class="input-append">  
                    <select  style="font-weight: bold;" class="form-control" name="unidad_medida_retenido" id="unidad_medida_retenido" required="true" onchange="limpiar_cantidad_retenido()" > </select>
                </div> 
            </div>
        </div>
   
        <div> 
            SELECCIONE NRO DE EMPACADORA
                <div id="combo" class="form-group">                 
                    <select   name="nro_empacadora" required="true"   id="nro_empacadora" class="form-control"  multiple="multiple" >
                    
                    </select>
                </div>
        </div>
        
   
        <div> 
            SELECCIONE ESTADO DE RETENCION
            <div id="combo" class="form-group">                 
                <select style="font-weight: bold;"  name="estado_retenido" required="true"   id="estado_retenido" class="form-control">
                    <option style="font-weight: bold;" value="R">RETENIDO</option>
                    <option style="font-weight: bold;" value="Z">RETENIDO CON REPORTE</option>
                </select>
            </div>
            <br>
        </div>
        <div class="input-group">
            <b>   Cantidad</b></label>
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
        <style>
              .cambio {
        color: #000;
        }
        </style>
        <br>
        <div id="boxColor">  
            <br>
            <div class="input-group">
                <b>   Hora inicio</b></label>
                <input type="text"   placeholder="HORA DE INICIO"  name="hora_desde" id="hora_desde" class="inputmask" required onblur="validar_fechaInicial_fechaFinal()">
                
            </div>
            <br>
            <div class="input-group">
                <b>   Fecha final de clasificacion</b></label>
                <input type="text" id="fecha_clas_final"  name="fecha_clas_final" class="datepicker" placeholder="FECHA FINAL " value="<%=fecha_clasificacion%>" onchange="validar_fechaInicial_fechaFinal()" >
            </div>
            <br>
            <div class="input-group">
                <b>   Hora final</b></label>
                <input type="text"   class="inputmask" placeholder="HORA DE FINALIZACION" name="hora_hasta" id="hora_hasta" required onblur="validar_fechaInicial_fechaFinal()">
                
            </div>
             <br>
            <div class="input-group"id="div_aviarios">
                <input type="hidden"  data-toggle="toggle" data-on="NO APLICA"     data-off="APLICA"   id="chkToggle_aviario"             data-onstyle="success" data-offstyle="warning">

                    <b>Aviarios disponibles segun horario</b></label>
                    <select  name="cbox_aviarios"  id="cbox_aviarios" class="form-control"  multiple="multiple" required >
                    
                    </select>
            </div>
            <br>
        </div>
        <br>
        <div class="input-group">
            <b>   Tipo de aviario</b></label>
                <select style="font-weight: bold;" class="form-control" required="true" name="tipo_aviario" id="tipo_aviario">
                    <OPTION style="font-weight: bold;"  VALUE="M">M</OPTION> 
                    <OPTION style="font-weight: bold;"  VALUE="T">T</OPTION>
                </select>  
        </div>  
        <br>
        <div class="input-group">
            <b>   Tipo de almacenamiento</b></label>
            <select style="font-weight: bold;" class="form-control" name="tipo_almacenamiento" id="tipo_almacenamiento" required="true"  >
                <OPTION style="font-weight: bold;" VALUE="C">C</OPTION> 
                <OPTION style="font-weight: bold;" VALUE="P">P</OPTION>
                <OPTION style="font-weight: bold;" VALUE="M">M</OPTION>
            </select>
        </div>  
        <br>
        
        <div class="form-group">
            <div class="input-group">
                <select style="font-weight: bold;" class="form-control" required="true" name="estado_liberacion" id="estado_liberacion">
                    <OPTION style="font-weight: bold;" selected disabled value="">Estado de liberación</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="NC">NO CONFORME</OPTION> 
                    <OPTION style="font-weight: bold;"VALUE="PNC">POTENCIALMENTE NO CONFORME</OPTION>
                    <OPTION style="font-weight: bold;" VALUE="PNC-NC">POTENCIALMENTE NO CONFORME - NO CONFORME</OPTION>
                </select>   
                <span class="input-group-addon">- </span>
                Motivo de retencion
                <select style="font-weight: bold;" class="form-control" name="motivo_retencion"  multiple="multiple"  id="motivo_retencion" required="true" >
                    <%  
                    rs2 = stmt.executeQuery( "select * from motivo_retencion where tipo='motivo'");
                    while(rs2.next()){   %>    
                    <OPTION style="font-weight: bold;" VALUE="<%=rs2.getString("descripcion")%>"><%=rs2.getString("descripcion")%></OPTION> <% }  %>  
                </select>  
            </div> 
        </div>   
        
        <div class="input-append">  
            <select  style="font-weight: bold;" class="form-control" required="true" name="disposicion" id="disposicion"  onchange="ver_div()" >
                <OPTION style="font-weight: bold;" selected disabled value="">Disposición</OPTION>
                <%   rs3 = stmt.executeQuery( " select * from motivo_retencion where tipo='disposicion'");
                while(rs3.next())   { %>    
                <OPTION style="font-weight: bold;" VALUE="<%=rs3.getString("id")%>"><%=rs3.getString("descripcion")%></OPTION>  <%}%>  
            </select>   
        </div> 
        <br>
        <div class="form-group">
            <div class="input-group">
                <input  style="font-weight: bold;" name="txt_responsable" style="text-transform: uppercase;" autocomplete="off" autocomplete="off" id="txt_responsable" type="text" required="true" class="form-control" placeholder="Responsable">
            
            </div>  
        </div>   
        
        <input style="font-weight: bold;" name="txt_obs" style="text-transform: uppercase;" id="txt_obs" type="text" class="form-control" placeholder="Comentario">
        <br><br>
        <input style="font-weight: bold;" type="submit" value="Registrar" id="btn_registrar" name="btn_registrar"  class="form-control btn btn-primary " style="  height:70px"   />
        <br> 
    </form> 
    <% 
          } catch (Exception e) {
        }
finally{
 clases.controles.DesconnectarBD(); 
}
      %>