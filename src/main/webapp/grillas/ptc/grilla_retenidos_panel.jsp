<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
 
<%
       
        String area = (String) sesionOk.getAttribute("clasificadora");
 
String SQL="select convert(varchar,a.fecha,103) as fecha,convert(varchar,a.fecha_puesta,103) as  fecha_puesta,"
        + "a.cod_Carrito,a.cantidad,a.tipo_huevo,replace(right(a.estado_liberacion,1),'Z','R.') as estado  ,c.descripcion ,"
        + " a.cod_lote,a.cod_interno ,b.disposicion,b.motivo_retencion,b.estado_retencion ,b.disposicion   "
        + "from lotes a 	  "
        + " inner join lotes_retenidos b on a.cod_interno=b.id_lote	   "
        + "inner join motivo_retencion c on b.disposicion=c.id "
        + " where right(a.estado_liberacion,1) in ('R','Z') 	  and "
        + "a.estado='a' and a.clasificadora_actual='"+area+"' and b.movimiento ='a' order by fecha";
 
   %>
   
   <table id="grilla_lotes_motivos" class="table table-striped table-bordered" style="width:100%">
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
                        <th>Accion</th> 
     </tr>
    </thead>
        <%
             clases.controles.connectarBD();   
                Connection cn = clases.controles.connect; 
                fuente.setConexion(cn);       
                ResultSet rs = fuente.obtenerDato(SQL);
       
     while(rs.next()){
       

         
 %>
                    <tr id="<%=rs.getString("cod_interno")%>">  
        
                            <td><b><%=rs.getString(1)%></b>    </td>
                            <td><b><%=rs.getString(2)%>    </b></td>
                            <td><b><%=rs.getString(3)%>    </b></td>
                            <td><b><%=rs.getString(4)%>    </b></td>
                            <td><b><%=rs.getString(5)%>    </b></td>
                            <td><b><%=rs.getString(6)%>    </b></td>
                            <td><b><%=rs.getString(7)%>    </b></td>
                            <td><b><%=rs.getString("motivo_retencion")%>    </b></td>
                            <td><b><%=rs.getString("estado_retencion")%>    </b></td>
                            <td><button    class=" bg-success" onclick="$('#cod_lote').val('<%=rs.getString("cod_lote")%>');
                                $('#cod_interno').val('<%=rs.getString("cod_interno")%>');
                                $('#div_header').text('CARRO NRO '+'<%=rs.getString("cod_carrito")%>');$('#btn_motivo').show(); " data-toggle="modal" data-target="#modal_liberar"> <b>REEMPLAZAR MOTIVO </b>  </button></td>

                            <td> <button       onclick="$('#cod_lote_estado').val('<%=rs.getString("cod_lote")%>');
                                $('#cod_interno_estado').val('<%=rs.getString("cod_interno")%>');
                                $('#div_header_estado').text('CARRO NRO '+'<%=rs.getString("cod_carrito")%>');$('#btn_producto').show(); " data-toggle="modal" data-target="#modal_estado_producto"> <b>REEMPLAZAR ESTADO DEL PRODUCTO </b>  </button> </td>

                             <td><button  class=" bg-danger" onclick="$('#cod_lote_disposicion').val('<%=rs.getString("cod_lote")%>');
                                 $('#disposicion_select').val('<%=rs.getString("disposicion")%>');
                                $('#cod_interno_disposicion').val('<%=rs.getString("cod_interno")%>');
                                $('#div_header_disposicion').text('CARRO NRO '+'<%=rs.getString("cod_carrito")%>');$('#btn_disposicion').show(); " data-toggle="modal" data-target="#modal_disposicion"> <b>REEMPLAZAR DISPOSICION </b>  </button></td>

                    </tr>
       <% } 
       cn.close();
       clases.controles.DesconnectarBD();
       %>
     
        <tbody id="tbody_id"> 
                </tbody>
      </table>
       
