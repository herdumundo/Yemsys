 <%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
  <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>   
<%@include  file="../../chequearsesion.jsp" %>
      <%
          String area_registro = (String) sesionOk.getAttribute("clasificadora"); 
          
          String area_format="";
          
          if (area_registro.equals("A")||area_registro.equals("B")) {
              area_format="cch";
          }
          
          if (area_registro.equals("O")) {
              area_format="ovo";
          }
                  
 	 clases.controles.connectarBD();   
            Statement stmt = clases.controles.connect.createStatement();
            
        ResultSet rs = stmt.executeQuery("SELECT  convert(varchar,getdate(),103) as fecha,REPLACE(CONVERT(VARCHAR(10), GETDATE(), 5),'-','') ");
       while(rs.next()){          
 %>  
 
 <% 
     String version=clases.versiones.contenedores_mis_contenedor_carro_mesa;
 
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
MIS
</div>
</div>
    <center><b>REGISTRO DE CARRO A MESA</b></center>
</div>
   </div>  <br>      
<form method="post" id="formulario_carro_mesa">
     <br> <br>
            <div class="input-append">  
            <span class="input-group-addon">Fecha de clasificación</span>
            <input id="calendario_mesa" name="calendario_mesa"  class="datepicker"    />
           
          
            <%}
            %>  <br>
            </div> 
            
            <input type="button" class="form-control"  value="Buscar" onclick="traer_grilla_carromesa($('#calendario_mesa').val())" >
 
     <div id="div_grilla_carromesa">
              
                
                
            </div>
     
    
    
</form>
