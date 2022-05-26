<%-- 
    Document   : transferencia_lotes
    Created on : 26/05/2020, 07:55:33 AM
    Author     : hvelazquez
--%>
<%@page import="clases.controles"%>
<%@page import="clases.fuentedato"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="fuente2" class="clases.fuentedato" scope="page"/>   
     <%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
     String area =(String) sesionOk.getAttribute("clasificadora");
  %>
     <div class="form-group">
    <script>
        $('#<%=area%>').hide();
    </script>
    <head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('0023-REP-01032022-A','VERSION: 0023-REP-01032022-A')">
    <label ></label>0023-PAN-01032022-A  
</div>
</head>
    <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
MIS
</div>
</div>
    <center><b>REGISTRO DE TRANSFERENCIAS DE SUBPRODUCTOS</b></center>
</div>
    </div>  <br><!-- comment -->
       <br> 
       <a>Destino</a>

         <div class="input-group">
             <select class="form-control" name="cbox_destino" id="cbox_destino" required>
                 <option    value=""       disabled="disabled"    selected="selected">DESTINO </option>
                 <option    id="S" value="S"  >SUBPRODUCTO </option>
                 <option    id="HP" value="HP"  >HUEVO EN POLVO </option>
        
                 
             </select>
      
             </div> </div>
                            <a>Chofer</a>

    <select style=" font-weight: bold" class="form-control" name="cbox_chofer" id="cbox_chofer" required> 
                 <option    value=""       disabled="disabled"    selected="selected">CHOFER </option>
                <% 
                    controles.VerificarConexion();
                    Connection cn2 = controles.connectSesion;
                    fuente2.setConexion(cn2);  
                    ResultSet rs_chofer,rs_camion;
                    
                     rs_chofer = fuente2.obtenerDato(" select code,name from maehara.dbo.[@CHOFERES] with(nolock) order by 2 ");
       while(rs_chofer.next()){ 
                
                %>
                <OPTION VALUE="<%=rs_chofer.getString("code")%>_<%=rs_chofer.getString("name")%>"> <%=rs_chofer.getString("name")%> </OPTION><%
                 }
                rs_chofer.close();%>
                </select>  
                <span class="input-group-addon">Camión</span>
                <select class="form-control" name="cbox_camion" id="cbox_camion" required>
                 <option    value=""       disabled="disabled"    selected="selected">CAMION </option>
                 <%
                    
            rs_camion = fuente2.obtenerDato("select code,name from maehara.dbo.[@CAMIONES] ");
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
                <input type="number" placeholder="LOTE" name="txt_lote" id="txt_lote" class="form-control" onkeypress="cargar_datos_key_trans_subproducto();"/>
                 
            <span class="input-group-addon">-</span>
            <input type="button" value="INGRESAR" name="btn_ingresar" id="btn_ingresar" onclick="consulta_lotes_transferencias_subproductos($('#txt_lote').val());" class="form-control btn btn-primary"/>

            </div>
          </div>
         
            <input  type="button" value="REGISTRAR" id="btn_registrar" name="btn_registrar" onclick="enviar_datos_transferencia_subproductos();"  class="form-control btn btn-danger" />
                
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
                                <th>TIPO</th>
                                <th>ESTADO COSTEO</th>
                                <th>LOTE</th>
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
    

 <% cn2.close();    
  clases.controles.DesconnectarBDsession();
%>
      
