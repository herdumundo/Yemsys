<%-- 
    Document   : consulta_chart_fila
    Created on : 20/01/2022, 12:59:34
    Author     : csanchez
--%>

<%@page import="org.json.JSONArray"%>
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
<%      String aviariof = request.getParameter("aviariof");
    String fechadf = request.getParameter("fechadf");
    String fechahf = request.getParameter("fechahf");
    String filadf = request.getParameter("filaf");
    clases.controles.VerificarConexion();
    fuente.setConexion(clases.controles.connectSesion);

    JSONObject chartsdetfila = new JSONObject();
    PreparedStatement pt = clases.controles.connectSesion.prepareStatement("select fecha, cant from ppr_contador where fecha BETWEEN '" + fechadf + "'and '" + fechahf + "'and aviario='" + aviariof + "'and fila='" + filadf + "'");
    ResultSet rs = pt.executeQuery();

    JSONObject DataScale = new JSONObject();

    JSONObject contenidoData, dataOptions, data,
            DataCantidad, DataA, ticksA,
            ContenidoTitle, DataTitle, ContenidoPoint,
            DataPoint, fecha1 = new JSONObject();

    JSONArray fecha2, Dataset, contenido_fecha,
            contenido_cantidad, dataArray = new JSONArray();

    String aviarios = (aviariof);

    DataCantidad = new JSONObject();
    DataCantidad.put("label", "Historico Contador fila: " + filadf + " | desde " + fechadf + " hasta " + fechahf + "del aviario: " + aviariof);
    DataCantidad.put("yAxisID", "A");
    DataCantidad.put("backgroundColor", "rgba(255, 0, 0, 0.5)");
    DataCantidad.put("borderColor", "rgba(255, 0, 0, 0.5)");
    DataCantidad.put("borderWidth", 2);
    DataCantidad.put("type", "line");

    DataA = new JSONObject();
    DataA.put("type", "linear");
    DataA.put("display", true);
    DataA.put("position", "left");
    DataA.put("suggestedMin", 0);
    DataA.put("suggestedMax", 300);

    ticksA = new JSONObject();
    ticksA.put("stepSize", 300);
    DataA.put("ticks", ticksA);

    ContenidoTitle = new JSONObject();
    ContenidoTitle.put("diplay", true);
    ContenidoTitle.put("text", aviarios);

    DataTitle = new JSONObject();
    DataTitle.put("title", ContenidoTitle);

    ContenidoPoint = new JSONObject();
    ContenidoPoint.put("radius", 0);

    DataPoint = new JSONObject();
    DataPoint.put("point", ContenidoPoint);

    contenido_fecha = new JSONArray();
    contenido_cantidad = new JSONArray();

    while (rs.next()) {
        // este recorre la cantidad de registros que hay en ese rango de fecha y en ese aviario

        contenido_fecha.put(rs.getString("fecha"));
        contenido_cantidad.put(rs.getInt("cant"));

        ////FIN DEL RECORRIDO LARGO
    }
    clases.controles.DesconnectarBDsession();
    fecha2 = new JSONArray();
    fecha2.put(fecha1);

    DataCantidad.put("data", contenido_cantidad);

    Dataset = new JSONArray();
    Dataset.put(DataCantidad);
    contenidoData = new JSONObject();
    data = new JSONObject();

    contenidoData.put("labels", contenido_fecha);
    contenidoData.put("datasets", Dataset);

    DataScale.put("A", DataA);

    data.put("data", contenidoData);

    data.put("type", "bar");
    dataOptions = new JSONObject();
    dataOptions.put("scales", DataScale);
    dataOptions.put("plugins", DataTitle);
    dataOptions.put("elements", DataPoint);

    data.put("options", dataOptions);

    dataArray.put(data);

    chartsdetfila.put("chartsdetfila", dataArray);

    out.print(chartsdetfila);
%>
