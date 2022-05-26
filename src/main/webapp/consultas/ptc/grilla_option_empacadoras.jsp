
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
        String area = (String) sesionOk.getAttribute("clasificadora");
        String tipo_huevo = request.getParameter("tipo_huevo");
        String contenedor="";
       if(tipo_huevo.equals("4TA")){
           tipo_huevo="D";
       }
        ResultSet rs = fuente.obtenerDato(" exec [mae_ptc_select_option_empacadoras] @tipo_huevo='"+tipo_huevo+"', @area='"+area+"'");
            while(rs.next()){
            contenedor=contenedor+ "<option value='"+rs.getString("empacadora")+"'>"+rs.getString("empacadora")+"</option>";
            }
            cn.close();
            clases.controles.DesconnectarBD();
            ob.put("mensaje",contenedor);
            out.print(ob);
       %>