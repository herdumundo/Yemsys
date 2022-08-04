 
<%@page import="clases.controles"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include file="../../cruds/conexion.jsp" %>
<%@include  file="../../chequearsesion_reporte.jsp" %>
<%    try {
        if (sesion == true) {
            String clasificadora = (String) sesionOk.getAttribute("clasificadora");
            String calendario = request.getParameter("calendario_reporte_carros_mixto");
            String estado = request.getParameter("cbox_estado");
            String carro = request.getParameter("numero");

            if (estado.equals("L")) {

                File reportfile = new File(application.getRealPath("reportes/ptc/reporte_lotes_mixtos_carro_carro_puesta.jasper"));

                Map<String, Object> parameter = new HashMap<String, Object>();

                parameter.put("fecha", new String(calendario));
                parameter.put("clasificadora", new String(clasificadora));
                parameter.put("status", new String(estado));
                parameter.put("codigo", new String(carro));
                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();

            } else {
                File reportfile = new File(application.getRealPath("reportes/ptc/reporte_lotes_mixtos_retenidos_puesta_codigo.jasper"));
                Map<String, Object> parameter = new HashMap<String, Object>();
                parameter.put("fecha", new String(calendario));
                parameter.put("clasificadora", new String(clasificadora));
                parameter.put("status", new String(estado));
                parameter.put("codigo", new String(carro));
                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();
            }

        }

    } catch (Exception e) {
        String efd = e.toString();
    } finally {
        connection.close();
    }
%>



