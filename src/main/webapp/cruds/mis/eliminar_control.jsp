<%-- 
    Document   : Delete
    Created on : 02/02/2018, 03:34:00 PM
    Author     : Joel
--%>

<%@page import="clases.controles"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
 
        <%
    String usuario                     = (String) sesionOk.getAttribute("user_name");
    controles.VerificarConexion();
    Connection cn = controles.connectSesion;
    fuente.setConexion(cn);   
    String id= request.getParameter("id") ;
    try {
           PreparedStatement pss = cn.prepareStatement("update lotes set estado='E',usuario_upd='"+usuario+"' ,fecha_modificacion=getdate() "
            + "where cod_interno='"+id+"'");
        pss.executeUpdate(); 
            clases.controles.DesconnectarBDsession();
        } catch (Exception e) {
            String es=e.toString();
        }
  
      
       %>
          
     