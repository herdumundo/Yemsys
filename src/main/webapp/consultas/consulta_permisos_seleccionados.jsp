<%-- 
    Document   : vista_menu
    Created on : 15/12/2021, 08:40:00
    Author     : csanchez
--%>

<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../chequearsesion.jsp" %>
<%@include  file="../cruds/conexion.jsp" %> 

<%     
    Statement   st      = connection.createStatement();
    String id_rol= request.getParameter("id_rol") ;
    ResultSet rs3;
    JSONObject ob = new JSONObject();
    String seleccionados="";
    ob=new JSONObject();
   try {
           
    
    rs3 = st.executeQuery (" select * from mae_yemsys_permisos where id_rol="+id_rol+" and id_estado=1  ");
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

       } catch (Exception e) {
       }
   finally{
     ob.put("selected",seleccionados ) ;

    out.print(ob);    
   }
        
 
%>
    
     
