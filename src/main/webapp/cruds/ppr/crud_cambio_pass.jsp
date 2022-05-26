<%-- 
    Document   : crud_cambio_pass
    Created on : 14-dic-2021, 12:04:34
    Author     : aespinola
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8" %>

<%    
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    
    JSONObject ob = new JSONObject();
    ob = new JSONObject();

    String id_usuario = (String) sesionOk.getAttribute("id_usuario");
    String pass = request.getParameter("pass");

    if (pass.equals("123")) {
        response.sendRedirect("../control/login_cambio_pass.jsp");
    } else {
        MessageDigest m = MessageDigest.getInstance("MD5");
        m.reset();
        m.update(pass.getBytes());
        byte[] digest = m.digest();
        BigInteger bigInt = new BigInteger(1, digest);
        String clavehASH = bigInt.toString(16);

        String mensaje = "";

        try {
            
            CallableStatement cstmt;
            cstmt = clases.controles.connectSesion.prepareCall("{call  [stp_mae_ppr_cambio_pass] (?,?,?)}");
            cstmt.setInt(1, Integer.parseInt(id_usuario));
            cstmt.setString(2, clavehASH);
            cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
            cstmt.execute();
            mensaje = cstmt.getString(3);
 
            response.sendRedirect("../index.jsp");
        } catch (Exception e) {
            ob.put("mensaje", mensaje);

        }
           
    }
 clases.controles.DesconnectarBDsession();%>
