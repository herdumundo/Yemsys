<!DOCTYPE html>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%    String usuario = (String) sesionOk.getAttribute("usuario");
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    sesionOk.setAttribute("area", clasificadora);
    String user_name = (String) sesionOk.getAttribute("nombre_usuario");
%>
     

   <% 
     String version=clases.versiones.contenedores_ptc_contenedor_info_ptc_excel;

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
    <center><b>INFORMES DE LOTES</b></center>
</div>
 <br>
<form id="form_excel">
    <div class="form-group">
        <div class="input-group">
            <b>FECHA DE PUESTA</b>
            <input id="calendario_ptc_excel" type="text" class="datepicker"     />


            <span class="input-group-addon">-</span>
            <div class="input-append">  
                <select class="form-control" name="estado" id="estado"  >
                    <OPTION selected value=""  >Estado liberacion</OPTION>

                    <OPTION VALUE="L">Liberado</OPTION> 
                    <OPTION VALUE="R">Retenido</OPTION> 
                    <OPTION VALUE="E">Eliminados</OPTION> 


                </select>             </div>


            <input type="submit" value="BUSCAR"  class="form-control bg-navy btn_buscar_excel">

        </div>
    </div>
    <br>   


    <div id="ptc_excel"> </div>


</form>