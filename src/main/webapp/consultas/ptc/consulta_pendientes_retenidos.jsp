<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<% 
        String clasificadora = (String) sesionOk.getAttribute("clasificadora");
        Statement st = connection.createStatement();
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contador="";
        String fecha_vieja_retenido="";
        String fecha_vieja="";
        ResultSet rs = st.executeQuery(" exec mae_ptc_select_fpVieja2022 @clasificadora='"+clasificadora+"'");
        while(rs.next())
        {
            contador= rs.getString(1);
            fecha_vieja_retenido = rs.getString(2);
            fecha_vieja  = rs.getString(3);
        }
        ob.put("cantidad","<b>"+contador+"</b>");
        ob.put("fecha_vieja_retenido",fecha_vieja_retenido);
        ob.put("fecha_vieja",fecha_vieja);
        connection.close();
        out.print(ob); 
       %>