
 <%@page import="clases.controles"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@include  file="../../chequearsesion.jsp" %>
 
<%  
 
    String area = (String) sesionOk.getAttribute("clasificadora");
    %>
      <head>  
      <label  ><b></b></label>
<div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"
     data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('0045-REP-01032022-A','VERSION: 0045-REP-01032022-A')" >
    <label neme="label_contenido" id="label_contenido" >0045-REP-01032022-A</label>  
</div>
</head> 
 <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>AGREGAR MOTIVO DE RETENCION A LOTES</b></center>
</div>
   </div>  <br>    
     
   <table id="grilla_lotes_liberacion" class="table table-striped table-bordered" style="width:100%">
                     <thead>

    <tr>
                            
                        <th>Fecha clasificacion</th>
                        <th>Fecha puesta</th>
                        <th>Codigo</th>
                        <th>Cantidad</th>
                        <th>Tipo huevo </th>
                        <th>Estado liberación</th> 
                        <th>Disposicion</th> 
                        <th>Motivo retencion</th> 
                        <th>Estado del producto</th> 
                        <th>Accion</th> 
                        <th>Accion</th> 
     </tr>
    </thead>
        <%
      
      
                clases.controles.connectarBD();   
                Connection cn = clases.controles.connect; 
                fuente.setConexion(cn);            
      ResultSet rs = fuente.obtenerDato("exec [mae_ptc_select_cambio_motivo_retencion] @clasificadora='"+area+"' ");
                                                //NOTA: ES UN PRODECIMIENTO ALMACENADO NUEVO PARA m_lotes
     while(rs.next()){
         
            String estado= rs.getString(6);
            String estado_liberacion="";
            if(estado.endsWith("Z")){
            
            estado_liberacion="R.";
                                }
            else  if(estado.endsWith("R")){
            
            estado_liberacion="R";
                                } 
            else  if(estado.endsWith("L")){
            
            estado_liberacion="L";
                                } 

         
 %>
 <tr id="<%=rs.getString("cod_interno")%>">  
        
                            <td><b><%=rs.getString(1)%></b>    </td>
                            <td><b><%=rs.getString(2)%>    </b></td>
                            <td><b><%=rs.getString(3)%>    </b></td>
                            <td><b><%=rs.getString(4)%>    </b></td>
                            <td><b><%=rs.getString(5)%>    </b></td>
                            <td><b><%=estado_liberacion%>    </b></td>
                            <td><b><%=rs.getString(7)%>    </b></td>
                            <td><b><%=rs.getString("motivo_retencion")%>    </b></td>
                            <td><b><%=rs.getString("estado_retencion")%>    </b></td>
                            <td><input type="button" value="AGREGAR MOTIVO" class="form-control bg-success" onclick="$('#cod_lote').val('<%=rs.getString("cod_lote")%>');
                                $('#cod_interno').val('<%=rs.getString("cod_interno")%>');
                                $('#div_header').text('CARRO NRO '+'<%=rs.getString("cod_carrito")%>');$('#btn_motivo').show(); " data-toggle="modal" data-target="#modal_liberar"></td>

                            <td><input type="button" value="AGREGAR ESTADO DEL PRODUCTO" class="form-control bg-primary" onclick="$('#cod_lote_estado').val('<%=rs.getString("cod_lote")%>');
                                $('#cod_interno_estado').val('<%=rs.getString("cod_interno")%>');
                                $('#div_header_estado').text('CARRO NRO '+'<%=rs.getString("cod_carrito")%>');$('#btn_producto').show(); " data-toggle="modal" data-target="#modal_estado_producto"></td>

                                                    </tr>
       <% } %>
     
       
         
        <tbody id="tbody_id"> 
             
                 </tbody>
   
     </table>
       
       
  <div class="modal fade" id="modal_liberar"      tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <form method="post"   id="form_motivo_retencion">
      <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header" id="div_header">
           
        </div>
            <div class="modal-body">
        <input type="hidden" id="cod_lote" name="cod_lote">
         <input type="hidden" id="cod_interno"name="cod_interno">
        
                <div id="div_calendario"  >  
        <a>SELECCIONAR MOTIVO DE RETENCION</a>
         <select style="font-weight: bold;" class="form-control"  multiple="multiple" name="motivo_retencion"  id="motivo_retencion" required="true" >
           
            
            
            
            <%  
                 ResultSet rs2 = fuente.obtenerDato("select * from motivo_retencion where tipo='motivo'");
       while(rs2.next()){          
 %>    
 <OPTION style="font-weight: bold;" VALUE="<%=rs2.getString("descripcion")%>"><%=rs2.getString("descripcion")%></OPTION> 
             
          <% }  %>  
            </select> 
                
                
                
                </div>
            </div>
            <button class="btn btn-secondary" type="button" id="btn_motivo" onclick="agregar_motivo_retencion()" >AGREGAR MOTIVO DE RETENCION</button>
        <div id="div_cargar" class="text-center" style="display: none">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
              </div> <br>
              <button class="btn btn-danger" type="button" id="btn_cancelar" data-dismiss="modal">CANCELAR</button>
           
       </div>
    </div>
            </form>
  </div>
   
            
            
            
            
            
            
            
            
            
            
            
            
            <form method="post"   id="form_estado_producto">
             
  <div class="modal fade " id="modal_estado_producto"      tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header" id="div_header_estado">
           
        </div>
            <div class="modal-body">
        <input type="hidden" id="cod_lote_estado" name="cod_lote_estado">
         <input type="hidden" id="cod_interno_estado"name="cod_interno_estado">
        
                <div id="div_calendario"  >  
        <a>SELECCIONAR ESTADO DEL PRODUCTO</a>
       <select style="font-weight: bold;" class="form-control" required="true" name="estado_producto" id="estado_producto">
            <OPTION style="font-weight: bold;" selected disabled>Estado de liberación</OPTION>
            <OPTION style="font-weight: bold;" VALUE="NC">NO CONFORME</OPTION> 
            <OPTION style="font-weight: bold;"VALUE="PNC">POTENCIALMENTE NO CONFORME</OPTION>
            <OPTION style="font-weight: bold;" VALUE="PNC-NC">POTENCIALMENTE NO CONFORME - NO CONFORME</OPTION>
            </select>   
                
                
                
                </div>
            </div>
          <button class="btn btn-secondary" type="button" id="btn_producto" onclick="agregar_estado_producto()" >AGREGAR ESTADO DEL PRODUCTO</button>
        <div id="div_cargar_estado" class="text-center" style="display: none">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
              </div> <br>
              <button class="btn btn-danger" type="button" id="btn_cancelar" data-dismiss="modal">CANCELAR</button>
           
       </div>
    </div>
           
  </div>
            
             </form>
            
          <%    cn.close();
              controles.DesconnectarBD(); %>