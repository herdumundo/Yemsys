<%@include  file="../../../versiones.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 
<%@ page contentType="application/json; charset=utf-8" %>
<%
        String linea = (String) sesionOk.getAttribute("clasificadora");
       // String linea = "LINEA04";
        
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contenedor=""; 
            ResultSet rs_nro;
            Statement st = connection.createStatement();
            rs_nro = st.executeQuery("select * from parada_produccion with(nolock) where linea='"+linea+"' and estado='a' "
            + "and (convert(varchar,fecha,103)=convert(varchar,getdate(),103) or convert(varchar, fecha, 103) ="
            + " convert(varchar, DATEADD(d, -1, getdate()), 103))");
            if (rs_nro.next()){
         
           contenedor="PRODUCCION ACTIVA NRO."+rs_nro.getString("nro_produccion")+ ", CODIGO BARRA:"+ rs_nro.getString("paquete");  
            }
            else {
             contenedor="NO CUENTA CON PRODUCCION ACTIVA";
            }
        ob.put("contenido","<strong><center>"+contenedor+"</center></strong> ");
        out.print(ob);
       %>