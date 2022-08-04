<%@page import="java.sql.Connection"%>
<%@page import="java.net.URL"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<jsp:useBean id="conexion" class="clases.ConnectionSqlServer" scope="page" />
<%@include  file="../../chequearsesion_reporte.jsp" %>

<%
    if(sesion==true)
        {
    try 
    {
        clases.controles.connectarBD();
        Connection cn = clases.controles.connect;

        File reportfile = new File(application.getRealPath("reportes/log_pedidos/principal.jasper"));

        Map<String, Object> parameter = new HashMap<String, Object>();
        String id = request.getParameter("id_rep");
        String estado = request.getParameter("estado_rep");
        parameter.put("id", id);
        parameter.put("estado", estado);
        parameter.put("SUBREPORT_DIR", new String("C:\\Program Files\\Apache Software Foundation\\Tomcat 10.0\\webapps\\Yemsys\\reportes\\log_pedidos\\"));

        byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, cn);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes, 0, bytes.length);
        outputstream.flush();
        outputstream.close();

    } catch (Exception e) {

    } finally {
        clases.controles.DesconnectarBD();
    }
    
}
%>
