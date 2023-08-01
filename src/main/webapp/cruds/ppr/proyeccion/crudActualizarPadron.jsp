<%-- 
    Document   : consulta_max
    Created on : 26/01/2022, 16:40:32
    Author     : aespinola
--%>
<%@page import="bal.solicitud_mtp1"%>
<%@page import="org.json.JSONObject"%>
<%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="bal.solicitud_mtp"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    JSONObject ob = new JSONObject();

    try {
        ob = new JSONObject();

        String id = request.getParameter("id");
        String json = request.getParameter("json_string");

        int tipo_respuesta = 0;
      /*    String mensaje = "";


        ObjectMapper mapper = new ObjectMapper();
        grillaPadron[] pp1 = mapper.readValue(json, grillaPadron[].class);
        SQLServerDataTable sourceDataTable = new SQLServerDataTable();

        sourceDataTable.addColumnMetadata("padron_id", java.sql.Types.INTEGER);
        sourceDataTable.addColumnMetadata("edad", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("viabilidad", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("mortandad_diaria", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("productividad", java.sql.Types.VARCHAR);

        for (grillaPadron mtp : pp1) {
            sourceDataTable.addRow(
                    mtp.padron_id,
                    mtp.edad,
                    mtp.viabilidad,
                    mtp.mortandad_diaria,
                    mtp.productividad.trim()
            );
        }
      connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call ppr_pry_update_padron(?,?,?,?)}");
        callableStatement.setInt(1, Integer.parseInt(id));
        callableStatement.setObject(2, sourceDataTable);
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        if (tipo_respuesta == 0) {
            connection.rollback();
        } else {
            connection.commit();
            //  connection.rollback();
        }*/
          ob.put("mensaje", json);
        ob.put("tipo_respuesta", 0);
    } catch (Exception e) {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        connection.rollback();
    } finally {
        connection.close();
        out.print(ob);
    }
%>
