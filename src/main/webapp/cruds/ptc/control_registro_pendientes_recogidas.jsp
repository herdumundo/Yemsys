  <%@page import="clases.controles"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page"/>
<%@include  file="../../chequearsesion.jsp" %>
<%@ page contentType="application/json; charset=utf-8" %>

<%
    clases.controles.connectarBD();  
    Connection cn = clases.controles.connect;
    fuente.setConexion(cn);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();         // Crear objeto de conexion al DB     
    String usuario             = (String) sesionOk.getAttribute("usuario");
    String clasificadora       = (String) sesionOk.getAttribute("clasificadora");
    String cantidad     = request.getParameter("txt_cantidad");
    String fecha_puesta   = request.getParameter("fecha_puesta");
    int tipo_respuesta=0;
    String mensaje="";
 
     try {
         cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                callableStatement = cn.prepareCall("{call mae_ptc_insert_pendientes_recogidas (?,?,?,?,?,?)}");
                callableStatement .setString(1,  usuario );
                callableStatement .setString(2, clasificadora );
                callableStatement .setInt(3,Integer.parseInt(cantidad)  );
                callableStatement .setString(4,fecha_puesta );
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
            ob.put("tipo_respuesta", tipo_respuesta);
          
       } catch (Exception e) 
        {
            ob.put("mensaje", e.toString());
            ob.put("tipo_respuesta", tipo_respuesta);
        }
        cn.close();
        controles.DesconnectarBD();
        out.print(ob);   %>       
