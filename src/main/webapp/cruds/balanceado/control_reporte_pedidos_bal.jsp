<%@page import="java.sql.Connection"%>
<%@page import="java.net.URL"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include file="../../cruds/conexion.jsp" %>
<%
    try 
    {
        File reportfile = new File(application.getRealPath("reportes/balanceado/form_cambio_bal.jasper"));

        Map<String, Object> parameter = new HashMap<String, Object>();
        String id = request.getParameter("id");
        parameter.put("id", Integer.parseInt(id));
      
        byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes, 0, bytes.length);
        outputstream.flush();
        outputstream.close();

    } catch (Exception e) 
    {
        String efd=e.toString();
    } finally {
        connection.close();
    }
%>
