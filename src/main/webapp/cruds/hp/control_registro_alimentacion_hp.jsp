<%@page import="org.json.JSONObject"%>
<%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="hp.lotes_alimentacion_ptc"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%   
    String grilla         = request.getParameter("json_string");
    String usuario        = (String) sesionOk.getAttribute("nombre_usuario");
     String clasificadora  = (String) sesionOk.getAttribute("clasificadora");
 
    clases.controles.connectarBD();  
   
    int tipo_respuesta=0;
    String mensaje="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    
    ObjectMapper mapper = new ObjectMapper();
    lotes_alimentacion_ptc[] pp1 = mapper.readValue(grilla, lotes_alimentacion_ptc[].class);

    SQLServerDataTable sourceDataTable = new SQLServerDataTable();
    sourceDataTable.addColumnMetadata("cod_interno" ,   java.sql.Types.INTEGER);
    sourceDataTable.addColumnMetadata("cod_carrito" ,   java.sql.Types.VARCHAR);
    sourceDataTable.addColumnMetadata("cantidad" ,      java.sql.Types.INTEGER);    
    sourceDataTable.addColumnMetadata("fecha_puesta" ,  java.sql.Types.VARCHAR);
    sourceDataTable.addColumnMetadata("tipo_huevo" ,    java.sql.Types.VARCHAR);
 
    
    for (lotes_alimentacion_ptc lotes : pp1) 
    {
        sourceDataTable.addRow(lotes.cod_interno,lotes.cod_carrito, lotes.cantidad , lotes.fecha_puesta , lotes.tipo_huevo );
    }
    try 
    {
        clases.controles.connect.setAutoCommit(false);
        CallableStatement  callableStatement=null;   
        callableStatement = clases.controles.connect.prepareCall("{call mae_ptc_insert_alimentacion_hp(?,?,?,?,?)}");
        callableStatement .setObject(1,  sourceDataTable );
        callableStatement .setString(2,  usuario );
        callableStatement .setString(3,  clasificadora );

        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje= callableStatement.getString("mensaje");
         
        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        if (tipo_respuesta==0)
        {
            clases.controles.connect.rollback(); 
        }   
        else  
        {
            clases.controles.connect.commit();
        }
    } catch (Exception e) 
    {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        clases.controles.connect.rollback(); 
    }
    finally{
        
        clases.controles.DesconnectarBD();
        out.print(ob);
    }
 %>
 
 
 
 
 
  
 
 
 