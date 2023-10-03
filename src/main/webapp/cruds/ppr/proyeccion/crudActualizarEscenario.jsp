<%-- 
    Document   : consulta_max
    Created on : 26/01/2022, 16:40:32
    Author     : aespinola
--%>
<%@page import="ppr.grillaPadron"%>
<%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
 <%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@include file="../../../cruds/conexion.jsp" %>
<%    JSONObject ob = new JSONObject();

    try {
        ob = new JSONObject();

        String idEscenario                  = request.getParameter("idEscenario");
        String calculoMortandad             = request.getParameter("calculoMortandad");
        String padronMortandad              = request.getParameter("padronMortandad");
        String mortandadParametroGeneral    = request.getParameter("mortandadParametroGeneral");
        String mortandadRecria              = request.getParameter("mortandadRecria");
        String mortandadPPR                 = request.getParameter("mortandadPPR");
        String mortandadPRED                = request.getParameter("mortandadPRED");
        String calculoProduccion            = request.getParameter("calculoProduccion");
        String padronProduccion             = request.getParameter("padronProduccion");
        String parametroGeneralProduccion   = request.getParameter("parametroGeneralProduccion");
        String produccionRecria             = request.getParameter("produccionRecria");
        String ProduccionPPR                = request.getParameter("ProduccionPPR");
        String ProduccionPred               = request.getParameter("ProduccionPred");
                    
                    
        int tipo_respuesta = 0;
        String mensaje = "";

         
     connection.setAutoCommit(false);
        CallableStatement callableStatement = null;
        callableStatement = connection.prepareCall("{call ppr_pry_update_escenario(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
        callableStatement.setString(1,idEscenario );
        callableStatement.setString(2, calculoMortandad          );
        callableStatement.setString(3, padronMortandad           );
        callableStatement.setString(4, mortandadParametroGeneral );
        callableStatement.setString(5, mortandadRecria           );
        callableStatement.setString(6, mortandadPPR              );
        callableStatement.setString(7, mortandadPRED             );
        callableStatement.setString(8, calculoProduccion         );
        callableStatement.setString(9, padronProduccion          );
        callableStatement.setString(10,parametroGeneralProduccion);
        callableStatement.setString(11,produccionRecria          );
        callableStatement.setString(12,ProduccionPPR             );
        callableStatement.setString(13,ProduccionPred            );
        
        
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
        } 
       ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
    } catch (Exception e) {
        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", 0);
        connection.rollback();
    } finally {
        connection.close();
        out.print(ob);
    }
%>
