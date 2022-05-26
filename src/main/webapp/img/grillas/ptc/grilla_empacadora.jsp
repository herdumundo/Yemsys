
 <%@page import="clases.controles"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@include  file="../../chequearsesion.jsp" %>
  
<%
       
        String area = (String) sesionOk.getAttribute("clasificadora");
  %>
 
   <table id="example" class="table table-striped table-bordered" style="width:100%">
                     <thead>

    <tr>
                        <th>EMPACADORA</th>      
                        <th>TIPO HUEVO</th>
                        <th>ACCION</th>
                        
    </tr>
    </thead>
        <%
        clases.controles.connectarBD();   
        Connection cn = clases.controles.connect; 
        fuente.setConexion(cn);
        ResultSet rs = fuente.obtenerDato(" select id,empacadora,replace(tipo_huevo,'D','4TA') as tipo_huevo"
            + " from huevos_empacadoras where estado='A' and clasificadora='"+area+"' order by empacadora  ");
            while(rs.next()){
        %>
            <tr>  
                <td><b><%=rs.getString("empacadora")%>           </b></td>
                <td><b><%=rs.getString("tipo_huevo")%>     </b></td>
                <td><input type="button" value="CERRAR" class="form-control" onclick="cerrar_empacadora(<%=rs.getString("id")%>)"></td>
            </tr>
       <% } 
            cn.close();
            controles.DesconnectarBD();
       %>
     
       
         
        <tbody id="tbody_id"> 
             
                 </tbody>
   
     </table>

   