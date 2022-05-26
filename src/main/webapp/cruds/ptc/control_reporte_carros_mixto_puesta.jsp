 
<%@page import="clases.controles"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion.jsp" %>
<%     
        String clasificadora = (String) sesionOk.getAttribute("clasificadora");
        String calendario = request.getParameter("calendario_reporte_carros_mixto");
        String estado = request.getParameter("cbox_estado");
  
        clases.controles.connectarBD();  
        Connection con = clases.controles.connect;
          if(estado.equals("L")){
              
               File reportfile = new File (application.getRealPath("reportes/ptc/reporte_lotes_mixtos_puesta.jasper"));
        
        Map<String,Object> parameter = new HashMap<String,Object>();
    
            parameter.put("fecha",new String(calendario));
            parameter.put("clasificadora",new String(clasificadora));
            parameter.put("status",new String(estado));
 
                 
         byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close();
          }
          
          else {
              
               File reportfile = new File (application.getRealPath("reportes/ptc/reporte_lotes_mixtos_retenidos_puesta.jasper"));
        
        Map<String,Object> parameter = new HashMap<String,Object>();
    
            parameter.put("fecha",new String(calendario));
            parameter.put("clasificadora",new String(clasificadora));
            parameter.put("status",new String(estado));
 
                 
         byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close();
          }
          con.close();
          controles.DesconnectarBD();
        %>
  