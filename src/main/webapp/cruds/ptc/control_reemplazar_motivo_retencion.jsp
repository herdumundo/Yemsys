 <%@page import="clases.controles"%>
<%@page import="clases.variables"%>
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
         // Crear objeto de conexion al DB     
     String cod_lote                    = request.getParameter ("cod_lote");
     String cod_interno                 = request.getParameter ("cod_interno");
     String []  motivo_retencion            = request.getParameterValues ("motivo_retencion");
     int tipo_respuesta=0;
      String mensaje="";
      String motivo_retencion_formateada="";
      String motivo ="";
      try {   
  
          
          
             
               for(int i=0; i<motivo_retencion.length; i++)   {
               
                    if (motivo_retencion.length>1){
                        motivo+=motivo_retencion[i]+",";  
                        motivo_retencion_formateada=motivo.toString();
                        motivo_retencion_formateada = motivo_retencion_formateada.substring(0, motivo_retencion_formateada.length() - 1);
                   }
                    if (motivo_retencion.length==1){
                        motivo+=motivo_retencion[i];  
                        motivo_retencion_formateada=motivo.toString();
                   }
                                                            }
         cn.setAutoCommit(false);
            CallableStatement  callableStatement=null;   
            callableStatement = cn.prepareCall("{call mae_ptc_update_motivoRetencion (?,?,?,?,?)}");
            callableStatement .setString(1,  cod_lote );
            callableStatement .setInt(2,  Integer.parseInt(cod_interno)  );
            callableStatement .setString(3, motivo_retencion_formateada);
    
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.registerOutParameter("tipo_mensaje", java.sql.Types.INTEGER);
            callableStatement.execute();
            tipo_respuesta = callableStatement.getInt("tipo_mensaje");
            mensaje = callableStatement.getString("mensaje");
        
            ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", tipo_respuesta); 
            
            if(tipo_respuesta==1){
                cn.commit();
            }
            else if (tipo_respuesta==0){
                cn.rollback();
             }
            
      
      } 
            catch (Exception e) 
            {
                cn.rollback();
                ob.put("mensaje", e.toString());
                ob.put("tipo_respuesta", "0");         
              }    
                cn.close();
                controles .DesconnectarBD();
                out.print(ob);
              %>
