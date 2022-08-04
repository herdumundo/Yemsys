<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion_reporte.jsp" %>
<%@include file="../../cruds/conexion.jsp" %>
<%   
    if(sesion==true){
        
        String nro_trans = request.getParameter("nro_transferencia");
        File reportfile = new File (application.getRealPath("reportes/mis/transferencia_reprocesos.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        parameter.put("nro_trans",new Integer(nro_trans)) ;
        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close(); 
        connection.close();
        
    }
%>
   