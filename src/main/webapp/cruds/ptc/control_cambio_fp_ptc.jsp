 <%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>

<%          if (sesion == true) {

    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    clases.controles.VerificarConexion();
    Connection cn = clases.controles.connectSesion;
    fuente.setConexion(cn);   
    String id=request.getParameter("id");
    String fecha_puesta=request.getParameter("fecha_puesta");
    int tipo=0;
    String mensaje=null;
       try {
            CallableStatement  callableStatement=null;   
            callableStatement = cn.prepareCall("{call [mae_ptc_update_fechaPuesta]( ?, ?, ?,?)}");
            callableStatement .setInt(1,Integer.parseInt(id) );
            callableStatement .setString(2,  fecha_puesta );
            
            callableStatement.registerOutParameter("tipo_res", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
             callableStatement.execute();
                tipo = callableStatement.getInt("tipo_res");
                mensaje=callableStatement.getString("mensaje");
           } catch (Exception e) {
                  tipo=0;
                   mensaje=e.toString();
           }
                cn.close();
                         
                ob.put("tipo", tipo);
                ob.put("mensaje", mensaje); 
                out.print(ob);
}           
%> 