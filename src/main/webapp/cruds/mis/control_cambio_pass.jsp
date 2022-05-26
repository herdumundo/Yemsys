   <%@page import="clases.controles"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.Connection"%>
<%@include  file="../../chequearsesion.jsp" %>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%
    controles.VerificarConexion();
    Connection cn = controles.connectSesion;
    // Asignar conexion al objeto manejador de datos
    fuente.setConexion(cn);   
    String cod_usuario = (String) sesionOk.getAttribute("cod_usuario");
    String pass= request.getParameter("txt_pass");
    PreparedStatement pss = cn.prepareStatement("update usuarios set password='"+pass+"' where cod_usuario='"+cod_usuario+"' ");
    pss.executeUpdate();      

            clases.controles.DesconnectarBDsession();
%> CAMBIOS REALIZADOS.
<br><br><br> <h1><a href="../menu.jsp">VOLVER AL MENU PRINCIPAL</a></h1>  
