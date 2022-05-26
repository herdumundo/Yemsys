<%-- 
    Document   : chequearsesion
    Created on : 20/12/2021, 15:35:10
    Author     : csanchez
--%>

<%@ page session="true" %>
<%
    HttpSession sesionOk = request.getSession();
    sesionOk.setMaxInactiveInterval(-1);
    if (sesionOk.getAttribute("id_usuario") == null ) 
    {
        
        if(clases.controles.connectSesion!=null ){
            clases.controles.connectSesion.close();
            }
        if (clases.controles.connect!=null){
        clases.controles.connect.close();
        }
        
         response.sendRedirect("index.jsp");
    }
%>