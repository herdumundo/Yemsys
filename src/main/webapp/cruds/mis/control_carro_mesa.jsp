 <%@page import="clases.controles"%>
<%@page import="java.sql.PreparedStatement"%>

 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page import="java.sql.Connection"%>
    <%@include  file="../../chequearsesion.jsp" %>

<%     controles.VerificarConexion();
    Connection cn = controles.connectSesion;
     // Asignar conexion al objeto manejador de datos
     fuente.setConexion(cn);   
      String  codigo_mesa  = request.getParameter("codigo_mesa");
      String id_lote=request.getParameter("id_carrito");
        PreparedStatement pss = cn.prepareStatement("update lotes set cod_cambio ='"+codigo_mesa+"' where cod_interno='"+id_lote+"' ");
        pss.executeUpdate();
            clases.controles.DesconnectarBDsession();
%>  