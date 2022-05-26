 
<%@page import="clases.controles"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion.jsp" %>
<%     
      String nro_transferencia = request.getParameter("nro_transferencia");
    
        clases.controles.connectarBD();  
        Connection cn = clases.controles.connect; 
        File reportfile = new File (application.getRealPath("reportes/ptc/transferencia.jasper"));
        
        Map<String,Object> parameter = new HashMap<String,Object>();
    
        parameter.put("nro_trans",new Integer(nro_transferencia));
        
        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, cn);
         
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        
        outputstream.flush();
        outputstream.close();
        cn.close();
        controles.DesconnectarBD();
        %>
 