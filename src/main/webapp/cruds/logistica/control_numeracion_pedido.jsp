<%-- 
    Document   : control_ot
    Created on : 07/04/2021, 08:53:01 AM
    Author     : hvelazquez
--%>
<%@page import="java.sql.CallableStatement"%>
<%@page session="true" %>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%   
    if (sesion == true) 
    {
        String numero = request.getParameter("numeracion");
        try 
        {
            CallableStatement callableStatement = null;
            callableStatement = connection.prepareCall("{call [mae_log_ptc_numeracion](?)}");
            callableStatement.setInt(1, Integer.parseInt(numero));
            callableStatement.execute();
        } 
        catch (Exception e) 
        {

        } 
        finally 
        {
            connection.close();
        }
    }
%>