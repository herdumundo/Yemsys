<%-- 
    Created on : 07/01/2022, 08:10:10
    Author     : aespinola
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="clases.controles"%>
<%
      String aviario = request.getParameter("aviario");
      String fecha   = request.getParameter("fecha");
      String lote1   = request.getParameter("lote");
      int lote = 0;
      String pad_productividad ="";
      String dias              ="";
      String sems              ="";
      String saldoaves         ="";
      String huevos            ="";
      controles.connectarBD();
      JSONObject obje = new JSONObject();
      obje = new JSONObject();
      try {
              
      PreparedStatement pt = clases.controles.connect.prepareStatement("select fecha,fila,cant,lote,aviario,id from ppr_contador where fecha='"+fecha+"' and aviario='"+aviario+"'");
      ResultSet rs = pt.executeQuery();

      ArrayList Fila_M = new ArrayList();
      ArrayList Fila_id = new ArrayList();
      while (rs.next()) {

          Map<String, String> fila_m = new HashMap<String, String>();
          Map<String, String> id_mor = new HashMap<String, String>();

          fila_m.put("id", "#" + rs.getString("fila"));
          id_mor.put("mor_id", rs.getString("id"));
          fila_m.put("mor_id", rs.getString("id"));
          fila_m.put("fila",   rs.getString("fila"));
          fila_m.put("cantidad", rs.getString("cant"));

          Fila_M.add(fila_m);
          lote = rs.getInt("lote");
          Fila_id.add(id_mor);

      }
      PreparedStatement pt3 = clases.controles.connect.prepareStatement("exec [stp_mae_ppr_select_contador_huevos] '"+fecha+"','"+lote1+"','"+aviario+"'");
      ResultSet rs3 = pt3.executeQuery();
      while (rs3.next()) {
         pad_productividad = rs3.getString("pad_productividad");
         dias              = rs3.getString("dias");
         sems              = rs3.getString("sems");
         saldoaves         = rs3.getString("saldoaves");
         huevos            = rs3.getString("huevos");
    
      }
      obje.put("filas", Fila_M);
      obje.put("lote", lote);
      obje.put("aviario", aviario);
      obje.put("id_mor", Fila_id);
      obje.put("pad_productividad", pad_productividad);
      obje.put("dias", dias);
      obje.put("sems", sems);
      obje.put("saldoaves", saldoaves);
      obje.put("huevos", huevos);
      
          } catch (Exception e) {
             String error = e.getMessage();
          }
      finally{
      clases.controles.DesconnectarBD();
           out.print(obje);
      }
 %>