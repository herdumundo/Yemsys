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
    String nombrelote   = request.getParameter("nombrelote");
    String lote_pedido  = request.getParameter("lote_pedido");
    String raza_lote    = request.getParameter("raza_lote");
    String fecha_pedido = request.getParameter("fecha");
    String fecha_naci   = request.getParameter("fecha_naci");
    String mensaje = "";
    String tipo_registro = "";
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    try {
            
     controles.connectarBD();
     clases.controles.connect.setAutoCommit(false);

     CallableStatement call = clases.controles.connect.prepareCall("{call [stp_mae_ppr_insert_lote] (?,?,?,?,?,?,?)}");

        call.setString(1, nombrelote);
        call.setString(2, lote_pedido);
        call.setString(3, raza_lote);
        call.setString(4, fecha_pedido);
        call.setString(5, fecha_naci);
        call.registerOutParameter(6, java.sql.Types.VARCHAR);
        call.registerOutParameter(7, java.sql.Types.VARCHAR);
        call.execute();

        tipo_registro = call.getString(6);
        mensaje = call.getString(7);

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
