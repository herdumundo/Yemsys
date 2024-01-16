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
     String usuario = (String) sesionOk.getAttribute("id_usuario");
    String cbox= request.getParameter("cbox_inicio");
    String [] partes= cbox.toString().split("-");
    int nro_prod=Integer.parseInt(partes[0].trim());
    String presentacion= partes[1].trim();
    int tipo_respuesta=0;
    String mensaje="";
        //NOTA: EL TRY CATCH Y LOS COMMITS ESTAN EN EL PROCEDIMIENTO ALMACENADOS.
                CallableStatement  callableStatement=null;   
                    callableStatement = connection.prepareCall("{call [vim_prod_fallas_inicio_produccion](?,?,?,?,?,? )}");
                    callableStatement .setInt(1,   nro_prod );
                    callableStatement .setString(2,   linea );
                    callableStatement .setString(3,   usuario );
                    callableStatement .setString(4,   presentacion );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo_respuesta = callableStatement.getInt("mensaje");
                    mensaje = callableStatement.getString("detalle_mensaje");

                    
            JSONObject ob = new JSONObject();
            ob=new JSONObject();
            ob.put("tipo", tipo_respuesta);
            ob.put("mensaje",mensaje);
            out.print(ob);  %>  