<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    JSONObject obje = new JSONObject();
    obje = new JSONObject();

   

   String id_datos = request.getParameter("id_datos");
   String campo = request.getParameter("campo");
   String valor = request.getParameter("valor");

    String mensaje = "";
    String tipo_registro = "";

    try {
        controles.connectarBD();
        clases.controles.connect.setAutoCommit(false);

        CallableStatement call;

        call = clases.controles.connect.prepareCall("{call [stp_mae_ppr_update_datos_diarios] (?,?,?,?,?)}");

        call.setString(1, campo);
        call.setString(2, valor);
        call.setString(3, id_datos);
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.registerOutParameter(5, java.sql.Types.VARCHAR);
        call.execute();

        tipo_registro = call.getString(4);
        mensaje = call.getString(5);

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
