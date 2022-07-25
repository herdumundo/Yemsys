<%@page import="org.json.JSONObject"%>
<%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="bal.solicitud_mtp"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%    
    String grilla = request.getParameter("json_string");
    String id = request.getParameter("id");
    String estado = request.getParameter("estado");
    String fecha_modificacion = request.getParameter("fecha_modificacion");
    String usuario = (String) sesionOk.getAttribute("nombre_usuario");
     
    
    int tipo_respuesta = 0;
    String mensaje = "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
   
        ObjectMapper mapper = new ObjectMapper();
        solicitud_mtp[] pp1 = mapper.readValue(grilla, solicitud_mtp[].class);

        SQLServerDataTable sourceDataTable = new SQLServerDataTable();

        sourceDataTable.addColumnMetadata("accion", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("codigo_formula", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("codigo_mtp", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("descripcion", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("cantidad_nueva", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("cantidad_actual", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("costo", java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("grupo", java.sql.Types.VARCHAR);

        for (solicitud_mtp mtp : pp1) {
            sourceDataTable.addRow(
                    mtp.accion,
                    mtp.codigo_formula,
                    mtp.codigo_mtp,
                    mtp.descripcion,
                    mtp.cantidad_nueva.trim() ,
                    mtp.cantidad_actual.trim(),
                    mtp.costo.trim() ,
                    mtp.grupo
            );
        }
 try {
        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call mae_bal_editar_solicitud_mtp(?,?,?,?,?,?,?)}");
        callableStatement.setObject(1,  sourceDataTable);
        callableStatement.setInt(2,  Integer.parseInt(id));
        callableStatement.setString(3,  usuario);
        callableStatement.setString(4,  "1");
        callableStatement.setString(5,  fecha_modificacion);

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
        }
    } catch (Exception e) {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        connection.rollback();
    } finally {

        connection.close();
        out.print(ob);
    }
%>








