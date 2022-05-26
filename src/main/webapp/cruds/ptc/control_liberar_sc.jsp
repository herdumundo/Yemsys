<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>
<%  
    clases.controles.connectarBD();  
    Connection cn = clases.controles.connect;
    fuente.setConexion(cn);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    String usuario              =   (String) sesionOk.getAttribute("usuario");
    String fecha_alimentacion         =   request.getParameter("fecha_alimentacion");
    String contenido            =   request.getParameter("contenido");
    int tipo_respuesta=0;
    String mensaje="";
   try {  
            cn.setAutoCommit(false);
            CallableStatement  callableStatement=null;   
            callableStatement = cn.prepareCall("{call mae_ptc_liberar_sc(?,?,?,?,?)}");      
            callableStatement .setString(1,  usuario );
            callableStatement .setString(2,  fecha_alimentacion  );
            callableStatement .setString(3, contenido);
            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);            
            callableStatement.execute();
            tipo_respuesta = callableStatement.getInt("estado_registro");
            mensaje= callableStatement.getString("mensaje");            
                
            if (tipo_respuesta==0)
            {
                cn.rollback(); 
            }   
            else  
            {
                //cn.rollback(); 
                cn.commit();
            }   
            ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", String.valueOf(tipo_respuesta));
                
        } catch (Exception e) 
        {
            ob.put("mensaje", e.toString());
            ob.put("tipo_respuesta", "1");
            cn.rollback();
        }
            cn.close();
            clases.controles.DesconnectarBD();
            out.print(ob);
      %>           