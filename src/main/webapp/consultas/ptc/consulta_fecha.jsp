<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    String contenedor = "";
    Statement st = connection.createStatement();
    ResultSet rs = st.executeQuery("SELECT convert(varchar,getdate(),103) as fecha ");
    while (rs.next()) 
    {
       contenedor = rs.getString("fecha");
    }
    connection.close();
    ob.put("fecha", contenedor);
    out.print(ob);
%>