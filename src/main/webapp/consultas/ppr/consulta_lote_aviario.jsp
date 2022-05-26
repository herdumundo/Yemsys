<%-- 
    Document   : consulta_max
    Created on : 26/01/2022, 16:40:32
    Author     : csanchez
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<jsp:useBean id="conexion" class="clases.ConnectionSqlServer" scope="page" />
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
    String fecha = request.getParameter("fecha");
    String aviario = request.getParameter("aviario");
     String lote_name = "";
     String lote = "";
     clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("select max(l.lote_name) as lote_name,c.lote from ppr_contador c inner join ppr_lotes l on c.lote=l.lote_id "
                                              + " where aviario='"+aviario+"'  and c.fecha='"+fecha+"' group by c.lote,l.lote_name ");
    ResultSet rs8=pt.executeQuery();
 

               while(rs8.next()) {  
                
                lote_name=rs8.getString("lote_name");
                lote=rs8.getString("lote");
                  }
                
                
    obje.put("lote_name",lote_name );
    obje.put("lote",lote);
        clases.controles.DesconnectarBDsession();             
    out.print(obje); 
 %>
