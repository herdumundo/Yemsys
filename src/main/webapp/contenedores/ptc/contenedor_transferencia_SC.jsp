<%-- 
    Document   : transferencia_lotes
    Created on : 26/05/2020, 07:55:33 AM
    Author     : hvelazquez
--%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /> 
  <%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
     String area =(String) sesionOk.getAttribute("clasificadora");
  %> <script>
        $('#<%=area%>').hide();
    </script>
    
    <% 
     String version=clases.versiones.contenedores_ptc_contenedor_transferencia_SC;

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
                <% 
                   
        controles.VerificarConexion();
        fuente.setConexion(clases.controles.connectSesion);
       
                    ResultSet rs_chofer,rs_camion;
                    
                     rs_chofer = fuente.obtenerDato(" select code,name from maehara.dbo.[@CHOFERES] with(nolock) order by 2 ");
       while(rs_chofer.next()){ 
                
                %>
                <OPTION VALUE="<%=rs_chofer.getString("code")%>_<%=rs_chofer.getString("name")%>"> <%=rs_chofer.getString("name")%> </OPTION><%
                 }
                rs_chofer.close();%>
                </select>  
                <br>
                <span class="input-group-addon">Camion</span>
                <select class="form-control" name="cbox_camion" id="cbox_camion" required>
                 <option    value=""       disabled="disabled"    selected="selected">CAMION </option>
                 <%
                    
            rs_camion = fuente.obtenerDato("select code,name from maehara.dbo.[@CAMIONES] ");
       while(rs_camion.next()){ 
      
            String camion_1=rs_camion.getString("code");
            String camion_2=rs_camion.getString("name");
            %><OPTION VALUE="<%=camion_1%>_<%=camion_2%>"><%=camion_1%>- <%=camion_2%> </OPTION><%
            }
              
           %>

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
    

   <%
        clases.controles.DesconnectarBDsession();
%>
      
