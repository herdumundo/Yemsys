<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include file="../../cruds/conexion.jsp" %>

<%     
    try {
            
    String fecha = request.getParameter("fecha");
    File reportfile = new File(application.getRealPath("reportes/webServiceReportes/resumen_desmontaje/resumen.jasper"));
    Map<String, Object> parameter = new HashMap<String, Object>();
    parameter.put("fecha", new String(fecha));
    byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
    response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream outputstream = response.getOutputStream();
    outputstream.write(bytes, 0, bytes.length);
    outputstream.flush();
    outputstream.close();
    

        } catch (Exception e) {
        out.print(e.toString());
        }
%>

