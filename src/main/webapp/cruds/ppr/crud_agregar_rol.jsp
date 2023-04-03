<%-- 
    Document   : crud_agregar_rol
    Created on : 14/12/2021, 07:17:45
    Author     : csanchez
--%>

<%@page contentType="application/json; charset=utf-8"%>

<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>

<%    JSONObject obje = new JSONObject();
    obje = new JSONObject();

    String mensaje = "";
    String tipo_registro = "";
    String descripcion = request.getParameter("descripcion");
    String sector = request.getParameter("sector");

    try {
        connection.setAutoCommit(false);

        CallableStatement call;

        call = connection.prepareCall("{call stp_mae_ppr_insert_roles(?,?,?,?)}");

        call.setString(1, descripcion);
        call.setString(2, sector);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.execute();
        mensaje = call.getString(4);
        tipo_registro = call.getString(3);

        if (tipo_registro == "1") {
            connection.rollback();

        } else {
            //clases.controles.connectSesion.rollback(); 
            connection.commit();

        }
    } catch (Exception ex) {

    } finally {
        connection.close();
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        out.print(obje);
    }
%>

