<%-- 
    Document   : consulta_max
    Created on : 26/01/2022, 16:40:32
    Author     : aespinola
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="clases.controles"%>
<%
    String lote    = request.getParameter("lote");
    String aviario = request.getParameter("aviario");
    String fecha   = request.getParameter("fecha");
    String saldo_inicial   = request.getParameter("saldo_inicial");
    String mensaje = "";
    String tipo_registro = "";
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    try {
            
     controles.connectarBD();
     clases.controles.connect.setAutoCommit(false);

     CallableStatement call = clases.controles.connect.prepareCall("{call [stp_mae_ppr_insert_activar_lote] (?,?,?,?,?,?)}");

        call.setString(1, fecha);
        call.setString(2, aviario);
        call.setString(3, lote);
        call.setString(4, saldo_inicial);
        call.registerOutParameter(5, java.sql.Types.VARCHAR);
        call.registerOutParameter(6, java.sql.Types.VARCHAR);
        call.execute();

        tipo_registro = call.getString(5);
        mensaje = call.getString(6);

        if (tipo_registro == "1") {
            clases.controles.connect.rollback();

        } else {
            //clases.controles.connectSesion.rollback(); 
            clases.controles.connect.commit();

        }
    } catch (Exception ex) {

    } finally {
        clases.controles.DesconnectarBD();
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        out.print(obje);
    }
%>
