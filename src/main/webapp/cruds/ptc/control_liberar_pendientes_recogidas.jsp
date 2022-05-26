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
    String usuario       = (String) sesionOk.getAttribute("usuario");
    String id     = request.getParameter("id");
    String estado     = request.getParameter("estado");// 2 es liberado // 5 ELIMINADO
 
     try {
         
            PreparedStatement ps2 = controles.connect.prepareStatement("update  mae_ptc_pendientes_recogidas set estado='"+estado+"' ,usuario_upd='"+usuario+"' where id='"+id+"'");
            ps2.executeUpdate(); 
            ob.put("mensaje", "OPERACION REALIZADA CON EXITO.");
            ob.put("tipo_respuesta", "1");
          
       } catch (Exception e) 
        {
            ob.put("mensaje", e.toString());
            ob.put("tipo_respuesta", "0");
        }
        cn.close();
        controles.DesconnectarBD();
        out.print(ob);   %>       
