<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@page import="javax.servlet.ServletResponse"%>
<%@include  file="../../chequearsesion_reporte.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>

<%    try {
        if (sesion == true) {

            String clasificadora = (String) sesionOk.getAttribute("clasificadora");

            File reportfile = new File(application.getRealPath("registro_reproceso.jasper"));

            Map<String, Object> parameter = new HashMap<String, Object>();
            String calendario = request.getParameter("calendario_reporte_reproceso");
            String tipo_reproceso = request.getParameter("cbox_reproceso_pdf");
            String tipo_categoria = request.getParameter("cbox_categoria_reproceso_pdf");

            parameter.put("fecha", new String(calendario));
            parameter.put("clasificadora", new String(clasificadora));
            parameter.put("tipo_reproceso", new String(tipo_reproceso));
            parameter.put("categoria", new String(tipo_categoria));

            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);

            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);

            outputstream.flush();
            outputstream.close();
        }

    } catch (Exception e) {
        String efd = e.toString();
    } finally {
        connection.close();
    }
%>
