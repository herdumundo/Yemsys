 <%@include  file="../../chequearsesion.jsp" %>
 <%@include file="../../cruds/conexion.jsp" %>
<%
    if (sesion == true) 
    {
        String cod_usuario = (String) sesionOk.getAttribute("cod_usuario");
        String pass= request.getParameter("txt_pass");
        PreparedStatement pss = connection.prepareStatement("update usuarios set password='"+pass+"' where cod_usuario='"+cod_usuario+"' ");
        pss.executeUpdate();      
        connection.close();
%> CAMBIOS REALIZADOS.
<br><br><br> <h1><a href="../menu.jsp">VOLVER AL MENU PRINCIPAL</a></h1>  
    <%}%>