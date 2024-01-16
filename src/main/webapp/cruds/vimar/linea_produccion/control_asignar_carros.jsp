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
<%@page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include file="../../../cruds/conexion.jsp" %>
<%
    //Connection cn = conexion.crearConexion();
    //fuente.setConexion(cn);
      
    String linea = (String) sesionOk.getAttribute("clasificadora");     
     String usuario = (String) sesionOk.getAttribute("id_usuario");  
    String[] cbox_carro=request.getParameterValues("cbox_carro"); 
    int tipo_respuesta=1;
    int nro_carro=0;
    int cantidad=0;
    int tipo=1;
    String cod_lote="";
    String contenido="";
    String mensaje="";
        try {
                
            for(int i=0; i<cbox_carro.length; i++)
            {

                contenido=cbox_carro[i];
                String[] textElements = contenido.split("-");  

                nro_carro= Integer.parseInt(textElements[0].trim());
                cantidad  = Integer.parseInt(textElements[1].trim());
                cod_lote= textElements[2].trim();
                connection.setAutoCommit(false);
                    CallableStatement  callableStatement=null;   
                    callableStatement = connection.prepareCall("{call [vim_prod_fallas_asignacion_carros](?,?,?,?,?,?,? )}");
                    callableStatement.setString(1, linea );
                    callableStatement.setInt(2,    nro_carro );
                    callableStatement.setInt(3,    cantidad );
                    callableStatement.setString(4, cod_lote );
                    callableStatement.setString(5, usuario );
                    callableStatement.registerOutParameter("mensaje", java.sql.Types.INTEGER);
                    callableStatement.registerOutParameter("detalle_mensaje", java.sql.Types.VARCHAR);
                    callableStatement.execute();

                    tipo    =   callableStatement.getInt("mensaje");
                    mensaje =   callableStatement.getString("detalle_mensaje");
                    tipo_respuesta=tipo_respuesta*tipo;
            }
                   if(tipo_respuesta==0){
                       connection.rollback();
                   } 

                   else{
                          //  cn.rollback();
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
            out.print(ob);  %>  