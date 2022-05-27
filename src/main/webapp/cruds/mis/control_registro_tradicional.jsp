<%@page import="java.sql.CallableStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.json.JSONObject"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json; charset=utf-8" %>
<%@include  file="../../chequearsesion.jsp" %>
<%    
    JSONObject ob = new JSONObject();
    clases.controles.connectarBD();
    String mensaje = null;
    Integer tipo_respuesta = null;
    try {

        String fecha_puesta = request.getParameter("fecha_puesta");
        String clasificadora = (String) sesionOk.getAttribute("clasificadora");
        String nrocarro = request.getParameter("cod_carrito");
        String nombre_usuario = (String) sesionOk.getAttribute("nombre_usuario");
        String tipo_huevo = request.getParameter("tipo_huevo");
        String cantidad = request.getParameter("txt_cantidad");//SE PASA A AJAX
        String unidad_medida = "GR";
        String categoria = (String) sesionOk.getAttribute("categoria");
        String fecha = request.getParameter("calendario_registro");
        String tipo_aviario = request.getParameter("tipo_aviario");
        String responsable = request.getParameter("txt_responsable");
        String liberado = request.getParameter("txt_liberado");
        String comentario = request.getParameter("txt_obs");
        String cbox_reproceso = request.getParameter("cbox_reproceso");
        String hora_desde_hasta;
        String lote = "";
        hora_desde_hasta = "";
        String fecha_puesta_form2 = fecha_puesta.replace("/", "");

        lote = nrocarro + "_" + fecha_puesta_form2 + "_" + categoria + "_" + tipo_huevo;

        CallableStatement callableStatement = null;
        callableStatement = clases.controles.connect.prepareCall("{call [mae_ptc_insert_reproceso_tradicional](?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? )}");
        callableStatement.setString(1, fecha);
        callableStatement.setString(2, nrocarro);
        callableStatement.setString(3, "RP");
        callableStatement.setString(4, categoria);
        callableStatement.setString(5, fecha_puesta);
        callableStatement.setString(6, hora_desde_hasta);
        callableStatement.setString(7, lote);
        callableStatement.setString(8, responsable);
        callableStatement.setString(9, unidad_medida);
        callableStatement.setString(10, cantidad);
        callableStatement.setString(11, "A");
        callableStatement.setString(12, "L");
        callableStatement.setString(13, clasificadora);
        callableStatement.setString(14, "N/A");
        callableStatement.setString(15, tipo_aviario);
        callableStatement.setString(16, "-");
        callableStatement.setString(17, liberado);
        callableStatement.setString(18, comentario);
        callableStatement.setString(19, cbox_reproceso);
        callableStatement.setString(20, nombre_usuario);
        callableStatement.setString(21, clasificadora);
        callableStatement.setString(22, clasificadora);

        callableStatement.registerOutParameter("estado_registro", java.sql.Types.INTEGER);
        callableStatement.registerOutParameter("mensaje", java.sql.Types.VARCHAR);
        callableStatement.execute();
        tipo_respuesta = callableStatement.getInt("estado_registro");
        mensaje = callableStatement.getString("mensaje");

        ob.put("mensaje", mensaje);
        ob.put("tipo_respuesta", tipo_respuesta);
    } catch (Exception e) {

        ob.put("mensaje", e.getMessage());
        ob.put("tipo_respuesta", "0");
    }

    clases.controles.DesconnectarBD();
    out.print(ob);
%> 
