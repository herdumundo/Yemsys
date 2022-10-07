<%-- 
    Document   : consulta_aviarios_hora
    Created on : 08/03/2021, 03:16:05 PM
    Author     : hvelazquez
--%>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    String fecha_inicio = request.getParameter("fecha_inicio");
    String fecha_final = request.getParameter("fecha_final");
  
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String contenedor=""; 
    try {
       Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery("exec grupomaehara.dbo.[mae_ptc_select_aviariosInvolucrados] @area='"+clasificadora+"',"
        + "@inicio='"+fecha_inicio+"',@final='"+fecha_final+"' ");
        while(rs.next())
        {
            contenedor=contenedor+"<OPTION  VALUE='"+ rs.getString("aviario")+"'>"+ rs.getString("aviario")+"</OPTION>";
        }
         ob.put("aviarios",contenedor);
        
        }
    catch (Exception e) {
       
        }
    finally{
        connection.close();
        out.print(ob);
     }
       %> 