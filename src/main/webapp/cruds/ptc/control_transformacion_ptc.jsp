 <%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>


<%  
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    clases.controles.connectarBD();  
    Connection cn = clases.controles.connect;
    fuente.setConexion(cn);   
    String id=request.getParameter("cod_interno");
    String tipo_huevo=request.getParameter("itemcode");
    int tipo=0;
    String mensaje=null;
       try {
            CallableStatement  callableStatement=null;   
            callableStatement = cn.prepareCall("{call [mae_ptc_update_tipoHuevoNoCosteados]( ?, ?, ?,?)}");
            callableStatement .setInt(1,Integer.parseInt(id) );
            callableStatement .setString(2,  tipo_huevo );
            callableStatement.registerOutParameter("tipo_res", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();
            tipo = callableStatement.getInt("tipo_res");
            mensaje=callableStatement.getString("mensaje");
           } catch (Exception e) {
                  tipo=0;
                   mensaje=e.toString();
           }
               
                ob.put("tipo", tipo);
                ob.put("mensaje", mensaje); 
                out.print(ob);
                cn.close();
                controles.DesconnectarBD();
                 
%> 