<%-- 
    Document   : chequearsesion
    Created on : 20/12/2021, 15:35:10
    Author     : csanchez
--%>
<%@ page session="true" %>
<%
    HttpSession sesionOk = request.getSession();
    sesionOk.setMaxInactiveInterval(30*60);
    Boolean sesion =true; 
    if (sesionOk.getAttribute("id_usuario") == null ) 
    {
        
        if(clases.controles.connectSesion!=null ){
            clases.controles.connectSesion.close();
            }
        if (clases.controles.connect!=null){
        clases.controles.connect.close();
        }
      sesion=false;   
      response.sendRedirect("login_sesion.jsp");
 
    } 

 
%>