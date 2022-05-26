<%-- 
    Document   : crud_agregar_rol
    Created on : 14/12/2021, 07:17:45
    Author     : csanchez
--%>

<%@page import="clases.controles"%>
<%@page contentType="application/json; charset=utf-8"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import ="java.sql.Connection"%>
<%@page import ="java.sql.SQLException"%>
<%@page import ="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<jsp:useBean id="fuente" class="clases.fuentedato" scope="page" />
 
<%
    JSONObject obje = new JSONObject();
    obje = new JSONObject();

    String descripcion;
    String mensaje = "";
    String tipo_registro = "";
    descripcion = request.getParameter("descripcion");
    controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    try {
        clases.controles.connectSesion.setAutoCommit(false);

        CallableStatement call;

        call = clases.controles.connectSesion.prepareCall("{call stp_mae_ppr_insert_roles(?,?,?)}");

        call.setString(1, descripcion);
        call.registerOutParameter(2, java.sql.Types.VARCHAR);
        call.registerOutParameter(3, java.sql.Types.VARCHAR);
        call.execute();
        mensaje = call.getString(3);
        tipo_registro = call.getString(2);

         if (tipo_registro == "1") {
            clases.controles.connectSesion.rollback();

        } else {
            //clases.controles.connectSesion.rollback(); 
            clases.controles.connectSesion.commit();

        }
    } catch (Exception ex) {

    } finally {
            clases.controles.DesconnectarBDsession();
        obje.put("mensaje", mensaje);
        obje.put("tipo_registro", tipo_registro);
        out.print(obje);
    }
%>

