<%-- 
    Document   : crud_restablecer_pass
    Created on : 8-ene-2022, 9:39:38
    Author     : aespinola
--%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="org.json.JSONObject"%>
<%@ page session="true" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String id_usuario       = request.getParameter("txt_id_reset");
    String mensaje="";
       MessageDigest m = MessageDigest.getInstance("MD5");
    m.reset();
    m.update( "123".getBytes());
    byte[] digest = m.digest();
    BigInteger bigInt = new BigInteger(1, digest);
    String clavenuevo = bigInt.toString(16);

    
    try 
    {
        CallableStatement  call;   
        call = connection.prepareCall("{call  stp_mae_ppr_restablecer_pass (?,?,? )}");
        call .setInt(1,  Integer.parseInt(id_usuario) );
        call.setString(2,clavenuevo);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.execute(); 
        mensaje= call.getString(3);
    } 
    catch (Exception ex) 
    {
    
    }
    finally 
    {  
        connection.close(); 
        ob.put("mensaje", mensaje);
        out.print(ob);
    }
            %>