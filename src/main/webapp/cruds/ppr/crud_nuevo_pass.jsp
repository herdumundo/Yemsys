<%-- 
    Document   : crud_restablecer_pass
    Created on : 20-dic-2021, 9:39:38
    Author     : aespinola
--%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="org.json.JSONObject"%>

<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>

<%@page contentType="application/json; charset=utf-8" %>

<%    JSONObject ob = new JSONObject();
    ob = new JSONObject();

    String id_usuario = request.getParameter("txt_id_cambiopas");
    String passnueva = request.getParameter("passnueva");
    String tipo_registro = "";
    String mensaje = "";
    String passactual = request.getParameter("passactual");

    MessageDigest m = MessageDigest.getInstance("MD5");
    m.reset();
    m.update(passnueva.getBytes());
    byte[] digest = m.digest();
    BigInteger bigInt = new BigInteger(1, digest);
    String clavenuevo = bigInt.toString(16);

    MessageDigest mpassactual = MessageDigest.getInstance("MD5");
    mpassactual.reset();
    mpassactual.update(passactual.getBytes());
    byte[] digest2 = mpassactual.digest();
    BigInteger bigInt2 = new BigInteger(1, digest2);
    String claveactual = bigInt2.toString(16);
    try {
        CallableStatement call;
        call = connection.prepareCall("{call  [stp_mae_yemsys_nuevo_pass] (?,?,?,?,?)}");
        call.setInt(1, Integer.parseInt(id_usuario));
        call.setString(2, claveactual);
        call.setString(3, clavenuevo);
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.registerOutParameter(5, java.sql.Types.VARCHAR);
        call.execute();

        tipo_registro = call.getString(4);
        mensaje = call.getString(5);

    } catch (Exception ex) {

    } finally {
        clases.controles.DesconnectarBDsession();
        ob.put("mensaje", mensaje);
        ob.put("tipo_registro", tipo_registro);
        out.print(ob);

    }
%>
