<%-- 
    Document   : reporte_datos_mortandad
    Created on : 07/01/2022, 08:10:10
    Author     : csanchez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@include  file="../../cruds/conexion.jsp" %>
<%
      String aviario = request.getParameter("aviario");
      String fecha   = request.getParameter("fecha");
      String lote1   = request.getParameter("lote");
      int lote = 0;
      String id_datos = "";
      String fecha_anterior = "";
       JSONObject obje = new JSONObject();
      obje = new JSONObject();
      try {
              
      PreparedStatement pt = connection.prepareStatement("select mor_fila, mor_cant,mor_lote,mor_aviario,mor_id  from ppr_mortandad where mor_fecha='" + fecha + "' and mor_aviario='" + aviario + "'");
      ResultSet rs = pt.executeQuery();

      ArrayList Fila_M = new ArrayList();
      ArrayList Fila_id = new ArrayList();
      while (rs.next()) {

          Map<String, String> fila_m = new HashMap<String, String>();
          Map<String, String> id_mor = new HashMap<String, String>();

          fila_m.put("id", "#" + rs.getString("mor_fila"));
          id_mor.put("mor_id",   rs.getString("mor_id"));
          fila_m.put("mor_id",   rs.getString("mor_id"));
          fila_m.put("fila",     rs.getString("mor_fila"));
          fila_m.put("cantidad", rs.getString("mor_cant"));

          Fila_M.add(fila_m);
          lote = rs.getInt("mor_lote");
          Fila_id.add(id_mor);

      }
      PreparedStatement pt3 = connection.prepareStatement("execute [stp_mae_ppr_select_ultima_fecha] '"+lote1+"', '"+fecha+"','"+aviario+"'");
      ResultSet rs3 = pt3.executeQuery();
      while (rs3.next()) {
          fecha_anterior = rs3.getString("dl_fecha");
          id_datos = rs3.getString("dl_id");
      }
      obje.put("filas", Fila_M);
      obje.put("lote", lote);
      obje.put("aviario", aviario);
      obje.put("id_mor", Fila_id);
      obje.put("fecha_anterior", fecha_anterior);
      obje.put("id_datos", id_datos);
     
      
          } catch (Exception e) {
             String error = e.getMessage();
          }
      finally{
      connection.close();
      out.print(obje);
      }
 %>