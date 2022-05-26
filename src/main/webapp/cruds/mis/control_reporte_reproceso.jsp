<%@page import="clases.controles"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
 <%@include  file="../../chequearsesion.jsp" %>
 
<%   
    String calendario = request.getParameter("calendario_reporte_reproceso");
    String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    
    controles.VerificarConexion();
     
    SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy");
    Date fecha_puestav1 = sdformat.parse(calendario);
    Date fechav2 = sdformat.parse("30/10/2021");
  
    Date fechav2022 = sdformat.parse("23/01/2022");
    try {
          
 
    
    if (fecha_puestav1.before(fechav2)) 
    {
        File reportfile = new File (application.getRealPath("reportes/mis/REV01/registro_reproceso.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        String tipo_reproceso = request.getParameter("cbox_reproceso_pdf");
        String tipo_categoria = request.getParameter("cbox_categoria_reproceso_pdf");
        parameter.put("fecha",new String(calendario));
        parameter.put("clasificadora",new String(clasificadora));
        parameter.put("tipo_reproceso",new String(tipo_reproceso));
        parameter.put("categoria",new String(tipo_categoria));

        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, controles.connectSesion);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close();
    }
    else if (fecha_puestav1.after(fechav2) &&fecha_puestav1.before(fechav2022)) 
    {
        File reportfile = new File (application.getRealPath("reportes/mis/REV02/registro_reproceso_v2.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        String tipo_reproceso = request.getParameter("cbox_reproceso_pdf");
        String tipo_categoria = request.getParameter("cbox_categoria_reproceso_pdf");
        parameter.put("fecha",new String(calendario));
        parameter.put("clasificadora",new String(clasificadora));
        parameter.put("tipo_reproceso",new String(tipo_reproceso));
        parameter.put("categoria",new String(tipo_categoria));

        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, controles.connectSesion);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close(); 
    }

    else 
    {
        File reportfile = new File (application.getRealPath("reportes/mis/registro_reproceso_actual.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
        String tipo_reproceso = request.getParameter("cbox_reproceso_pdf");
        String tipo_categoria = request.getParameter("cbox_categoria_reproceso_pdf");
        parameter.put("fecha",new String(calendario));
        parameter.put("clasificadora",new String(clasificadora));
        parameter.put("tipo_reproceso",new String(tipo_reproceso));
        parameter.put("categoria",new String(tipo_categoria));

        byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, controles.connectSesion);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close(); 
    }
                 clases.controles.DesconnectarBDsession();

        } catch (Exception e) {
            String asdasd=e.getMessage();
        }
%>
   