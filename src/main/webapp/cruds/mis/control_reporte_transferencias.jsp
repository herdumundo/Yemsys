<%@page import="clases.controles"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include file="../../contenedores/mis/contenedor_pdf_reproceso.jsp" %>
<%@include  file="../../chequearsesion.jsp" %>
 
<%   
        String nro_trans = request.getParameter("nro_transferencia");
        controles.VerificarConexion(); 
        Connection con = controles.connectSesion;
    
        File reportfile = new File (application.getRealPath("reportes/mis/transferencia_reprocesos.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        parameter.put("nro_trans",new Integer(nro_trans)) ;
  
        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close(); 
            clases.controles.DesconnectarBDsession();
  %>
   