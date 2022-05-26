<%-- 
    Document   : crud_agregar_usuario_pendientes
    Created on : 28-dic-2021, 7:35:53
    Author     : aespinola
--%>

<%@page import="clases.controles"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="application/json; charset=utf-8"%>
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

    String nombre;
    String apellido;
    String area;

    nombre = request.getParameter("nombrepend");
    apellido = request.getParameter("apellidopend");
    area = request.getParameter("select_area");

    String mensaje = "";
    String tipo_registro = "";

    controles.VerificarConexion();

    fuente.setConexion(clases.controles.connectSesion);

    try {
        clases.controles.connectSesion.setAutoCommit(false);

        CallableStatement call;

        call = clases.controles.connectSesion.prepareCall("{call [stp_mae_ppr_insert_usuarios_pendientes](?,?,?,?,?)}");

        call.setString(1, nombre);
        call.setString(2, apellido);
        call.setInt(3, Integer.parseInt(area));
        call.registerOutParameter(4, java.sql.Types.VARCHAR);
        call.registerOutParameter(5, java.sql.Types.VARCHAR);
        call.execute();

        mensaje = call.getString(5);
        tipo_registro = call.getString(4);
        if (tipo_registro == "0") {
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
