
 <%@page import="clases.variables"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />

 
<%
  
    String area = (String) sesionOk.getAttribute("clasificadora");
    %>
       <% 
     String version=clases.versiones.grillas_ptc_grilla_pendiente_liberacion;

       %>
</head>
 

    <form > 
        <label  ><b></b></label> 

        <div class="float-right d-none d-sm-inline-block" href="#" id="contenido_version"  data-toggle="modal" data-target=".bd-example-modal-xx"  
             onclick="cargar_datos_modal_version('<%=version%>','VERSION: <%=version%>')" >
    <label neme="label_contenido" id="label_contenido" ><%=version%></label>  
</div>
        <div class="col-lg-20 ">
<div class="position-relative p-3 bg-navy"  >
<div class="ribbon-wrapper">
<div class="ribbon bg-warning">
PTC
</div>
</div>
    <center><b>PENDIENTES A LIBERAR</b></center>
</div>
   </div>
   <table id="grilla_lotes_liberacion" class="table table-striped table-bordered" style="width:100%">
                     <thead>
    <tr>                
      
     
            <th>Cod interno</th>
            <th>Fecha clasificacion</th>
            <th>Fecha puesta</th>
            <th>Codigo</th>
            <th>Cantidad</th>
            <th>Tipo huevo </th>
            <th>Estado liberación</th> 
            <th>Disposicion</th> 
            <th>Estado Costeo</th> 
            <th>Accion</th> 
     </tr>
    </thead>
        <%
                clases.controles.connectarBD();   
                Connection cn = clases.controles.connect; 
                fuente.setConexion(cn);            
                ResultSet rs = fuente.obtenerDato("exec [mae_ptc_select_pendientes_liberacion] @area='"+area+"'");
       
                while(rs.next())
                {  %>
                    <tr id="<%=rs.getString("cod_interno")%>">  
                        <td><b><%=rs.getString("cod_interno")%></b>    </td>
                        <td><b><%=rs.getString(1)%></b>    </td>
                        <td><b><%=rs.getString(2)%>    </b></td>
                        <td><b><%=rs.getString(3)%>    </b></td>
                        <td><b><%=rs.getString(4)%>    </b></td>
                        <td><b><%=rs.getString(5)%>    </b></td>
                        <td><b><%=rs.getString(6)%>    </b></td>
                        <td><b><%=rs.getString(7)%>    </b></td>
                        <td><b><%=rs.getString("tipo")%>    </b></td>
                        <td><input type="button" value="LIBERAR" class="form-control bg-success color_letra" onclick="liberar_retenidos_mensaje('<%=rs.getString("cod_Carrito")%>','<%=rs.getString("cod_lote")%>','<%=rs.getString("disposicion")%>','<%=rs.getString("cod_interno")%>','<%=rs.getString("tipo_registro")%>');" ></td>
                    </tr>
            <%  } 
                cn.close();
                clases.controles.DesconnectarBD();
            %>
 
        <tbody id="tbody_id"> 
             
                 </tbody>
   
     </table>
       
       
  </form>