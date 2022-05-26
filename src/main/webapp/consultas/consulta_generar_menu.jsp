<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>

<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%     
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    String html="";
    ResultSet rs2,rs3;
    rs2 = fuente.obtenerDato("  select id,html from  mae_yemsys_modulos where id in (   select id_modulos         "
            + "  from vis_mae_yemsys_permisos_login where nivel=2 and id_estado=1 and id_usuario="+id_usuario+" group by id_modulos) and id_estado=1 ");// 1 ES IGUAL A ACTIVO.
    
    String li="";
    String subMenu="";
    String menu="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    while(rs2.next())
    {
        li="";
        subMenu="";
        li=li+"<li class='nav-item'>"+rs2.getString("html")+"<ul class='nav nav-treeview'  >";// EL FINAL DEL UL Y EL LI VAN ABAJO, LUEGO DE CARGAR EL SUBMENU
       
        rs3 = fuente.obtenerDato("  select ID_MODULOS,html  from vis_mae_yemsys_permisos_login where nivel=2 and id_usuario="+id_usuario+"  and id_modulos="+rs2.getString("id")+" and id_estado=1 ");
   
        while(rs3.next())
    {
        subMenu=subMenu+  rs3.getString("html");
    }   
        rs3.close();
        menu=menu+li+subMenu+" </ul></li>";
    }
    rs2.close();
        clases.controles.DesconnectarBDsession();
    ob.put("menu",menu ) ;

    out.print(ob);  
%>
    
     
