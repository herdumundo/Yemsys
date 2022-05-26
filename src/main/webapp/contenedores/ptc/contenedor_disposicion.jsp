<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>   
  <%@include  file="../../chequearsesion.jsp" %>

<!--<link href="estilos/css/styles_loading.css" rel="stylesheet">-->
      <% 
         clases.controles.VerificarConexion();
         Connection cn = clases.controles.connectSesion; 
        fuente.setConexion(cn);  
     String version=clases.versiones.contenedores_ptc_contenedor_disposicion;
 try {
         
       %> 
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
    <center><b>CAMBIO DE DISPOSICIÓN Y LIBERACION DE REPROCESADOS</b></center>
</div>
   </div>  <br>              
        
         <form id="formulario_reproceso" method="post" >
            <select  name="tipo" required   id="tipo" class="form-control"   >
            <OPTION selected disabled>SELECCIONAR FILTRO POR FECHA DE PUESTA O CLASIFICACION</OPTION>
            <option value="P">FECHA DE PUESTA</option>
            <option value="C">FECHA DE CLASIFICACION</option>
        </select>
                  <div class="form-group">
                  <a>INGRESAR FECHA</a>   
                  <div class="input-group">
        
                      <input id="calendario_reproceso" name="calendario_reproceso" type="text" class="datepicker"  width="276"   />
 
        <span class="input-group-addon">-</span>
         Disposicion actual
             <select class="form-control" required="true" name="disposicion" id="disposicion"  onchange="accion_combo_ptc();">
            <OPTION selected disabled>Disposición actual</OPTION>
              <%  
	// Asignar conexion al objeto manejador de datos
         ResultSet rs3 = fuente.obtenerDato("select * from motivo_retencion where tipo='disposicion'");
        while(rs3.next())   
             {          
                %>    
        <OPTION VALUE="<%=rs3.getString("id")%>"><%=rs3.getString("descripcion")%></OPTION> 
             
          <% } rs3.close(); %>  
            </select> 
                  </div> 
        </div>
             
    <br>
    <br>
     
      
    <div id="div_disposicion"  style="display: none;">
         Cambio de disposicion
            
          <select class="form-control" required="true" name="disposicion_insert" id="disposicion_insert" onchange="funcion_disposicion();">
            <OPTION selected disabled>Cambio de disposicion</OPTION>
              <%  
	// Asignar conexion al objeto manejador de datos
	            //CAMBIAR BASE DE DATOS                                                                                                                                                                                                                                                                                                                                                                                                                //CAMBIAR BASE DE DATOS       
        ResultSet rs4 = fuente.obtenerDato("select * from motivo_retencion where tipo='disposicion'");
        while(rs4.next())   {          
                %>    
        <OPTION VALUE="<%=rs4.getString("id")%>"><%=rs4.getString("descripcion")%></OPTION> 
             
          <%                } 
                rs4.close();  %>  
            </select>  
    </div>

        <div id="div_fecha_ali" style="display: none;">
         
            <br>
            
        Fecha de alimentacion
        <input id="calendario_alimentacion" name="calendario_alimentacion" class="datepicker" type="text"  width="276"/>
     <br>
    <br>
        <input type="text"  id="txt_lib" name="txt_lib" placeholder="LIBERADO POR" class="form-control">
                    <br>  
        
        <br>
        <input type="text"  id="txt_nro_mesa" name="txt_nro_mesa" placeholder="OBSERVACION" class="form-control">
                    <br>
       
                    <input type="text" name="caja_check" style="display: none"  id="caja_check"  >
            <br>
           
            </div>


    <div id="div_registro" style="display: none">
        <input type="button" class="form-control bg-primary "style="font-weight: bold;color:black;" value="REGISTRAR" onclick=" Enviar_datos_cambio_disposicion_lib();">
           </div>
    <div id="contenedor_grilla_reproceso" >

    </div>

  </form>
            
    <%
        } catch (Exception e) {
     }
     finally{
        clases.controles.DesconnectarBDsession();
}
%>
      