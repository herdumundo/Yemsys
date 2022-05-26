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
     String cod_lote            = request.getParameter("txt_cod_lote");
     String usuario             = (String) sesionOk.getAttribute("usuario");
     String clasificadora       = (String) sesionOk.getAttribute("clasificadora");
     String cantidad_huevos     = request.getParameter("cantidad_huevos");
     String fecha_involucrada   = request.getParameter("txt_fecha_involucradas");
     String cod_interno         = request.getParameter("cod_interno");
     int tipo_respuesta=0;
     String mensaje="";
 
     try {
         cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                callableStatement = cn.prepareCall("{call mae_ptc_insert_fechasInvolucradas(?,?,?,?,?,?,?,?)}");
                callableStatement .setInt(1,Integer.parseInt(cod_interno) );
                callableStatement .setString(2,  usuario );
                callableStatement .setString(3, cantidad_huevos );
                callableStatement .setString(4,clasificadora  );
                callableStatement .setString(5,cod_lote );
                callableStatement .setString(6,fecha_involucrada);
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
