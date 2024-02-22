<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@page import="javax.servlet.ServletResponse"%>
<%@include file="../../cruds/conexion.jsp" %>
      <%
        String codigo= request.getParameter ("codigo");
        File reportfile = new File (application.getRealPath("reportes/webServiceReportes/transferencia_vimar.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        parameter.put("codigo",new Integer(Integer.parseInt(codigo)));
        parameter.put("SUBREPORT_DIR", "C:\\Program Files\\Apache Software Foundation\\Tomcat 10.1\\webapps\\Yemsys\\reportes\\WebServices_reportes\\");
        // D:\\Documentos\\NetBeansProjects\\Yemsys\\src\\main\\webapp\\reportes\\webServiceReportes
         byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close();
     %>
 