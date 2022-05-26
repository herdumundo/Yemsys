<%-- 
    Document   : consulta_carga_grilla_aviarios_ultimo_registro
    Created on : 31/01/2022, 14:12:06
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
        String aviario= request.getParameter("aviario") ;
        String fecha= "";
        String fecha2= request.getParameter("fecha2") ;

           clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

     JSONObject obje = new JSONObject();
    obje = new JSONObject();
    //PreparedStatement pt=con.prepareStatement("select case  when  fila % 2 =0 then 'green' else 'red' end as color, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
     //PreparedStatement pt=con.prepareStatement("select idusuario,nombreusuario from tab_mae_ppr_log");
    //PreparedStatement pt=con.prepareStatement("select '#ff0000' as min1, '#e10000' as min2,'#e10000' as min3, '#007d3c' as prom, '#007d50' as prom1 , '#007d97' as prom2, '#007dff' as prom3, fila, sum(cant) as cant from ppr_contador where fecha BETWEEN '"+fecha1+"'and '"+fecha2+"'and aviario='"+aviario+"'group by fila");
    PreparedStatement pt=clases.controles.connectSesion.prepareStatement("select max(dl_fecha) as fecha from ppr_datolotes");
    ResultSet rs=pt.executeQuery();
    ArrayList Fila = new ArrayList();
    //ArrayList fe1 = new ArrayList();
   // ArrayList fe2 = new ArrayList();
            while(rs.next()) {

  
                fecha = rs.getString("fecha");
               // Cant.add(cant_c);
               
              }
     obje.put("fecha",fecha );
   // obje.put("fecha1",fe1 );
   // obje.put("fecha2",fe2 );
   // obje.put("cant",Cant );
    out.print(obje); 
 %>