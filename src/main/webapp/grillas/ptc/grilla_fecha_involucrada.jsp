 <%@page import="clases.controles"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />

<%    String usuario = (String) sesionOk.getAttribute("usuario");
String clasificadora = (String) sesionOk.getAttribute("clasificadora");
String user_name = (String) sesionOk.getAttribute("nombre_usuario");
   String calendario= request.getParameter("fecha");
  %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
 
 <form method="post" id="formulario_eliminar">
              <table id="grilla_involucrada" class="table table-striped table-bordered" style="width:100%">
   
    <thead>
        <th>Nro carro</th>
        <th>U. medida</th>
        <th>Fecha de puesta</th>
        <th> Tipo Huevo</th>
        <th>ACCION</th>   
    </thead>
            
    <%
        clases.controles.connectarBD();   
        Connection cn = clases.controles.connect; 
        fuente.setConexion(cn);                
        ResultSet rs = fuente.obtenerDato("exec [mae_ptc_select_fechaInvolucrada] @fecha='"+calendario+"' ,@clasificadora='"+clasificadora+"'");
       //ESTE PROCEDIMIENTO ALMACENADO ES NUEVO, POR TANTO NO SE COLOCO AL FRENTE DEL NOMBRE "TEST."
        // String tipohuevo="";
    while(rs.next()){
      
    %>  
        <tr id="<%=rs.getString("cod_lote")%>">  
            <td id="nro_carro"><b><%=rs.getString("cod_carrito")%></b></td>
            <td id="nro_carro"><b><%=rs.getString("u_medida")%></b></td>
            <td id="fecha_puesta"><b><%=rs.getString("Fecha_eliminar")%></b></td>
            <td id="tipo_huevo"><b><%=rs.getString("tipo_huevo")%></b></td> 
            <td>
                <input type="button" id="<%=rs.getString("cod_lote")%>" data-toggle="modal" data-target="#cuadro1" onclick="$('#txt_cod_lote').val('<%=rs.getString("cod_lote")%>');$('#cod_interno').val('<%=rs.getString("cod_interno")%>');$('#cantidad_huevos').val('<%=rs.getString("cantidad")%>');$('#txt_fecha_involucradas').val('');$('#txt_fecha_involucradas').multiDatesPicker('resetDates', 'picked'); $('#div_titulo').html('CARRO NRO. '+'<%=rs.getString("cod_carrito")%>')"     class="btn btn-success " value="INGRESAR DATOS">
            </td>  
        </tr> 
           <%}
        cn.close();
        controles.DesconnectarBD();
        %>      
              
                <tbody id="grilla_eliminar">
              
              </tbody>   
          </table>
       </form>
        
              
              
               
               
     
 
    
           
           
  
 
 

        
        
      
      
        




        
        
        
        
        
      