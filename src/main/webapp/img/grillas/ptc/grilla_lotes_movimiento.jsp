 <%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page contentType="application/json; charset=utf-8" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %> 
<%@include  file="../../chequearsesion.jsp" %>
 
                  <%
                      
        JSONObject ob = new JSONObject();
        JSONArray jarray = new JSONArray();
        
        String hora_desde  = request.getParameter("inicio_retenido");
        String combo_estado=request.getParameter("combo_estado_retenido");
        String hora_fin  = request.getParameter("fin_retenido");
        String calendario=request.getParameter("fecha_retenido");
        String tipo_consulta    = request.getParameter("tipo");
        String clasificadora    = (String) sesionOk.getAttribute("clasificadora");
        String clasificadora_cch    = (String) sesionOk.getAttribute("area_cch");
         String tipo_movimiento=request.getParameter("combo_estado_retenido");
          
          if(tipo_movimiento.equals("R")){
              
              tipo_movimiento="L";
          }
          else if (tipo_movimiento.equals("Z")){
              tipo_movimiento="L,R";
              
          }
          else {
              
              tipo_movimiento="Z,R";
          }
        try 
        {
                clases.controles.connectarBD();   
                Connection cn = clases.controles.connect; 
                fuente.setConexion(cn);            

                        ResultSet rs = fuente.obtenerDato(" exec [mae_ptc_select_movimientos] @clasificadora='"+clasificadora+"',"
                    + "@fecha='"+calendario+"',@hora_inicio='"+hora_desde+"',@hora_fin='"+hora_fin+"',@tipo_estado='"+combo_estado+"',"
                    + "@tipo_consulta='"+tipo_consulta+"',@clasificadora_cch='"+clasificadora_cch+"',@tipo_movimiento='"+tipo_movimiento+"'"); 

            while(rs.next()){
                    ob=new JSONObject();
                    ob.put("0",  rs.getString("cod_interno"));        
                    ob.put("1",  rs.getString("cod_interno"));        
                    ob.put("2",  rs.getString("cod_lote"));        
                    ob.put("3",  rs.getString("cod_carrito"));        
                    ob.put("4",  rs.getString("tipo_huevo"));        
                    ob.put("5",  rs.getString("estado_liberacion"));        
                    ob.put("6",  rs.getString("tipo"));        
                    ob.put("7",  rs.getString("disposicion"));        
                    ob.put("8",  rs.getString("tipo_costeo"));        
                    ob.put("9",  rs.getString("desc_disposicion"));      
                    ob.put("10",  rs.getString("motivo_retencion"));      
                    ob.put("11",  rs.getString("hora_clasificacion"));      
                    ob.put("12",  rs.getString("fecha_involucrada"));      
                    ob.put("13",  rs.getString("aviarios"));      
                  jarray.put(ob);        

                 }
                JSONObject mainObj = new JSONObject();
                mainObj.put("data", jarray);
                out.print(mainObj); 
                clases.controles.DesconnectarBD();
                cn.close();
                 } catch (Exception e) 
                    {
                     String error=e.toString();
                    }
        %>   
            