<%@page import="clases.controles"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion.jsp" %>
<%      //String usuario       = (String) sesionOk.getAttribute("usuario");
        String clasificadora = (String) sesionOk.getAttribute("clasificadora");
        String calendario = request.getParameter("calendario_reporte_clasificados");
        clases.controles.connectarBD();  
        Connection con = clases.controles.connect; 
        File reportfile = new File (application.getRealPath("reportes/ptc/Reportes_CCH/HuevosClasificados.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        parameter.put("Fecha_Clasificacion",new String(calendario));
        parameter.put("Clasificadora",new String(clasificadora));
        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        
        outputstream.flush();
        outputstream.close();
        con.close();
        controles.DesconnectarBD();
        
    %>
         