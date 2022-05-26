  <%@page import="com.microsoft.sqlserver.jdbc.SQLServerDataTable"%>
<%@page import="ptc.lotes_reprocesos"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
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
    clases.controles.VerificarConexion();
    Connection cn = clases.controles.connectSesion;
    fuente.setConexion(cn);
    JSONObject ob = new JSONObject();
    ob=new JSONObject();         // Crear objeto de conexion al DB     
    String grilla           = request.getParameter("jsonObj");
    String usuario          = (String) sesionOk.getAttribute("user_name");
    String clasificadora    = (String) sesionOk.getAttribute("clasificadora");
    String tipo_registro    = request.getParameter("registro");
    String id_cabecera    = request.getParameter("id_cab");
    int tipo_respuesta=0;
    String mensaje="";
    int id_cab=0;
     
 
     
     try {
         cn.setAutoCommit(false);
                CallableStatement  callableStatement=null;   
                
                if(tipo_registro.equals("1"))
                {
                    callableStatement = cn.prepareCall("{call mae_ptc_insert_apertura_reproceso(?,?,?,?,?)}");
                    callableStatement .setString(1,  usuario );
                    callableStatement .setString(2,clasificadora  );
                    callableStatement.registerOutParameter("id_cab", java.sql.Types.INTEGER);
                }
                else
                {
                    ObjectMapper mapper = new ObjectMapper();
                    lotes_reprocesos[] pp1 = mapper.readValue(grilla, lotes_reprocesos[].class);
                    SQLServerDataTable sourceDataTable = new SQLServerDataTable();
                    sourceDataTable.addColumnMetadata("cod_carrito" ,   java.sql.Types.VARCHAR);
                    sourceDataTable.addColumnMetadata("cantidad" ,      java.sql.Types.INTEGER);
                    sourceDataTable.addColumnMetadata("cod_interno" ,   java.sql.Types.INTEGER);
                    sourceDataTable.addColumnMetadata("tipo_huevo" ,   java.sql.Types.VARCHAR);
                    for (lotes_reprocesos lotes : pp1) 
                    {
                        sourceDataTable.addRow(lotes.cod_carrito,lotes.cantidad, lotes.cod_interno, lotes.tipo_huevo );
                    }
        
                    callableStatement = cn.prepareCall("{call mae_ptc_insert_cierre_reproceso(?,?,?,?,?)}");
                    callableStatement .setString(1, clasificadora); 
                    callableStatement .setObject(2, sourceDataTable); 
                    callableStatement .setInt(3, Integer.parseInt(id_cabecera)); 
                }
                callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
                callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
             
                callableStatement.execute();
                tipo_respuesta = callableStatement.getInt("estado_registro");
                mensaje= callableStatement.getString("mensaje");
                if(tipo_registro.equals("1")){
                id_cab= callableStatement.getInt("id_cab");
                }
                if (tipo_respuesta==0)
                {
                    cn.rollback(); 
                }   
                else  
                {
                   // cn.rollback(); 
                     cn.commit();
                }   
            ob.put("mensaje", mensaje);
            ob.put("id_cab", id_cab);
            ob.put("tipo_respuesta", tipo_respuesta);
          
       } catch (Exception e) 
        {
            ob.put("mensaje", e.toString());
            ob.put("tipo_respuesta", tipo_respuesta);
        }
        cn.close();
         out.print(ob);   %>       
