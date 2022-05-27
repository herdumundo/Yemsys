<%-- 
    Document   : consulta_max
    Created on : 26/01/2022, 16:40:32
    Author     : csanchez
--%>

<%@page import="java.io.File"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.DataInput"%>
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
    String ave_nro = request.getParameter("ave");
    String necrop_nro = request.getParameter("nro_necrop");
    int id_ultimo = 1550;
    int number = Integer.parseInt(necrop_nro);
    String nro = "";
    String ave = "";
    String url = "";
    String imagen = "";
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);
    JSONObject obje = new JSONObject();
    obje = new JSONObject();
    PreparedStatement pt = clases.controles.connectSesion.prepareStatement(
            "select pnecfile_id id, pnecfile_nec nro, pnecfile_ave ave, pnecfile_filename imagen"
            + " from ppr_necropsias_files where pnecfile_nec='" + necrop_nro + "' and pnecfile_ave='" + ave_nro + "' ");
    ResultSet rs = pt.executeQuery();
    ArrayList datos = new ArrayList();
    ArrayList lista_imagen = new ArrayList();
    //  v7.maehara.com/uploads/ppr/necropsias/ppr-nec-1452-1-DSC00406.JPG
    // http://v7.maehara.com/uploads/ppr/necropsias/

    if (number < id_ultimo) {
        while (rs.next()) {
            Map<String, String> datos_lista = new HashMap<String, String>();
            Map<String, String> imagen_lista = new HashMap<String, String>();
            url = ("../../necropsias_imagen/" + rs.getString("imagen"));
            if (url == rs.getString("imagen")) {

            }
            datos_lista.put("id", rs.getString("id"));
            datos_lista.put("nro", rs.getString("nro"));
            datos_lista.put("ave", rs.getString("ave"));
            datos_lista.put("imagen", rs.getString("imagen"));
            imagen_lista.put("url", "http://v7.maehara.com/uploads/ppr/necropsias/" + rs.getString("imagen"));
            nro = rs.getString("nro");
            ave = rs.getString("ave");
            datos.add(datos_lista);
            lista_imagen.add(imagen_lista);
        }
    };

    if (number >= id_ultimo) {
        while (rs.next()) {
            Map<String, String> datos_lista = new HashMap<String, String>();
            Map<String, String> imagen_lista = new HashMap<String, String>();
            url = ("../../necropsias_imagen/" + rs.getString("imagen"));
            if (url == rs.getString("imagen")) {

            }
            datos_lista.put("id", rs.getString("id"));
            datos_lista.put("nro", rs.getString("nro"));
            datos_lista.put("ave", rs.getString("ave"));
            datos_lista.put("imagen", rs.getString("imagen"));
            //imagen_lista.put("url", "necropsias_imagen/"+rs.getString("imagen"));
            //imagen_lista.put("url", "img/img_aldo/Captura_infrom.PNG");
            imagen_lista.put("url", "necropsias_imagen/" + rs.getString("imagen"));

            nro = rs.getString("nro");
            ave = rs.getString("ave");
            datos.add(datos_lista);
            lista_imagen.add(imagen_lista);
        }
    };

    obje.put("datos", datos);
    obje.put("imagen_lista", lista_imagen);
    obje.put("nro", nro);
    obje.put("ave", ave);
    obje.put("url", url);

    out.print(obje);
%>



