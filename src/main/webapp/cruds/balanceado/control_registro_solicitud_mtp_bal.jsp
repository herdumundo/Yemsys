<%@page import="bal.nutrientes_mtp_bal"%>
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
        if (sesion == true) {
    
    String grilla               = request.getParameter("json_string");
    String grillaNutriente       = request.getParameter("json_Nutriente");
    String fecha_solicitud      = request.getParameter("fecha_solicitud");
    String recomendado          = request.getParameter("recomendado");
    String motivo               = request.getParameter("motivo");
    String desc_formula         = request.getParameter("desc_formula");
    String toneladas            = request.getParameter("toneladas");
    String resultado_esperado   = request.getParameter("resultado_esperado");
    String impacto              = request.getParameter("impacto");
    String cod_formula          = request.getParameter("cod_formula");
    String plazo_evaluacion     = request.getParameter("plazo_evaluacion");
    String indicadores          = request.getParameter("indicadores");
    String urgente              = request.getParameter("urgente");
    String usuario              = (String) sesionOk.getAttribute("nombre_usuario");
    String area                 = (String) sesionOk.getAttribute("area_gm");
    String id_usuario           = (String) sesionOk.getAttribute("id_usuario");
    String observacion          = request.getParameter("observacion");
    String aviario              = request.getParameter("aviario");
   
    int tipo_respuesta = 0;
    String mensaje = "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    
        ObjectMapper mapper = new ObjectMapper();
        solicitud_mtp[] pp1 = mapper.readValue(grilla, solicitud_mtp[].class);

        SQLServerDataTable sourceDataTable = new SQLServerDataTable();

        sourceDataTable.addColumnMetadata("accion",             java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("codigo_formula",     java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("codigo_mtp",         java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("descripcion",        java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("cantidad_nueva",     java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("cantidad_actual",    java.sql.Types.FLOAT);
        sourceDataTable.addColumnMetadata("costo",              java.sql.Types.VARCHAR);
        sourceDataTable.addColumnMetadata("grupo",              java.sql.Types.VARCHAR);

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
        
        ObjectMapper mapperNutriente = new ObjectMapper();
        nutrientes_mtp_bal[] nutriente = mapperNutriente.readValue(grillaNutriente, nutrientes_mtp_bal[].class);

        SQLServerDataTable sourceDataTableNutriente = new SQLServerDataTable();

        sourceDataTableNutriente.addColumnMetadata("id",             java.sql.Types.VARCHAR);
        sourceDataTableNutriente.addColumnMetadata("descripcion",     java.sql.Types.VARCHAR);
        sourceDataTableNutriente.addColumnMetadata("actual",         java.sql.Types.VARCHAR);
        sourceDataTableNutriente.addColumnMetadata("nuevo",        java.sql.Types.VARCHAR);
        

        for (nutrientes_mtp_bal nutri : nutriente) {
            sourceDataTableNutriente.addRow(
                    nutri.id.trim() ,
                    nutri.descripcion,
                    nutri.actual.trim() ,
                    nutri.nuevo.trim() 
                    
            );
        }
        
        
        
        

        connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call mae_bal_crear_solicitud_mtp_nuevo05042023(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        callableStatement.setObject(1,  sourceDataTable);
        
        callableStatement.setObject(2, sourceDataTableNutriente);
        
        callableStatement.setString(3,  fecha_solicitud);
        callableStatement.setString(4,  recomendado);
        callableStatement.setString(5,  motivo);
         callableStatement.setString(6,  usuario ); 
        callableStatement.setString(7, desc_formula );
         callableStatement.setString(8, toneladas );
        callableStatement.setString(9,   cod_formula );
        callableStatement.setString(10, resultado_esperado); 
        callableStatement.setString(11,impacto);
        callableStatement.setString(12, plazo_evaluacion);
        callableStatement.setString(13,  indicadores ); 
        callableStatement.setString(14, urgente); 
        callableStatement.setString(15, area); 
        callableStatement.setInt   (16, Integer.parseInt(id_usuario)); 
        callableStatement.setString(17,  observacion);
        callableStatement.setString(18,  aviario);
        
         
         
       
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta",tipo_respuesta);
        if (tipo_respuesta == 0) 
        {
            connection.rollback();
        } 
        else
        {
            connection.commit();
        }
    } 
    catch (Exception e) 
    {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        connection.rollback();
    } 
    finally 
    {
        connection.close();
        out.print(ob);
    }}
%> 