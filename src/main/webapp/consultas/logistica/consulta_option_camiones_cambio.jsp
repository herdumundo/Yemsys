
<%@page import="org.json.JSONObject"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
 <%@ page contentType="application/json; charset=utf-8" %>
    <%
        ResultSet rs,rs2,rs3;
        PreparedStatement  pst,pst2,pst3;
        String capacidad    = request.getParameter("capacidad");
        
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contenedor="";
        
        pst = connection.prepareStatement("select * from  maehara.dbo.[@CAMIONES] where u_estado='Activo' and   u_desc<>''  and U_capacidad="+capacidad+" ");
        rs = pst.executeQuery();
        while(rs.next())
        {
            contenedor=contenedor+ "<option value='"+rs.getString("code")+"'>"+rs.getString("code")+"- "+rs.getString("name")+"</option>";
        }

        connection.close();
        ob.put("select",contenedor);
        out.print(ob);
    %>