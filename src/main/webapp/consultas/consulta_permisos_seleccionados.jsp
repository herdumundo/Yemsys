<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%     
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String id_rol= request.getParameter("id_rol") ;
    ResultSet rs3;
    JSONObject ob = new JSONObject();
    String seleccionados="";
    ob=new JSONObject();
   rs3 = fuente.obtenerDato(" select * from mae_yemsys_permisos where id_rol="+id_rol+" and id_estado=1  ");
   int c=0;
        while(rs3.next())
    {
        if(c==0){
            seleccionados=rs3.getString("id_modulos");
        }
        else{
           seleccionados=seleccionados+","+rs3.getString("id_modulos");

        }
         c++;
    }   
        rs3.close();
        clases.controles.DesconnectarBDsession();
    ob.put("selected",seleccionados ) ;

    out.print(ob);  
 
%>
    
     
