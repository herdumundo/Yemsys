<%-- 
    Document   : crud_agregar_rol
    Created on : 14/12/2021, 07:17:45
    Author     : csanchez
--%>

<%@page contentType="application/json; charset=utf-8"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
   
<%
    JSONObject obje = new JSONObject();
    obje = new JSONObject();

    String mensaje = "";
    String tipo_registro = "";
    String fecha = "";
    String id = request.getParameter("id");
    String id_cab = request.getParameter("id_cab");
    try {
        connection.setAutoCommit(false);

        CallableStatement call;

        call = connection.prepareCall("{call stp_mae_ppr_reset_barra_pry_lote(?,?,?,?,?)}");

        call.setString(1, id);
        call.setString(2, id_cab);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.registerOutParameter(5, java.sql.Types.VARCHAR);
        call.execute();
        mensaje         = call.getString(4);
        fecha           = call.getString(5);
        tipo_registro   = call.getString(3);

        if (tipo_registro == "1") 
        {
            connection.rollback();
        } 
        else 
        {
            //clases.controles.connectSesion.rollback(); 
           //   connection.rollback();
          connection.commit();
        }
    } catch (Exception ex) 
    {
        mensaje=ex.getMessage();
    } finally 
    {
          connection.close(); 
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        obje.put("fecha", fecha );
        
        out.print(obje);
    }
%>

