<%@page import="clases.controles"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@include  file="../../chequearsesion.jsp" %>
<%  String clasificadora = (String) sesionOk.getAttribute("clasificadora");
    String fecha_puesta = request.getParameter("calendario_reporte_carros");
    String estado = request.getParameter("cbox_estado");
    String fecha_clasificacion = request.getParameter("calendario_reporte_clasificacion");
    String hora_desde = request.getParameter("desde");
    String hora_hasta = request.getParameter("hasta");
    String tipo_huevo_form=null;
    String tipo_huevo = request.getParameter("tipo_huevo");
    String clasificacion="";
    
    clases.controles.connectarBD();  
    Connection con = clases.controles.connect;
    if(fecha_clasificacion.length()==0)
    {
        clasificacion="0";
    }
    else {
                  clasificacion=fecha_clasificacion;
     }
    if (tipo_huevo.equals("A")||tipo_huevo.equals("B")||tipo_huevo.equals("C")
        ||tipo_huevo.equals("D")||tipo_huevo.equals("J")||tipo_huevo.equals("S")||tipo_huevo.equals("G")){
    
        tipo_huevo_form= tipo_huevo;
    }
    else {
    tipo_huevo_form= "T";
        }
        File reportfile = new File (application.getRealPath("reportes/ptc/reporte_lotes_retenido.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
            parameter.put("fecha_puesta",new String(fecha_puesta));
            parameter.put("clasificadora",new String(clasificadora));
            parameter.put("status",new String(estado));
            parameter.put("tipo_huevo", tipo_huevo_form );
            parameter.put("fecha_clasificacion", clasificacion );
            parameter.put("hora_desde", hora_desde );
            parameter.put("hora_hasta", hora_hasta );
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