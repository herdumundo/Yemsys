<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@include  file="../../cruds/conexion.jsp" %>

<%
    String fecha = request.getParameter("fecha");
    String lote = request.getParameter("lote");
    String aviario = request.getParameter("aviario");
    String dl_edad = request.getParameter("dl_edad");
    String saldoant = request.getParameter("saldoant");
    String edad_dias = request.getParameter("edad_dias");
    int id_datos = 0;

    String mensaje = "";
    String tipo_registro = "";
    String saldo_anterior = "";
    
    try {
 
        CallableStatement call;

        call = connection.prepareCall("{call stp_mae_ppr_insert_datos_diarios (?,?,?,?,?,?,?,?,?,?)}");
        

        call.setString(1, fecha);
        call.setString(2, aviario);
        call.setString(3, lote);
        call.setString(4, "0");
        call.setString(5, "0");
        call.setString(6, saldoant);
        call.setString(7, "0");
        call.registerOutParameter(8, java.sql.Types.VARCHAR);
        call.registerOutParameter(9, java.sql.Types.VARCHAR);
        call.registerOutParameter(10, java.sql.Types.INTEGER);
      
        call.execute();

        id_datos = call.getInt(10);

        tipo_registro = call.getString(8);
        mensaje = call.getString(9);

         
        PreparedStatement pt3 = connection.prepareStatement("select dl_saldoaves from ppr_datolotes where dl_id='" + id_datos + "'");
        ResultSet rs3 = pt3.executeQuery();
        while (rs3.next()) {
        saldo_anterior = rs3.getString("dl_saldoaves");

             }
    } catch (Exception ex) {

    } finally {
        connection.close();
        JSONObject objet = new JSONObject();
        objet = new JSONObject();

        objet.put("mensaje", mensaje);
        objet.put("tipo_registro", tipo_registro);
        objet.put("saldo_anterior", saldo_anterior);
        objet.put("id_datos", id_datos);
        out.print(objet);

    }
%>
