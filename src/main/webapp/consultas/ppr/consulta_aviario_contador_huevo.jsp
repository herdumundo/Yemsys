<%-- 
    Document   : consulta_aviario_contador_huevo
    Created on : 27-ene-2022, 7:55:31
    Author     : aespinola
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
 <jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
        String aviario= request.getParameter("aviario") ;
        String fecha= request.getParameter("fecha") ;
      
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
        
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("select id, fila, cant, fecha,lote,aviario from ppr_contador where fecha ='"+fecha+"' and aviario= '"+aviario+"' ");
    //PreparedStatement pt2=con.prepareStatement("select  fila, sum(cant/48) as cant from ppr_contador where fecha ='"+fecha+"'and aviario='"+aviario+"'group by fila");

    ResultSet rs=pt.executeQuery();
    ArrayList Fila = new ArrayList();
   
            while(rs.next()) {

                Map<String, String> fila_f = new HashMap<String, String>();
              
                
                fila_f.put("idcontador",  rs.getString("id"));
                fila_f.put("id", "#celda"+rs.getString("fila"));
                fila_f.put("cantidad",    rs.getString("cant"));
                fila_f.put("datafecha",   rs.getString("fecha"));
                fila_f.put("datalote",    rs.getString("lote"));
                fila_f.put("dataavi",     rs.getString("aviario"));
                

                Fila.add(fila_f);
               // Cant.add(cant_c);
               
              }
            clases.controles.DesconnectarBDsession();
     obje.put("filas",Fila );
    
    out.print(obje); 
 %>
