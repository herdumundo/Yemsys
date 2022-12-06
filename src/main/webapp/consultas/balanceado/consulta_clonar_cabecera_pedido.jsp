<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%    JSONObject ob = new JSONObject();
     try {
        String id = request.getParameter("id");
        ResultSet rs_GM;
        Statement st = connection.createStatement();
        rs_GM = st.executeQuery( "select * from mae_bal_mtp_cab_solicitud where id="+id);

        while (rs_GM.next()) 
        {
            ob.put("indicadores",                                 rs_GM.getString("indicadores"));
            ob.put("motivo",                                      rs_GM.getString("motivo"));
            ob.put("plazo",                                       rs_GM.getString("plazo_evaluacion"));
            ob.put("recomendado",                                 rs_GM.getString("recomendado"));
            ob.put("resultado_esperado",                          rs_GM.getString("resultado_esperado"));
            ob.put("tonela",                                      rs_GM.getString("toneladas_proyectada"));
            
            ob.put("caracter",                                    rs_GM.getString("urgente"));
            ob.put("impacto",                                     rs_GM.getString("impacto_comercial"));
            ob.put("observacion",                                 rs_GM.getString("observacion"));
            ob.put("selected",                                    rs_GM.getString("aviarios_involucrados"));
     

                }
        
     

        rs_GM.close();
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
        out.print(ob);
    }
%> 

