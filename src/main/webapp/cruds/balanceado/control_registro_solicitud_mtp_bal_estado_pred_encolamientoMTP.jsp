<%-- 
    Document   : control_registro_solicitud_mtp_bal_estado_encolamientoMTP
    Created on : 06-may-2023, 17:57:33
    Author     : jalvarez
--%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.IOException"%>
<%@include file="../../chequearsesion.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
<%
 if (sesion == true) {
    
  String itemcode=              request.getParameter("itemcode");
  String cod_formula=           request.getParameter("cod_formula");
  
  int tipo_respuesta=0;
  String mensaje="";
  String estadoPredeterminado="";
  JSONObject ob= new JSONObject();
   ob= new JSONObject();
   
   try{
        connection.setAutoCommit(false);
        CallableStatement callableStatement=null;
        callableStatement =connection.prepareCall("{call mae_bal_encolamientoMTPREstPre(?,?,?,?,?) }");
    callableStatement.setString(1,itemcode);        
       
    callableStatement.setString(2,cod_formula);        
 
        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.registerOutParameter("estadopredeterminado", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");
        estadoPredeterminado = callableStatement.getString("estadopredeterminado");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
        ob.put("estadopredeterminado", estadoPredeterminado);
        if (tipo_respuesta == 0) 
        {
            connection.rollback();
        } 
        else 
        {
            connection.commit();
        }
    } catch (Exception e) 
    {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        
        connection.rollback();
    } finally {

        connection.close();
        out.print(ob);
        }
    }
%>
