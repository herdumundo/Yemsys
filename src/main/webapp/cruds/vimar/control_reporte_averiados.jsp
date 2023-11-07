<%@page import="java.net.URL"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion_reporte.jsp" %>
<%@include  file="../../cruds/conexion.jsp" %> 
<%  
        try {
            
            File reportfile = new File(application.getRealPath("reportes/vimar/transferencia_vimar.jasper"));

            Map<String, Object> parameter = new HashMap<String, Object>();
            String codigoStr = request.getParameter("codigo"); // Obt�n el valor como String
            Integer codigo = Integer.parseInt(codigoStr); // Convierte a Integer
            parameter.put("codigo", codigo); // Luego, pasa el valor convertido como par�metro

          parameter.put("SUBREPORT_DIR", new String("C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\Yemsys\\reportes\\vimar\\"));
          //   parameter.put("SUBREPORT_DIR", new String("C:\\Users\\jbernal\\Documents\\NetBeansProjects\\Yemsys\\target\\Yemsys\\reportes\\vimar\\"));
            //C:\Users\jbernal\Documents\NetBeansProjects\Yemsys\target\Yemsys\reportes\vimar
            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, connection);
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();

        } catch (Exception e) {
            out.print(e.getMessage());

        } finally {
             connection.close();
        }

    
%>