
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
    <%
        String capacidad            = request.getParameter("capacidad");
        clases.controles.connectarBD();
        Connection cn = clases.controles.connect;
	fuente.setConexion(cn);
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contenedor="";
  
        ResultSet rs = fuente.obtenerDato("  select * from  maehara.dbo.[@CAMIONES] where u_estado='Activo' and   u_desc<>''  and U_capacidad="+capacidad+" ");  
        
        while(rs.next())
        {
            contenedor=contenedor+ "<option value='"+rs.getString("code")+"'>"+rs.getString("code")+"- "+rs.getString("name")+"</option>";
        }
        cn.close();
        clases.controles.DesconnectarBD();
        ob.put("select",contenedor);
        out.print(ob);
    %>