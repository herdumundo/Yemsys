<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%@page contentType="application/json; charset=utf-8" %>
    <% 
    clases.controles.connectarBD();
    String cbox_chofer= request.getParameter("cbox_chofer") ;
    String cbox_camion= request.getParameter("cbox_camion") ;
    String filas_grilla= request.getParameter("resultado") ;
    String fecha_embarque= request.getParameter("calendario") ;
    String numero_factura = request.getParameter("numero_factura") ;
    String hora_inicio = request.getParameter("hora_inicio") ;
    String nombre_usuario=(String)sesionOk.getAttribute("nombre_usuario");
    String area=(String)sesionOk.getAttribute("area");
    String mensaje="";
    JSONObject ob = new JSONObject();
    ob=new JSONObject();
    int tipo_respuesta=0;
    try { 
          //  clases.controles.connect.setAutoCommit(false);
       
            CallableStatement  callableStatement=null;   
            callableStatement = clases.controles.connect.prepareCall("{call mae_cch_pa_embarque( ?, ?, ?, ?, ? ,?,?,?,?,?)}");
            callableStatement .setString(1,filas_grilla);
            callableStatement .setInt(2,Integer.parseInt(cbox_chofer) );
            callableStatement .setInt(3, Integer.parseInt(cbox_camion));
            callableStatement .setString(4,numero_factura);
            callableStatement .setString(5, area);
            callableStatement .setString(6, nombre_usuario);
            callableStatement .setString(7,  fecha_embarque );
            callableStatement .setString(8,  hora_inicio);
            callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
            callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
            callableStatement.execute();
            mensaje = callableStatement.getString("mensaje");
            tipo_respuesta = callableStatement.getInt("estado_registro");
            
            if (tipo_respuesta==0)
            {
              //  clases.controles.connect.rollback(); 
            }   
            else 
            {
              //   clases.controles.connect.rollback(); 
              // clases.controles.connect.commit();
            }
        } 
    
            catch (Exception e) 
            {
                ob.put("mensaje", e.getMessage());
                ob.put("tipo_respuesta", tipo_respuesta);
            }
    finally{
            ob.put("mensaje", mensaje);
            ob.put("tipo_respuesta", tipo_respuesta);
            clases.controles.DesconnectarBD();
            out.print(ob); 

    }
        %>  