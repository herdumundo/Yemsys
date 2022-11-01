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
<%@include  file="../../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
  <% 
        String aviario2= request.getParameter("aviario") ;
        String fecha12= request.getParameter("fecha1") ;
        String fecha22= request.getParameter("fecha2") ;

 clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("select  (sum(cant)/count(*)) as promedio , min(cant) as minimo, max(cant) maximo, 1 as flag from (select sum(cant) as cant,fila from ppr_contador where fecha BETWEEN '"+fecha12+"'and '"+fecha22+"'and aviario='"+aviario2+"' group by fila ) ts");
    ResultSet rs8=pt.executeQuery();
    ArrayList Fila = new ArrayList();

            while(rs8.next()) {

                Map<String, String> fila_f = new HashMap<String, String>();
                Map<String, String> cant_c = new HashMap<String, String>();

                fila_f.put("maximo", rs8.getString("maximo"));
                fila_f.put("minimo", rs8.getString("minimo"));

                Fila.add(fila_f);
               
              }
        clases.controles.DesconnectarBDsession();             
     obje.put("filas13",Fila );

    out.print(obje); 
 %>
