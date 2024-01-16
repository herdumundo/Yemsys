<%@page import="org.apache.http.client.config.RequestConfig"%>
<%@page import="org.apache.http.util.EntityUtils"%>
<%@page import="org.apache.http.HttpEntity"%>
<%@page import="org.apache.http.client.methods.HttpGet"%> 
<%@page import="org.apache.http.HttpResponse"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@page import="org.apache.http.client.methods.HttpPost"%>
<%@page import="org.apache.http.impl.client.HttpClients"%>
<%@page import="org.apache.http.entity.StringEntity"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@include file="../../../chequearsesion.jsp" %>
 <%@include file="../../../cruds/conexion.jsp" %>
<%
//    Connection cn = conexion.crearConexion();
//    fuente.setConexion(cn);
    String linea = (String) sesionOk.getAttribute("clasificadora");     
     int cbox_op_fin= Integer.parseInt(request.getParameter("cbox_op_fin"));
    int tipo_respuesta=0;
    String mensaje="";
        try {
                
           
                connection.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                    callableStatement = connection.prepareCall("{call [vim_prod_fallas_cierre_produccion](?,?,?,? )}");
                    callableStatement .setInt(1,   cbox_op_fin );
                    callableStatement .setString(2,   linea );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo_respuesta = callableStatement.getInt("mensaje");
                    mensaje = callableStatement.getString("detalle_mensaje");

                   if(tipo_respuesta==0){
                       connection.rollback();
                   } 

                   else{
                       //cn.rollback();
                       connection.commit();
                   }                    
           
       
                
            } catch (Exception e) {
                connection.rollback();
                mensaje=e.toString();
            }
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("mensaje",mensaje);
            out.print(ob);  
%>  