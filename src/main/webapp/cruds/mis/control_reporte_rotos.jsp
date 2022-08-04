<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion_reporte.jsp" %>
 <%@include file="../../cruds/conexion.jsp" %>

<%  
    try {  
    if (sesion == true) {

        
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    String calendario = request.getParameter("calendario_reporte_rotos");
    SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy");
    Date fecha_puestav1 = sdformat.parse(calendario);
    Date fechav2 = sdformat.parse("28/10/2021");

    if (fecha_puestav1.before(fechav2)) {
        File reportfile = new File(application.getRealPath("reportes/mis/REV01/reporte_rotos.jasper"));
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("fecha", new String(calendario));
        parameter.put("clasificadora", new String(clasificadora));
        byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes, 0, bytes.length);
        outputstream.flush();
        outputstream.close();
    } else {
        File reportfile = new File(application.getRealPath("reportes/mis/reporte_rotos.jasper"));
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("fecha", new String(calendario));
        parameter.put("clasificadora", new String(clasificadora));
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
    }
    finally{ 
         connection.close();
            }
%> 