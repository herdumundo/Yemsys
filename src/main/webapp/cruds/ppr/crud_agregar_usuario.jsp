 <%@page import="java.math.BigInteger"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="org.json.JSONObject"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %> 
<%@page contentType="application/json; charset=utf-8"%> 

<%
    JSONObject obje = new JSONObject();
    obje = new JSONObject();

    String nombre           = request.getParameter("nombre");
    String pass             = request.getParameter("pass");
    String usuario          = request.getParameter("usuario");
    String clasificadora    = request.getParameter("clasificadora");
    String rol              = request.getParameter("select_rol");

    String mensaje = "";
    String tipo_registro = "";
    MessageDigest m = MessageDigest.getInstance("MD5");
    m.reset();
    m.update(pass.getBytes());
    byte[] digest = m.digest();
    BigInteger bigInt = new BigInteger(1, digest);
    String clavehASH = bigInt.toString(16);
    
    try 
    {
        CallableStatement call = connection.prepareCall("{call stp_mae_ppr_insert_usuarios(?,?,?,?,?,?,?)}");
        call.setString(1, usuario);
        call.setString(2, clavehASH);
        call.setString(3, clasificadora);
        call.setString(4, nombre);
        call.setInt(5, Integer.parseInt(rol));
        call.registerOutParameter(6, java.sql.Types.VARCHAR);
        call.registerOutParameter(7, java.sql.Types.VARCHAR);
        call.execute();

        mensaje = call.getString(7);
        tipo_registro = call.getString(6);
        if (tipo_registro == "1") 
        {
            connection.rollback();
        } 
        else 
        {
            connection.commit();
        }
    } catch (Exception ex) 
    {
        String mens = ex.getMessage();
    } 
    finally 
    {
        connection.close();
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        out.print(obje);
    }
%>
