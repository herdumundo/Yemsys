<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>
  
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<%@include  file="../cruds/conexion.jsp" %> 


 <%     
    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
     
    Statement st2 = connection.createStatement();
    Statement st3 = connection.createStatement();
    JSONObject ob = new JSONObject();
    
    ResultSet rs2,rs3;
    rs2 = st2.executeQuery("  select id,html from  mae_yemsys_modulos where id in (   select id_modulos         "
            + "  from vis_mae_yemsys_permisos_login where nivel=2 and id_estado=1 and id_usuario="+id_usuario+" group by id_modulos) and id_estado=1 ");// 1 ES IGUAL A ACTIVO.
    
    try {
            
    String li="";
    String subMenu="";
    String menu="";
    ob=new JSONObject();
    while(rs2.next())
    {
        li="";
        subMenu="";
        li=li+"<li class='nav-item'>"+rs2.getString("html")+"<ul class='nav nav-treeview'  >";// EL FINAL DEL UL Y EL LI VAN ABAJO, LUEGO DE CARGAR EL SUBMENU
       
        rs3 = st3.executeQuery("  select ID_MODULOS,html  from vis_mae_yemsys_permisos_login where nivel=2 and id_usuario="+id_usuario+"  and id_modulos="+rs2.getString("id")+" and id_estado=1 ");
   
        while(rs3.next())
    {
        subMenu=subMenu+  rs3.getString("html");
    }   
        rs3.close();
        menu=menu+li+subMenu+" </ul></li>";
    }
    rs2.close();

    ob.put("menu",menu ) ;

        } catch (Exception e) 
        {
        }
    
    finally
    {
        connection.close();
        out.print(ob);  
    }
%>
    
     
