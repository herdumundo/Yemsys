<%-- 
    Document   : crud_agregar_modulos
    Created on : 14/12/2021, 11:20:03
    Author     : csanchez
--%>

<%@page import="clases.controles"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
 
<%@include  file="../chequearsesion.jsp" %>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" /> 
<%
        JSONObject obje = new JSONObject();
        obje = new JSONObject();
        
        String descri_rol;
        String descri_modulo;
        String select_rol;
         String id=  "";
        descri_rol= request.getParameter("descri_rol");
        descri_modulo= request.getParameter("descri_modulo");
        select_rol= request.getParameter("data.select[c]");
        String[] array_modulo= request.getParameterValues("permisos");
        String mensaje="";
        String tipo_mensaje="";
        String verificacion_commit="";
        controles.VerificarConexion();
        fuente.setConexion(clases.controles.connectSesion);
         int i=0;
        
        
    try{
         CallableStatement call2;
        call2 = clases.controles.connectSesion.prepareCall("exec [stp_mae_yemsys_insert_permisos_estado] @idrol='"+select_rol+"'");
        call2.execute(); 
     
        int asda=array_modulo.length;
        CallableStatement call;
         for(i=0; i<array_modulo.length;)//mientras que i sea menor que grilla_array 
        { 
         id=array_modulo[i];
         String [] separar_columnas=id.split("_");
         String col1="";
         col1=separar_columnas[0];                               
        call = clases.controles.connectSesion.prepareCall("{call [stp_mae_yemsys_insert_permisos](?,?,?,?)}");
        call.setString(1, select_rol);
        call.setString(2, id);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.execute(); 
        tipo_mensaje=call.getString(3);
        mensaje=call.getString(4);
             
             i++;

         } 
        
        
        } catch (Exception ex) {
     }
 finally {
      controles.DesconnectarBDsession();
        obje.put("mensaje",mensaje );
        obje.put("tipo_mensaje",tipo_mensaje );
        out.print(obje);
 }
%>

