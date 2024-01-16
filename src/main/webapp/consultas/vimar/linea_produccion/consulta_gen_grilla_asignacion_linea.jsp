<%@page import="java.text.DecimalFormat"%>
<%@page import="clases.controles"%>
<%@page import="clases.variables"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="application/json; charset=utf-8" %>
<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
<%@include  file="../../../chequearsesion.jsp" %>
<%@include  file="../../../cruds/conexion.jsp" %> 
<%  JSONObject ob = new JSONObject();
    String grilla_html = "";
    String cabecera = "";
    try {
        ResultSet rsUsuarios;
        Statement st = connection.createStatement();

        rsUsuarios = st.executeQuery("select distinct T1.cod_usuario, T1.nombre, "
                + " isnull(T2.linea, 'No asignado') as linea "
                + " from usuarios T1 "
                + " left outer join "
                + " vim_yemsys_usuario_linea T2 on T1.cod_usuario=T2.idUsuario "
                + " where T1.clasificadora='U' ");

        cabecera = " <table id='tb_asignacion_usu_consulta' class='display'> "
                    + " <thead> "
                        + " <tr> "
                            + " <th>Código usuario</th> "
                            + " <th>Nombre Usuario</th> "
                            + " <th>Linea</th> "
                            + " <th>Acción</th> "
                        + "</tr> "
                    + " </thead> "
                    + " <tbody> ";
        while (rsUsuarios.next()) {
            grilla_html = grilla_html
                    + " <tr id='row" + rsUsuarios.getString("cod_usuario") + "'> "
                        + " <td>" + rsUsuarios.getString("cod_usuario") + "</td> "
                        + " <td>" + rsUsuarios.getString("nombre") + "</td> "
                        + " <td>" + rsUsuarios.getString("linea") + "</td> "
                        + " <td> "
                            + " <a class='btn btn-success btn-icon-split' data-toggle='modal' data-target='#miModal' onclick='prepararModal("+rsUsuarios.getString("cod_usuario")+", \""+rsUsuarios.getString("nombre")+"\" )'> "
                                + "<span class='icon text-white-50'><i class='fas fa-info-circle'></i></span> "
                                + "<span class='text'>Acción</span> "
                            + " </a> "
                        + "</td> "
                    + "</tr> ";
        }

        ob.put("grilla", cabecera + grilla_html + "</tbody></table>");

        rsUsuarios.close();
    } catch (Exception e) {
        ob.put("grilla", e.toString());
    } finally {
        connection.close();
        out.print(ob);
    }
%>


