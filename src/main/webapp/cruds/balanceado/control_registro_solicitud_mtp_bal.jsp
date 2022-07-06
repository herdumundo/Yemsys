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
    String fecha_solicitud = request.getParameter("fecha_solicitud");
    String recomendado = request.getParameter("recomendado");
    String motivo = request.getParameter("motivo");
    String desc_formula = request.getParameter("desc_formula");
    String toneladas = request.getParameter("toneladas");
    String resultado_esperado = request.getParameter("resultado_esperado");
    String impacto = request.getParameter("impacto");
    String cod_formula = request.getParameter("cod_formula");
    String plazo_evaluacion = request.getParameter("plazo_evaluacion");
    String indicadores = request.getParameter("indicadores");
    String urgente = request.getParameter("urgente");
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
        callableStatement = connection.prepareCall("{call mae_bal_crear_solicitud_mtp(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        callableStatement.setObject(1,  sourceDataTable);
        callableStatement.setString(2,  fecha_solicitud);
        callableStatement.setString(3,  recomendado);
        callableStatement.setString(4,  motivo);
        callableStatement.setString(5,  usuario);
        callableStatement.setString(6,  desc_formula);
        callableStatement.setString(7,  toneladas );
        callableStatement.setString(8,  cod_formula ); 
        callableStatement.setString(9,  resultado_esperado ); 
        callableStatement.setString(10, impacto); 
        callableStatement.setString(11, plazo_evaluacion); 
        callableStatement.setString(12, indicadores); 
        callableStatement.setString(13, urgente); 

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








