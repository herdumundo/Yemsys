<%-- 
    Document   : crud_modificar_rol
    Created on : 21-dic-2021, 13:52:16
    Author     : aespinola
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>


<%    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

    JSONObject ob = new JSONObject();
    ob = new JSONObject();

    String idscore = request.getParameter("idscore");
    String score       = request.getParameter("score");


    String mensaje = "";
    String tipo_respuesta = "";
    try {
        clases.controles.connectSesion.setAutoCommit(false);

        CallableStatement call;
        call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_update_necropsias_score_detalle](?,?,?,?)}");
        call.setString(1, idscore);
        call.setString(2, score);

        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.execute();
        tipo_respuesta = call.getString(3);
        mensaje = call.getString(4);

        if (tipo_respuesta == "1") {
            clases.controles.connectSesion.rollback();

        } else {
            //clases.controles.connectSesion.rollback(); 
            clases.controles.connectSesion.commit();

        }

    } catch (Exception e) {

    } finally {
        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        out.print(ob);
    }
%>