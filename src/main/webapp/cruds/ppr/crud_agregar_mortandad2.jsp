
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.Statement"%>
<%@page import ="java.sql.SQLException"%>
<%@page import="clases.controles"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />

<%
  

    String fecha = request.getParameter("fecha");
    String lote = request.getParameter("lote");
    String fila = request.getParameter("fila");
    String cantidad = request.getParameter("cantidad");
    String aviario = request.getParameter("aviario");
    String suma_mort = request.getParameter("sum");

    String mensaje = "";
    String tipo_registro = "";

   JSONObject obje = new JSONObject();
    obje = new JSONObject();
      controles.VerificarConexion();
        
      fuente.setConexion(clases.controles.connectSesion);

    try {
        clases.controles.connectSesion.setAutoCommit(false);
        CallableStatement call;
        call = clases.controles.connectSesion.prepareCall("{exec stp_mae_ppr_insert_mortandad  (?,?,?,?,?,?,?)}");
        call.setString(1, fecha);
        call.setString(2, lote);
        call.setString(3, fila);
        call.setString(4, cantidad);
        call.setString(5, aviario);
        call.registerOutParameter(6, java.sql.Types.VARCHAR);
        call.registerOutParameter(7, java.sql.Types.VARCHAR);
        call.execute();
        tipo_registro = call.getString(6);
        mensaje = call.getString(7);
    } catch (Exception ex) {

    } finally {
         clases.controles.connectSesion.close();
        clases.controles.DesconnectarBD();
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
       
        out.print(obje);
    }
%>
