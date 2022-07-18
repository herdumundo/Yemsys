<%-- 
    Document   : crud_modificar_rol
    Created on : 21-dic-2021, 13:52:16
    Author     : aespinola
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="clases.controles"%>


<%   

   
    
    String idlote       = request.getParameter("idlote");
 

    String mensaje = "";
    String tipo_respuesta = "";
    JSONObject ob = new JSONObject();
    ob = new JSONObject();
    try {
     controles.connectarBD();
     clases.controles.connect.setAutoCommit(false);

        CallableStatement call;
        call = clases.controles.connect.prepareCall("{call [stp_mae_ppr_update_estado_lotes] (?,?,?)}");
        call.setString(1, idlote);
        call.registerOutParameter(2, java.sql.Types.VARCHAR);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.execute();
        tipo_respuesta = call.getString(2);
        mensaje = call.getString(3);

        if (tipo_respuesta == "1") {
            clases.controles.connect.rollback();

        } else {
           
            clases.controles.connect.commit();

        }

    } catch (Exception e) {

    } finally {
clases.controles.DesconnectarBD();
 ob.put("mensaje", mensaje);
 ob.put("tipo_respuesta", tipo_respuesta);
 out.print(ob);
    }
%>