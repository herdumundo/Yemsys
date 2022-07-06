<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    JSONObject obje = new JSONObject();
    obje = new JSONObject();

   

   String conta_id= request.getParameter("conta_id");
   String fecha   = request.getParameter("fecha");
   String valor   = request.getParameter("valor");
   String fila    = request.getParameter("fila");
   String lote    = request.getParameter("lote");
   String aviario = request.getParameter("aviario");
   int id_contador = 0;
    String mensaje = "";
    String tipo_registro = "";

    try {
        controles.connectarBD();
        clases.controles.connect.setAutoCommit(false);

        CallableStatement call;

        call = clases.controles.connect.prepareCall("{call [stp_mae_ppr_update_contador_huevo] (?,?,?,?,?,?,?,?,?)}");

        call.setString(1, conta_id);
        call.setString(2, valor);
        call.setString(3, fecha);
        call.setString(4, aviario);
        call.setString(5, fila);
        call.setString(6, lote);
        call.registerOutParameter(7, java.sql.Types.VARCHAR);
        call.registerOutParameter(8, java.sql.Types.VARCHAR);
        call.registerOutParameter(9, java.sql.Types.INTEGER);
        call.execute();
        id_contador = call.getInt(9);
        tipo_registro = call.getString(8);
        mensaje = call.getString(8);

        if (tipo_registro == "0") {
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
        obje.put("id_contador",   id_contador);
        out.print(obje);
    }
%>
