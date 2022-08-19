<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.fuentedato"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../versiones.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>  <%     
    ResultSet rs,rs2,rs3;
    PreparedStatement  pst,pst2,pst3;
    String id = request.getParameter("id") ;
    pst = connection.prepareStatement("select * from  maehara.dbo.[@CAMIONES] where u_estado='Activo' and   u_desc<>'' ");
    pst2 = connection.prepareStatement("select code,name  from maehara.dbo.[@CHOFERES] where U_estado='activo'");
    pst3 = connection.prepareStatement("    select id_cab,id_chofer,id_camion,clasificadora  "
            + "     from 		 mae_log_ptc_det_pedidos2 t0 inner join mae_log_ptc_cab_pedidos t1 on t0.id_cab=t1.id   "
            + " where id_cab="+id+" and t0.estado=2 group by id_cab,id_chofer,id_camion,clasificadora");
    
    
    
    rs = pst.executeQuery();
    rs2 = pst2.executeQuery();
    rs3 = pst3.executeQuery();
  
     String version= contenedores_logistica_contenedor_pedidos;
 try {
         
      %>
<head>   
<label  ><b></b></label> 
<div class="float-right d-none d-sm-inline-block" href="#" data-toggle="modal" data-target=".bd-example-modal-xx" 
     onclick="cargar_datos_modal_version('<%=version%> ','VERSION: <%=version%> ')">
    <label ><%=version%> </label>  
</div>
</head>
   <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
LOG
</div>
</div>
    <center><b>REGISTRO DE PEDIDOS</b></center>
</div>
   </div>  <br>    
     
   
    
        <div id="div_pedido"> 
  
     <a style="font-weight: bold;color:black">SELECCIONE CHOFER</a> 
    <select id="cbox_chofer" class="btn btn-dark"  style="font-weight: bold;color:white;" >
        <option codigo="-"  value="-">CHOFER</option>
        <%while(rs2.next())
        { %><option codigo="<%=rs2.getString("code")%>" id="<%=rs2.getString("code")%>" value="<%=rs2.getString("code")%>"><%=rs2.getString("name")%> </option><%  } %>
    </select>
    
     
    
    <a style="font-weight: bold;color:black">CARROS CARGADOS:</a><input type="text" disabled id="txt_cargados" style="font-weight: bold;color:black" value="0" >
    <input  type="hidden" id="id_pedido"> 
    <input  type="hidden" id="validacion_cantidades"> 
    <input  type="hidden" id="validacion_tipos"> 
    
    <br> <br>
   
    
        <form  class="row align-items-end"  action="cruds/logistica/control_reporte_log_stock_ptc.jsp" target="_blank">
            <input type="button" value="GENERAR PEDIDO"   onclick="registrar_pedido_mod_log();"  class="form-control col bg-success inline" id="btn_generar"style="font-weight: bold;color:white;"   >
            <input type="submit" value="GENERAR REPORTE"    class="form-control col bg-dark "  style="font-weight: bold;color:white;"   >

       </form> <br>
       
       <input type="text" placeholder="Observación (Opcional)" id="txt_obs" class="form-control"><br> 
     
    
       </div>
      <div class="input-group mb-3">
                        <div class="input-group-prepend">
                        <button type="button" class="btn btn-danger">MODIFICACIONES POR AREA</button>
                        </div>

                        <div id="grupo_areas" class="btn-group btn-group-toggle" data-toggle="buttons">
                       
                            <% 
                            while (rs3.next()) {
                                    
                             %>       
                            
                            <label class="btn btn-secondary "> 
                                <input type="radio" name="options" id="option_a1" autocomplete="off" checked="" onclick="ir_pedido_modificacion_porArea(<%=rs3.getString("id_cab")%>,<%=rs3.getString("id_chofer")%>,<%=rs3.getString("id_camion")%>,'<%=rs3.getString("clasificadora")%>')" ><%=rs3.getString("clasificadora")%></label>
                            <%   }
                            %>
                        </div>
                          
                        </div>   
       <div class="container my-4">
        <button id="modalActivate" type="button" class="btn bg-navy form-control" data-toggle="modal" data-target="#exampleModalPreview">
        Abrir ventana de pedidos
        </button>
        <!-- Modal -->
        <div class="modal fade right" id="exampleModalPreview" tabindex="-1" role="dialog" aria-labelledby="exampleModalPreviewLabel" aria-hidden="true">
            <div class="modal-dialog-full-width modal-dialog momodel modal-fluid" role="document">
                <div class="modal-content-full-width modal-content ">
                    <div class=" modal-header-full-width   modal-header text-center">
                       <b>0004-PAN-01032022-A</b>  <button type="button" class="close " data-dismiss="modal" aria-label="Close">
                            <span style="font-size: 1.3em;" aria-hidden="true">&times;</span>
                        </button>
                       

                    </div>
                    <div class="modal-body">
                        
                        <a style="font-weight: bold;color:black">CARROS RESTANTES:</a><input type="text" disabled id="txt_restantes" style="font-weight: bold;color:black" value="0" >
                        <a style="font-weight: bold;color:black">SELECCIONE CAMION</a> 

                       <select class="btn btn-dark"  id="cbox_camion"  style="font-weight: bold;color:white;" onchange="generar_grilla_pedido_log(8),$('#contenido_grillas').show()">
                           <option  capacidad="0" codigo="0" disabled selected class="btn btn-dark" >CAMION</option>
                        <%while(rs.next())
                        { %><option capacidad="<%=rs.getString("u_capacidad")%>" codigo="<%=rs.getString("code")%>" class=" select_camion btn bg-dark <%=rs.getString("code")%>"  id="<%=rs.getString("code")%>" value="<%=rs.getString("code")%>"><%=rs.getString("code")%>-<%=rs.getString("u_desc")%> </option><%  } %>
                    </select>
                        <a style="font-weight: bold;color:black">DISPONIBILIDAD:</a><input type="text" disabled id="txt_disponibilidad" style="font-weight: bold;color:black" value="0" >

                        <div id="contenido_grillas"   class="table-responsive" style="display: none">

                        </div>  
                        <div id="contenido_grillas_mixto"   class="table-responsive">

                        </div>  
                    </div>
                    <div class="modal-footer-full-width  modal-footer">
                        <button type="button" class="btn btn-danger btn-md btn-rounded" data-dismiss="modal">Cerrar</button>
                     </div>
                </div>
            </div>
        </div>
    </div>

<%
    } 
    catch (Exception e) 
    {
    
    }
    finally
    {
        connection.close();
    }
%>