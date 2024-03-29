<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion_reporte.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%    try {

        if (sesion == true) {
            String clasificadora = (String) sesionOk.getAttribute("clasificadora");
            String calendario = request.getParameter("calendario_reporte_reproceso");
            String tipo = request.getParameter("tipo");

            String ruta = "";

            if (tipo.equals("RP")) {
                ruta = "registro_reproceso_tradicional";
            } else {
                ruta = "registro_subproducto_tradicional";
            }

            File reportfile = new File(application.getRealPath("reportes/mis/" + ruta + ".jasper"));
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("fecha", new String(calendario));
            parameter.put("clasificadora", new String(clasificadora));
            parameter.put("tipo", new String(tipo));

            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();
        }

    } catch (Exception e) {
    } finally {
        connection.close();} 
%>
