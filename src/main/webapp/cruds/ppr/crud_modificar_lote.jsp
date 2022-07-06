<%-- 
    Document   : crud_modificar_rol
    Created on : 21-dic-2021, 13:52:16
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

   
    
    String idlote       = request.getParameter("idlote");
    String nombrelote   = request.getParameter("nombrelote");
    String lote_pedido  = request.getParameter("lote_pedido");
    String raza_lote    = request.getParameter("raza_lote");
    String fecha_pedido = request.getParameter("fecha_pedido");
    String fecha_naci   = request.getParameter("fecha_naci");

    String mensaje = "";
    String tipo_respuesta = "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    try {
     controles.connectarBD();
     clases.controles.connect.setAutoCommit(false);

        CallableStatement call;
        call = clases.controles.connect.prepareCall("{call [stp_mae_ppr_update_lotes] (?,?,?,?,?,?,?,?)}");
        call.setString(1, idlote);
        call.setString(2, nombrelote);
        call.setString(3, lote_pedido);
        call.setString(4, raza_lote);
        call.setString(5, fecha_pedido);
        call.setString(6, fecha_naci);
        call.registerOutParameter(7, java.sql.Types.VARCHAR);
        call.registerOutParameter(8, java.sql.Types.VARCHAR);
        call.execute();
        tipo_respuesta = call.getString(7);
        mensaje = call.getString(8);

        if (tipo_respuesta == "1") {
            clases.controles.connect.rollback();

        } else {
            //clases.controles.connectSesion.rollback(); 
            clases.controles.connect.commit();

        }

    } catch (Exception e) {

    } finally {
clases.controles.DesconnectarBD();
 ob.put("mensaje", mensaje);
 ob.put("tipo_respuesta", tipo_respuesta);
 out.print(ob);
    }
%>