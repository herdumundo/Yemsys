
<%@page import="org.json.JSONObject"%>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>
    <%
        clases.controles.connectarBD();
        Connection cn = clases.controles.connect;
	fuente.setConexion(cn);
        JSONObject ob = new JSONObject();
        ob=new JSONObject();
        String contenedor="";
  
        ResultSet rs = fuente.obtenerDato(" select NumAtCard  "
                + "from maehara.dbo.oinv where DocStatus='O' AND CANCELED='N'-- AND isIns='Y' "
                + "and  InvntSttus='o'  AND CardName='VIMAR Y COMPAÑIA S.A.'  "
                + "AND NumAtCard COLLATE DAtabase_default NOT IN ( "
                + "SELECT NRO_FACTURA  FROM embarque_cab WHERE    estado_sincro NOT IN ('C') " //CONSULTA PARA QUE DE SAP NO TRAIGA LAS FACTURAS QUE YA ESTAN EMBARCADAS.
                + " union all"
                + " select nro_factura from mae_log_pct_cab_pedidos where estado in (2) )");// CONSULTA DEL PEDIDO PARA QUE DE SAP NO TRAIGA LAS FACTURAS QUE YA SE INGRESARON EN EL PEDIDO
        
        while(rs.next())
        {
            contenedor=contenedor+ "<option value='"+rs.getString("NumAtCard")+"'>"+rs.getString("NumAtCard")+"</option>";
        }
        cn.close();
        clases.controles.DesconnectarBD();
        ob.put("mensaje",contenedor);
        out.print(ob);
    %>